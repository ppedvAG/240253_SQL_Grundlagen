USE Northwind

-- WHERE: filtert Ergebniszeilen
-- = sucht nach exakten Treffern
SELECT * FROM Customers
WHERE Country = 'Germany'

-- NICHT case-sensitive
SELECT * FROM Customers
WHERE Country = 'GERMANY'

SELECT * FROM Orders
WHERE Freight = 100

-- alle boolschen Vergleichsoperatoren 
-- (>, <, >=, <=, != bzw <>)

SELECT * FROM Orders
WHERE Freight > 500

SELECT * FROM Customers
WHERE Country != 'Germany'

-- Kombinieren von WHERE Ausdrücken mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

-- Wo Country = 'France' Oder Deutschland ist
SELECT * FROM Customers
WHERE Country = 'France' OR Country = 'Germany'

-- AND = "Beide" Bedingungen müssen "wahr" sein
-- OR = Ein Ausdruck muss wahr sein
-- Können beliebig oft kombinieren

-- "Vorsicht" bei Kombination aus AND und OR
SELECT * FROM Customers
WHERE (City = 'Paris' OR City = 'Berlin') AND Country = 'Germany'
-- AND "ist stärker bindent" als OR; Notfalls Klammern setzen!


-- Frachkosten zwischen 100 und 500
SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

-- Alternative mit BETWEEN, Randwerte mit inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Customers
WHERE Country = 'Brazil' OR Country = 'Germany' OR Country = 'France'

-- Alternative das IN (Wert1, Wert2, Wert3)
SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France')
-- IN verbindet mehrere OR Bedingungen die sich auf die selbe Spalte beziehen

----------------------------------------------------------------------
-- Übungen

-- 1. Alle ContactNames die als Title "Owner" haben
-- Tabelle Customers
SELECT * FROM Customers
WHERE ContactTitle = 'Owner'

-- 2. Alle [Order Details] die ProductID 43 bestellt haben
-- Tabelle Order Details
SELECT * FROM [Order Details]
WHERE ProductID = 43

-- 3. Alle Kunden aus Paris, Berlin, Madrid und Brasilien
-- Tabelle Customers
SELECT * FROM Customers
WHERE City IN ('Paris', 'Madrid', 'Berlin') OR Country = 'Brazil'

-- Bonus Aufgabe: Alle Kunden die eine Fax Nummer haben
-- => NULL Werte rausfiltern
SELECT * FROM Customers
WHERE Fax != 'NULL'

SELECT * FROM Customers
WHERE Fax IS NOT NULL
