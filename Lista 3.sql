--1. Crie uma tabela chamada "Carro" que tenha os seguintes atributos: placa, marca,
--modelo, ano, disponível. A tabela deve ter uma chave primária chamada "placa". Se
--o campo "disponível" não for especificado, deve ser atribuído o valor "true" a ele.
CREATE TABLE Carro (
	placa VARCHAR PRIMARY KEY,
	marca VARCHAR NOT NULL,
	modelo VARCHAR NOT NULL,
	ano INTEGER NOT NULL,
	disponivel BOOLEAN DEFAULT TRUE
);

--2. Insira informações de carros na tabela "Carro". Inclua pelo menos 5 registros.
INSERT INTO Carro (placa, marca, modelo, ano, disponivel) VALUES 
('FMA123', 'Honda', 'Civic', 2020, True),
('AMC213', 'Toyota', 'Corolla', 2018, True),		
('DEF456', 'Ford', 'Focus', 2021, True),
('GHI789', 'Chevrolet', 'Cruze', 2022, True),
('JKL012', 'Nissan', 'Altima', 2021, True);

--3. Crie uma tabela chamada "Cliente" que tenha os seguintes atributos: id, nome,
--email, telefone. A tabela deve ter uma chave primária chamada "id".
CREATE TABLE Cliente (
	id SERIAL PRIMARY KEY,
	nome VARCHAR NOT NULL,
	email VARCHAR,
	telefone VARCHAR
);

--4. Insira informações de clientes na tabela "Cliente". Inclua pelo menos 2 registros.
INSERT INTO Cliente (nome, email, telefone)
VALUES
('João Silva', 'joao@email.com', '123-456-7890'),
('Maria Santos', 'maria@email.com', '987-654-3210');

--5. Crie uma tabela chamada "Aluguel" que tenha os seguintes atributos: id,
--placa_carro, id_cliente, data_inicio, data_fim. A tabela deve ter uma chave primária
--chamada "id" e campos placa_carro e id_cliente como chaves estrangeiras.
CREATE TABLE Aluguel (
	id SERIAL PRIMARY KEY,
	data_inicio DATE,
	data_fim DATE,
	placa_carro VARCHAR REFERENCES Carro(placa),
	id_cliente SERIAL REFERENCES Cliente(id)
);

--6. Insira informações de aluguéis na tabela "Aluguel". Inclua pelo menos 3 registros.
INSERT INTO Aluguel (id_cliente, placa_carro, data_inicio, data_fim)
VALUES
(1, 'FMA123', '2023-01-15', '2023-01-20'),
(2, 'AMC213', '2023-02-10', '2023-02-15'),
(1, 'DEF456', '2023-03-05', '2023-03-10');

--7. Selecione todos os carros disponíveis para aluguel.
SELECT * FROM Carro
WHERE disponivel = true;

--8. Selecione os carros alugados por um cliente específico.
SELECT c.placa, c.marca, c.modelo
FROM Carro c
INNER JOIN Aluguel a on a.placa_carro = c.placa
INNER JOIN Cliente cl on a.id_cliente = cl.id
WHERE cl.nome = 'João Silva'

--9. Calcule a duração média dos aluguéis.
SELECT AVG(data_fim-data_inicio) AS duracao_media FROM Aluguel;

--10. Selecione os carros mais alugados.
SELECT c.marca, c.modelo, c.placa, COUNT (a.id) AS total_alugueis
FROM Carro c
LEFT JOIN Aluguel a ON a.placa_carro = c.placa
GROUP BY c.placa, c.marca, c.modelo
ORDER BY total_alugueis DESC;

--11. Selecione os carros ordenados por ano em ordem decrescente.
SELECT * FROM CARRO
ORDER BY ano DESC;

--12. Selecione os clientes ordenados por nome em ordem alfabética.
SELECT * FROM Cliente
ORDER BY nome;

--13. Agrupe os carros por marca e conte quantos carros de cada marca estão disponíveis
--para aluguel.
SELECT c.marca, COUNT (*) AS total_disponiveis 
FROM Carro c
GROUP BY marca;

--14. Agrupe os aluguéis por cliente e calcule a quantidade total de aluguéis para cada
--cliente
SELECT cl.nome, COUNT(*) AS alugueis
FROM Aluguel a
INNER JOIN Cliente cl ON a.id_cliente = cl.id
GROUP BY cl.nome;