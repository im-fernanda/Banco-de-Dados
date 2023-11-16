-- CRIE o banco de dados
CREATE TABLE Fornecedores (
    idFORNECEDOR INTEGER PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    RUA VARCHAR(255),
    CIDADE VARCHAR(255),
    ESTADO CHAR(2)
);

CREATE TABLE Categorias (
    idCATEGORIA INTEGER PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL
);

CREATE TABLE Produtos (
    idPRODUTO INTEGER PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    QUANTIDADE INTEGER,
    PRECO FLOAT,
    idFORNECEDOR INTEGER REFERENCES Fornecedores(idFORNECEDOR),
    idCATEGORIA INTEGER REFERENCES Categorias(idCATEGORIA)
);

INSERT INTO Categorias (idCATEGORIA, NOME) VALUES
(1, 'Super Luxo'),
(2, 'Importado'),
(3, 'Tecnologia'),
(4, 'Vintage'),
(5, 'Supremo');

-- INSERIR dados de 2 fornecedores distintas, sendo do Estado do RN e outro do estado da PB;
INSERT INTO Fornecedores (idFORNECEDOR, NOME, RUA, CIDADE, ESTADO) VALUES
(6, 'Lojinha do Carioca', 'Av São João', 'Natal', 'RN'),
(7, 'Verdinha', 'Av João Galo', 'Campina Grande', 'PB'),

-- INSERINDO outros fornecedores
(1, 'Ajax SA', 'Rua Presidente Castelo Branco', 'Porto Alegre', 'RS'),
(2, 'Sansul SA', 'Av Brasil', 'Rio de Janeiro', 'RJ'),
(3, 'South Chairs', 'Rua do Moinho', 'Santa Maria', 'RS'),
(4, 'Elon Electro', 'Rua Apolo', 'São Paulo', 'SP'),
(5, 'Mike electro', 'Rua Pedro da Cunha', 'Curitiba', 'PR');

-- INSERIR dados de 2 produtos de categoria 3 e qualquer fornecedor
INSERT INTO Produtos (idPRODUTO, NOME, QUANTIDADE, PRECO, idFORNECEDOR, idCATEGORIA) VALUES
(6, 'Laptop da Xuxa', 20, 50, 4, 3),
(7, 'Caixa JBL', 12, 120, 5, 3);

--INSERIR dados de mais 1 categoria de nome Nacional
INSERT INTO Categorias (idCATEGORIA, NOME) VALUES
(6, 'Nacional');

-- INSERINDO outros produtos
INSERT INTO Produtos (idPRODUTO, NOME, QUANTIDADE, PRECO, idFORNECEDOR, idCATEGORIA) VALUES
(1, 'Cadeira azul', 30, 300, 5, 5),
(2, 'Cadeira vermelha', 50, 2150, 2, 1),
(3, 'Guarda-roupa Disney', 400, 829.5, 4, 1),
(4, 'Torradeira Azul', 20, 9.90, 3, 1),
(5, 'TV', 30, 3300.25, 2, 2);

-- ATUALIZE a tabela produtos, aumentando o preço do produto cujo idPRODUTO é 4, para R$ 298.00;
UPDATE Produtos SET PRECO = 298.00 WHERE idPRODUTO = 4;

-- RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no RJ;
SELECT p.* FROM Produtos p JOIN Fornecedores f ON p.idFORNECEDOR = f.idFORNECEDOR WHERE f.ESTADO = 'RJ';
-- RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no RS;
SELECT p.* FROM Produtos p JOIN Fornecedores f ON p.idFORNECEDOR = f.idFORNECEDOR WHERE f.ESTADO = 'RS';
-- RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no SP;
SELECT p.* FROM Produtos p JOIN Fornecedores f ON p.idFORNECEDOR = f.idFORNECEDOR WHERE f.ESTADO = 'SP';

-- RECUPERE da tabela produtos e fornecedores o nome do produto mais caro e o nome do fornecedor deste produto;
SELECT p.NOME AS NOME_PRODUTO, f.NOME AS NOME_FORNECEDOR FROM Produtos p 
JOIN Fornecedores f ON p.idFORNECEDOR = f.idFORNECEDOR 
WHERE p.PRECO = (SELECT MAX(PRECO) FROM Produtos);

-- ATUALIZE a tabela fornecedores, alterando a cidade para Parnamirim, o estado para RN e a Rua para Abel Cabral, do Fornecedor cujo nome é Elon Electro;
UPDATE Fornecedores
SET CIDADE = 'Parnamirim', ESTADO = 'RN', RUA = 'Abel Cabral'
WHERE NOME = 'Elon Electro';

-- ATUALIZE a tabela produtos, alterando o preço dos produtos em 10% de aumento, cujo fornecedor seja Sansul SA.
UPDATE Produtos
SET PRECO = PRECO*1.1
WHERE idFORNECEDOR = (SELECT idFORNECEDOR FROM Fornecedores WHERE NOME = 'Sansul SA');

-- ATUALIZE a tabela produtos, alterando o preço dos produtos em 10% de diminuição, cujo fornecedor seja Mike electro e a categoria seja Supremo.
UPDATE Produtos
SET PRECO = PRECO*0.9
WHERE 
   idFORNECEDOR = (SELECT idFORNECEDOR FROM Fornecedores WHERE NOME = 'Mike Electro') AND
   idCATEGORIA = (SELECT idCATEGORIA FROM Categorias WHERE NOME = 'Supremo');

--  RECUPERE da tabela produtos, todos os produtos que tenham o preço entre 8 e 2.000, ordenados a partir do maior preço.
SELECT * FROM Produtos
WHERE PRECO BETWEEN 8 AND 2000
ORDER BY PRECO DESC;

-- RECUPERE da tabela produtos, todos os produtos que tenham o preço entre 800 e 2.000, ordenados a partir do menor preço.
SELECT *
FROM Produtos
WHERE PRECO BETWEEN 800 AND 2000
ORDER BY PRECO;

-- RECUPERE da tabela fornecedor, o nome de todos os fornecedores que iniciam com a letra A.
SELECT NOME FROM Fornecedores
WHERE NOME LIKE 'A%';
-- RECUPERE da tabela fornecedor, o nome de todos os fornecedores que contenham a letra S.
SELECT NOME FROM Fornecedores
WHERE NOME LIKE '%S%';

-- ATUALIZE a tabela produtos, aumentando em 15% a quantidade de produtos que tenham o preço inferior a 300.
UPDATE Produtos
SET QUANTIDADE = QUANTIDADE * 1.15
WHERE PRECO < 300;

-- APAGUE da tabela produtos todas os produtos da categoria 5;
DELETE FROM Produtos
WHERE idCATEGORIA = 5;

-- RECUPERE da tabela fornecedores, todos os registros cadastrados;
SELECT * FROM Fornecedores;

-- RECUPERE da tabela produtos, o nome dos produtos que iniciam com a letra T e tenham o preço acima de 400;
SELECT NOME FROM Produtos
WHERE NOME LIKE 'T%' AND PRECO > 400;

-- APAGUE a tabela produtos;
DROP TABLE Produtos;
