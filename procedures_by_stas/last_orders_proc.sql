-- raporty dotyczące poprzednich zamówień produktów przez klienta (w tym
-- przydzielonych rabatów), ujęte w różnych przedziałach czasu;
CREATE PROCEDURE last_orders
    @CustomerID INT,
    @DateFrom DATE,
    @DateTo DATE

AS
BEGIN
    SELECT c.customer_id, o.order_date, o.order_id, SUM(od.unit_price * od.quantity) AS val, o.discount
    FROM Customers c
    INNER JOIN Orders o ON c.customer_id = o.customer_id
    INNER JOIN Order_Details od ON o.order_id = od.order_id

    WHERE c.customer_id = @CustomerID AND o.order_date BETWEEN @DateFrom AND @DateTo
    
    GROUP BY o.order_id, c.customer_id, o.order_date, o.discount
    ORDER BY o.order_date DESC
END;