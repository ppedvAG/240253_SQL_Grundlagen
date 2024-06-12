USE Northwind
GO
-- Views / Sichten
-- Views: Erzeugt eine Virtuelle Tabelle, deren Inhalt durch eine Abfrage definiert wird

/*
	Vorteile:
	- Komplexere Abfragen speichern
	- Sicherheit: User erlabuen nur die zu lesen, aber nicht zu verändern
	- Views sind immer aktuell (aktuelle Daten)
		=> beim Aufruf der View wird das hinterlegt Statement ausgeführt
*/

CREATE VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO

-- Aufruf der View
-- Code hinter einer View (oder anderem DB Objekt) ansehen über Objekt Explorer
-- Rechtsklick -> SCRIPT AS -> CREATE -> neues Abfragefenster
SELECT * FROM vRechnungsDaten

-- View löschen
-- DROP VIEW vRechnungsDaten

-- View ändern:
ALTER VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO

-- 1. Wieviel Umsatz haben wir im Q1 1998 mit Kunden aus der USA gemacht?
SELECT SUM(SummeBestPosi) AS GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998
AND DATEPART(QUARTER, OrderDate) = 1

-- Wieviel Umsatz haben wir in jedem Geschäftsjahr insgesamt gemacht?
-- Benoetigt: SUM(SummeBestPosi)
-- View: vRechnungsDaten
SELECT DATEPART(YEAR, OrderDate) AS Geschäftsjahr,
SUM(SummeBestPosi) AS Gesamtumsatz FROM vRechnungsDaten
GROUP BY DATEPART(YEAR,OrderDate)
ORDER BY 1
GO

-- Ist der Spediteur „Speedy Express“ 
-- über die Jahre durchschnittlich (AVG) teurer geworden? (Freight pro Jahr)
-- Und das ganze in einer View packen
-- Tabellen: Orders - Shippers
-- Orders.ShipVia = Shippers.ShipperID
CREATE VIEW SpeedyExpress AS
SELECT CompanyName, DATEPART(YEAR, OrderDate) as Geschäftsjahr, AVG(Freight) as Durchschnitt FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE CompanyName = 'Speedy Express'
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
GO

-- Aufruf der View
SELECT * FROM SpeedyExpress
GO

CREATE VIEW JoinExample AS
SELECT CompanyName, Country, City FROM Customers
JOIN Orders on Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GO

-- Aufruf der View
SELECT * FROM JoinExample