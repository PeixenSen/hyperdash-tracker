# Image Node.js de base
FROM node:18-slim

# Installer les dépendances pour Puppeteer
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
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Créer le dossier de l'app
WORKDIR /app

# Copier les fichiers package
COPY package.json ./

# Installer les dépendances avec Puppeteer à jour
RUN npm install puppeteer@22.8.2 --save && npm install

# Copier le reste des fichiers
COPY . .

# Définir le chemin du Chromium installé par Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/app/node_modules/puppeteer/.local-chromium/linux-*/chrome-linux/chrome

# Lancer le script Node
CMD ["node", "index.js"]
