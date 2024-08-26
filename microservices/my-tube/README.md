# MyTube 
## Video streaming platform

### Project is still a work in progess
The complete tech stack will be the following:

### Tech Stack ###
- Nodejs
- MongoDB
- RabbitMQ

- Docker
- Kubernetes 
- Terraform (Azure)
- GitHub Actions

### Microservices ###
- Video streaming (with MongoDB)
- Video storage (Azure file storage)

MongoDB stores videos metadata, such as the video path. 
Video storage stores the actual videos files, and abstracts from the cloud provider.
Video streaming retrive and sends the video to the client's browser.  
