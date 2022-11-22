
use bd_eleicao

DROP TABLE IF EXISTS AUX_CANDIDATO
DROP TABLE IF EXISTS AUX_LOCALIDADE
DROP TABLE IF EXISTS AUX_LOCALIDADE_ELEICAO
DROP TABLE IF EXISTS AUX_CARGO
DROP TABLE IF EXISTS AUX_SESSAO
DROP TABLE IF EXISTS AUX_ELEITOR
DROP TABLE IF EXISTS AUX_TIPO_VOTO
DROP TABLE IF EXISTS AUX_VOTO
DROP TABLE IF EXISTS AUX_TEMPO


CREATE TABLE AUX_CANDIDATO(
       DATA_CARGA DATETIME NULL,
	   COD_CANDIDATO INT NULL,
	   NM_CANDIDATO VARCHAR(100) NULL,
	   CPF CHAR(11) NULL,
	   COD_CARGO INT NULL,
	   CARGO VARCHAR(50) NULL,
	   COD_PARTIDO INT NULL,
	   PARTIDO VARCHAR(200) NULL,
	   --TIPO_VOTO VARCHAR(50) NOT NULL CHECK(TIPO_VOTO IN (''))
	   CNPJ CHAR(14) NULL
)

CREATE TABLE AUX_LOCALIDADE(
    DATA_CARGA DATETIME NULL,
	COD_ESTADO INT NULL,
    ESTADO VARCHAR(50) NULL,
	COD_CIDADE INT NULL,
	CIDADE VARCHAR(50) NULL
)

CREATE TABLE AUX_LOCALIDADE_ELEICAO(
      DATA_CARGA DATETIME NULL,
	  COD_LOCALIDADE_ELEICAO INT NULL,
      LOCALIDADE VARCHAR(100) NULL,
	  TIPO_LOCALIDADE VARCHAR(50) NULL CHECK(TIPO_LOCALIDADE IN ('ESTADO', 'MUNICIPIO', 'PAIS')),
	  UF_ESTADO CHAR(2) NULL
)

CREATE TABLE AUX_CARGO(
     DATA_CARGA DATETIME NOT NULL,
	 COD_CARGO INT NOT NULL,
     CARGO VARCHAR(100) NOT NULL
)

CREATE TABLE AUX_TEMPO(
	DATA_CARGA DATETIME NULL,
	COD_ANO_TURNO INT NULL,
	ANO INT NULL,
	TURNO VARCHAR(10) NULL CHECK(TURNO IN ('1�TURNO', '2�TURNO'))
)

CREATE TABLE AUX_SECAO(
    DATA_CARGA DATETIME NULL,
    COD_SECAO INT NULL,
	NM_SECAO VARCHAR(50) NULL,
	ZONA VARCHAR(50) NULL
)

CREATE TABLE AUX_ELEITOR(
    DATA_CARGA DATETIME NULL,
	COD_ELEITOR INT NULL,
    CPF CHAR(11) NULL UNIQUE,
	NM_SECAO VARCHAR(50) NULL,
	ZONA VARCHAR(50) NULL
)

CREATE TABLE AUX_TIPO_VOTO(
	DATA_CARGA DATETIME NULL,
	COD_TIPO_VOTO INT NULL,
	TIPO_VOTO VARCHAR(50) NULL CHECK(TIPO_VOTO IN ('BRANCOS', 'NULOS', 'VALIDOS'))
)

CREATE TABLE AUX_VOTO(
    DATA_CARGA DATETIME NULL,
    COD_ELEITOR INT NULL,
	COD_TIPO_VOTO INT NULL,
	COD_CANDIDATO INT NULL,
	COD_CIDADE INT NULL,
	COD_ESTADO INT NULL,
	COD_SECAO INT NULL,
	COD_CARGO INT NULL,
	COD_LOCALIDADE_ELEICAO INT NULL,
	COD_ANO_TURNO INT NULL
)

CREATE TABLE AUX_VIOLACAO(
    DATA_CARGA DATETIME NULL,
    COD_ELEITOR INT NULL,
	COD_TIPO_VOTO INT NULL,
	COD_CANDIDATO INT NULL,
	COD_CIDADE INT NULL,
	COD_ESTADO INT NULL,
	COD_SECAO INT NULL,
	COD_CARGO INT NULL,
	COD_LOCALIDADE_ELEICAO INT NULL,
	COD_ANO_TURNO INT NULL, 
	ERRO VARCHAR(100)


)


