"use strict";

const express = require("express");
const router = express.Router();

const projectController = require("../controllers/project-controller");

router.get("/:slug/pdf-export", projectController.pdfExport);

module.exports = router;
