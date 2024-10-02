CREATE DATABASE nome_do_seu_banco;
USE nome_do_seu_banco;

CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT
);

CREATE TABLE professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    disciplina VARCHAR(100)
);

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(100),
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professores(id)
);

CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT,
    curso_id INT,
    data_matricula DATE,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Inserção de Dados

INSERT INTO alunos (nome, idade) VALUES ('Carlos', 22), ('Ana', 20), ('Beatriz', 19), ('João', 25), ('Tamires', 21);
INSERT INTO professores (nome, disciplina) VALUES ('Professor Marco', 'Matemática'), ('Professor Maciel', 'Física'), ('Professor Souza', 'Química');
INSERT INTO cursos (nome_curso, professor_id) VALUES ('Cálculo', 1), ('Física I', 2), ('Química Geral', 3), ('Álgebra', 1);

INSERT INTO matriculas (aluno_id, curso_id, data_matricula) VALUES (1, 1, '2024-01-10'), (2, 2, '2024-01-11'), (3, 1, '2024-01-12'),
(4, 3, '2024-01-13'), (5, 4, '2024-01-14'), (1, 2, '2024-01-15');
