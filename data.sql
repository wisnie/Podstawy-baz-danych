INSERT INTO Suppliers (name, address, city, region, postal_code, country, contact_email, phone, delivery_days)
VALUES
('Drew-Hurt Wielkopolska', 'ul. Tartaczna 15', 'Oborniki', 'Wielkopolskie', '64-600', 'Polska', 'biuro@drewhurt.pl', '+48 61 296 00', 3),
('Shenzhen TechComponents', 'High-Tech Park, District 4', 'Shenzhen', 'Guangdong', '518000', 'Chiny', 'sales@sz-tech.cn', '+86 755 1234', 45),
('SteelForge GmbH', 'Industriestrasse 44', 'Duisburg', 'NRW', '47051', 'Niemcy', 'orders@steelforge.de', '+49 203 9988', 7),

-- 4. Dostawca tkanin obiciowych i skór do foteli (Designerskie)
('Tessuti di Milano', 'Via della Moda 12', 'Mediolan', 'Lombardia', '20121', 'Włochy', 'info@tessuti.it', '+39 02 12345', 10),

-- 5. Dostawca oświetlenia LED i sterowników (Gaming)
('RGB Lighting Solutions', 'Gangnam-gu Teheran-ro', 'Seul', 'Seoul Area', '06236', 'Korea Płd.', 'export@rgblights.kr', '+82 2 555 00', 21),

-- 6. Dostawca elementów plastikowych: kółka, podłokietniki
('Plast-System Sp. j.', 'ul. Chemików 7', 'Tarnów', 'Małopolskie', '33-100', 'Polska', 'zamowienia@plast-sys.pl', '+48 14 688 99', 5),

-- 7. Dostawca drewna premium (Dąb, Jesion) na droższe biurka
('Nordic Wood Supply AB', 'Skogsvägen 88', 'Umeå', 'Västerbotten', '90187', 'Szwecja', 'hello@nordicwood.se', '+46 90 11223', 14),

-- 8. Dostawca śrub, wkrętów i złączy
('Fasteners & Fixings Ltd', 'Industrial Estate Unit 5', 'Birmingham', 'West Mids', 'B2 4QA', 'Wlk. Brytania', 'support@fasteners.uk', '+44 121 5556', 8),

-- 9. Dostawca zaawansowanych mechanizmów podnoszenia (Gas lifts)
('ErgoLift Mechanisms', '100 Innovation Dr', 'Chicago', 'Illinois', '60601', 'USA', 'sales@ergolift.com', '+1 312 555 0', 30),

-- 10. Dostawca opakowań kartonowych i folii
('Eko-Pak Opakowania', 'ul. Magazynowa 2', 'Pruszków', 'Mazowieckie', '05-800', 'Polska', 'logistyka@ekopak.pl', '+48 22 700 80', 2);

INSERT INTO Assembly_Lines (min_capability, max_capability) VALUES
(30, 150), -- ID 1: Stolarnia Lekka (Biurka standard, szafki)
(10, 60),  -- ID 2: Tapicernia (Fotele biurowe, gamingowe, sofy)
(1, 15),   -- ID 3: Elektronika i Precyzja (Tablice interaktywne, biurka elektryczne)
(2, 10),   -- ID 4: Stolarnia Ciężka (Duże stoły konferencyjne)
(50, 300); -- ID 5: Drobne elementy metalowe (Stojaki, uchwyty)

INSERT INTO Categories (category_name, assembly_line) VALUES
-- Przypisane do Linii 1 (Stolarnia Lekka)
('Biurka Biurowe Standard', 1),
('Szafy i Kontenery', 1),
('Stoły Jadalniane', 1),

-- Przypisane do Linii 2 (Tapicernia)
('Fotele Ergonomiczne', 2),
('Fotele Gamingowe', 2),
('Sofy Poczekalniowe', 2),

-- Przypisane do Linii 3 (Elektronika)
('Biurka Gamingowe LED', 3), -- Wymagają montażu oświetlenia
('Tablice Interaktywne', 3), -- Wymagają montażu matryc

-- Przypisane do Linii 4 (Stolarnia Ciężka)
('Stoły Konferencyjne', 4),

-- Przypisane do Linii 5 (Drobne elementy)
('Ruchome Stojaki na Projektory', 5);

INSERT INTO Products (product_name, manufacturing_cost, unit_price, category_id, production_time_unit, quantity_on_stock, warehouse_sector, production_level)
VALUES
-- KATEGORIA 1: Biurka Biurowe (Linia 1 - Stolarnia)
('Biurko Basic 120x60', 150.00, 399.00, 1, 15, 50, 1, 10),     -- 1.5h pracy (tanie, szybkie)
('Biurko Narożne Manager', 320.00, 850.00, 1, 35, 15, 1, 5),   -- 3.5h pracy
('Biurko Open Space 4-stanowiskowe', 800.00, 2200.00, 1, 60, 5, 2, 2), -- 6h pracy

-- KATEGORIA 2: Szafy i Kontenery (Linia 1 - Stolarnia)
('Kontenerek Mobilny 3S', 90.00, 249.00, 2, 20, 100, 1, 20),
('Szafa Aktowa Wysoka', 250.00, 699.00, 2, 40, 20, 2, 5),

-- KATEGORIA 3: Stoły Jadalniane (Linia 1 - Stolarnia)
('Stół Socjalny Okrągły', 180.00, 450.00, 3, 25, 10, 2, 5),

-- KATEGORIA 4: Fotele Ergonomiczne (Linia 2 - Tapicernia)
('Fotel Ergo-Office Mesh', 220.00, 599.00, 4, 30, 40, 3, 10),  -- 3h pracy
('Fotel Prezesa Skóra Naturalna', 650.00, 1899.00, 4, 60, 5, 3, 2), -- 6h pracy (dużo szycia)
('Krzesło Konferencyjne ISO', 45.00, 129.00, 4, 10, 200, 3, 50), -- 1h pracy (proste)

-- KATEGORIA 5: Fotele Gamingowe (Linia 2 - Tapicernia)
('Fotel Gamingowy RedDragon', 350.00, 899.00, 5, 45, 30, 3, 10), -- 4.5h pracy (skomplikowane wzory)
('Fotel Gamingowy BluePhantom', 350.00, 899.00, 5, 45, 25, 3, 10),
('Tron Streamera RGB (Fotel)', 550.00, 1499.00, 5, 70, 8, 3, 3), -- 7h pracy (montaż ledów w tapicerce)

-- KATEGORIA 6: Sofy Poczekalniowe (Linia 2 - Tapicernia)
('Sofa Lobby 2-osobowa', 500.00, 1200.00, 6, 80, 4, 4, 2), -- 8h pracy

