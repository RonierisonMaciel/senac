-- Aula 1: Criação de Tabelas e Definição de Relacionamentos
CREATE DATABASE IF NOT EXISTS db_aula_1;
USE db_aula_1;

-- Criação da tabela departamentos
CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    bloco VARCHAR(100),
    data_criacao DATE
);

-- Criação da tabela empregados
CREATE TABLE empregados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    departamento_id INT,
    salario DECIMAL(10,2),
    data_admissao DATE,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

-- Aula 2: Operações Básicas com SQL
-- Inserindo dados
INSERT INTO departamentos (nome) VALUES
('Recursos Humanos'), ('Tecnologia da Informação'),
('Financeiro'), ('Marketing'), ('Vendas');

INSERT INTO empregados (nome, departamento_id, salario, data_admissao) VALUES
('Ana Ramalho', 1, 3500.00, '2022-01-15'), ('Bruno Cunha', 2, 4500.00, '2021-06-20'),
('Carla Oliveira', 3, 4000.00, '2020-03-10'), ('Daniel Ferraz', 4, 3800.00, '2019-11-25'),
('Eduardo Torres', 5, 3700.00, '2021-09-05'), ('Fernanda Maciel', 2, 4600.00, '2018-07-30'),
('Gustavo Varjão', 2, 4800.00, '2017-05-18'), ('Helena Santos', 1, 3600.00, '2022-02-10');

-- Consultando dados
SELECT * FROM empregados;
SELECT nome FROM empregados WHERE departamento_id = 2;
SELECT nome, departamento_id FROM empregados ORDER BY nome ASC;

-- Atualizando dados
UPDATE empregados SET nome = 'João da Silva' WHERE id = 1;

-- Excluindo dados
DELETE FROM empregados WHERE id = 2;

-- Aula 3: Transações
-- Exemplo de Transação
START TRANSACTION;

INSERT INTO empregados (nome, departamento_id) VALUES ('Ana Clara', 1);
UPDATE empregados SET departamento_id = 3 WHERE nome = 'Carlos Pereira';

-- Confirmando a transação
COMMIT;

-- Em caso de erro, poderíamos usar ROLLBACK para desfazer as mudanças
-- ROLLBACK;

-- Funções agregadoras MySQL

-- Usando COUNT(*) para contar o número de linhas
SELECT id_departamento, COUNT(*) AS pessoas_departamentos
FROM empregados
GROUP BY id_departamento;

-- Contar o total de empregados
SELECT COUNT(*) FROM empregados;

-- AVG retorna o valor médio dos salários por departamento
SELECT id_departamento, AVG(salario) AS salario_medio
FROM empregados
GROUP BY id_departamento;

-- Valor médio dos salários de todos os empregados
SELECT AVG(salario) FROM empregados;

-- Maior salário dos empregados por departamento
SELECT id_departamento, MAX(salario) AS maiores_salarios
FROM empregados
GROUP BY id_departamento;

-- Maior salário de todos os empregados
SELECT MAX(salario) FROM empregados;

-- Menor salário dos empregados por departamento
SELECT id_departamento, MIN(salario) AS menores_salarios
FROM empregados
GROUP BY id_departamento;

-- Menor Salário de todos os empregados
SELECT MIN(salario) FROM empregados;

-- Retorna a soma dos salários das linhas do sa
SELECT id_departamento, SUM(salario) AS soma_salarios
FROM empregados
GROUP BY id_departamento;

-- Soma de todos os salários dos empregados
SELECT SUM(salario) FROM empregados;
