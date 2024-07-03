# alpine Linux as base image
FROM alpine:latest

# Install Python and pip
RUN apk add --no-cache python3 py3-pip py3-virtualenv

# Setup Python virtual environment
RUN python3 -m venv /app/venv

# Copy application code to the image
COPY app.py /app/app.py

# Activate virtual environment and install Flask and Requests
RUN . /app/venv/bin/activate && pip install flask requests

# Set the working directory
WORKDIR /app

# Set the environment variable to use the virtual environment
ENV VIRTUAL_ENV /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Define the command to run the application
CMD ["python3", "app.py"]