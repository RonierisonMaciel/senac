-- 1. Criação do Banco de Dados
CREATE DATABASE escola;

-- 2. Selecionar o Banco de Dados
USE escola;

-- 3. Criação da Tabela cursos
CREATE TABLE IF NOT EXISTS cursos (
    curso_id INT PRIMARY KEY,
    nome_curso VARCHAR(100)
);

-- 3. Criação da Tabela alunos
CREATE TABLE IF NOT EXISTS alunos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
);

CREATE TABLE IF NOT EXISTS alunos_b (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
);

-- 5. Inserção de Dados na Tabela cursos
INSERT INTO cursos (curso_id, nome_curso) VALUES (1, 'Engenharia de Software');
INSERT INTO cursos (curso_id, nome_curso) VALUES (2, 'Ciência da Computação');
INSERT INTO cursos (curso_id, nome_curso) VALUES (3, 'Sistemas de Informação');
INSERT INTO cursos (curso_id, nome_curso) VALUES (4, 'Análise e Desenvolvimento de Sistemas');

-- 4. Inserção de Dados na Tabela alunos
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (1, 'João Silva', '2001-05-20', 1);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (2, 'Maria Oliveira', '2000-11-15', 2);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (3, 'Carlos Mendes', '1999-12-10', 4);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (4, 'Joana Xavier', '1999-12-10', NULL);

INSERT INTO alunos_b (id, nome, data_nascimento, curso_id) VALUES (1, 'Rogério Felix', '2001-05-20', 1);
INSERT INTO alunos_b (id, nome, data_nascimento, curso_id) VALUES (2, 'Maria Luisa', '2000-11-15', 2);
INSERT INTO alunos_b (id, nome, data_nascimento, curso_id) VALUES (3, 'Sabrina Feitosa', '1999-12-10', 4);
INSERT INTO alunos_b (id, nome, data_nascimento, curso_id) VALUES (4, 'Juliana Oliveira', '1999-12-10', NULL);

-- 6. Consultas com JOINs
-- INNER JOIN: Listar todos os alunos e seus respectivos cursos
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
INNER JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- 7. LEFT JOIN: Listar todos os alunos, incluindo aqueles que não estão matriculados em nenhum curso
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
LEFT JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- 8. RIGHT JOIN: Listar todos os cursos, incluindo aqueles que não têm alunos matriculados
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
RIGHT JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- 9. FULL OUTER JOIN (simulado com UNION): Listar todos os alunos e cursos, incluindo os que não têm correspondência
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
LEFT JOIN cursos ON alunos.curso_id = cursos.curso_id
UNION
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
RIGHT JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- 10. Subconsulta de Única Linha: Encontrar os alunos que estão matriculados no curso de Engenharia de Software
SELECT nome FROM alunos WHERE curso_id = (SELECT curso_id FROM cursos WHERE nome_curso = 'Engenharia de Software');

-- 11. Subconsulta de Múltiplas Linhas: Listar os alunos que estão matriculados em cursos que começam com "Ciência"
SELECT nome FROM alunos WHERE curso_id IN (SELECT curso_id FROM cursos WHERE nome_curso LIKE 'Ciência%');

-- 12. Subconsulta Correlacionada: Listar os alunos que estão matriculados em cursos específicos com base em critérios dinâmicos
SELECT nome FROM alunos a WHERE EXISTS (SELECT 1 FROM cursos c WHERE c.curso_id = a.curso_id AND c.nome_curso = 'Engenharia de Software');

-- 13. Criação de uma View: Criar uma view para simplificar a consulta de alunos e seus cursos
CREATE VIEW alunos_cursos AS
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- 14. Consulta de uma View: Usar a view `alunos_cursos` para listar todos os alunos e seus cursos
SELECT * FROM alunos_cursos;

-- 15. Exclusão de uma View: Excluir a view criada
DROP VIEW IF EXISTS alunos_cursos;

