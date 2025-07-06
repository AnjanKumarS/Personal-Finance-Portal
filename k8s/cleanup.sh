#!/bin/bash

# Kubernetes Cleanup Script for Personal Finance Portal

echo "🧹 Cleaning up Personal Finance Portal from Kubernetes..."

# Delete all resources in the namespace
kubectl delete namespace finance-portal

# Delete persistent volume (if not automatically deleted)
kubectl delete pv finance-portal-pv --ignore-not-found=true

echo "✅ Cleanup completed successfully!" 