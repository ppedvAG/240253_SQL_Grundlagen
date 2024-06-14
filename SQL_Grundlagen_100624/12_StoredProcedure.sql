USE Northwind
GO
-- Stored Procedures
/*
	- Sind gespeicherte SQL Anweisungen (Nicht nur SELECT, sondern auch alles andere)
	- Arbeiten mit Variablen
	- Praktisch zum "automatisieren" von Code
	- Prozeduren verwenden ihren Abfrageplan immer wieder
*/

CREATE PROCEDURE spRechnungsByOrderID @OrderID INT
AS
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID
GO

-- Prozedur ausführen
EXEC spRechnungsByOrderID 10250
GO

-- Prozedur die mir ein Datensatz hinzufügen soll
CREATE PROCEDURE spNewCustomer
@CustomerID char(5), @CompanyName varchar(40),
@Country varchar(30), @City varchar(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)

EXEC spNewCustomer EDEKA, 'Edeka GmbH', Germany, Burghausen
EXEC spNewCustomer 'LIDLI', 'Lidl GmbH', 'Germany', 'Burghausen'

SELECT * FROM Customers
WHERE CustomerID = 'LIDLI'
GO

-- DEFAULT WERTE
CREATE PROCEDURE spKundenNachLandCity @Country varchar(50) = 'Germany', @City varchar(50) = 'Berlin'
AS
SELECT * FROM Customers
WHERE Country = @Country AND City = @City
GO

EXEC spKundenNachLandCity France, Paris
GO
-- Eine Prozedur, der ich ein Land übergebe und mir die Datensätze von z.B
-- Country = 'Germany' ausgibt
CREATE PROCEDURE spCountry @Country varchar(30)
AS
SELECT * FROM Customers
WHERE Country = @Country
GO

EXEC spCountry Brazil
GO
-- Eine Prozedur, der man die ProductID übergeben muss um alles mir 
-- aus der Products-Tabelle anzeigen zu lassen
CREATE PROCEDURE spProductID @ProductID INT
AS 
SELECT * FROM Products
WHERE ProductID = @ProductID
GO

EXEC spProductID 43