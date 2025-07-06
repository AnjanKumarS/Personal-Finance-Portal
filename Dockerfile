# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Make startup script executable
RUN chmod +x /app/start.sh

# Set environment variables
ENV FLASK_APP=run.py
ENV FLASK_ENV=production
ENV SECRET_KEY=your-secret-key
ENV DATABASE_URL=sqlite:///finance_portal.db

# Expose port
EXPOSE 5000

# Run the startup script
CMD ["/app/start.sh"]
