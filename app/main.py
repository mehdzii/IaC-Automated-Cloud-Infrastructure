import os
import time
from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(
    title="IaC Demo API",
    description="API REST de démonstration pour le projet IaC (Terraform + Ansible + Docker + Monitoring)",
    version="1.0.0"
)

# Configuration de l'instrumentation Prometheus
instrumentator = Instrumentator(
    should_group_status_codes=False,
    should_ignore_untargeted_api=False,
    excluded_handlers=["/metrics"],
)
instrumentator.instrument(app).expose(app, endpoint="/metrics")

START_TIME = time.time()
ENVIRONMENT = os.getenv("APP_ENV", "development")


@app.get("/")
def read_root():
    return {
        "message": "Bienvenue sur l'API de démonstration IaC",
        "institution": "INPT - Institut National des Postes et Télécommunications",
        "filiere": "Systèmes Ubiquitaires et Distribués (Cloud & IoT)",
        "environment": ENVIRONMENT,
        "docs_url": "/docs"
    }


@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "timestamp": time.time(),
        "environment": ENVIRONMENT
    }


@app.get("/status")
def status_info():
    uptime_seconds = round(time.time() - START_TIME, 2)
    return {
        "status": "operational",
        "uptime_seconds": uptime_seconds,
        "environment": ENVIRONMENT,
        "version": "1.0.0"
    }
