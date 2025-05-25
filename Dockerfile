# Base image Node.js avec Debian slim
FROM node:20-slim

# Empêche Puppeteer de télécharger Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Dépendances requises par Chromium
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ajoute le chemin vers Chromium installé par Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium"

# Crée le dossier de l'application
WORKDIR /app

# Copie les fichiers
COPY package*.json ./
RUN npm install
COPY . .

# Démarre l'application
CMD ["node", "index.js"]
