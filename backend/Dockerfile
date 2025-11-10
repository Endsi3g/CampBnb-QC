# Image de base Python
FROM python:3.11-slim

# Métadonnées de l'image (selon la documentation GitHub Packages)
# Note: Remplacez YOUR_USERNAME par votre nom d'utilisateur GitHub ou organisation
LABEL org.opencontainers.image.source=https://github.com/YOUR_USERNAME/campbnb
LABEL org.opencontainers.image.description="API Backend pour CampBnb - Application de réservation de camping au Québec"
LABEL org.opencontainers.image.licenses=PROPRIETARY

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances système si nécessaire
RUN apt-get update && apt-get install -y \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copier les fichiers de dépendances
COPY requirements.txt .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code de l'application
COPY api_server.py .

# Exposer le port de l'application
EXPOSE 5000

# Variables d'environnement par défaut
ENV PORT=5000
ENV DEBUG=False
ENV LOCALAI_URL=http://localhost:8080
ENV HANDY_API_URL=http://localhost:3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Commande pour démarrer l'application
CMD ["python", "api_server.py"]

