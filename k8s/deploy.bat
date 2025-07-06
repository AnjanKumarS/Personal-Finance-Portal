@echo off
echo 🚀 Deploying Personal Finance Portal to Kubernetes...

REM Check if kubectl is installed
kubectl version --client >nul 2>&1
if errorlevel 1 (
    echo ❌ kubectl is not installed. Please install kubectl first.
    pause
    exit /b 1
)

REM Check if Docker image exists
docker images | findstr "finance-portal" >nul 2>&1
if errorlevel 1 (
    echo 📦 Building Docker image...
    docker build -t finance-portal:latest ..
)

REM Create namespace and resources
echo 📋 Creating Kubernetes resources...

REM Apply all resources using kustomize
kubectl apply -k .

REM Wait for deployment to be ready
echo ⏳ Waiting for deployment to be ready...
kubectl wait --for=condition=available --timeout=300s deployment/finance-portal -n finance-portal

REM Get service information
echo 🌐 Getting service information...
kubectl get service finance-portal-service -n finance-portal

echo ✅ Deployment completed successfully!
echo.
echo 📊 To check the status:
echo    kubectl get pods -n finance-portal
echo    kubectl get services -n finance-portal
echo.
echo 🔍 To view logs:
echo    kubectl logs -f deployment/finance-portal -n finance-portal
echo.
echo 🌍 To access the application:
echo    kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal
echo    Then open http://localhost:3000 in your browser
echo.
echo    Alternative port (if 3000 is busy):
echo    kubectl port-forward service/finance-portal-service 3001:80 -n finance-portal
echo    Then open http://localhost:3001 in your browser
pause 