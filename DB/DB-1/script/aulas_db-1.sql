-- Aula 1: Criação de Tabelas e Definição de Relacionamentos
CREATE DATABASE IF NOT EXISTS db_aula_1;
USE db_aula_1;

CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

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
