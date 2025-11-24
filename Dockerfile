# ---- Base Python Image ----
FROM python:3.12-slim

# Prevent Python from buffering outputs
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install MLflow + dependencies
RUN pip install --no-cache-dir mlflow[extras] psycopg2-binary boto3

# Create MLflow working directory
RUN mkdir -p /mlflow/artifacts
WORKDIR /mlflow

# Expose MLflow port
EXPOSE 5000

# MLflow Command
CMD ["mlflow", "server", \
     "--host", "0.0.0.0", \
     "--port", "5000", \
     "--backend-store-uri", "sqlite:///mlflow.db", \
     "--default-artifact-root", "/mlflow/artifacts"]
