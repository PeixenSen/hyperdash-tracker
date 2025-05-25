const puppeteer = require('puppeteer');
const axios = require('axios');
require('dotenv').config();

(async () => {
  const browser = await puppeteer.launch({
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  console.log('🟡 Opening test page...');
  const page = await browser.newPage();
  await page.goto('https://example.com');
  await page.screenshot({ path: 'example.png' });
  await browser.close();

  const browser2 = await puppeteer.launch({
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  console.log('🧭 Navigating to Hyperdash...');
  const page2 = await browser2.newPage();
  await page2.goto('https://hyperdash.info/trader/0x225864ad63ba66272cdbbae3e5467a2eba48c215', {
    waitUntil: 'networkidle2',
    timeout: 60000
  });

  console.log('🧠 Extracting HTML...');
  const html = await page2.content();

  const data = await page2.evaluate(() => {
    const actif = document.querySelector('.text-md.font-semibold.text-zinc-300')?.innerText || 'N/A';
    const direction = document.querySelector('.text-xs.font-medium.uppercase.text-green-500')?.innerText || 'N/A';
    const entree = document.querySelector('.text-xs.text-zinc-500')?.nextElementSibling?.innerText || 'N/A';
    const stopLoss = document.querySelectorAll('.text-xs.text-zinc-500')[1]?.nextElementSibling?.innerText || 'N/A';
    const takeProfit = document.querySelectorAll('.text-xs.text-zinc-500')[2]?.nextElementSibling?.innerText || 'N/A';
    const statut = document.querySelectorAll('.text-xs.text-zinc-500')[3]?.nextElementSibling?.innerText || 'N/A';

    return {
      actif,
      direction,
      entree,
      stopLoss,
      takeProfit,
      statut
    };
  });

  console.log('🚀 Sending data to Make...');
  await axios.post('https://hook.eu2.make.com/9hu3u9iddy3gpddnre86seuhnm496', data);

  console.log('📩 Sending data to Telegram...');
  const telegramMsg = `🟣 Nouvelle position détectée :\n\n` +
    `Actif: ${data.actif}\n` +
    `Direction: ${data.direction}\n` +
    `Entrée: ${data.entree}\n` +
    `StopLoss: ${data.stopLoss}\n` +
    `TakeProfit: ${data.takeProfit}\n` +
    `Statut: ${data.statut}`;

  await axios.post(`https://api.telegram.org/bot${process.env.BOT_TOKEN}/sendMessage`, {
    chat_id: process.env.CHAT_ID,
    text: telegramMsg
  });

  console.log('✅ Closing browser...');
  await browser2.close();
  console.log('✅ Done.');
})();