-- KATEGORIA 7: Biurka Gamingowe LED (Linia 3 - Elektronika)
('Biurko CyberDesk Pro (Elektryczne)', 900.00, 2100.00, 7, 50, 10, 5, 5), -- 5h pracy (montaż silników)
('Biurko LED RGB Entry', 400.00, 999.00, 7, 30, 25, 5, 10),

-- KATEGORIA 8: Tablice Interaktywne (Linia 3 - Elektronika)
('SmartBoard Edu 65 cali', 1800.00, 4500.00, 8, 120, 5, 6, 2), -- 12h pracy (precyzyjna robota)
('SmartBoard Biznes 85 cali 4K', 3500.00, 9900.00, 8, 160, 2, 6, 1), -- 16h pracy

-- KATEGORIA 9: Stoły Konferencyjne (Linia 4 - Stolarnia Ciężka)
('Stół Konferencyjny Dąb 3m', 1200.00, 3500.00, 9, 100, 3, 4, 1), -- 10h pracy (duży gabaryt)
('Stół Modułowy "V"', 800.00, 2100.00, 9, 80, 4, 4, 2),

-- KATEGORIA 10: Stojaki (Linia 5 - Drobne elementy)
('Wózek pod Projektor', 60.00, 189.00, 10, 15, 30, 1, 10),
('Uchwyt PC podblatowy', 15.00, 49.00, 10, 5, 100, 1, 20); -- 0.5h pracy


INSERT INTO Parts (part_name, part_cost, supplier_id, units_in_stock, units_on_order, reorder_level)
VALUES
-- DREWNO I PŁYTY (Supplier 1: Drew-Hurt, 7: Nordic Wood)
('Blat Melamina 120x60 (Basic)', 40.00, 1, 100, 50, 20),         -- ID 1
('Blat Narożny (Manager)', 120.00, 1, 30, 0, 10),                -- ID 2
('Blat Lity Dąb 3m (Konferencyjny)', 800.00, 7, 5, 2, 2),        -- ID 3
('Płyta Meblowa Boczna (Szafy)', 30.00, 1, 200, 0, 50),          -- ID 4

-- METAL I STELAŻE (Supplier 3: SteelForge, 8: Fasteners)
('Stelaż Metalowy Podstawowy', 60.00, 3, 50, 20, 10),            -- ID 5
('Nogi do stołu Konferencyjnego (kpl)', 200.00, 3, 10, 0, 2),   -- ID 6
('Śruby Montażowe M6 (Paczka 100szt)', 5.00, 8, 1000, 200, 100), -- ID 7
('Uchwyt Meblowy Chrom', 8.00, 8, 300, 0, 50),                   -- ID 8

-- ELEMENTY FOTELI (Supplier 6: Plast-System, 9: ErgoLift)
('Kółka Kauczukowe (kpl 5szt)', 15.00, 6, 200, 50, 30),          -- ID 9
('Podstawa "Gwiazda" Nylonowa', 25.00, 6, 100, 20, 20),          -- ID 10
('Siłownik Gazowy Klasa 4', 35.00, 9, 80, 40, 15),               -- ID 11
('Mechanizm Tilt (Bujanie)', 45.00, 3, 60, 0, 10),               -- ID 12
('Podłokietnik Regulowany 3D (szt)', 20.00, 6, 150, 0, 40),      -- ID 13

-- TAPICERKA (Supplier 4: Tessuti)
('Formatka Piankowa (Siedzisko)', 15.00, 6, 100, 20, 20),        -- ID 14
('Tkanina Mesh Oddychająca (mb)', 20.00, 4, 300, 0, 50),         -- ID 15
('Ekoskóra Premium (mb)', 35.00, 4, 200, 50, 40),                -- ID 16
('Skóra Naturalna Włoska (m2)', 150.00, 4, 40, 10, 5),           -- ID 17

-- ELEKTRONIKA (Supplier 2: Shenzhen, 5: RGB Lighting)
('Zestaw LED RGB + Pilot', 45.00, 5, 80, 20, 20),                -- ID 18
('Silnik Elektryczny (Biurka)', 150.00, 2, 40, 20, 10),          -- ID 19
('Panel Sterujący (Góra/Dół)', 30.00, 2, 50, 10, 10),            -- ID 20
('Matryca Dotykowa 65 cali', 1200.00, 2, 8, 5, 3),               -- ID 21
('Matryca 4K 85 cali', 2500.00, 2, 4, 2, 1),                     -- ID 22
('Komputer OPS (Moduł PC)', 400.00, 2, 15, 5, 5),                -- ID 23

-- PAKOWANIE (Supplier 10: Eko-Pak)
('Karton Płaski (Biurka)', 5.00, 10, 500, 100, 50),              -- ID 24
('Karton Sześcienny (Fotele)', 6.00, 10, 400, 0, 50),            -- ID 25
('Folia Bąbelkowa i Zabezpieczenia', 2.00, 10, 1000, 200, 100);  -- ID 26


INSERT INTO Product_Parts (product_id, part_id, quantity)
VALUES
-- 1. Biurko Basic 120x60
(1, 1, 1),   -- 1x Blat
(1, 5, 1),   -- 1x Stelaż
(1, 7, 1),   -- 1x Śruby
(1, 24, 1),  -- 1x Karton

-- 2. Biurko Narożne Manager
(2, 2, 1),   -- 1x Blat Narożny
(2, 5, 2),   -- 2x Stelaż (wzmocniony)
(2, 7, 2),   -- 2x Śruby
(2, 24, 1),  -- 1x Karton

-- 3. Biurko Open Space 4-stanowiskowe
(3, 1, 4),   -- 4x Blat Basic
(3, 5, 4),   -- 4x Stelaż
(3, 7, 4),   -- 4x Śruby
(3, 24, 2),  -- 2x Karton (duża paczka)

-- 4. Kontenerek Mobilny 3S
(4, 4, 3),   -- 3x Płyta meblowa
(4, 9, 1),   -- 1x Kółka (komplet)
(4, 8, 3),   -- 3x Uchwyt
(4, 25, 1),  -- 1x Karton

-- 5. Szafa Aktowa Wysoka
(5, 4, 5),   -- 5x Płyta meblowa
(5, 8, 2),   -- 2x Uchwyt
(5, 7, 1),   -- 1x Śruby
(5, 24, 1),  -- 1x Karton

-- 6. Stół Socjalny Okrągły
(6, 1, 1),   -- 1x Blat (docinany)
(6, 6, 1),   -- 1x Noga centralna
(6, 7, 1),   -- 1x Śruby

