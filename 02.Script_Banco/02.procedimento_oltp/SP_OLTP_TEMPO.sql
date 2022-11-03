
CREATE OR ALTER PROCEDURE SP_OLTP_TEMPO(@DATA_CARGA DATETIME)
AS
BEGIN
	DELETE AUX_TEMPO
	WHERE DATA_CARGA = @DATA_CARGA
	INSERT INTO AUX_TEMPO(DATA_CARGA, ANO, TURNO)
	SELECT @DATA_CARGA, ANO, TURNO FROM TB_ANO_TURNO
END
SELECT * FROM AUX_TEMPO
