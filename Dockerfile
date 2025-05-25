# Image Node de base
FROM node:18-slim

# Installer les dépendances nécessaires à Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libxshmfence1 \
    libxkbcommon0 \
    libxext6 \
    libxfixes3 \
    libxrender1 \
    libx11-6 \
    libx12 \
    libxss1 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Créer le dossier de l’app
WORKDIR /app

# Copier les fichiers package.json
COPY package*.json ./

# Ne pas télécharger Chromium via Puppeteer
ENV PUPPETEER_SKIP_DOWNLOAD=true
RUN npm install

# Copier le reste des fichiers
COPY . .

# Définir le chemin de Chromium installé dans l’image
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Lancer le script Node
CMD ["node", "index.js"]
