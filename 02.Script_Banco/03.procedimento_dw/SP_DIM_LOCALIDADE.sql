USE bd_eleicao

CREATE OR ALTER PROCEDURE SP_DIM_LOCALIDADE
AS 
BEGIN 
      INSERT INTO DIM_LOCALIDADE(COD_ESTADO, COD_CIDADE, ESTADO, CIDADE)
	  SELECT COD_ESTADO, COD_CIDADE, ESTADO, CIDADE FROM AUX_LOCALIDADE
END
EXEC SP_DIM_LOCALIDADE
SELECT * FROM DIM_LOCALIDADE