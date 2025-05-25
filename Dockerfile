# Base Node.js image
FROM node:18-slim

# Installer les dépendances pour Puppeteer + Chromium
RUN apt-get update && apt-get install -y \
  wget \
  gnupg \
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
  libu2f-udev \
  libvulkan1 \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Installer Chromium
RUN apt-get update && apt-get install -y chromium && \
  ln -s /usr/bin/chromium /usr/bin/google-chrome && \
  rm -rf /var/lib/apt/lists/*

# Créer le dossier de l'app
WORKDIR /app

# Copier les fichiers
COPY package*.json ./
RUN npm install
COPY . .

# Définir la variable d’environnement utilisée par Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Lancer l’app
CMD ["node", "index.js"]