-- 7. Fotel Ergo-Office Mesh
(7, 9, 1),   -- 1x Kółka
(7, 10, 1),  -- 1x Podstawa
(7, 11, 1),  -- 1x Siłownik
(7, 12, 1),  -- 1x Mechanizm Tilt
(7, 14, 1),  -- 1x Pianka
(7, 15, 2),  -- 2mb Tkaniny Mesh
(7, 13, 2),  -- 2x Podłokietnik
(7, 25, 1),  -- 1x Karton

-- 8. Fotel Prezesa Skóra Naturalna
(8, 10, 1),  -- Podstawa
(8, 11, 1),  -- Siłownik
(8, 12, 1),  -- Mechanizm
(8, 14, 2),  -- Pianka (dużo)
(8, 17, 3),  -- 3m2 Skóry naturalnej
(8, 13, 2),  -- Podłokietniki
(8, 25, 1),  -- Karton

-- 9. Krzesło Konferencyjne ISO
(9, 5, 1),   -- Stelaż prosty
(9, 14, 1),  -- Pianka
(9, 15, 1),  -- Tkanina
(9, 7, 1),   -- Śruby

-- 10. Fotel Gamingowy RedDragon
(10, 9, 1),  -- Kółka
(10, 10, 1), -- Podstawa
(10, 11, 1), -- Siłownik
(10, 12, 1), -- Mechanizm
(10, 14, 2), -- Pianka
(10, 16, 3), -- Ekoskóra
(10, 13, 2), -- Podłokietniki
(10, 25, 1), -- Karton

-- 11. Fotel Gamingowy BluePhantom
(11, 9, 1),  -- Kółka
(11, 10, 1), -- Podstawa
(11, 11, 1), -- Siłownik
(11, 16, 3), -- Ekoskóra
(11, 14, 2), -- Pianka
(11, 25, 1), -- Karton

-- 12. Tron Streamera RGB
(12, 10, 1), -- Podstawa
(12, 16, 4), -- Dużo ekoskóry
(12, 18, 2), -- 2 zestawy LED
(12, 20, 1), -- Sterowanie LED
(12, 14, 3), -- Gruby fotel
(12, 25, 1), -- Karton

-- 13. Sofa Lobby 2-osobowa
(13, 4, 2),  -- Płyta
(13, 14, 4), -- Pianka
(13, 16, 5), -- Ekoskóra
(13, 6, 1),  -- Nóżki stałe

-- 14. Biurko CyberDesk Pro (Elektryczne)
(14, 1, 1),  -- Blat
(14, 5, 1),  -- Stelaż
(14, 19, 2), -- 2x Silnik
(14, 20, 1), -- Panel
(14, 18, 1), -- LED RGB
(14, 7, 2),  -- Śruby
(14, 24, 1), -- Karton

-- 15. Biurko LED RGB Entry
(15, 1, 1),  -- Blat
(15, 5, 1),  -- Stelaż
(15, 18, 1), -- Pasek LED
(15, 7, 1),  -- Śruby
(15, 24, 1), -- Karton

-- 16. SmartBoard Edu 65 cali
(16, 21, 1), -- Matryca 65
(16, 23, 1), -- Komputer OPS
(16, 26, 5), -- Folia bąbelkowa
(16, 24, 1), -- Karton
(16, 7, 1),  -- Śruby

-- 17. SmartBoard Biznes 85 cali 4K
(17, 22, 1), -- Matryca 85 4K
(17, 23, 1), -- Komputer OPS
(17, 5, 1),  -- Wzmocnienia metalowe
(17, 26, 8), -- Dużo folii

-- 18. Stół Konferencyjny Dąb 3m
(18, 3, 1),  -- Blat Dębowy
(18, 6, 1),  -- Nogi masywne
(18, 7, 2),  -- Śruby
(18, 26, 10),-- Zabezpieczenia

-- 19. Stół Modułowy "V"
(19, 4, 4),  -- Płyty meblowe
(19, 6, 2),  -- Nogi
(19, 7, 2),  -- Śruby

-- 20. Wózek pod Projektor
(20, 5, 1),  -- Stelaż
(20, 9, 1),  -- Kółka
(20, 4, 1),  -- Półka

-- 21. Uchwyt PC podblatowy
(21, 5, 1),  -- Metal
(21, 7, 1);  -- Śruby

INSERT INTO Customers (address, city, region, country, postal_code, contact_email, phone)
VALUES
-- INDYWIDUALNI (IDs 1-10)
('ul. Mokotowska 51/4', 'Warszawa', 'Mazowieckie', 'Polska', '00-543', 'arch.j.bielski@studio-design.pl', '+48 601 999 888'),
('Friedrichstraße 120', 'Berlin', 'Berlin', 'Niemcy', '10117', 'hans.mueller@web.de', '+49 170 123456'),
('10 Downing Street', 'Londyn', 'Greater London', 'Wlk. Brytania', 'SW1A 2AA', 'james.sterling@consultant.uk', '+44 20 7925 00'),
('Avenue des Champs-Élysées 25', 'Paryż', 'Île-de-France', 'Francja', '75008', 'marie.dubois@art-gallery.fr', '+33 6 12 34 56'),
('Václavské náměstí 1', 'Praga', 'Prague', 'Czechy', '110 00', 'pavel.novak@seznam.cz', '+420 602 111 22'),
('5th Avenue 725', 'Nowy Jork', 'New York', 'USA', '10022', 'michael.ross@law-firm.com', '+1 212 555 123'),
('ul. PiotrÅkowska 89', 'Łódź', 'Łódzkie', 'Polska', '90-423', 'kasia.streamer@twitch.tv', '+48 720 333 444'),
('Via Montenapoleone 8', 'Mediolan', 'Lombardia', 'Włochy', '20121', 'giovanni.rossi@fashion.it', '+39 02 777 888'),
('Kungsgatan 4', 'Sztokholm', 'Stockholm', 'Szwecja', '111 43', 'elias.andersen@nordic.se', '+46 8 555 111'),
('Plac Solny 14', 'Wrocław', 'Dolnośląskie', 'Polska', '50-062', 'dr.krzysztof.mocny@politechnika.pl', '+48 71 320 000'),

