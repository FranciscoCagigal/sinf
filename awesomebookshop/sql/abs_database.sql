/* Drop Tables */

DROP TABLE IF EXISTS Administrador CASCADE
;

DROP TABLE IF EXISTS Armazem CASCADE
;

DROP TABLE IF EXISTS ArmazemPublicacao CASCADE
;

DROP TABLE IF EXISTS Autor CASCADE
;

DROP TABLE IF EXISTS AutorPublicacao CASCADE
;

DROP TABLE IF EXISTS Carrinho CASCADE
;

DROP TABLE IF EXISTS Cartaocredito CASCADE
;

DROP TABLE IF EXISTS Cartaocreditocliente CASCADE
;

DROP TABLE IF EXISTS Categoria CASCADE
;

DROP TABLE IF EXISTS Cliente CASCADE
;

DROP TABLE IF EXISTS Codigopostal CASCADE
;

DROP TABLE IF EXISTS Comentario CASCADE
;

DROP TABLE IF EXISTS Editora CASCADE
;

DROP TABLE IF EXISTS Encomenda CASCADE
;

DROP TABLE IF EXISTS Funcionario CASCADE
;

DROP TABLE IF EXISTS Imagem CASCADE
;

DROP TABLE IF EXISTS Informacaofaturacao CASCADE
;

DROP TABLE IF EXISTS Localidade CASCADE
;

DROP TABLE IF EXISTS Login CASCADE
;

DROP TABLE IF EXISTS Metodopagamento CASCADE
;

DROP TABLE IF EXISTS Morada CASCADE
;

DROP TABLE IF EXISTS MoradaEnvio CASCADE
;

DROP TABLE IF EXISTS MoradaFaturacao CASCADE
;

DROP TABLE IF EXISTS Multibanco CASCADE
;

DROP TABLE IF EXISTS Pais CASCADE
;

DROP TABLE IF EXISTS Perguntautilizador CASCADE
;

DROP TABLE IF EXISTS Pesquisa CASCADE
;

DROP TABLE IF EXISTS Publicacao CASCADE
;

DROP TABLE IF EXISTS Publicacaocarrinho CASCADE
;

DROP TABLE IF EXISTS Publicacaoencomenda CASCADE
;

DROP TABLE IF EXISTS PublicacaoWishList CASCADE
;

DROP TABLE IF EXISTS Subcategoria CASCADE
;

DROP TABLE IF EXISTS Wishlist CASCADE
;

/* Drop Types */

DROP TYPE IF EXISTS Genero CASCADE
;

DROP TYPE IF EXISTS Tipocartao CASCADE
;

DROP TYPE IF EXISTS Estadoencomenda CASCADE
;

DROP TYPE IF EXISTS Periodicidade CASCADE
;

/* Drop Indexes */

DROP INDEX IF EXISTS idx_publicacao_titulo CASCADE
;

DROP INDEX IF EXISTS idx_publicacao_subcategoria CASCADE
;

DROP INDEX IF EXISTS idx_publicacao_descricao CASCADE
;

DROP INDEX IF EXISTS idx_publicacao_stock CASCADE
;

DROP INDEX IF EXISTS idx_encomenda_cliente CASCADE
;

DROP INDEX IF EXISTS idx_encomenda_estado CASCADE
;

DROP INDEX IF EXISTS idx_login_cliente CASCADE
;

DROP INDEX IF EXISTS idx_cliente_carrinho CASCADE
;

DROP INDEX IF EXISTS idx_cliente_nome CASCADE
;

/* Drop Triggers */

DROP TRIGGER IF EXISTS insert_publicacao_trigger ON Publicacao CASCADE
;

DROP TRIGGER IF EXISTS insert_cliente_trigger ON Cliente CASCADE
;

DROP TRIGGER IF EXISTS insert_funcionario_trigger ON Funcionario CASCADE
;

DROP TRIGGER IF EXISTS insert_encomenda_trigger ON Encomenda CASCADE
;

DROP TRIGGER IF EXISTS insert_publicacaoencomenda_trigger ON Publicacaoencomenda CASCADE
;

DROP TRIGGER IF EXISTS insert_imagem_trigger ON Imagem CASCADE
;

DROP TRIGGER IF EXISTS insert_comentario_trigger ON Comentario CASCADE
;

DROP TRIGGER IF EXISTS insert_multibanco_trigger ON Multibanco CASCADE
;

DROP TRIGGER IF EXISTS insert_cartaocredito_trigger ON Cartaocredito CASCADE
;

DROP TRIGGER IF EXISTS update_informacaoFaturacao_trigger ON Publicacaoencomenda CASCADE
;

DROP TRIGGER IF EXISTS update_subtotalcarrinho_trigger ON Publicacaocarrinho CASCADE
;

DROP TRIGGER IF EXISTS update_publicacaostock_on_update_armazempublicacao_trigger ON ArmazemPublicacao CASCADE
;

/* Create Types */

CREATE TYPE Genero AS ENUM
(
	'Masculino',
	'Feminino'
)
;

CREATE TYPE Tipocartao AS ENUM
(
	'AmericanExpress',
	'MasterCard',
	'Visa'
)
;

CREATE TYPE Estadoencomenda AS ENUM
(
	'Cancelada',
	'Enviada',
	'Em processamento',
	'Devolvida',
	'Processada',
	'Paga'
)
;

CREATE TYPE Periodicidade AS ENUM
(
	'Diario',
	'Semanal',
	'Mensal',
	'Anual'
)
;

/* Create Tables */

CREATE TABLE Administrador
(
	AdministradorID SERIAL,
	PaisID integer NOT NULL,
	Nome varchar(100) NOT NULL,
	Genero varchar(50) NOT NULL,
	Datanascimento date NOT NULL,
	Datacessacao date NULL,
	Username varchar(50) NOT NULL,
	Password varchar(50) NOT NULL,
	Ativo boolean NOT NULL DEFAULT TRUE,
	CONSTRAINT PK_Administrador PRIMARY KEY (AdministradorID),
	CONSTRAINT administrador_username_key UNIQUE (Username),
	CONSTRAINT administrador_password_length CHECK (length(Password) >= 6)
)
;

CREATE TABLE Armazem
(
	ArmazemID SERIAL,
	PrimaveraArmazemID varchar(30) NOT NULL,
	Nome varchar(100) NOT NULL,
	CONSTRAINT PK_Armazem PRIMARY KEY (ArmazemID)
)
;

CREATE TABLE ArmazemPublicacao
(
	ArmazemID integer NOT NULL,
	PublicacaoID integer NOT NULL,
	Stock integer NOT NULL,
	CONSTRAINT PK_ArmazemPublicacao PRIMARY KEY (ArmazemID,PublicacaoID)
)
;

CREATE TABLE Autor
(
	AutorID SERIAL,
	PaisID integer NOT NULL DEFAULT 193,
	Nome varchar(100) NOT NULL,
	Genero varchar(50),
	Datanascimento date,
	Biografia text NULL,
	CONSTRAINT PK_Autor PRIMARY KEY (AutorID)
)
;

CREATE TABLE AutorPublicacao
(
	PublicacaoID integer NOT NULL,
	AutorID integer NOT NULL,
	CONSTRAINT PK_AutorPublicacao PRIMARY KEY (PublicacaoID,AutorID)
)
;

CREATE TABLE Carrinho
(
	CarrinhoID SERIAL,
	Datacriacao timestamp NOT NULL,
	Subtotal real,
	CONSTRAINT PK_Carrinho PRIMARY KEY (CarrinhoID)
)
;

CREATE TABLE Cartaocredito
(
	CartaocreditoID integer NOT NULL,
	Tipo TipoCartao NOT NULL,
	Numero varchar(50) NOT NULL,
	Validade varchar(50) NOT NULL,
	Cvv varchar(3) NOT NULL,
	CONSTRAINT PK_Cartaocredito PRIMARY KEY (CartaocreditoID)
)
;

CREATE TABLE Cartaocreditocliente
(
	CartaocreditoclienteID SERIAL,
	ClienteID integer NOT NULL,
	Tipo TipoCartao NOT NULL,
	Numero varchar(50) NOT NULL,
	Validade varchar(50) NOT NULL,
	Cvv integer NOT NULL,
	CONSTRAINT PK_Cartaocreditocliente PRIMARY KEY (CartaocreditoclienteID)
)
;

CREATE TABLE Categoria
(
	CategoriaID SERIAL,
	PrimaveraCategoriaID varchar(10) NOT NULL,
	Nome varchar(50) NOT NULL,
	CONSTRAINT PK_Categoria PRIMARY KEY (CategoriaID),
	CONSTRAINT categoria_nome_key UNIQUE (Nome)
)
;

CREATE TABLE Cliente
(
	ClienteID SERIAL,
	PaisID Integer NULL,
	CarrinhoID integer NULL,
	Nome varchar(100) NOT NULL,
	Genero varchar(50) NOT NULL,
	Datanascimento date NOT NULL,
	Username varchar(50) NOT NULL,
	Password varchar(200) NOT NULL,
	Ativo boolean NOT NULL DEFAULT TRUE,
	Dataregisto timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Datacancelamento timestamp NULL,
	Telefone varchar(50) NULL,
	Email varchar(50) NOT NULL,
	Nif varchar(50) NOT NULL,
	Idade integer NOT NULL,
	CONSTRAINT PK_Cliente PRIMARY KEY (ClienteID),
	CONSTRAINT cliente_email_key UNIQUE (Email),
	CONSTRAINT cliente_nif_key UNIQUE (Nif),
	CONSTRAINT cliente_username_key UNIQUE (Username),
	CONSTRAINT CK_Cliente_dataCessacao CHECK (Datacancelamento > Dataregisto),
	CONSTRAINT cliente_password_length CHECK (length(Password) > 6)
)
;

CREATE TABLE Codigopostal
(
	CodigopostalID SERIAL,
	LocalidadeID integer NOT NULL,
	Cod1 varchar(4) NOT NULL,
	Cod2 varchar(3) NOT NULL,
	CONSTRAINT PK_Codigopostal PRIMARY KEY (CodigopostalID)
)
;

CREATE TABLE Comentario
(
	ComentarioID SERIAL,
	ClienteID integer NOT NULL,
	PublicacaoID integer NOT NULL,
	Data timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Classificacao integer NOT NULL,
	Texto text NOT NULL,
	CONSTRAINT PK_Comentario PRIMARY KEY (ComentarioID),
	CONSTRAINT CK_Comentario_classificacao CHECK (Classificacao BETWEEN 1 AND 5),
	CONSTRAINT CK_Comentario_texto_comprimento CHECK (char_length(Texto) <= 300)
)
;

CREATE TABLE Editora
(
	EditoraID SERIAL,
	PrimaveraEditoraID varchar(10) NOT NULL,
	Nome varchar(50) NOT NULL,
	CONSTRAINT PK_Editora PRIMARY KEY (EditoraID)
)
;

CREATE TABLE Encomenda
(
	EncomendaID SERIAL,
	PrimaveraEncomendaID varchar(10) NULL,
	PrimaveraFaturaSerie varchar(5) NULL,
	PrimaveraFaturaID varchar(10) NULL,
	PrimaveraReciboSerie varchar(5) NULL,
	PrimaveraReciboID varchar(10) NULL,
	PrimaveraGuiaRemessaID varchar(10) NULL,
	PrimaveraNotaCreditoSerie varchar(5) NULL,
	PrimaveraNotaCreditoID varchar(10) NULL,
	ClienteID integer NOT NULL,
	MoradaFaturacaoID integer NOT NULL,
	MoradaEnvioID integer NOT NULL,
	InformacaofaturacaoID integer NULL,
	Data timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Estado EstadoEncomenda NOT NULL DEFAULT 'Em processamento',
	CONSTRAINT PK_Encomenda PRIMARY KEY (EncomendaID)
)
;

CREATE TABLE Funcionario
(
	FuncionarioID SERIAL,
	MoradaID integer NOT NULL,
	PaisID integer NOT NULL,
	Nome varchar(100) NOT NULL,
	Genero varchar(50) NOT NULL,
	Datanascimento date NOT NULL,
	Username varchar(50) NOT NULL,
	Password varchar(50) NOT NULL,
	Ativo boolean NOT NULL DEFAULT TRUE,
	Dataadmissao timestamp NOT NULL,
	Datacessacao timestamp NULL,
	Telefone varchar(50) NOT NULL,
	Email varchar(50) NOT NULL,
	Nif varchar(50) NOT NULL,
	Cartaocidadao varchar(50) NOT NULL,
	Idade integer NOT NULL,
	CONSTRAINT PK_Funcionario PRIMARY KEY (FuncionarioID),
	CONSTRAINT funcionario_email_key UNIQUE (Email),
	CONSTRAINT funcionario_cartaocidadao_key UNIQUE (Cartaocidadao),
	CONSTRAINT funcionario_nif_key UNIQUE (Nif),
	CONSTRAINT funcionario_username_key UNIQUE (Username),
	CONSTRAINT CK_Funcionario_dataCessacao CHECK (Datacessacao > Dataadmissao),
	CONSTRAINT funcionario_password_length CHECK (length(Password) > 6)
)
;

CREATE TABLE Imagem
(
	ImagemID SERIAL NOT NULL,
	PublicacaoID integer NOT NULL,
	Nome varchar(100) NOT NULL,
	Url varchar(300) NOT NULL,
	CONSTRAINT PK_Imagem PRIMARY KEY (ImagemID)
)
;

CREATE TABLE Informacaofaturacao
(
	InformacaofaturacaoID SERIAL,
	MetodopagamentoID integer NULL,
	Portes real NULL,
	Iva decimal(5,2) NULL,
	Total real NULL,
	CONSTRAINT PK_Informacaofaturacao PRIMARY KEY (InformacaofaturacaoID)
)
;

CREATE TABLE Localidade
(
	LocalidadeID SERIAL,
	PaisID integer NOT NULL,
	Nome varchar(100) NOT NULL,
	CONSTRAINT PK_Localidade PRIMARY KEY (LocalidadeID)
)
;

CREATE TABLE Login
(
	LoginID SERIAL,
	AdministradorID integer NULL,
	FuncionarioID integer NULL,
	ClienteID integer NULL,
	Data timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT PK_Login PRIMARY KEY (LoginID)
)
;

CREATE TABLE Metodopagamento
(
	MetodopagamentoID SERIAL,
	Tipo varchar(50) NOT NULL,
	CONSTRAINT PK_Metodopagamento PRIMARY KEY (MetodopagamentoID),
	CONSTRAINT metodopagamento_tipo_key UNIQUE (Tipo)
)
;

CREATE TABLE Morada
(
	MoradaID SERIAL,
	CodigopostalID integer NOT NULL,
	Rua varchar(100) NOT NULL,
	CONSTRAINT PK_Morada PRIMARY KEY (MoradaID)
)
;

CREATE TABLE MoradaEnvio
(
	MoradaID integer NOT NULL,
	ClienteID integer NOT NULL,
	CONSTRAINT PK_MoradaEnvio PRIMARY KEY (MoradaID,ClienteID)
)
;

CREATE TABLE MoradaFaturacao
(
	MoradaID integer NOT NULL,
	ClienteID integer NOT NULL,
	CONSTRAINT PK_Morada_Faturacao PRIMARY KEY (MoradaID,ClienteID)
)
;

CREATE TABLE Multibanco
(
	MultibancoID integer NOT NULL,
	Entidade varchar(50) NOT NULL,
	Referencia varchar(50) NOT NULL,
	CONSTRAINT PK_Multibanco PRIMARY KEY (MultibancoID)
)
;

CREATE TABLE Pais
(
	PaisID SERIAL,
	Nome varchar(100) NOT NULL,
	CONSTRAINT PK_Pais PRIMARY KEY (PaisID),
	CONSTRAINT pais_nome_key UNIQUE (Nome)
)
;

CREATE TABLE Perguntautilizador
(
	PerguntautilizadorID SERIAL,
	Data timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Nome varchar(100) NOT NULL,
	Email varchar(50) NOT NULL,
	Mensagem text NOT NULL,
	Respondido boolean NOT NULL DEFAULT FALSE,
	CONSTRAINT PK_Perguntautilizador PRIMARY KEY (PerguntautilizadorID)
)
;

CREATE TABLE Pesquisa
(
	PesquisaID SERIAL,
	Data timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Expressao varchar(100) NOT NULL,
	CONSTRAINT PK_Pesquisa PRIMARY KEY (PesquisaID)
)
;

CREATE TABLE Publicacao
(
	PublicacaoID SERIAL,
	PrimaveraID varchar(10) NOT NULL,
	EditoraID integer NOT NULL,
	SubcategoriaID integer NOT NULL,
	Titulo varchar(100) NOT NULL,
	Datapublicacao date NULL,
	Codigobarras varchar(13) NULL,
	Descricao text NULL,
	Paginas integer NULL,
	Peso real NULL,
	Iva decimal(5,2) NOT NULL,
	Preco real NOT NULL,
	Precopromocional real NULL,
	Novidade boolean NOT NULL DEFAULT TRUE,
	Stock integer NULL,
	Edicao varchar(50) NULL,
	Periodicidade Periodicidade NULL,
	Isbn varchar(100) NULL,
	CONSTRAINT PK_Publicacao PRIMARY KEY (PublicacaoID),
	CONSTRAINT publicacao_codigobarras_key UNIQUE (Codigobarras),
	CONSTRAINT CK_Publicacao_precopromocional CHECK (Precopromocional <= Preco)
)
;