-- 16. Seleção: Alunos nascidos após o ano 2000
SELECT * FROM alunos WHERE data_nascimento > '2000-01-01';

-- 17. Projeção: Apenas os nomes e as datas de nascimento dos alunos
SELECT nome, data_nascimento FROM alunos;

-- 18. Renomeação: Renomear a coluna nome para estudante_nome
# SELECT nome AS estudante_nome, data_nascimento FROM alunos;

-- 19. União: Combinação de registros de duas tabelas semelhantes
SELECT nome, data_nascimento FROM alunos
UNION
SELECT nome, data_nascimento FROM alunos_b;

-- 20. Diferença: Alunos em uma tabela mas não na outra
SELECT a.nome, a.data_nascimento
FROM alunos a
LEFT JOIN alunos_b b ON a.nome = b.nome AND a.data_nascimento = b.data_nascimento
WHERE b.nome IS NULL;

-- 21. Produto Cartesiano: Todas as combinações possíveis entre alunos e cursos
SELECT * FROM alunos, cursos;

-- 22. Junção: Juntar alunos com seus respectivos cursos
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- 23. Cálculo Relacional de Tupla: Alunos com idade maior que 20 anos
SELECT nome FROM alunos WHERE (YEAR(CURDATE()) - YEAR(data_nascimento)) > 20;

-- 24. Cálculo Relacional de Domínio: Alunos cujo curso é 'Engenharia de Software'
SELECT nome FROM alunos WHERE curso_id = (SELECT curso_id FROM cursos WHERE nome_curso = 'Engenharia de Software');

-- 25. Criação da Tabela Cliente
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

INSERT INTO Cliente (cliente_id, nome, telefone) VALUES (1, 'Roberta Miranda', '(81) 997765415');
INSERT INTO Cliente (cliente_id, nome, telefone) VALUES (2, 'André Rocha', '(81) 965540981');
INSERT INTO Cliente (cliente_id, nome, telefone) VALUES (3, 'Mannoel Filho', '(81) 965433218');
INSERT INTO Cliente (cliente_id, nome, telefone) VALUES (4, 'Carla Shutz', '(81) 987466216');

-- 25. Índices
CREATE INDEX idx_cliente_nome ON Cliente(nome);

-- 26.1 Início Tiggers

-- Tabela Cliente
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela de Auditoria para armazenar logs de alterações
CREATE TABLE auditoria_cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    usuario VARCHAR(100),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    campo_alterado VARCHAR(50),
    valor_antigo VARCHAR(255),
    valor_novo VARCHAR(255)
);

-- 26. Triggers
DELIMITER //

CREATE TRIGGER antes_atualizacao_cliente
BEFORE UPDATE ON Cliente
FOR EACH ROW
BEGIN
    -- Auditar alteração no campo "nome"
    IF OLD.nome != NEW.nome THEN
        INSERT INTO auditoria_cliente (cliente_id, usuario, campo_alterado, valor_antigo, valor_novo)
        VALUES (OLD.cliente_id, USER(), 'nome', OLD.nome, NEW.nome);
    END IF;

    -- Auditar alteração no campo "telefone"
    IF OLD.telefone != NEW.telefone THEN
        INSERT INTO auditoria_cliente (cliente_id, usuario, campo_alterado, valor_antigo, valor_novo)
        VALUES (OLD.cliente_id, USER(), 'telefone', OLD.telefone, NEW.telefone);
    END IF;
END //

DELIMITER ;

-- Inserindo dados iniciais
INSERT INTO Cliente (nome, telefone) VALUES ('João Silva', '9999-1234');

-- Atualizando o telefone do cliente
UPDATE Cliente SET telefone = '8888-4321' WHERE cliente_id = 1;

SELECT * FROM auditoria_cliente WHERE cliente_id = 1;

-- 26.2 Fim Triggers

-- 27.1 Início Stored Procedures

