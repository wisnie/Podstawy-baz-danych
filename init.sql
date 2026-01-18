USE u_bawisnie;

SET NOCOUNT ON;
SET DATEFIRST 1; -- 1 = Poniedziałek

-- =============================================
-- 1. CZYSZCZENIE I TWORZENIE STRUKTURY (DDL)
-- =============================================

-- Usuwanie kluczy obcych (dla bezpieczeństwa przy dropowaniu)
DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += N'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id))
    + '.' + QUOTENAME(OBJECT_NAME(parent_object_id)) +
    ' DROP CONSTRAINT ' + QUOTENAME(name) + ';'
FROM sys.foreign_keys;
EXEC(@sql);

-- Usuwanie tabel
IF OBJECT_ID('dbo.Production', 'U') IS NOT NULL DROP TABLE dbo.Production;
IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL DROP TABLE dbo.Payments;
IF OBJECT_ID('dbo.Cancelled_Orders', 'U') IS NOT NULL DROP TABLE dbo.Cancelled_Orders;
IF OBJECT_ID('dbo.Order_Details', 'U') IS NOT NULL DROP TABLE dbo.Order_Details;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Individual_Customers', 'U') IS NOT NULL DROP TABLE dbo.Individual_Customers;
IF OBJECT_ID('dbo.Company_Customers', 'U') IS NOT NULL DROP TABLE dbo.Company_Customers;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
IF OBJECT_ID('dbo.Product_Parts', 'U') IS NOT NULL DROP TABLE dbo.Product_Parts;
IF OBJECT_ID('dbo.Parts', 'U') IS NOT NULL DROP TABLE dbo.Parts;
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL DROP TABLE dbo.Products;
IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories;
IF OBJECT_ID('dbo.Assembly_Lines', 'U') IS NOT NULL DROP TABLE dbo.Assembly_Lines;
IF OBJECT_ID('dbo.Suppliers', 'U') IS NOT NULL DROP TABLE dbo.Suppliers;
IF OBJECT_ID('dbo.Calendar', 'U') IS NOT NULL DROP TABLE dbo.Calendar;

-- TWORZENIE TABEL Z NOWYMI KOLUMNAMI

CREATE TABLE dbo.Calendar (
    calendar_date DATE PRIMARY KEY,
    day_off BIT  NOT NULL,
    comment  NVARCHAR(50) NULL
);

CREATE TABLE dbo.Suppliers (
    supplier_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    address NVARCHAR(100),
    city NVARCHAR(50),
    region NVARCHAR(50),
    postal_code NVARCHAR(20),
    country NVARCHAR(50),
    contact_email NVARCHAR(100),
    phone NVARCHAR(50),
    delivery_days INT
);

CREATE TABLE dbo.Assembly_Lines (
    assembly_line_id INT IDENTITY(1,1) PRIMARY KEY,
    min_capability INT,
    max_capability INT
);

CREATE TABLE dbo.Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100),
    assembly_line INT FOREIGN KEY REFERENCES Assembly_Lines(assembly_line_id)
);

CREATE TABLE dbo.Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(100),
    manufacturing_cost MONEY,
    unit_price MONEY,
    category_id INT FOREIGN KEY REFERENCES Categories(category_id),
    production_time_unit INT,
    quantity_in_stock INT,
    warehouse_sector INT,
    production_level INT,
    discontinued BIT DEFAULT 0
);

CREATE TABLE dbo.Parts (
    part_id INT IDENTITY(1,1) PRIMARY KEY,
    part_name NVARCHAR(100),
    part_cost MONEY,
    supplier_id INT FOREIGN KEY REFERENCES Suppliers(supplier_id),
    units_in_stock INT,
    units_on_order INT,
    reorder_level INT,
    discontinued BIT DEFAULT 0 -- NOWA KOLUMNA
);

CREATE TABLE dbo.Product_Parts (
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    part_id INT FOREIGN KEY REFERENCES Parts(part_id),
    quantity INT,
    PRIMARY KEY (product_id, part_id)
);

CREATE TABLE dbo.Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    address NVARCHAR(100),
    city NVARCHAR(50),
    region NVARCHAR(50),
    country NVARCHAR(50),
    postal_code NVARCHAR(20),
    contact_email NVARCHAR(100),
    phone NVARCHAR(50)
);

CREATE TABLE dbo.Individual_Customers (
    customer_id INT PRIMARY KEY FOREIGN KEY REFERENCES Customers(customer_id),
    name NVARCHAR(50),
    surname NVARCHAR(50),
    title_of_courtesy NVARCHAR(20)
);

CREATE TABLE dbo.Company_Customers (
    customer_id INT PRIMARY KEY FOREIGN KEY REFERENCES Customers(customer_id),
    company_name NVARCHAR(100),
    contact_person_name NVARCHAR(50),
    contact_person_surname NVARCHAR(50),
    nip_number NVARCHAR(20)
);

