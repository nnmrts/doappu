const puppeteer = require("puppeteer");
const report = require("puppeteer-report");

exports.pdfExport = async (req, res) => {
	const { slug } = req.params;

	const browser = await puppeteer.launch({
		args: ["--no-sandbox", "--headless", "--disable-dev-shm-usage"]
	});
	const page = await browser.newPage();

	await page.goto(`https://books.toscrape.com/catalogue/${slug}`, { waitUntil: "networkidle0" });

	const pdf = Buffer.from(await report.pdfPage(
		page,
		{
			format: "A4",
			margin: {
				top: "1cm",
				right: "1cm",
				bottom: "1cm",
				left: "1cm",
			},
			timeout: 2 * 60 * 1000,
		}));

	await browser.close();

	res.setHeader("Content-Type", "application/pdf");
	res.send(pdf);
};