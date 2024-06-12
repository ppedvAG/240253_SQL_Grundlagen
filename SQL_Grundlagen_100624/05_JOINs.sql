USE Northwind

SELECT * FROM Customers
SELECT * FROM Orders

-- Verknüpfung zwischen der Orders und Customers Tabelle

/*
	JOIN Syntax:
	SELECT * FROM TabelleA
	JOIN TabelleB ON A.Spalte1 = B.Spalte1
*/

SELECT City, Country, Orders.* FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID

-- Mit Aliasen
SELECT * FROM Customers as cus
JOIN Orders as o ON cus.CustomerID = o.CustomerID
WHERE cus.CustomerID = 'ALFKI'
ORDER BY OrderID DESC

-- JOIN Orders-Customers-Order Details
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID

-- Übung 

-- 1. Wieviele Bestellungen haben Kunden aus Argentinien aufgegeben?
-- Tabellen: Customers - Orders
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Argentina'

-- 2. Was war die größte Bestellmenge (Quantity) von Chai Tee (ProductName = 'Chai')?
-- Tabellen: [Order Details] - Products
SELECT TOP 1 ProductName, Quantity FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
WHERE ProductName = 'Chai'
ORDER BY Quantity DESC

-- 3. Welche Produkte (ProductName) hat "Leverling" bisher verkauft?
-- Tabellen: Employees - Orders - [Order Details] - Products
SELECT DISTINCT ProductName, LastName, Orders.OrderID FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE LastName = 'Leverling'

--  4. Alle Produkte (ProductNames) aus den Kategorien "Beverages" und "Produce"
-- (CategoryName in Categories)
--> Products - Categories Tables
SELECT * FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName IN ('Beverages', 'Produce')

-- 5. Alle Bestellungen (Orders) bei denen ein Produkt verkauft wurde, das nicht mehr gefuehrt wird
-- (Discontinued = 1 in Products)
--> Orders - Order Details - Products
SELECT * FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE Discontinued = 1

-- Aliase Spaltenname
SELECT Customers.CustomerID as CusID, Orders.CustomerID as OrdCusID, 7*8 as Rechnung FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID

SELECT * FROM Customers
JOIN Orders ON Orders.CustomerID = Customers.CustomerID

-- Bisher: INNER JOIN
------------------------------------------------------------------
-- OUTER Joins: LEFT/RIGHT und FULL OUTER

-- RIGHT: Z.189 & 502
SELECT * FROM Orders
RIGHT JOIN Customers ON Customers.CustomerID = Orders.CustomerID

-- LEFT:
SELECT * FROM Orders
LEFT JOIN Customers ON Customers.CustomerID = Orders.CustomerID

-- FULL OUTER:
SELECT * FROM Orders
FULL OUTER JOIN Customers ON Customers.CustomerID = Orders.CustomerID

-- RIGHT JOIN "invertieren", d.h keine Schnittmenge anzeigen, durch filtern nach NULL
SELECT * FROM Orders
RIGHT JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL

-- CROSS JOIN: Erstellt karthesisches Produkt zweier Tabellen (A x B) (830 x 91)
SELECT * FROM Orders CROSS JOIN Customers

-- Übung: Bestellungen die Herr King bearbeitet hat
-- Tabellen: Orders & Employees
SELECT * FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
WHERE LastName = 'King'