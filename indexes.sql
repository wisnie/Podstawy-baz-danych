
-- Indeksy dodane na klucze obce
CREATE INDEX IX_Orders_CustomerID ON dbo.Orders (customer_id);

CREATE INDEX IX_Products_CategoryID ON dbo.Products(category_id);

CREATE INDEX IX_Categories_AssemblyLine ON dbo.Categories(assembly_line);

CREATE INDEX IX_Parts_SupplierID ON dbo.Parts(supplier_id);

CREATE INDEX IX_Production_ProductID ON dbo.Production(product_id);
CREATE INDEX IX_Production_AssemblyLine ON dbo.Production(assembly_line);
CREATE INDEX IX_Production_OrderID ON dbo.Production(order_id);

-- Indeksy dodane na dane
CREATE INDEX IX_Orders_OrderDate ON dbo.Orders(order_date);
CREATE INDEX IX_Orders_EstimatedDate ON dbo.Orders(estimated_date);
CREATE INDEX IX_Orders_DeliveryDate ON dbo.Orders(delivery_date);


CREATE INDEX IX_Production_ProductionStartDate ON dbo.Production(production_startdate);
CREATE INDEX IX_Production_ProductionEndDate ON dbo.Production(production_enddate);

-- Indeksy na widokach