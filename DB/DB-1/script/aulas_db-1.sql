-- Aula 1: Criação de Tabelas e Definição de Relacionamentos
CREATE DATABASE IF NOT EXISTS aula_mysql;
USE aula_mysql;

CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE empregados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

-- Aula 2: Operações Básicas com SQL
-- Inserindo dados
INSERT INTO departamentos (nome) VALUES ('Recursos Humanos'), ('Financeiro'), ('TI');

INSERT INTO empregados (nome, departamento_id) VALUES ('João Silva', 1), ('Maria Souza', 2), ('Carlos Pereira', 3);

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
