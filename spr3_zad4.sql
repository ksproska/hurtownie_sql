DROP TABLE Fact_Orders;
DROP TABLE Dim_Customer;
DROP TABLE Dim_Product;
--ALTER AUTHORIZATION ON DATABASE:: [254534] TO sa;

CREATE TABLE Dim_Customer (
	CustomerID INT NOT NULL PRIMARY KEY, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	TerritoryName NVARCHAR(50), 
	CounrtyRegionCode NVARCHAR(3), 
	[Group] NVARCHAR(50)
);


CREATE TABLE Dim_Product (
	ProductID INT NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(50),
	ListPrice MONEY, 
	Color NVARCHAR(15),
	SubCategoryName NVARCHAR(50),
	CategoryName NVARCHAR(50)
);

CREATE TABLE Fact_Orders (
	ProductID INT NOT NULL, 
	CustomerID INT NOT NULL, 
	OrderDate DATETIME,
	ShipDate DATETIME,
	OrderQty SMALLINT,
	UnitPrice MONEY,
	UnitPriceDiscount MONEY,
	LineTotal NUMERIC(38, 6),
	FOREIGN KEY (ProductID) REFERENCES Dim_Product(ProductID),
	FOREIGN KEY (CustomerID) REFERENCES Dim_Customer(CustomerID)
);

