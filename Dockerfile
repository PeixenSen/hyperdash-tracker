# Image Node officielle légère
FROM node:18-slim

# Empêche les invites interactives
ENV DEBIAN_FRONTEND=noninteractive

# Installation des dépendances nécessaires à Puppeteer
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
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Création du dossier app
WORKDIR /app

# Copie des fichiers de config
COPY package*.json ./

# Empêche Puppeteer de télécharger Chromium (on utilise celui du système)
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Installation des dépendances Node.js
RUN npm install

# Copie du reste de l'app
COPY . .

# Définit Chromium installé comme navigateur
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Commande à lancer
CMD ["node", "index.js"]

