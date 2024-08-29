# MyTube - DevOps Project
## Video streaming platform

### Project is still a work in progess!
The complete tech stack will be the following:

The WebApp Involves: 
- NodeJS
- MongoDB
- RabbitMQ
- Docker

The Infrastructure relies on: 
- Kubernetes
- Terraform (AWS/Azure)
- GitHub Actions for CI/CD
- HashiCorp Vault
- ElK stack
- Prometheus + Grafana

### Microservices ###
- Video streaming (with MongoDB)
- Video storage (Azure file storage)

MongoDB stores videos metadata, such as the video path on azure storage.
Video storage stores the actual videos file, and abstracts from the cloud provider.
Video streaming retrive and sends the video to the client's browser.