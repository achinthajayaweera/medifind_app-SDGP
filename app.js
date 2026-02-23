const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Root route
app.get("/", (req, res) => {
  res.send("MediFind Backend is Running ✅");
});

// Connect all routes
app.use("/users", require("./routes/users"));
app.use("/doctors", require("./routes/doctors"));
app.use("/medicine", require("./routes/medicine"));
app.use("/pharmacies", require("./routes/pharmacies"));
app.use("/orders", require("./routes/orders"));
app.use("/orderMedicines", require("./routes/orderMedicines"));
app.use("/inventories", require("./routes/inventories"));
app.use("/prescriptions", require("./routes/prescriptions"));

// Start server
app.listen(5000, () => console.log("Server running on port 5000"));