-- FIRMY (IDs 11-20)
('Silicon Allee 1', 'Berlin', 'Berlin', 'Niemcy', '10115', 'procurement@tech-unicorn.de', '+49 30 555 666'),
('ul. Cybernetyki 2', 'Warszawa', 'Mazowieckie', 'Polska', '02-677', 'biuro@cd-projekt-red.pl', '+48 22 555 000'),
('Canary Wharf, Level 30', 'Londyn', 'Greater London', 'Wlk. Brytania', 'E14 5AB', 'orders@global-banking.co.uk', '+44 20 7111 22'),
('La Défense 4', 'Paryż', 'Île-de-France', 'Francja', '92800', 'achat@le-grand-corp.fr', '+33 1 47 77 88'),
('Aleja Grunwaldzka 472', 'Gdańsk', 'Pomorskie', 'Polska', '80-309', 'office@olivia-business.pl', '+48 58 333 221'),
('1 Infinite Loop', 'Cupertino', 'California', 'USA', '95014', 'facilities@tech-giant.com', '+1 408 996 101'),
('Rynek Główny 1', 'Kraków', 'Małopolskie', 'Polska', '30-001', 'rektorat@uj.edu.pl', '+48 12 663 111'),
('Potsdamer Platz 3', 'Berlin', 'Berlin', 'Niemcy', '10785', 'kontakt@esport-berlin.de', '+49 30 999 888'),
('ul. Wiejska 4/6/8', 'Warszawa', 'Mazowieckie', 'Polska', '00-902', 'kancelaria@sejm.gov.pl', '+48 22 694 200'),
('Masarykovo nábřeží 2', 'Praga', 'Prague', 'Czechy', '110 00', 'info@coworking-prague.cz', '+420 222 333 44');


INSERT INTO Individual_Customers (customer_id, name, surname, title_of_courtesy)
VALUES
(1, 'Janusz', 'Bielski', 'Arch.'),  -- Architekt wnętrz
(2, 'Hans', 'Müller', 'Mr.'),       -- Niemiecki programista
(3, 'James', 'Sterling', 'Sir'),    -- Konsultant z Londynu
(4, 'Marie', 'Dubois', 'Mme'),      -- Właścicielka galerii
(5, 'Pavel', 'Novák', 'Pan'),       -- Czeski IT specialist
(6, 'Michael', 'Ross', 'Mr.'),      -- Prawnik z NY (Suits reference)
(7, 'Katarzyna', 'Wójcik', 'Pani'), -- Streamerka gier
(8, 'Giovanni', 'Rossi', 'Sig.'),   -- Projektant mody
(9, 'Elias', 'Andersen', 'Mr.'),    -- Skandynawski minimalista
(10, 'Krzysztof', 'Mocny', 'Dr hab.'); -- Wykładowca akademicki

INSERT INTO Company_Customers (customer_id, company_name, contact_person_name, contact_person_surname, nip_number)
VALUES
(11, 'TechUnicorn GmbH', 'Klaus', 'Weber', 'DE99887766'),      -- Niemiecki Startup (Biurka el.)
(12, 'CyberZone Gaming Studio', 'Marcin', 'Iwiński', '5250009988'), -- Studio Gier (Fotele gamingowe)
(13, 'Royal Bank of London', 'Sarah', 'Ferguson', 'GB12345678'),   -- Bank (Meble gabinetowe dębowe)
(14, 'Le Bureau Élégant', 'Jean', 'Renoir', 'FR88776655'),     -- Francuski dystrybutor
(15, 'Olivia Business Centre', 'Anna', 'Zarządzalska', '5840001122'), -- Zarządca biurowców
(16, 'Silicon Valley Hub', 'Steve', 'Jobsowski', 'US99887766'),    -- Inkubator technologii
(17, 'Uniwersytet Jagielloński', 'Prof.', 'Dziekan', '6750001234'), -- Uczelnia (Krzesła ISO, tablice)
(18, 'E-Sport Berlin Arena', 'Torsten', 'Schmidt', 'DE55443322'),  -- Arena gamingowa
(19, 'Kancelaria Sejmu RP', 'Marek', 'Urzędnik', '5210002580'),     -- Urząd (Fotele skórzane)
(20, 'Prague Co-Work Space', 'Jana', 'Novotna', 'CZ11223344');     -- Coworking (Biurka Basic)


-- Najpierw czyścimy tabelę, żeby nie dublować wpisów
DELETE FROM Production;
DBCC CHECKIDENT ('Production', RESEED, 0);

INSERT INTO Production (product_id, assembly_line, manufacturing_cost, quantity, production_startdate, production_enddate, order_id)
VALUES
-- === LINIA 1: STOLARNIA (Biurka i Szafy) ===

-- Produkt 1: Biurko Basic (Stan: 50 sztuk)
-- Rozbijamy na 3 serie: start roku, uzupełnienie w lutym, końcówka marca
(1, 1, 150.00, 20, '2024-01-10 06:00', '2024-01-12 14:00', NULL),
(1, 1, 150.00, 20, '2024-02-15 06:00', '2024-02-17 14:00', NULL),
(1, 1, 150.00, 10, '2024-03-20 06:00', '2024-03-21 12:00', NULL),

-- Produkt 4: Kontenerek Mobilny (Stan: 100 sztuk)
-- Produkcja masowa, dwie duże partie
(4, 1, 90.00, 60, '2024-01-05 06:00', '2024-01-08 22:00', NULL), -- Duży zapas na start roku
(4, 1, 90.00, 40, '2024-03-01 06:00', '2024-03-03 14:00', NULL),

-- Produkt 2: Biurko Manager (Stan: 15 sztuk)
(2, 1, 320.00, 10, '2024-01-20 07:00', '2024-01-22 15:00', NULL),
(2, 1, 320.00, 5,  '2024-03-10 07:00', '2024-03-11 12:00', NULL),

-- Produkt 5: Szafa Aktowa (Stan: 20 sztuk)
-- Jedna seria, rzadko zamawiane
(5, 1, 250.00, 20, '2024-02-05 06:00', '2024-02-08 14:00', NULL),

-- Produkt 3 (5szt) i 6 (10szt) - Mniejsze serie
(3, 1, 800.00, 5, '2024-02-28 06:00', '2024-02-29 16:00', NULL),
(6, 1, 180.00, 10, '2024-01-15 06:00', '2024-01-16 14:00', NULL),


-- === LINIA 2: TAPICERNIA (Krzesła i Fotele) ===

-- Produkt 9: Krzesło ISO (Stan: 200 sztuk)
-- To jest "drobnica", robi się tego dużo na raz
(9, 2, 45.00, 100, '2024-01-02 06:00', '2024-01-05 14:00', NULL), -- Partia styczniowa
(9, 2, 45.00, 100, '2024-03-01 06:00', '2024-03-04 14:00', NULL), -- Partia marcowa

-- Produkt 7: Fotel Ergo-Office (Stan: 40 sztuk)
-- Regularna produkcja co miesiąc
(7, 2, 220.00, 15, '2024-01-25 08:00', '2024-01-27 16:00', NULL),
(7, 2, 220.00, 15, '2024-02-25 08:00', '2024-02-27 16:00', NULL),
(7, 2, 220.00, 10, '2024-03-25 08:00', '2024-03-26 12:00', NULL),

