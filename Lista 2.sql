--Q1.) Crie uma tabela chamada Curso que tenha os seguintes atributos: codigo, nome, instituicao, duracao, ativo.
CREATE TABLE Curso (
	id SERIAL PRIMARY KEY,
	cod VARCHAR(10) NOT NULL,
	nome TEXT NOT NULL,
	instituicao TEXT NOT NULL,
	duracao INT DEFAULT 0,
	ativo BOOLEAN
);

--Q2.) Inserir 5 cursos no banco de dados.
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('TI01', 'TI', 'UFRN', 4); 
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('TI01', 'TI','UNP', 4); 
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('TADS01', 'TADS', 'UFRN', 3);
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('FIS01', 'FISICA', 'UFRN', 4); 
INSERT INTO Curso (cod, nome, instituicao, duracao) VALUES('ENGCOMP01', 'ENG DA COMPUTACAO', 'UFRN', 5);

--Q3.) Crie uma tabela chamada Aluno que tenha os seguintes atributos: nome, sobrenome, data de nascimento, endereco.
CREATE TABLE Aluno (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	sobrenome TEXT,
	nascimento DATE,
	endereco TEXT
);

--Q4.) Inserir 10 alunos no banco de dados. Criar alguns alunos com o nome similar, por exemplo: Carla, Carla F., Carla F. Curvelo, carla.
INSERT INTO Aluno (nome, sobrenome, nascimento, endereco) VALUES ('Lucas', 'Loureiro', '20/05/1996', 'Neópolis');
INSERT INTO Aluno (nome, nascimento, endereco) VALUES ('Carla', '20/12/1996', 'Tirol');
INSERT INTO Aluno (nome, sobrenome, nascimento, endereco) VALUES ('Fernanda', 'Felix', '19/12/1999', 'Paju');
INSERT INTO Aluno (nome, sobrenome, nascimento, endereco) VALUES ('Carla', 'F', '20/12/1996', 'Nova Parna');
INSERT INTO Aluno (nome, sobrenome, nascimento, endereco) VALUES ('Carla', 'F Curvelo', '20/05/2005', 'Parna');
INSERT INTO Aluno (nome, nascimento, endereco) VALUES ('carla', '20/05/1996', 'Neópolis');
INSERT INTO Aluno (nome, sobrenome, nascimento, endereco) VALUES ('Mateus', 'Wesley', '20/06/1995', 'Nazaré');

--Q5.) Crie uma tabela chamada CursoAluno que tenha os seguintes atributos: id_aluno, id_curso, ativo
-- a. Id_aluno, id_curso são chaves primárias e estrangeiras
-- b. 3 dos alunos devem estar cursando o curso TADS da instituição UFRN.
ALTER TABLE Aluno ADD COLUMN curso INT;
ALTER TABLE Aluno ADD CONSTRAINT Curso FOREIGN KEY (curso) REFERENCES Curso(id);

CREATE TABLE CursoAluno (
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    ativo BOOLEAN NOT NULL,
    PRIMARY KEY(id_aluno,id_curso),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id),
    FOREIGN KEY (id_curso) REFERENCES Curso(id)
);

INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (2, 3, TRUE);
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (3, 3, TRUE);
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (5, 3, FALSE);
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (1, 1, TRUE);
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (6, 5, FALSE);
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (7, 1, FALSE);

SELECT * FROM Aluno;
SELECT * FROM Curso;
SELECT * FROM CursoAluno;

--Q6.) Inserir 10 elementos na tabela CursoAluno.
-- a. Alguns alunos devem estar cursando mais de um curso
-- b. Alguns alunos devem ter cursos inativos
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (3, 4, TRUE);
INSERT INTO CursoAluno (id_aluno, id_curso, ativo) VALUES (1, 2, TRUE);

--Q7.) Altere a duração do curso TADS para 2475.
UPDATE Curso SET duracao=2475 WHERE nome='TADS';

--Q8.) Deletar o curso com o nome Engenharia de Computação.
DELETE FROM CursoAluno WHERE id_curso = 5;
DELETE FROM Curso WHERE nome = 'ENG DA COMPUTACAO';

--Q9.) Buscar todos os alunos com nome Carla (considerando alterações do nome) - usar o LIKE

SELECT nome, sobrenome FROM Aluno WHERE nome LIKE %Carla% or SOBRENOME LIKE %CARLA%
	
-- a. Desconsiderar minúsculo e maiúsculo
SELECT nome, sobrenome
FROM Aluno
WHERE UPPER(nome) LIKE '%CARLA%' OR UPPER(sobrenome) LIKE '%CARLA%';

--Q10.) Selecionar os nomes dos alunos que estão cursando mais de um curso ativo
SELECT A.nome, A.sobrenome, A.id
FROM Aluno A
JOIN CursoAluno CA ON A.id = CA.id_aluno
GROUP BY A.id, A.nome
HAVING COUNT(DISTINCT CA.id_curso) > 1
   AND COUNT(CASE WHEN CA.ativo = TRUE THEN 1 END) > 1;

-- Q11.) Selecionar o valor médio de duração dos cursos da instituição de ensino
SELECT AVG(duracao) FROM Curso

--Q12.) Selecionar os cursos com menor e maior duração
SELECT MIN(duracao), MAX(duracao), nome FROM Curso C
GROUP BY C.id, C.nome

--Q13.) Selecionar a quantidade total de cursos ativos na instituição
SELECT COUNT(*) as total_cursos_ativos
FROM CursoAluno
WHERE ativo = True;

--Q14.) Selecionar a quantidade de alunos ativos inscritos por curso
CREATE VIEW Alunos_ativos_por_curso AS
SELECT CA.id_curso, C.nome, COUNT(*)
FROM CursoAluno CA
JOIN Curso C ON CA.id_curso = C.id
WHERE CA.ativo = TRUE
GROUP BY CA.id_curso, C.nome;

--Q15.) Selecionar os cursos que têm mais do que dois alunos inscritos
SELECT CA.id_curso, COUNT(*) as alunos_inscritos
FROM CursoAluno CA
JOIN Curso C ON CA.id_curso = C.id
GROUP BY CA.id_curso, C.nome
HAVING COUNT(*) > 2;

--Q16.) Selecionar os alunos que estão cursando o TADS e não estão cursando outro curso
SELECT A.nome, A.sobrenome, C.nome AS nome_curso, C.id AS id_curso
FROM Aluno A JOIN CursoAluno CA ON A.id = CA.id_aluno
WHERE CA.id_curso NOT IN (
		SELECT id
		FROM Curso
		WHERE nome = 'TADS' AND instituicao = 'UFRN'))

EXCEPT
(SELECT A.nome, A.sobrenome
FROM Aluno A JOIN CursoAluno CA ON CA.id_aluno = A.id
WHERE CA.id_curso NOT IN (
		SELECT id
		FROM Curso
		WHERE nome = 'TADS' AND instituicao = 'UFRN'))


--Q17.) Selecionar os alunos que estão cursando o TADS e estão cursando Engenharia de Computação
SELECT A.nome, A.sobrenome, C.nome AS nome_curso
FROM Aluno A
WHERE CA.id_curso = 3 AND CA.id_curso = 5;
GROUP BY A.id, A.nome, A.sobrenome, C.nome

--Q18.) Selecionar os alunos que estão cursando dois ou mais cursos
SELECT A.nome, A.sobrenome
FROM Aluno A
JOIN CursoAluno CA ON A.id = CA.id_aluno
GROUP BY A.id, A.nome, A.sobrenome
HAVING COUNT(DISTINCT CA.id_curso) >= 2;
