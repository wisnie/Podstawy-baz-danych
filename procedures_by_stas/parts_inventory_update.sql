--  3. Aktualizacja stanów części po rozpoczęciu produkcji,
-- WHEN: AFTER INSERT na Produkcja
-- CO ROBI:

-- odejmuje ilości części wg BOM (struktura produktu),

CREATE TRIGGER update_parts_inventory
ON Production
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.units_in_stock = p.units_in_stock - (pp.quantity * i.quantity)
    FROM Parts p
    JOIN Product_Parts pp ON p.part_id = pp.part_id
    JOIN inserted i ON pp.product_id = i.product_id;
END;