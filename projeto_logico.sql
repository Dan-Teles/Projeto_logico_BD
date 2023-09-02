CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CLIENTE
CREATE TABLE Cliente(
	idCliente INT auto_increment PRIMARY KEY,
    nome VARCHAR(45),
    endereco VARCHAR(45),
	cpf CHAR (11) NOT NULL,
    cnpj VARCHAR(18),
    CONSTRAINT unique_cpf_cliente UNIQUE (cpf),
    CONSTRAINT unique_cnpj_cliente UNIQUE (cnpj)
    );

DESC Cliente;

-- PRODUTO
CREATE TABLE Produto(
	idProduto INT auto_increment PRIMARY KEY,
    categoria VARCHAR(45),
    descricao VARCHAR(45),
	valor FLOAT
);

DESC Produto;

-- PAGAMENTO
CREATE TABLE Pagamento(
	idPagamento INT auto_increment PRIMARY KEY,
    pagamentoCliente INT,
    cartao VARCHAR(45),
    numero VARCHAR(45),
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (pagamentoCliente) REFERENCES Cliente(idCliente)
);

DESC Pagamento;

-- ENTREGA
CREATE TABLE Entrega(
	idEntrega INT auto_increment PRIMARY KEY,
    statusEntrega BOOL,
    codigoRastreio VARCHAR(45),
    dataEntrega DATE
);

DESC Entrega;

-- PEDIDO
CREATE TABLE Pedido(
	idPedido INT auto_increment PRIMARY KEY,
    statusPedido BOOL DEFAULT FALSE,
    frete FLOAT,
    descricao VARCHAR(45),
    CONSTRAINT fk_entrega FOREIGN KEY (idPedido) REFERENCES Entrega(idEntrega)
);

DESC Pedido;

-- ESTOQUE
CREATE TABLE Estoque(
	idEstoque INT auto_increment PRIMARY KEY,
    Local VARCHAR(45)
);

DESC Estoque;

-- PRODUTOS EM ETOQUE
CREATE TABLE Produtos_Estoque(
	idProduto INT PRIMARY KEY,
    idProdutos_Estoque INT,
    quantidade FLOAT,
    CONSTRAINT fk_estoque FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_produto_estoque FOREIGN KEY (idProdutos_Estoque) REFERENCES Estoque(idEstoque)
);

DESC Produtos_Estoque;

-- FORNECEDOR PRINCIPAL
CREATE TABLE Fornecedor(
	idFornecedor INT auto_increment PRIMARY KEY,
    cpf CHAR (11) NOT NULL,
    cnpj VARCHAR(18),
    CONSTRAINT unique_cpf_cliente UNIQUE (cpf),
    CONSTRAINT unique_cnpj_cliente UNIQUE (cnpj)
);

DESC Fornecedor;

-- FORNECEDOR TERCEIRO
CREATE TABLE Fornecedor_Terceiro(
	idTerceiro INT auto_increment PRIMARY KEY,
    endereco VARCHAR(45),
    cpf CHAR (11) NOT NULL,
    cnpj VARCHAR(18),
    CONSTRAINT unique_cpf_cliente UNIQUE (cpf),
    CONSTRAINT unique_cnpj_cliente UNIQUE (cnpj)
);

DESC TFornecedor_Terceiro;

-- PEDIDO DE PRODUTO
CREATE TABLE Pedido_produto(
	idPedido INT,
    idProduto INT,
    quantidade FLOAT DEFAULT 1,
    CONSTRAINT fk_pedido FOREIGN KEY (idPedido) REFERENCES Fornecedor_Terceiro(idTerceiro),
    CONSTRAINT fk_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

DESC Pedido_produto;

-- PEDIDO DE PRODUTO PARA FORNECEDOR PRINCIPAL
CREATE TABLE Pedido_Fornecedor(
	idCompraFornecedor INT,
    idFornecedorPedido INT,
    quantidade FLOAT DEFAULT 1,
    CONSTRAINT fk_pedido_forncedor FOREIGN KEY (idCompraFornecedor) REFERENCES Fornecedor(idFornecedor),
    CONSTRAINT fk_fornecedor_pedido FOREIGN KEY (idFornecedorPedido) REFERENCES Pedido(idPedido)
);

DESC Pedido_Fornecedor;

-- PRODUTOS EM ESTOQUE FORNECEDOR PRINCIPAL (VERIFICA SE O FORNECEDOR TEM O PRODUTO QUE O CLIENTE DESEJA)
CREATE TABLE Estoque_Fornecedor(
	idEstoque_Fornecedor INT,
    idProdutoFornecedor INT,
    CONSTRAINT fk_estoque_fornecedor FOREIGN KEY (idEstoque_Fornecedor) REFERENCES Fornecedor(idFornecedor),
    CONSTRAINT fk_produtos_fornecedor FOREIGN KEY (idProdutoFornecedor) REFERENCES Produto(idProduto)
);

DESC Estoque_Fornecedor;

-- PRODUTOS EM ESTOQUE FORNECEDOR TERCEIRO (VERIFICA SE O FORNECEDOR TEM O PRODUTO QUE O CLIENTE DESEJA)

CREATE TABLE Estoque_Terceiro(
	idProdutosEstoque INT,
    idPOFornecedor INT,
    CONSTRAINT fk_produtos_estoque FOREIGN KEY (idProdutosEstoque) REFERENCES Produto(idProduto),
    CONSTRAINT fk_po_fornecedor FOREIGN KEY (idPOFornecedor) REFERENCES Terceiro(idTerceiro)
);

DESC Estoque_Terceiro;