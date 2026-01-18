CREATE PROCEDURE dbo.AddOrder(
    @customer_id INT,
    @estimated_date DATE = NULL,
    @delivery_date DATE = NULL,
    @discount DECIMAL(5, 4) = 0,
    @order_status NVARCHAR(50) = 'Processing'
) AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    INSERT INTO Orders (
        customer_id,
        order_date,
        estimated_date,
        delivery_date,
        discount,
        order_status
    )
    VALUES (
        @customer_id,
        SYSDATETIME(),
        @estimated_date,
        @delivery_date,
        @discount,
        @order_status
    );
END;
GO


CREATE PROCEDURE dbo.AddOrderDetail(
    @order_id INT,
    @product_id INT,
    @quantity INT,
    @unit_price MONEY,
    @extra_remarks NVARCHAR(200) = NULL
) AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    INSERT INTO Order_Details
        (order_id, product_id, quantity, unit_price, extra_remarks)
    VALUES (@order_id,
            @product_id,
            @quantity,
            @unit_price,
            @extra_remarks)
END;
GO

CREATE PROCEDURE dbo.AddPart(
    @part_name NVARCHAR(100),
    @part_cost MONEY,
    @supplier_id INT,
    @units_in_stock INT,
    @units_on_order INT,
    @reorder_level INT,
    @discontinued BIT = 0
) AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    INSERT INTO Parts
    (part_name, part_cost, supplier_id, units_in_stock,
     units_on_order, reorder_level, discontinued)
    VALUES (@part_name,
            @part_cost,
            @supplier_id,
            @units_in_stock,
            @units_on_order,
            @reorder_level,
            @discontinued)
END;
GO

CREATE PROCEDURE dbo.AddPartToProduct(
    @part_id INT,
    @product_id INT,
    @quantity INT
) AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    INSERT INTO Product_Parts
    VALUES (@part_id,
            @product_id,
            @quantity)
END;
GO

CREATE PROCEDURE dbo.CancelOrder(
    @order_id INT,
    @reason NVARCHAR(500) = NULL,
    @compensation MONEY = 0
) AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    INSERT INTO Cancelled_Orders
        (order_id, cancellation_date, reason, compensation)
    VALUES (@order_id, SYSDATETIME(),
            @reason, @compensation)
END;
GO

CREATE PROCEDURE EstimateOrderDate(@order_id INT)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        IF (EXISTS(SELECT * FROM Orders WHERE order_id = @order_id AND estimated_date IS NOT NULL))
            BEGIN
                DECLARE @msg NVARCHAR(2048)
                    = FORMATMESSAGE('A delivery date has already been estimated for "%i" order.', @order_id);
                THROW 52000, @msg, 1;
            END

        BEGIN TRANSACTION;

        DECLARE @days_to_finish_order INT;
        DECLARE @estimated_date DATETIME;
        WITH line_occupancy AS (
            SELECT Assembly_Lines.assembly_line,
                   max_capability,
                COALESCE(SUM(quantity * production_time_unit) /
                   CAST(max_capability AS DECIMAL(9,2)), 0)
                 AS line_days_occupation
            FROM Production
            INNER JOIN Products ON Production.product_id = Products.product_id
                AND  production_enddate IS NULL AND order_id <> @order_id
            RIGHT JOIN Assembly_Lines ON
                Production.assembly_line = Assembly_Lines.assembly_line
            GROUP BY Assembly_Lines.assembly_line, max_capability
        )

        SELECT TOP 1 @days_to_finish_order =
                     CEILING(((quantity * production_time_unit) / max_capability)
                   + line_occupancy.line_days_occupation)
        FROM Production
        INNER JOIN Products ON Production.product_id = Products.product_id
        INNER JOIN line_occupancy
            ON line_occupancy.assembly_line = Production.assembly_line
        WHERE production.order_id = @order_id
        ORDER BY (CEILING(((quantity * production_time_unit) / max_capability)
                   + line_occupancy.line_days_occupation)) DESC;

        SELECT @estimated_date = calendar_date FROM Calendar
            WHERE calendar_date >= SYSDATETIME() AND day_off = 0
        ORDER BY calendar_date OFFSET (@days_to_finish_order) ROWS FETCH NEXT 1 ROW ONLY;

        UPDATE Orders SET estimated_date
            = @estimated_date WHERE order_id = @order_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            BEGIN
                ROLLBACK TRANSACTION;
            END

            ;THROW;
    END CATCH
END
GO

CREATE PROCEDURE ViewOrderItems(@order_id INT) AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    SELECT Orders.order_id,
           Products.product_id,
           product_name,
           Products.unit_price,
           quantity,
           Products.unit_price * quantity AS product_total
    FROM Orders
             INNER JOIN Order_Details
                        ON Orders.order_id = Order_Details.order_id
             INNER JOIN Products ON
        Order_Details.product_id = Products.product_id
    WHERE Orders.order_id = @order_id;
END;
GO

CREATE PROCEDURE ViewOrderSummary(@order_id INT) AS
BEGIN
    SELECT Orders.order_id,
           SUM(Products.unit_price * quantity) AS order_total,
           discount,
           SUM(Products.unit_price * quantity) * (1 - discount) AS after_discount
    FROM Orders
             INNER JOIN Order_Details
                        ON Orders.order_id = Order_Details.order_id
             INNER JOIN Products ON
        Order_Details.product_id = Products.product_id
    WHERE Orders.order_id = @order_id
    GROUP BY Orders.order_id, discount;
END;
GO

CREATE PROCEDURE ViewScheduledProduction(
    @product_id INT,
    @start_date DATE,
    @end_date DATE = NULL
) AS
BEGIN
    SET NOCOUNT ON;
    IF @end_date IS NULL
        SET @end_date = SYSDATETIME();

    SELECT production_id,
           production.product_id,
           product_name,
           assembly_line,
           production.manufacturing_cost,
           quantity,
           production_startdate,
           production_enddate,
           order_id
    FROM Production
             INNER JOIN Products
                        ON Production.product_id = Products.product_id
    WHERE production.product_id = @product_id
      AND ((production_startdate >= @start_date AND production_startdate <= @end_date)
        OR (production_enddate >= @start_date AND production_enddate <= @end_date))
END;
GO

