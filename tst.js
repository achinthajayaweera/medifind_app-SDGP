const { Sequelize } = require("sequelize");

const sequelize = new Sequelize("medifind_dev", "postgres", "sdgp1201", {
  host: "127.0.0.1",
  dialect: "postgres"
});

sequelize.authenticate()
  .then(() => console.log("PostgreSQL Connected ✅"))
  .catch(err => console.log("Connection Error ❌", err));
