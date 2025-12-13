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
- klient może modyfikować swoje zamówienie, jednak może to powodować opóźnienie w planie produkcji.
- w przypadku rezygnacji z zamówienia klient może ponieść dodatkową opłatę.
- klient jest informowany w przypadku, gdy zamówienie jest opóźnione i może zrezygnować ze swojego zamówienia; wówczas nie ponosi dodatkowej opłaty za zamówienie.
- klient może zadeklarować metodę płatności jako karta/gotówka lub płatność przy odbiorze, a także regulować płatność na różne sposoby (np. zaliczka, lub w wielu ratach).
- klient może otrzymać rabat procentowy na całe zamówienie.
- klientem może być zarówno klient indywidualny jak i zewnętrzna firma.
- klient może przeglądać produkty po kategoriach.

### Założenia

- konkretna część jest dostarczana przez jednego dostawcę.
- sklep nie odpowiada za wysyłkę towarów.
- produkty są składane na poszczególnych zespołach linii produkcyjnych, w zależności od kategorii, do której należą. Na danym zespole linii produkcyjnych mogą być produkowane produkty z wielu kategorii.
- zawarta jest informacja o maksymalnych mocach przerobowych firmy na konkretnym zestawie linii produkcyjnych.
- na każdym zestawie linii produkcyjnych istnieje minimalny poziom produkcji.
- na podstawie aktualnych zamówień ustalana jest kolejka, na podstawie której produkowane są poszczególne produkty.
- w przypadku braku zamówień sklep dąży do określonego poziomu danego produktu na magazynie.
- klient może modyfikować swoje zamówienie:
  - w przypadku zmniejszenia wielkości zamówienia, wyprodukowana nadwyżka trafia na magazyn (Jeśli produkcja nie została rozpoczęta, jej plan jest odpowiednio modyfikowany).
  - w przypadku zwiększenia wielkości zamówienia:
    - Jeśli aktualna produkcja zwiększa się przed/w trakcie zamówienia, modyfikuje się plan produkcji dla danego produktu.
    - Jeśli aktualna produkcja zwiększa się po wyprodukowaniu zamówienia, tworzy się nowy plan produkcji dla dodatkowo zamówionej partii produktu.

## 2. Baza danych

## Schemat bazy danych

![Schemat bazy danych](schemat_bazy_2.png)

## Opis poszczególnych tabel

### Products

| Kolumna         | Typ         | Klucz  | Opis/Uwagi                                            |
| --------------- | ----------- | ------ | ----------------------------------------------------- |
| product_id      | int         | główny | Identyfikator produktu                                |
| product_name    | nvarchar(100) |        | Nazwa produktu                                        |
| manufactoring_cost      | money         |    | Koszt wyprodukowania jednej sztuki  
| category_id     | int         | obcy   | Identyfikator kategorii                               |
| production_time_unit | int         |        | Jednostka określająca całkowitą liczbę jednostek czasu, w której produkowany jest dany produkt. 10 jednostek to jedna roboczogodzina na taśmie produkcyjnej. |
| quantity_on_stock | int |              | Liczba sztuk na magazynie                                                            |
| warehousse_sector            | int |              | Sektor w magazynie, przy którym znajduje się produkt                                 |
| production_level  | int |              | Liczba sztuk produktu do której dąży się w przypadku mniejszych obrotów na produkcji |

### ProductParts

| Kolumna    | Typ | Klucz        | Opis/Uwagi                                                                                           |
| ---------- | --- | ------------ | ---------------------------------------------------------------------------------------------------- |
| product_id | int | główny, obcy | Identyfikator produktu                                                                               |
| part_id    | int | główny, obcy | Identyfikator części potrzebnej do produkcji produktu o identyfikatorze product_id                   |
| quantity   | int |              | Liczba części o identyfikatorze part_id potrzebna do produkcji produktu o identyfikatorze product_id |

### Parts

| Kolumna        | Typ          | Klucz  | Opis/Uwagi                                              |
| -------------- | ------------ | ------ | ------------------------------------------------------- |
| part_id        | int          | główny | Identyfikator części                                    |
| part_name      | nvarchar(100) |        | Nazwa części                                            |
| part_cost      | money        |        | Cena jednostkowa części                                 |
| supplier_id    | int          | obcy   | Identyfikator dostawcy                                  |
| units_in_stock | int          |        | Liczba części w magazynie                               |
| units_on_order | int          |        | Liczba części zamówionych (w drodze)                    |
| reorder_level  | int          |        | Liczba units_in_stock przy której należy domówić części |

### Suppliers

| Kolumna       | Typ          | Klucz  | Opis/Uwagi                                                                  |
| ------------- | ------------ | ------ | --------------------------------------------------------------------------- |
| supplier_id   | int          | główny | Identyfikator dostawcy                                                      |
| name          | nvarchar(50)  |        | Nazwa firmy dostarczającej części                                           |
| adress        | nvarchar(100) |        | Ulica i numer budynku                                                       |
| city          | nvarchar(30) |        | Miasto siedziby firmy                                                       |
| region        | nvarchar(50) |        | Województwo/stan/land                                                       |
| postal_code   | nvarchar (10)      |        | Kod pocztowy                                                                |
| country       | nvarchar(30)  |        | Kraj                                                                        |
| contact_email | nvarchar(100) |        | Adres email                                                |
| phone         | nvarchar (15)       |        | Numer telefonu                                       |
| delivery_time | int          |        | Średni oczekiwany czas dostawy (do oszacowania czasu realizacji zamówienia) |

