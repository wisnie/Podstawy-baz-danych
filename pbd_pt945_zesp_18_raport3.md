## Dokumentacja projektu "firma produkcyjno-usługowa"

Dzień i godzina zajęć: pt. 9:45

Nr zespołu: 18

**Autorzy:** Małgorzata Liskowska, Stanisław Ogonowski, Bartłomiej Wiśniewski

## 1. Wymagania funkcyjne systemu

Celem projektu jest projekt bazy danych dla firmy usługowo-produkcyjnej.
Klient biznesowy specjalizuje się w produkcji mebli biurowych, w szczególności do pomieszczeń z urządzeniami komputerowymi.

### Persona: klient sklepu

- klient składa zamówienie, znając oczekiwaną datę odbioru. Oczekiwana data reliazacji zamówienia jest obliczona automatycznie na podstawie aktualnych zamówień, stanu magazynu i dostępności części.
- w przypadku braku części potrzebnych do realizacji zamówienia, do oczekiwanej daty zamówienia dodawany jest także czas potrzebny na sprowadzenie części.
- klient może modyfikować swoje zamówienie, jednak może to powodować opóźnienie w planie produkcji.
- w przypadku rezygnacji z zamówienia klient może ponieść dodatkową opłatę.
- klient jest informowany w przypadku, gdy zamówienie jest opóźnione i może zrezygnować ze swojego zamówienia; wówczas nie ponosi dodatkowej opłaty za zamówienie.
- klient może zadeklarować metodę płatności jako karta/gotówka lub płatność przy odbiorze, a także regulować płatność na różne sposoby (np. zaliczka, lub w wielu ratach).
- klient może otrzymać rabat procentowy na całe zamówienie.
- klientem może być zarówno klient indywidualny jak i zewnętrzna firma.
- klient może przeglądać produkty po kategoriach.

### Założenia

- konkretna część jest dostarczana przez jednego dostawcę.
- koszt pracy linii produkcyjnych jest niezależny od liczby produktów.
- umowy z dostawcami są podpisywane z góry na cały rok.
- sklep nie odpowiada za wysyłkę towarów.
- produkty są składane na poszczególnych zespołach linii produkcyjnych, w zależności od kategorii, do której należą. Na danym zespole linii produkcyjnych mogą być produkowane produkty z wielu kategorii.
- zawarta jest informacja o maksymalnych mocach przerobowych firmy na konkretnym zestawie linii produkcyjnych.
- na każdym zestawie linii produkcyjnych istnieje minimalny poziom produkcji.
- sklep domawia części na magazyn, jeśli na magazynie jest mniej niż 10% docelowej wartości.
- w przypadku braku części na zamówienie sklep domawia je w taki sposób, aby wciąż osiągać określony cel.
- na podstawie aktualnych zamówień ustalana jest kolejka, na podstawie której produkowane są poszczególne produkty.
- w przypadku braku zamówień sklep dąży do określonego poziomu danego produktu na magazynie.
- klient może modyfikować swoje zamówienie:
  - w przypadku zmniejszenia wielkości zamówienia, wyprodukowana nadwyżka trafia na magazyn (Jeśli produkcja nie została rozpoczęta, jej plan jest odpowiednio modyfikowany).
  - w przypadku zwiększenia wielkości zamówienia:
    - Jeśli aktualna produkcja zwiększa się przed/w trakcie zamówienia, modyfikuje się plan produkcji dla danego produktu.
    - Jeśli aktualna produkcja zwiększa się po wyprodukowaniu zamówienia, tworzy się nowy plan produkcji dla dodatkowo zamówionej partii produktu.

## 2. Baza danych

## Schemat bazy danych

![Schemat bazy danych](schemat_bazy_5.svg)

## Opisy poszczególnych tabel (wraz z kodem DDL)

### Products

| Kolumna              | Typ           | Klucz  | Opis/Uwagi                                                                                                                                                   |
| -------------------- | ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| product_id           | int           | główny | Identyfikator produktu                                                                                                                                       |
| product_name         | nvarchar(100) |        | Nazwa produktu                                                                                                                                               |
| unit_price           | money         |        | Aktualna cena jednostkowa produktu                                                                                                                           |
| manufactoring_cost   | money         |        | Koszt wyprodukowania jednej sztuki (koszt części + robocizna)                                                                                                |
| category_id          | int           | obcy   | Identyfikator kategorii                                                                                                                                      |
| production_time_unit | int           |        | Jednostka określająca całkowitą liczbę jednostek czasu, w której produkowany jest dany produkt. 10 jednostek to jedna roboczogodzina na taśmie produkcyjnej. |
| quantity_in_stock    | int           |        | Liczba sztuk na magazynie                                                                                                                                    |
| warehouse_sector     | int           |        | Sektor w magazynie, przy którym znajduje się produkt                                                                                                         |
| production_level     | int           |        | Liczba sztuk produktu do której dąży się w przypadku mniejszych obrotów na produkcji                                                                         |
| discontinued         | bit           |        | Określa, czy część została wycofana                                                                                                                          |

