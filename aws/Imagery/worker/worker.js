const AWS = require('aws-sdk');
const assert = require('assert-plus');
const Jimp = require('jimp');
const fs = require('fs/promises');

const db = new AWS.DynamoDB({});
const s3 = new AWS.S3({});
const sqs = new AWS.SQS({});

const states = {
  'processed': processed
};

// ----- UTILITY FUNCTIONS -----

// Get an optional attribute from an item
function getOptionalAttribute(item, attr, type) {
    return (item[attr] !== undefined) ? item[attr][type] : undefined;
  }

// Map DynamoDB item to image object
mapImage = function(item) {
    return {
      'id': item.id.S,
      'version': parseInt(item.version.N, 10),
      'state': item.state.S,
      'rawS3Key': getOptionalAttribute(item, 'rawS3Key', 'S'),
      'processedS3Key': getOptionalAttribute(item, 'processedS3Key', 'S'),
      'processedImage': (item.processedS3Key !== undefined) ? ('https://s3.amazonaws.com/' + process.env.ImageBucket + '/' + item.processedS3Key.S) : undefined
    };
  };

// Retrive image and convert into image object
async function getImage(id){
    const query = await db.getItem({
        'Key': { 'id': { 'S': id } },
        'TableName': 'imagery-images' }).promise();
    if(query.Item)
        return mapImage(query.Item);
    else
        throw new Error('image not found');
}

// ----- Worker Functions ----

// Apply image filter and upload to S3
async function processImage(image) {
    let processedS3Key = 'processed/' + image.id + '-' + Date.now() + '.png';
    let rawFile = './tmp_raw_' + image.id;
    let processedFile = './tmp_processed_' + image.id;

    let data = await s3.getObject({
      'Bucket': process.env.ImageBucket,
      'Key': image.rawS3Key
    }).promise();
    
    await fs.writeFile(rawFile, data.Body, {'encoding': null});
    let lenna = await Jimp.read(rawFile);
    await lenna.sepia().write(processedFile);
    await fs.unlink(rawFile);
    let buf = await fs.readFile(processedFile, {'encoding': null});
    
    await s3.putObject({
      'Bucket': process.env.ImageBucket,
      'Key': processedS3Key,
      'ACL': 'public-read',
      'Body': buf,
      'ContentType': 'image/png'
    }).promise();
    await fs.unlink(processedFile);
    return processedS3Key;
  }

  // update DynamoDB 
  async function processed(image) {
    let processedS3Key = await processImage(image);
    await db.updateItem({
      'Key': {'id': {'S': image.id}},
      'UpdateExpression': 'SET #s=:newState, version=:newVersion, processedS3Key=:processedS3Key',
      'ConditionExpression': 'attribute_exists(id) AND version=:oldVersion AND #s IN (:stateUploaded, :stateProcessed)',
      'ExpressionAttributeNames': {
        '#s': 'state'
      },
      'ExpressionAttributeValues': {
        ':newState': {
          'S': 'processed'
        },
        // concurrency requirement
        ':oldVersion': {
          'N': image.version.toString()
        },
        ':newVersion': {
          'N': (image.version + 1).toString()
        },
        ':processedS3Key': {
          'S': processedS3Key
        },
        ':stateUploaded': {
          'S': 'uploaded'
        },
        ':stateProcessed': {
          'S': 'processed'
        }
      },
      'ReturnValues': 'ALL_NEW',
      'TableName': 'imagery-image'
    }).promise();
  }

  // Poll SQS for messages and process them
  async function processMessage(){
    const message = await sqs.receiveMessage({
      'QueueUrl': process.env.QueueUrl,
      'MaxNumberOfMessages': 1,
      'WaitTimeSeconds': 20
    }).promise();

    if (message.Messages) {
      const receiptHandle = message.Messages[0].ReceiptHandle;
      const body = JSON.parse(message.Messages[0].Body);
      const image = await getImage(body.imageId);

      await states[body.desiredState](image); // calling processed function
      await sqs.deleteMessage({
        'QueueUrl': process.env.QueueUrl,
        'ReceiptHandle': receiptHandle
      }).promise();
    }
  }

// Server Loop 
async function run() {
    while (true) {
      try {
      await processMessage();
      await new Promise(resolve => setTimeout(resolve, 1000));
      } catch (e) {
        console.log('ERROR', e);
      }
    }
  }
  
  run();
  