@echo off
echo Building and running Personal Finance Portal with Docker...

REM Stop and remove existing containers
echo Stopping existing containers...
docker-compose down

REM Remove existing images to force rebuild
echo Removing existing images...
docker-compose down --rmi all

REM Build and start the application
echo Building and starting the application...
docker-compose up --build

echo Application should be running at http://localhost:5000
echo Admin credentials: admin@financeportal.com / admin123
pause 