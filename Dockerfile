# Production Deployment Configuration for AWS High-Frequency Trading Instance
# Optimized for Debian Slim to minimize Docker overhead

FROM python:3.11-slim-bullseye

# System dependencies for high-performance Python extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory for the firm ops
WORKDIR /opt/castle-trade/whale-rider

# Install institutional-grade Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy institutional infrastructure components
COPY src/ ./src/
COPY docs/ ./docs/
COPY scripts/ ./scripts/
COPY tests/ ./tests/

# Create logs directory for SRE observability
RUN mkdir -p logs && touch logs/orchestrator.log

# Security: Run as non-privileged service account
RUN useradd -m tradersvc
USER tradersvc

# Runtime Configuration: Enable UVLOOP for high-performance event loop
ENV PYTHONASYNCIODEBUG=0
ENV PYTHONOPTIMIZE=1

# Execution entry point
CMD ["python", "src/core/orchestrator.py"]
