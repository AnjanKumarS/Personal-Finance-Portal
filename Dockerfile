# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Normalize line endings and ensure script is executable
RUN apt-get update && apt-get install -y dos2unix && \
    dos2unix /app/start.sh && \
    chmod +x /app/start.sh && \
    apt-get remove -y dos2unix && apt-get autoremove -y

# Set environment variables
ENV FLASK_APP=run.py
ENV FLASK_ENV=production
ENV SECRET_KEY=your-secret-key
ENV DATABASE_URL=sqlite:///finance_portal.db

# Expose port
EXPOSE 5000

# Start the application
CMD ["/app/start.sh"]
