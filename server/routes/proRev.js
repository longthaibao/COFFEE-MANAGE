const express = require("express");
const router = express.Router();

const { ProductRev, totalRevenue, totalProduct, bestSeller} = require("../BusinessLayer/Store/ProductRev");

router.post("/", ProductRev); 
router.post("/totalrevenue", totalRevenue );
router.post("/totalproduct", totalProduct);
router.post("/bestseller", bestSeller);

module.exports = router;