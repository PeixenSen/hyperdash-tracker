# Base Node.js image
FROM node:18-slim

# Installer les dépendances système nécessaires pour Puppeteer + Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet
COPY package*.json ./

# Empêche Puppeteer de télécharger Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true
RUN npm install
COPY . .

# Définir la variable d’environnement attendue par Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Lancer le script
CMD ["node", "index.js"]