CREATE TABLE dbo.Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    estimated_date DATE,
    delivery_date DATE NULL,
    discount DECIMAL(4, 2) DEFAULT 0.00,
    order_status NVARCHAR(50) DEFAULT 'Pending' -- NOWA KOLUMNA
);

CREATE TABLE dbo.Order_Details (
    order_id INT FOREIGN KEY REFERENCES Orders(order_id),
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    quantity INT,
    unit_price MONEY,
    extra_remarks NVARCHAR(200) NULL,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE dbo.Cancelled_Orders (
    order_id INT PRIMARY KEY FOREIGN KEY REFERENCES Orders(order_id),
    cancellation_date DATETIME,
    reason NVARCHAR(200),
    compensation MONEY
);

CREATE TABLE dbo.Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT FOREIGN KEY REFERENCES Orders(order_id),
    paid_amount MONEY,
    payment_type NVARCHAR(20),
    payment_date DATE
);

CREATE TABLE dbo.Production (
    production_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    assembly_line INT FOREIGN KEY REFERENCES Assembly_Lines(assembly_line_id),
    manufacturing_cost MONEY,
    quantity INT,
    production_startdate DATETIME,
    production_enddate DATETIME NULL,
    order_id INT NULL FOREIGN KEY REFERENCES Orders(order_id)
);

CREATE TABLE Order_Status_History
(
    order_id           int         NOT NULL,
    order_status       nvarchar(50) NOT NULL,
    status_change_date date        NOT NULL,
    CONSTRAINT order_id PRIMARY KEY (order_id)
);



-- foreign keys
-- Reference: AssemblyLines_Category (table: Categories)
ALTER TABLE Categories ADD CONSTRAINT AssemblyLines_Category
    FOREIGN KEY (assembly_line)
    REFERENCES Assembly_Lines (assembly_line);

-- Reference: CompanyCustomer_Customers (table: Company_Customers)
ALTER TABLE Company_Customers ADD CONSTRAINT CompanyCustomer_Customers
    FOREIGN KEY (customer_id)
    REFERENCES Customers (customer_id);

-- Reference: Customers_Orders (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Customers_Orders
    FOREIGN KEY (customer_id)
    REFERENCES Customers (customer_id);

-- Reference: IndividualCustomer_Customers (table: Individual_Customers)
ALTER TABLE Individual_Customers ADD CONSTRAINT IndividualCustomer_Customers
    FOREIGN KEY (customer_id)
    REFERENCES Customers (customer_id);

-- Reference: OrderDetails_Production (table: Production)
ALTER TABLE Production ADD CONSTRAINT OrderDetails_Production
    FOREIGN KEY (order_id,product_id)
    REFERENCES Order_Details (order_id,product_id);

-- Reference: Order_Details_Product (table: Order_Details)
ALTER TABLE Order_Details ADD CONSTRAINT Order_Details_Product
    FOREIGN KEY (product_id)
    REFERENCES Products (product_id);

-- Reference: Order_Order_Details (table: Order_Details)
ALTER TABLE Order_Details ADD CONSTRAINT Order_Order_Details
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);

-- Reference: Orders_Cancelled_Orders (table: Cancelled_Orders)
ALTER TABLE Cancelled_Orders ADD CONSTRAINT Orders_Cancelled_Orders
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);

-- Reference: Orders_Payment (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT Orders_Payment
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);

-- Reference: Part_Supplier (table: Parts)
ALTER TABLE Parts ADD CONSTRAINT Part_Supplier
    FOREIGN KEY (supplier_id)
    REFERENCES Suppliers (supplier_id);

-- Reference: ProductPart_Part (table: Product_Parts)
ALTER TABLE Product_Parts ADD CONSTRAINT ProductPart_Part
    FOREIGN KEY (part_id)
    REFERENCES Parts (part_id);

-- Reference: ProductPart_Product (table: Product_Parts)
ALTER TABLE Product_Parts ADD CONSTRAINT ProductPart_Product
    FOREIGN KEY (product_id)
    REFERENCES Products (product_id);

-- Reference: Product_Category (table: Products)
ALTER TABLE Products ADD CONSTRAINT Product_Category
    FOREIGN KEY (category_id)
    REFERENCES Categories (category_id);

-- Reference: Production_AssemblyLines (table: Production)
ALTER TABLE Production ADD CONSTRAINT Production_AssemblyLines
    FOREIGN KEY (assembly_line)
    REFERENCES Assembly_Lines (assembly_line);

-- Reference: Production_Product (table: Production)
ALTER TABLE Production ADD CONSTRAINT Production_Product
    FOREIGN KEY (product_id)
    REFERENCES Products (product_id);


CREATE TABLE Order_Status_History
(
    order_id           int         NOT NULL,
    order_status       nvarchar(50) NOT NULL,
    status_change_date date        NOT NULL,
    CONSTRAINT order_id PRIMARY KEY (order_id)
);

-- Reference: Order_Status_History_Orders (table: Order_Status_History)
ALTER TABLE Order_Status_History ADD CONSTRAINT Order_Status_History_Orders
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);