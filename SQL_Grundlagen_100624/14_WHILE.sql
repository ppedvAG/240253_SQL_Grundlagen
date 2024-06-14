USE Northwind

-- Variablen allgemein

-- Deklarieren
DECLARE @OrderID int = 10250

-- Abfragen einbauen
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

-- Neu setzen
SET @OrderID = 10251

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

-- WHILE - leitet eine Schleifenanweisung ein

DECLARE @Zaehler INT = 0

WHILE @Zaehler <= 5
BEGIN
SELECT 'Hallo'
SET @Zaehler = @Zaehler + 1
END

-- Endlosschleife, aufpassen auf den Computer
WHILE 1=1
BEGIN 
SELECT 'Hallo!'
END