CREATE TABLE Publicacaocarrinho
(
	PublicacaoID integer NOT NULL,
	CarrinhoID integer NOT NULL,
	Quantidade integer NOT NULL,
	CONSTRAINT PK_Publicacaocarrinho PRIMARY KEY (PublicacaoID,CarrinhoID),
	CONSTRAINT CK_Publicacaocarrinho_quantidade CHECK (Quantidade >= 1)
)
;

CREATE TABLE Publicacaoencomenda
(
	PublicacaoID Integer NOT NULL,
	EncomendaID Integer NOT NULL,
	Preco real NOT NULL,
	Quantidade integer NOT NULL DEFAULT 1,
	CONSTRAINT PK_Publicacaoencomenda PRIMARY KEY (PublicacaoID,EncomendaID),
	CONSTRAINT CK_Publicacaoencomenda_preco CHECK (Preco >= 0),
	CONSTRAINT CK_Publicacaoencomenda_quantidade CHECK (Quantidade >= 1)
)
;

CREATE TABLE PublicacaoWishList
(
	WishlistID integer NOT NULL,
	PublicacaoID integer NOT NULL,
	CONSTRAINT PK_PublicacaoWishList PRIMARY KEY (WishlistID,PublicacaoID)
)
;

CREATE TABLE Subcategoria
(
	SubcategoriaID SERIAL,
	PrimaveraSubCategoriaID varchar(10) NOT NULL,
	CategoriaID integer NOT NULL,
	PrimaveraCategoriaID varchar(10) NOT NULL,
	Nome varchar(50) NOT NULL,
	CONSTRAINT PK_Subcategoria PRIMARY KEY (SubcategoriaID)
)
;

CREATE TABLE Wishlist
(
	WishlistID SERIAL,
	ClienteID integer NOT NULL,
	Nome varchar(50) NOT NULL,
	CONSTRAINT PK_Wishlist PRIMARY KEY (WishlistID)
)
;

/* Create Indexes */
CREATE INDEX idx_publicacao_titulo_descricao ON Publicacao
USING gin((setweight(to_tsvector('portuguese', titulo),'A') ||
	setweight(to_tsvector('portuguese', descricao),'B')))
;

CREATE INDEX idx_publicacao_subcategoria ON Publicacao (SubcategoriaID)
;

CREATE INDEX idx_publicacao_stock ON Publicacao (Stock)
;

CREATE INDEX idx_encomenda_cliente ON Encomenda (ClienteID)
;

CREATE INDEX idx_encomenda_estado ON Encomenda (Estado)
;

CREATE INDEX idx_login_cliente ON Login (ClienteID)
;

CREATE INDEX idx_cliente_carrinho ON Cliente (CarrinhoID)
;

CREATE INDEX idx_cliente_nome ON Cliente (Nome)
;

CREATE INDEX idx_subcategoria ON Subcategoria (SubcategoriaID)
;

CREATE INDEX idx_categoria ON Categoria (CategoriaID)
;
/* Create Trigger Funtions */

CREATE OR REPLACE FUNCTION insert_publicacao()
RETURNS TRIGGER
AS $$
BEGIN
	NEW.iva := NEW.preco-(NEW.preco/1.23);

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_cliente()
RETURNS TRIGGER
AS $$
BEGIN
	INSERT INTO Carrinho(Datacriacao)
	VALUES(CURRENT_TIMESTAMP)
	RETURNING CarrinhoID
	INTO NEW.CarrinhoID;

	NEW.idade := date_part('year', age(NEW.Datanascimento));

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_funcionario()
RETURNS TRIGGER
AS $$
BEGIN
	NEW.idade := date_part('year', age(NEW.Datanascimento));

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_encomenda()
RETURNS TRIGGER
AS $$
BEGIN
	INSERT INTO Informacaofaturacao(InformacaofaturacaoID)
	VALUES(DEFAULT)
	RETURNING InformacaofaturacaoID
	INTO NEW.InformacaofaturacaoID;

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_publicacaoencomenda()
RETURNS TRIGGER
AS $$
BEGIN
	NEW.preco = (SELECT preco
				FROM Publicacao
				WHERE publicacaoID = NEW.publicacaoID);

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_imagem()
RETURNS TRIGGER
AS $$
BEGIN
	NEW.nome := (SELECT titulo
					FROM Publicacao
					WHERE publicacaoID=NEW.publicacaoID);

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_comentario()
RETURNS TRIGGER
AS $$
BEGIN
	IF NEW.PublicacaoID NOT IN (SELECT Publicacaoencomenda.Publicacaoid
									FROM encomenda JOIN Cliente ON Encomenda.clienteid = Cliente.clienteid JOIN Publicacaoencomenda ON Publicacaoencomenda.encomendaid = Encomenda.encomendaid
									WHERE NEW.ClienteID = Cliente.ClienteID)
	THEN
		RAISE EXCEPTION 'Cliente nao comprou publicacao que pretende comentar';
	END IF;

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_multibanco()
RETURNS TRIGGER
AS $$
BEGIN
	IF NEW.MultibancoID IN (SELECT Cartaocredito.CartaocreditoID
							FROM Cartaocredito)
	THEN
		RAISE EXCEPTION 'MultibancoID já se encontra atribuido a CartaocreditoID';
	ELSE
		RETURN NEW;
	END IF;

END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insert_cartaocredito()
RETURNS TRIGGER
AS $$
BEGIN
	IF NEW.CartaocreditoID IN (SELECT MultibancoID
								FROM Multibanco)
	THEN
		RAISE EXCEPTION 'CartaocreditoID já se encontra atribuido a MultibancoID';
	ELSE
		RETURN NEW;
	END IF;

END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_informacaoFaturacao()
RETURNS TRIGGER
AS $$
DECLARE newtotal INTEGER;
BEGIN

	SELECT SUM(preco*quantidade) INTO newtotal
						FROM Publicacaoencomenda
						WHERE encomendaID = NEW.encomendaID;

	UPDATE Informacaofaturacao
	SET total=newtotal,
		portes=(CASE WHEN total <= 30 THEN 2.99
						ELSE 0.00 END),
		iva=newtotal-(newtotal/1.23)
	WHERE informacaoFaturacaoID = (SELECT InformacaofaturacaoID
									FROM Encomenda
									WHERE encomendaID = NEW.encomendaID);

	RETURN NULL;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_subtotalcarrinho()
RETURNS TRIGGER
AS $$
BEGIN
	UPDATE Carrinho
	SET Subtotal=(SELECT SUM(Publicacao.precopromocional*Publicacaocarrinho.quantidade)
						FROM Publicacaocarrinho, Publicacao
						WHERE Publicacaocarrinho.CarrinhoID = NEW.CarrinhoID AND Publicacao.PublicacaoID=Publicacaocarrinho.PublicacaoID)
	WHERE CarrinhoID = NEW.CarrinhoID;

	RETURN NULL;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_subtotalcarrinho_on_delete()
RETURNS TRIGGER
AS $$
BEGIN
	UPDATE Carrinho
	SET Subtotal=(SELECT SUM(Publicacao.precopromocional*Publicacaocarrinho.quantidade)
						FROM Publicacaocarrinho, Publicacao
						WHERE Publicacaocarrinho.CarrinhoID = OLD.CarrinhoID AND Publicacao.PublicacaoID=Publicacaocarrinho.PublicacaoID)
	WHERE CarrinhoID = OLD.CarrinhoID;

	RETURN NULL;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_stock_on_publicacao()
RETURNS TRIGGER
AS $$
BEGIN
	UPDATE Publicacao
	SET Stock=(SELECT Stock
			   FROM ArmazemPublicacao
			   WHERE ArmazemID = 3 AND PublicacaoID=NEW.PublicacaoID)
	WHERE PublicacaoID = NEW.PublicacaoID;

	RETURN NULL;
END $$ LANGUAGE plpgsql;

/* Create Trigger */

CREATE TRIGGER insert_publicacao_trigger
BEFORE INSERT OR UPDATE ON Publicacao
FOR EACH ROW
	EXECUTE PROCEDURE insert_publicacao();

CREATE TRIGGER insert_cliente_trigger
BEFORE INSERT ON Cliente
FOR EACH ROW
	EXECUTE PROCEDURE insert_cliente();

CREATE TRIGGER insert_funcionario_trigger
BEFORE INSERT OR UPDATE ON Funcionario
FOR EACH ROW
	EXECUTE PROCEDURE insert_funcionario();

CREATE TRIGGER insert_encomenda_trigger
BEFORE INSERT ON Encomenda
FOR EACH ROW
	EXECUTE PROCEDURE insert_encomenda();

CREATE TRIGGER insert_publicacaoencomenda_trigger
BEFORE INSERT OR UPDATE ON Publicacaoencomenda
FOR EACH ROW
	EXECUTE PROCEDURE insert_publicacaoencomenda();

CREATE TRIGGER insert_imagem_trigger
BEFORE INSERT OR UPDATE ON Imagem
FOR EACH ROW
	EXECUTE PROCEDURE insert_imagem();

CREATE TRIGGER insert_comentario_trigger
BEFORE INSERT ON Comentario
FOR EACH ROW
	EXECUTE PROCEDURE insert_comentario();

CREATE TRIGGER insert_multibanco_trigger
BEFORE INSERT ON Multibanco
FOR EACH ROW
	EXECUTE PROCEDURE insert_multibanco();

CREATE TRIGGER insert_cartaocredito_trigger
BEFORE INSERT ON Cartaocredito
FOR EACH ROW
	EXECUTE PROCEDURE insert_cartaocredito();

CREATE TRIGGER update_informacaoFaturacao_trigger
AFTER INSERT OR UPDATE ON Publicacaoencomenda
FOR EACH ROW
	EXECUTE PROCEDURE update_informacaoFaturacao();

CREATE TRIGGER update_subtotalcarrinho_trigger
AFTER INSERT OR UPDATE ON Publicacaocarrinho
FOR EACH ROW
	EXECUTE PROCEDURE update_subtotalcarrinho();

CREATE TRIGGER update_subtotalcarrinho_on_delete_trigger
AFTER DELETE ON Publicacaocarrinho
FOR EACH ROW
	EXECUTE PROCEDURE update_subtotalcarrinho_on_delete();

CREATE TRIGGER update_publicacaostock_on_update_armazempublicacao_trigger
AFTER UPDATE ON ArmazemPublicacao
FOR EACH ROW
	EXECUTE PROCEDURE update_stock_on_publicacao();
	
/* Create Foreign Key Constraints */

ALTER TABLE Administrador ADD CONSTRAINT FK_Administrador_nacionalidade
	FOREIGN KEY (PaisID) REFERENCES Pais (PaisID)
;

ALTER TABLE ArmazemPublicacao ADD CONSTRAINT FK_Armazem_ID
	FOREIGN KEY (ArmazemID) REFERENCES Armazem (ArmazemID)
;

ALTER TABLE ArmazemPublicacao ADD CONSTRAINT FK_Armazem_Publicacao_ID
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE Autor ADD CONSTRAINT FK_Autor_nacionalidade
	FOREIGN KEY (PaisID) REFERENCES Pais (PaisID)
;

ALTER TABLE AutorPublicacao ADD CONSTRAINT FK_escrito_por_Publicacao
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE AutorPublicacao ADD CONSTRAINT FK_escrito_por_Autor
	FOREIGN KEY (AutorID) REFERENCES Autor (AutorID)
;

ALTER TABLE Cartaocredito ADD CONSTRAINT FK_CartaoCredito_InformacaoFaturacao
	FOREIGN KEY (CartaocreditoID) REFERENCES Informacaofaturacao (InformacaofaturacaoID)
;

ALTER TABLE Cartaocreditocliente ADD CONSTRAINT FK_CartaoCreditoCliente_possui
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_Carrinho
	FOREIGN KEY (CarrinhoID) REFERENCES Carrinho (CarrinhoID)
;

ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_ncaionalidade
	FOREIGN KEY (PaisID) REFERENCES Pais (PaisID)
;

ALTER TABLE Codigopostal ADD CONSTRAINT FK_Codigopostal_Localidade
	FOREIGN KEY (LocalidadeID) REFERENCES Localidade (LocalidadeID)
;

ALTER TABLE Comentario ADD CONSTRAINT FK_Comentario_feito_por
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

ALTER TABLE Comentario ADD CONSTRAINT FK_Comentario_relativo_a
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE Encomenda ADD CONSTRAINT FK_Encomenda_feita_por
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

ALTER TABLE Encomenda ADD CONSTRAINT FK_Encomenda_morada_envio
	FOREIGN KEY (MoradaEnvioID) REFERENCES Morada (MoradaID)
;

ALTER TABLE Encomenda ADD CONSTRAINT FK_Encomenda_morada_faturacao
	FOREIGN KEY (MoradaFaturacaoID) REFERENCES Morada (MoradaID)
;

ALTER TABLE Encomenda ADD CONSTRAINT FK_Encomenda_referente_a
	FOREIGN KEY (InformacaofaturacaoID) REFERENCES Informacaofaturacao (InformacaofaturacaoID)
;

ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario_nacionalidade
	FOREIGN KEY (PaisID) REFERENCES Pais (PaisID)
;

ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario_morada_de
	FOREIGN KEY (MoradaID) REFERENCES Morada (MoradaID)
;

ALTER TABLE Imagem ADD CONSTRAINT FK_Imagem_ilustrada_por
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE Informacaofaturacao ADD CONSTRAINT FK_InformacaoFaturacao_associado_a
	FOREIGN KEY (MetodopagamentoID) REFERENCES Metodopagamento (MetodopagamentoID)
;

ALTER TABLE Localidade ADD CONSTRAINT FK_Localidade_pertence_a
	FOREIGN KEY (PaisID) REFERENCES Pais (PaisID)
;

ALTER TABLE Login ADD CONSTRAINT FK_Login_Administrador
	FOREIGN KEY (AdministradorID) REFERENCES Administrador (AdministradorID)
;

ALTER TABLE Login ADD CONSTRAINT FK_Login_Cliente
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

ALTER TABLE Login ADD CONSTRAINT FK_Login_Funcionario
	FOREIGN KEY (FuncionarioID) REFERENCES Funcionario (FuncionarioID)
;

ALTER TABLE Morada ADD CONSTRAINT FK_Morada_pertence_a
	FOREIGN KEY (CodigopostalID) REFERENCES Codigopostal (CodigopostalID)
;

ALTER TABLE MoradaEnvio ADD CONSTRAINT FK_morada_envio_Morada
	FOREIGN KEY (MoradaID) REFERENCES Morada (MoradaID)
;

ALTER TABLE MoradaEnvio ADD CONSTRAINT FK_morada_envio_Cliente
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

ALTER TABLE MoradaFaturacao ADD CONSTRAINT FK_morada_faturacao_Cliente
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

ALTER TABLE MoradaFaturacao ADD CONSTRAINT FK_morada_faturacao_Morada
	FOREIGN KEY (MoradaID) REFERENCES Morada (MoradaID)
;

ALTER TABLE Multibanco ADD CONSTRAINT FK_Multibanco_InformacaoFaturacao
	FOREIGN KEY (MultibancoID) REFERENCES Informacaofaturacao (InformacaofaturacaoID)
;

ALTER TABLE Publicacao ADD CONSTRAINT FK_Publicacao_editado_por
	FOREIGN KEY (EditoraID) REFERENCES Editora (EditoraID)
;

ALTER TABLE Publicacao ADD CONSTRAINT FK_Publicacao_pertence_a
	FOREIGN KEY (SubcategoriaID) REFERENCES Subcategoria (SubcategoriaID)
;

ALTER TABLE Publicacaocarrinho ADD CONSTRAINT FK_PublicacaoCarrinho_Publicacao
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE Publicacaocarrinho ADD CONSTRAINT FK_PublicacaoCarrinho_Carrinho
	FOREIGN KEY (CarrinhoID) REFERENCES Carrinho (CarrinhoID)
;

ALTER TABLE Publicacaoencomenda ADD CONSTRAINT FK_PublicacaoEncomenda_Publicacao
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE Publicacaoencomenda ADD CONSTRAINT FK_PublicacaoEncomenda_Encomenda
	FOREIGN KEY (EncomendaID) REFERENCES Encomenda (EncomendaID)
;

ALTER TABLE PublicacaoWishList ADD CONSTRAINT FK_constituida_por_WishList
	FOREIGN KEY (WishlistID) REFERENCES Wishlist (WishlistID)
;

ALTER TABLE PublicacaoWishList ADD CONSTRAINT FK_constituda_por_Publicacao
	FOREIGN KEY (PublicacaoID) REFERENCES Publicacao (PublicacaoID)
;

ALTER TABLE Subcategoria ADD CONSTRAINT FK_Subcategoria_Categoria
	FOREIGN KEY (CategoriaID) REFERENCES Categoria (CategoriaID)
;

ALTER TABLE Wishlist ADD CONSTRAINT FK_WishList_possui
	FOREIGN KEY (ClienteID) REFERENCES Cliente (ClienteID)
;

/* Inserts */

/* ------------------------------------------------------ R10 Categoria ------------------------------------------------------ */
INSERT INTO Categoria (PrimaveraCategoriaID,nome) VALUES ('LIVROS','Livros');
INSERT INTO Categoria (PrimaveraCategoriaID,nome) VALUES ('LIVROS ESC','Livros Escolares');
INSERT INTO Categoria (PrimaveraCategoriaID,nome) VALUES ('APOIO ESC','Apoio Escolar');
INSERT INTO Categoria (PrimaveraCategoriaID,nome) VALUES ('REVISTAS','Revistas');
INSERT INTO Categoria (PrimaveraCategoriaID,nome) VALUES ('DICENC','Dicionarios e Enciclopedias');
INSERT INTO Categoria (PrimaveraCategoriaID,nome) VALUES ('GTM','Guias Turisticos e Mapas');

