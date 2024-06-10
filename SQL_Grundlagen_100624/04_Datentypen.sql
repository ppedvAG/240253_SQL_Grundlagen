/*
	Datentypen in SQL: 3 große Gruppen

	1 Zeichen hat 1 Byte = 1 Byte = 8 Bit

	1. Charakter/String Datentypen
	char(10) = 'Hallo     ' = 10 Byte Speicherplatz
	nchar(10) = 'Hallo     ' = pro Zeichen = 2 Byte = 20 Byte = UTF-16 

	varchar(10) = 'Hallo'   = 5 Byte Speicherplatz
	nvarchar(10) = 'Hallo' = pro Zeichen = 2 Byte = 10 Byte = UTF-16

	Legacy: text --> mittlerweile VARCHAR(MAX) = bis zu 2 GB
	varchar(8000) & nvarchar(4000) sind maximum

	BIT = char, varchar
	Byte
	KiloByte
	Megabyte
	Gigabyte = 2GB
	Terabyte



	2. Numerische Datentypen
	tinyint = 8 Bit = -255 bis 255
	smallint = 16 Bit = -32k bis 32k
	int = 32 Bit = -2,14 Mrd bis 2,14 Mrd
	bigint = 64 Bit = -9,2 Trillion bis ca. 9,2 Trillionen

	bit = 1 oder 0 (True = 1, False = 0) => Es gibt kein Bool!

	decimal(x, y) = x Ziffern insgesamt, davon sind y Nachkommastellen
	decimal(10, 2) = 10 Ziffern insgesamt, davon sind 2 Nachkommastellen
	money = -9,2 Trillion bis ca 9,2 Trillion
	smallmoney = -214k bis 214k



	3. Datum/Zeit Datentypen:
	time = hh:mm:ss.nnnnnnn
	date = YYYY-MM-DD
	datetime = date + time IN MS = YYYY-MM-DD hh:mm:ss.mmm
	datetime2 = YYYY-MM-DD hh:mm:ss.nnnnnnn
	smalldatetime = präzise bis Sekunden = YYYY-MM-DD hh:mm:ss
*/