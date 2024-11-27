CREATE DATABASE exercicio;
USE exercicio;

CREATE TABLE Categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
);

CREATE TABLE Produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10,2),
    estoque INT,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

CREATE TABLE Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    endereco VARCHAR(200)
);

CREATE TABLE Pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data_pedido DATETIME,
    status ENUM('Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado'),
    total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

CREATE TABLE Itens_Pedido (
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (pedido_id, produto_id),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

-- Procedimento para gerar dados

DELIMITER //

CREATE PROCEDURE GerarDados()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;

    -- Inserir Categorias
    WHILE i <= 20 DO
        INSERT INTO Categorias (nome) VALUES (CONCAT('Categoria ', i));
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Inserir Produtos
    WHILE i <= 1000 DO
        INSERT INTO Produtos (nome, descricao, preco, estoque, categoria_id)
        VALUES (
            CONCAT('Produto ', i),
            CONCAT('Descrição do produto ', i),
            ROUND(RAND() * 500 + 1, 2),
            FLOOR(RAND() * 100 + 1),
            FLOOR(RAND() * 20 + 1)
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Inserir Clientes
    WHILE i <= 500 DO
        INSERT INTO Clientes (nome, email, senha, endereco)
        VALUES (
            CONCAT('Cliente ', i),
            CONCAT('cliente', i, '@exemplo.com'),
            'senha123',
            CONCAT('Endereço do Cliente ', i)
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    -- Inserir Pedidos e Itens_Pedido
    WHILE i <= 800 DO
        SET @cliente_id = FLOOR(RAND() * 500 + 1);
        SET @data_pedido = NOW() - INTERVAL FLOOR(RAND() * 365) DAY;
        SET @status = ELT(FLOOR(RAND() * 5 + 1), 'Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado');
        INSERT INTO Pedidos (cliente_id, data_pedido, status, total)
        VALUES (@cliente_id, @data_pedido, @status, 0);
        SET @pedido_id = LAST_INSERT_ID();

        -- Inserir Itens do Pedido
        SET j = 1;
        SET @num_itens = FLOOR(RAND() * 5 + 1);

        -- Criar tabela temporária para rastrear produtos adicionados
        CREATE TEMPORARY TABLE temp_produtos (
            produto_id INT PRIMARY KEY
        );

        WHILE j <= @num_itens DO
            SET @produto_id = FLOOR(RAND() * 1000 + 1);

            -- Verificar se o produto já foi adicionado ao pedido
            WHILE EXISTS (SELECT 1 FROM temp_produtos WHERE produto_id = @produto_id) DO
                SET @produto_id = FLOOR(RAND() * 1000 + 1);
            END WHILE;

            -- Registrar o produto na tabela temporária
            INSERT INTO temp_produtos (produto_id) VALUES (@produto_id);

            SET @quantidade = FLOOR(RAND() * 5 + 1);
            SELECT preco INTO @preco_unitario FROM Produtos WHERE id = @produto_id;
            INSERT INTO Itens_Pedido (pedido_id, produto_id, quantidade, preco_unitario)
            VALUES (@pedido_id, @produto_id, @quantidade, @preco_unitario);
            SET j = j + 1;
        END WHILE;

        -- Atualizar total do pedido
        SELECT SUM(quantidade * preco_unitario) INTO @total FROM Itens_Pedido WHERE pedido_id = @pedido_id;
        UPDATE Pedidos SET total = @total WHERE id = @pedido_id;

        -- Remover tabela temporária
        DROP TEMPORARY TABLE temp_produtos;

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- Executar o procedimento para gerar os dados
CALL GerarDados();

-- Remover o procedimento se não for mais necessário
DROP PROCEDURE GerarDados;

-- Criação do índice e consulta de exemplo
CREATE INDEX idx_coluna ON Produtos(preco);

-- Consulta de Produtos com preço entre 100 e 200
SELECT * FROM Produtos WHERE preco BETWEEN 100 AND 200;

-- Medir o tempo de execução da consulta
EXPLAIN SELECT * FROM Produtos WHERE preco BETWEEN 100 AND 200;

-- Consulta de Produtos com preço entre 100 e 200 e tempo de execução
SET @inicio = NOW();
SELECT * FROM Produtos WHERE preco BETWEEN 100 AND 200;
SET @fim = NOW();
SELECT TIMEDIFF(@fim, @inicio) AS tempo__de_execucao;

-- Remover o índice
DROP INDEX idx_coluna ON tabela;