-- Produkt 10: Fotel Gamingowy RedDragon (Stan: 30 sztuk)
(10, 2, 350.00, 10, '2024-01-18 08:00', '2024-01-19 16:00', NULL),
(10, 2, 350.00, 20, '2024-03-15 08:00', '2024-03-18 16:00', NULL), -- Większe zapotrzebowanie przed wiosną

-- Produkt 11: Fotel BluePhantom (Stan: 25 sztuk)
(11, 2, 350.00, 25, '2024-02-10 08:00', '2024-02-14 16:00', NULL),

-- Produkty luksusowe (małe ilości): Prezes (5), Tron (8), Sofa (4)
(8, 2, 650.00, 5, '2024-03-28 08:00', '2024-03-29 16:00', NULL),
(12, 2, 550.00, 4, '2024-01-30 08:00', '2024-02-01 16:00', NULL),
(12, 2, 550.00, 4, '2024-03-10 08:00', '2024-03-12 16:00', NULL),
(13, 2, 500.00, 4, '2024-02-20 08:00', '2024-02-22 16:00', NULL),


-- === LINIA 3: ELEKTRONIKA (Biurka el. i Tablice) ===
-- Tutaj produkcja trwa dłużej, serie są małe

-- Produkt 15: Biurko LED Entry (Stan: 25 sztuk)
(15, 3, 400.00, 10, '2024-01-15 08:00', '2024-01-18 16:00', NULL),
(15, 3, 400.00, 15, '2024-03-15 08:00', '2024-03-20 16:00', NULL),

-- Produkt 14: Biurko CyberDesk Pro (Stan: 10 sztuk)
(14, 3, 900.00, 5, '2024-02-01 08:00', '2024-02-03 16:00', NULL),
(14, 3, 900.00, 5, '2024-04-01 08:00', '2024-04-03 16:00', NULL),

-- Tablice (produkcja jednostkowa/małoseryjna)
(16, 3, 1800.00, 2, '2024-01-10 08:00', '2024-01-12 16:00', NULL), -- SmartBoard 65
(16, 3, 1800.00, 3, '2024-03-05 08:00', '2024-03-08 16:00', NULL),
(17, 3, 3500.00, 2, '2024-02-15 08:00', '2024-02-18 16:00', NULL), -- SmartBoard 85 (tylko 2 sztuki)


-- === LINIA 4: STOLARNIA CIĘŻKA (Stoły konferencyjne) ===
-- Duże gabaryty, rzadka produkcja

(18, 4, 1200.00, 3, '2024-03-10 07:00', '2024-03-14 15:00', NULL), -- Dąb 3m (3 sztuki)
(19, 4, 800.00, 4, '2024-02-20 07:00', '2024-02-23 15:00', NULL),  -- Modułowe (4 sztuki)


-- === LINIA 5: DROBNE ELEMENTY (Akcesoria) ===
-- Szybka produkcja, duże serie

-- Produkt 21: Uchwyt PC (Stan: 100 sztuk)
(21, 5, 15.00, 100, '2024-01-05 08:00', '2024-01-06 14:00', NULL), -- Jedna szybka seria na początku roku

-- Produkt 20: Wózek pod projektor (Stan: 30 sztuk)
(20, 5, 60.00, 15, '2024-01-12 08:00', '2024-01-13 16:00', NULL),
(20, 5, 60.00, 15, '2024-03-12 08:00', '2024-03-13 16:00', NULL);

-- Czyścimy tabelę Orders i resetujemy licznik ID, żeby mieć pewność, że zaczynamy od 1
DELETE FROM Order_Details; -- Najpierw szczegóły (klucz obcy)
DELETE FROM Payments;      -- Płatności (klucz obcy)
DELETE FROM Cancelled_Orders;
DELETE FROM Production WHERE order_id IS NOT NULL; -- Produkcja powiązana z zamówieniami
DELETE FROM Orders;
DBCC CHECKIDENT ('Orders', RESEED, 0);

INSERT INTO Orders (customer_id, order_date, estimated_date, delivery_date, discount)
VALUES
-- === Q1: ROZRUCH (Zimowy sen i pierwsze kontrakty) ===
-- Zamówienia 1-15
(1, '2025-01-10', '2025-01-15', '2025-01-14', 0.00), -- Janusz Bielski (Start roku)
(11, '2025-01-12', '2025-01-20', '2025-01-18', 0.05), -- TechUnicorn (Małe doposażenie)
(2, '2025-01-15', '2025-01-20', '2025-01-19', 0.00),
(3, '2025-01-25', '2025-01-30', '2025-01-29', 0.00),
(14, '2025-02-01', '2025-02-15', '2025-02-14', 0.00), -- Le Bureau (Francja)
(4, '2025-02-05', '2025-02-10', '2025-02-09', 0.00),
(12, '2025-02-10', '2025-02-28', '2025-02-25', 0.02), -- CyberZone (Przed turniejem)
(5, '2025-02-14', '2025-02-20', '2025-02-19', 0.05), -- Walentynkowy rabat
(6, '2025-02-20', '2025-02-25', '2025-02-24', 0.00),
(15, '2025-02-25', '2025-03-05', '2025-03-04', 0.00), -- Olivia Business
(7, '2025-03-01', '2025-03-06', '2025-03-05', 0.00),
(19, '2025-03-05', '2025-03-20', '2025-03-18', 0.00), -- Sejm (Długi czas realizacji)
(8, '2025-03-10', '2025-03-15', '2025-03-14', 0.00),
(13, '2025-03-15', '2025-03-30', '2025-03-29', 0.03), -- Bank of London
(9, '2025-03-20', '2025-03-25', '2025-03-24', 0.00),

-- === Q2: WIOSENNE PORZĄDKI (Biura się budzą) ===
-- Zamówienia 16-35
(16, '2025-04-02', '2025-04-20', '2025-04-18', 0.10), -- Silicon Valley (Duże zamówienie)
(10, '2025-04-05', '2025-04-10', '2025-04-09', 0.00),
(1, '2025-04-10', '2025-04-15', '2025-04-14', 0.00), -- Powracający klient
(17, '2025-04-15', '2025-05-01', '2025-04-30', 0.05), -- UJ (Mały przetarg)
(11, '2025-04-20', '2025-04-30', '2025-04-29', 0.05),
(20, '2025-04-25', '2025-05-10', '2025-05-08', 0.00), -- Praga Coworking
(2, '2025-05-01', '2025-05-06', '2025-05-05', 0.00),
(18, '2025-05-05', '2025-05-25', '2025-05-23', 0.08), -- Arena Berlin
(3, '2025-05-10', '2025-05-15', '2025-05-14', 0.00),
(14, '2025-05-15', '2025-06-01', '2025-05-30', 0.02),
(4, '2025-05-20', '2025-05-25', '2025-05-24', 0.00),
(12, '2025-05-25', '2025-06-10', '2025-06-09', 0.05),
(5, '2025-06-01', '2025-06-06', '2025-06-05', 0.00),
(15, '2025-06-05', '2025-06-20', '2025-06-19', 0.03),
(6, '2025-06-10', '2025-06-15', '2025-06-14', 0.00),
(19, '2025-06-15', '2025-07-01', '2025-06-30', 0.00),
(7, '2025-06-20', '2025-06-25', '2025-06-24', 0.00),
(13, '2025-06-25', '2025-07-15', '2025-07-14', 0.05),
(8, '2025-06-30', '2025-07-05', '2025-07-04', 0.00),
(16, '2025-07-01', '2025-07-20', '2025-07-18', 0.08),

