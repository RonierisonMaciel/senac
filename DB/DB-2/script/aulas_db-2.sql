-- 1. Criação do Banco de Dados
CREATE DATABASE escola;

-- 2. Selecionar o Banco de Dados
USE escola;

-- 3. Criação da Tabela alunos
CREATE TABLE IF NOT EXISTS alunos (
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
);

-- 3. Criação da Tabela cursos
CREATE TABLE IF NOT EXISTS cursos (
    curso_id INT PRIMARY KEY,
    nome_curso VARCHAR(100)
);

-- 4. Inserção de Dados na Tabela alunos
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (1, 'João Silva', '2001-05-20', 1);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (2, 'Maria Oliveira', '2000-11-15', 2);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (3, 'Carlos Mendes', '1999-12-10', 4);

-- 5. Inserção de Dados na Tabela cursos
INSERT INTO cursos (curso_id, nome_curso) VALUES (1, 'Engenharia de Software');
INSERT INTO cursos (curso_id, nome_curso) VALUES (2, 'Ciência da Computação');
INSERT INTO cursos (curso_id, nome_curso) VALUES (3, 'Sistemas de Informação');
INSERT INTO cursos (curso_id, nome_curso) VALUES (4, 'Análise e Desenvolvimento de Sistemas');

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
SELECT nome AS estudante_nome, data_nascimento FROM alunos;

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

-- 25. Índices
CREATE INDEX idx_cliente_nome ON Cliente(nome);

-- 26. Triggers
DELIMITER //
CREATE TRIGGER before_cliente_update
BEFORE UPDATE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_cliente (cliente_id, alteracao, data)
    VALUES (OLD.cliente_id, 'Modificado', NOW());
END //
DELIMITER ;

-- 27. Stored Procedures
DELIMITER //
CREATE PROCEDURE AtualizarTelefone(IN cliente INT, IN novo_telefone VARCHAR(20))
BEGIN
    UPDATE Cliente
    SET telefone = novo_telefone
    WHERE cliente_id = cliente;
END //
DELIMITER ;

-- 28. Funções Definidas pelo Usuário (UDF)
DELIMITER //
CREATE FUNCTION CalcularAnosCadastro(data DATE)
RETURNS INT
BEGIN
    RETURN YEAR(CURDATE()) - YEAR(data);
END //
DELIMITER ;

-- 29. Views Complexas
CREATE VIEW ClientesComEndereco AS
SELECT c.nome, e.rua, e.cidade, e.estado
FROM Cliente c
JOIN Endereco e ON c.endereco_id = e.id;

-- 30. Particionamento de Tabelas
CREATE TABLE Historico_Vendas (
    id INT,
    data_venda DATE,
    valor DECIMAL(10,2)
)
PARTITION BY RANGE (YEAR(data_venda)) (
    PARTITION p2019 VALUES LESS THAN (2020),
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022)
);

-- 31. InnoDB e Suporte a Transações
START TRANSACTION;
UPDATE Cliente SET nome = 'Maria Silva' WHERE cliente_id = 1;
DELETE FROM Endereco WHERE id = 5;
ROLLBACK;

-- 32. CTEs e Consultas Recursivas (MySQL 8.0+ necessário)
WITH RECURSIVE Hierarquia AS (
    SELECT id, nome, supervisor_id
    FROM Funcionarios
    WHERE supervisor_id IS NULL
    UNION
    SELECT f.id, f.nome, f.supervisor_id
    FROM Funcionarios f
    INNER JOIN Hierarquia h ON f.supervisor_id = h.id
)
SELECT * FROM Hierarquia;

-- 33. Full-Text Search
CREATE FULLTEXT INDEX idx_texto ON artigos(conteudo);
SELECT * FROM artigos WHERE MATCH(conteudo) AGAINST('palavras chave');