/* ------------------------------------------------------ R9 SubCategoria ------------------------------------------------------ */
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ARTE',1,'LIVROS','Arte');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('BD',1,'LIVROS','Banda Desenhada');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('CEN',1,'LIVROS','Ciencias Exatas e Naturais');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('CSH',1,'LIVROS','Ciencias Sociais e Humanas');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('DL',1,'LIVROS','Desporto e Lazer');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('DIREITO',1,'LIVROS','Direito');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ENGENHARIA',1,'LIVROS','Engenharia');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('EE',1,'LIVROS','Ensino e Educacao');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('GV',1,'LIVROS','Gastronomia e Vinhos');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('GESTAO',1,'LIVROS','Gestao');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('HISTORIA',1,'LIVROS','Historia');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('INF',1,'LIVROS','Informatica');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('LITERATURA',1,'LIVROS','Literatura');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('MEDICINA',1,'LIVROS','Medicina');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('POLITICA',1,'LIVROS','Politica');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('RM',1,'LIVROS','Religião e Moral');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('SBE',1,'LIVROS','Saude e Bem Estar');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('1.º ANO',2,'LIVROS ESC','1.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('2.º ANO',2,'LIVROS ESC','2.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('3.º ANO',2,'LIVROS ESC','3.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('4.º ANO',2,'LIVROS ESC','4.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('5/6.º ANO',2,'LIVROS ESC','5.º e 6.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('7º/8º/9º',2,'LIVROS ESC','7.º, 8.º e 9.º ciclo');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ENS SEC',2,'LIVROS ESC','Ensino Secundario');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('1.º ANO',3,'APOIO ESC','1.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('2.º ANO',3,'APOIO ESC','2.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('3.º ANO',3,'APOIO ESC','3.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('4.º ANO',3,'APOIO ESC','4.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('5/6.º ANO',3,'APOIO ESC','5.º e 6.º ano');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('7º/8º/9º',3,'APOIO ESC','7.º, 8.º e 9.º ciclo');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ENS SEC',3,'APOIO ESC','Ensino Secundario');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('AGRICUL',4,'REVISTAS','Agricultura');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ARQ',4,'REVISTAS','Arquitetura');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ARTE',4,'REVISTAS','Arte');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('AUT',4,'REVISTAS','Automobilismo');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('AVIACAO',4,'REVISTAS','Aviação');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('CIENT',4,'REVISTAS','Científicas');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('CINEMA',4,'REVISTAS','Cinema');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('DECOR',4,'REVISTAS','Decoracao');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('DESPORTO',4,'REVISTAS','Desporto');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('DIREITO',4,'REVISTAS','Direito');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ECONOMIA',4,'REVISTAS','Economia');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('FOTOGRAFIA',4,'REVISTAS','Fotografia');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('HISTORIA',4,'REVISTAS','Historia');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('HUMOR',4,'REVISTAS','Humor');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('INFANTIS',4,'REVISTAS','Infantis');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('INF',4,'REVISTAS','Informatica');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('MODA',4,'REVISTAS','Moda');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('MUSICA',4,'REVISTAS','Musica');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('QC',4,'REVISTAS','Quebra-cabecas');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('TURISMO',4,'REVISTAS','Turismo');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('PORTUGUES',5,'DICENC','Portugues');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('INGLES',5,'DICENC','Ingles');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('FRANCES',5,'DICENC','Frances');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ALEMAO',5,'DICENC','Alemao');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ESPANHOL',5,'DICENC','Espanhol');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('AFRICA',6,'GTM','Africa');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('AMERICA',6,'GTM','America');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('ASIA',6,'GTM','Asia');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('EUROPA',6,'GTM','Europa');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('SOCIAL',4,'REVISTAS','Social');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('CULINARIA',4,'REVISTAS','Culinaria');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('LAZER',4,'REVISTAS','Lazer');
INSERT INTO SubCategoria (PrimaveraSubCategoriaID,categoriaID,PrimaveraCategoriaID,nome) VALUES ('REGIONAIS',4,'REVISTAS','Regionais');

/* ------------------------------------------------------ R8 Editora ------------------------------------------------------ */
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('CORAL','Coral Books');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('EGGILI','Editorial Gustavo Gili');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('GFSTUDIO','G. Floy Studio');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('GRADIVA','Gradiva');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('MARCADOR','Marcador');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('PERGAMINHO','Pergaminho');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('ESFLIVROS','A Esfera dos Livros');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('JACARANDA','Jacarandá Editora');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('EDAFRONTA','Edições Afrontamento');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('PORTOEDI','Porto Editora');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('FCA','FCA');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('PUBLIIND','Publindústria');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('VOGAIS','Vogais');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('EUROIMPALA','EuroImpala');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('EDPRESENCA','Editorial Presença');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('TOPBOOKS','Top Books');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('OBJECTIVA','Objectiva');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('GUERRAEPAZ','Editora Guerra & Paz');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('SEXTANTE','Sextante Editora (chancela)');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('LIDEL','Lidel');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('MCGRAWHILL','Mc Graw-Hill');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('NASCENTE','Nascente');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('LUCERNA','Lucerna');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('CENTROCURA','Centro de Cura');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('PRIMEBOOKS','Prime Books');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('GAILIVRO','Edições Gailivro');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('HORIZONTE','Livros Horizonte');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('EDCAMINHO','Editorial Caminho');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('EDMINERVA','Editorial Minerva');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('IDEIASLER','Ideias de Ler');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('AREALEDIT','Areal Editores');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('COFINA','Cofina');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('IMPRESA','Impresa');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('LONELYPGL','Lonely Planet Global Limited');
INSERT INTO Editora (PrimaveraEditoraID,nome) VALUES ('OFICINALVR','Oficina do Livro');

/* ------------------------------------------------------ R1 Publicação ------------------------------------------------------ */
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0001',1,1,'Arte Portuguesa no Século XX','01/01/2017','3230014481474','Bernardo Pinto de Almeida, aquele que muitos consideram o mais importante crítico de arte da actualidade, oferece-nos aqui uma larga visão panorâmica e solidamente fundamentada da recepção nacional aos movimentos artísticos do século XX e dos seus protagonistas. De agora em diante esta obra, ilustrada por centenas de imagens, muitas delas quase inéditas, será «a» História da Arte Portuguesa do Século XX, uma referência incontornável para artistas, coleccionadores, estudiosos e amantes de arte.',496,0.496,59.99,53.91,TRUE,3,'primeira',NULL,'9789898851086');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0002',2,1,'Guia Essencial Para o Estudante de Fotografia Profissional','01/01/2017','2192558647840','Capturar e compartilhar imagens fotográficas são práticas bastante comuns atualmente, que estão ao alcance de todos. No entanto, neste universo digital do século xxi, no qual milhões de pessoas se comunicam todos os dias por meio de fotografias, nem sempre é fácil saber quais conhecimentos um fotógrafo deve reunir para conseguir se distinguir dos demais como profissional.',192,0.192,21.20,19.08,TRUE,11,'primeira',NULL,'9788584520848');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0003',3,2,'SAGA','01/01/2017','5086812095806','Fantasia e ficção científica - e sexo, política, traição, morte, amor verdadeiro e reality shows - juntam-se como nunca antes neste épico subversivo e provocante do escritor Brian K. Vaughan e da artista Fiona Staples.',152,0.152,10.99,9.89,TRUE,10,'primeira',NULL,'9788416510290');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0004',3,2,'Velvet - Vol. 2','01/01/2017','4220053295829','Dos criadores de Capitão América: O Soldado de Inverno, uma das mais brilhantes séries de espionagem em banda desenhada.',128,0.128,9.99,8.99,FALSE,13,'segunda',NULL,'9788416510269');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0005',4,3,'Ciência Cosmológica','01/01/2016','2565704760882','Uma viagem até à moderna ciência do Universo. A ciência, como actividade humana socialmente relevante, é relativamente recente. Contudo, a cosmologia, como visão do Universo ligada a construções mágicas e religiosas, é bem mais antiga.',192,0.192,15.00,15.00,TRUE,12,'primeira',NULL,'9789896167165');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0006',5,3,'O Livro da Ciência','01/01/2017','3205973219926','MAIS UM LIVRO DA COLEÇÃO GRANDES IDEIAS Será que o Universo começou com um Big Bang? A luz é uma onda, uma partícula - ou ambas? Será que somos a causa do aquecimento global? É possível uma Teoria de Tudo?',352,0.352,24.50,22.05,FALSE,4,'primeira',NULL,'9789897542664');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0007',6,4,'Inteligência Multifocal','01/01/2017','5539924172326','Este livro pretende levar o leitor a caminhar para dentro de si mesmo e a expandir o mundo das ideias sobre a mente humana, a construção de pensamentos e a formação de pensadores.',360,0.360,16.60,14.94,FALSE,3,'primeira',NULL,'9789896874056');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0008',7,4,'Amor Zero','01/01/2017','1638761835655','Os psicopatas não têm de ser assassinos, mas estão entre nós e podem matar a nossa autoestima. Conheça os sinais de alerta para não cair no poço sem fundo do amor zero. O amor transforma-se num inferno quando o homem ou a mulher por quem nos apaixonámos deixa cair a máscara e revela-se um psicopata - com zero remorsos, zero empatia, zero compaixão, zero lealdade.',256,0.256,17.90,16.11,TRUE,8,'primeira',NULL,'9789896268060');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0009',8,5,'Labirintos Quase Impossíveis','01/01/2017','6444561682733','Elaborado pelo aclamado autor bestseller Gareth Moore, este livro reúne 30 complexos e desafiantes labirintos para resolver. Tem tanto de divertido como de diabólico, mas para os apaixonados por quebra-cabeças, nada lhes trará mais satisfação do que completar os desafios propostos.',84,0.084,11.90,10.71,TRUE,13,'primeira',NULL,'9789898857064');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0010',9,5,'Estética e Desporto','01/01/2017','2586530428762','Lembro-me de quando a rivalidade entre Roger Federer e Rafael Nadal estava no auge ter utilizado uma hipérbole para sublinhar as diferenças essenciais nos duelos entre ambos - o Homem do Renascimento contra o Cro-Magnon.',256,0.256,12.00,10.80,FALSE,3,'primeira',NULL,'9789723615388');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0011',10,6,'Condomínio','01/01/2017','8871263074269','A legislação relativa aos condomínios encontra-se vertida no Código Civil e em vários diplomas avulsos, razão pela qual nem sempre é simples dispor de todo o material de consulta prático e fidedigno nesta área.',192,0.192,12.90,11.61,TRUE,8,'decima',NULL,'978-972-0-02009-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0012',10,6,'Códigos Penal e Processo Penal','01/01/2017','3739359213965','É nosso objetivo oferecer aos profissionais do Direito uma seleção dos textos mais relevantes, devidamente consolidados e organizados, tendo em conta as últimas alterações legais.',840,0.840,22.00,19.80,FALSE,4,'oitava',NULL,'978-972-0-00048-4');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0013',11,7,'Programação de CNC para Torno e Fresadora','01/01/2016','2411708370019','Expõe os principais conceitos e a maquinação de peças em várias linguagens. Exercícios propostos e resolvidos para uma autoaprendizagem. Para profissionais, formação profissional e ensino superior.',368,0.368,26.65,23.99,TRUE,5,'primeira',NULL,'9789727228430');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0014',12,7,'Guia de Aplicações de Gestão de Energia e Eficiência Energética','01/01/2016','8478814991251','A energia é um bem que deve ser optimizado a um custo cada vez mais relevante. É importante maximizar a sua produção eficiente e racionalizar o seu consumo.',527,0.527,33.00,33.00,FALSE,11,'terceira',NULL,'9789897231544');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0015',13,8,'Adolescência, os Anos da Mudança','01/01/2016','6323951187888','Viver com um adolescente é um dos maiores desafios para qualquer pai. É estimulante mas também pode ser assustador! Este é o guia ideal para si e para os seus filhos.',352,0.352,16.99,15.29,FALSE,12,'primeira',NULL,'9789898843630');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0016',7,8,'Os Nossos Adolescentes e a Droga','01/01/2016','6740535325490','Num registo a que já nos habituou, Mário Cordeiro fala de um tema sensível, mas o qual é urgente discutir: os adolescentes e a droga.',344,0.344,19.90,17.91,TRUE,3,'primeira',NULL,'9789896267834');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0017',14,9,'As Receitas da Minha Querida Mãe','01/01/2017','7079696892385','As Receitas da Minha Querida Mãe é uma obra onde são reveladas as preferências gastronómicas destas madeirenses muito acarinhadas pelos seguidores.',120,0.120,18.00,16.20,FALSE,5,'primeira',NULL,'9789892404844');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0018',14,9,'Deixei de Comer Carne. E Agora?','01/01/2017','6735213228700','Tomou a decisão de deixar comer carne e depois de olhar para os produtos, denominados vegetarianos, fica sem saber o que fazer? É mais fácil do que imagina!',128,0.128,16.00,14.40,FALSE,13,'primeira',NULL,'9789892404851');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0019',15,10,'Tenha Um Bom Dia!','01/01/2017','6422249201404','Caroline Webb, economista e antiga partner da consultora McKinsey, mostra aos leitores as mais recentes descobertas no campo da economia comportamental, da psicologia e da neurociência que poderão alterar a sua vida.',392,0.392,18.95,17.06,FALSE,4,'primeira',NULL,'9789722358989');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0020',16,10,'Atitude UAUme!','01/01/2017','9515343926026','O sucesso internacional deste top seller resulta da Atitude UAUme! ser um conceito inovador que explora que todos temos de impactar os outros positivamente através da SURPRESA!',304,0.304,15.99,14.39,FALSE,14,'primeira',NULL,'9789897060526');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0021',17,11,'Os Últimos Dias de Estaline','01/01/2017','6562631901643','Em 2017 celebram-se os 100 anos da Revolução Russa O colapso repentino de Estaline, que o leva à morte, em Março de 1953, foi tão dramático e misterioso como a sua vida.',336,0.336,24.90,22.41,FALSE,6,'primeira',NULL,'9789896651770');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0022',18,11,'Grandes Discursos da História','01/01/2017','8381412076092','Foram as palavras que Péricles gritou aos cidadãos de Atenas que fundaram a democracia? Foi o «Ich bin ein Berliner», essa emotiva frase de John Kennedy, que deu à parte livre de Berlim a força de resistir?',208,0.208,16.00,14.40,FALSE,5,'primeira',NULL,'9789897022630');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0023',11,12,'Desenvolvimento em Swift para iOS','01/01/2017','8203137094131','A linguagem Swift é uma linguagem open source com um elevado crescimento e que permite desenvolver aplicações em diversos contextos, nomeadamente aplicações iOS, watchOS, tvOS e OS X.',256,0.256,24.95,22.46,TRUE,14,'primeira',NULL,'9789727228591');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0024',11,12,'Android','01/01/2017','3237163641803','As necessidades diárias dos consumidores continuam fortemente ligadas aos dispositivos móveis, que se tornaram objetos essenciais na vida de qualquer um. Para responder a estas exigências do dia a dia, o desenvolvimento de aplicações para dispositivos Android continua a apresentar um forte crescimento.',192,0.192,19.95,17.96,TRUE,12,'primeira',NULL,'9789727228621');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0025',10,13,'O feitiço de Marraquexe','01/01/2017','5224243915040','No coração da histórica Medina de Marraquexe, entre os animados souks e bazares, encontra-se um grupo de europeus, desfrutando a tranquilidade de um riad.',416,0.416,17.70,15.93,FALSE,6,'primeira',NULL,'978-972-0-04803-5');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0026',19,13,'Para onde vão os gatos quando morrem?','01/01/2017','6972274592095','O regresso a Ataúro, terra da infância, «terra do nunca», é o início desta nova viagem ao revés, de Luís Cardoso, um romance veloz, poético e emotivo, que percorre a infância e a idade de formação do narrador, a diáspora, as lutas, as desilusões, as traições, as perdas, o regresso, cruzando-o com uma plêiade de personagens extraordinárias. Uma viagem que, naturalmente, corre ao lado da história de Timor Leste, com a fantasia e a ironia que marcam desde sempre a voz do autor e nos fazem suspirar por essas terras misteriosas e de aterradora beleza.',272,0.272,16.60,14.94,TRUE,3,'primeira',NULL,'978-989-676-190-5');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0027',20,14,'Protocolos de Medicina Materno-Fetal','01/01/2014','1457957759311','Nesta 3.ª edição dos Protocolos de Medicina Materno-Fetal foi feita uma cuidada revisão e atualização dos protocolos anteriormente publicados e incluídos 16 novos, respondendo aos desafios impostos pela evidência científica mais recente. Esta obra é fruto do trabalho de uma equipa de profissionais que incorpora o desejo de se manter viva a chama da vocação, a responsabilidade de dignificar a classe médica e de prestar serviço à comunidade.',296,0.296,24.95,24.95,TRUE,15,'terceira',NULL,'9789897520358');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0028',21,14,'Anatomia e Fisiologia de Seeley','01/01/2016','7037499773863','Anatomia e Fisiologia de Seeley acompanha a tendência atual do ensino integrado das ciências básicas da saúde, facilitando a aprendizagem e proporcionando uma visão multidisciplinar dos conteúdos apresentados.',1264,1.264,104.94,104.94,FALSE,6,'decima',NULL,'9788580555882');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0029',10,15,'Jorge Sampaio - Uma Biografia - 2.º volume','01/01/2017','5791462972012','Este segundo volume da biografia de Jorge Sampaio ocupa-se dos seus 16 anos como Presidente: na II Câmara Municipal de Lisboa e no Palácio de Belém.',1064,1.064,24.90,22.41,FALSE,11,'segunda',NULL,'978-972-0-04984-1');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0030',10,15,'Quinta-feira','01/01/2017','6142874300338','Tendo mantido até agora reservada parte importante da minha ação como Presidente da República, convicto de que essa era a melhor forma de defender o superior interesse nacional - e nunca tendo ocorrido fugas de informação para a comunicação social sobre o que se passou nos meus encontros com o Primeiro-Ministro e outros membros do Governo -, entendo que é altura de completar a prestação de contas aos Portugueses dando público testemunho de componentes relevantes da minha magistratura que são, em larga medida, desconhecidos dos cidadãos.',592,0.592,18.80,16.92,TRUE,10,'primeira',NULL,'978-972-0-04942-1');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0031',22,16,'O Amor É Contagioso','01/01/2016','1538275989525','O Amor É Contagioso é um convite a uma meditação profunda sobre os temas mais prementes da sociedade atual.',224,0.224,14.99,13.49,FALSE,8,'primeira',NULL,'9789898849434');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0032',23,16,'Deus ou Nada','01/01/2016','2951563092148','Nesta fascinante entrevista autobiográfica, Robert Sarah, um dos mais desassombrados cardeais da Igreja Católica, dá um testemunho ímpar da sua fé e comenta muitos dos acontecimentos, desafios e controvérsias das últimas décadas.',344,0.344,22.95,20.66,FALSE,15,'primeira',NULL,'9789898809261');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0033',24,17,'Manual de Tratamento - 250 Doenças','01/01/2016','8754155616174','Nascemos para sermos felizes, para termos conhecimento do nosso próprio corpo e estarmos saudáveis.',342,0.342,17.95,16.16,FALSE,7,'primeira',NULL,'9789899956926');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0034',25,17,'Chegar Novo a Velho - Receitas','01/01/2017','1990865252372','Depois do enorme sucesso do livro CHEGAR NOVO A VELHO, Manuel Pinto Coelho, o maior especialista português em anti-aging, apresenta um livro de receitas que seguem os princípios básicos que defende: uma alimentação promotora de hormonas, alcalina e paleolítica',176,0.176,17.50,15.75,TRUE,9,'primeira',NULL,'9789896553050');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0035',10,18,'Gosto de Matemática 1','01/01/2015','5320882212185','Gosto de Matemática é uma coleção especialmente criada para os alunos do 1.° ciclo do ensino básico praticarem o novo Programa de Matemática, alcançando as Metas Curriculares.',532,0.532,9.90,9.90,FALSE,8,'primeira',NULL,'978-972-0-14139-2');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0036',10,18,'Alfa - Adição e Subtração - 6-8 anos','01/01/2016','8004153322242','Este bloco contém exercícios para praticar a adição e a subtração que permitem: reforçar a compreensão das operações;treinar o cálculo mental;explicar e exercitar os respetivos algoritmos.',263,0.263,5.50,5.50,FALSE,15,'primeira',NULL,'978-972-0-10947-7');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0037',26,19,'Preparo-me para as Provas de Aferição - 2º Ano 2016/2017','01/01/2016','9778948328070','NA',52,0.052,7.50,6.75,TRUE,11,'primeira',NULL,'9789893201640');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0038',10,19,'Casos de Leitura - 1.º Ciclo','01/01/2017','7386725266511','Casos de Leitura é um caderno de apoio à aprendizagem da leitura e escrita, elaborado de acordo com as orientações programáticas em vigor para o 1.° Ciclo.',80,0.08,7.70,6.93,FALSE,3,'primeira',NULL,'978-972-0-17083-5');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0039',27,20,'Poemas da Mentira e da Verdade','01/01/2005','2651213145718','Livro recomendado para o 3º ano de escolaridade, destinado a leitura orientada.',34,0.034,9.51,9.51,FALSE,6,'primeira',NULL,'9789722410700');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0040',10,20,'A Gramática - Português - 1.º ciclo','01/01/2016','0982249097803','Esta é a gramática de referência para o 1.° Ciclo!',160,0.160,11.90,10.71,TRUE,4,'primeira',NULL,'978-972-0-11024-4');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0041',28,21,'O Beijo da Palavrinha','01/01/2008','2376391506248','Livro recomendado para o 4º ano de escolaridade, destinado a leitura autónoma.',32,0.032,12.90,12.90,TRUE,14,'primeira',NULL,'9789722120159');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0042',29,21,'Histórias do Arco da Velha','01/01/1900','0326452518593','Livro recomendado para o 4º ano de escolaridade, destinado a leitura orientada.',174,0.174,6.50,6.50,FALSE,5,'primeira',NULL,'9780009685507');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0043',28,22,'Chocolate à Chuva','15/07/2015','2676749386384','Livro recomendado para o 6º ano de escolaridade, destinado a leitura orientada.',192,0.192,11.00,11.00,FALSE,9,'primeira',NULL,'9789722100373');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0044',10,22,'Ulisses','01/01/2017','4406704142865','Livro recomendado para o 6º ano de escolaridade, destinado a leitura orientada.',80,0.080,11.90,10.71,FALSE,15,'primeira',NULL,'978-972-0-72657-5');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0045',10,23,'Gramática de Português - 3.º Ciclo','01/01/2017','8044997343834','Elaborada de raiz de acordo com o Programa e Metas Curriculares de Português do 3.° Ciclo, esta gramática é um instrumento de trabalho completo e de fácil consulta.',288,0.288,18.80,18.80,FALSE,13,'primeira',NULL,'978-972-0-30017-1');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0046',10,23,'Os Lusíadas','01/01/2015','3612976962916','A ação central da obra é a viagem de Vasco da Gama para a Índia. Dela se serve o poeta para nos oferecer a visão épica de toda a História de Portugal até à sua época, ora sendo ele o narrador, ora transferindo essa tarefa para figuras da viagem. Para outras figuras - as míticas - transfere os discursos que projetam a ação no futuro em forma profética.',288,0.288,6.60,6.60,TRUE,14,'primeira',NULL,'978-972-0-04956-8');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0047',10,24,'Preparação para o Exame Final Nacional 2017 - Português - 12.º Ano','01/01/2016','1520384702356','Este livro foi especialmente desenvolvido para os alunos dos 10.°, 11.° e 12.° anos que se encontram em fase de preparação para os Exames Finais Nacionais.',432,0.432,29.90,26.91,FALSE,3,'primeira',NULL,'978-972-0-00016-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0048',30,24,'Resumos - Memorial do Convento - José Saramago - Ensino Secundário','01/01/2017','6047312864156','Este estudo de Memorial do Convento pretende ajudar os alunos na sistematização dos aspetos temáticos e formais do romance saramaguiano, ao mesmo tempo que tenta promover um conhecimento mais alargado do universo de produção e divulgação da obra de José Saramago.',64,0.064,7.70,6.93,TRUE,11,'primeira',NULL,'978-972-0-40181-6');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0049',10,25,'Fichas de Ortografia - 1.º Ano','01/01/2016','2207726726159','As Fichas de Ortografia 1 são recomendadas para o 1.º ano do ensino básico e têm como principal objetivo auxiliar o aluno no estudo das regras da ortografia de forma autónoma, quer na sala de aula quer em casa.',96,0.096,7.70,6.93,FALSE,14,'primeira',NULL,'978-972-0-01810-6');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0050',10,25,'Troca-Tintas - 5-6 Anos','01/01/2017','7869210941541','A educadora da minha filha sugeriu este livro para desenvolver competências adequadas à idade da minha filha. O surpreendente neste livro é ter textos e actividades que se enquadram no Plano Nacional de Leitura que contribui para o enriquecimento do processo de aprendizagem e desenvolvimento global dos nossos filhos. Recomendo vivamente este livro, para a Educação Pré-Escolar.',79,0.079,9.90,8.91,TRUE,15,'primeira',NULL,'978-972-0-10929-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0051',10,26,'Apoio ao Estudo - 2.º Ano','01/01/2016','5574840389859','De acordo com o novo enquadramento legal relativo ao currículo do 1.° Ciclo do Ensino Básico, o Apoio ao Estudo é de frequência obrigatória e tem por objetivo apoiar os alunos na criação de métodos de estudo e de trabalho, visando prioritariamente o reforço do apoio nas disciplinas de Português e de Matemática.',64,0.064,8.80,7.92,TRUE,10,'primeira',NULL,'978-972-0-14104-0');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0052',10,26,'Ditados 1.º e 2.º anos','01/01/2015','7153658111035','Ditados - 1.° e 2.° anos tem como principal objetivo auxiliar o aluno a escrever corretamente e sem erros.',372,0.372,6.60,6.60,FALSE,9,'primeira',NULL,'978-972-0-14030-2');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0053',10,27,'A Matemática - 3.º e 4.º anos','01/01/2016','5480657290805','Um auxiliar essencial para o 1.º Ciclo do Ensino Básico!',160,0.160,12.20,10.98,FALSE,9,'primeira',NULL,'978-972-0-13710-4');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0054',10,27,'Fichas de Avaliação - 3.º Ano','01/01/2017','6526927280903','Português, Matemática e Estudo do Meio.',104,0.104,7.70,6.93,TRUE,5,'primeira',NULL,'978-972-0-14257-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0055',10,28,'Fichas de Avaliação - 4.º Ano','01/01/2016','8026294651660','Português, Matemática e Estudo do Meio;',120,0.120,7.70,7.70,FALSE,4,'primeira',NULL,'978-972-0-14258-0');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0056',10,28,'I Love English! - 9-10 anos - 4.º ano','01/01/2016','1216740100921','Aprender Inglês é cada vez mais fácil e divertido!',321,0.321,7.70,6.93,FALSE,13,'primeira',NULL,'978-972-0-18164-0');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0057',31,29,'Prova de Aferição 2017 - Matemática e Ciências Naturais - 5.º Ano','01/01/2017','8429137192716','Em 2017, vai realizar-se, pela primeira vez, a Prova de Aferição das disciplinas de Matemática e Ciências Naturais do 5.º ano. Esta publicação reúne seis propostas de provas de aferição e respetiva solução, permitindo a verificação dos conhecimentos adquiridos, bem como a superação de eventuais dificuldades, constituindo-se assim como um utensílio de estudo indispensável. Tudo o que o aluno necessita para estar 100% preparado para a Prova de Aferição.',800,0.080,7.70,6.93,TRUE,14,'primeira',NULL,'978-989-767-202-6');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0058',31,29,'Prova de Aferição 2017 - História e Geografia de Portugal - 5.º Ano','01/01/2016','7931073395202','Prova de Aferição 2017 - HGP, 5.º ano é um livro desenvolvido para auxiliar os alunos na preparação para a Prova de Aferição de História e Geografia de Portugal do 5.º ano.',80,0.080,7.70,6.93,TRUE,11,'primeira',NULL,'978-989-767-203-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0059',10,30,'Preparação para a Prova Final 2017 - Matemática - 9.º Ano','01/01/2017','1697934903978','Uma das características da disciplina de Matemática, que por vezes cria grandes dificuldades aos alunos, é a forma estruturada como ela se desenvolve, tornando a falta de bases uma das principais causas e consequências de insucesso.',320,0.320,14.90,13.41,TRUE,10,'primeira',NULL,'978-972-0-00017-0');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0060',10,30,'Preparação para a Prova Final 2017 - Português - 9.º Ano','01/01/2017','0401075184361','Este livro foi especialmente desenvolvido para os alunos do 9.° ano que se encontram em fase de preparação para as Provas Finais.',256,0.256,14.90,13.41,TRUE,8,'primeira',NULL,'978-972-0-00029-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0061',10,31,'Preparação para o Exame Final Nacional 2017 - Física e Química A - 11.º Ano','01/01/2017','5146013439357','Com o intuito de preparar o aluno para o Exame Final Nacional de Física e Química A - 11.° ano, este livro constitui um excelente instrumento de apoio no reforço, sistematização e síntese das aprendizagens fundamentais da disciplina.',448,0.448,29.90,26.91,TRUE,3,'primeira',NULL,'978-972-0-01995-0');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0062',10,31,'Preparação para o Exame Final Nacional 2017 - Biologia e Geologia - 11.º Ano','01/01/2017','8194233259422','Com o intuito de preparar o aluno para o Exame Final Nacional de Biologia e Geologia do 11.° ano, este livro constitui um excelente instrumento de apoio no reforço, sistematização e síntese das aprendizagens fundamentais da disciplina.',304,0.304,29.90,26.91,TRUE,9,'primeira',NULL,'978-972-0-46911-3');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0063',32,35,'Autosport','22/03/2017','0985961643675','Autosport',100,0.100,2.35,2.35,TRUE,7,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0064',33,35,'Auto Foco','23/03/2017','0109287266508','Auto Foco',100,0.100,1.99,1.99,FALSE,14,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0065',32,36,'Take Off','23/03/2017','7049071906079','Take Off',100,0.100,1.99,1.99,FALSE,12,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0066',33,36,'Sirius Magazine','01/02/2017','7529012336482','Sirius Magazine',100,0.100,2.50,2.50,TRUE,4,NULL,'Mensal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0067',33,37,'Visao','23/03/2017','4292557109070','Visao',100,0.100,3.20,3.20,TRUE,5,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0068',32,37,'Sabado','23/03/2017','9918695296190','Sabado',100,0.100,3.20,3.20,FALSE,7,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0069',33,61,'Caras','25/03/2017','1419098322397','Caras',100,0.100,1.50,1.50,FALSE,10,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0070',33,61,'VIP','21/03/2017','0657670274761','VIP',100,0.100,1.50,1.50,FALSE,7,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0071',33,42,'Expresso Economia','23/03/2017','2440508820339','Expresso Economia',100,0.100,1.99,1.99,FALSE,13,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0072',32,42,'Vida Economica','23/03/2017','5464618601219','Vida Economica',100,0.100,1.99,1.99,TRUE,13,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0073',33,40,'Dragoes','23/03/2017','7927920175420','Dragoes',100,0.100,1.50,1.50,TRUE,10,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0074',32,40,'Jornal Sporting','23/03/2017','3724918280352','Jornal Sporting',100,0.100,1.50,1.50,TRUE,12,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0075',32,47,'Exame Informatica','23/03/2017','1506012351385','Exame Informatica',100,0.100,2.50,2.50,TRUE,15,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0076',33,47,'PC Guia','23/03/2017','0534154813213','PC Guia',100,0.100,2.50,2.50,FALSE,3,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0077',32,62,'Teleculinaria','23/03/2017','0707129484025','Teleculinaria',100,0.100,2.50,2.50,FALSE,14,NULL,'Mensal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0078',32,62,'Ementa da semana','23/03/2017','6954574725085','Ementa da semana',100,0.100,0.50,0.50,FALSE,13,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0079',33,39,'Caras Decoracao','23/03/2017','3209378132684','Caras Decoracao',100,0.100,3.00,3.00,TRUE,9,NULL,'Mensal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0080',33,39,'Casa Claudia','23/03/2017','9740495212784','Casa Claudia',100,0.100,3.50,3.50,FALSE,7,NULL,'Mensal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0081',32,51,'Evasoes','23/03/2017','4920701920776','Evasoes',100,0.100,1.60,1.60,TRUE,15,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0082',32,51,'Viajar','01/03/2017','6659026698925','Viajar',100,0.100,2.00,2.00,FALSE,4,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0083',32,63,'Jornal das Letras','23/03/2017','5614434196754','Jornal das Letras',100,0.100,3.00,3.00,FALSE,11,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0084',33,63,'Blitz','23/03/2017','7773017376326','Blitz',100,0.100,4.00,4.00,TRUE,15,NULL,'Mensal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0085',32,64,'Dica da semana','23/03/2017','6839724965936','Dica da semana',100,0.100,1.50,1.50,FALSE,7,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0086',32,64,'Jornal de Barcelos','23/03/2017','7241848559321','Jornal de Barcelos',100,0.100,0.70,0.70,FALSE,9,NULL,'Semanal',NULL);
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0087',10,52,'Dicionário Básico Ilustrado da Língua Portuguesa','01/01/2016','2313908565730','Dicionário Básico Ilustrado da Língua Portuguesa.',512,0.512,9.99,9.99,FALSE,14,'primeira',NULL,'978-972-0-01993-6');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0088',10,53,'Dicionário Escolar de Inglês-Português / Português-Inglês','01/01/2016','7417447979942','Mais de 101 000 traduções e de 54 000 entradas, exemplos e expressões idiomáticas, incluindo os termos mais usuais do inglês americano e vocábulos brasileiros. Esta edição regista vocabulário corrente e atual, para além de várias palavras e sentidos novos das mais diversas áreas: biohazard, blogosphere, metrosexual, minicam, newbie na parte Inglês-Português e bloguista, linkar, login, porta-bebés, pró-ativo, resiliência na parte Português-Inglês.',765,0.765,9.90,8.91,TRUE,11,'primeira',NULL,'978-972-0-05422-7');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0089',10,54,'Dicionário Escolar de Francês-Português / Português-Francês','01/01/2016','5377031095792','Atualizada com o Acordo Ortográfico, esta edição regista as novas grafias, mantendo também as grafias anteriores na parte Português-Francês. Inclui igualmente um Guia do Acordo Ortográfico que expõe as principais alterações decorrentes da reforma ortográfica.',768,0.768,9.90,9.90,TRUE,7,'primeira',NULL,'978-972-0-01561-7');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0090',15,55,'Alemão em 30 Dias','01/01/2004','7335604547643','Alemão em 30 Dias é o segundo volume da colecção «Novos Manuais de Línguas». Um curso de línguas que certamente o ajudará a dar os primeiros passos na língua alemã.',324,0.324,12.50,12.50,TRUE,14,'primeira',NULL,'9789722332217');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0091',10,56,'Dicionário Moderno de Espanhol-Português / Português-Espanhol','01/01/2016','7775009678550','Um dicionário de língua espanhola, cujo texto em português se encontra adaptado ao Acordo Ortográfico de 1990. Para facilitar a pesquisa e a transição segura para a nova ortografia, na lista de entradas da parte Português-Espanhol foram registadas as duas grafias: as grafias anteriores à reforma ortográfica e as novas grafias introduzidas por ela.',1040,1.040,17.90,16.11,TRUE,7,'primeira',NULL,'978-972-0-05755-6');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0092',10,57,'Guias de Viagem 10 - Top 10 Marraquexe','01/01/2016','9257786970263','Este Guia de Viagem TOP 10 tem tudo o que não pode perder em Marraquexe, qualquer que seja o tipo de viagem que vai realizar. Aqui vai encontrar o que a cidade tem de melhor.',128,0.128,14.40,14.40,FALSE,9,'primeira',NULL,'978-972-0-31835-0');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0093',34,58,'Lonely Planet Costa Rica','01/01/2016','4042082573451','Lonely Planet Costa Rica is your passport to the most relevant, up-to-date advice on what to see and skip, and what hidden discoveries await you. Snorkel the teeming reefs off Manzanillo, explore some of the globes best wildlife-watching destinations, or dig into Costa Rican culture and cuisine in San Jose; all with your trusted travel companion.',544,0.544,20.98,20.98,TRUE,13,'primeira',NULL,'9781786571120');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0094',35,59,'Oriente Distante','01/01/2012','7961913135419','Viajante habitual, o autor percorre o trilho dos vestígios da cultura e presença portuguesa pelo Oriente. Neste livro, embaixador itinerante por Macau, Japão, Mongólia, Camboja, Xinjiang e Vietname onde Portugal permanece teimosamente presente - apesar da perda do protagonismo.',453,0.453,13.90,13.90,TRUE,15,'primeira',NULL,'9789895555505');
INSERT INTO Publicacao (PrimaveraID, editoraID,subcategoriaID,titulo,dataPublicacao,codigoBarras,descricao,paginas,peso,preco,precoPromocional,novidade,stock,edicao,periodicidade,ISBN) VALUES ('ABS0095',10,60,'CITYPACK - Londres','01/01/2017','0063535683248','Descubra a cidade de Londres com a ajuda do guia CityPack',176,0.176,13.30,11.97,TRUE,7,'primeira',NULL,'978-972-0-00039-2');

