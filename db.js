require('dotenv').config(); // Ensure dotenv is loaded to read .env variables
const { Sequelize, DataTypes } = require("sequelize");
const bcrypt = require("bcrypt"); // Ensure bcrypt is properly required

const sequelize = new Sequelize("tasks", "root", "", {
    host: "localhost",
    dialect: "mysql",
});
 

// Define 'usuario' model
const Usuario = sequelize.define("usuario", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nome: { type: DataTypes.STRING },
    cpf: { type: DataTypes.STRING, unique: true },
    setor: { type: DataTypes.STRING },
    email: { type: DataTypes.STRING, unique: true, validate: { isEmail: true } },
    senha: { type: DataTypes.STRING },
}, {
    hooks: {
        beforeCreate: async (usuario) => {
            usuario.senha = await bcrypt.hash(usuario.senha, 10);
        }
    }
});

// Define 'relatorio' model
const Relatorio = sequelize.define("relatorio", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    finalidade: { type: DataTypes.STRING },
    data: { type: DataTypes.DATE },
    descricao: { type: DataTypes.TEXT },
    componentes: { type: DataTypes.TEXT },
});

// Define 'tarefa' model
const Tarefa = sequelize.define("tarefa", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nome: { type: DataTypes.STRING },
    descricao: { type: DataTypes.TEXT },
    data: { type: DataTypes.DATE },
    responsaveis: { type: DataTypes.STRING }, // Consider making this a foreign key reference to Usuario
    setor: { type: DataTypes.STRING },
    relatorioId: {
        type: DataTypes.INTEGER,
        references: { model: Relatorio, key: 'id' },
    },
});

// Set up relationships between models
Relatorio.hasMany(Tarefa, { foreignKey: 'relatorioId' });
Tarefa.belongsTo(Relatorio, { foreignKey: 'relatorioId' });

// Sync models with the database
const syncModels = async () => {
    try {
        await sequelize.authenticate(); // Authenticate DB connection
        await sequelize.sync({ force: false }); // Sync models (does not drop tables)
        console.log("Database synchronized successfully!");
    } catch (error) {
        console.error("Unable to connect to the database:", error);
    }
};

// Function to insert data into tables
const insert = async () => {
    try {
        // Ensure models are synced before inserting data
        await syncModels();

        // Insert users
        const usuarios = await Usuario.bulkCreate([
            { nome: "Ana Souza", cpf: "123.456.789-00", setor: "TI", email: "ana.souza@example.com", senha: "senhaAna123" },
            { nome: "Pedro Almeida", cpf: "987.654.321-00", setor: "Administração", email: "pedro.almeida@example.com", senha: "senhaPedro456" },
            { nome: "Maria Fernanda", cpf: "555.444.333-22", setor: "Recursos Humanos", email: "maria.fernanda@example.com", senha: "senhaMaria789" },
            { nome: "João Batista", cpf: "111.222.333-44", setor: "Financeiro", email: "joao.batista@example.com", senha: "senhaJoao012" }
        ]);

        // Insert reports
        const relatorios = await Relatorio.bulkCreate([
            { finalidade: "Avaliação de Desempenho", data: new Date("2024-10-30"), descricao: "Relatório de desempenho dos usuários em suas respectivas funções.", componentes: "Análise de métricas, feedback dos supervisores" },
            { finalidade: "Análise de Projetos", data: new Date("2024-11-15"), descricao: "Relatório sobre o andamento dos projetos em andamento.", componentes: "Dados dos projetos, cronograma" }
        ]);

        // Insert tasks
        const tarefas = await Tarefa.bulkCreate([
            { nome: "Análise de Dados", descricao: "Analisar os dados coletados do desempenho dos usuários.", data: new Date("2024-11-01"), responsaveis: `${usuarios[0].nome}, ${usuarios[2].nome}`, setor: usuarios[0].setor, relatorioId: relatorios[0].id },
            { nome: "Preparar Apresentação", descricao: "Criar apresentação sobre os resultados da análise.", data: new Date("2024-11-05"), responsaveis: usuarios[1].nome, setor: usuarios[1].setor, relatorioId: relatorios[0].id },
            { nome: "Revisão de Projetos", descricao: "Revisar o andamento dos projetos em equipe.", data: new Date("2024-11-10"), responsaveis: `${usuarios[1].nome}, ${usuarios[3].nome}`, setor: usuarios[1].setor, relatorioId: relatorios[1].id },
            { nome: "Preparar Relatório Financeiro", descricao: "Preparar relatório financeiro dos projetos.", data: new Date("2024-11-20"), responsaveis: usuarios[3].nome, setor: usuarios[3].setor, relatorioId: relatorios[1].id }
        ]);

        console.log("Todos os dados inseridos com sucesso!");
    } catch (err) {
        console.error("Erro ao inserir dados:", err);
    }
};

// Insert data into tables
insert();