#### Kod DDL

```sql
-- Table: Products
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
```

### ProductParts

| Kolumna    | Typ | Klucz        | Opis/Uwagi                                                                                           |
| ---------- | --- | ------------ | ---------------------------------------------------------------------------------------------------- |
| product_id | int | główny, obcy | Identyfikator produktu                                                                               |
| part_id    | int | główny, obcy | Identyfikator części potrzebnej do produkcji produktu o identyfikatorze product_id                   |
| quantity   | int |              | Liczba części o identyfikatorze part_id potrzebna do produkcji produktu o identyfikatorze product_id |

#### Kod DDL

```sql
-- Table: Product_Parts
CREATE TABLE dbo.Product_Parts (
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    part_id INT FOREIGN KEY REFERENCES Parts(part_id),
    quantity INT,
    PRIMARY KEY (product_id, part_id)
);
```

### Parts

| Kolumna        | Typ           | Klucz  | Opis/Uwagi                                              |
| -------------- | ------------- | ------ | ------------------------------------------------------- |
| part_id        | int           | główny | Identyfikator części                                    |
| part_name      | nvarchar(100) |        | Nazwa części                                            |
| part_cost      | money         |        | Cena jednostkowa części                                 |
| supplier_id    | int           | obcy   | Identyfikator dostawcy                                  |
| units_in_stock | int           |        | Liczba części w magazynie                               |
| units_on_order | int           |        | Liczba części zamówionych (w drodze)                    |
| reorder_level  | int           |        | Liczba units_in_stock przy której należy domówić części |
| discontinued   | bit           |        | Określa, czy część została wycofana                     |

#### Kod DDL

```sql
-- Table: Parts
CREATE TABLE dbo.Parts (
    part_id INT IDENTITY(1,1) PRIMARY KEY,
    part_name NVARCHAR(100),
    part_cost MONEY,
    supplier_id INT FOREIGN KEY REFERENCES Suppliers(supplier_id),
    units_in_stock INT,
    units_on_order INT,
    reorder_level INT,
    discontinued BIT DEFAULT 0
);
```

### Suppliers

| Kolumna       | Typ           | Klucz  | Opis/Uwagi                                                                  |
| ------------- | ------------- | ------ | --------------------------------------------------------------------------- |
| supplier_id   | int           | główny | Identyfikator dostawcy                                                      |
| name          | nvarchar(50)  |        | Nazwa firmy dostarczającej części                                           |
| adress        | nvarchar(100) |        | Ulica i numer budynku                                                       |
| city          | nvarchar(30)  |        | Miasto siedziby firmy                                                       |
| region        | nvarchar(50)  |        | Województwo/stan/land                                                       |
| postal_code   | nvarchar (10) |        | Kod pocztowy                                                                |
| country       | nvarchar(30)  |        | Kraj                                                                        |
| contact_email | nvarchar(100) |        | Adres email                                                                 |
| phone         | nvarchar (15) |        | Numer telefonu                                                              |
| delivery_days | int           |        | Średni oczekiwany czas dostawy (do oszacowania czasu realizacji zamówienia) |

#### Kod DDL

```sql
-- Table: Suppliers
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
```

### Categories

| Kolumna       | Typ          | Klucz  | Opis/Uwagi                        |
| ------------- | ------------ | ------ | --------------------------------- |
| category_id   | int          | główny | Identyfikator kategorii           |
| category_name | nvarchar(50) |        | Nazwa kategorii                   |
| assembly_line | int          | obcy   | Numer zespołu linii produkcyjnych |

#### Kod DDL

```sql
-- Table: Categories
CREATE TABLE dbo.Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100),
    assembly_line INT FOREIGN KEY REFERENCES Assembly_Lines(assembly_line_id)
);
```

### AssemblyLines

| Kolumna        | Typ | Klucz  | Opis/Uwagi                                                      |
| -------------- | --- | ------ | --------------------------------------------------------------- |
| assembly_line  | int | główny | Numer taśmy produkcyjnej                                        |
| min_capability | int |        | Minimalna liczba produktów wytwarzanych na taśmie w ciągu dnia  |
| max_capability | int |        | Maksymalna liczba produktów wytwarzanych na taśmie w ciągu dnia |

