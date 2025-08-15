CREATE DATABASE ShopDB;
USE ShopDB;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE DEFAULT (CURRENT_DATE),
    IsActive BOOLEAN DEFAULT TRUE
);

INSERT INTO Customers (FirstName, LastName, Email, JoinDate) VALUES
('Aarav', 'Roy', 'Aarav25@gmail.com', '2024-01-12'),
('Meera', 'Panday', 'Meera81@gmail.com', '2024-02-22'),
('Rohan', 'Kapoor', 'Rohan63@gmail.com', '2024-03-06'),
('Ananya', 'Khan', NULL, '2024-04-21'),
('Kunal', 'Deshmukh', 'Kunal21@gmail.com', '2024-05-31'),
('Priya', 'Kadam', 'Priya34@gmail.com', '2024-06-03');

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

INSERT INTO Products (ProductName, Price) VALUES
('Monitor', 271.99),
('Keyboard', 234.99),
('CPU', 123.99),
('Mouse', 341.99),
('Laptop', 245.99);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE DEFAULT (CURRENT_DATE),
    Amount DECIMAL(10,2),
    Status ENUM('Pending', 'Shipping', 'Delivered', 'Cancelled'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (CustomerID, OrderDate, Amount, Status) VALUES
(1, '2024-06-03', 1300.99, 'Pending'),
(1, '2024-06-06', 3400.99, 'Shipping'),
(2, '2024-06-12', 5200.99, 'Delivered'),
(2, '2024-06-15', 2400.99, 'Cancelled'),
(3, '2024-06-19', 2500.99, 'Pending'),
(3, '2024-06-21', 4600.99, 'Cancelled'),
(4, '2024-06-26', 2400.99, 'Cancelled'),
(5, '2024-06-29', 2300.99, 'Delivered'),
(6, '2024-06-30', 2400.99, 'Pending');

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 5, 1),
(3, 4, 2),
(4, 3, 1),
(5, 1, 1),
(6, 5, 1),
(7, 2, 1),
(8, 4, 1),
(9, 2, 1),
(9, 5, 1);

-- View: Customer Order Details
CREATE VIEW customer_order_details AS
SELECT  
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.OrderData,  
    p.ProductName,
    p.Price,
    od.Quantity,
    (p.Price * od.Quantity) AS TotalPrice
FROM  
    Customers c
JOIN 
	Orders o ON c.CustomerID = o.CustomerID
JOIN 
	OrderDetails od ON o.OrderID = od.OrderID
JOIN 
	Products p ON od.ProductID = p.ProductID;
    
-- View: High-Value Customers
CREATE VIEW high_value_customers AS
SELECT  
    c.CustomerID,
    c.FirstName,
    SUM(o.Amount) AS LifetimeValue
FROM  
    Customers c
JOIN 
	Orders o ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID, c.FirstName
HAVING
    SUM(o.Amount) > 1000;
    
--  View: Active Customers
ALTER TABLE Customers ADD IsActive BOOLEAN DEFAULT TRUE;

CREATE VIEW active_customers AS
SELECT  
    CustomerID,
    FirstName,
    Email
FROM  
    Customers
WHERE
    IsActive = TRUE
WITH CHECK OPTION;

SELECT * FROM customer_order_details WHERE CustomerID = 9;
SELECT * FROM high_value_customers ORDER BY LifetimeValue DESC;
