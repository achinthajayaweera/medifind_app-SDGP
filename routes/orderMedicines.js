const express = require("express");
const router = express.Router();
const { OrderMedicine } = require("../models"); // Make sure your model is named exactly 'OrderMedicine'

// GET all order_medicines
router.get("/", async (req, res) => {
  try {
    const items = await OrderMedicine.findAll();
    res.json(items);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Something went wrong" });
  }
});

// GET one by ID
router.get("/:id", async (req, res) => {
  try {
    const item = await OrderMedicine.findByPk(req.params.id);
    if (!item) return res.status(404).json({ error: "Item not found" });
    res.json(item);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Something went wrong" });
  }
});

// CREATE new item
router.post("/", async (req, res) => {
  try {
    const newItem = await OrderMedicine.create(req.body);
    res.status(201).json(newItem);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Something went wrong" });
  }
});

// UPDATE item by ID
router.put("/:id", async (req, res) => {
  try {
    const item = await OrderMedicine.findByPk(req.params.id);
    if (!item) return res.status(404).json({ error: "Item not found" });
    await item.update(req.body);
    res.json(item);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Something went wrong" });
  }
});

// DELETE item by ID
router.delete("/:id", async (req, res) => {
  try {
    const item = await OrderMedicine.findByPk(req.params.id);
    if (!item) return res.status(404).json({ error: "Item not found" });
    await item.destroy();
    res.json({ message: "Item deleted" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Something went wrong" });
  }
});

module.exports = router;
