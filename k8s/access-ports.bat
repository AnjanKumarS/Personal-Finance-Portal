@echo off
echo 🌐 Personal Finance Portal - Access Options
echo ==========================================
echo.

REM Check if namespace exists
kubectl get namespace finance-portal >nul 2>&1
if errorlevel 1 (
    echo ❌ Namespace 'finance-portal' not found. Please deploy the application first.
    echo    Run: deploy.bat
    pause
    exit /b 1
)

REM Check if service exists
kubectl get service finance-portal-service -n finance-portal >nul 2>&1
if errorlevel 1 (
    echo ❌ Service 'finance-portal-service' not found. Please deploy the application first.
    echo    Run: deploy.bat
    pause
    exit /b 1
)

echo ✅ Application is deployed!
echo.

echo 🚀 Port Forwarding Options:
echo.

echo 1️⃣  Primary Port (3000):
echo    kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal
echo    URL: http://localhost:3000
echo.

echo 2️⃣  Alternative Port (3001):
echo    kubectl port-forward service/finance-portal-service 3001:80 -n finance-portal
echo    URL: http://localhost:3001
echo.

echo 3️⃣  Custom Port (choose any available port):
echo    kubectl port-forward service/finance-portal-service 4000:80 -n finance-portal
echo    URL: http://localhost:4000
echo.

echo 4️⃣  Direct Service Port (3000):
echo    kubectl port-forward service/finance-portal-service 3000:3000 -n finance-portal
echo    URL: http://localhost:3000
echo.

echo 📋 Quick Commands:
echo ==================
echo.

echo Start port forwarding on port 3000:
echo kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal
echo.

echo Check if port is available:
echo netstat -an | findstr :3000
echo.

echo Kill port forwarding:
echo taskkill /f /im kubectl.exe
echo.

echo 🔍 Troubleshooting:
echo ==================
echo.

echo If port 3000 is busy, try:
echo   - Port 3001: kubectl port-forward service/finance-portal-service 3001:80 -n finance-portal
echo   - Port 4000: kubectl port-forward service/finance-portal-service 4000:80 -n finance-portal
echo   - Port 5001: kubectl port-forward service/finance-portal-service 5001:80 -n finance-portal
echo.

echo Check what's using port 3000:
echo   netstat -ano | findstr :3000
echo.

echo Admin Credentials:
echo ==================
echo Email: admin@financeportal.com
echo Password: admin123
pause 