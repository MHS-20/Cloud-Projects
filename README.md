# MyTube
## Video streaming platform
Microservices-based video streaming WebApp, utilizing modern DevOps techniques to build a scalable and resilient IT infrastructure on the cloud.

### Architecture
The architecture comprises the backend only: 
```
Client → Streaming Service → Storage Service → Azure Blob Storage
            ↓                           ↓
        MongoDB                    Container "videos"
    (video's metadata)               (video files)
```

### CI/CD Pipeline
The CI/CD pipeline is as follows:
- Development: Push code to a specific directory (e.g., azure-storage/)
- Build: Automatically trigger Docker image build
- Infrastructure: Create/update clusters (if necessary)
- Secrets: Automatically configure Kubernetes secrets
- Deploy: Automatically deploy the application with Helm

### Tech Stack
The complete tech stack is the following:

The WebApp Involves: 
- NodeJS
- MongoDB
- Docker

The Infrastructure relies on: 
- Kubernetes
- Terraform (AWS/Azure)
- GitHub Actions for CI/CD
- Vault and Consul
- Prometheus and Grafana
- Docker Scout for container security scanning

Future Enhancements
- Elastic Stack
- Suricata and Wazuh