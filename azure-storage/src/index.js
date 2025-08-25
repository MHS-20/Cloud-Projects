const express = require("express");
require("dotenv").config();

// Azure Blob Service
const {
  BlobServiceClient,
  StorageSharedKeyCredential,
} = require("@azure/storage-blob");


// Check Env Vars
if (!process.env.PORT) {
  throw new Error(
    "Please specify the port number for the HTTP server with the environment variable PORT."
  );
}

if (!process.env.STORAGE_ACCOUNT_NAME) {
  throw new Error(
    "Please specify the name of an Azure storage account in environment variable STORAGE_ACCOUNT_NAME."
  );
}

if (!process.env.STORAGE_ACCESS_KEY) {
  throw new Error(
    "Please specify the access key to an Azure storage account in environment variable STORAGE_ACCESS_KEY."
  );
}

// Extracts env vars
const PORT = process.env.PORT;
const STORAGE_ACCOUNT_NAME = process.env.STORAGE_ACCOUNT_NAME;
const STORAGE_ACCESS_KEY = process.env.STORAGE_ACCESS_KEY;

console.log(
  `Serving videos from Azure storage account ${STORAGE_ACCOUNT_NAME}.`
);


// Create the Blob service API
function createBlobService() {
  const sharedKeyCredential = new StorageSharedKeyCredential(
    STORAGE_ACCOUNT_NAME,
    STORAGE_ACCESS_KEY
  );

  const blobService = new BlobServiceClient(
    `https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net`,
    sharedKeyCredential
  );
  return blobService;
}

const app = express();

// HTTP GET route to retrieve videos from storage
app.get("/test", async (req, res) => {
  res.status(200).json({ message: "Request successful", data: "This is a test response" });
})

app.get("/storage", async (req, res) => {
  const videoPath = req.query.path;
  console.log(`Streaming video from path ${videoPath}.`);

  const blobService = createBlobService();
  const containerName = "videos";

  const containerClient = blobService.getContainerClient(containerName);
  const blobClient = containerClient.getBlobClient(videoPath);
  const properties = await blobClient.getProperties();

  // Writes HTTP headers to the response
  res.writeHead(200, {
    "Content-Length": properties.contentLength,
    "Content-Type": "video/mp4",
  });

  const response = await blobClient.download();
  response.readableStreamBody.pipe(res);
});

// Starts the HTTP server.
app.listen(PORT, () => {
  console.log(`Microservice online with port ${PORT}`);
});
