--DROP TABLE Dim_Customer;
--DROP TABLE Dim_Product;
--DROP TABLE Fact_Orders;

CREATE TABLE Dim_Customer (
	CustomerID INT NOT NULL, 
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	TerritoryName NVARCHAR(50) NOT NULL, 
	CounrtyRegionCode NVARCHAR(3) NOT NULL, 
	[Group] NVARCHAR(50) NOT NULL, 
	PRIMARY KEY (CustomerID)
);


CREATE TABLE Dim_Product (
	ProductID INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	ListPrice MONEY NOT NULL, 
	Color NVARCHAR(15),
	SubCategoryName NVARCHAR(50) NOT NULL,
	CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Fact_Orders (
	ProductID INT NOT NULL, 
	CustomerID INT NOT NULL, 
	OrderDate , 
	ShipDate, 
	OrderQty, 
	UnitPrice, 
	UnitPriceDiscount, 
	LineTotal
);

