-- 1. Die 10 größten ProductNames vom UnitPrice
SELECT TOP 10 * FROM Products
ORDER BY UnitPrice DESC

-- 2. Haben wir Produkteinheiten im Lager (UnitsInStock), die aber nicht
-- mehr verkauft werden (Discontinued)? Wenn ja, wieviel "Geld" liegt dort im Lager?
-- Rechnung: UnitsInStock * UnitPrice
SELECT ProductName, UnitsInStock * UnitPrice as Wert FROM Products
WHERE Discontinued = 1 AND UnitsInStock != 0
ORDER BY Wert 

-- 3. Den Employee "Leverling" anzeigen lassen
SELECT * FROM Employees
WHERE LastName = 'Leverling'

-- 4. Alle ShipPostalCode's anzeigen lassen, die mit 0,2,4 beginnen
SELECT ShipPostalCode FROM Orders
WHERE ShipPostalCode LIKE '[024]%'

