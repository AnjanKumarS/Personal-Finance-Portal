# 🚀 Kubernetes Deployment for Personal Finance Portal

This directory contains all the Kubernetes manifests and deployment scripts for running the Personal Finance Portal in a Kubernetes cluster.

## 📁 File Structure

```
k8s/
├── namespace.yaml              # Kubernetes namespace
├── configmap.yaml              # Application configuration
├── secret.yaml                 # Sensitive configuration data
├── persistent-volume.yaml      # Storage volume definition
├── persistent-volume-claim.yaml # Storage volume request
├── deployment.yaml             # Application deployment
├── service.yaml                # Service exposure
├── ingress.yaml                # External access configuration
├── hpa.yaml                    # Horizontal Pod Autoscaler
├── kustomization.yaml          # Kustomize configuration
├── deploy.sh                   # Linux/macOS deployment script
├── deploy.bat                  # Windows deployment script
├── cleanup.sh                  # Cleanup script
└── README.md                   # This file
```

## 🛠️ Prerequisites

### Required Tools
- **kubectl** - Kubernetes command-line tool
- **Docker** - Container runtime
- **Kubernetes Cluster** - Local (Minikube/Docker Desktop) or cloud cluster

### Optional Tools
- **kustomize** - For managing Kubernetes resources
- **helm** - For advanced deployments

## 🚀 Quick Start

### 1. Build Docker Image
```bash
# From the project root directory
docker build -t finance-portal:latest .
```

### 2. Deploy to Kubernetes

#### Option A: Using Deployment Scripts
```bash
# Linux/macOS
chmod +x k8s/deploy.sh
./k8s/deploy.sh

# Windows
k8s\deploy.bat
```

#### Option B: Manual Deployment
```bash
# Navigate to k8s directory
cd k8s

# Apply all resources
kubectl apply -k .

# Check deployment status
kubectl get pods -n finance-portal
kubectl get services -n finance-portal
```

### 3. Access the Application

#### Option A: Port Forwarding
```bash
# Primary port (recommended)
kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal

# Alternative port (if 3000 is busy)
kubectl port-forward service/finance-portal-service 3001:80 -n finance-portal
```
Then open http://localhost:3000 or http://localhost:3001 in your browser.

#### Option B: LoadBalancer (Cloud)
```bash
kubectl get service finance-portal-service -n finance-portal
```
Use the external IP provided by your cloud provider.

#### Option C: Ingress (if configured)
Add `finance-portal.local` to your hosts file and access via the configured domain.

## 📊 Monitoring and Management

### Check Application Status
```bash
# View all resources in the namespace
kubectl get all -n finance-portal

# Check pod status
kubectl get pods -n finance-portal

# View service details
kubectl get services -n finance-portal

# Check persistent volumes
kubectl get pv,pvc -n finance-portal
```

### View Logs
```bash
# View application logs
kubectl logs -f deployment/finance-portal -n finance-portal

# View logs from specific pod
kubectl logs -f <pod-name> -n finance-portal
```

### Scale Application
```bash
# Scale deployment
kubectl scale deployment finance-portal --replicas=3 -n finance-portal

# Check HPA status
kubectl get hpa -n finance-portal
```

### Update Application
```bash
# Update image
kubectl set image deployment/finance-portal finance-portal=finance-portal:new-version -n finance-portal

# Or restart deployment
kubectl rollout restart deployment/finance-portal -n finance-portal
```

## 🔧 Configuration

### Environment Variables
The application configuration is managed through ConfigMaps and Secrets:

- **ConfigMap**: `finance-portal-config` - Non-sensitive configuration
- **Secret**: `finance-portal-secret` - Sensitive data (passwords, keys)

### Storage
- **PersistentVolume**: 1GB local storage for database persistence
- **StorageClass**: `manual` - Uses hostPath for local development

### Resources
- **CPU**: 250m request, 500m limit
- **Memory**: 256Mi request, 512Mi limit

### Scaling
- **HPA**: Automatically scales based on CPU (70%) and Memory (80%) usage
- **Replicas**: 2 minimum, 10 maximum

## 🧹 Cleanup

### Remove All Resources
```bash
# Using cleanup script
chmod +x k8s/cleanup.sh
./k8s/cleanup.sh

# Or manually
kubectl delete namespace finance-portal
kubectl delete pv finance-portal-pv --ignore-not-found=true
```

## 🔒 Security Considerations

### Production Deployment
For production environments, consider:

1. **Secrets Management**: Use external secret management (HashiCorp Vault, AWS Secrets Manager)
2. **Network Policies**: Implement network policies for pod-to-pod communication
3. **RBAC**: Configure proper role-based access control
4. **TLS**: Enable HTTPS with proper certificates
5. **Resource Limits**: Adjust resource requests/limits based on actual usage
6. **Database**: Use external database service instead of SQLite

### Security Best Practices
```bash
# Create namespace with security context
kubectl create namespace finance-portal --dry-run=client -o yaml | \
  kubectl apply -f -

# Apply security policies
kubectl apply -f security-policies.yaml
```

## 🐛 Troubleshooting

### Common Issues

#### Pod Not Starting
```bash
# Check pod events
kubectl describe pod <pod-name> -n finance-portal

# Check pod logs
kubectl logs <pod-name> -n finance-portal
```

#### Database Issues
```bash
# Check persistent volume
kubectl get pv,pvc -n finance-portal

# Check storage mount
kubectl exec -it <pod-name> -n finance-portal -- ls -la /app/instance
```

#### Service Not Accessible
```bash
# Check service endpoints
kubectl get endpoints finance-portal-service -n finance-portal

# Test service connectivity
kubectl run test-pod --image=busybox --rm -it --restart=Never -- \
  wget -O- http://finance-portal-service:80
```

### Debug Commands
```bash
# Get detailed resource information
kubectl describe deployment finance-portal -n finance-portal
kubectl describe service finance-portal-service -n finance-portal

# Check resource usage
kubectl top pods -n finance-portal
kubectl top nodes

# View events
kubectl get events -n finance-portal --sort-by='.lastTimestamp'
```

## 📈 Performance Optimization

### Resource Optimization
- Monitor actual resource usage with `kubectl top`
- Adjust resource requests/limits based on metrics
- Use resource quotas for namespace limits

### Scaling Optimization
- Configure HPA based on application-specific metrics
- Use custom metrics for better scaling decisions
- Implement pod disruption budgets for high availability

### Storage Optimization
- Use appropriate storage class for your environment
- Consider using StatefulSets for stateful applications
- Implement backup strategies for persistent data

## 🔄 CI/CD Integration

### GitHub Actions Example
```yaml
name: Deploy to Kubernetes
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build Docker image
      run: docker build -t finance-portal:${{ github.sha }} .
    - name: Deploy to Kubernetes
      run: |
        kubectl set image deployment/finance-portal \
          finance-portal=finance-portal:${{ github.sha }} \
          -n finance-portal
```

## 📚 Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Kustomize Documentation](https://kustomize.io/)
- [Flask Deployment Guide](https://flask.palletsprojects.com/en/2.0.x/deploying/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/) 