#### Kod DDL

```sql
-- Table: Assembly_Lines
CREATE TABLE dbo.Assembly_Lines (
    assembly_line_id INT IDENTITY(1,1) PRIMARY KEY,
    min_capability INT,
    max_capability INT
);
```

### Production

| Kolumna              | Typ      | Klucz        | Opis/Uwagi                                                                                              |     |
| -------------------- | -------- | ------------ | ------------------------------------------------------------------------------------------------------- | --- |
| production_id        | int      | główny       | Identyfikator produkcji                                                                                 |
| product_id           | int      | główny, obcy | Identyfikator produktu                                                                                  |
| assembly_line        | int      | główny, obcy | Numer taśmy produkcyjnej                                                                                |     |
| manufactoring_cost   | money    |              | Koszt wyprodukowania jednej sztuki (włącznie z częściami - koszt ten może się zmieniać z biegiem czasu) |
| quantity             | int      |              | Liczba wyprodukowanego produktu w danej partii                                                          |
| production_startdate | datetime |              | Data rozpoczęcia produkcji                                                                              |
| production_enddate   | datetime |              | Data zakończenia produkcji                                                                              |

#### Kod DDL

```sql
-- Table: Production
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

```

### Orders

| Kolumna        | Typ          | Klucz  | Opis/Uwagi                                 |
| -------------- | ------------ | ------ | ------------------------------------------ |
| order_id       | int          | główny | Identyfikator zamówienia                   |
| customer_id    | int          | obcy   | Identyfikator klienta                      |
| order_date     | date         |        | Data złożenia zamówienia                   |
| estimated_date | date         |        | Zadeklarowana data dostarczenia zamówienia |
| delivery_date  | date         |        | Rzeczywista data dostarczenia zamówienia   |
| discount       | decimal(5,4) |        | Zniżka na całe zamówienie                  |
| order_status   | nvarchar(5)  |        | Aktualny status zamówienia                 |

#### Kod DDL

```sql
-- Table: Orders
CREATE TABLE dbo.Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    estimated_date DATE,
    delivery_date DATE NULL,
    discount DECIMAL(4, 2) DEFAULT 0.00,
    order_status NVARCHAR(50) DEFAULT 'Pending'
);
```

### OrderDetails

| Kolumna       | Typ           | Klucz        | Opis/Uwagi               |
| ------------- | ------------- | ------------ | ------------------------ |
| order_id      | int           | główny, obcy | Identyfikator zamówienia |
| product_id    | int           | główny, obcy | Identyfikator produktu   |
| quantity      | int           |              | Liczba zamówionych sztuk |
| unit_price    | money         |              | Cena za sztukę           |
| extra_remarks | nvarchar(200) |              | Uwagi dodatkowe          |

#### Kod DDL

```sql
-- Table: Order_Details
CREATE TABLE dbo.Order_Details (
    order_id INT FOREIGN KEY REFERENCES Orders(order_id),
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    quantity INT,
    unit_price MONEY,
    extra_remarks NVARCHAR(200) NULL,
    PRIMARY KEY (order_id, product_id)
);
```

### Payments

| Kolumna      | Typ          | Klucz        | Opis/Uwagi                                             |
| ------------ | ------------ | ------------ | ------------------------------------------------------ |
| order_id     | int          | główny, obcy | Identyfikator zamówienia                               |
| paid_amount  | money        |              | Zapłacona kwota                                        |
| payment_type | nvarchar(20) |              | Typ płatności (np. karta przy odbiorze, BLIK, przelew) |
| payment_date | datetime     |              | Data zaksięgowania przelewu                            |

#### Kod DDL

```sql
-- Table: Payments
CREATE TABLE dbo.Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT FOREIGN KEY REFERENCES Orders(order_id),
    paid_amount MONEY,
    payment_type NVARCHAR(20),
    payment_date DATE
);
```

### Cancelled_Orders

| Kolumna      | Typ           | Klucz        | Opis/Uwagi                                        |
| ------------ | ------------- | ------------ | ------------------------------------------------- |
| order_id     | int           | główny, obcy | Identyfikator zamówienia                          |
| cancel_date  | datetime      |              | Data anulowania zamówienia                        |
| reason       | nvarchar(500) |              | Powód anulowania zamówienia                       |
| compensation | money         |              | Wartość dodatkowej opłaty za anulowane zamówienie |

#### Kod DDL

```sql
-- Table: Cancelled_Orders
CREATE TABLE dbo.Cancelled_Orders (
    order_id INT PRIMARY KEY FOREIGN KEY REFERENCES Orders(order_id),
    cancellation_date DATETIME,
    reason NVARCHAR(200),
    compensation MONEY
);
```