-- Tabela Cliente
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela de Auditoria para registrar as alterações
CREATE TABLE auditoria_cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    usuario VARCHAR(100),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    campo_alterado VARCHAR(50),
    valor_antigo VARCHAR(255),
    valor_novo VARCHAR(255)
);

DELIMITER //

CREATE PROCEDURE AtualizarCliente(
    IN p_cliente_id INT,
    IN p_novo_nome VARCHAR(100),
    IN p_novo_telefone VARCHAR(20)
)
BEGIN
    DECLARE v_nome_atual VARCHAR(100);
    DECLARE v_telefone_atual VARCHAR(20);

    -- Buscar os valores atuais do cliente
    SELECT nome, telefone INTO v_nome_atual, v_telefone_atual
    FROM Cliente
    WHERE cliente_id = p_cliente_id;

    -- Comparar o nome e inserir auditoria se houver alteração
    IF v_nome_atual != p_novo_nome THEN
        INSERT INTO auditoria_cliente (cliente_id, usuario, campo_alterado, valor_antigo, valor_novo)
        VALUES (p_cliente_id, USER(), 'nome', v_nome_atual, p_novo_nome);
    END IF;

    -- Comparar o telefone e inserir auditoria se houver alteração
    IF v_telefone_atual != p_novo_telefone THEN
        INSERT INTO auditoria_cliente (cliente_id, usuario, campo_alterado, valor_antigo, valor_novo)
        VALUES (p_cliente_id, USER(), 'telefone', v_telefone_atual, p_novo_telefone);
    END IF;

    -- Atualizar os dados do cliente
    UPDATE Cliente
    SET nome = p_novo_nome, telefone = p_novo_telefone
    WHERE cliente_id = p_cliente_id;

END //

DELIMITER ;

-- Insere um novo cliente
INSERT INTO Cliente (nome, telefone) VALUES ('João Silva', '9999-1234');

-- Atualiza o nome e telefone do cliente
CALL AtualizarCliente(1, 'João Silva', '8888-4321');

-- Exibe o log de auditoria
SELECT * FROM auditoria_cliente WHERE cliente_id = 1;

-- Atualiza o telefone do cliente
CALL AtualizarCliente(1, 'João Pedro Silva', '8888-4321');

-- Exibe o log de auditoria
SELECT * FROM auditoria_cliente WHERE cliente_id = 1;

-- 27.2 Fim Stored Procedures

-- Início funções definidas pelo usuário (UDF)

CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    data_nascimento DATE
);

-- Inserindo alguns dados de exemplo
INSERT INTO Cliente (nome, data_nascimento) 
VALUES ('João Silva', '1985-05-15'), 
       ('Maria Oliveira', '1990-08-22'), 
       ('Carlos Mendes', '2000-02-10');

DELIMITER //

CREATE FUNCTION CalcularIdade(data_nascimento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    -- Calcular a idade com base no ano atual menos o ano de nascimento
    RETURN YEAR(CURDATE()) - YEAR(data_nascimento);
END //

DELIMITER ;

-- Usando a função para calcular a idade dos clientes
SELECT nome, CalcularIdade(data_nascimento) AS idade
FROM Cliente;

-- Filtrando clientes com mais de 30 anos
SELECT nome, CalcularIdade(data_nascimento) AS idade
FROM Cliente
WHERE CalcularIdade(data_nascimento) > 30;

-- Ordenando os clientes por idade decrescente
SELECT nome, CalcularIdade(data_nascimento) AS idade
FROM Cliente
ORDER BY idade DESC;

-- Excluindo a função definida pelo usuário
DROP FUNCTION IF EXISTS CalcularIdade;

-- Fim funções definidas pelo usuário

-- Início Views Complexas

-- Tabela Cliente
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100)
);

