#!/usr/bin/env bash

# Installe Chromium
apt-get update && apt-get install -y chromium

# Définit le chemin de Chrome pour Puppeteer
export PUPPETEER_EXECUTABLE_PATH=$(which chromium)

# Installe les dépendances
npm install