/* ------------------------------------------------------ R20 Pais ------------------------------------------------------ */
INSERT INTO Pais (nome) VALUES 
('AFEGANISTÃO'),
('ACROTÍRI E DECELIA'),
('ÁFRICA DO SUL'),
('ALBÂNIA'),
('ALEMANHA'),
('AMERICAN SAMOA'),
('ANDORRA'),
('ANGOLA'),
('ANGUILLA'),
('ANTÍGUA E BARBUDA'),
('ANTILHAS NEERLANDESAS'),
('ARÁBIA SAUDITA'),
('ARGÉLIA'),
('ARGENTINA'),
('ARMÉNIA'),
('ARUBA'),
('AUSTRÁLIA'),
('ÁUSTRIA'),
('AZERBAIJÃO'),
('BAHAMAS'),
('BANGLADECHE'),
('BARBADOS'),
('BARÉM'),
('BASSAS DA ÍNDIA'),
('BÉLGICA'),
('BELIZE'),
('BENIM'),
('BERMUDAS'),
('BIELORRÚSSIA'),
('BOLÍVIA'),
('BÓSNIA E HERZEGOVINA'),
('BOTSUANA'),
('BRASIL'),
('BRUNEI DARUSSALAM'),
('BULGÁRIA'),
('BURQUINA FASO'),
('BURUNDI'),
('BUTÃO'),
('CABO VERDE'),
('CAMARÕES'),
('CAMBOJA'),
('CANADÁ'),
('CATAR'),
('CAZAQUISTÃO'),
('CENTRO-AFRICANA REPÚBLICA'),
('CHADE'),
('CHILE'),
('CHINA'),
('CHIPRE'),
('COLÔMBIA'),
('COMORES'),
('CONGO'),
('CONGO REPÚBLICA DEMOCRÁTICA'),
('COREIA DO NORTE'),
('COREIA DO SUL'),
('COSTA DO MARFIM'),
('COSTA RICA'),
('CROÁCIA'),
('CUBA'),
('DINAMARCA'),
('DOMÍNICA'),
('EGIPTO'),
('EMIRADOS ÁRABES UNIDOS'),
('EQUADOR'),
('ERITREIA'),
('ESLOVÁQUIA'),
('ESLOVÉNIA'),
('ESPANHA'),
('ESTADOS UNIDOS'),
('ESTÓNIA'),
('ETIÓPIA'),
('FAIXA DE GAZA'),
('FIJI'),
('FILIPINAS'),
('FINLÂNDIA'),
('FRANÇA'),
('GABÃO'),
('GÂMBIA'),
('GANA'),
('GEÓRGIA'),
('GIBRALTAR'),
('GRANADA'),
('GRÉCIA'),
('GRONELÂNDIA'),
('GUADALUPE'),
('GUAM'),
('GUATEMALA'),
('GUERNSEY'),
('GUIANA'),
('GUIANA FRANCESA'),
('GUINÉ'),
('GUINÉ EQUATORIAL'),
('GUINÉ-BISSAU'),
('HAITI'),
('HONDURAS'),
('HONG KONG'),
('HUNGRIA'),
('IÉMEN'),
('ILHA BOUVET'),
('ILHA CHRISTMAS'),
('ILHA DE CLIPPERTON'),
('ILHA DE JOÃO DA NOVA'),
('ILHA DE MAN'),
('ILHA DE NAVASSA'),
('ILHA EUROPA'),
('ILHA NORFOLK'),
('ILHA TROMELIN'),
('ILHAS ASHMORE E CARTIER'),
('ILHAS CAIMAN'),
('ILHAS COCOS (KEELING)'),
('ILHAS COOK'),
('ILHAS DO MAR DE CORAL'),
('ILHAS FALKLANDS (ILHAS MALVINAS)'),
('ILHAS FEROE'),
('ILHAS GEÓRGIA DO SUL E SANDWICH DO SUL'),
('ILHAS MARIANAS DO NORTE'),
('ILHAS MARSHALL'),
('ILHAS PARACEL'),
('ILHAS PITCAIRN'),
('ILHAS SALOMÃO'),
('ILHAS SPRATLY'),
('ILHAS VIRGENS AMERICANAS'),
('ILHAS VIRGENS BRITÂNICAS'),
('ÍNDIA'),
('INDONÉSIA'),
('IRÃO'),
('IRAQUE'),
('IRLANDA'),
('ISLÂNDIA'),
('ISRAEL'),
('ITÁLIA'),
('JAMAICA'),
('JAN MAYEN'),
('JAPÃO'),
('JERSEY'),
('JIBUTI'),
('JORDÂNIA'),
('KIRIBATI'),
('KOWEIT'),
('LAOS'),
('LESOTO'),
('LETÓNIA'),
('LÍBANO'),
('LIBÉRIA'),
('LÍBIA'),
('LISTENSTAINE'),
('LITUÂNIA'),
('LUXEMBURGO'),
('MACAU'),
('MACEDÓNIA'),
('MADAGÁSCAR'),
('MALÁSIA'),
('MALAVI'),
('MALDIVAS'),
('MALI'),
('MALTA'),
('MARROCOS'),
('MARTINICA'),
('MAURÍCIA'),
('MAURITÂNIA'),
('MAYOTTE'),
('MÉXICO'),
('MIANMAR'),
('MICRONÉSIA'),
('MOÇAMBIQUE'),
('MOLDÁVIA'),
('MÓNACO'),
('MONGÓLIA'),
('MONTENEGRO'),
('MONTSERRAT'),
('NAMÍBIA'),
('NAURU'),
('NEPAL'),
('NICARÁGUA'),
('NÍGER'),
('NIGÉRIA'),
('NIUE'),
('NORUEGA'),
('NOVA CALEDÓNIA'),
('NOVA ZELÂNDIA'),
('OMÃ'),
('PAÍSES BAIXOS'),
('PALAU'),
('PALESTINA'),
('PANAMÁ'),
('PAPUÁSIA-NOVA GUINÉ'),
('PAQUISTÃO'),
('PARAGUAI'),
('PERU'),
('POLINÉSIA FRANCESA'),
('POLÓNIA'),
('PORTO RICO'),
('PORTUGAL'),
('QUÉNIA'),
('QUIRGUIZISTÃO'),
('REINO UNIDO'),
('REPÚBLICA CHECA'),
('REPÚBLICA DOMINICANA'),
('ROMÉNIA'),
('RUANDA'),
('RÚSSIA'),
('SAHARA OCCIDENTAL'),
('SALVADOR'),
('SAMOA'),
('SANTA HELENA'),
('SANTA LÚCIA'),
('SANTA SÉ'),
('SÃO CRISTÓVÃO E NEVES'),
('SÃO MARINO'),
('SÃO PEDRO E MIQUELÃO'),
('SÃO TOMÉ E PRÍNCIPE'),
('SÃO VICENTE E GRANADINAS'),
('SEICHELES'),
('SENEGAL'),
('SERRA LEOA'),
('SÉRVIA'),
('SINGAPURA'),
('SÍRIA'),
('SOMÁLIA'),
('SRI LANCA'),
('SUAZILÂNDIA'),
('SUDÃO'),
('SUÉCIA'),
('SUÍÇA'),
('SURINAME'),
('SVALBARD'),
('TAILÂNDIA'),
('TAIWAN'),
('TAJIQUISTÃO'),
('TANZÂNIA'),
('TERRITÓRIO BRITÂNICO DO OCEANO ÍNDICO'),
('TERRITÓRIO DAS ILHAS HEARD E MCDONALD'),
('TIMOR-LESTE'),
('TOGO'),
('TOKELAU'),
('TONGA'),
('TRINDADE E TOBAGO'),
('TUNÍSIA'),
('TURKS E CAICOS'),
('TURQUEMENISTÃO'),
('TURQUIA'),
('TUVALU'),
('UCRÂNIA'),
('UGANDA'),
('URUGUAI'),
('USBEQUISTÃO'),
('VANUATU'),
('VENEZUELA'),
('VIETNAME'),
('WALLIS E FUTUNA'),
('ZÂMBIA'),
('ZIMBABUÉ');

