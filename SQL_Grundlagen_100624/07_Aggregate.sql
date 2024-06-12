USE Northwind
-- Aggregatfunktionen: Führt eine Berechnung auf einer Menge von Werten durch und gibt einen 
--					   einzigen Wert zurück
-- Ignorieren NULL-Werte außer COUNT(*)

-- 5 grundsätzliche verschiedene Funktionen

SELECT
SUM(Freight) AS Summe,
MIN(Freight) AS Minimum,
MAX(Freight) AS Maximum,
AVG(Freight) AS Durchschnitt,
COUNT(ShippedDate) AS ZähleSpalte,
COUNT(*) as ZähleAlles
FROM Orders

-- AVG selber berechnen
SELECT SUM(Freight) / COUNT(*) FROM Orders

SELECT CustomerID, SUM(Freight) FROM Orders
-- Lösung über GROUP BY
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
SELECT ProductName, SUM(Quantity) as SummeStückZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName

-- Quantity Summe pro ProductName für Produkte der Kategorien 1-4
SELECT ProductName, SUM(Quantity) as SummeStückZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
ORDER BY SummeStückZahl DESC

-- Verkaufte Stückzahlen pro Produkt, die aber über 1000
SELECT ProductName, SUM(Quantity) as SummeStückZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeStückZahl DESC

-- HAVING funktioniert 1zu1 wie WHERE, kann aber gruppierte/aggregierte Werte nachträglich filtern kann
SELECT ProductName, SUM(Quantity) as SummeStückZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE SUM(Quantity) > 1000
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStückZahl DESC

-- Übung
-- 1. Verkaufte Stückzahlen (Quantity) pro KategorieName (CategoryName) (8 Ergebniszeilen)
-- SELECT * FROM TabellaA JOIN TabelleB ON TabelleA.Spalte = TabelleB.Spalte
-- Categories - Products - Order Details
SELECT CategoryName, SUM(Quantity) as SummeStückZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName
ORDER BY SummeStückZahl

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

-- 4. In welcher Stadt (City) waren „Wimmers gute Semmelknödel“ am beliebtesten (Quantity)?
-- Tabellen: Products - Order Details - Orders - Customers
SELECT TOP 1 City, SUM(Quantity) as Verkaufsmenge FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE ProductName = 'Wimmers gute SemmelknÃ¶del'
GROUP BY City
ORDER BY Verkaufsmenge DESC

-- 5. Welcher Spediteur (Shippers) war durchschnittlich am günstigsten? (Freight)
-- Tables: Shippers - Orders Vernüpfung Orders.ShipVia = Shippers.ShipperID
SELECT CompanyName, AVG(Freight) as AvgFreight FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName
ORDER BY AvgFreight 

-- Datumsfunktionen
-- 1. Welches Produkt (ProductName) hatte die größte Bestellmenge (Quantity in OrderDetails) im Februar 1998?
SELECT TOP 1 ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(MONTH, OrderDate) = 2
ORDER BY Quantity DESC