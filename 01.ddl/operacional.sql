CREATE DATABASE BD_ELEICAO
USE BD_ELEICAO

DROP TABLE IF EXISTS TB_REGIAO
DROP TABLE IF EXISTS TB_ESTADO
DROP TABLE IF EXISTS TB_CIDADE
DROP TABLE IF EXISTS TB_ELEITOR
DROP TABLE IF EXISTS TB_PARTIDO
DROP TABLE IF EXISTS TB_CARGO
DROP TABLE IF EXISTS TB_CANDIDATO
DROP TABLE IF EXISTS TB_VOTO
DROP TABLE IF EXISTS TB_SECAO


CREATE TABLE TB_PARTIDO(
             ID_PARTIDO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			 NM_PARTIFO VARCHAR(100) NOT NULL,
			 CNPJ CHAR(14) NOT NULL
)

CREATE TABLE TB_CANDIDATO(
             ID_CANDIDATO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			 NM_CANDIDATO VARCHAR(100) NOT NULL,
			 CPF CHAR(11) NOT NULL UNIQUE,
			 REELEICAO CHAR(3) NOT NULL CHECK (REELEICAO IN ('SIM', 'NAO')), 
			 ID_PARTIDO INT NOT NULL REFERENCES TB_PARTIDO(ID_PARTIDO),
			 ID_CARGO INT NOT NULL REFERENCES TB_CARGO(ID_CARGO)
)

CREATE TABLE TB_CARGO(
            ID_CARGO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			NM_CARGO VARCHAR(100) NOT NULL
)

CREATE TABLE TB_ELEITOR(
           ID_ELEITOR INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
		   NUMERO_TITULO VARCHAR(50) NOT NULL,
		   CPF CHAR(11) NOT NULL UNIQUE,
		   SECAO VARCHAR(50) NOT NULL,
		   ZONA VARCHAR(50) NOT NULL
)

CREATE TABLE TB_VOTO(
           ID_CANDIDATO INT NOT NULL REFERENCES TB_CANDIDATO(ID_CANDIDATO), 
		   ID_ELEITOR INT NOT NULL REFERENCES TB_ELEITOR(ID_ELEITOR),
		   PRIMARY KEY(ID_CANDIDATO, ID_ELEITOR),
		   DATA_VOTACAO DATETIME NULL,
		   ID_ANO_TURNO INT NOT NULL REFERENCES TB_ANO_TURNO(ID_ANO_TURNO),
		   ID_TIPO_VOTO INT NOT NULL REFERENCES TB_TIPO_VOTO(ID_TIPO_VOTO)
)

CREATE TABLE TB_ANO_TURNO(
          ID_ANO_TURNO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		  ANO INT NOT NULL,
		  TURNO VARCHAR(10) NOT NULL CHECK(TURNO IN ('1�TURNO', '2�TURNO'))
)

CREATE TABLE TB_SECAO(
          ID_SECAO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		  SECAO VARCHAR(50) NOT NULL,
		  ZONA VARCHAR(50) NOT NULL,
		  ID_CANDIDATO INT NOT NULL REFERENCES TB_CANDIDATO(ID_CANDIDATO), 
		  ID_ELEITOR INT NOT NULL REFERENCES TB_ELEITOR(ID_ELEITOR),
		  ID_CIDADE INT NOT NULL REFERENCES TB_CIDADE(ID_CIDADE)
)

CREATE TABLE TB_CIDADE(
         ID_CIDADE INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
		 NM_CIDADE VARCHAR(200) NOT NULL,
		 ID_ESTADO INT NOT NULL REFERENCES TB_ESTADO(ID_ESTADO)

)

CREATE TABLE TB_ESTADO(
        ID_ESTADO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		NM_ESTADO VARCHAR(100) NOT NULL,
)

CREATE TABLE TB_TIPO_VOTO(
	ID_TIPO_VOTO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TIPO_VOTO VARCHAR(45) NOT NULL CHECK(TIPO_VOTO IN ('NULOS','BRANCOS','VALIDOS'))
)


SELECT * FROM TB_REGIAO
SELECT * FROM TB_VOTO
