USE u_bawisnie;

-- Table: Assembly_Lines
CREATE TABLE Assembly_Lines (
    assembly_line int  NOT NULL IDENTITY CHECK (assembly_line >= 0),
    min_capability int  NOT NULL,
    max_capability int  NOT NULL,
    CONSTRAINT Assembly_Lines_pk PRIMARY KEY  (assembly_line)
);

-- Table: Cancelled_Orders
CREATE TABLE Cancelled_Orders (
    order_id int  NOT NULL,
    cancellation_date datetime  NOT NULL,
    reason nvarchar(500)  NOT NULL,
    compensation money  NOT NULL CHECK (compensation >= 0),
    CONSTRAINT Cancelled_Orders_pk PRIMARY KEY  (order_id)
);

-- Table: Categories
CREATE TABLE Categories (
    category_id int  NOT NULL IDENTITY,
    category_name nvarchar(50)  NOT NULL,
    assembly_line int  NOT NULL,
    CONSTRAINT Categories_pk PRIMARY KEY  (category_id)
);

-- Table: Company_Customers
CREATE TABLE Company_Customers (
    customer_id int  NOT NULL,
    company_name nvarchar(100)  NOT NULL,
    contact_person_name nvarchar(100)  NOT NULL,
    contact_person_surname nvarchar(100)  NOT NULL,
    nip_number nvarchar(10)  NOT NULL,
    CONSTRAINT Company_Customers_pk PRIMARY KEY  (customer_id)
);

-- Table: Customers
CREATE TABLE Customers (
    customer_id int  NOT NULL IDENTITY,
    address nvarchar(100)  NOT NULL,
    city nvarchar(30)  NOT NULL,
    region nvarchar(50)  NOT NULL,
    country nvarchar(50)  NOT NULL,
    postal_code nvarchar(10)  NOT NULL,
    contact_email nvarchar(100)  NOT NULL CHECK (contact_email LIKE '%_@__%.__%'),
    phone nvarchar(15)  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY  (customer_id)
);

-- Table: Individual_Customers
CREATE TABLE Individual_Customers (
    customer_id int  NOT NULL,
    name nvarchar(100)  NOT NULL,
    surname nvarchar(100)  NOT NULL,
    title_of_courtesy nvarchar(10)  NOT NULL,
    CONSTRAINT Individual_Customers_pk PRIMARY KEY  (customer_id)
);

-- Table: Order_Details
CREATE TABLE Order_Details (
    order_id int  NOT NULL,
    product_id int  NOT NULL,
    quantity int  NOT NULL CHECK (quantity > 0),
    unit_price money  NOT NULL CHECK (unit_price > 0),
    extra_remarks nvarchar(200)  NULL,
    CONSTRAINT Order_Details_pk PRIMARY KEY  (order_id,product_id)
);

-- Table: Orders
CREATE TABLE Orders (
    order_id int  NOT NULL IDENTITY,
    customer_id int  NOT NULL,
    order_date date  NOT NULL,
    estimated_date date  NOT NULL,
    delivery_date date  NULL,
    discount decimal(5,4)  NOT NULL CHECK (discount BETWEEN 0 AND 1 ),
    CONSTRAINT required_date_after_order CHECK (estimated_date >= order_date),
    CONSTRAINT delivery_date_after_order CHECK (delivery_date >= order_date),
    CONSTRAINT Orders_pk PRIMARY KEY  (order_id)
);

-- Table: Parts
CREATE TABLE Parts (
    part_id int  NOT NULL IDENTITY,
    part_name nvarchar(100)  NOT NULL,
    part_cost money  NOT NULL CHECK (part_cost >= 0),
    supplier_id int  NOT NULL,
    units_in_stock int  NOT NULL CHECK (units_in_stock >= 0),
    units_on_order int  NOT NULL CHECK (units_on_order >= 0),
    reorder_level int  NOT NULL CHECK (reorder_level >= 0),
    CONSTRAINT Parts_pk PRIMARY KEY  (part_id)
);

-- Table: Payments
CREATE TABLE Payments (
    order_id int  NOT NULL,
    paid_amount money  NOT NULL CHECK (paid_amount > 0),
    payment_type nvarchar(20)  NOT NULL,
    payment_date datetime  NOT NULL,
    CONSTRAINT Payments_pk PRIMARY KEY  (order_id)
);

-- Table: Product_Parts
CREATE TABLE Product_Parts (
    product_id int  NOT NULL,
    part_id int  NOT NULL,
    quantity int  NOT NULL CHECK (quantity >= 0),
    CONSTRAINT Product_Parts_pk PRIMARY KEY  (part_id,product_id)
);

-- Table: Production
CREATE TABLE Production (
    production_id int  NOT NULL IDENTITY,
    product_id int  NOT NULL,
    assembly_line int  NOT NULL,
    manufacturing_cost money  NOT NULL CHECK (manufacturing_cost >= 0),
    quantity int  NOT NULL CHECK (quantity >= 0),
    production_startdate datetime  NULL,
    production_enddate datetime  NULL,
    order_id int  NULL,
    CONSTRAINT production_startdate_bef_enddate CHECK (production_startdate <= production_enddate),
    CONSTRAINT Production_pk PRIMARY KEY  (production_id)
);

-- Table: Products
CREATE TABLE Products (
    product_id int  NOT NULL IDENTITY,
    product_name nvarchar(100)  NOT NULL,
    manufacturing_cost money  NOT NULL CHECK (manufacturing_cost >= 0),
    unit_price money NOT NULL CHECK (unit_price >= 0),
    category_id int  NOT NULL,
    production_time_unit int  NOT NULL CHECK (production_time_unit >= 0),
    quantity_on_stock int  NOT NULL CHECK (quantity_on_stock >= 0),
    warehouse_sector int  NOT NULL CHECK (warehouse_sector >=0),
    production_level int  NOT NULL CHECK (production_level >= 0),
    CONSTRAINT Products_pk PRIMARY KEY  (product_id)
);

-- Table: Suppliers
CREATE TABLE Suppliers (
    supplier_id int  NOT NULL IDENTITY,
    name nvarchar(50)  NOT NULL,
    address nvarchar(100)  NOT NULL,
    city nvarchar(30)  NOT NULL,
    region nvarchar(50)  NOT NULL,
    postal_code nvarchar(10)  NOT NULL,
    country nvarchar(30)  NOT NULL,
    contact_email nvarchar(100)  NOT NULL CHECK (contact_email LIKE '%_@__%.__%'),
    phone nvarchar(15)  NOT NULL,
    delivery_days int  NOT NULL CHECK (delivery_days >= 0),
    CONSTRAINT Suppliers_pk PRIMARY KEY  (supplier_id)
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
