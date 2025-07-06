#!/bin/bash

# Wait for database to be ready (if using external database)
echo "Starting Personal Finance Portal..."

# Initialize database if it doesn't exist
echo "Initializing database..."
if ! flask db upgrade; then
    echo "Migration failed, trying direct database initialization..."
    python init_db.py
fi

# Start the application
echo "Starting Flask application..."
flask run --host=0.0.0.0 --port=5000 