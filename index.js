const puppeteer = require('puppeteer');
const axios = require('axios');

(async () => {
  const browser = await puppeteer.launch({
  executablePath: process.env.PUPPETEER_EXECUTABLE_PATH,
  args: ['--no-sandbox', '--disable-setuid-sandbox'],
  });

  const page = await browser.newPage();

  console.log("🧭 Opening test page...");
  await page.goto('https://example.com');
  await page.screenshot({ path: 'example.png' });

  console.log("🧭 Navigating to Hyperdash...");
  await page.goto('https://hyperdash.info/trader/0x225864ad63ba66272cdbbae3e55476a2eba48c215', {
    waitUntil: 'networkidle2',
    timeout: 60000
  });

  console.log("🧠 Extracting HTML...");
  const html = await page.content();

  // 🔧 À adapter plus tard avec les bons sélecteurs (exemple fictif ci-dessous)
  const data = {
    actif: "XAU/USD",
    direction: "Long",
    entree: 2438.0,
    stopLoss: 2432.0,
    takeProfit: 2455.0,
    statut: "Ouvert"
  };

  console.log("🚀 Sending data to Make...");
  await axios.post('https://hook.eu2.make.com/mz74inl1cnt9gmuolneicbtlshhhr48b', data);

  console.log("❎ Closing browser...");
  await browser.close();

  console.log("✅ Done.");
})();
