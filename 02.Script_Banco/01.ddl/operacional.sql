USE BD_ELEICAO
DROP DATABASE bd_eleicao

DROP TABLE IF EXISTS TB_ESTADO
DROP TABLE IF EXISTS TB_CIDADE
DROP TABLE IF EXISTS TB_ELEITOR
DROP TABLE IF EXISTS TB_PARTIDO
DROP TABLE IF EXISTS TB_CARGO
DROP TABLE IF EXISTS TB_CANDIDATO
DROP TABLE IF EXISTS TB_VOTO
DROP TABLE IF EXISTS TB_SECAO
DROP TABLE IF EXISTS TB_ANO_TURNO
DROP TABLE IF EXISTS TB_TIPO_VOTO

--ordem de cria��o das tabelas:
--1- tb_partido
--2  tb_cargo
--3  tb_candidato
--4  tb_eleitor
--5  tb_ano_turno
--6  tb_estado
--7  tb_cidade
--8  tb_sessao
--9  tb_tipo_voto
--10 tb_localidade_eleicao
--11 tb_voto

CREATE TABLE TB_PARTIDO(
             ID_PARTIDO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			 NM_PARTIDO VARCHAR(100) NOT NULL,
			 CNPJ CHAR(14) NOT NULL
)
INSERT INTO TB_PARTIDO VALUES('Partido dos Trabalhadores','11111111111111')
INSERT INTO TB_PARTIDO VALUES('Partido Progressista','22222222222222')
INSERT INTO TB_PARTIDO VALUES('Partido Liberal','33333333333333')



CREATE TABLE TB_CANDIDATO(
             ID_CANDIDATO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			 NM_CANDIDATO VARCHAR(100) NOT NULL,
			 CPF CHAR(11) NOT NULL UNIQUE,
			 REELEICAO CHAR(3) NOT NULL CHECK (REELEICAO IN ('SIM', 'NAO')), 
			 ID_PARTIDO INT NOT NULL REFERENCES TB_PARTIDO(ID_PARTIDO),
			 ID_CARGO INT NOT NULL REFERENCES TB_CARGO(ID_CARGO)
)
INSERT INTO TB_CANDIDATO VALUES('Bolsonaro','111111111','sim',3,1)
INSERT INTO TB_CANDIDATO VALUES('Lula','222222222','nao',1,1)
INSERT INTO TB_CANDIDATO VALUES('Talison de Valmir','333333333','sim',3,4)
INSERT INTO TB_CANDIDATO VALUES('Rogerio Carvalho','444444444','nao',1,2)
INSERT INTO TB_CANDIDATO VALUES('Valmir de Fransisquinho','555555555','nao',3,2)
INSERT INTO TB_CANDIDATO VALUES('F�bio Mitidieri','666666666','nao',3,2)

CREATE TABLE TB_CARGO(
            ID_CARGO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			NM_CARGO VARCHAR(100) NOT NULL
)
INSERT INTO TB_CARGO VALUES('Presidente')
INSERT INTO TB_CARGO VALUES('Governador')
INSERT INTO TB_CARGO VALUES('Senador')
INSERT INTO TB_CARGO VALUES('Deputado estadual')
INSERT INTO TB_CARGO VALUES('Deputado federal')