### Order_Status_History

| Kolumna            | Typ         | Klucz  | Opis/Uwagi                     |
| ------------------ | ----------- | ------ | ------------------------------ |
| order_id           | int         | główny | ID zamówienia                  |
| order_status       | nvarchar(5) |        | Skrót statusu zamówienia       |
| status_change_date | date        |        | Data ostatniej zmienay statusu |

#### Kod DDL

```sql
-- Table: Order_Status_History
CREATE TABLE dbo.Order_Status_History
(
    order_id           int         NOT NULL,
    order_status       nvarchar(50) NOT NULL,
    status_change_date date        NOT NULL,
    CONSTRAINT order_id PRIMARY KEY (order_id)
);
```

### Customers

| Kolumna       | Typ            | Klucz  | Opis/Uwagi                                           |
| ------------- | -------------- | ------ | ---------------------------------------------------- |
| customer_id   | int            | główny | Identyfikator klienta                                |
| address       | nvarchar (100) |        | Ulica i numer budynku                                |
| city          | nvarchar(30)   |        | Miasto siedziby klienta/ Miasto zamieszkania klienta |
| region        | nvarchar(50)   |        | Województwo/stan/land                                |
| country       | nvarchar(50)   |        | Kraj                                                 |
| postal_code   | nvarchar(10)   |        | Kod pocztowy                                         |
| contact_email | nvarchar(100)  |        | Email                                                |
| phone         | nvarchar (15)  |        | Numer telefonu                                       |

#### Kod DDL

```sql
-- Table: Customers
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
```

### IndividualCustomers

| Kolumna           | Typ           | Klucz        | Opis/Uwagi            |
| ----------------- | ------------- | ------------ | --------------------- |
| customer_id       | int           | główny, obcy | Identyfikator klienta |
| name              | nvarchar(100) |              | Imię klienta          |
| surname           | nvarchar(100) |              | Nazwisko klienta      |
| title_of_courtesy | nvarchar(10)  |              | Pan/Pani              |

#### Kod DDL

```sql
-- Table: Individual_Customers
CREATE TABLE dbo.Individual_Customers (
    customer_id INT PRIMARY KEY FOREIGN KEY REFERENCES Customers(customer_id),
    name NVARCHAR(50),
    surname NVARCHAR(50),
    title_of_courtesy NVARCHAR(20)
);
```

### CompanyCustomers

| Kolumna                | Typ           | Klucz        | Opis/Uwagi                 |
| ---------------------- | ------------- | ------------ | -------------------------- |
| customer_id            | int           | główny, obcy | Identyfikator klienta      |
| company_name           | nvarchar(100) |              | Nazwa firmy                |
| contact_person_name    | nvarchar(100) |              | Imię osoby kontaktowej     |
| contact_person_surname | nvarchar(100) |              | Nazwisko osoby kontaktowej |
| nip_number             | nvarchar (10) |              | Numer NIP firmy            |

#### Kod DDL

```sql
-- Table: Company_Customers
CREATE TABLE dbo.Company_Customers (
    customer_id INT PRIMARY KEY FOREIGN KEY REFERENCES Customers(customer_id),
    company_name NVARCHAR(100),
    contact_person_name NVARCHAR(50),
    contact_person_surname NVARCHAR(50),
    nip_number NVARCHAR(20)
);
```

### Calendar

| Kolumna       | Typ          | Klucz  | Opis/Uwagi                      |
| ------------- | ------------ | ------ | ------------------------------- |
| calendar_date | date         | główny | Data                            |
| day_off       | tinyint      |        | Dzień tygodnia                  |
| comment       | nvarchar(50) |        | Komentarz dot. przyczyny święta |

#### Kod DDL

```sql
-- Table: Calendar
CREATE TABLE dbo.Calendar
(
    calendar_date DATE PRIMARY KEY,
    day_off BIT  NOT NULL,
    comment  NVARCHAR(50) NULL
);
```

## Referencje pomiędzy tabelami

```sql
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

-- Reference: Order_Status_History_Orders (table: Order_Status_History)
ALTER TABLE Order_Status_History ADD CONSTRAINT Order_Status_History_Orders
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);
```

# 3. Widoki, procedury/funkcje, triggery

## Widoki

1. **PartsPrice** - pokazuje łączną cenę wszystkich części potrzebnych do wyprodukowania każdego produktu (`craft_price`).

