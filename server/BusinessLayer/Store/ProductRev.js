const {productRev, totalPro, totalRev, bestSel} = require("../../PersistenceLayer/ProductRevDAO");


const ProductRev = async (req, res) => {
    let store = req.body.store;
    let start = req.body.start;
    let end = req.body.end;

    try {
      let data = await productRev(store, start, end);
      return res.status(200).json({"data": data});
    }
    catch (e) {
      console.log(e)
      return res.sendStatus(503)
    }
    
  };

const totalRevenue = async (req, res) => {
    let store = req.body.store;
    let start = req.body.start;
    let end = req.body.end;

    try {
      let data = await totalRev(store, start, end);
      return res.status(200).json({"data": data[0].totalrev});
    }
    catch (e) {
      console.log(e)
      return res.sendStatus(503)
    }
}
  
const totalProduct = async (req, res) => {
  let store = req.body.store;
    let start = req.body.start;
    let end = req.body.end;

    try {
      let data = await totalPro(store, start, end);
      return res.status(200).json({"data": data[0].totalpro});
    }
    catch (e) {
      console.log(e)
      return res.sendStatus(503)
    }
}

const bestSeller = async (req, res) => {
  let store = req.body.store;
    let start = req.body.start;
    let end = req.body.end;

    try {
      let data = await bestSel(store, start, end);
      return res.status(200).json({"data": data[0].bestselID});
    }
    catch (e) {
      console.log(e)
      return res.sendStatus(503)
    }
}

module.exports = { ProductRev, totalRevenue, totalProduct, bestSeller};