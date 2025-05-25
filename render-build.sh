#!/usr/bin/env bash

export PUPPETEER_SKIP_DOWNLOAD=true
export CHROMIUM_PATH=$(which chromium || which chromium-browser)

npm install
