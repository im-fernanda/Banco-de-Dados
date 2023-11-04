Q1.) Crie uma tabela chamada Curso que tenha os seguintes atributos: codigo, nome, instituicao, duracao.
    a. A tabela deve ter uma chave primária chamada id.
    b. Se não for especificada a duração, deve ser atribuído o valor 0 a ela.
    c. Codigo, nome e instituicao são atributos obrigatórios.

CREATE TABLE Curso (
 id SERIAL PRIMARY KEY,
 cod VARCHAR(8) NOT NULL,
 nome TEXT NOT NULL,
 instituicao TEXT NOT NULL,
 duracao INT DEFAULT 0
);

Q2.) Inserir 5 cursos no banco de dados.
    a. Inserir 2 cursos com o mesmo nome, mas de instituições diferentes.
    b. Inserir um curso com o nome TADS e instituicao UFRN.

INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('TI001', 'TI', 'UFRN', 5); 
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('TI002', 'TI','UNP', 4); 
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('TADS001', 'TADS', 'UFRN-EAJ', 3);
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('FIS001', 'FIS', 'UFRN', 4); 
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('HIST001', 'HIST', 'UFRN', 5);

Q3.) Crie uma tabela chamada Aluno que tenha os seguintes atributos: nome,

CREATE TABLE Aluno (
 id SERIAL PRIMARY KEY,
 nome TEXT NOT NULL,
 sobrenome TEXT NOT NULL,
 nascimento TEXT NOT NULL,
 endereco TEXT NOT NULL
);

ALTER TABLE Aluno RENAME COLUMN nascimento TO data_nascimento;

Q4.) Inserir 5 alunos no banco de dados

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco) VALUES ('Lucas', 'Loureiro', '20/05/1996', 'Neópolis');
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco) VALUES ('Ramon', 'Gomes', '20/12/1996', 'Tirol');
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco) VALUES ('Fernanda', 'Felix', '19/12/1999', 'Paju');
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco) VALUES ('Fer', 'Bezerra', '20/12/1996', 'Paju');
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco) VALUES ('Vina', 'Gomes', '20/05/2005', 'Parna');


SELECT * from Aluno;
SELECT * from Curso;

Q5.) Alterar a tabela Aluno para inserir o atributo curso
    a. O atributo curso é uma chave estrangeira que referencia a tabela curso, e
    pode ser um valor nulo.

ALTER TABLE Aluno ADD Curso INT REFERENCES Curso(id);

Q6.) Inserir 5 novos alunos no banco de dados
    a. Todos os alunos devem estar cursando algum curso.
    b. 3 desses alunos devem estar cursando o curso TADS da instituição UFRN.

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, curso) VALUES ('Luiz', 'Guilherme', '20/08/1998', 'Igapó', 3);
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, curso) VALUES ('Pedro', 'Alexandre', '17/05/2004', 'Neópolis', 3);
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, curso) VALUES ('André', 'Lucas', '19/07/2005', 'Nova Parnamirim', 3);
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, curso) VALUES ('Maria', 'Clara', '25/05/1999', 'Planalto', 5);
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, curso) VALUES ('Cibelly', 'Fernandes', '19/05/2000', 'Maca', 5);

Q7.) Selecionar os nomes de todos os cursos.

SELECT nome
FROM Curso

Q8.) Selecionar os nomes dos cursos, sem repetir os nomes.
SELECT DISTINCT nome
FROM Curso

Q9.) Selecionar apenas os cursos que tenham uma duração maior do que 6 semestres.
SELECT *
FROM Curso
WHERE (duracao*2)>6

Q10.) Selecionar o nome e sobrenome de todos os alunos cadastrados no sistema.

SELECT nome, sobrenome
FROM Aluno

Q11.)  Selecionar o nome e sobrenome de todos os alunos que estão matriculados em
algum curso.

SELECT nome, sobrenome
FROM Aluno
WHERE (Curso IS NOT NULL)

Q12.) Selecionar o nome e sobrenome dos alunos que cursam o curso TADS na UFRN

SELECT A.nome, A.sobrenome
FROM Aluno A
JOIN Curso C ON A.curso = C.id
WHERE C.nome = 'TADS' AND C.instituicao = 'UFRN-EAJ';
