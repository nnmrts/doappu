const express = require("express");

require("dotenv").config();

const apiRoutes = require("./routes/index");

const app = express();

app.use(express.json());

app.use((req, res, next) => {
	req.locals = {};
	next();
});

app.get("/", (req, res) => {
	res.json();
});

app.use("/api/v1", apiRoutes);

module.exports = app;