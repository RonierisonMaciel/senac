CREATE DATABASE `banco_3`;

USE banco_3;

CREATE TABLE alunos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento date,
    email VARCHAR(80),
    cpf VARCHAR(80)
);

CREATE TABLE cursos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(100),
    data_criacao date,
    descri_curso VARCHAR(100),
    professor VARCHAR(100),
    id_aluno INT,
    foreign key (id_alunos) references alunos (id)
);

insert into alunos (nome, data_nascimento, email, cpf) values 
("Carlos Alberto", '2024-08-08', "carlos.alberto@gmail.com", "088.452.467-51"), 
("André Veloso", '1989-01-01', "veloso@gmail.com", "088.058.487-50"), 
("Maria Oliveira", '2001-07-01', "maria.oliveira@gmail.com", "010.222.427-40"),
("Josefá Silva", '1945-03-10', "josefa@gmail.com", "025.154.874-60");

insert into cursos (nome_curso, data_criacao, descri_curso, professor, id_aluno) values 
('Análise e Desenvolimento de Sistemas', '2024-07-08', 'curso onoonoono', 'Johnatan Silva', 1), ('', '', '', '', 2),
('Sistemas de Informação', '2024-07-08', 'curso onoonoono', 'Fábio Oliveira', 3), ('', '', '', '', 3);

# -----------------------------------------------

CREATE DATABASE IF NOT EXISTS banco_de_dados;
USE banco_de_dados;

CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

INSERT INTO Clientes (cliente_id, nome, endereco, telefone) VALUES (1, 'João Silva', 'Rua A, 123', '1234-5678');
INSERT INTO Clientes (cliente_id, nome, endereco, telefone) VALUES (2, 'Maria Souza', 'Rua B, 456', '8765-4321');

CREATE TABLE Pedidos (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

INSERT INTO Pedidos (pedido_id, cliente_id, data_pedido, valor_total) VALUES (1, 1, '2024-08-28', 150.50);
INSERT INTO Pedidos (pedido_id, cliente_id, data_pedido, valor_total) VALUES (2, 2, '2024-08-29', 200.75);

SELECT * FROM Clientes WHERE nome = ?;

CREATE TABLE Produtos (
    produto_id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10, 2),
    categoria VARCHAR(50)
);

INSERT INTO Produtos (produto_id, nome, preco, categoria) VALUES (1, 'Notebook', 3500.00, 'Eletrônicos');
INSERT INTO Produtos (produto_id, nome, preco, categoria) VALUES (2, 'Smartphone', 1500.00, 'Eletrônicos');
INSERT INTO Produtos (produto_id, nome, preco, categoria) VALUES (3, 'Livro', 50.00, 'Literatura');

SELECT * FROM Produtos WHERE categoria = ?;

-- 1. Exemplo de uso de LIKE:
SELECT * FROM Clientes WHERE endereco LIKE 'Rua%';

-- 2. Exemplo de INNER JOIN:
SELECT Clientes.nome, Pedidos.pedido_id, Pedidos.data_pedido
FROM Clientes
INNER JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;

-- 3. Exemplo de LEFT JOIN:
SELECT Clientes.nome, Pedidos.pedido_id, Pedidos.data_pedido
FROM Clientes
LEFT JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;

-- 4. Exemplo de RIGHT JOIN:
SELECT Clientes.nome, Pedidos.pedido_id, Pedidos.data_pedido
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;

-- 5. Exemplo de FULL JOIN:
SELECT Clientes.nome, Pedidos.pedido_id, Pedidos.data_pedido
FROM Clientes
FULL JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;

-- 6. Exemplo de GROUP BY e HAVING:
SELECT cliente_id, COUNT(pedido_id) AS total_pedidos, SUM(valor_total) AS total_valor
FROM Pedidos
GROUP BY cliente_id
HAVING total_valor > 100;

-- 7. Exemplo de uso de MAX:
SELECT MAX(valor_total) AS maior_pedido FROM Pedidos;

-- 8. Criação de uma VIEW:
CREATE VIEW View_Clientes_Pedidos AS
SELECT Clientes.cliente_id, Clientes.nome, Pedidos.pedido_id, Pedidos.data_pedido
FROM Clientes
INNER JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;

-- Usando a VIEW para consultas:
SELECT * FROM View_Clientes_Pedidos;

-- 9. Criação de tipos de dados usando CREATE TYPE:
CREATE TYPE Endereco AS (
    rua VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(10)
);

CREATE TYPE Cliente AS (
    cliente_id INT,
    nome VARCHAR(100),
    endereco Endereco,
    telefone VARCHAR(20)
);


CREATE TABLE ClientesComEndereco (
    cliente_info Cliente,
    data_registro DATE
);

INSERT INTO ClientesComEndereco (cliente_info, data_registro)
VALUES (
    Cliente(1, 'João Silva', Endereco('Rua A', 'Recife', 'PE', '50000-000'), '1234-5678'),
    '2024-08-28'
);

SELECT cliente_info.nome, cliente_info.endereco.cidade
FROM ClientesComEndereco;