```sql
CREATE VIEW Parts_Price AS
    SELECT pp.product_id, p.product_name, SUM(pp.quantity * pa.part_cost) AS craft_price FROM Products p
        INNER JOIN Product_Parts pp ON p.product_id = pp.product_id
        INNER JOIN Parts pa ON pa.part_id = pp.part_id
        GROUP BY pp.product_id, p.product_name
```

2. **Product_Profits** - prezentuje jednostkowy zysk produktu, wyrażony kwotowo oraz procentowo na podstawie ceny sprzedaży i kosztu wytworzenia.

```sql
CREATE VIEW Product_Profits AS
    SELECT product_id, product_name, unit_price, manufacturing_cost, (unit_price-manufacturing_cost) AS profit, (manufacturing_cost/unit_price*100) AS percent_profit FROM Products
```

3. **Individual_Client_Orders** - dla każdego klienta indywidualnego pokazuje jego łączną liczbę złożonych zamówień, liczbę zamówień w trakcie realizacji, łączną sumę wydanych pieniędzy w sklepie (po zniżkach), łączną sumę otrzymanych rabatów, liczbę odwołanych zamówień oraz bilans konta, czyli różnicę między przelanymi pieniędzmi na konto naszej firmy, a sumą wartości wszystkich złożonych zamówień (bilans jest ujemny dla klientów z długiem dla firmy).

```sql
CREATE VIEW Individual_Clients_Orders AS
    WITH Customer_Stats AS (
        SELECT o.customer_id,
            COUNT (DISTINCT o.order_id) AS total_orders,
            COUNT (o.order_id) - COUNT (o.delivery_date) AS handled_orders,
            COALESCE (SUM (od.quantity * od.unit_price * (1 - o.discount)), 0) AS total_money_spent,
            COALESCE (SUM (od.quantity * od.unit_price * o.discount), 0) AS total_money_saved,
            COUNT (DISTINCT co.order_id) AS cancelled_orders_counter,
            COALESCE (SUM (od.quantity * od.unit_price * (1 - o.discount)) - SUM (p.paid_amount), 0) AS balance
        FROM Orders o
        LEFT JOIN Order_Details od
            ON o.order_id = od.order_id
        LEFT JOIN Payments p
            ON o.order_id = p.order_id
        LEFT JOIN Cancelled_Orders co
            ON o.order_id = co.order_id
        GROUP BY o.customer_id
    )
    SELECT ic.customer_id, ic.name, ic.surname,
           total_orders, handled_orders,
           total_money_spent, total_money_saved,
           cancelled_orders_counter, balance
    FROM Individual_Customers ic
        LEFT JOIN Customer_Stats cs
            ON ic.customer_id = cs.customer_id;
```

## Procedury/funkcje

1. **AddOrder** - dodaje zamówienie do bazy danych.

```sql
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
```

2. **AddOrderDetail** - dodaje produkt do zamówienia.

```sql
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
```

3. **CancelOrder** - przenosi zamówienie do Cancelled_Orders.

```sql
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
```

4. **AddPart** - dodaje nową część do bazy danych.

```sql
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
```

5. **AddPartToProduct** - dodaje część do definicji produktu.

```sql
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
```

6. **ViewScheduledProduction** - wyświetla zaplanowaną produkcję.

```sql
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

```

7. **ViewCurrentProduction** - wyświetla produkty w trakcie produkcji na podanej taśmie produkcyjnej.

```sql
CREATE PROCEDURE ViewCurrentProduction
    @assembly_line INT
AS
    SELECT p.production_id, p.product_id, product_name, p.quantity, p.production_startdate, p.order_id
    FROM Production p
          INNER JOIN Products pr
                     ON p.product_id = pr.product_id
    WHERE production_enddate IS NULL
        AND assembly_line = @assembly_line
GO
```

8. **AddProduct** - dodaje nowy produkt do bazy danych.

```sql
CREATE PROCEDURE AddProduct (
    @product_name NVARCHAR(100),
    @unit_price MONEY,
    @manufacturing_cost MONEY,
    @category_id INT,
    @production_time_unit INT,
    @quantity_in_stock INT,
    @warehouse_sector INT,
    @production_level INT,
    @discontinued BIT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        IF EXISTS(SELECT * FROM Products WHERE product_name = @product_name)
            BEGIN
                THROW 52000, N'Product already exists', 1;
            END

        INSERT INTO Products(product_name,
                             unit_price,
                             manufacturing_cost,
                             category_id,
                             production_time_unit,
                             quantity_in_stock,
                             warehouse_sector,
                             production_level,
                             discontinued)
        VALUES(@product_name,
               @unit_price,
               @manufacturing_cost,
               @category_id,
               @production_time_unit,
               @quantity_in_stock,
               @warehouse_sector,
               @production_level,
               @discontinued)

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
```

