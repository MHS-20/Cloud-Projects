const express = require('express');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const { v4: uuidv4 } = require('uuid'); // create universally unique ids
const multiparty = require('multiparty'); // parse images

const db = new AWS.DynamoDB({});
const sqs = new AWS.SQS({});
const s3 = new AWS.S3({});

const app = express();
app.use(bodyParser.json());
app.use(express.static('public')); // for serving the HTML file

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

// Retrive and convert image
function getImage (id, callback) {
    db.getItem({
        'Key': { 'id': { 'S': id } },
        'TableName': 'imagery-images' },
    function(err, data) {
        if (err) {
            console.log(err, err.stack);
            callback(err);
        } else {
            if(data.Item)
                callback(null, mapImage(data.Item));
            else
                callback(new Error('image not found'));
        }
    })}; 

// Upload image to S3, update DynamoDB and send an SQS message
// receive image object from DynamoDB and the part object from the form
function uploadImage(image, part, response){ 
    const rawS3Key = 'upload/' + image.id + '-' + Date.now();
    s3.putObject({
        'Bucket': process.env.ImageBucket,
        'Key': rawS3Key,
        'Body': part,
        'ContentType': part.headers['content-type'],
        'ContentLength': part.byteCount},
    function(err, data) {
        if (err) {
            console.log(err, err.stack);
            response.status(500).send('Server Error: ' + err);
        } else {
            console.log("Uploaded image to S3, operation details: " + data);
            db.updateItem({
                'Key': {'id': {'S': image.id}},
                'UpdateExpression': 'SET #s=:newState, version=:newVersion, rawS3Key=:rawS3Key',
                'ConditionExpression': 'attribute_exists(id) AND version=:oldVersion AND #s IN (:stateCreated, :stateUploaded)',
                'ExpressionAttributeNames': {
                  '#s': 'state'
                },
                'ExpressionAttributeValues': {
                  ':newState': {
                    'S': 'uploaded'
                  },
                // concurrency requirement
                  ':oldVersion': {
                    'N': image.version.toString()
                  },
                  ':newVersion': {
                    'N': (image.version + 1).toString()
                  },
                  ':rawS3Key': {
                    'S': rawS3Key
                  },
                  ':stateCreated': {
                    'S': 'created'
                  },
                  ':stateUploaded': {
                    'S': 'uploaded'
                  }
                },
                'ReturnValues': 'ALL_NEW',
                'TableName': 'imagery-image'
            // putItem callback
              }, function(err, data) {
                if (err) {
                    console.log(err, err.stack);
                    response.status(500).send('Server Error: ' + err);
                } else {
                    console.log("Updated image, operation details: " + data);
                    // send SQS message
                    sqs.sendMessage({
                        'MessageBody': JSON.stringify({'imageId': image.id, 'desiredState': 'processed'}),
                        'QueueUrl': process.env.ImageQueueUrl},
                    function(err, data) {
                        if (err) {
                            console.log(err, err.stack);
                            response.status(500).send('Server Error: ' + err);
                        } else {
                            response.redirect('/#view=' + image.id);
                            response.end();
                        }
                    }); //SQS sendMessage
                }
            }); //DB updateItem
        }
    }) //S3 putObject
}

// ----- ROUTES -----
app.post('/image', function(request, response){
    const id = uuidv4();
    // query
    db.putItem({
        'Item': {
            'id': { 'S': id },
            'versioned': { 'N': '0' },
            'created': { 'N': Date.now().toString() },
            'state' : { 'S': 'created' }},
        'TableName': 'imagery-images', 
        'ConditionExpression': 'attribute_not_exists(id)'},
    //callback 
    function(err, data) {
            if (err) {
                console.log(err, err.stack);
                response.status(500).send('Server Error: ' + err);
            } else {
                console.log("Post image, operation details: " + data);
                response.json({'id': id, 'state': 'created'});
            }
        }); //putItem
}); // post image

// Look up image processing status
app.get('/image/:id', function(request, response){
    getImage(request.params.id, function(err, image) {
        if (err) {
            response.status(500).send('Server Error: ' + err);
        } else {
            response.json(image);
        }
    });
})

// Upload image to S3, update DynamoDB and send an SQS message
app.get('/image/:id/upload', function(request, response){
    getImage(request.params.id, function(err, image) {
        if (err) {
            response.status(500).send('Server Error: ' + err);
        } else {
        // parse request when form is submitted
            const form = new multiparty.Form();
        // listen on part event for image file
            form.on('part', function(part) {
                uploadImage(image, part, response);});
        // parse request (emit events)
            form.parse(request);        
        }
    });
})

app.listen(process.env.PORT || 8080, function() {
    console.log('Server started. Open http://localhost:' + (process.env.PORT || 8080) + ' with browser.');
  });