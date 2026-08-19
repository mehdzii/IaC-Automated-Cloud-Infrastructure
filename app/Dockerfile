FROM python:3.11-slim

WORKDIR /app

# Empêcher Python d'écrire des fichiers .pyc et forcer l'unbuffered I/O pour les logs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Installation des dépendances système de base
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Exposer le port HTTP 8000
EXPOSE 8000

# Endpoint de santé Docker native
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
