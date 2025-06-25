drop database EcommerceDB;
CREATE DATABASE IF NOT EXISTS EcommerceDB;
USE EcommerceDB;

CREATE TABLE Categories (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
  ProductID INT AUTO_INCREMENT PRIMARY KEY,
  ProductName VARCHAR(100),
  Price DECIMAL(10, 2),
  Stock INT,
  CategoryID INT,
  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Customers (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(20),
  Address VARCHAR(255)
);

CREATE TABLE Orders (
  OrderID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT,
  OrderDate DATE,
  Status VARCHAR(50),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
  OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
  OrderID INT,
  ProductID INT,
  Quantity INT,
  Price DECIMAL(10,2),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  OrderID INT,
  PaymentDate DATE,
  Amount DECIMAL(10,2),
  PaymentMethod VARCHAR(50),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--  INSERT sample Categories
INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Clothing'),
('Books');

--  INSERT sample Products
INSERT INTO Products (ProductName, Price, Stock, CategoryID) VALUES
('Smartphone', 19999.99, 100, 1),     -- ProductID = 1
('Laptop', 54999.00, 50, 1),          -- ProductID = 2
('T-Shirt', 499.00, 200, 2),          -- ProductID = 3
('Novel', NULL, 150, 3),              -- ProductID = 4 (Price is NULL)
('Headphones', 1499.00, NULL, 1);     -- ProductID = 5 (Stock is NULL)

--  INSERT sample Customers
INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('Anjali Jare', 'anjali@example.com', '9876543210', 'Mumbai'),     -- CustomerID = 1
('Rahul Sharma', NULL, '9123456789', 'Delhi'),                     -- CustomerID = 2
('Sneha Kapoor', 'sneha@gmail.com', NULL, 'Pune');                 -- CustomerID = 3

--  INSERT sample Orders
INSERT INTO Orders (CustomerID, OrderDate, Status) VALUES
(1, '2025-06-20', 'Shipped'),     -- OrderID = 1
(2, '2025-06-21', 'Pending');     -- OrderID = 2

--  INSERT OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 19999.99),
(1, 5, 2, 1499.00),
(2, 3, 3, 499.00);

--  INSERT Payments
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2025-06-20', 22997.99, 'UPI'),
(2, '2025-06-21', 1497.00, 'COD');

--  UPDATE Queries using PRIMARY KEYS

-- Set stock of Headphones (ProductID = 5)
UPDATE Products
SET Stock = 30
WHERE ProductID = 5;

-- Update Rahul Sharma's email (CustomerID = 2)
UPDATE Customers
SET Email = 'rahul@samplemail.com'
WHERE CustomerID = 2;

-- Change order status to Delivered (OrderID = 1)
UPDATE Orders
SET Status = 'Delivered'
WHERE OrderID = 1;

--  DELETE Queries using PRIMARY KEYS

-- Simulate a product with Stock = 0 and delete it
INSERT INTO Products (ProductName, Price, Stock, CategoryID)
VALUES ('Old Mouse', 399.00, 0, 1);  -- ProductID = 6

DELETE FROM Products
WHERE ProductID = 6;

-- Simulate customer with NULL email and phone, then delete
INSERT INTO Customers (Name, Email, Phone, Address)
VALUES ('Test User', NULL, NULL, 'TestCity');  -- CustomerID = 4

DELETE FROM Customers
WHERE CustomerID = 4;
