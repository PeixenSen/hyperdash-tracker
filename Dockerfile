# ✅ Utilise une image Node plus complète (bullseye ≠ slim)
FROM node:18-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# ✅ Installe les dépendances Chromium
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
  apt-get clean && rm -rf /var/lib/apt/lists/*

# 📁 Dossier de travail
WORKDIR /app

# 🔧 Copie fichiers essentiels
COPY package*.json ./

# ⛔ Empêche Puppeteer de télécharger Chromium lui-même
ENV PUPPETEER_SKIP_DOWNLOAD=true

# 📦 Installe les dépendances
RUN npm install

# 📂 Copie le reste
COPY . .

# ✅ Spécifie le chemin vers Chromium installé
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 🚀 Démarre le script
CMD ["node", "index.js"]



