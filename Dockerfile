# Use a slim Python image
FROM python:3.10-slim

# Set a working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Environment defaults (can be overridden)
ENV FLASK_ENV=production
ENV FLASK_APP=backend.app

# Expose port used by Gunicorn
EXPOSE 8000

# Run Gunicorn server
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "backend.app:app"]
