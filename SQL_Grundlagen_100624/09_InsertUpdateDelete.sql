USE Northwind

-- CREATE / ALTER / DROP - DDL (Data Definition Language)

/*
	- CREATE  = Tabelle erstellen
	- ALTER   = Tabelle bearbeiten
	- DELETE  = Löscht den Inhalt der Tabelle
	- INSERT  = Datensätze hinzufügen
	- UPDATE  = Bestimmte Werte in der Tabelle verändern
	- DROP    = Tabelle verwerfen
*/


-- Immer wenn wir Datenbankobjekte bearbeiten gelten diese Befehle

-- Erstellung der Tabelle
CREATE TABLE PurchasingOrders
(
	ID INT PRIMARY KEY IDENTITY(1, 1),
	OrderDate date NOT NULL,
	ProductID INT NOT NULL
)

SELECT * FROM PurchasingOrders

-- Beziehung zwischen PurchasingOrders und Products anlegen über ProductID
ALTER TABLE PurchasingOrders
ADD FOREIGN KEY (ProductID) REFERENCES Products (ProductID)

-- Neue Spalte hinzufügen zu bestehender Tabelle:
ALTER TABLE PurchasingOrders
ADD TestDaten INT

SELECT * FROM PurchasingOrders

-- Spalte aus der bestehenden Tabelle löschen:
ALTER TABLE PurchasingOrders
DROP COLUMN NeueSpalte

-- INSERT

-- Alle Spalten befüllen:
INSERT INTO PurchasingOrders
VALUES ('20240613', 3, 20)

-- Explizit einzelne Spalten befüllen
INSERT INTO PurchasingOrders (OrderDate, ProductID)
VALUES ('20240613', 1)

-- Ergebnis einer SELECT Abfrage können direkt Inserted werden (Wenn Spaltenanzahl passt
-- & Datentypen kompatibel sind) 
INSERT INTO PurchasingOrders
SELECT GETDATE(), 2, NULL

SELECT * FROM PurchasingOrders

-- DELETE

-- Aufpassen! Ohne WHERE Filter werden ALLE Datensätze gelöscht!
DELETE FROM PurchasingOrders
WHERE ID = 7

-- Primär-/Fremdschlüsselbeziehungen verhindern das löschen von Datensätzen, wenn anderer Datensätze
-- sonst "ins Leere laufen würden"
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

------------------------------------
-- UPDATE

SELECT * FROM PurchasingOrders

UPDATE PurchasingOrders
SET TestDaten = 50
WHERE ID = 9

-- "Löschen" von Werten: SET = NULL
UPDATE PurchasingOrders
SET TestDaten = NULL
WHERE ID = 4

-- Transactions

BEGIN TRANSACTION

UPDATE PurchasingOrders
SET TestDaten = 5
WHERE ID = 4

COMMIT
ROLLBACK

SELECT * FROM PurchasingOrders

-- Trage dich selber in die Tabelle ein (Employees). Bei den folgenden Spalten: 
-- LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
-- HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo
INSERT INTO Employees
(LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo)
VALUES
('Libowicz', 'Philipp', 'IT-Trainer', 'Mr.', '20050213', '20230901', 'Burghausen', 'Bayern', '84489', 'Germany', '(206) 555-9857', 2)

-- Bonus: Aendere die Werte (LastName, FirstName, Region = NULL) danach um, in eine Person die frei erfunden ist
UPDATE Employees
SET Region = NULL
WHERE EmployeeID = 10

SELECT * FROM Employees