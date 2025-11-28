## Raport mniejszości

dzień i godzina

**Autorzy**: ...

Repozytorim git [hiperłącze](https://www.markdownguide.org/extended-syntax/)


## 1. Wymagania funkcyjne

Schemat bazy danych

![Schemat](stoat.jpg)

Lista 

- raz
- dwa
- trzy

lista numerowana

1. raz
2. dwa

tabelka

| imie | nazwisko |
| ----- | ----------- |
| marco | polo|
| marco | polo|
| marco | polo|

```sql
SELECT firstname,
       lastname,
       birth_date,
       CONCAT_WS(', ', state, city, street, zip) AS address
FROM juvenile
         INNER JOIN member
                    ON juvenile.member_no = member.member_no
         INNER JOIN adult
                    ON juvenile.adult_member_no = adult.member_no;

```