FROM node:18-slim

# Installer Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Répertoire de travail
WORKDIR /app

# Copier les dépendances
COPY package*.json ./

# Ne pas télécharger Chromium via Puppeteer
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Installer les modules npm
RUN npm install

# Copier le reste du projet
COPY . .

# Définir le chemin du binaire Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Lancer le script Node
CMD ["node", "index.js"]


