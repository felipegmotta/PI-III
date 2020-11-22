CREATE DATABASE TadeSound_BD;
use TadeSound_BD;

CREATE TABLE cliente (
    idCliente SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NULL,
    dataNascimento VARCHAR(8) NULL,
    telefone varchar(11) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero SMALLINT NOT NULL,
    complemento VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL
);

CREATE TABLE fornecedor (
    idFornecedor SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NULL,
    cnpj VARCHAR(14) NULL,
    telefone VARCHAR(11) NOT NULL,
    email VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero SMALLINT NOT NULL,
    complemento VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL
);

CREATE TABLE loja (
    idLoja SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    telefone varchar(11) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero SMALLINT NOT NULL,
    complemento VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL
);

CREATE TABLE funcionario (
    idFuncionario SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idLoja SMALLINT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NULL,
    dataNascimento VARCHAR(10) NULL,
    telefone VARCHAR(11) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    salario DECIMAL(10 , 2) NOT NULL,
    setor VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero SMALLINT NOT NULL,
    complemento VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL,
    FOREIGN KEY (idLoja)
        REFERENCES loja (idLoja)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE usuario (
	idUsuario SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    idFuncionario SMALLINT NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL,
    FOREIGN KEY (idFuncionario)
        REFERENCES funcionario (idFuncionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE produto (
    idProduto SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(25) NOT NULL,
    preco DECIMAL(10 , 2 ) NOT NULL,
    categoria VARCHAR(255) NOT NULL,
    quantidadeEstoque INT NOT NULL,
    idFornecedor SMALLINT NOT NULL,
    idLoja SMALLINT NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL,
    FOREIGN KEY (idFornecedor)
        REFERENCES fornecedor (idFornecedor)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (idLoja)
        REFERENCES loja (idLoja)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE servico (
    idServico SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10 , 2 ) NOT NULL,
    grauComplexidade SMALLINT NOT NULL,
    duracaoMinutos INT NOT NULL,
    idLoja SMALLINT NOT NULL,
    dataCadastro DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL,
    FOREIGN KEY (idLoja)
        REFERENCES loja (idLoja)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE venda (
    idVenda SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(255) NOT NULL,
    valorTotal DECIMAL(10 , 2) NOT NULL,
    quantidadeProdutos SMALLINT NOT NULL,
    idCliente SMALLINT NOT NULL,
    idFuncionario SMALLINT NOT NULL,
    dataEntrega DATE NULL,
    dataRetirada DATE NULL,
    dataVenda DATETIME DEFAULT NOW() NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL,
    FOREIGN KEY (idCliente)
        REFERENCES cliente (idCliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (idFuncionario)
        REFERENCES funcionario (idFuncionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE itensVenda (
    idItensVenda SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idProduto SMALLINT NOT NULL,
    idVenda SMALLINT NOT NULL,
    quantidadeProduto SMALLINT NOT NULL,
    valorTotalProduto DECIMAL(10, 2) NOT NULL,
    ultimaAtualizacao DATETIME ON UPDATE NOW() NULL,
    FOREIGN KEY (idProduto)
        REFERENCES produto (idProduto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (idVenda)
        REFERENCES venda (idVenda)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

#Cria a trigger responsável por atualizar o estoque dos produtos, assim que uma venda for realizada
delimiter $$
CREATE TRIGGER atualizaEstoqueProduto AFTER INSERT ON itensVenda FOR EACH ROW
BEGIN
	UPDATE produto set quantidadeEstoque = quantidadeEstoque - NEW.quantidadeProduto WHERE idProduto = new.idProduto;
END $$

#SELECT do relatorio de produtos
SELECT
	produto.idProduto,
    produto.nome,
    produto.preco,
    itensVenda.quantidadeProduto,
    itensVenda.valorTotalProduto,
    funcionario.idLoja
FROM
	venda
    INNER JOIN itensVenda ON venda.idVenda = itensVenda.idVenda
    INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario
    INNER JOIN produto ON itensVenda.idProduto = produto.idProduto
WHERE produto.idProduto = 1;

SELECT cliente.idCliente, cliente.nome, loja.idLoja, loja.nome, venda.idVenda, venda.valorTotal, venda.dataVenda FROM venda INNER JOIN cliente ON venda.idCliente = cliente.idCliente INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario INNER JOIN loja ON funcionario.idLoja = loja.idLoja WHERE cliente.idCliente = 2;

#SELECT do relatorio de lojas
SELECT 
    SUM(venda.valorTotal) as "Valor Total",
	CONCAT(ROUND(SUM(valorTotal)*100/(SELECT SUM(valorTotal) FROM venda), 2), "%") AS 'valorTotalLoja'
FROM
    venda
	INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario
    INNER JOIN loja ON funcionario.idLoja = loja.idLoja
GROUP BY loja.idLoja

#SELECT do relatorio de clientes
SELECT 
	cliente.idCliente,
    cliente.nome,
    loja.idLoja,
    loja.nome,
    venda.idVenda,
    venda.valorTotal,
    venda.dataVenda
FROM
    venda
    INNER JOIN cliente ON venda.idCliente = cliente.idCliente
    INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario
    INNER JOIN loja ON funcionario.idLoja = loja.idLoja

#SELECT dos usuarios
SELECT 
    usuario.idUsuario,
    usuario.senha,
    funcionario.idFuncionario,
    funcionario.nome,
    funcionario.cargo,
    usuario.dataCadastro
FROM
    usuario
        INNER JOIN
    funcionario ON usuario.idFuncionario = funcionario.idFuncionario

#Base de dados
INSERT INTO loja (nome, telefone, endereco, numero, complemento, bairro, cidade, uf, cep, dataCadastro) 
VALUES ('TadeSoundSC', '40028922', 'Rua Dom Pedro I', 10, ' ', 'América', 'Joinville', 'SC', '89204170', '2020-10-28'),
		('TadeSoundDF', '34412086', 'Rua 24 Chácara',347, ' ', 'Vila São José', 'Brasília', 'DF', '72004205', '2020-10-17'),
		('TadeSoundSP', '4659907', 'Rua João Lúcio Viana', 25, ' ', ' Ferreira', 'São Paulo', 'SP', '05524080', '2020-10-30'),
		('TadeSoundPB', '51848966', 'Rua dos Pinhões', 140, ' ', 'Malvinas', 'Campina Grande', 'PB', '58432815', '2020-10-10');
        
INSERT INTO fornecedor (nome, cpf, cnpj, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep) 
VALUES ('Gx Importados', null, 52114491000103, '55589746', 'gximportados@gmail.com', 'Rua Fernandes', 411, '', 'Jardim Vista Alegre', 'São Paulo', 'SP', '841671955'),
		('VF Instrumentos', null, 30902802000158, '58317416', 'vfinstrumentos@gmail.com', 'Rua Zendavesta', 07, ' ' , 'Jardim Vista Alegre', 'São Paulo', 'SP', '841671955'),
		('JS Importados', null, 17484570000105, '56861547', 'jsimportados@gmail.com', 'Rua Fernandes', 100, ' ', 'Jardim Rodolfo Pirani', 'São Paulo', 'SP', '08310450');
        
INSERT INTO produto (nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja)
VALUES ('Bateria Eletrônica TD 1 DMK Roland', 'Bateria Eletrônica TD 1 DMK Roland', 8799.00,'Percussão', 10, 1, 2),
		('Guitarra Affinity Stratocaster Squier By Fender', 'Guitarra Affinity Stratocaster Squier By Fender - Preto (Black) (506)', 3299.00, 'Cordas', 12, 1, 3 ),
		('Contrabaixo 5 Cordas Open Pore B5 P Cort', 'Contrabaixo 5 Cordas Open Pore B5 P Cort', 5569.00, 'Cordas', 10, 2, 1),
		('Violão Aço Dallas Elétrico', 'Violão Aço Dallas Elétrico com Afinador Série América Tagima - Preto BK ', 1169.00, 'Instrumento de Cordas', 8, 3, 2);
        
INSERT INTO cliente (nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep)
VALUES ("Marcos Lopes", "marcospereiralopes1@gmail.com", "98357868797", "25081995", "986166239", "Avenida Abud Daibes", 324, "Funil", "Casa 03", "Rio de Janeiro", "RJ", "28440970"),
		("Cláudia Sarah Jesus", "claudiasarahjesus@gmail.com", "56484039844", "15021998", "986166239", "Rua Anderson Messias Costa", 7, "", "Vila Fachini", "Sao Paulo", "SP", "4334030"),
		("Isabel Emilly Ferreira", "isabelemillyferreira@gmail.com", "56418170822", "17102001", "981874525", "Rua Forte de Alcobaça", 999, "", " Vila Seabra", "Sao Paulo", "SP", " 8180510"),
		("Vitor Ricardo Rafael Nunes", "vitorricardorafaelnunes@gmail.com", "38916469848", "15021998", "991149248", " Avenida São Remo", 613, " ", " Vila Butantã", "Sao Paulo", "SP", "5360900");

INSERT INTO funcionario (idloja, nome, email, cpf, dataNascimento, telefone, cargo, salario, setor, endereco,numero, complemento,bairro,cidade,uf,cep)
VALUES (1, 'Rogerio Braga', 'rogeriobraga@gmail.com',null, 25-08-1997, '54478699', 'admin', 5500.00, 'Vendas',
 'Rua Magalhaes Castro', 07, '', 'Baragos', 'Santa Catarina', 'SC', 04831120),
		(2, 'Bruno Fernandes', 'brunof@gmail.com',null, 25-10-2002, '40028933', 'vendedor', 5500.00, 'Vendas',
 'Rua Magalhaes Castro', 07, '', 'Baragos', 'Santa Catarina', 'SC', 04840122),
		(3, 'Flora Dias', 'florad@gmail.com',null, 25-10-1997, '34412084', 'backoffice', 5500.00, 'Vendas',
 'Rua Zabumbue', 158, '', 'Jd Elisio', 'São Paulo', 'SP', 04831122),
		(2, 'admin', 'administrator@gmail.com',null, 25-10-2002, '40028933', 'gerente', 5500.00, 'Vendas',
'Rua Magalhaes Castro', 07, '', 'Baragos', 'Santa Catarina', 'SC', 04840122);

INSERT INTO usuario (login, senha, idFuncionario) VALUES ("admin", "$2y$12$IchP8ujVwPn6RsCJu8pOiuT/DvRKbxdT2Jmz16KwWQC79.k01e5t6", "1"),
														 ("vendedor", "$2y$12$9XXODn4BgjvTb2oOFCr54e1mhnVb215mkJIdtnMDnp9rkb5slTAha", "2"),
														 ("backoffice", "$2y$12$wHoIYjYKmX.mAxPnml1MvORZuMeDcbIYh32XO0W08Ut.vhWfCpl9e", "3"),
														 ("gerente", "$2y$12$iMvNdpkk5EQnkoA3zQAcBOG8zagR8vR8HCjoikSHgjRjaBdUiFAqq", "4");

#SELECTS aleatorios
select * from cliente
select * from loja
select * from produto
select * from funcionario
select * from venda
select * from itensVenda
select * from fornecedor
select * from servico
select * from usuario
select * from fornecedor
