# My Application Deployment Guide

This guide provides an overview of the deployment process for "My Application" using Terraform for infrastructure management and Kubernetes for orchestration. The deployment utilizes an NGINX Ingress Controller to route traffic to the application within a Kubernetes cluster.

## Infrastructure Setup with Terraform

### Overview

We use Terraform to automate the provisioning of our cloud infrastructure on AWS. This includes setting up an Amazon EKS (Elastic Kubernetes Service) cluster, which serves as the runtime environment for our application.

### Components Provisioned

- **Amazon EKS Cluster**: The main Kubernetes cluster where our application pods run.
- **EKS Managed Node Groups**: EC2 instances that join the EKS cluster as worker nodes.
- **VPC, Subnets, and Related Networking Resources**: A dedicated VPC and subnets to ensure network isolation for our Kubernetes cluster.
- **IAM Roles and Policies**: Necessary IAM roles for EKS and worker nodes to operate within AWS securely.

### Assumptions

- **Usage and Size**: The initial deployment targets a moderate load, with autoscaling configured to accommodate peaks. We've chosen instance types and scaling parameters based on an expected average of X requests per minute, scaling up to handle 3X during peak times.
- **Region**: Deployments are focused on the `us-east-1` AWS region for proximity to our user base, minimizing latency.
- **Security**: We assume all traffic is internal or HTTPS, with IAM roles strictly granting the least privilege necessary for operation.

## Kubernetes Deployment with NGINX

### Overview

Our application is containerized, packaged into a Docker image, and deployed to the Kubernetes cluster provisioned by Terraform. We utilize an NGINX Ingress Controller to manage incoming traffic, route it to our application, and implement rate limiting for security and stability.

### Components

- **Deployment**: Manages the desired state of our application pods, ensuring they are updated and scaled as defined.
- **Service**: Defines internal networking within the cluster to route traffic to our application pods from the NGINX Ingress Controller.
- **Ingress**: Utilizes the NGINX Ingress Controller to manage external access to our application, providing URL routing and SSL termination.
- **Rate Limiting**: Configured at the Ingress level to prevent abuse and ensure the availability of our application under high load.

### Scaling

- **Horizontal AutoScaling**: A scaling policy based on cpu and memory usage is attached to the deployment so if thresholds are breached the application scales to a max of 10 replicas
- **CronJob Scaling**: Based on the given instructions the deployment will scale to 3 automatically on weekends and scale down before the new week

### Assumptions

- **Traffic Patterns**: Based on an analysis of expected usage, rate limits are initially set to X requests per second per IP, with adjustments planned based on observed traffic patterns.
- **Maintenance Windows**: Deployments are rolled out with minimal downtime, leveraging Kubernetes' rolling update features. Maintenance and updates are scheduled during off-peak hours to minimize impact.

## Getting Started

### Prerequisites

- AWS CLI, configured with appropriate access credentials.
- Terraform installed and configured for AWS.
- kubectl configured to interact with your Kubernetes cluster.
- Docker, for building and pushing the application image.

### Steps

1. **Infrastructure Provisioning**: Navigate to the Terraform directory and apply the configurations:

``` sh
cd terraform
terraform init
terraform apply

```

2. **Application Deployment**: Build your Docker image, push it to your registry, and deploy to Kubernetes:

``` sh
docker build -t myapp:latest .
docker push myapp:latest
kubectl apply -f kubernetes/
```

3. **Verify Deployment**: Ensure the application is running and accessible:

``` sh
kubectl get pods,svc,ingress -n privilee-app

```

use the endpoint value for svc to go to application, use curl or browser