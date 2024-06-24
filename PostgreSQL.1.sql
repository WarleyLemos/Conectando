-- Criação do banco de dados
CREATE DATABASE ESCOLA;
USE ESCOLA;

-- Criação da tabela ALUNO
CREATE TABLE ALUNO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Matricula INT NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20)
);

-- Criação da tabela EMPRESTIMO
CREATE TABLE EMPRESTIMO (
    Codigo INT AUTO_INCREMENT PRIMARY KEY,
    Data_hora DATETIME NOT NULL,
    Matric_Aluno INT NOT NULL,
    Data_devolucao DATE NOT NULL,
    FOREIGN KEY (Matric_Aluno) REFERENCES ALUNO(Matricula)
);

-- Inserção de dados na tabela ALUNO
INSERT INTO ALUNO (Nome, Matricula, Email, Endereco, Telefone) VALUES
('João Carlos', 1234, 'Jcarlos@gmail.com', 'Rua 13 de maio', '(11)7825-4489'),
('José Vitor', 2345, 'Jvitor@gmail.com', 'Rua da Saudade', '(11)7825-6589'),
('Paulo André', 3456, 'Pandr@gmail.com', 'Rua do Sol', '(11)7825-4495');

-- Inserção de dados na tabela EMPRESTIMO
INSERT INTO EMPRESTIMO (Data_hora, Matric_Aluno, Data_devolucao) VALUES
('2022-03-12 15:25', 1234, '2022-03-15'),
('2022-03-15 14:32', 3456, '2022-03-18'),
('2022-03-20 03:51', 2345, '2022-03-23');

-- Consultas usando JOIN

-- Consulta 1: Todos os empréstimos com informações dos alunos
SELECT 
    EMPRESTIMO.Codigo,
    EMPRESTIMO.Data_hora,
    EMPRESTIMO.Data_devolucao,
    ALUNO.Nome,
    ALUNO.Email
FROM 
    EMPRESTIMO
JOIN 
    ALUNO ON EMPRESTIMO.Matric_Aluno = ALUNO.Matricula;

-- Consulta 2: Alunos que realizaram empréstimos depois de uma determinada data
SELECT 
    ALUNO.Nome,
    ALUNO.Email,
    EMPRESTIMO.Data_hora,
    EMPRESTIMO.Data_devolucao
FROM 
    EMPRESTIMO
JOIN 
    ALUNO ON EMPRESTIMO.Matric_Aluno = ALUNO.Matricula
WHERE 
    EMPRESTIMO.Data_hora > '2022-03-14';

-- Consulta 3: Listar todos os alunos e seus respectivos empréstimos (se houver)
SELECT 
    ALUNO.Nome,
    ALUNO.Email,
    EMPRESTIMO.Codigo,
    EMPRESTIMO.Data_hora,
    EMPRESTIMO.Data_devolucao
FROM 
    ALUNO
LEFT JOIN 
    EMPRESTIMO ON ALUNO.Matricula = EMPRESTIMO.Matric_Aluno;