CREATE DATABASE TadeSound_BD;
use TadeSound_BD;

CREATE TABLE cliente (
    idCliente SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NULL,
    dataNascimento VARCHAR(8) NULL,
    telefone VARCHAR(11) NOT NULL,
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
    telefone VARCHAR(9) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    salario DECIMAL(10 , 2) NOT NULL,
    setor VARCHAR(255) NOT NULL,
    usuario VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
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

CREATE TABLE fornecedor (
    idFornecedor SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NULL,
    cnpj VARCHAR(14) NULL,
    telefone VARCHAR(9) NOT NULL,
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
    telefone VARCHAR(9) NOT NULL,
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
    grau SMALLINT NOT NULL,
    duracaoMin INT NOT NULL,
    idLoja SMALLINT NOT NULL,
    dataRequisicao DATETIME DEFAULT NOW() NOT NULL,
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

select * from cliente
select * from loja
select * from produto
select * from funcionario
select * from venda
select * from itensVenda
clienteclientedelete from cliente where idCliente = 15

drop database tadesound_bd;

INSERT INTO cliente (nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep) 
	VALUES ("Felipe Motta", "femotta38@gmail.com", "38284868863", "25102001", "999596830", "Rua schunk klein", 6, "novo Parelheiros", "Parelheiros", "Sao Paulo", "SP", "04693040"),
    ("Maria Silva", "femotta38@gmail.com", "38284868863", "25102001", "999596830", "Rua schunk klein", 6, "novo Parelheiros", "Parelheiros", "Sao Paulo", "SP", "04693040");
    
INSERT INTO fornecedor (nome, cpf, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep) values ("teste", "123132", "1231", "dasdad", "asdas", 12312, "adasd", "asdas", "adasd", "da", "asasd")
INSERT INTO loja (nome, telefone, endereco, numero, complemento, bairro, cidade, uf, cep) values ("asdasd", "adsd", "asdas", 12313, "adasd", "asdas", "adasd", "da", "asasd")
INSERT INTO funcionario (nome, email, cpf, dataNascimento, telefone, cargo, salario, setor, usuario, senha, nivelAcesso, nomeLoja, endereco, numero, complemento, bairro, cidade, uf, cep) values ("asdasd", "adsd", "asdas", 123123, "adasd", "asdas", 10000, "asd", "asasd", "asasd", "asasd", "asasd", "asasd", 12, "asasd", "asasd", "asasd", "as", "asasd")