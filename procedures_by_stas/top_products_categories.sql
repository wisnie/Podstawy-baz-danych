-- raporty dla kadry zarządczej dotyczące sprzedaży grup produktów w poszczególnych
-- tygodniach i miesiącach oraz kosztów produkcji produktów (także w tygodniach i
-- miesiącach);

--(top produkty w danej kategorii)

CREATE PROCEDURE top_product_groups
    @DateFrom DATE,
    @DateTo DATE,
    @CategoryID INT
AS
BEGIN
    SELECT p.product_id, p.product_name, SUM(od.unit_price * od.quantity) AS val FROM Products p
    INNER JOIN Order_Details od ON od.product_id = p.product_id
    INNER JOIN Orders o ON o.order_id = od.order_id
    WHERE p.category_id = @CategoryID AND o.order_date BETWEEN @DateFrom AND @DateTo
    GROUP BY p.product_id, p.product_name
    ORDER BY val DESC
END;