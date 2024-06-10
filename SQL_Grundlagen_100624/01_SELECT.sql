-- einzeiliger Kommentar
/*
	Mehrzeiliger
	Kommentar
*/

-- USE Datenbankname wechselt angesprochene Datenbank
-- Alternativ "oben links" im Drop-Down Menü richtige DB auswählen
USE Northwind

/*
	SELECT: Spalten auswählen, die im Ergebnisfenster angezeigt werden sollen von der
	Tabelle
*/

SELECT * FROM Customers -- * = alle Spalten in der angesprochenen Tabelle

-- "Custom" Werte und mathematische Operatoren nutzen
SELECT 100 --> Zahl

SELECT 'Hallo!' --> Zeichenkette

SELECT 'Hallo!', 100
-- Nur einzelne "Anweisungen" ausführen:
-- Zeile Markieren
-- Ausführen oben, oder über F5, oder STRG+E

SELECT 100+5, 7*8
-------------------------------------------------------
-- Den CompanyName, Country von der Customers Tabelle
SELECT CompanyName, Country FROM Customers

-- SELECT [Spalten] FROM [Tabelle]

-- SQL ist NICHT case-sensitive, Formatierung spielt keine Rolle, keine Strichpunkte nötig
sElEcT		cOuNtrY,
		ComPanYnAme
FrOm		Customers

-------------------------------------------------------------
-- Sortieren mit ORDER BY
SELECT * FROM Customers
ORDER BY City ASC

-- Z-A sortieren möchte
SELECT * FROM Customers
ORDER BY City DESC
-- ORDER BY ist syntaktsich IMMER am Ende
-- DESC = Descening = absteigend (Z-A)
-- ASC = Ascending = aufsteigend (A-Z)

-------------------------------------------------------------
-- TOP X gibt nur die ersten X Zeilen aus
SELECT TOP 5 * FROM Customers

SELECT TOP 100 * FROM Customers

-- Geht auch mit %-Angabe
-- TOP X PERCENT
SELECT TOP 10 PERCENT * FROM Customers
-- 91 Zeilen => 10% davon => 9,1

-- Die 10 größten Frachtkosten von der Tabelle Orders
SELECT TOP 10 * FROM Orders
ORDER BY Freight DESC

-- Die 10 kleinsten Frachtkosten von der Tabelle Orders
SELECT TOP 10 * FROM Orders
ORDER BY Freight ASC

/*
	WCIHTIG!: "BOTTOM X" existiert nicht, Ergebnisse einfach 
	umdrehen müssen mittels ORDER BY
*/
---------------------------------------------
SELECT * FROM Customers
-- Duplikate "filtern" mit SELECT DISTINCT
-- DISTINCT: Filtert alle Ergebnisse/Datensätzen deren Werte exakt gleich sind
SELECT Country FROM Customers

SELECT DISTINCT Country FROM Customers

-- Spalten "umbennen" über Aliase bzw. "as"
SELECT 'Hallo' as Wort, 100 as Zahl

-- Übung 
-- 1. Alle Spalten von der Tabelle "Employees"
SELECT * FROM Employees

-- 2. Spalte: ProductName & UnitPrice von der Tabelle "Products"
SELECT ProductName, UnitPrice FROM Products

-- 3. Alle Spalten von der Tabelle [Order Details] -> absteigend sortiert haben
-- UnitPrice absteigend
SELECT * FROM [Order Details]
ORDER BY UnitPrice DESC