-- Tabela Produto
CREATE TABLE Produto (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- Tabela PedidoProduto
CREATE TABLE PedidoProduto (
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

-- Inserindo clientes
INSERT INTO Cliente (nome, email) 
VALUES ('João Silva', 'joao@email.com'),
       ('Maria Oliveira', 'maria@email.com');

-- Inserindo produtos
INSERT INTO Produto (nome_produto, preco) 
VALUES ('Notebook', 2000.00),
       ('Mouse', 50.00),
       ('Teclado', 100.00);

-- Inserindo pedidos
INSERT INTO Pedido (cliente_id, data_pedido) 
VALUES (1, '2024-09-01'), 
       (2, '2024-09-02');

-- Inserindo itens dos pedidos
INSERT INTO PedidoProduto (pedido_id, produto_id, quantidade)
VALUES (1, 1, 1),  -- João comprou 1 Notebook
       (1, 2, 2),  -- João comprou 2 Mouses
       (2, 3, 1);  -- Maria comprou 1 Teclado

-- Criando uma view para exibir os pedidos dos clientes com os produtos
CREATE VIEW view_pedidos_clientes_produtos AS
SELECT 
    c.nome AS nome_cliente,
    c.email,
    p.pedido_id,
    p.data_pedido,
    pr.nome_produto,
    pp.quantidade,
    pr.preco,
    (pp.quantidade * pr.preco) AS valor_total
FROM 
    Cliente c
JOIN 
    Pedido p ON c.cliente_id = p.cliente_id
JOIN 
    PedidoProduto pp ON p.pedido_id = pp.pedido_id
JOIN 
    Produto pr ON pp.produto_id = pr.produto_id;

-- Consultando a view
SELECT * FROM view_pedidos_clientes_produtos;

-- Consultando os pedidos de um cliente específico
SELECT * FROM view_pedidos_clientes_produtos
WHERE nome_cliente = 'João Silva';

-- Consultando os produtos comprados em um pedido específico
SELECT nome_produto, quantidade, valor_total 
FROM view_pedidos_clientes_produtos 
WHERE pedido_id = 1;

-- Modificando e atualizando a view
CREATE OR REPLACE VIEW view_pedidos_clientes_produtos AS
SELECT 
    c.nome AS nome_cliente,
    c.email,
    p.pedido_id,
    p.data_pedido,
    pr.nome_produto,
    pp.quantidade,
    pr.preco,
    (pp.quantidade * pr.preco) AS valor_total,
    p.data_pedido + INTERVAL 7 DAY AS prazo_entrega
FROM 
    Cliente c
JOIN 
    Pedido p ON c.cliente_id = p.cliente_id
JOIN 
    PedidoProduto pp ON p.pedido_id = pp.pedido_id
JOIN 
    Produto pr ON pp.produto_id = pr.produto_id;

-- Fim Views Complex

-- 30. Início Particionamento de Tabelas

-- Tabela de Vendas
CREATE TABLE HistoricoVendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    valor DECIMAL(10, 2)
)
PARTITION BY RANGE (YEAR(data_venda)) (
    PARTITION p2019 VALUES LESS THAN (2020),
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024)
);

-- Inserindo dados de vendas
INSERT INTO HistoricoVendas (data_venda, valor) 
VALUES 
('2019-05-15', 150.00), 
('2020-06-20', 200.00),
('2021-07-10', 300.00),
('2022-08-22', 400.00),
('2023-09-01', 500.00);

-- Consultando as vendas de 2021
SELECT * FROM HistoricoVendas 
WHERE YEAR(data_venda) = 2021;

-- Consultando as vendas de 2022
SELECT * FROM HistoricoVendas 
WHERE YEAR(data_venda) = 2022;

-- Verificando as partições
SHOW TABLE STATUS LIKE 'HistoricoVendas';

-- Verificar especificamente as partições da tabela HistoricoVendas
SHOW CREATE TABLE HistoricoVendas;

-- Expandindo partições para anos futuros
ALTER TABLE HistoricoVendas
ADD PARTITION (
    PARTITION p2024 VALUES LESS THAN (2025)
);