9. **AddIndividualCustomer** - dodaje nowego klienta indywidualnego do bazy danych.

```sql
CREATE PROCEDURE AddIndividualCustomer
    (@adress NVARCHAR(100), @city NVARCHAR(30), @region NVARCHAR(50),
     @country NVARCHAR(50), @postal_code NVARCHAR(10), @contact_email NVARCHAR(100),
     @phone nvarchar(15), @name NVARCHAR(100), @surname NVARCHAR(100),
     @title_of_courtesy NVARCHAR(10))
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
            INSERT INTO Customers(address, city, region, country, postal_code, contact_email, phone)
            VALUES(@adress, @city, @region, @country, @postal_code, @contact_email, @phone)

            DECLARE @customer_id INT = SCOPE_IDENTITY();

            INSERT INTO Individual_Customers(customer_id, name, surname, title_of_courtesy)
            VALUES (@customer_id, @name, @surname, @title_of_courtesy)
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
```

10. **AddCompanyCustomer** - dodaje nową firmę będącą klientem do bazy danych.

```sql
CREATE PROCEDURE AddCompanyCustomer
    @address NVARCHAR(100), @city NVARCHAR(30), @region NVARCHAR(50),
    @country NVARCHAR(50), @postal_code NVARCHAR(10), @contact_email NVARCHAR(100),
    @phone NVARCHAR(15), @company_name NVARCHAR(100),
    @contact_person_name NVARCHAR(100), @contact_person_surname NVARCHAR(100),
    @nip_number NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        IF EXISTS(SELECT * FROM Company_Customers WHERE company_name = @company_name)
        BEGIN
            DECLARE @msg NVARCHAR(2048) = FORMATMESSAGE('Company with name "%s" already exists.', @company_name);
            THROW 51000, @msg, 1;
        END

        BEGIN TRANSACTION;

            INSERT INTO Customers (address, city, region, country, postal_code, contact_email, phone)
            VALUES (@address, @city, @region, @country, @postal_code, @contact_email, @phone);

            DECLARE @customer_id INT = SCOPE_IDENTITY();

            INSERT INTO Company_Customers (customer_id, company_name, contact_person_name, contact_person_surname, nip_number)
            VALUES (@customer_id, @company_name, @contact_person_name, @contact_person_surname, @nip_number);

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
```

11. **LastOrdersFromClient** - generuje poprzednie zamówienia danego klienta, wraz ze zniżkami i wartością zamówienia przed/po zniżce

```sql
CREATE PROCEDURE LastOrdersFromClient
    @CustomerID INT,
    @DateFrom DATE,
    @DateTo DATE
AS
BEGIN
    SELECT
        c.customer_id,
        o.order_id,
        o.order_date,
        SUM(od.unit_price * od.quantity) AS total_before_discount,
        SUM(od.unit_price * od.quantity) * o.discount AS discount_value,
        SUM(od.unit_price * od.quantity) * (1 - o.discount) AS total_after_discount,
        o.discount
    FROM Customers c
    INNER JOIN Orders o
        ON c.customer_id = o.customer_id
    INNER JOIN Order_Details od
        ON o.order_id = od.order_id
    WHERE
        c.customer_id = @CustomerID
        AND o.order_date BETWEEN @DateFrom AND @DateTo
    GROUP BY
        c.customer_id,
        o.order_id,
        o.order_date,
        o.discount
    ORDER BY
        o.order_date DESC;
END;
```

12. **TopProductGroups** - generuje listę najlepiej sprzedawanych produktów (wewnątrz danej kategorii) w tygodniu, miesiącu, roku, w podanym zakresie dat

```sql
CREATE PROCEDURE TopProductGroups
    @DateFrom DATE,
    @DateTo DATE,
    @CategoryID INT
AS
BEGIN
    SELECT
        p.product_id,
        p.product_name,

        -- wartości
        SUM(od.unit_price * od.quantity) AS total_before_discount,
        SUM(od.unit_price * od.quantity * od.discount) AS total_discount,
        SUM(od.unit_price * od.quantity * (1 - o.discount)) AS total_after_discount,

        -- grupowanie czasowe
        DATEPART(YEAR, o.order_date) AS year_no,
        DATEPART(MONTH, o.order_date) AS month_no,
        DATEPART(WEEK, o.order_date) AS week_no

    FROM Products p
    INNER JOIN Order_Details od ON od.product_id = p.product_id
    INNER JOIN Orders o ON o.order_id = od.order_id

    WHERE
        p.category_id = @CategoryID
        AND o.order_date BETWEEN @DateFrom AND @DateTo

    GROUP BY
        ROLLUP (
            p.product_id,
            p.product_name,
            DATEPART(YEAR, o.order_date),
            DATEPART(MONTH, o.order_date),
            DATEPART(WEEK, o.order_date)
        )

    ORDER BY
        total_after_discount DESC;
END;
```

13. **TopProductsValue** - generuje listę najbardziej dochodowych produktów w tygodniu, miesiącu, roku, w podanym zakresie dat.

```sql
CREATE PROCEDURE TopProductsValue
    @date_from DATE,
    @date_to DATE
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    BEGIN TRY
        IF @date_from > @date_to
            BEGIN
                DECLARE @msg NVARCHAR(2048) = FORMATMESSAGE('Date To is earlier than Date From');
                THROW 56000, @msg, 1;
            END
        SELECT
            p.product_id,
            p.product_name,

            SUM(od.unit_price * od.quantity) AS total_before_discount,
            SUM(od.unit_price * od.quantity * o.discount) AS total_discount,
            SUM(od.unit_price * od.quantity * (1 - o.discount)) AS total_after_discount,

            DATEPART(YEAR, o.order_date) AS year_no,
            DATEPART(MONTH, o.order_date) AS month_no,
            DATEPART(WEEK, o.order_date) AS week_no

        FROM Products p
        INNER JOIN Order_Details od ON od.product_id = p.product_id
        INNER JOIN Orders o ON o.order_id = od.order_id

        WHERE
            o.order_date BETWEEN @date_from AND @date_to

        GROUP BY
            ROLLUP (
                p.product_id,
                p.product_name,
                DATEPART(YEAR, o.order_date),
                DATEPART(MONTH, o.order_date),
                DATEPART(WEEK, o.order_date)
            )

        ORDER BY
            total_after_discount DESC;
    END TRY
    BEGIN CATCH
        ;THROW;
    END CATCH;
END;
```

14. **TopProductsNumber** - generuje listę najlepiej sprzedawanych produktów w tygodniu, miesiącu, roku, w podanym zakresie dat

```sql
CREATE PROCEDURE TopProductsNumber
    @DateFrom DATE,
    @DateTo DATE
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM Orders WHERE order_date BETWEEN @DateFrom AND @DateTo)
            BEGIN
                DECLARE @msg NVARCHAR(2048) = FORMATMESSAGE('No products between selected dates');
                THROW 55000, @msg, 1;
            END
        IF @DateFrom > @DateTo
            BEGIN
                DECLARE @msg1 NVARCHAR(2048) = FORMATMESSAGE('Date To is earlier than Date From');
                THROW 56000, @msg1, 1;
            END
        SELECT
            p.product_id,
            p.product_name,

            SUM(od.quantity) AS total_number,

            DATEPART(YEAR, o.order_date) AS year_no,
            DATEPART(MONTH, o.order_date) AS month_no,
            DATEPART(WEEK, o.order_date) AS week_no

        FROM Products p
        INNER JOIN Order_Details od ON od.product_id = p.product_id
        INNER JOIN Orders o ON o.order_id = od.order_id

        WHERE
            o.order_date BETWEEN @DateFrom AND @DateTo

        GROUP BY
            ROLLUP (
                p.product_id,
                p.product_name,
                DATEPART(YEAR, o.order_date),
                DATEPART(MONTH, o.order_date),
                DATEPART(WEEK, o.order_date)
            )

        ORDER BY
            total_number DESC;
    END TRY
    BEGIN CATCH
        ;THROW;
    END CATCH;
END;
GO
```

15.**TopProductsWeek** - generuje listę najlepiej sprzedawanych produktów w zadanym tygodniu

```sql
        CREATE PROCEDURE TopProductsWeek
        @week_number INT,
        @year INT
    AS
    BEGIN
        BEGIN TRY
            SET NOCOUNT ON;
                IF @week_number > 53
                    BEGIN
                        DECLARE @msg1 NVARCHAR(2048) = FORMATMESSAGE('Week number does not exist');
                        THROW 56000, @msg1, 1;
                    END
            SELECT p.product_id, p.product_name, SUM(od.unit_price * od.quantity) AS val FROM Products p
            INNER JOIN Order_Details od ON od.product_id = p.product_id
            INNER JOIN Orders o ON o.order_id = od.order_id
            WHERE DATEPART(ISO_WEEK, o.order_date) = @week_number
            AND YEAR(o.order_date) = @year
            GROUP BY p.product_id, p.product_name
            ORDER BY val DESC
        END TRY
        BEGIN CATCH
            ;THROW;
        END CATCH;
    END;
```

