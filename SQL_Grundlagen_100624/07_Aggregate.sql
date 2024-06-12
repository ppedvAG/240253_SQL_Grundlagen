USE Northwind
-- Aggregatfunktionen: F�hrt eine Berechnung auf einer Menge von Werten durch und gibt einen 
--					   einzigen Wert zur�ck
-- Ignorieren NULL-Werte au�er COUNT(*)

-- 5 grunds�tzliche verschiedene Funktionen

SELECT
SUM(Freight) AS Summe,
MIN(Freight) AS Minimum,
MAX(Freight) AS Maximum,
AVG(Freight) AS Durchschnitt,
COUNT(ShippedDate) AS Z�hleSpalte,
COUNT(*) as Z�hleAlles
FROM Orders

-- AVG selber berechnen
SELECT SUM(Freight) / COUNT(*) FROM Orders

SELECT CustomerID, SUM(Freight) FROM Orders
-- L�sung �ber GROUP BY
/*
	 GROUP BY - Fasst mehrere Werte in Gruppen zusammen
*/

SELECT CustomerID, Freight FROM Orders
ORDER BY CustomerID

-- GROUP BY
SELECT CustomerID, SUM(Freight) FROM Orders
GROUP BY CustomerID

-- Quantity Summe pro ProductID:
-- Alles was kein Aggregat ist, kommt automatisch ins Group by rein
SELECT ProductID, SUM(Quantity) FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

-- Quantity summe pro ProductName
-- Tabellen ProductID - [Order Details]
SELECT ProductName, SUM(Quantity) as SummeSt�ckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName

-- Quantity Summe pro ProductName f�r Produkte der Kategorien 1-4
SELECT ProductName, SUM(Quantity) as SummeSt�ckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
ORDER BY SummeSt�ckZahl DESC

-- Verkaufte St�ckzahlen pro Produkt, die aber �ber 1000
SELECT ProductName, SUM(Quantity) as SummeSt�ckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeSt�ckZahl DESC

-- HAVING funktioniert 1zu1 wie WHERE, kann aber gruppierte/aggregierte Werte nachtr�glich filtern kann
SELECT ProductName, SUM(Quantity) as SummeSt�ckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE SUM(Quantity) > 1000
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeSt�ckZahl DESC

-- �bung
-- 1. Verkaufte St�ckzahlen (Quantity) pro KategorieName (CategoryName) (8 Ergebniszeilen)
-- SELECT * FROM TabellaA JOIN TabelleB ON TabelleA.Spalte = TabelleB.Spalte
-- Categories - Products - Order Details
SELECT CategoryName, SUM(Quantity) as SummeSt�ckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName
ORDER BY SummeSt�ckZahl

-- 2.  Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
-- Tables: Employees - Orders
SELECT LastName, COUNT(OrderID) as Bestellungen FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName

-- 3. Wiederholung von Datumsfunktionen
-- Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
-- Sind es mehr oder weniger als aus Frankreich? (2. Abfrage)
SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Country = 'Spain' AND DATEPART(YEAR, OrderDate) = 1997 AND
DATEPART(QUARTER, OrderDate) = 2

SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Country = 'France' AND DATEPART(YEAR, OrderDate) = 1997 AND
DATEPART(QUARTER, OrderDate) = 2

-- 4. In welcher Stadt (City) waren �Wimmers gute Semmelkn�del� am beliebtesten (Quantity)?
-- Tabellen: Products - Order Details - Orders - Customers
SELECT TOP 1 City, SUM(Quantity) as Verkaufsmenge FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE ProductName = 'Wimmers gute Semmelknödel'
GROUP BY City
ORDER BY Verkaufsmenge DESC

-- 5. Welcher Spediteur (Shippers) war durchschnittlich am g�nstigsten? (Freight)
-- Tables: Shippers - Orders Vern�pfung Orders.ShipVia = Shippers.ShipperID
SELECT CompanyName, AVG(Freight) as AvgFreight FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName
ORDER BY AvgFreight 

-- Datumsfunktionen
-- 1. Welches Produkt (ProductName) hatte die gr��te Bestellmenge (Quantity in OrderDetails) im Februar 1998?
SELECT TOP 1 ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(MONTH, OrderDate) = 2
ORDER BY Quantity DESC