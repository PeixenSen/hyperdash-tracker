FROM node:18-slim

# Installer les dépendances pour Chromium
RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  fonts-liberation \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libgtk-3-0 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgbm1 \
  libnss3 \
  libxshmfence1 \
  libxss1 \
  libxtst6 \
  libu2f-udev \
  xdg-utils \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Installer Google Chrome stable
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb && \
    ln -s /usr/bin/google-chrome /usr/bin/chromium && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV NODE_ENV=production

CMD ["node", "index.js"]

