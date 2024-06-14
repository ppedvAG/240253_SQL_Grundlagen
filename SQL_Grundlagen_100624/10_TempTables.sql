USE Northwind

-- Temporäre Tabellen / Temp Tables / #Tables

/*
	- SELECT INTO #TableName => Ergebnisse werden in eine Temporäre Tabelle geschrieben
	- existiert nur innerhalb meiner Session (Abfragefenster)
	- werden in SystemDB => tempDB angelegt
	- Ergebniss wird nur einmal generiert --> TempTables sehr schnell aber nicht aktuell
	- mit einem # = "lokal"
	- mit zwei ## = 'global'

*/

-- Erstellen
SELECT * 
INTO #TempTable
FROM Customers
WHERE Country = 'Germany'

-- Temporäre Tabelle aufrufen
SELECT * FROM #TempTable

-- manuell löschen
DROP TABLE #TempTable

-- globale Temp Table:
SELECT * 
INTO ##TempTable
FROM Customers
WHERE Country = 'Germany'

-- Hat „Andrew Fuller“ (LastName) schonmal Produkte der Kategorie 
-- „Seafood“(CategoryName) verkauft?
-- Wenn ja, wieviel Lieferkosten (Freight) sind 
-- dabei insgesamt entstanden?
-- Tables: Employees - Orders - [Order Details] - Products - Categories
-- Bonus: Das ganze mit Temporaere Tabellen machen
SELECT SUM(Freight) as Lieferkosten 
INTO #Ergebnis
FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE Employees.LastName = 'Fuller' AND Categories.CategoryName = 'Seafood'

SELECT * FROM #Ergebnis