CREATE TABLE TB_ELEITOR(
           ID_ELEITOR INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
		   NUMERO_TITULO VARCHAR(50) NOT NULL,
		   CPF CHAR(11) NOT NULL UNIQUE,
		   SECAO VARCHAR(50) NOT NULL,
		   ZONA VARCHAR(50) NOT NULL
)
INSERT INTO TB_ELEITOR VALUES('000000000000','01010101010','145','1� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('111111111111','02020202020','169','2� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('222222222222','03030303030','178','1� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('333333333333','04040404040','146','1� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('444444444444','05050505050','175','4� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('555555555555','06060606060','145','1� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('666666666666','07070707070','120','5� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('777777777777','08080808080','135','6� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('888888888888','09090909090','145','10� Zona elitoral')
INSERT INTO TB_ELEITOR VALUES('999999999999','00000000000','145','1� Zona elitoral')

CREATE TABLE TB_VOTO(
           ID_CANDIDATO INT NOT NULL REFERENCES TB_CANDIDATO(ID_CANDIDATO), 
		   ID_ELEITOR INT NOT NULL REFERENCES TB_ELEITOR(ID_ELEITOR),
		   PRIMARY KEY(ID_CANDIDATO, ID_ELEITOR),
		   ID_ANO_TURNO INT NOT NULL REFERENCES TB_ANO_TURNO(ID_ANO_TURNO),
		   ID_TIPO_VOTO INT NOT NULL REFERENCES TB_TIPO_VOTO(ID_TIPO_VOTO),
		   ID_LOCALIDADE_ELEICAO INT NOT NULL REFERENCES TB_LOCALIDADE_ELEICAO(ID_LOCALIDADE_ELEICAO),
		   ID_SECAO INT NOT NULL REFERENCES TB_SECAO(ID_SECAO)
)
INSERT INTO TB_VOTO VALUES(1,1,2,1,1,1)
INSERT INTO TB_VOTO VALUES(2,3,2,3,2,2)
INSERT INTO TB_VOTO VALUES(3,1,2,2,3,3)
INSERT INTO TB_VOTO VALUES(5,1,1,1,4,4)
INSERT INTO TB_VOTO VALUES(4,2,2,1,5,5)
INSERT INTO TB_VOTO VALUES(1,4,1,2,6,6)
INSERT INTO TB_VOTO VALUES(1,6,1,2,7,7)
INSERT INTO TB_VOTO VALUES(1,8,2,3,8,8)
INSERT INTO TB_VOTO VALUES(3,7,2,1,9,9)
INSERT INTO TB_VOTO VALUES(4,5,1,1,10,10)

CREATE TABLE TB_ANO_TURNO(
          ID_ANO_TURNO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		  ANO INT NOT NULL,
		  TURNO VARCHAR(10) NOT NULL CHECK(TURNO IN ('1�TURNO', '2�TURNO'))
)
INSERT INTO TB_ANO_TURNO VALUES(2022,'1�TURNO')
INSERT INTO TB_ANO_TURNO VALUES(2022,'2�TURNO')

CREATE TABLE TB_SECAO(
          ID_SECAO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		  SECAO VARCHAR(50) NOT NULL,
		  ZONA VARCHAR(50) NOT NULL,
		  ID_CIDADE INT NOT NULL REFERENCES TB_CIDADE(ID_CIDADE)
)
INSERT INTO TB_SECAO VALUES('145','1� Zona elitoral',1)
INSERT INTO TB_SECAO VALUES('145','10� Zona elitoral',2)
INSERT INTO TB_SECAO VALUES('169','2� Zona elitoral',2)
INSERT INTO TB_SECAO VALUES('178','1� Zona elitoral',3)
INSERT INTO TB_SECAO VALUES('175','4� Zona elitoral',4)
INSERT INTO TB_SECAO VALUES('120','5� Zona elitoral',7)
INSERT INTO TB_SECAO VALUES('135','6� Zona elitoral',8)
INSERT INTO TB_SECAO VALUES('170','1� Zona elitoral',2)
INSERT INTO TB_SECAO VALUES('148','10� Zona elitoral',1)
INSERT INTO TB_SECAO VALUES('145','4� Zona elitoral',4)

CREATE TABLE TB_CIDADE(
         ID_CIDADE INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
		 NM_CIDADE VARCHAR(200) NOT NULL,
		 ID_ESTADO INT NOT NULL REFERENCES TB_ESTADO(ID_ESTADO)
)
INSERT INTO TB_CIDADE VALUES('Itabaiana',1)
INSERT INTO TB_CIDADE VALUES('Areia Branca',1)
INSERT INTO TB_CIDADE VALUES('Macei�',2)
INSERT INTO TB_CIDADE VALUES('Arapiraca',2)
INSERT INTO TB_CIDADE VALUES('Guarulhos',3)
INSERT INTO TB_CIDADE VALUES('Campinas',3)
INSERT INTO TB_CIDADE VALUES('Beneditinos',4)
INSERT INTO TB_CIDADE VALUES('Teresina',4)

CREATE TABLE TB_ESTADO(
        ID_ESTADO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		NM_ESTADO VARCHAR(100) NOT NULL,
		UF_ESTADO CHAR(2) NOT NULL
)
INSERT INTO TB_ESTADO VALUES('Sergipe','SE')
INSERT INTO TB_ESTADO VALUES('Alagoas','AL')
INSERT INTO TB_ESTADO VALUES('S�o Paulo','SP')
INSERT INTO TB_ESTADO VALUES('Piaui','PI')

CREATE TABLE TB_TIPO_VOTO(
	ID_TIPO_VOTO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TIPO_VOTO VARCHAR(45) NOT NULL CHECK(TIPO_VOTO IN ('NULOS','BRANCOS','VALIDOS'))
)
INSERT INTO TB_TIPO_VOTO VALUES('NULOS')
INSERT INTO TB_TIPO_VOTO VALUES('BRANCOS')
INSERT INTO TB_TIPO_VOTO VALUES('VALIDOS')

CREATE TABLE TB_LOCALIDADE_ELEICAO(
      ID_LOCALIDADE_ELEICAO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
      LOCALIDADE VARCHAR(100) NOT NULL,
	  TIPO_LOCALIDADE VARCHAR(50) NOT NULL CHECK(TIPO_LOCALIDADE IN ('ESTADO', 'MUNICIPIO', 'PAIS')),
	  UF_ESTADO CHAR(2) NOT NULL
)
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Itabaiana','MUNICIPIO','SE')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Sergipe','ESTADO','SE')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Ribeir�polis','MUNICIPIO','SE')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Alagoas','ESTADO','AL')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Piau�','ESTADO','PI')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Macei�','MUNICIPIO','AL')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Areia Branca','MUNICIPIO','SE')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Teresina','MUNICIPIO','PI')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Beneditinos','MUNICIPIO','PI')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('Campinas','MUNICIPIO','SP')
INSERT INTO TB_LOCALIDADE_ELEICAO VALUES('S�o Paulo','ESTADO','SP')






SELECT * FROM TB_ESTADO
SELECT * FROM TB_CIDADE
SELECT * FROM TB_ELEITOR
SELECT * FROM TB_PARTIDO
SELECT * FROM TB_CARGO
SELECT * FROM TB_CANDIDATO
SELECT * FROM TB_VOTO
SELECT * FROM TB_SECAO
SELECT * FROM TB_ANO_TURNO
SELECT * FROM TB_TIPO_VOTO
SELECT * FROM TB_LOCALIDADE_ELEICAO