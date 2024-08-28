
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
