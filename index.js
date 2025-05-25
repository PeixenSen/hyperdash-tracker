const puppeteer = require('puppeteer');
const axios = require('axios');

(async () => {
  const browser = await puppeteer.launch({
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    headless: 'new', // conforme au warning Puppeteer
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  console.log("🆕 Opening new page...");
  const page = await browser.newPage();
  await page.goto('https://example.com');
  await page.screenshot({ path: 'example.png' });
  await browser.close();

  console.log("🌐 Navigating to Hyperdash...");
  await page.goto('https://hyperdash.info/trader/0x225864ad63ba66272cd6bae3e65476a2eba48c215', {
    waitUntil: 'networkidle2',
    timeout: 60000
  });

  console.log("📄 Extracting HTML...");
  const html = await page.content();

  // ⚠️ À adapter plus tard avec les bons sélecteurs (actuellement fictif)
  const data = {
    actif: "XAU/USD",
    direction: "Long",
    entree: 2438.0,
    stopLoss: 2432.0,
    takeProfit: 2455.0,
    statut: "Ouvert"
  };

  console.log("📤 Sending data to Make...");
  await axios.post('https://hook.eu2.make.com/9hu3u9iddy3gpddnre86seuhnmw496', data);

  console.log("🧹 Closing browser...");
  await browser.close();

  console.log("✅ Done.");
})();
