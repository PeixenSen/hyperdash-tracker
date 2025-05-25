FROM node:18-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Installer les dépendances système nécessaires à Chromium
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
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Crée le dossier de travail
WORKDIR /app

# Copie les fichiers nécessaires
COPY package*.json ./

# Empêche Puppeteer de télécharger Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=true

RUN npm install

COPY . .

# Utiliser le Chromium système
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

CMD ["node", "index.js"]

