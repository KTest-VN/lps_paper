FROM python:3.11-slim

# System deps (for scipy, numpy, etc.)
RUN apt-get update && apt-get install -y \
    build-essential=12.12 \
    gfortran=4:14.2.0-1 \
    libopenblas-dev=0.3.29+ds-3 \
    liblapack-dev=3.12.1-6 \
    git=1:2.47.3-0+deb13u1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps
COPY .devcontainer/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Default command
ENTRYPOINT /bin/bash