/* ------------------------------------------------------ R12 Cliente ------------------------------------------------------ */
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Joao Americo Pereira Ribeiro','Masculino','21/03/1993','joaoribeiro','QYU41RAX3FI',TRUE,'05/03/2013 11:54:40','934844763','joaoribeiro@gmail.com','044593724');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Antonio Joaquim dos Santos Teixeira','Masculino','24/03/1995','antonioteixeira','BRD41MAM5ON',TRUE,'03/10/2015 13:34:40','966450982','antonioteixiera@gmail.com','283234271');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Eduardo Paredes da Silva','Masculino','15/11/1988','eduardosilva','RQV35LJX2ML',TRUE,'12/10/2013 15:32:42','917716855','eduardoparedessilva@gmail.com','239054718');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Alexandre Jose Ribeiro Gaspar','Masculino','15/03/1979','alexandregaspar','LSL47AZW9BX',TRUE,'09/11/2013 17:26:35','917176613','alexandrejosegaspar@gmail.com','405583318');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Maria de Castro Meireles Guerra','Feminino','13/11/1980','mariaguerra','VEF30WBO4MB',TRUE,'01/08/2013 14:32:12','968203005','mariameirelesguerra@hotmail.com','161643248');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Luis Alberto Martins Guimaraes','Masculino','07/06/1996','luisguimaraes','GCV39KPT8BG',TRUE,'22/09/2014 15:29:18','964412884','luisalbertoguimaraes@gmail.com','156008522');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Ricardo Martins Marques','Masculino','08/02/1971','ricardomarques','PGT76GUP3KT',TRUE,'07/10/2012 12:16:32','962680460','ricardomartinsmarques@gmail.com','551775972');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Belmiro Jose Guimaraes Pinto','Masculino','11/07/1993','belmiropinto','UCQ67FXR1YJ',TRUE,'23/09/2017 09:36:35','914899512','belmirojoseguimaraespinto@hotmail.com','156795223');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Ricardo Antonio Ramos Cruz','Masculino','12/08/1988','ricardocruz','FBT96EWW3LM',TRUE,'01/04/2015 11:02:34','934216494','ricardoantonioramoscruz@gmail.com','122897197');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Daniel Rodrigues de Sousa Carmo','Masculino','01/10/1976','danielcarmo','MCL83NVJ2EH',TRUE,'30/07/2014 11:43:22','933835578','danielsousacarmo@hotmail.com','817189216');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Henrique Jose Gouveia Pinto','Masculino','01/09/1981','henriquepinto,','QYZ07WLN7YC',TRUE,'21/04/2012 14:33:22','912356510','henriquegouveiapinto@gmail.com','220227873');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Augusto Manuel Alves Pardal','Masculino','12/01/1979','augustopardal','YBS70AHE9VH',TRUE,'22/08/2015 10:07:12','967193101','augustomanuelpardal@gmail.com','184681792');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Manuel da Costa Soares de Sampaio','Masculino','12/09/1976','manuelsampaio','ORU30BNL0JK',TRUE,'28/11/2016 11:12:40','964749241','manuelsoaressampaio@gmail.com','995300138');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Maria Adelaide Ribeiro','Feminino','12/06/1976','mariaribeiro','NGJ01GJR0YA',TRUE,'18/04/2014 09:08:33','918367885','mariaadelaideribeiro@gmail.com','828257176');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Fernando Jose Costa Matos','Masculino','04/10/1988','fernandomatos','EEK74UJV6HC',TRUE,'09/05/2012 21:50:32','932641906','fernandojosecostamatos@gmail.com','337520918');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Teresa Maria Ribeiro Gaspar','Feminino','11/12/1975','teresagaspar','HGY55RMA9YB',TRUE,'12/12/2013 08:32:21','938501001','teresamariagaspar@gmail.com','794359407');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Teresa de Jesus Teixeira Ferreira','Feminino','02/11/1990','teresaferreira','YJP07DRL9MK',TRUE,'03/01/2013 12:43:21','926131659','teresajesusteixeira@hotmail.com','736225027');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Jose Manuel Carvalho dos Santos','Masculino','09/07/1970','josesantos','BKF67NLO2SU',TRUE,'01/03/2014 15:50:32','965650958','josemanuelcarvalhodossantos@hotmail.com','833984062');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Jorge Manuel Rodrigues Goncalves','Masculino','22/03/1986','jorgegoncalves','NWH27SAD6MP',TRUE,'02/10/2015 16:21:40','966172007','jorgemanuelrodriguesgoncalves@gmail.com','866169562');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Helena Isabel Duarte Dias Ribeiro','Feminino','29/06/1973','helenaribeiro','NNS43YYQ8GT',TRUE,'01/03/2016 17:21:32','966229693','helenaisabelribeiro@hotmail.com','898351545');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'Armando Dina Mieiro','Masculino','06/09/1998','armandomieiro','HLL49KIO9FU',TRUE,'12/11/2012 18:21:34','917865498','armandomieiro@gmail.com','259873398');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,dataRegisto,telefone,email,nif) VALUES (193,'ClienteProto','Masculino','06/09/1998','cli_proto','219d87a2f4b50249b71bdea4184b662b7cea3c95',TRUE,'12/11/2012 18:21:34','917865498','cliproto@gmail.com','259873376');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,telefone,email,nif) VALUES (193,'Andre Correia','Masculino','15/03/1989','a','883768b6dd2c42aea0031b24be8a2da40fef4b64',TRUE,'916735524','a@gmail.com','258681542');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,telefone,email,nif) VALUES (193,'Andre Correia','Masculino','15/03/1989','b','883768b6dd2c42aea0031b24be8a2da40fef4b64',TRUE,'916735524','b@gmail.com','258682542');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,telefone,email,nif) VALUES (193,'Andre Correia','Masculino','15/03/1989','c','883768b6dd2c42aea0031b24be8a2da40fef4b64',TRUE,'916735524','c@gmail.com','258683542');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,telefone,email,nif) VALUES (193,'Andre Correia','Masculino','15/03/1989','d','883768b6dd2c42aea0031b24be8a2da40fef4b64',TRUE,'916735524','d@gmail.com','258687542');
INSERT INTO Cliente (paisID,nome,genero,dataNascimento,userName,passWord,ativo,telefone,email,nif) VALUES (193,'Andre Correia','Masculino','15/03/1989','e','883768b6dd2c42aea0031b24be8a2da40fef4b64',TRUE,'916735524','e@gmail.com','228687542');


