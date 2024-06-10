USE Northwind

-- LIKE: Für ungenaue Filterung/Suche können wir LIKE verwenden
-- (statt Vergleichsoperatoren)

SELECT * FROM Customers
WHERE ContactTitle = 'Owner'

-- Wildcards
-- "%"-Zeichen: Beliebig Symbole, beliebig viele davon
SELECT * FROM Customers
WHERE ContactTitle LIKE '%Manager%'

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Owner%'

-- "_"-Zeichen: EIN beliebiges Zeichen
SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_l%'

-- "[]"-Zeichen: Alles in den Klammern ist gültiges Symbol
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[012345]%'

-- "[a-z]" oder gegenteil mit ^ [^a-z]
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-5]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[^123]%'

-- Sonderfällen: % & '
SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%['']%'
