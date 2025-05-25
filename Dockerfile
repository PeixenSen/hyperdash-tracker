# Étape 1 : image de base légère avec Node.js
FROM node:18-slim

# Étape 2 : installation de Chromium + dépendances nécessaires à Puppeteer
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    wget \
    ca-certificates \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Étape 3 : définition du dossier de travail
WORKDIR /app

# Étape 4 : copie des fichiers package.json et installation des dépendances
COPY package*.json ./
RUN npm install

# Étape 5 : copie du reste du code
COPY . .

# Étape 6 : variable d’environnement pour Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Étape 7 : démarrage du script principal
CMD ["node", "index.js"]
