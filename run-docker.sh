#!/bin/bash

echo "Building and running Personal Finance Portal with Docker..."

# Stop and remove existing containers
echo "Stopping existing containers..."
docker-compose down

# Remove existing images to force rebuild
echo "Removing existing images..."
docker-compose down --rmi all

# Build and start the application
echo "Building and starting the application..."
docker-compose up --build

echo "Application should be running at http://localhost:5000"
echo "Admin credentials: admin@financeportal.com / admin123" 