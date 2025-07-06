#!/bin/bash

# Access Ports Script for Personal Finance Portal
# This script shows different ways to access the application

echo "🌐 Personal Finance Portal - Access Options"
echo "=========================================="
echo ""

# Check if namespace exists
if ! kubectl get namespace finance-portal &> /dev/null; then
    echo "❌ Namespace 'finance-portal' not found. Please deploy the application first."
    echo "   Run: ./deploy.sh"
    exit 1
fi

# Check if service exists
if ! kubectl get service finance-portal-service -n finance-portal &> /dev/null; then
    echo "❌ Service 'finance-portal-service' not found. Please deploy the application first."
    echo "   Run: ./deploy.sh"
    exit 1
fi

echo "✅ Application is deployed!"
echo ""

echo "🚀 Port Forwarding Options:"
echo ""

echo "1️⃣  Primary Port (3000):"
echo "   kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal"
echo "   URL: http://localhost:3000"
echo ""

echo "2️⃣  Alternative Port (3001):"
echo "   kubectl port-forward service/finance-portal-service 3001:80 -n finance-portal"
echo "   URL: http://localhost:3001"
echo ""

echo "3️⃣  Custom Port (choose any available port):"
echo "   kubectl port-forward service/finance-portal-service 4000:80 -n finance-portal"
echo "   URL: http://localhost:4000"
echo ""

echo "4️⃣  Direct Service Port (3000):"
echo "   kubectl port-forward service/finance-portal-service 3000:3000 -n finance-portal"
echo "   URL: http://localhost:3000"
echo ""

echo "📋 Quick Commands:"
echo "=================="
echo ""

echo "Start port forwarding on port 3000:"
echo "kubectl port-forward service/finance-portal-service 3000:80 -n finance-portal &"
echo ""

echo "Check if port is available:"
echo "netstat -an | grep :3000"
echo ""

echo "Kill port forwarding:"
echo "pkill -f 'kubectl port-forward'"
echo ""

echo "🔍 Troubleshooting:"
echo "=================="
echo ""

echo "If port 3000 is busy, try:"
echo "  - Port 3001: kubectl port-forward service/finance-portal-service 3001:80 -n finance-portal"
echo "  - Port 4000: kubectl port-forward service/finance-portal-service 4000:80 -n finance-portal"
echo "  - Port 5001: kubectl port-forward service/finance-portal-service 5001:80 -n finance-portal"
echo ""

echo "Check what's using port 3000:"
echo "  - Windows: netstat -ano | findstr :3000"
echo "  - Linux/macOS: lsof -i :3000"
echo ""

echo "Admin Credentials:"
echo "=================="
echo "Email: admin@financeportal.com"
echo "Password: admin123" 