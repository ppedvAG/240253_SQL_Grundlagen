USE Northwind
-- String Funktionen bzw. Text-Datentypen manipulieren

-- LEN gibt die länge des Strings zurück als int
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" / "rechten" X Zeichen eines Strings zurück
SELECT CompanyName, LEFT(CompanyName, 5) as Test FROM Customers
SELECT CompanyName, RIGHT(CompanyName, 5) as Test FROM Customers

-- SUBSTRING(Spalte, x, y) springt zu Position X von der Spalte und gibt y Zeichen zurück
SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers

-- CONCAT fügt mehrere Strings in die selbe Spalte hinzu
SELECT CONCAT(FirstName, ' ', LastName) as 'Ganzer Name' FROM Employees
SELECT FirstName + ' ' + LastName as 'Ganzer Name' FROM Employees

-------------------------------------------------------------------------------------
-- Datumsfunktionen
SELECT GETDATE() -- aktuelle Systemzeit mit Zeitstempel

SELECT * FROM Orders

SELECT YEAR(OrderDate) as Jahr, MONTH(OrderDate) as Monat, DAY(OrderDate) as Tag,
OrderDate FROM Orders

-- "Zieht" ein gewünschtes Intervall aus einem Datum
SELECT
DATEPART(YEAR, OrderDate) as Jahr,
DATEPART(QUARTER, OrderDate) as Quartal,
DATEPART(WEEK, OrderDate) as Kalenderwoche,
DATEPART(WEEKDAY, OrderDate) as Wochentag,
DATEPART(HOUR, OrderDate) AS Stunde
FROM Orders

-- Zieht den IntervallNamen aus einem Datum
SELECT
DATENAME(MONTH, OrderDate),
DATENAME(WEEKDAY, OrderDate),
OrderDate
FROM Orders

/*
	Deutsches Format:
	1=Montag, 2=Dienstag, 3=Mittwoch, 4=Donnerstag, 5=Freitag, 6=Samstag, 7=Sonntag

	Englisches Format:
	0=Sonntag, 1=Montag, 2=Dienstag, 3=Mittwoch, 4=Donnerstag, 5=Freitag, 6=Samstag

*/

-- Intervall zu einem Datum addieren/subtrahieren
SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(DAY, -14, GETDATE())

-- Differenz in Intervall zwischen 2 Datums haben
SELECT DATEDIFF(YEAR, '20050213', GETDATE()) -- Datumsformat in hochkomma 'YYYYMMDD'
SELECT DATEDIFF(DAY, OrderDate, GETDATE()), OrderDate FROM Orders

SELECT OrderID, YEAR(OrderDate), OrderDate FROM Orders

-- Übung:
-- 1. Alle Bestellungen (Orders) aus dem Q2 im Jahr 1997

-- Lösung Nr.1
SELECT * FROM Orders
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 2

-- Lösung Nr.2
SELECT * FROM Orders
WHERE OrderDate BETWEEN '19970401' AND '19970630'


-- 2. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
-- (OrderDate in Orders) 'YYYYMMDD'
--> Customers - Orders
-- 1. JOIN Syntax
-- 2. Nach USA Filtern bei den Country
-- 3. Das Jahr 1997 filtern
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND DATEPART(Year, OrderDate) = 1997

SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND OrderDate BETWEEN '19970101' AND '19971231'

/***********************************************************************************/

-- CAST oder CONVERT, wandeln Datentypen in der der Ausgabe um
-- konvertierung von datetime => date
-- datetime = YYYY-MM-DD HH:mm:ss.mmm 
-- date     = YYYY-mm-dd
SELECT CAST(OrderDate as date) FROM Orders

SELECT CONVERT(date, OrderDate) FROM Orders

-- ISNULL prüft auf NULL Werte und ersetzt diese wenn erwünscht
SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers

-- Reverse(Spaltenname) => z.B 'Hallo' => 'ollaH'
SELECT CompanyName, REVERSE(CompanyName) FROM Customers

-- UPPER(Spaltenname) => alles in Großbuchstaben
SELECT CompanyName, UPPER(CompanyName) FROM Customers

-- LOWER(Spaltenname) => alles in kleinbuchstaben
SELECT CompanyName, LOWER(CompanyName) FROM Customers