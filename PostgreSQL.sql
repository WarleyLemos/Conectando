CREATE TABLE cliente (
  id SERIAL PRIMARY KEY ,
  nome VARCHAR(16) not NULL,
  sobrenome VARCHAR(24) not NULL,
  idade INT,
  pais VARCHAR(4) );
  
CREATE TABLE pedido (
   ID SERIAL PRIMARY KEY,
   item VARCHAR(48) NOT NULL,
   quantidade INT NOT NULL,
   fk_id_cliente INT NOT NULL,
   CONSTRAINT fk_cliente FOREIGN KEY (fk_id_cliente) REFERENCES cliente(id) );
   
INSERT INTO cliente (nome, sobrenome, idade, pais) VALUES
  ('João', 'Alves', 48, 'BR'),
  ('Roberto', 'Garcia', 36, 'MX'),
  ('Dario', 'Rubens', 39, 'ARG'),
  ('Julia', 'Lopes', 28, 'PE'),
  ('Rebeca', 'Giglio', 54, 'IT');
  
INSERT INTO pedido (item, quantidade, fk_id_cliente) VALUES
  ('teclado', 1, 4),
  ('mouse', 2, 4),
  ('monitor', 8, 3),
  ('teclado', 1, 1),
-- Criação do banco de dados

CREATE DATABASE ESCOLA (

USE ESCOLA );

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