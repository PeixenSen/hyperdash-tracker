# Étape 1 : Image Node de base allégée
FROM node:18-slim

# Installer les dépendances nécessaires pour Puppeteer/Chromium
RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libgbm1 \
  libglib2.0-0 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  libxshmfence1 \
  libxext6 \
  libxfixes3 \
  libxrender1 \
  libx11-6 \
  libx12 \
  chromium \
  --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers nécessaires
COPY package*.json ./

# Installer les dépendances Node
RUN npm install

# Copier tout le reste du projet
COPY . .

# Définir le chemin de Chromium pour Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Lancer le script index.js par défaut
CMD ["node", "index.js"]
