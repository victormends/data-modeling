-- Nome: João Victor Mendes
-- Matrícula: 211708033

-- (Resolução individual. Responda com suas palavras. Crie os seus exemplos.)
-- Exercícios de reforço em SQL

-- (Peso 4) Execute as instruções a seguir:
-- Apague todas as tabelas do seu banco de dados individual de laboratório (anexe as instruções SQL utilizadas).
DROP TABLE *
-- Crie as tabelas e preencha com dados o modelo das lojas ZAGI, use o arquivo anexo “DDL e DML CodeCreatePopulate_ZAGI.sql”.


-- Insira a região “Centro-Oeste” (anexe as instruções SQL utilizadas).
INSERT INTO region VALUES ('O', 'Centro-Oeste');

-- Insira a loja sob o ZipCode “46788” na região “Centro-Oeste” (anexe as instruções SQL utilizadas).
INSERT INTO store VALUES ('S4','46788','O');
-- Insira o cliente “Willian” sob o ZipCode “87673” (anexe as instruções SQL utilizadas).
INSERT INTO customer VALUES ('4-5-666','Willian','87673');

-- Insira o fornecedor “DAMA X” (anexe as instruções SQL utilizadas).
INSERT INTO vendor VALUES ('DX','DAMA X');

-- Insira o produto “Broken Wind”, custando $ 120, do fornecedor “DAMA X” sob a categoria “Camping” (anexe as instruções SQL utilizadas).
INSERT INTO product VALUES ('7X7','Broken Wind',120,'DX','CP');

-- Insira uma transação de venda realizada na única loja que fica na região “Centro-Oeste”, feita pelo cliente “Willian”, adquirindo 10 produtos “Broken Wind” no dia 3-jan-2020 (anexe as instruções SQL utilizadas).
INSERT INTO salestransaction VALUES ('T666','4-5-666','S4','03/Jan/2020');
INSERT INTO includes VALUES ('7x7','T666',10);





-- (Peso 3) Elabore uma instrução SQL que liste o nome da região e o montante de receita por região (anexe a instrução SQL utilizada e o resultado obtido).
SELECT r.regionname [Região], SUM(p.productprice*i.quantity) [Montante]
FROM region AS r
INNER JOIN store AS s ON r.regionid = s.regionid
INNER JOIN salestransaction AS st ON s.storeid = st.storeid
INNER JOIN includes AS i ON st.tid = i.tid
INNER JOIN product AS p ON i.productid = p.productid
GROUP BY r.regionname;

-- (Peso 3) Elabore uma instrução SQL que liste o nome do produto e o montante de receita por produto em ordem descendente de receita (anexe a instrução SQL utilizada e o resultado obtido).
SELECT p.productname [Produto], SUM(p.productprice*i.quantity) [Montante]
FROM product AS p
INNER JOIN includes AS i ON p.productid = i.productid
GROUP BY p.productname
ORDER BY Montante DESC;