const puppeteer = require('puppeteer');
const axios = require('axios');

(async () => {
  const browser = await puppeteer.launch({
    executablePath: process.env.CHROMIUM_PATH || undefined,
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  const page = await browser.newPage();
  await page.goto('https://hyperdash.info/trader/0x225864ad63ba66272cd6be3e65476a2eba48c215', {
    waitUntil: 'networkidle2',
    timeout: 60000
  });

  const html = await page.content();

  // ⚠️ À adapter plus tard avec les bons sélecteurs
  const data = {
    actif: "XAU/USD",
    direction: "Long",
    entree: 2438.0,
    stopLoss: 2432.0,
    takeProfit: 2455.0,
    statut: "Ouvert"
  };

  await browser.close();

  await axios.post('https://hook.eu2.make.com/9hu3u9iddy3gpddnrge86seuhmnwv496', data);
})();