-- === Q3: BACK TO SCHOOL & OFFICE (Szczyt sezonu edukacyjnego) ===
-- Zamówienia 36-55
(17, '2025-07-15', '2025-08-30', '2025-08-25', 0.15), -- UJ (Główny przetarg roczny - duży rabat)
(9, '2025-07-20', '2025-07-25', '2025-07-24', 0.00),
(11, '2025-08-01', '2025-08-15', '2025-08-14', 0.05),
(1, '2025-08-05', '2025-08-10', '2025-08-09', 0.00),
(20, '2025-08-10', '2025-08-25', '2025-08-24', 0.02),
(10, '2025-08-15', '2025-08-20', '2025-08-19', 0.00),
(12, '2025-08-20', '2025-09-10', '2025-09-08', 0.05),
(2, '2025-08-25', '2025-08-30', '2025-08-29', 0.00),
(18, '2025-09-01', '2025-09-20', '2025-09-18', 0.05),
(3, '2025-09-02', '2025-09-07', '2025-09-06', 0.00),
(14, '2025-09-05', '2025-09-25', '2025-09-23', 0.02),
(4, '2025-09-10', '2025-09-15', '2025-09-14', 0.00),
(15, '2025-09-15', '2025-09-30', '2025-09-29', 0.03),
(5, '2025-09-20', '2025-09-25', '2025-09-24', 0.00),
(19, '2025-09-25', '2025-10-10', '2025-10-09', 0.00), -- Sejm (Doposażenie biur poselskich)
(6, '2025-09-28', '2025-10-03', '2025-10-02', 0.00),
(13, '2025-10-01', '2025-10-20', '2025-10-18', 0.05),
(7, '2025-10-05', '2025-10-10', '2025-10-09', 0.00),
(16, '2025-10-10', '2025-10-30', '2025-10-28', 0.10),
(8, '2025-10-15', '2025-10-20', '2025-10-19', 0.00),

-- === Q4: KOŃCÓWKA ROKU (Black Friday & Budżety) ===
-- Zamówienia 56-65 (Zrealizowane)
(9, '2025-10-20', '2025-10-25', '2025-10-24', 0.00),
(11, '2025-11-02', '2025-11-15', '2025-11-14', 0.00),
(17, '2025-11-05', '2025-11-20', '2025-11-19', 0.05),
(1, '2025-11-10', '2025-11-15', '2025-11-14', 0.00),
(20, '2025-11-15', '2025-11-30', '2025-11-29', 0.02),
(10, '2025-11-20', '2025-11-25', '2025-11-24', 0.00),
(12, '2025-11-25', '2025-12-10', '2025-12-09', 0.15), -- Black Friday Deal!
(2, '2025-11-28', '2025-12-05', '2025-12-04', 0.20), -- Black Friday Indywidualny
(3, '2025-11-28', '2025-12-05', '2025-12-04', 0.20), -- Black Friday Indywidualny
(14, '2025-12-01', '2025-12-15', '2025-12-14', 0.05),

-- === OSTATNIA PROSTA (Zaległe / W toku) ===
-- Zamówienia 66-69 (Opóźnione lub w trakcie dostawy)
(18, '2025-12-05', '2025-12-24', NULL, 0.08), -- Arena Berlin (Na styk przed świętami)
(4, '2025-12-10', '2025-12-18', NULL, 0.00), -- Zamówienie z zeszłego tygodnia (dziś powinna być dostawa)
(13, '2025-12-12', '2026-01-15', NULL, 0.00), -- Royal Bank (Luksusowe stoły, długa produkcja)
(15, '2025-12-15', '2025-12-22', NULL, 0.02), -- Olivia Business

-- === DZISIAJ (18 Grudnia 2025) ===
-- Zamówienia 70-73 (Nowe, wpadły przed chwilą)
(16, '2025-12-18', '2026-01-20', NULL, 0.05), -- Silicon Valley (Palenie budżetu na koniec roku)
(1, '2025-12-18', '2025-12-21', NULL, 0.00),  -- Janusz Bielski (Prezent last minute)
(11, '2025-12-18', '2026-02-01', NULL, 0.10), -- TechUnicorn (Duży projekt na luty)
(19, '2025-12-18', '2026-01-10', NULL, 0.00); -- Sejm (Wymiana mebli w nowym roku)

INSERT INTO Order_Details (order_id, product_id, quantity, unit_price, extra_remarks)
VALUES
-- === Q1: ROZRUCH (Mix indywidualnych i małych firm) ===
-- 1. Janusz Bielski (Komplet do gabinetu)
(1, 1, 1, 399.00, NULL),        -- Biurko Basic
(1, 7, 1, 599.00, NULL),        -- Fotel Ergo
(1, 21, 1, 49.00, NULL),        -- Uchwyt PC

-- 2. TechUnicorn (Małe biuro startowe)
(2, 14, 5, 2100.00, 'Wtyczki EU'), -- 5x CyberDesk
(2, 21, 5, 49.00, NULL),           -- 5x Uchwyt PC

-- 3-5. Pojedyncze zakupy
(3, 10, 1, 899.00, NULL),       -- Fotel Gamingowy
(4, 13, 1, 1200.00, 'Kolor szary'), -- Sofa
(5, 18, 1, 3500.00, 'Winda towarowa dostępna'), -- Stół Dębowy (Le Bureau)

-- 6. Szkoła (Drobiazgi)
(6, 9, 20, 129.00, NULL),       -- 20x Krzesło ISO
(6, 20, 2, 189.00, NULL),       -- 2x Wózek na rzutnik

-- 7. CyberZone (Gaming Setup - luty)
(7, 10, 15, 899.00, NULL),      -- 15x RedDragon
(7, 15, 15, 999.00, NULL),      -- 15x Biurko LED