### Categories

| Kolumna       | Typ         | Klucz  | Opis/Uwagi               |
| ------------- | ----------- | ------ | ------------------------ |
| category_id   | int         | główny | Identyfikator kategorii  |
| category_name | nvarchar(50)|        | Nazwa kategorii          |
| assembly_line | int         | obcy   | Numer zespołu linii produkcyjnych |

### AssemblyLines

| Kolumna        | Typ | Klucz  | Opis/Uwagi                                                      |
| -------------- | --- | ------ | --------------------------------------------------------------- |
| assembly_line  | int | główny | Numer taśmy produkcyjnej                                        |
| min_capability | int |        | Minimalna liczba produktów wytwarzanych na taśmie w ciągu dnia  |
| max_capability | int |        | Maksymalna liczba produktów wytwarzanych na taśmie w ciągu dnia |

### Production

| Kolumna              | Typ      | Klucz        | Opis/Uwagi                                     |
| -------------------- | -------- | ------------ | ---------------------------------------------- |
| production_id           | int      | główny | Identyfikator produkcji  
| product_id           | int      | główny, obcy | Identyfikator produktu                         |
| assembly_line        | int      | główny, obcy | Numer taśmy produkcyjnej                       |                       |
| manufactoring_cost      | money         |    | Koszt wyprodukowania jednej sztuki  
| quantity             | int      |              | Liczba wyprodukowanego produktu w danej partii |
| production_startdate | datetime |              | Data rozpoczęcia produkcji                                |
| production_enddate   | datetime |              | Data zakończenia produkcji                               |

### Orders

| Kolumna       | Typ           | Klucz  | Opis/Uwagi                                 |
| ------------- | ------------- | ------ | ------------------------------------------ |
| order_id      | int           | główny | Identyfikator zamówienia                   |
| customer_id   | int           | obcy   | Identyfikator klienta                      |
| order_date    | date          |        | Data złożenia zamówienia                   |
| required_date | date          |        | Zadeklarowana data dostarczenia zamówienia |
| delivery_date | date          |        | Rzeczywista data dostarczenia zamówienia   |
| discount      | decimal(5,4) |        | Zniżka na całe zamówienie                  ||

### OrderDetails

| Kolumna            | Typ          | Klucz        | Opis/Uwagi                         |
| ------------------ | ------------ | ------------ | ---------------------------------- |
| order_id           | int          | główny, obcy | Identyfikator zamówienia           |
| product_id         | int          | główny, obcy | Identyfikator produktu             |
| quantity           | int          |              | Liczba zamówionych sztuk           |
| unit_price         | money        |              | Cena za sztukę     |                |
| extra_remarks      | nvarchar(200) |              | Uwagi dodatkowe                    |

### Payments

| Kolumna           | Typ         | Klucz        | Opis/Uwagi            |
| ----------------- | ----------- | ------------ | --------------------- |
| order_id       | int         | główny, obcy | Identyfikator zamówienia |
| paid_amount              | money |              | Zapłacona kwota          |
| payment_type           | nvarchar(20) |              | Typ płatności (np. karta przy odbiorze, BLIK, przelew)      |
| payment_date | datetime |              | Data zaksięgowania przelewu              |


### Cancelled_Orders

| Kolumna           | Typ         | Klucz        | Opis/Uwagi            |
| ----------------- | ----------- | ------------ | --------------------- |
| order_id       | int         | główny, obcy | Identyfikator zamówienia |
| cancel_date              | datetime |              | Data anulowania zamówienia          |
| reason           | nvarchar(500) |              | Powód anulowania zamówienia      |
| compensation | money |              | Wartość dodatkowej opłaty za anulowane zamówienie              |

### Customers

| Kolumna       | Typ          | Klucz  | Opis/Uwagi                                           |
| ------------- | -------------- | ------ | ---------------------------------------------------- |
| customer_id   | int          | główny | Identyfikator klienta                                |
| address        | nvarchar (100)    |        | Ulica i numer budynku                                |
| city          | nvarchar(30) |        | Miasto siedziby klienta/ Miasto zamieszkania klienta |
| region        | nvarchar(50) |        | Województwo/stan/land                                |
| country       | nvarchar(50)  |        | Kraj                                                 |
| postal_code   | nvarchar(10)       |        | Kod pocztowy                                         |
| contact_email | nvarchar(100) |        | Email                                                |
| phone         | nvarchar (15)       |        | Numer telefonu                                       |


### IndividualCustomer

| Kolumna           | Typ         | Klucz        | Opis/Uwagi            |
| ----------------- | ----------- | ------------ | --------------------- |
| customer_id       | int         | główny, obcy | Identyfikator klienta |
| name              | nvarchar(100) |              | Imię klienta          |
| surname           | nvarchar(100) |              | Nazwisko klienta      |
| title_of_courtesy | nvarchar(10) |              | Pan/Pani              |

### CompanyCustomer

| Kolumna                | Typ          | Klucz        | Opis/Uwagi                 |
| ---------------------- | ------------ | ------------ | -------------------------- |
| customer_id            | int          | główny, obcy | Identyfikator klienta      |
| company_name           | nvarchar(100)  |              | Nazwa firmy                |
| contact_person_name    | nvarchar(100) |              | Imię osoby kontaktowej     |
| contact_person_surname | nvarchar(100) |              | Nazwisko osoby kontaktowej |
| nip_number             | nvarchar (10)          |              | Numer NIP firmy            |

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
