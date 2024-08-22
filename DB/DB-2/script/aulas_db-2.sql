
-- Criação do Banco de Dados (Caso ainda não exista)
CREATE DATABASE escola;

-- Selecionar o Banco de Dados
USE escola;

-- Criação da Tabela alunos (Caso ainda não exista)
CREATE TABLE IF NOT EXISTS alunos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    curso_id INT
);

-- Criação da Tabela cursos (Caso ainda não exista)
CREATE TABLE IF NOT EXISTS cursos (
    curso_id INT PRIMARY KEY,
    nome_curso VARCHAR(100)
);

-- Inserção de Dados na Tabela alunos
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (1, 'João Silva', '2001-05-20', 1);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (2, 'Maria Oliveira', '2000-11-15', 2);
INSERT INTO alunos (id, nome, data_nascimento, curso_id) VALUES (3, 'Carlos Mendes', '1999-12-10', NULL);

-- Inserção de Dados na Tabela cursos
INSERT INTO cursos (curso_id, nome_curso) VALUES (1, 'Engenharia de Software');
INSERT INTO cursos (curso_id, nome_curso) VALUES (2, 'Ciência da Computação');

-- Consultas com JOINs
-- INNER JOIN
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
INNER JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- LEFT JOIN
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
LEFT JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- RIGHT JOIN
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
RIGHT JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- FULL OUTER JOIN (Note: MySQL does not support FULL OUTER JOIN directly, use UNION)
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
LEFT JOIN cursos ON alunos.curso_id = cursos.curso_id
UNION
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
RIGHT JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- Consultas com Subconsultas
-- Subconsulta de Única Linha
SELECT nome FROM alunos WHERE curso_id = (SELECT curso_id FROM cursos WHERE nome_curso = 'Engenharia de Software');

-- Subconsulta de Múltiplas Linhas
SELECT nome FROM alunos WHERE curso_id IN (SELECT curso_id FROM cursos WHERE nome_curso LIKE 'Ciência%');

-- Subconsulta Correlacionada
SELECT nome FROM alunos a WHERE EXISTS (SELECT 1 FROM cursos c WHERE c.curso_id = a.curso_id AND c.nome_curso = 'Engenharia de Software');

-- Trabalhando com Views
-- Criação de uma View
CREATE VIEW alunos_cursos AS
SELECT alunos.nome, cursos.nome_curso 
FROM alunos 
JOIN cursos ON alunos.curso_id = cursos.curso_id;

-- Consulta de uma View
SELECT * FROM alunos_cursos;

-- Exclusão de uma View
DROP VIEW IF EXISTS alunos_cursos;