-- Removendo partições antigas
ALTER TABLE HistoricoVendas
DROP PARTITION p2019, p2020;

-- Combinando partições com índices
CREATE INDEX idx_data_venda ON HistoricoVendas(data_venda);

-- Fim Particionamento de Tabelas

-- 31. Criação da Tabela Funcionarios
CREATE TABLE Funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES Funcionarios(id)
);

INSERT INTO Funcionarios (nome, supervisor_id) VALUES ('João', NULL); -- João é o CEO, sem supervisor

INSERT INTO Funcionarios (nome, supervisor_id) VALUES ('Maria', 1);   -- Maria reporta a João
INSERT INTO Funcionarios (nome, supervisor_id) VALUES ('Carlos', 1);  -- Carlos reporta a João

INSERT INTO Funcionarios (nome, supervisor_id) VALUES ('Ana', 2);     -- Ana reporta a Maria
INSERT INTO Funcionarios (nome, supervisor_id) VALUES ('Paulo', 3);   -- Paulo reporta a Carlos

-- 32. CTEs e Consultas Recursivas (MySQL 8.0+ necessário)
WITH RECURSIVE Hierarquia AS (
    SELECT id, nome, supervisor_id
    FROM Funcionarios
    WHERE supervisor_id IS NULL  -- Seleciona o nível mais alto da hierarquia (ex: João)
    UNION
    SELECT f.id, f.nome, f.supervisor_id
    FROM Funcionarios f
    INNER JOIN Hierarquia h ON f.supervisor_id = h.id  -- Encontra os subordinados
)
SELECT * FROM Hierarquia;

-- 33. Full-Text Search

-- Tabela Artigos
CREATE TABLE Artigos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    conteudo TEXT,
    FULLTEXT (titulo, conteudo)
) ENGINE=InnoDB;

-- Inserindo alguns artigos
INSERT INTO Artigos (titulo, conteudo) 
VALUES 
('Introdução ao MySQL', 'MySQL é um sistema de gerenciamento de banco de dados relacional.'),
('Vantagens do MySQL', 'MySQL é um dos bancos de dados mais populares, conhecido por sua eficiência e escalabilidade.'),
('Full-Text Search no MySQL', 'Este artigo explica como utilizar a funcionalidade Full-Text Search no MySQL para buscas eficientes.'),
('Aprendizado de Máquina', 'Técnicas de aprendizado de máquina têm se tornado cada vez mais populares em diversas áreas.'),
('Python para Data Science', 'Python é uma das linguagens mais populares para análise de dados e ciência de dados.');

-- Consulta Full-Text Search
SELECT titulo, conteudo 
FROM Artigos
WHERE MATCH(titulo, conteudo) AGAINST('MySQL');

-- Consulta por "aprendizado"
SELECT titulo, conteudo 
FROM Artigos
WHERE MATCH(titulo, conteudo) AGAINST('aprendizado');

-- Consulta por "MySQL eficiência"
SELECT titulo, conteudo 
FROM Artigos
WHERE MATCH(titulo, conteudo) AGAINST('MySQL eficiência');

-- Consulta em modo booleano
SELECT titulo, conteudo 
FROM Artigos
WHERE MATCH(titulo, conteudo) AGAINST('MySQL -eficiência' IN BOOLEAN MODE);

-- Consulta artigos que devem conter "MySQL" e podem conter "bancos"
SELECT titulo, conteudo 
FROM Artigos
WHERE MATCH(titulo, conteudo) AGAINST('+MySQL bancos' IN BOOLEAN MODE);

-- Consulta com relevância
SELECT titulo, conteudo, 
MATCH(titulo, conteudo) AGAINST('MySQL') AS relevancia
FROM Artigos
WHERE MATCH(titulo, conteudo) AGAINST('MySQL')
ORDER BY relevancia DESC;
