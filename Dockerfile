# Image Node complète (évite les bugs de dépendances)
FROM node:18

# Installer les dépendances système nécessaires à Puppeteer
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libgbm1 \
    libglib2.0-0 \
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
    libx11-xcb1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Créer le dossier de travail
WORKDIR /app

# Copier les fichiers package.json
COPY package*.json ./

# Ne pas télécharger Chromium avec Puppeteer
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Installer les dépendances Node.js
RUN npm install

# Copier le reste des fichiers
COPY . .

# Définir le chemin du Chromium installé
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Lancer l'application
CMD ["node", "index.js"]

