-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 25/10/2024 às 02:46
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `tasks`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `relatorios`
--

CREATE TABLE `relatorios` (
  `id` int(11) NOT NULL,
  `finalidade` varchar(255) DEFAULT NULL,
  `data` datetime DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `componentes` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `relatorios`
--

INSERT INTO `relatorios` (`id`, `finalidade`, `data`, `descricao`, `componentes`, `createdAt`, `updatedAt`) VALUES
(1, 'Avaliação de Desempenho', '2024-10-30 00:00:00', 'Relatório de desempenho dos usuários em suas respectivas funções.', 'Análise de métricas, feedback dos supervisores', '2024-10-25 00:43:32', '2024-10-25 00:43:32'),
(2, 'Análise de Projetos', '2024-11-15 00:00:00', 'Relatório sobre o andamento dos projetos em andamento.', 'Dados dos projetos, cronograma', '2024-10-25 00:43:32', '2024-10-25 00:43:32');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tarefas`
--

CREATE TABLE `tarefas` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `data` datetime DEFAULT NULL,
  `responsaveis` varchar(255) DEFAULT NULL,
  `setor` varchar(255) DEFAULT NULL,
  `relatorioId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tarefas`
--

INSERT INTO `tarefas` (`id`, `nome`, `descricao`, `data`, `responsaveis`, `setor`, `relatorioId`, `createdAt`, `updatedAt`) VALUES
(1, 'Análise de Dados', 'Analisar os dados coletados do desempenho dos usuários.', '2024-11-01 00:00:00', 'Ana Souza, Maria Fernanda', 'TI', 1, '2024-10-25 00:43:33', '2024-10-25 00:43:33'),
(2, 'Preparar Apresentação', 'Criar apresentação sobre os resultados da análise.', '2024-11-05 00:00:00', 'Pedro Almeida', 'Administração', 1, '2024-10-25 00:43:33', '2024-10-25 00:43:33'),
(3, 'Revisão de Projetos', 'Revisar o andamento dos projetos em equipe.', '2024-11-10 00:00:00', 'Pedro Almeida, João Batista', 'Administração', 2, '2024-10-25 00:43:33', '2024-10-25 00:43:33'),
(4, 'Preparar Relatório Financeiro', 'Preparar relatório financeiro dos projetos.', '2024-11-20 00:00:00', 'João Batista', 'Financeiro', 2, '2024-10-25 00:43:33', '2024-10-25 00:43:33');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `setor` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `cpf`, `setor`, `email`, `senha`, `createdAt`, `updatedAt`) VALUES
(1, 'Ana Souza', '123.456.789-00', 'TI', 'ana.souza@example.com', 'senhaAna123', '2024-10-25 00:43:32', '2024-10-25 00:43:32'),
(2, 'Pedro Almeida', '987.654.321-00', 'Administração', 'pedro.almeida@example.com', 'senhaPedro456', '2024-10-25 00:43:32', '2024-10-25 00:43:32'),
(3, 'Maria Fernanda', '555.444.333-22', 'Recursos Humanos', 'maria.fernanda@example.com', 'senhaMaria789', '2024-10-25 00:43:32', '2024-10-25 00:43:32'),
(4, 'João Batista', '111.222.333-44', 'Financeiro', 'joao.batista@example.com', 'senhaJoao012', '2024-10-25 00:43:32', '2024-10-25 00:43:32');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `relatorios`
--
ALTER TABLE `relatorios`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tarefas`
--
ALTER TABLE `tarefas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `relatorioId` (`relatorioId`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `relatorios`
--
ALTER TABLE `relatorios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tarefas`
--
ALTER TABLE `tarefas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tarefas`
--
ALTER TABLE `tarefas`
  ADD CONSTRAINT `tarefas_ibfk_1` FOREIGN KEY (`relatorioId`) REFERENCES `relatorios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