/* ------------------------------------------------------ R3 PublicacaoCarrinho ------------------------------------------------------ */
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (11,4,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (1,10,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (68,8,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (56,2,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (14,2,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (51,3,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (95,7,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (44,6,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (9,10,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (82,5,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (52,1,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (6,4,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (60,2,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (81,4,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (83,2,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (23,7,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (48,7,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (10,2,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (53,7,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (88,10,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (58,6,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (12,2,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (40,9,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (50,5,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (5,4,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (14,5,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (59,4,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (15,10,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (88,3,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (76,4,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (66,4,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (58,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (12,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (40,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (50,22,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (5,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (14,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (59,22,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (15,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (88,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (76,22,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (66,22,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (82,23,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (52,23,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (6,23,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (60,23,1);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (81,23,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (83,23,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (23,23,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (48,23,2);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (10,23,3);
INSERT INTO PublicacaoCarrinho (publicacaoID,carrinhoID,quantidade) VALUES (53,23,3);

/* ------------------------------------------------------ R4 WishList ------------------------------------------------------ */
INSERT INTO WishList (clienteID,nome) VALUES (15,'Informatica');
INSERT INTO WishList (clienteID,nome) VALUES (2,'Romance');
INSERT INTO WishList (clienteID,nome) VALUES (21,'Acao');
INSERT INTO WishList (clienteID,nome) VALUES (10,'Historia');
INSERT INTO WishList (clienteID,nome) VALUES (3,'Informatica');
INSERT INTO WishList (clienteID,nome) VALUES (6,'Informatica');
INSERT INTO WishList (clienteID,nome) VALUES (9,'Acao');
INSERT INTO WishList (clienteID,nome) VALUES (4,'Romance');
INSERT INTO WishList (clienteID,nome) VALUES (20,'Informatica');
INSERT INTO WishList (clienteID,nome) VALUES (18,'Arte');
INSERT INTO WishList (clienteID,nome) VALUES (1,'Arte');
INSERT INTO WishList (clienteID,nome) VALUES (7,'Acao');
INSERT INTO WishList (clienteID,nome) VALUES (20,'Historia');
INSERT INTO WishList (clienteID,nome) VALUES (15,'Acao');
INSERT INTO WishList (clienteID,nome) VALUES (10,'Informatica');
INSERT INTO WishList (clienteID,nome) VALUES (19,'Romance');
INSERT INTO WishList (clienteID,nome) VALUES (7,'Historia');
INSERT INTO WishList (clienteID,nome) VALUES (11,'Historia');
INSERT INTO WishList (clienteID,nome) VALUES (9,'Arte');
INSERT INTO WishList (clienteID,nome) VALUES (19,'Informatica');
INSERT INTO WishList (clienteID,nome) VALUES (22,'Arte');
INSERT INTO WishList (clienteID,nome) VALUES (23,'Romance');

/* ------------------------------------------------------ R5 PublicacaoWishList ------------------------------------------------------ */
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (2,44);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (4,67);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (9,87);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (7,54);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (11,72);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (7,5);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (10,30);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (11,58);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (19,11);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (10,20);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (12,88);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (10,78);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (9,31);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (16,81);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (3,40);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (4,95);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (3,39);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (18,54);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (5,74);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (1,14);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (9,84);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (15,43);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (9,51);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (16,16);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (3,94);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (1,32);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (15,93);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (6,15);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (3,45);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (8,3);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (4,55);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (11,13);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (20,86);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (16,63);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (9,29);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (6,88);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (4,84);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (16,50);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (17,90);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (19,85);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (13,87);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (17,29);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,86);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,63);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,29);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,88);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,84);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,50);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,90);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,85);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (21,87);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,84);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,43);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,51);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,16);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,94);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,32);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,93);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,15);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,45);
INSERT INTO PublicacaoWishList (wishListID,publicacaoID) VALUES (22,3);

/* ------------------------------------------------------ R7 Imagem ------------------------------------------------------ */
INSERT INTO Imagem (publicacaoID,url) VALUES (1,'images/publications/books/Arte/1.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (2,'images/publications/books/Arte/2.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (3,'images/publications/books/Banda_Desenhada/3.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (4,'images/publications/books/Banda_Desenhada/4.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (5,'images/publications/books/Ciencias_Exatas_e_Naturais/5.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (6,'images/publications/books/Ciencias_Exatas_e_Naturais/6.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (7,'images/publications/books/Ciencias_Sociais_e_Humanas/7.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (8,'images/publications/books/Ciencias_Sociais_e_Humanas/8.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (9,'images/publications/books/Desporto_e_Lazer/9.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (10,'images/publications/books/Desporto_e_Lazer/10.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (11,'images/publications/books/Direito/11.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (12,'images/publications/books/Direito/12.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (13,'images/publications/books/Engenharia/13.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (14,'images/publications/books/Engenharia/14.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (15,'images/publications/books/Ensino_e_Educacao/15.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (16,'images/publications/books/Ensino_e_Educacao/16.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (17,'images/publications/books/Gastronomia_e_Vinhos/17.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (18,'images/publications/books/Gastronomia_e_Vinhos/18.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (19,'images/publications/books/Gestao/19.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (20,'images/publications/books/Gestao/20.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (21,'images/publications/books/Historia/21.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (22,'images/publications/books/Historia/22.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (23,'images/publications/books/Informatica/23.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (24,'images/publications/books/Informatica/24.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (25,'images/publications/books/Literatura/25.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (26,'images/publications/books/Literatura/26.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (27,'images/publications/books/Medicina/27.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (28,'images/publications/books/Medicina/28.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (29,'images/publications/books/Politica/29.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (30,'images/publications/books/Politica/30.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (31,'images/publications/books/Religiao_e_Moral/31.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (32,'images/publications/books/Religiao_e_Moral/32.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (33,'images/publications/books/Saude_e_Bem_Estar/33.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (34,'images/publications/books/Saude_e_Bem_Estar/34.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (35,'images/publications/educationbooks/1.º_ano/35.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (36,'images/publications/educationbooks/1.º_ano/36.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (37,'images/publications/educationbooks/2.º_ano/37.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (38,'images/publications/educationbooks/2.º_ano/38.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (39,'images/publications/educationbooks/3.º_ano/39.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (40,'images/publications/educationbooks/3.º_ano/40.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (41,'images/publications/educationbooks/4.º_ano/41.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (42,'images/publications/educationbooks/4.º_ano/42.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (43,'images/publications/educationbooks/5.º_e_6.º_ano/43.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (44,'images/publications/educationbooks/5.º_e_6.º_ano/44.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (45,'images/publications/educationbooks/7.º_8.º_e_9.º_ciclo/45.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (46,'images/publications/educationbooks/7.º_8.º_e_9.º_ciclo/46.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (47,'images/publications/educationbooks/Ensino_Secundario/47.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (48,'images/publications/educationbooks/Ensino_Secundario/48.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (49,'images/publications/supporteducationbooks/1.º_ano/49.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (50,'images/publications/supporteducationbooks/1.º_ano/50.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (51,'images/publications/supporteducationbooks/2.º_ano/51.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (52,'images/publications/supporteducationbooks/2.º_ano/52.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (53,'images/publications/supporteducationbooks/3.º_ano/53.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (54,'images/publications/supporteducationbooks/3.º_ano/54.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (55,'images/publications/supporteducationbooks/4.º_ano/55.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (56,'images/publications/supporteducationbooks/4.º_ano/56.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (57,'images/publications/supporteducationbooks/5.º_e_6.º_ano/57.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (58,'images/publications/supporteducationbooks/5.º_e_6.º_ano/58.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (59,'images/publications/supporteducationbooks/7.º_8.º_e_9.º_ciclo/59.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (60,'images/publications/supporteducationbooks/7.º_8.º_e_9.º_ciclo/60.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (61,'images/publications/supporteducationbooks/Ensino_Secundario/61.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (62,'images/publications/supporteducationbooks/Ensino_Secundario/62.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (63,'images/publications/magazines/Automobilismo/63.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (64,'images/publications/magazines/Automobilismo/64.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (65,'images/publications/magazines/Aviacao/65.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (66,'images/publications/magazines/Aviacao/66.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (67,'images/publications/magazines/Cientificas/67.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (68,'images/publications/magazines/Cientificas/68.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (69,'images/publications/magazines/Social/69.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (70,'images/publications/magazines/Social/70.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (71,'images/publications/magazines/Economia/71.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (72,'images/publications/magazines/Economia/72.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (73,'images/publications/magazines/Desporto/73.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (74,'images/publications/magazines/Desporto/74.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (75,'images/publications/magazines/Informatica/75.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (76,'images/publications/magazines/Informatica/76.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (77,'images/publications/magazines/Culinaria/77.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (78,'images/publications/magazines/Culinaria/78.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (79,'images/publications/magazines/Decoracao/79.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (80,'images/publications/magazines/Decoracao/80.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (81,'images/publications/magazines/Turismo/81.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (82,'images/publications/magazines/Turismo/82.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (83,'images/publications/magazines/Lazer/83.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (84,'images/publications/magazines/Lazer/84.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (85,'images/publications/magazines/Regionais/85.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (86,'images/publications/magazines/Regionais/86.jpg');
INSERT INTO Imagem (publicacaoID,url) VALUES (87,'images/publications/dictionaries/Portugues/87.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (88,'images/publications/dictionaries/Ingles/88.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (89,'images/publications/dictionaries/Frances/89.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (90,'images/publications/dictionaries/Alemao/90.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (91,'images/publications/dictionaries/Espanhol/91.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (92,'images/publications/turisticguides/Africa/92.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (93,'images/publications/turisticguides/America/93.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (94,'images/publications/turisticguides/Asia/94.jpeg');
INSERT INTO Imagem (publicacaoID,url) VALUES (95,'images/publications/turisticguides/Europa/95.jpeg');

/* ------------------------------------------------------ R18 Autor ------------------------------------------------------ */
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Bernardo Pinto de Almeida','Masculino','10/02/1954','Bernardo Pinto de Almeida nasceu em 1954.Vive e trabalha no Porto. Professor Catedrático na Faculdade de Belas Artes da Universidade do Porto.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Grant Scott','Masculino','27/04/1973','Grant Scott é fotógrafo profissional. Depois de atuar durante quinze anos como diretor de fotografia de livros e revistas como Elle e Tatler, no ano 2000 ele decidiu abrir seu próprio estúdio como fotógrafo freelancer, trabalho que executa até os dias de hoje, paralelamente às aulas que ministra no curso de graduação em Fotografia Editorial e Publicitária da Universidade de Gloucestershire, na Inglaterra.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Brian K. Vaughan','Masculino','18/11/1975','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'ED Brubaker','Masculino','31/12/1984','Ed Brubaker é um dos mais aclamados argumentistas da actualidade, com histórias em todas as grandes editoras americanas.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Jorge Dias de Deus','Masculino','10/06/1976','Jorge Dias de Deus é professor catedrático jubilado no Instituto Superior Técnico, da Universidade de Lisboa, com notável obra científica em física de altas energias, astrofísica e cosmologia, e sistemas dinâmicos.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Augusto Cury','Masculino','17/06/1986','O Dr. Augusto Cury é psiquiatra, psicoterapeuta, cientista e escritor. Desenvolveu o conceito de inteligência multifocal, uma perspetiva inovadora do funcionamento da mente e da construção do pensamento.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (131,'Iñaki Piñuel','Masculino','29/06/1972','Iñaki Piñuel é doutorado em Psicologia, psicoterapeuta, investigador e divulgador especializado na avaliação e no tratamento das vítimas de abuso psicológico e de psicopatas integrados.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Gareth Moore','Masculino','18/02/1980','Dr. Gareth Moore é autor de mais de 35 best-sellers internacionais de puzzles e outros exercícios para o cérebro.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'João Tiago Lima','Masculino','05/08/1980','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Joaquim Rocha','Masculino','07/02/1977','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'André Fernando Ribeiro de Sá','Masculino','12/04/1980','Engenheiro Eletrotécnico e de Computadores, ramo de sistemas de energia, pela FEUP – Licenciatura (2000) e Mestrado (2003). Pós-graduado em gestão de energia – eficiência energética, pelo ISQ (2008). Título de Especialista em Engenharia Eletrotécnica pela Universidade de Aveiro (2012).');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Rita Castanheira Alves','Feminino','12/01/1979','Rita Castanheira Alves é licenciada em Psicologia Clínica desde 2007. A sua prática profissional tem-se dividido entre a prática clínica com crianças, adolescentes e pais, passando pela gestão, implementação e coordenação de projetos de prevenção e intervenção em saúde mental na área infanto-juvenil');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Mário Cordeiro','Masculino','23/08/1981','Mário Cordeiro, pediatra, professor aposentado de pediatria e de saúde pública da Faculdade de Ciências Médicas de Lisboa.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Dolores Aveiro','Feminino','22/01/1984','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Caroline Webb','Feminino','10/07/1974','Caroline Webb foi partner da McKinsey & Co., onde trabalhou mais de uma década. Ocupa o cargo de CEO na empresa de consultadoria Sevenshift, que criou. Dedica-se a ajudar os seus clientes a serem mais produtivos e mais eficazes no trabalho.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Ana Teresa Penim','Feminino','21/04/1975','É especialista em Coaching Apreciativo, Liderança, Psicologia Positiva, Comunicação, Consumer Behavior e Desenvolvimento de Performance. Possui uma carreira marcada pela liderança e desenvolvimento de projectos formativos inovadores na área do comércio e da aprendizagem ao longo da vida.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Joshua Rubenstein','Masculino','20/09/1978','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Henrique Monteiro','Masculino','07/10/1978','Henrique Monteiro é jornalista profissional há quase 40. Foi repórter em mais de 30 países, incluindo cenários de guerra em Moçambique, Angola e Irão. Foi ainda repórter político e parlamentar. É cronista, assinando desde 1990, na revista do Expresso, a coluna Cartas do Comendador; faz, desde 1995, comentário político no caderno principal do mesmo jornal e, desde 2011, comentários diários na sua versão digital. É ainda comentador na SIC Notícias e na Rádio Renascença. Foi subdiretor do Expresso de 1995 a 2005 e depois disso diretor até 2011.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Luis Marcelino','Masculino','02/01/1972','Licenciado em Eng.ª Eletrotécnica e de Computadores (IST/UTL) com doutoramento em Sistemas de Informação (University of Salford, Reino Unido). Foi docente na Universidade do Algarve e na Universidade Nova de Lisboa. Dedica-se à interação pessoa-máquina e aos dispositivos móveis.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Ricardo Queirós','Masculino','17/07/1983','Licenciado em Informática pelo Instituto Superior de Engenharia do Porto (ISEP) e Mestrado em Informática pela Faculdade de Ciências da Universidade do Porto (FCUP). Exerce a sua actividade como docente na Escola Superior de Estudos Industriais e Gestão (ESEIG), em Vila do Conde, onde é responsável por disciplinas na área das Linguagens e Técnicas de Programação e Bases de Dados.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Rosanna Ley','Feminino','10/03/1977','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Luís Cardoso','Masculino','16/03/1970','Luís Cardoso nasceu em Kailako, uma vila no interior de Timor que aparece por diversas vezes referenciada nos seus romances.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Teresa Rodrigues','Feminino','13/05/1970','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Cinnamon Vanputte','Masculino','03/01/1972','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'José Pedro Castanheira','Masculino','11/04/1981','Ganhou alguns dos mais prestigiados galardões de jornalismo atribuídos em Portugal: Prémio Macau de Jornalismo (1990) e Prémio Nacional de Reportagem de Imprensa (1993), ambos do Clube de Jornalistas; Primeiro Prémio de Reportagem (1993 e 1997), do Clube Português de Imprensa;');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Aníbal Cavaco Silva','Masculino','15/07/1939','Aníbal Cavaco Silva, nascido a 15 de julho de 1939, em Boliqueime, Loulé. É casado com Maria Alves da Silva Cavaco Silva. O casal tem dois filhos e cinco netos. Foi o 19º Presidente da República Portuguesa entre 2006 e 2016.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (131,'Papa Francisco','Masculino','10/12/1986','Francisco (em latim: Franciscus), nascido Jorge Mario Bergoglio SJ (Buenos Aires, 17 de dezembro de 1936) é o 266.º Papa da Igreja Católica e atual chefe de estado do Vaticano,4 sucedendo o Papa Bento XVI, que abdicou ao papado em 28 de fevereiro de 2013.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Robert Sarah','Masculino','16/12/1970','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Isabel Oliveira','Feminino','27/10/1968','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Manuel Pinto Coelho','Masculino','04/01/1986','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Alcides Azevedo Canelas','Feminino','18/04/1983','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Luísa Ducla Soares','Feminino','20/09/1939','uísa Ducla Soares nasceu em Lisboa a 20 de julho de 1939. É licenciada em Filologia Germânica pela Universidade Clássica de Lisboa. Iniciou a sua atividade profissional como tradutora, consultora literária e jornalista, tendo sido diretora da revista de divulgação cultural Vida (1971-2)');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Maria Helena Marques','Feminino','18/09/1978','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Mia Couto','Masculino','16/12/1955','Nasceu na Beira, Moçambique, em 1955. Foi jornalista e professor, e é, atualmente, biólogo e escritor. Está traduzido em diversas línguas.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'António Botto','Feminino','27/10/1968','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Alice Vieira','Feminino','18/09/1943','Escritora portuguesa de livros infantis e juvenis, nascida em 1943. Neste domínio da literatura, ganhou em 1979 o Prémio do Ano Internacional da Criança, com Rosa, Minha Irmã Rosa. Tem publicado regularmente obras em volume - entre elas, Chocolate à Chuva (1982) e Graças e Desgraças da Corte de El-Rei Tadinho (1984)');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'MARIA ALBERTA MENÉRES','Feminino','04/01/1930','Maria Alberta Menéres nasceu em 1930, em Vila Nova de Gaia. Tem uma vasta obra poética, estando representada em várias antologias literárias nacionais e estrangeiras. Foi professora dos Ensinos Básico e Secundário nas disciplinas de Língua Portuguesa e História. É autora de inúmeros programas televisivos para crianças, tendo sido Diretora do Departamento de Programas Infantis e Juvenis da RTP de 1974 a 1986.');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (196,'Angelina G.Beck','Feminino','18/04/1983','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (193,'Lonely Planet','Masculino','18/09/1978','N/A');
INSERT INTO Autor (PaisID,nome,genero,dataNascimento,biografia) VALUES (1,'Joaquim Magalhães De Castro','Masculino','18/09/1978','Nasceu nas Caldas de São Jorge, em Santa Maria da Feira. Escritor, jornalista independente, fotógrafo e investigador da História da Expansão Portuguesa');

/* ------------------------------------------------------ R11 AutorPublicacao ------------------------------------------------------ */
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (1,1);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (2,2);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (3,3);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (4,4);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (5,5);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (6,24);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (7,7);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (8,8);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (9,9);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (10,10);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (11,6);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (12,6);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (13,11);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (14,12);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (15,13);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (16,14);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (17,15);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (18,21);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (19,17);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (20,18);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (21,19);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (22,20);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (23,21);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (24,22);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (25,23);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (26,24);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (27,25);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (28,26);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (29,27);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (30,28);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (31,29);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (32,30);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (33,31);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (34,32);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (35,33);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (40,34);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (41,35);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (42,36);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (43,37);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (44,38);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (89,39);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (92,40);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (93,40);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (94,40);
INSERT INTO AutorPublicacao (publicacaoID,autorID) VALUES (95,40);

/* ------------------------------------------------------ R21 Localidade ------------------------------------------------------ */
INSERT INTO Localidade (paisID,nome) VALUES (193,'Abrantes');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Albufeira');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Amarante');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Aveiro');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Barcelos');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Beja');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Braga');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Bragança');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Caldas da Rainha');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Castelo Branco');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Coimbra');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Ermesinde');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Espinho');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Évora');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Faro');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Figueira da Foz');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Funchal');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Guarda');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Guimarães');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Lamego');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Leiria');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Lisboa');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Maia');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Matosinhos');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Mealhada');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Mirandela');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Odivelas');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Paredes');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Penafiel');
INSERT INTO Localidade (paisID,nome) VALUES (193,'Porto');

/* ------------------------------------------------------ R22 CodigoPostal ------------------------------------------------------ */
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (1,'2200','320');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (2,'8200','250');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (3,'4600','058');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (4,'3800','371');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (5,'4750','264');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (6,'7800','449');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (7,'4715','586');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (8,'5300','031');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (9,'2504','909');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (10,'6001','909');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (11,'3025','016');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (12,'4445','418');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (13,'4501','902');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (14,'7005','872');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (15,'8005','998');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (16,'3080','744');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (17,'9000','083');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (18,'6300','625');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (19,'4800','178');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (20,'5101','909');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (21,'2410','253');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (22,'1750','364');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (23,'4425','087');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (24,'4450','187');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (25,'3050','894');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (26,'5371','909');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (27,'2675','639');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (28,'4580','023');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (29,'4560','495');
INSERT INTO CodigoPostal (localidadeID,cod1,cod2) VALUES (30,'4000','000');

/* ------------------------------------------------------ R23 Morada ------------------------------------------------------ */
INSERT INTO Morada (codigoPostalID,rua) VALUES (1,'Esplanada 1º de Maio');
INSERT INTO Morada (codigoPostalID,rua) VALUES (2,'Albufeira Gare');
INSERT INTO Morada (codigoPostalID,rua) VALUES (3,'Rua Carlos Amarante');
INSERT INTO Morada (codigoPostalID,rua) VALUES (4,'Praceta Cidadela de Aveiro');
INSERT INTO Morada (codigoPostalID,rua) VALUES (5,'Rua Duques Barcelos');
INSERT INTO Morada (codigoPostalID,rua) VALUES (6,'Rua Beja');
INSERT INTO Morada (codigoPostalID,rua) VALUES (7,'Rua Maria Ondina Braga');
INSERT INTO Morada (codigoPostalID,rua) VALUES (8,'Rua Dona Catarina de Bragança');
INSERT INTO Morada (codigoPostalID,rua) VALUES (9,'Apartado 16, Caldas da Rainha');
INSERT INTO Morada (codigoPostalID,rua) VALUES (10,'Apartado 4, Castelo Branco');
INSERT INTO Morada (codigoPostalID,rua) VALUES (11,'Rua de Coimbra');
INSERT INTO Morada (codigoPostalID,rua) VALUES (12,'Travessa de Ermesinde');
INSERT INTO Morada (codigoPostalID,rua) VALUES (13,'Apartado 1001, Espinho');
INSERT INTO Morada (codigoPostalID,rua) VALUES (14,'Circular de Évora');
INSERT INTO Morada (codigoPostalID,rua) VALUES (15,'Rua de Faro');
INSERT INTO Morada (codigoPostalID,rua) VALUES (16,'Rua da Figueira da Foz');
INSERT INTO Morada (codigoPostalID,rua) VALUES (17,'Rua do Marquês do Funchal');
INSERT INTO Morada (codigoPostalID,rua) VALUES (18,'In Guarda Retail-Park');
INSERT INTO Morada (codigoPostalID,rua) VALUES (19,'Rua Capitão Alfredo Guimarães');
INSERT INTO Morada (codigoPostalID,rua) VALUES (20,'Apartado 1, Lamego');
INSERT INTO Morada (codigoPostalID,rua) VALUES (21,'Rua Assunção Leiria');
INSERT INTO Morada (codigoPostalID,rua) VALUES (22,'Terminal de Carga Aeroporto de Lisboa');
INSERT INTO Morada (codigoPostalID,rua) VALUES (23,'Rua Fontineiros da Maia');
INSERT INTO Morada (codigoPostalID,rua) VALUES (24,'Rua Orfeão de Matosinhos');
INSERT INTO Morada (codigoPostalID,rua) VALUES (25,'Póvoa da Mealhada');
INSERT INTO Morada (codigoPostalID,rua) VALUES (26,'Apartado 1, Mirandela');
INSERT INTO Morada (codigoPostalID,rua) VALUES (27,'Praça Cidade de Odivelas');
INSERT INTO Morada (codigoPostalID,rua) VALUES (28,'Rua da Misericórdia de Paredes');
INSERT INTO Morada (codigoPostalID,rua) VALUES (29,'Largo dos Bombeiros Voluntários de Penafiel');
INSERT INTO Morada (codigoPostalID,rua) VALUES (30,'Largo 1º de Dezembro');

/* ------------------------------------------------------ R13 MoradaFaturacao ------------------------------------------------------ */
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (1,1);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (2,2);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (3,3);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (4,4);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (5,5);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (6,6);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (7,7);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (8,8);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (9,9);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (10,10);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (11,11);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (12,12);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (13,13);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (14,14);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (15,15);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (16,16);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (17,17);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (18,18);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (19,19);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (20,20);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (21,21);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (22,22);
INSERT INTO MoradaFaturacao (clienteID,moradaID) VALUES (23,23);

/* ------------------------------------------------------ R14 MoradaEnvio ------------------------------------------------------ */
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (1,1);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (2,2);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (3,3);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (4,4);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (5,5);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (6,6);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (7,7);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (8,8);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (9,9);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (10,10);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (11,11);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (12,12);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (13,13);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (14,14);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (15,15);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (16,16);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (17,17);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (18,18);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (19,19);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (20,20);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (21,21);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (22,22);
INSERT INTO MoradaEnvio (clienteID,moradaID) VALUES (23,23);

/* ------------------------------------------------------ R15 CartaoCreditoCliente ------------------------------------------------------ */
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (1,'MasterCard','5202765077828229','22/05/2015','935');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (2,'MasterCard','5430691565133761','14/08/2011','983');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (3,'AmericanExpress','370260745421182','07/06/2010','837');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (4,'Visa','4916986359778797','05/06/2010','854');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (5,'AmericanExpress','377474126024732','26/04/2012','385');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (6,'Visa','4556648286082744','02/05/2016','376');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (7,'MasterCard','5409854996751109','01/06/2014','831');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (8,'MasterCard','5526905920137779','24/09/2011','610');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (9,'AmericanExpress','370211408726086','06/07/2013','276');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (10,'Visa','4532856394501211','10/01/2015','203');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (11,'Visa','4716421781519918','15/01/2012','890');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (12,'MasterCard','5458126513696426','25/09/2012','645');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (13,'MasterCard','5201465857878229','24/10/2012','719');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (14,'AmericanExpress','371592925533140','14/08/2010','597');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (15,'AmericanExpress','377943126021332','28/06/2015','389');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (16,'Visa','4916550504410670','11/03/2011','752');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (17,'MasterCard','5430657564853761','08/06/2011','173');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (18,'AmericanExpress','376016372768384','22/04/2016','970');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (19,'MasterCard','5401454996774109','01/04/2012','885');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (20,'Visa','4532854254501211','14/09/2011','735');
INSERT INTO CartaoCreditoCliente (clienteID,tipo,numero,validade,cvv) VALUES (22,'Visa','4535654254534232','15/03/2018','798');

/* ------------------------------------------------------ R16 Funcionario ------------------------------------------------------ */
INSERT INTO Funcionario (moradaID,paisID,nome,genero,dataNascimento,username,password,dataAdmissao,telefone,email,nif,cartaoCidadao) VALUES (1,193,'Manuel Pereira Lopes','Masculino','08/12/1980','manuellopes','YPB58AJH6LE','02/09/2009 12:12:50','938321270','manuelpereiralopes@hotmail.com','998187586','51057539 8NE7');
INSERT INTO Funcionario (moradaID,paisID,nome,genero,dataNascimento,username,password,dataAdmissao,telefone,email,nif,cartaoCidadao) VALUES (2,193,'Rui Manuel Fernandes Varela','Masculino','10/05/1991','ruivarela','FOT73YNK8JP','15/08/2012 15:48:15','919232515','ruivarela@gmail.com','102798307','79782665 1XL6');
INSERT INTO Funcionario (moradaID,paisID,nome,genero,dataNascimento,username,password,dataAdmissao,telefone,email,nif,cartaoCidadao) VALUES (3,193,'Emanuel Jose Costa Frade','Masculino','02/02/2000','emanuelfrade','AXK90DBX1NI','19/11/2002 11:50:50','917672257','emanueljosecostafrade@hotmail.com','637237286','44216592 7KU5');
INSERT INTO Funcionario (moradaID,paisID,nome,genero,dataNascimento,username,password,dataAdmissao,telefone,email,nif,cartaoCidadao) VALUES (4,193,'Flavio Vieira Marques','Masculino','29/03/1978','flaviomarques','ODB56YJQ9SX','19/03/1997 10:08:10','934216494','flaviovieiramarques@gmail.com','060839699','96659782 2YM1');
INSERT INTO Funcionario (moradaID,paisID,nome,genero,dataNascimento,username,password,ativo,dataAdmissao,dataCessacao,telefone,email,nif,cartaoCidadao) VALUES (5,193,'Fernanda Goncalves Teixeira','Feminino','07/02/1996','fernandateixeira','OLP29HOE9KR',FALSE,'07/05/2014 09:40:20','12/12/2016 19:15:08','938713908','fernandagoncalvesteixeira@gmail.com','937865341','67542959 4IL4');
INSERT INTO Funcionario (moradaID,paisID,nome,genero,dataNascimento,username,password,dataAdmissao,telefone,email,nif,cartaoCidadao) VALUES (6,193,'FuncionarioProto','Masculino','06/09/1998','func_proto','8950a1913eae349b3a8f40b115efec916af587e8','12/11/2012 18:21:34','917865498','funcproto@gmail.com','259878798', '11342959 4IB4');

/* ------------------------------------------------------ R17 Administrador ------------------------------------------------------ */
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,username,password) VALUES (193,'Renata Vieira Esteves','Feminino','17/8/1994','renataesteves','AIQ85AQG4TJ');
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,username,password) VALUES (193,'Carla Maria dos Santos Botelho','Feminino','27/3/1994','carlabotelho','MAV09WFT8TE');
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,username,password) VALUES (193,'Tiago Miguel Alves Campos','Masculino','15/3/1993','tiagocampos','QDQ58ODE1KV');
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,username,password) VALUES (193,'Armindo Alves Teixeira','Masculino','8/3/1992','armindoteixeira','VBN58OSG2YG');
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,username,password) VALUES (193,'Joaquim da Costa Torres','Masculino','19/7/1991','joaquimtorres','WPZ07DVI9PP');
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,dataCessacao,username,password,ativo) VALUES (193,'Carlos Manuel Teixeira','Masculino','8/9/1991','12/02/2017','carlosteixeira','BSO38NJN5MA',FALSE);
INSERT INTO Administrador (paisID,nome,genero,dataNascimento,username,password) VALUES (193,'AdministradorProto','Masculino','06/09/1998','admin_proto','13bfea3892ba2b5683c6a8f2ebf2b8b182ec1044');

/* ------------------------------------------------------ R19 Login ------------------------------------------------------ */
INSERT INTO Login (administradorID) VALUES (6);
INSERT INTO Login (administradorID) VALUES (5);
INSERT INTO Login (administradorID) VALUES (3);
INSERT INTO Login (administradorID) VALUES (5);
INSERT INTO Login (administradorID) VALUES (5);
INSERT INTO Login (administradorID) VALUES (5);
INSERT INTO Login (administradorID) VALUES (3);
INSERT INTO Login (administradorID) VALUES (3);
INSERT INTO Login (administradorID) VALUES (5);
INSERT INTO Login (administradorID) VALUES (2);
INSERT INTO Login (administradorID) VALUES (3);
INSERT INTO Login (administradorID) VALUES (6);
INSERT INTO Login (administradorID) VALUES (2);
INSERT INTO Login (administradorID) VALUES (2);
INSERT INTO Login (administradorID) VALUES (6);
INSERT INTO Login (administradorID) VALUES (2);
INSERT INTO Login (administradorID) VALUES (5);
INSERT INTO Login (administradorID) VALUES (1);
INSERT INTO Login (administradorID) VALUES (4);
INSERT INTO Login (funcionarioID) VALUES (1);
INSERT INTO Login (funcionarioID) VALUES (4);
INSERT INTO Login (funcionarioID) VALUES (3);
INSERT INTO Login (funcionarioID) VALUES (2);
INSERT INTO Login (funcionarioID) VALUES (1);
INSERT INTO Login (funcionarioID) VALUES (5);
INSERT INTO Login (funcionarioID) VALUES (2);
INSERT INTO Login (funcionarioID) VALUES (1);
INSERT INTO Login (funcionarioID) VALUES (3);
INSERT INTO Login (funcionarioID) VALUES (4);
INSERT INTO Login (funcionarioID) VALUES (1);
INSERT INTO Login (funcionarioID) VALUES (5);
INSERT INTO Login (funcionarioID) VALUES (3);
INSERT INTO Login (funcionarioID) VALUES (2);
INSERT INTO Login (funcionarioID) VALUES (1);
INSERT INTO Login (funcionarioID) VALUES (4);
INSERT INTO Login (clienteID) VALUES (21);
INSERT INTO Login (clienteID) VALUES (21);
INSERT INTO Login (clienteID) VALUES (20);
INSERT INTO Login (clienteID) VALUES (5);
INSERT INTO Login (clienteID) VALUES (1);
INSERT INTO Login (clienteID) VALUES (7);
INSERT INTO Login (clienteID) VALUES (12);
INSERT INTO Login (clienteID) VALUES (3);
INSERT INTO Login (clienteID) VALUES (11);
INSERT INTO Login (clienteID) VALUES (19);
INSERT INTO Login (clienteID) VALUES (5);
INSERT INTO Login (clienteID) VALUES (6);
INSERT INTO Login (clienteID) VALUES (13);
INSERT INTO Login (clienteID) VALUES (12);
INSERT INTO Login (clienteID) VALUES (1);

/* ------------------------------------------------------ R24 Encomenda ------------------------------------------------------ */
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (1,1,1,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (9,9,9,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (13,13,13,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (11,11,11,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (3,3,3,'Em processamento');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (9,9,9,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (11,11,11,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (18,18,18,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (15,15,15,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (13,13,13,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (20,20,20,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (10,10,10,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (14,14,14,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (6,6,6,'Em processamento');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (7,7,7,'Cancelada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (3,3,3,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (5,5,5,'Cancelada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (6,6,6,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (14,14,14,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (21,21,21,'Cancelada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (12,12,12,'Em processamento');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (20,20,20,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (6,6,6,'Cancelada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (11,11,11,'Em processamento');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (19,19,19,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (19,19,19,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (3,3,3,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (8,8,8,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (11,11,11,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (9,9,9,'Cancelada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (22,22,22,'Enviada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (22,22,22,'Processada');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (22,22,22,'Devolvida');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (22,22,22,'Em processamento');
INSERT INTO Encomenda (clienteID,moradaFaturacaoID,moradaEnvioID,estado) VALUES (22,22,22,'Cancelada');

/* ------------------------------------------------------ R27 MetodoPagamento ------------------------------------------------------ */
INSERT INTO MetodoPagamento (tipo) VALUES ('Multibanco');
INSERT INTO MetodoPagamento (tipo) VALUES ('Visa');
INSERT INTO MetodoPagamento (tipo) VALUES ('Transferencia Bancaria');
INSERT INTO MetodoPagamento (tipo) VALUES ('A Cobranca');
INSERT INTO MetodoPagamento (tipo) VALUES ('PayPal');
INSERT INTO MetodoPagamento (tipo) VALUES ('MBnet');
INSERT INTO MetodoPagamento (tipo) VALUES ('PaySafeCard');
INSERT INTO MetodoPagamento (tipo) VALUES ('MoneyBookers');

/* ------------------------------------------------------ R26 InformacaoFaturacao ------------------------------------------------------ */
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=1;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=2;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=3;
UPDATE InformacaoFaturacao SET metodoPagamentoID=5 WHERE informacaofaturacaoID=4;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=5;
UPDATE InformacaoFaturacao SET metodoPagamentoID=6 WHERE informacaofaturacaoID=6;
UPDATE InformacaoFaturacao SET metodoPagamentoID=4 WHERE informacaofaturacaoID=7;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=8;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=9;
UPDATE InformacaoFaturacao SET metodoPagamentoID=3 WHERE informacaofaturacaoID=10;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=11;
UPDATE InformacaoFaturacao SET metodoPagamentoID=6 WHERE informacaofaturacaoID=12;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=13;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=14;
UPDATE InformacaoFaturacao SET metodoPagamentoID=4 WHERE informacaofaturacaoID=15;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=16;
UPDATE InformacaoFaturacao SET metodoPagamentoID=6 WHERE informacaofaturacaoID=17;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=18;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=19;
UPDATE InformacaoFaturacao SET metodoPagamentoID=3 WHERE informacaofaturacaoID=20;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=21;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=22;
UPDATE InformacaoFaturacao SET metodoPagamentoID=5 WHERE informacaofaturacaoID=23;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=24;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=25;
UPDATE InformacaoFaturacao SET metodoPagamentoID=3 WHERE informacaofaturacaoID=26;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=27;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=28;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=29;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=30;
UPDATE InformacaoFaturacao SET metodoPagamentoID=1 WHERE informacaofaturacaoID=31;
UPDATE InformacaoFaturacao SET metodoPagamentoID=2 WHERE informacaofaturacaoID=32;
UPDATE InformacaoFaturacao SET metodoPagamentoID=4 WHERE informacaofaturacaoID=33;
UPDATE InformacaoFaturacao SET metodoPagamentoID=5 WHERE informacaofaturacaoID=34;
UPDATE InformacaoFaturacao SET metodoPagamentoID=6 WHERE informacaofaturacaoID=35;

/* ------------------------------------------------------ R25 PublicacaoEncomenda ------------------------------------------------------ */
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (43,1);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (39,1);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (34,2);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (58,2);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (81,3);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (93,3);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (17,4);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (30,4);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (81,5);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (10,5);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (51,6);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (3,6);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (29,7);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (82,7);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (94,8);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (21,8);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (31,9);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (58,9);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (66,10);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (89,10);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (71,11);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (33,11);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (24,12);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (19,12);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (69,13);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (16,13);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (16,14);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (34,14);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (49,15);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (66,15);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (7,16);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (72,16);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (67,17);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (31,17);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (57,18);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (39,18);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (92,19);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (67,19);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (8,20);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (11,20);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (14,21);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (73,21);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (8,22);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (21,22);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (21,23);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (2,23);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (72,24);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (16,24);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (36,25);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (68,25);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (84,26);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (31,26);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (29,27);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (80,27);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (83,28);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (39,28);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (26,29);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (82,29);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (68,30);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (30,30);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (2,31);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (8,31);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (11,31);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (15,32);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (18,32);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (3,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (17,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (28,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (5,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (19,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (23,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (26,33);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (7,34);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (16,34);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (17,34);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (24,34);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (37,34);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (13,35);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (29,35);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (32,35);
INSERT INTO PublicacaoEncomenda (publicacaoID,encomendaID) VALUES (43,35);

/* ------------------------------------------------------ R6 Comentario ------------------------------------------------------ */
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (1,43,1,'Não gostei nada do livro, penso que foi dinheiro mal gasto.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (1,39,1,'Deveria ter gasto o dinheiro em outro livro.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (9,34,4,'Achei bastante interessante, faltava no final uma conclusao para valer as 5 estrelas');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (9,58,3,'Não está mau, mas tambem não está bom, poderia ser melhor');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (13,81,1,'Não gostei nada do livro, penso que foi dinheiro mal gasto.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (13,93,4,'Bastante bom, bem parametrizado e muito informativo');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (11,17,4,'Achei bastante interessante, faltava algo no final para valer as 5 estrel');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (11,30,1,'Deveria ter gasto o dinheiro em outro livro.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (3,81,1,'Não gostei nada do livro, penso que foi dinheiro mal gasto.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (3,10,3,'Poderia ter gasto dinheiro noutro livro melhor.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (9,51,3,'Poderia ter gasto dinheiro noutro livro melhor.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (9,3,2,'Não achei o livro nada de especial, penso que poderiam ter explicitado melhor a informação');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (11,29,1,'Não gostei nada do livro, penso que foi dinheiro mal gasto.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (11,82,5,'5 estrelas, tudo perfeito, sem nenhum defeito, bastante bom, excelente');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (18,94,4,'Achei bastante interessante, faltava algo no final para valer as 5 estrel');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (18,21,1,'Não gostei nada do livro, penso que foi dinheiro mal gasto.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (15,31,3,'Poderia ter gasto dinheiro noutro livro melhor.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (15,58,3,'Não está mau, mas tambem não está bom, poderia ser melhor');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (13,66,3,'Poderia ter gasto dinheiro noutro livro melhor.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (13,89,5,'5 estrelas, tudo perfeito, sem nenhum defeito, bastante bom, excelente');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (20,71,1,'Deveria ter gasto o dinheiro em outro livro.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (20,33,4,'Bastante bom, bem parametrizado e muito informativo');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (10,24,4,'Achei bastante interessante, faltava algo no final para valer as 5 estrel');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (10,19,4,'Bastante bom, bem parametrizado e muito informativo');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (14,69,3,'Não está mau, mas tambem não está bom, poderia ser melhor');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (14,16,4,'Bastante bom, bem parametrizado e muito informativo');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (6,16,2,'Não achei o livro nada de especial, penso que poderiam ter explicitado melhor a informação');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (6,34,1,'Não gostei nada do livro, penso que foi dinheiro mal gasto.');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (7,49,5,'5 estrelas, tudo perfeito, sem nenhum defeito, bastante bom, excelente');
INSERT INTO Comentario (clienteID,publicacaoID,classificacao,texto) VALUES (7,66,4,'Achei bastante interessante, faltava algo no final para valer as 5 estrel');

/* ------------------------------------------------------ R28 CartaoCredito ------------------------------------------------------ */
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (1,'MasterCard','5202765077828229','22/05/2015','935');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (3,'MasterCard','5430691565133761','14/08/2011','983');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (8,'AmericanExpress','370260745421182','07/06/2010','837');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (13,'Visa','4916986359778797','05/06/2010','854');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (18,'AmericanExpress','377474126024732','26/04/2012','385');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (22,'Visa','4556648286082744','02/05/2016','376');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (25,'MasterCard','5409854996751109','01/06/2014','831');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (27,'MasterCard','5526905920137779','24/09/2011','610');
INSERT INTO CartaoCredito (cartaocreditoid,tipo,numero,validade,cvv) VALUES (30,'AmericanExpress','370211408726086','06/07/2013','276');

/* ------------------------------------------------------ R29 Multibanco ------------------------------------------------------ */
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (2,'61624','614 976 849');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (5,'75491','395 315 825');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (9,'65582','182 226 819');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (11,'72157','686 128 244');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (14,'37188','328 165 191');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (16,'87488','655 663 668');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (19,'31585','232 614 235');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (21,'91247','117 778 349');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (24,'12416','758 365 939');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (28,'39498','823 263 724');
INSERT INTO Multibanco (multibancoid,entidade,referencia) VALUES (29,'33338','459 581 165');

/* ------------------------------------------------------ R30 Pesquisa ------------------------------------------------------ */
INSERT INTO Pesquisa (expressao) VALUES ('Livro');
INSERT INTO Pesquisa (expressao) VALUES ('Livro');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Revista');
INSERT INTO Pesquisa (expressao) VALUES ('Revista');
INSERT INTO Pesquisa (expressao) VALUES ('Jornal');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Arte');
INSERT INTO Pesquisa (expressao) VALUES ('Jornal');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Jornal');
INSERT INTO Pesquisa (expressao) VALUES ('Livro');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Arte');
INSERT INTO Pesquisa (expressao) VALUES ('Revista');
INSERT INTO Pesquisa (expressao) VALUES ('Revista');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Embalar');
INSERT INTO Pesquisa (expressao) VALUES ('Livro');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Historias');
INSERT INTO Pesquisa (expressao) VALUES ('Jornal');
INSERT INTO Pesquisa (expressao) VALUES ('Men');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Arte');
INSERT INTO Pesquisa (expressao) VALUES ('Revista');
INSERT INTO Pesquisa (expressao) VALUES ('Livro');
INSERT INTO Pesquisa (expressao) VALUES ('Livro');
INSERT INTO Pesquisa (expressao) VALUES ('Spider');
INSERT INTO Pesquisa (expressao) VALUES ('Embalar');
INSERT INTO Pesquisa (expressao) VALUES ('Historias');
INSERT INTO Pesquisa (expressao) VALUES ('Historias');
INSERT INTO Pesquisa (expressao) VALUES ('Exames');
INSERT INTO Pesquisa (expressao) VALUES ('Embalar');
INSERT INTO Pesquisa (expressao) VALUES ('Historias');
INSERT INTO Pesquisa (expressao) VALUES ('Preparacao');
INSERT INTO Pesquisa (expressao) VALUES ('Men');

/* ------------------------------------------------------ R31 PerguntaUtilizador ------------------------------------------------------ */
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Lacy Sexton','ornare.facilisis.eget@euaugueporttitor.edu','Posso levantar em loja física?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Cameron Rhodes','et.libero@etipsum.ca','Olá, pode indicar quais os métodos de pagamento disponíveis?',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Faith Grant','Sed.auctor@nullaat.org','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Aretha Mcdaniel','nec.euismod@nibh.ca','Olá, pode indicar quais os métodos de pagamento disponíveis?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Ulla Leach','erat.eget@facilisislorem.ca','Não consigo esperar mais pela minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Angela Bartlett','ut.molestie.in@at.org','Não consigo esperar mais pela minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Zorita Mercado','Curabitur.consequat.lectus@sedturpis.edu','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Frances Norman','nec@velit.org','Posso levantar em loja física?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Eugenia Douglas','gravida.molestie@nequevenenatislacus.co.uk','Olá, pode indicar quais os métodos de pagamento disponíveis?',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Regina Cooke','semper.rutrum.Fusce@atortorNunc.org','Não consigo esperar mais pela minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Colin Sears','eu@aliquet.net','Posso levantar em loja física?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Sierra Yates','vestibulum@imperdieteratnonummy.com','Olá, quanto tempo demora a chegar a minha encomenda?',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Elmo Mccullough','tempor.diam@magnis.co.uk','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Hashim Dudley','lectus.Nullam.suscipit@tristique.org','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Grady Roberson','cursus.Integer.mollis@Namporttitorscelerisque.edu','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Jakeem Burt','velit@seddolor.edu','Olá, quanto tempo demora a chegar a minha encomenda?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Berk Riggs','convallis.dolor.Quisque@Nullamenim.org','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Sylvia Hardy','quis.accumsan@semPellentesque.net','Olá, pode indicar quais os métodos de pagamento disponíveis?',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Avram Hebert','mi.Duis@mauriserat.co.uk','Posso levantar em loja física?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Jaden David','non.sollicitudin@Donec.ca','Não consigo esperar mais pela minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Kyle Huffman','Curabitur@Donec.ca','Não consigo esperar mais pela minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Fallon Hardy','aliquet@diamProindolor.net','Posso levantar em loja física?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Lael Lynn','hendrerit.Donec@libero.org','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Octavius Merritt','auctor.velit.Aliquam@volutpatnuncsit.org','Olá, quanto tempo demora a chegar a minha encomenda?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Laura Frye','nec.leo.Morbi@commodotincidunt.co.uk','Olá, pode indicar quais os métodos de pagamento disponíveis?',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Jarrod Powell','ac.nulla.In@tincidunt.edu','Não consigo esperar mais pela minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Preston Carr','accumsan.convallis.ante@gravida.org','Olá, pode indicar quais os métodos de pagamento disponíveis?',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Quyn Mcmillan','tempus.lorem@ultrices.org','Não consigo esperar mais pela minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Lana Crosby','et.netus@utlacusNulla.edu','Olá, pode indicar quais os métodos de pagamento disponíveis?',FALSE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Serena Mccarty','mus.Proin@fringilla.com','Olá, tudo bem? Tenho uma duvida relativamente à minha encomenda',TRUE);
INSERT INTO PerguntaUtilizador (nome,email,mensagem,respondido) VALUES ('Orson Dennis','Proin.vel@Donecnonjusto.co.uk','Posso levantar em loja física?',TRUE);

/* ------------------------------------------------------ R32 Armazem ------------------------------------------------------ */
INSERT INTO Armazem (PrimaveraArmazemID,Nome) VALUES ('ACOIM','Armazem Coimbra');
INSERT INTO Armazem (PrimaveraArmazemID,Nome) VALUES ('ALIS','Armazem Lisboa');
INSERT INTO Armazem (PrimaveraArmazemID,Nome) VALUES ('AONL','Armazem Online');
INSERT INTO Armazem (PrimaveraArmazemID,Nome) VALUES ('APOR','Armazem Porto');

/* ------------------------------------------------------ R33 ArmazemPublicacao ------------------------------------------------------ */
/* ------------------------------------------------------ Armazem Coimbra ------------------------------------------------------ */
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','1', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','2', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','3', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','4', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','5', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','6', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','7', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','8', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','9', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','10', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','11', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','12', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','13', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','14', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','15', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','16', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','17', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','18', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','19', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','20', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','21', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','22', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','23', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','24', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','25', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','26', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','27', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','28', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','29', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','30', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','31', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','32', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','33', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','34', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','35', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','36', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','37', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','38', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','39', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','40', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','41', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','42', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','43', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','44', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','45', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','46', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','47', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','48', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','49', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','50', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','51', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','52', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','53', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','54', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','55', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','56', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','57', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','58', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','59', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','60', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','61', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','62', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','63', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','64', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','65', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','66', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','67', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','68', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','69', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','70', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','71', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','72', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','73', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','74', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','75', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','76', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','77', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','78', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','79', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','80', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','81', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','82', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','83', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','84', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','85', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','86', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','87', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','88', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','89', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','90', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','91', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','92', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','93', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','94', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('1','95', 2);

/* ------------------------------------------------------ Armazem Lisboa ------------------------------------------------------ */
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','1', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','2', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','3', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','4', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','5', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','6', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','7', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','8', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','9', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','10', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','11', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','12', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','13', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','14', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','15', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','16', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','17', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','18', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','19', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','20', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','21', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','22', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','23', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','24', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','25', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','26', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','27', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','28', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','29', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','30', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','31', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','32', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','33', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','34', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','35', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','36', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','37', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','38', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','39', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','40', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','41', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','42', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','43', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','44', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','45', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','46', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','47', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','48', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','49', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','50', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','51', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','52', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','53', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','54', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','55', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','56', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','57', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','58', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','59', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','60', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','61', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','62', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','63', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','64', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','65', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','66', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','67', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','68', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','69', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','70', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','71', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','72', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','73', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','74', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','75', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','76', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','77', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','78', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','79', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','80', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','81', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','82', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','83', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','84', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','85', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','86', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','87', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','88', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','89', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','90', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','91', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','92', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','93', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','94', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('2','95', 2);

/* ------------------------------------------------------ Armazem Online ------------------------------------------------------ */
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','1', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','2', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','3', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','4', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','5', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','6', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','7', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','8', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','9', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','10', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','11', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','12', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','13', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','14', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','15', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','16', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','17', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','18', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','19', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','20', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','21', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','22', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','23', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','24', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','25', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','26', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','27', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','28', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','29', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','30', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','31', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','32', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','33', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','34', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','35', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','36', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','37', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','38', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','39', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','40', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','41', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','42', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','43', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','44', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','45', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','46', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','47', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','48', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','49', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','50', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','51', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','52', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','53', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','54', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','55', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','56', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','57', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','58', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','59', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','60', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','61', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','62', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','63', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','64', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','65', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','66', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','67', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','68', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','69', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','70', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','71', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','72', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','73', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','74', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','75', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','76', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','77', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','78', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','79', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','80', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','81', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','82', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','83', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','84', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','85', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','86', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','87', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','88', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','89', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','90', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','91', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','92', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','93', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','94', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('3','95', 2);

/* ------------------------------------------------------ Armazem Porto ------------------------------------------------------ */
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','1', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','2', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','3', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','4', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','5', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','6', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','7', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','8', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','9', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','10', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','11', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','12', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','13', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','14', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','15', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','16', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','17', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','18', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','19', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','20', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','21', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','22', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','23', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','24', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','25', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','26', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','27', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','28', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','29', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','30', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','31', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','32', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','33', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','34', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','35', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','36', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','37', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','38', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','39', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','40', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','41', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','42', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','43', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','44', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','45', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','46', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','47', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','48', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','49', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','50', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','51', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','52', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','53', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','54', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','55', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','56', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','57', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','58', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','59', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','60', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','61', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','62', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','63', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','64', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','65', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','66', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','67', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','68', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','69', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','70', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','71', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','72', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','73', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','74', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','75', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','76', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','77', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','78', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','79', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','80', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','81', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','82', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','83', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','84', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','85', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','86', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','87', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','88', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','89', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','90', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','91', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','92', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','93', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','94', 2);
INSERT INTO ArmazemPublicacao (ArmazemID,PublicacaoID,Stock) VALUES ('4','95', 2);