-- 8-15. Różne
(8, 5, 2, 699.00, NULL),        -- 2x Szafa
(9, 1, 1, 399.00, NULL),
(10, 4, 10, 249.00, NULL),      -- 10x Kontenerek (Olivia Business)
(11, 7, 5, 599.00, NULL),
(12, 8, 2, 1899.00, 'Skóra czarna'), -- Fotele Prezesa dla Sejmu
(13, 2, 1, 850.00, NULL),
(14, 19, 4, 2100.00, NULL),     -- Stoły modułowe (Bank)
(15, 11, 1, 899.00, NULL),


-- === Q2: DUŻE KONTRAKTY ===
-- 16. Silicon Valley Hub (PEŁNE WYPOSAŻENIE PIĘTRA)
-- To zamówienie zje sporo zapasów z początku roku
(16, 14, 20, 2100.00, 'CyberDesk Pro'),
(16, 7, 20, 599.00, 'Ergo Mesh'),
(16, 4, 20, 249.00, 'Kontenerki'),
(16, 5, 5, 699.00, 'Szafy na dokumenty'),

-- 17. UJ (Sale wykładowe)
(17, 9, 100, 115.00, 'Rabat edukacyjny'), -- 100 Krzeseł ISO!

-- 18-35. Uzupełniacze
(18, 1, 5, 399.00, NULL),
(19, 20, 5, 189.00, NULL),      -- Praga Coworking (Wózki)
(20, 3, 2, 2200.00, NULL),      -- Biurka 4-stanowiskowe
(21, 10, 2, 899.00, NULL),
(22, 12, 5, 1499.00, 'Arena Berlin - VIP Seats'), -- Trony Streamera
(23, 6, 4, 450.00, NULL),       -- Stoły socjalne
(24, 16, 1, 4500.00, NULL),     -- SmartBoard 65
(25, 4, 10, 249.00, NULL),
(26, 11, 10, 899.00, NULL),     -- BluePhantom
(27, 2, 1, 850.00, NULL),
(28, 5, 3, 699.00, NULL),
(29, 1, 10, 399.00, NULL),
(30, 8, 1, 1899.00, NULL),
(31, 15, 5, 999.00, NULL),
(32, 17, 1, 9900.00, 'Montaż w cenie'), -- SmartBoard 85 (Sejm)
(33, 1, 2, 399.00, NULL),
(34, 18, 1, 3500.00, NULL),
(35, 21, 50, 45.00, NULL),      -- 50 uchwytów (Silicon Valley domawia)


-- === Q3: BACK TO SCHOOL (Lipiec-Wrzesień) ===
-- 36. UJ (Wielki przetarg letni)
(36, 9, 150, 110.00, 'Cena hurtowa'),   -- 150 Krzeseł ISO
(36, 16, 10, 4200.00, 'Dla sal A i B'), -- 10 SmartBoardów 65

-- 37-55. Sezon ogórkowy i powroty
(37, 7, 1, 599.00, NULL),
(38, 14, 2, 2100.00, NULL),
(39, 2, 1, 850.00, NULL),
(40, 20, 10, 189.00, NULL),     -- Praga Coworking
(41, 1, 1, 399.00, NULL),
(42, 10, 5, 899.00, NULL),      -- CyberZone domawia
(43, 13, 2, 1200.00, NULL),
(44, 18, 2, 3500.00, 'Dąb naturalny'), -- Arena Berlin (strefa VIP)
(45, 1, 5, 399.00, NULL),
(46, 5, 5, 699.00, NULL),
(47, 6, 2, 450.00, NULL),
(48, 4, 20, 249.00, NULL),      -- Olivia Business
(49, 8, 2, 1899.00, NULL),
(50, 8, 10, 1899.00, 'Sejm - Sale komisyjne'), -- 10 Foteli Prezesa (Luksus)
(51, 1, 1, 399.00, NULL),
(52, 19, 2, 2100.00, NULL),
(53, 2, 1, 850.00, NULL),
(54, 16, 2, 4500.00, NULL),
(55, 10, 1, 899.00, NULL),


-- === Q4: BLACK FRIDAY & KONIEC ROKU ===
-- 56-65. Zakupy impulsywne i budżetowe
(56, 1, 1, 399.00, NULL),
(57, 14, 5, 2100.00, NULL),     -- TechUnicorn
(58, 9, 20, 129.00, NULL),      -- UJ
(59, 11, 1, 899.00, NULL),
(60, 21, 20, 49.00, NULL),
(61, 7, 2, 599.00, NULL),
(62, 10, 20, 750.00, 'Black Friday Deal'), -- CyberZone (taniej)
(63, 11, 1, 750.00, 'Black Friday Deal'),
(64, 12, 1, 1200.00, 'Black Friday Deal'),
(65, 5, 2, 699.00, NULL),


-- === OSTATNIA PROSTA (ZAMÓWIENIA WISZĄCE/OPÓŹNIONE) ===
-- To są te kluczowe zamówienia, które "wiszą" i mogą wymagać produkcji

-- 66. Arena Berlin (Turniej e-sportowy) - WIELKIE ZAMÓWIENIE
-- Tego na pewno nie mamy tyle na stanie po całym roku sprzedaży
(66, 15, 60, 999.00, 'Pilne! Cała arena'), -- 60 biurek LED
(66, 10, 60, 899.00, 'Logotypy sponsorów'), -- 60 foteli RedDragon

-- 67. Le Bureau (Francja)
(67, 13, 5, 1200.00, 'Sofy do lobby'),

-- 68. Royal Bank of London (Meble gabinetowe)
(68, 18, 5, 3500.00, 'Stół Dębowy 3m'), -- 5 sztuk (produkcja tego trwa wieki!)
(68, 8, 20, 1899.00, 'Fotele skórzane'), -- 20 foteli Prezesa

-- 69. Olivia Business Centre
(69, 5, 15, 699.00, NULL),      -- 15 Szaf aktowych


-- === DZISIAJ (18 Grudnia 2025) ===
-- Nowe zamówienia, które dopiero wpadły

-- 70. Silicon Valley Hub (Palenie budżetu)
(70, 21, 100, 49.00, 'Akcesoria dla pracowników'), -- 100 uchwytów
(70, 20, 10, 189.00, NULL),

-- 71. Janusz Bielski
(71, 1, 1, 399.00, 'Prezent dla syna'),

-- 72. TechUnicorn
(72, 17, 3, 9900.00, 'SmartBoard 85 4K - Sala Zarządu'), -- Bardzo drogie, brak na stanie

-- 73. Sejm RP (Wymiana mebli)
(73, 19, 10, 2100.00, 'Stoły modułowe do sal spotkań');

INSERT INTO Production (product_id, assembly_line, manufacturing_cost, quantity, production_startdate, production_enddate, order_id)
VALUES
-- === REALIZACJA ZAMÓWIENIA 66 (Arena Berlin) ===
-- Zamówili 60 biurek LED i 60 foteli. Na stanie mieliśmy resztki.
-- Status: W TOKU (Data startu jest, data końca NULL).
-- Linia 3 (Elektronika) i Linia 2 (Tapicernia) pracują pełną parą.

