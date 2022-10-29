
use bd_eleicao

DROP TABLE IF EXISTS DIM_CANDIDATO
DROP TABLE IF EXISTS DIM_LOCALIDADE
DROP TABLE IF EXISTS DIM_LOCALIDADE_ELEICAO
DROP TABLE IF EXISTS DIM_CARGO
DROP TABLE IF EXISTS DIM_TEMPO
DROP TABLE IF EXISTS DIM_SESSAO
DROP TABLE IF EXISTS DIM_ELEITOR
DROP TABLE IF EXISTS DIM_TIPO_VOTO
DROP TABLE IF EXISTS FATO_VOTO


CREATE TABLE DIM_CANDIDATO(
	ID_CANDIDATO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_CANDIDATO INT NOT NULL,
	NM_CANDIDATO VARCHAR(100) NOT NULL,
	CPF CHAR(11) NOT NULL UNIQUE,
	COD_CARGO INT NOT NULL,
	CARGO VARCHAR(50) NOT NULL,
	COD_PARTIDO INT NOT NULL,
	PARTIDO VARCHAR(200) NULL,
	--TIPO_VOTO VARCHAR(50) NOT NULL CHECK(TIPO_VOTO IN (''))
	CNPJ CHAR(14) NOT NULL UNIQUE
)

CREATE TABLE DIM_LOCALIDADE(
	ID_LOCALIDADE INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ESTADO CHAR(2) NOT NULL,
	CIDADE VARCHAR(50) NOT NULL,
)

CREATE TABLE DIM_LOCALIDADE_ELEICAO(
    ID_LOCALIDADE_ELEICAO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	LOCALIDADE VARCHAR(100) NOT NULL,
	TIPO_LOCALIDADE VARCHAR(50) NOT NULL CHECK(TIPO_LOCALIDADE IN ('ESTADO', 'MUNICIPIO', 'PAIS')),
	UF_ESTADO CHAR(2) NOT NULL
)

CREATE TABLE DIM_CARGO(
    ID_CARGO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CARGO VARCHAR(100) NOT NULL
)

CREATE TABLE DIM_TEMPO(
	ID_TEMPO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ANO INT NOT NULL,
	TURNO VARCHAR(10) NOT NULL CHECK(TURNO IN ('1ºTURNO', '2ºTURNO'))
)

CREATE TABLE DIM_SESSAO(
	ID_SESSAO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_SESSAO INT NOT NULL,
	NM_SESSAO VARCHAR(50) NOT NULL,
	ZONA VARCHAR(50) NOT NULL
)

CREATE TABLE DIM_ELEITOR(
	ID_ELEITOR INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CPF CHAR(11) NOT NULL UNIQUE,
	NM_ELEITOR VARCHAR(100),
	NM_SESSAO VARCHAR(50) NOT NULL,
	ZONA VARCHAR(50) NOT NULL
)

CREATE TABLE DIM_TIPO_VOTO(
	ID_TIPO_VOTO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TIPO_VOTO VARCHAR(50) NOT NULL CHECK(TIPO_VOTO IN ('BRANCOS', 'NULOS', 'VALIDOS'))
)

CREATE TABLE FATO_VOTO(
	ID_ELEITOR INT NOT NULL,
	ID_TIPO_VOTO INT NOT NULL,
	ID_CANDIDATO INT NOT NULL,
	ID_LOCALIDADE INT NOT NULL,
	ID_SESSAO INT NOT NULL,
	DIA_VOTACAO INT NOT NULL, --ID_TEMPO
	ID_CARGO INT NOT NULL,
	ID_LOCALIDADE_ELEICAO INT NOT NULL,
	QUANTIDADE_VOTOS INT DEFAULT(1),
	CONSTRAINT FK_FATO_VOTO_ELEITOR FOREIGN KEY (ID_ELEITOR) REFERENCES DIM_ELEITOR(ID_ELEITOR),
	CONSTRAINT FK_FATO_VOTO_TIPO_VOTO FOREIGN KEY (ID_TIPO_VOTO) REFERENCES DIM_TIPO_VOTO(ID_TIPO_VOTO),
	CONSTRAINT FK_FATO_VOTO_CANDIDATO FOREIGN KEY (ID_CANDIDATO) REFERENCES DIM_CANDIDATO(ID_CANDIDATO),
	CONSTRAINT FK_FATO_VOTO_LOCALIDADE FOREIGN KEY (ID_LOCALIDADE) REFERENCES DIM_LOCALIDADE(ID_LOCALIDADE),
	CONSTRAINT FK_FATO_VOTO_SESSAO FOREIGN KEY (ID_SESSAO) REFERENCES DIM_SESSAO(ID_SESSAO),
	CONSTRAINT FK_FATO_VOTO_TEMPO FOREIGN KEY (DIA_VOTACAO) REFERENCES DIM_TEMPO(ID_TEMPO),
	CONSTRAINT FK_FATO_VOTO_CARGO FOREIGN KEY (ID_CARGO) REFERENCES DIM_CARGO(ID_CARGO),
	CONSTRAINT FK_FATO_VOTO_LOCALIDADE_ELEICAO FOREIGN KEY (ID_LOCALIDADE_ELEICAO) REFERENCES DIM_LOCALIDADE_ELEICAO(ID_LOCALIDADE_ELEICAO)
)

SELECT * FROM FATO_VOTO


