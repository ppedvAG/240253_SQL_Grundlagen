USE Northwind

-- Subqueries / Unterabfragen / nested queries

/*
	- Müssen eigenständig fehlerfrei ausführbar sein
	- Können prinzipiell überall in eine Abfrage eingebaut werden (wenn es Sinn macht)
	- Abfragen werden "von innen nach außen" der Reihe nach ausgeführt
*/

-- Zeige mir alle Orders, deren Freight Werte über dem Durchschnitt liegt
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442

-- Schreiben Sie eine Abfrage, um eine Produktliste 
-- (ID, ProductName, UnitPrice) mit einem überdurchschnittlichen Preis zu erhalten.
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice