---
## Dokumentacja projektu "firma produkcyjno-usługowa"

Dzień i godzina zajęć: pt. 9:45

Nr zespołu: 18

**Autorzy:** Małgorzata Liskowska, Stanisław Ogonowski, Bartłomiej Wiśniewski

---

## 1. Wymagania funkcyjne systemu

Celem projektu jest projekt bazy danych dla firmy usługowo-produkcyjnej.
Klient biznesowy specjalizuje się w produkcji mebli biurowych, w szczególności do pomieszczeń z urządzeniami komputerowymi.

### Persona: klient sklepu

- klient składa zamówienie, znając oczekiwaną datę odbioru. Oczekiwana data reliazacji zamówienia jest obliczona automatycznie na podstawie aktualnych zamówień, stanu magazynu i dostępności części.
- w przypadku braku części potrzebnych do realizacji zamówienia, do oczekiwanej daty zamówienia dodawany jest także czas potrzebny na sprowadzenie części.
- klient może mieć dodatkowe uwagi do zamówienia, takie jak docięcie mebli na wymiar, co zwiększa koszt robocizny.
- klient jest informowany w przypadku, gdy zamówienie jest opóźnione.
- klient może zadeklarować metodę płatności jako karta/gotówka lub płatność przy odbiorze.
- klient może otrzymać rabat jednostkowy na całe zamówienie.
- klientem może być zarówno klient indywidualny jak i zewnętrzna firma.
- klient może przeglądać produkty po kategoriach.

### Założenia

- konkretna część jest dostarczana przez jednego dostawcę.
- sklep nie odpowiada za wysyłkę towarów.
- produkty są składane na poszczególnych liniach produkcyjnych, w zależności od kategorii, do której należą. Na danej linii produkcyjnej mogą być produkowane produkty z wielu kategorii.
- właściwości produktu, takie jak materiał, czy kolor, są wnioskowane po częściach z jakich produkt jest zrobiony.
- zawarta jest informacja o maksymalnych mocach przerobowych firmy na konkretnej linii produkcyjnej.
- na każdej linii produkcyjnej istnieje minimalny poziom produkcji.
- w przypadku braku zamówień mogą to być produkty najczęściej kupowane.

## 2. Baza danych

## Schemat bazy danych

![Schemat bazy danych](schemat_bazy_2.png)

## Opis poszczególnych tabel

### Product

| Kolumna         | Typ         | Klucz  | Opis/Uwagi                                            |
| --------------- | ----------- | ------ | ----------------------------------------------------- |
| product_id      | int         | główny | Identyfikator produktu                                |
| product_name    | varchar(40) |        | Nazwa produktu                                        |
| category_id     | int         | obcy   | Identyfikator kategorii                               |
| production_time | int         |        | Czas potrzebny do produkcji jednej jednostki produktu |
| width           | int         |        | Szerokość produktu (w cm)                             |
| height          | int         |        | Wysokość produktu (w cm)                              |
| depth           | int         |        | Długość produktu (w cm)                               |
| weight          | int         |        | Waga produktu (w kg)                                  |

### ProductPart

| Kolumna    | Typ | Klucz        | Opis/Uwagi                                                                                           |
| ---------- | --- | ------------ | ---------------------------------------------------------------------------------------------------- |
| product_id | int | główny, obcy | Identyfikator produktu                                                                               |
| part_id    | int | główny, obcy | Identyfikator części potrzebnej do produkcji produktu o identyfikatorze product_id                   |
| quantity   | int |              | Liczba części o identyfikatorze part_id potrzebna do produkcji produktu o identyfikatorze product_id |

### Part

| Kolumna        | Typ          | Klucz  | Opis/Uwagi                                              |
| -------------- | ------------ | ------ | ------------------------------------------------------- |
| part_id        | int          | główny | Identyfikator części                                    |
| part_name      | varchar(100) |        | Nazwa części                                            |
| part_cost      | money        |        | Cena jednostkowa części                                 |
| supplier_id    | int          | obcy   | Identyfikator dostawcy                                  |
| units_in_stock | int          |        | Liczba części w magazynie                               |
| units_in_order | int          |        | Liczba części zamówionych (w drodze)                    |
| reorder_level  | int          |        | Liczba units_in_stock przy której należy domówić części |

### Supplier

| Kolumna       | Typ          | Klucz  | Opis/Uwagi                                                                  |
| ------------- | ------------ | ------ | --------------------------------------------------------------------------- |
| supplier_id   | int          | główny | Identyfikator dostawcy                                                      |
| name          | varchar(50)  |        | Nazwa firmy dostarczającej części                                           |
| adress        | varchar(100) |        | Ulica i numer budynku                                                       |
| city          | varchar(100) |        | Miasto siedziby firmy                                                       |
| region        | varchar(100) |        | Województwo/stan/land                                                       |
| postal_code   | varchar (10)      |        | Kod pocztowy                                                                |
| country       | varchar(50)  |        | Kraj                                                                        |
| delivery_time | int          |        | Średni oczekiwany czas dostawy (do oszacowania czasu realizacji zamówienia) |

### Category

| Kolumna       | Typ         | Klucz  | Opis/Uwagi               |
| ------------- | ----------- | ------ | ------------------------ |
| category_id   | int         | główny | Identyfikator kategorii  |
| assembly_line | int         | obcy   | Numer taśmy produkcyjnej |
| category_name | varchar(50) |        | Nazwa kategorii          |

### Production

| Kolumna              | Typ      | Klucz        | Opis/Uwagi                                     |
| -------------------- | -------- | ------------ | ---------------------------------------------- |
| assembly_line        | int      | główny, obcy | Numer taśmy produkcyjnej                       |
| product_id           | int      | główny, obcy | Identyfikator produktu                         |
| quantity             | int      |              | Liczba wyprodukowanego produktu w danej partii |
| production_startdate | datetime |              | Start produkcji                                |
| production_enddate   | datetime |              | Koniec produkcji                               |

### AssemblyLines

| Kolumna        | Typ | Klucz  | Opis/Uwagi                                                      |
| -------------- | --- | ------ | --------------------------------------------------------------- |
| assembly_line  | int | główny | Numer taśmy produkcyjnej                                        |
| min_capability | int |        | Minimalna liczba produktów wytwarzanych na taśmie w ciągu dnia  |
| max_capability | int |        | Maksymalna liczba produktów wytwarzanych na taśmie w ciągu dnia |

### Orders

| Kolumna       | Typ           | Klucz  | Opis/Uwagi                                 |
| ------------- | ------------- | ------ | ------------------------------------------ |
| order_id      | int           | główny | Identyfikator zamówienia                   |
| customer_id   | int           | obcy   | Identyfikator klienta                      |
| order_date    | date          |        | Data złożenia zamówienia                   |
| required_date | date          |        | Zadeklarowana data dostarczenia zamówienia |
| delivery_date | date          |        | Rzeczywista data dostarczenia zamówienia   |
| payment_type  | varchar(50)   |        | Typ płatności                              |
| discount      | decimal(10,2) |        | Zniżka na całe zamówienie                  |
| paid          | bit       |        | Określa, czy klient zapłacił za zamówienie                                        |

### OrderDetails

| Kolumna            | Typ          | Klucz        | Opis/Uwagi                         |
| ------------------ | ------------ | ------------ | ---------------------------------- |
| order_id           | int          | główny, obcy | Identyfikator zamówienia           |
| product_id         | int          | główny, obcy | Identyfikator produktu             |
| manufactoring_cost | money        |              | Koszt wyprodukowania jednej sztuki |
| unit_price         | money        |              | Cena za sztukę                     |
| quantity           | int          |              | Liczba zamówionych sztuk           |
| extra_remarks      | varchar(200) |              | Uwagi dodatkowe                    |


### Customers

| Kolumna       | Typ          | Klucz  | Opis/Uwagi                                           |
| ------------- | ------------ | ------ | ---------------------------------------------------- |
| customer_id   | int          | główny | Identyfikator klienta                                |
| adress        | varchar (100)    |        | Ulica i numer budynku                                |
| city          | varchar(100) |        | Miasto siedziby klienta/ Miasto zamieszkania klienta |
| region        | varchar(100) |        | Województwo/stan/land                                |
| country       | varchar(50)  |        | Kraj                                                 |
| postal_code   | varchar(10)       |        | Kod pocztowy                                         |
| contact_email | varchar(100) |        | Email                                                |
| phone         | varchar (12)       |        | Numer telefonu                                       |


### IndividualCustomer

| Kolumna           | Typ         | Klucz        | Opis/Uwagi            |
| ----------------- | ----------- | ------------ | --------------------- |
| customer_id       | int         | główny, obcy | Identyfikator klienta |
| name              | varchar(50) |              | Imię klienta          |
| surname           | varchar(50) |              | Nazwisko klienta      |
| title_of_courtesy | varchar(20) |              | Pan/Pani              |

### CompanyCustomer

| Kolumna                | Typ          | Klucz        | Opis/Uwagi                 |
| ---------------------- | ------------ | ------------ | -------------------------- |
| customer_id            | int          | główny, obcy | Identyfikator klienta      |
| company_name           | varchar(50)  |              | Nazwa firmy                |
| contact_person_name    | varchar(100) |              | Imię osoby kontaktowej     |
| contact_person_surname | varchar(100) |              | Nazwisko osoby kontaktowej |
| nip_number             | int          |              | Numer NIP firmy            |

### Warehouse

| Kolumna           | Typ | Klucz        | Opis/Uwagi                                                                           |
| ----------------- | --- | ------------ | ------------------------------------------------------------------------------------ |
| product_id        | int | główny, obcy | Identyfikator produktu                                                               |
| quantity_on_stock | int |              | Liczba sztuk na magazynie                                                            |
| sector            | int |              | Sektor w magazynie, przy którym znajduje się produkt                                 |
| production_level  | int |              | Liczba sztuk produktu do której dąży się w przypadku mniejszych obrotów na produkcji |

(Dla każdej tabeli kod DDL wraz z zaimplementowanymi war. integralności, + ewentualnie opis, np. w formie tabelki)

- kod DDL

```sql
CREATE TABLE Product (
   ProductId int  NOT NULL,
   ProductName varchar(40)  NOT NULL,
   CategoryID int  NOT NULL,
   ProductionTime int  NOT NULL,
   CONSTRAINT ProductId PRIMARY KEY  (ProductId)
);
```

- Opis: (opis tabeli, komentarz)
- np.

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| Atrybut 1 …    |     |            |
| Atrybut 2 …    |     |            |

# 3. Widoki, procedury/funkcje, triggery

## Widoki

(dla każdego widoku należy wkleić kod polecenia definiującego widok wraz z komentarzem)

```sql
crete or alter view vw_abc
as
select a from tab1
```

## Procedury/funkcje

(dla każdej procedury/funkcji należy wkleić kod polecenia definiującego procedurę wraz z komentarzem)

```sql
-- ...
```

## Triggery

(dla każdego triggera należy wkleić kod polecenia definiującego trigger wraz z komentarzem)

```sql
-- ...
```

# 4. Inne

(informacja o sposobie wygenerowania danych, uprawnienia …)
