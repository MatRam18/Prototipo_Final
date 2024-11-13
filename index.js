const express = require("express");
const server = express();
const { create } = require("express-handlebars");
const Sequelize = require("sequelize");

const conexaoComBanco = new Sequelize("events", "root", "", {
    host: "localhost",
    dialect: "mysql",
});

server.get("/Usuario/:nome/:cpf/:setor/:email/:senha", function (req, res) {
    res.send(req.params);
});

server.get("/Tarefa/:nome/:desc/:data/:responsaveis/:setor", function (req, res) {
    res.send(req.params);
});

server.get("/relatorio/:finalidade/:data/:desc/:componentes", function (req, res) {
    res.send(req.params);
});


server.get("/cad", function (req, res) {
    res.render("form");
});


const abs = create({ defaultLayout: "main" });
server.engine("handlebars", abs.engine);
server.set("view engine", "handlebars");


server.listen(3030, () => {
    console.log("Servidor on");
});
