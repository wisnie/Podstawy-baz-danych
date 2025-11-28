

---
# Podstawy baz danych


dzień i godz zajęć: (np. wt 13:15) 

nr zespołu: (np. 1)

**Autorzy:** (Imiona i nazwiska autorów)

ew. link do repozytorium git: ...


--- 

# 1.	Wymagania i funkcje systemu

(np. lista wymagań, doprecyzowanie wymagań, ,np. historyjki użytkownika, np. przypadki użycia itp.,)

# 2.	Baza danych

## Schemat bazy danych

(diagram (rysunek) przedstawiający schemat bazy danych) 

## Opis poszczególnych tabel

(Dla każdej tabeli  kod DDL wraz z zaimplementowanymi war. integralności, + ewentualnie opis, np. w formie tabelki)


- kod DDL 

```sql
create table tab1 (
   a int,
   b varchar(10)
)
```

- Opis: (opis tabeli, komentarz)
- np.

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| Atrybut 1 …    |     |            |
| Atrybut 2 …    |     |            |

# 3.  Widoki, procedury/funkcje, triggery 


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
