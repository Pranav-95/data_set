const express = require("express");
const path = require("path");
const fs = require("fs");
require("dotenv").config();
const app = express();

app.use(express.static(path.join(__dirname, "public")));
app.set("view engine", "ejs");

// Route to get ABI and contract address
app.get("/contract-info", (req, res) => {
  const contractPath = path.join(
    __dirname,
    "build",
    "contracts",
    "Charity.json"
  );
  fs.readFile(contractPath, "utf8", (err, data) => {
    if (err) {
      return res.status(500).send("Error reading contract data");
    }
    const contractData = JSON.parse(data);
    const abi = contractData.abi;
    const address = contractData.networks["5777"].address; // Ganache default network id (5777)
    res.json({ abi, address });
  });
});

app.get("/", (req, res) => {
  res.render("index");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