16. **TopProductsMonth** - generuje listę najlepiej sprzedawanych produktów w miesiącu

```sql
    CREATE PROCEDURE TopProductsMonth
        @month_number INT,
        @year INT
    AS
    BEGIN
        BEGIN TRY
            SET NOCOUNT ON;
                IF @month_number > 12
                    BEGIN
                        DECLARE @msg1 NVARCHAR(2048) = FORMATMESSAGE('Month number does not exist');
                        THROW 56000, @msg1, 1;
                    END
            SELECT p.product_id, p.product_name, SUM(od.unit_price * od.quantity) AS val FROM Products p
            INNER JOIN Order_Details od ON od.product_id = p.product_id
            INNER JOIN Orders o ON o.order_id = od.order_id
            WHERE MONTH(o.order_date) = @month_number
            AND YEAR(o.order_date) = @year
            GROUP BY p.product_id, p.product_name
            ORDER BY val DESC
        END TRY
        BEGIN CATCH
            ;THROW;
        END CATCH;
    END;
```

17. **TopProductsYear** - generuje listę najlepiej sprzedawanych produktów w roku

```sql
    CREATE PROCEDURE TopProductsYear
    @year INT
    AS
    BEGIN
        BEGIN TRY
            SET NOCOUNT ON;
            SELECT p.product_id, p.product_name, SUM(od.unit_price * od.quantity) AS val FROM Products p
            INNER JOIN Order_Details od ON od.product_id = p.product_id
            INNER JOIN Orders o ON o.order_id = od.order_id
            WHERE YEAR(o.order_date) = @year
            GROUP BY p.product_id, p.product_name
            ORDER BY val DESC
        END TRY
        BEGIN CATCH
            ;THROW;
        END CATCH;
    END;
```

18. **EstimateOrderDate** - dla danego zamówienia estymuje datę jego dostarczenia uwzględniając:

- czy produkty nie zostały już wyprodukowane (nie są na magazynie),
- aktualną produkcję (obciążenie na liniach produkcyjnych, to ile zajmie wyprodukowanie każdego produktu),
- dni wolne.

```sql
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
```

19. **ViewOrderItems** - dla każdego zamówienia pokazuje informacje o zamówionych produktach.

```sql
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
```

20. **ViewOrderSummary** - dla każdego zamówienia podsumowuje jego koszt, zniżkę, i cenę po zniżce.

```sql
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
```

## Triggery

1. **OrderStatusChange** - obsługuje zmiany statusu zamówienia, wraz z postępem jego realizacji.

```sql
CREATE TRIGGER dbo.OrderStatusChange
    ON Orders
    AFTER INSERT, UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(order_status)
        BEGIN
            INSERT INTO Order_Status_History (order_id, order_status, status_change_date)
            SELECT inserted.order_id,
                   inserted.order_status,
                   SYSDATETIME()
            FROM inserted;
        END
END;
```

2. **UpdateProductionAndWarehouseWhenNewOrder** - realizuje automatyczną obsługę stanu magazynu i planu produkcji po złożeniu zamówienia. Po dodaniu pozycji do Order_Details zmniejsza stan magazynu produktu. W przypadku braku wystarczającej liczby produktów na magazynie automatycznie tworzy wpis w tabeli Production dla brakującej ilości oraz ustawia stan magazynowy na zero.

```sql
CREATE TRIGGER UpdateProductionAndWarehouseWhenNewOrder
ON Order_Details
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- Jeżeli liczba zamówionych produktów jest mniejsza od liczby produktów na magzynie
    -- to aktualizujemy tabelę Production
    INSERT INTO Production (product_id, quantity, order_id, assembly_line, manufacturing_cost)
    SELECT
        i.product_id,
        i.quantity - p.quantity_in_stock,
        i.order_id,
        pr.assembly_line,
        p.manufacturing_cost * i.quantity
    FROM Products p
    JOIN INSERTED i ON p.product_id = i.product_id
    JOIN Production pr ON p.product_id = pr.product_id
    WHERE i.quantity > p.quantity_in_stock; -- warunek

    -- Aktualizujemy liczbę produktów na magazynie w Products.
    UPDATE p
    SET p.quantity_in_stock
        = IIF((p.quantity_in_stock - i.quantity) < 0, 0, (p.quantity_in_stock - i.quantity))
    FROM Products p
    JOIN INSERTED i ON p.product_id = i.product_id;
END;
GO
```

3. **Update_Parts_Inventory** - aktualizuje liczbę poszczególnych części na podstawie wykonanego zamówienia

```sql
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
```
