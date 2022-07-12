const express = require("express");
const router = express.Router();

const project = require("./project-routes");

router.get("/", (req, res) => {
	res.json({ message: "API V1" });
});

for (const [route, path] of [
	[project, "/projects"],
]) {
	router.use(path, route);
}

module.exports = router;