(15, 3, 400.00, 50, '2025-12-06 08:00:00', NULL, 66), -- Biurka LED (Dorabiamy 50 sztuk)
(10, 2, 350.00, 45, '2025-12-07 08:00:00', NULL, 66), -- Fotele RedDragon (Dorabiamy 45 sztuk)


-- === REALIZACJA ZAMÓWIENIA 67 (Le Bureau) ===
-- Zamówili 5 sof. Mieliśmy 0 lub 1.
-- Status: ZAKOŃCZONE (Udało się wyprodukować w zeszłym tygodniu).

(13, 2, 500.00, 4, '2025-12-12 08:00:00', '2025-12-16 16:00:00', 67),


-- === REALIZACJA ZAMÓWIENIA 68 (Royal Bank of London) ===
-- Zamówili 5 stołów dębowych i 20 foteli prezesa.
-- To są produkty luksusowe, robią się długo.

(18, 4, 1200.00, 5, '2025-12-13 07:00:00', NULL, 68), -- Stoły Dębowe (Linia Ciężka zajęta)
(8, 2, 650.00, 20, '2025-12-14 07:00:00', NULL, 68), -- Fotele Prezesa (Szycie skóry w toku)


-- === REALIZACJA ZAMÓWIENIA 69 (Olivia Business) ===
-- 15 Szaf. Prosta robota stolarska.
-- Status: W TOKU (Zaczęli wczoraj).

(5, 1, 250.00, 15, '2025-12-17 06:00:00', NULL, 69),


-- === PLANOWANIE ZAMÓWIEŃ DZISIEJSZYCH (18 Grudnia) ===
-- To są zamówienia, które wpadły przed chwilą.
-- Status: OCZEKUJĄCE (Start Date IS NULL). System je kolejkuję.

-- Order 70 (Silicon Valley): 10 Wózków
(20, 5, 60.00, 10, NULL, NULL, 70),

-- Order 72 (TechUnicorn): 3 Tablice SmartBoard 4K
-- Brakuje matryc 85 cali (Unit on Order w Parts by wzrosło), produkcja wstrzymana.
(17, 3, 3500.00, 3, NULL, NULL, 72),

-- Order 73 (Sejm): 10 Stołów modułowych
-- Czekają na zwolnienie Linii nr 4 (zajętej przez Royal Bank).
(19, 4, 800.00, 10, NULL, NULL, 73);


-- 1. Czyścimy TYLKO starą produkcję "na magazyn" (Twoje 9 rekordów z order_id zostanie bezpieczne)
DELETE FROM Production WHERE order_id IS NULL;

-- 1. Czyścimy TYLKO starą produkcję "na magazyn" (Twoje 9 rekordów z order_id jest bezpieczne)
DELETE FROM Production WHERE order_id IS NULL;

-- 2. Wstawiamy produkcję historyczną bezpieczną metodą
INSERT INTO Production (product_id, assembly_line, manufacturing_cost, quantity, production_startdate, production_enddate, order_id)
SELECT
    product_id,
    assembly_line,
    manufacturing_cost,
    total_qty,
    GeneratedStartDate,
    -- Data końca to zawsze Data Startu + 2 dni (gwarancja poprawności)
    DATEADD(day, 2, GeneratedStartDate),
    NULL -- order_id NULL
FROM (
    -- Podzapytanie, które grupuje sprzedaż i losuje datę RAZ dla każdego produktu
    SELECT
        od.product_id,
        c.assembly_line,
        p.manufacturing_cost,
        SUM(od.quantity) as total_qty,
        -- Losujemy datę startu tutaj: od 30 do 230 dni temu
        DATEADD(day, -ABS(CHECKSUM(NEWID()) % 200) - 30, GETDATE()) as GeneratedStartDate
    FROM Order_Details od
    JOIN Orders o ON od.order_id = o.order_id
    JOIN Products p ON od.product_id = p.product_id
    JOIN Categories c ON p.category_id = c.category_id
    WHERE o.delivery_date IS NOT NULL -- Tylko dla zamówień już zrealizowanych
    GROUP BY od.product_id, c.assembly_line, p.manufacturing_cost
) AS SafeData;


-- Najpierw upewniamy się, że tabela jest czysta, żeby nie dublować
DELETE FROM Cancelled_Orders;

-- Scenariusz 1: Black Friday (Jan Nowak) - Rezygnacja
UPDATE Orders SET delivery_date = NULL WHERE order_id = 56;
INSERT INTO Cancelled_Orders (order_id, cancellation_date, reason, compensation)
VALUES (56, '2025-10-20 18:00:00', 'Rezygnacja klienta', 0.00);

-- Scenariusz 2: Arena Berlin (Majowe zamówienie) - Nasza wina (brak części)
UPDATE Orders SET delivery_date = NULL WHERE order_id = 22;
INSERT INTO Cancelled_Orders (order_id, cancellation_date, reason, compensation)
VALUES (22, '2025-05-20 10:00:00', 'Brak części na produkcji', 0.00);

-- Scenariusz 3: Le Bureau (Sofy) - Anulowane w trakcie produkcji (z Twoich 9 rekordów!)
UPDATE Orders SET delivery_date = NULL WHERE order_id = 67;
INSERT INTO Cancelled_Orders (order_id, cancellation_date, reason, compensation)
VALUES (67, '2025-12-16 09:00:00', 'Odstąpienie w trakcie produkcji', 1800.00);


-- Czyścimy tabelę płatności
DELETE FROM Payments;

INSERT INTO Payments (order_id, paid_amount, payment_type, payment_date)
SELECT
    o.order_id,
    -- Wyliczamy kwotę: (Ilość * Cena) * (1 - Rabat)
    CAST(SUM(od.quantity * od.unit_price) * (1.0 - o.discount) AS MONEY),

    -- Typ płatności
    CASE
        WHEN c.company_name IS NOT NULL THEN 'Przelew'
        ELSE 'Karta'
    END,

    -- Data płatności (Firmy płacą 3 dni później, ludzie od razu)
    CASE
        WHEN c.company_name IS NOT NULL THEN DATEADD(day, 3, o.order_date)
        ELSE o.order_date
    END
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
LEFT JOIN Company_Customers c ON o.customer_id = c.customer_id
WHERE
    -- WARUNKI LOGICZNE:
    o.order_id NOT IN (SELECT order_id FROM Cancelled_Orders) -- Pomiń anulowane
    AND o.order_id <> 73 -- Pomiń Sejm (jeszcze nie zapłacili)
GROUP BY o.order_id, o.order_date, o.discount, c.company_name;