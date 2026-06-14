-- Baza danych została zaprojektowana dla kliniki weterynaryjnej i służy do zarządzania informacjami o właścicielach zwierząt, pacjentach, 
-- wizytach, zabiegach oraz receptach. System umożliwia przechowywanie historii leczenia zwierząt, przypisywanie weterynarzy do wizyt oraz 
-- dokumentowanie wykonanych zabiegów i wypisanych leków.

USE master;
GO

--sprawdzenie czy baza istnieje 
IF EXISTS (SELECT *FROM sys.databases WHERE name = 'Klinika')
BEGIN

-- zamknięcie połączeń do bazy
ALTER DATABASE Klinika
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;

-- usunięcie bazy
DROP DATABASE Klinika;

END;
GO

-- tworzenie nowej bazy
CREATE DATABASE Klinika;
GO

-- wejście do bazy
USE Klinika;
GO 
/*Tabela przechowuje dane właścicieli zwierząt. Zawiera informacje takie jak imię, nazwisko, numer telefonu, adres e-mail oraz adres 
zamieszkania właściciela.*/

CREATE TABLE Owners (
owner_id INT IDENTITY(1,1) PRIMARY KEY,
first_name NVARCHAR(30) NOT NULL,
last_name NVARCHAR(30) NOT NULL,
phone NVARCHAR(9) NOT NULL,
email NVARCHAR(30),  
city NVARCHAR(30) NOT NULL,
street NVARCHAR(30) NOT NULL,
postal_code CHAR(6) NOT NULL
);

INSERT INTO Owners (first_name, last_name, phone,email, city,street, postal_code ) VALUES
( 'Jan', 'Kowalski', '123456789', 'jan@gmail.com', 'Kraków', 'ul. Długa 10', '30-011'),
( 'Anna', 'Nowak', '987654321', 'anna@gmail.com', 'Katowice', 'ul. Znajoma 5', '40-002'),
('Piotr', 'Zieliński', '222111333',NULL, 'Kraków', 'ul. Szeroka 8', '30-111'), 
( 'Marzena', 'Mazur', '987654311', 'm.mazur12@wp.pl', 'Niepołomice', 'ul. Polna 15', '35-102'),
( 'Ewelina', 'Wójcik', '123654321', 'ewelina.w@gmail.com', 'Kraków', 'ul. Krawiecka 88', '30-123'),
( 'Tomasz', 'Baran', '432154321',NULL,'Kraków', 'ul. Brzozowa 4', '31-112'),
( 'Robert', 'Dąbrowski', '121254321', 'r.dabrowski@onet.pl', 'Katowice', 'ul. Sosnowa 11', '40-111'),
( 'Katarzyna', 'Niewiadoma', '795132111', 'kat.niew@gmail.com', 'Słomniki', 'ul. Krakowska 22', '36-321'),
( 'Julia', 'Malarczyk', '771257327', NULL, 'Kraków', 'aleja 29 listopada 32', '31-452'),
( 'Adrian', 'Małysz', '721357428', NULL, 'Zielonki', 'ul. Krakowskie Przedmieście 55', '32-078'),
('Magdalena', 'Kowalczyk',  '601111222', 'magda.k@gmail.com',      'Kraków',       'ul. Wiślna 3',              '30-015'),
('Krzysztof', 'Wiśniewski', '602222333', NULL,                      'Wieliczka',    'ul. Górnicza 7',            '32-020'),
('Agnieszka', 'Pawlak',     '603333444', 'a.pawlak@wp.pl',          'Kraków',       'ul. Józefińska 12',         '30-530'),
('Marcin',    'Krawczyk',   '604444555', 'marcin.kr@onet.pl',       'Myślenice',    'ul. Słoneczna 19',          '32-400'),
('Barbara',   'Adamczyk',   '605555666', 'b.adamczyk@gmail.com',    'Kraków',       'ul. Rakowicka 44',          '31-510'),
('Łukasz',    'Jabłoński',  '606666777', NULL,                      'Skawina',      'ul. Energetyków 8',         '32-050'),
('Monika',    'Woźniak',    '607777888', 'monika.w@gmail.com',      'Kraków',       'ul. Prądnicka 67',          '31-202'),
('Grzegorz',  'Zając',      '608888999', 'g.zajac@interia.pl',      'Niepołomice',  'ul. Parkowa 3',             '35-102'),
('Natalia',   'Kowalska',   '609999000', 'natalia.kow@gmail.com',   'Kraków',       'ul. Lipowa 21',             '30-702'),
('Damian',    'Piotrowicz',  '610101010', NULL,                     'Zabierzów',    'ul. Kolejowa 5',            '32-080'),
('Sylwia',    'Michalska',  '611111111', 's.michalska@wp.pl',       'Kraków',       'ul. Botaniczna 9',          '31-503'),
('Rafał',     'Sikora',     '612121212', 'rafal.sikora@gmail.com',  'Wieliczka',    'ul. Zamkowa 14',            '32-020'),
('Dorota',    'Pietrzak',   '613131313', NULL,                      'Kraków',       'ul. Łagiewnicka 55',        '30-417'),
('Wojciech',  'Grabowski',  '614141414', 'w.grabowski@onet.pl',     'Nowy Targ',    'ul. Waksmundzka 2',         '34-400'),
('Justyna',   'Nowicka',    '615151515', 'justyna.now@gmail.com',   'Kraków',       'ul. Fieldorfa 11',          '30-960'),
('Sławomir',  'Czarnecki',  '616161616', NULL,                      'Chrzanów',     'ul. Kusocińskiego 4',       '32-500'),
('Paulina',   'Jaworska',   '617171717', 'p.jaworska@gmail.com',    'Kraków',       'ul. Bieżanowska 88',        '30-826'),
('Irena',     'Wieczorek',  '618181818', 'i.wieczorek@wp.pl',       'Dobczyce',     'ul. Rynek 7',               '32-410'),
('Mateusz',   'Lewandowski','619191919', 'mateusz.l@gmail.com',     'Kraków',       'ul. Kolberga 3',            '31-155'),
('Halina',    'Kamińska',   '620202020', NULL,                      'Kraków',       'ul. Opolska 22',            '31-323');

SELECT * FROM Owners;

/*Tabela Pets przechowuje informacje o zwierzętach należących do właścicieli. Zawiera dane takie jak imię zwierzęcia, gatunek, rasa, 
data urodzenia, waga oraz płeć. Kolumna gender może przyjmować tylko wartości: "samiec", "samica" lub "nieznana", 
a domyślnie ustawiana jest wartość "nieznana".*/

CREATE TABLE Pets (
animal_id INT IDENTITY(1,1) PRIMARY KEY,
name NVARCHAR(30) NOT NULL,
species NVARCHAR(20) NOT NULL,  
breed NVARCHAR(30) NULL,
birth_date DATE NULL,
weight DECIMAL(5,2),
gender NVARCHAR(10)  NOT NULL DEFAULT 'nieznana' CHECK (gender IN ('samiec','samica','nieznana')),
owner_id INT,
FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

INSERT INTO Pets (name, species, breed, birth_date, weight, gender,owner_id) VALUES
('Rex', 'pies', 'labrador', '2020-05-10', 30.5, 'samiec', 1),
('Mruczek', 'kot', 'dachowiec', NULL, 4.2, 'samiec', 2),
('Bella', 'pies', 'buldog', '2023-04-01', 12.0, 'samica', 1),
('Kropka', 'kot', 'perski', '2019-11-05', 3.8, 'samica', 3),
('Kruszynka', 'chomik', NULL,NULL,NULL, 'samica', 4),
('Cynamon', 'kot', 'dachowiec',NULL, 4.0, 'samiec', 5),
('Puszek', 'kot', 'ragdoll', '2024-05-12', 4.7, 'samiec', 6),
('Mamba', 'kot', 'bombajski', '2023-04-20', 4.0, 'samica', 6),
('Maks', 'pies',NULL,NULL, 11.0, 'samiec', 7),
('Kulka', 'chomik',NULL,NULL, 0.38, 'samica', 8),
('Pasztecik', 'chomik',NULL,NULL,0.45,'samiec',8),
('Azor', 'pies','kundel',NULL, 15.32, 'samiec', 9),
-- owner 1 (Jan Kowalski) - ma już Rex(1) i Bella(3)
('Burek',      'pies',   'owczarek',     '2019-03-15', 28.0,  'samiec', 1),
 
-- owner 2 (Anna Nowak) - ma już Mruczek(2)
('Luna',       'kot',    'brytyjski',    '2021-07-20', 4.5,   'samica', 2),
('Tygrys',     'kot',    'dachowiec',    '2020-01-10', 5.1,   'samiec', 2),
 
-- owner 3 (Piotr Zieliński) - ma już Kropka(4)
('Zefir',      'pies',   'beagle',       '2022-06-01', 10.2,  'samiec', 3),
 
-- owner 4 (Marzena Mazur) - ma już Kruszynka(5)
('Loki',       'kot',    'dachowiec',    '2023-02-14', 3.9,   'samiec', 4),
('Śnieżka',    'królik', NULL,           '2022-10-05', 1.8,   'samica', 4),
 
-- owner 5 (Ewelina Wójcik) - ma już Cynamon(6)
('Hania',      'pies',   'shih tzu',     '2021-11-30', 6.5,   'samica', 5),
('Perełka',    'kot',    'syberyjski',   '2020-08-12', 5.8,   'samica', 5),
 
-- owner 6 (Tomasz Baran) - ma już Puszek(7) i Mamba(8)
('Gniewko',    'pies',   'owczarek',     '2018-05-20', 32.0,  'samiec', 6),
 
-- owner 7 (Robert Dąbrowski) - ma już Maks(9)
('Zara',       'pies',   'doberman',     '2020-09-25', 33.5,  'samica', 7),
('Czesia',     'kot',    'dachowiec',    NULL,          3.4,   'samica', 7),
 
-- owner 8 (Katarzyna Niewiadoma) - ma już Kulka(10) i Pasztecik(11)
('Gucio',      'pies',   'corgi',        '2022-12-01', 13.0,  'samiec', 8),
 
-- owner 9 (Julia Malarczyk) - ma już Azor(12)
('Basia',      'pies',   'golden retriever','2021-03-18', 27.5,'samica', 9),
 
-- owner 10 (Adrian Małysz) - ma już Nela(13)
('Tofik',      'pies',   'labrador',     '2020-11-11', 29.0,  'samiec', 10),
 
-- owner 11 (Magdalena Kowalczyk)
('Lila',       'kot',    'siamski',      '2022-04-07', 3.6,   'samica', 11),
('Bruno',      'pies',   'boxer',        '2019-08-22', 30.0,  'samiec', 11),
('Złotko',     'chomik', NULL,           NULL,          0.42,  'samiec', 11),
 
-- owner 12 (Krzysztof Wiśniewski)
('Atlas',      'pies',   'nowofundland', '2018-12-15', 58.0,  'samiec', 12),
('Ruda',       'kot',    'maine coon',   '2021-05-30', 6.2,   'samica', 12),
 
-- owner 13 (Agnieszka Pawlak)
('Zizi',       'papuga', NULL,           '2020-01-01', 0.32,  'samica', 13),
('Balbinka',   'kot',    'dachowiec',    '2022-07-14', 4.1,   'samica', 13),
('Reksio',     'pies',   'dalmatyńczyk', '2021-02-28', 24.0,  'samiec', 13),
 
-- owner 14 (Marcin Krawczyk)
('Nero',       'pies',   'rottweiler',   '2020-06-10', 45.0,  'samiec', 14),
('Kleopatra',  'kot',    'egipski mau',  '2023-01-15', 3.7,   'samica', 14),
 
-- owner 15 (Barbara Adamczyk)
('Fifi',       'pies',   'chihuahua',    '2021-09-05', 2.8,   'samica', 15),
('Miszka',     'chomik', NULL,           NULL,          0.40,  'samica', 15),
 
-- owner 16 (Łukasz Jabłoński)
('Max',        'pies',   'husky',        '2019-07-20', 26.0,  'samiec', 16),
('Śmiga',      'kot',    'dachowiec',    NULL,          4.3,   'samiec', 16),
 
-- owner 17 (Monika Woźniak)
('Stella',     'pies',   'spaniel',      '2022-03-12', 16.0,  'samica', 17),
('Puch',       'królik', NULL,           '2023-05-20', 2.1,   'samiec', 17),
 
-- owner 18 (Grzegorz Zając)
('Samson',     'pies',   'bernardyn',    '2017-11-01', 72.0,  'samiec', 18),
('Fryderyk',   'kot',    'norweski leśny','2020-10-10', 5.5,  'samiec', 18),
 
-- owner 19 (Natalia Kowalska)
('Miętka',     'kot',    'dachowiec',    '2023-08-03', 3.8,   'samica', 19),
('Zuzia',      'pies',   'maltańczyk',   '2022-06-25', 3.5,   'samica', 19),
 
-- owner 20 (Damian Piotrowicz)
('Rambo',      'pies',   'pitbull',      '2020-04-14', 22.0,  'samiec', 20),
('Kleks',      'kot',    'dachowiec',    NULL,          4.6,   'samiec', 20),
 
-- owner 21 (Sylwia Michalska)
('Baśka',      'pies',   'pudel',        '2021-12-20', 8.0,   'samica', 21),
('Oreo',       'kot',    'dachowiec',    '2022-09-09', 4.4,   'samiec', 21),
 
-- owner 22 (Rafał Sikora)
('Hektor',     'pies',   'dog niemiecki','2019-03-03', 62.0,  'samiec', 22),
('Bianka',     'kot',    'ragdoll',      '2023-11-11', 5.0,   'samica', 22),
 
-- owner 23 (Dorota Pietrzak)
('Puzon',      'pies',   'sznaucer',     '2020-02-02', 18.0,  'samiec', 23),
('Tulipan',    'kot',    'rosyjski niebieski','2021-04-04', 4.2,'samiec',23),
 
-- owner 24 (Wojciech Grabowski)
('Braveheart', 'pies',   'szkocki',      '2018-06-16', 25.0,  'samiec', 24),
('Fizia',      'kot',    'dachowiec',    NULL,          3.9,   'samica', 24),
('Wiesio',     'papuga', NULL,           '2019-05-01', 0.28,  'samiec', 24),
 
-- owner 25 (Justyna Nowicka)
('Mela',       'pies',   'sheltie',      '2022-01-17', 8.5,   'samica', 25),
('Pistacjo',   'chomik', NULL,           NULL,          0.38,  'samiec', 25),
 
-- owner 26 (Sławomir Czarnecki)
('Diablo',     'pies',   'cane corso',   '2019-09-09', 50.0,  'samiec', 26),
('Ciastko',    'kot',    'perski',       '2022-05-05', 4.8,   'samica', 26),
 
-- owner 27 (Paulina Jaworska)
('Wróbel',     'pies',   'jack russell', '2021-07-07', 6.0,   'samiec', 27),
('Ninka',      'kot',    'dachowiec',    '2023-03-22', 3.5,   'samica', 27),
 
-- owner 28 (Irena Wieczorek)
('Bajka',      'pies',   'spaniel',      '2020-05-18', 14.0,  'samica', 28),
('Karmel',     'kot',    'burmański',    '2021-10-30', 4.9,   'samiec', 28),
 
-- owner 29 (Mateusz Lewandowski)
('Tytan',      'pies',   'husky',        '2021-08-08', 27.5,  'samiec', 29),
('Iskra',      'kot',    'dachowiec',    '2022-02-14', 3.7,   'samica', 29),
 
-- owner 30 (Halina Kamińska)
('Ptyś',       'pies',   'bichon frise', '2022-11-11', 5.5,   'samiec', 30),
('Mariolka',   'kot',    'dachowiec',    '2023-06-06', 3.2,   'samica', 30),
('Pępek',      'królik', NULL,           '2022-08-20', 2.4,   'samiec', 30);


-- brakujące rekordy aby zachować spójność Visits (animal_id 72-78)
INSERT INTO Pets (name, species, breed, birth_date, weight, gender, owner_id) VALUES
('Rocky', 'pies', 'amstaff', '2021-03-11', 24.5, 'samiec', 21),
('Mika', 'kot', 'maine coon', '2022-01-15', 5.1, 'samica', 22),
('Leon', 'pies', 'owczarek niemiecki', '2020-09-20', 34.0, 'samiec', 23),
('Koko', 'papuga', NULL, '2021-06-01', 0.45, 'samica', 24),
('Tosia', 'kot', 'brytyjski', '2023-02-14', 4.3, 'samica', 25),
('Rufi', 'pies', 'beagle', '2022-10-05', 12.8, 'samiec', 26),
('Fado', 'pies', 'border collie', '2021-12-12', 18.6, 'samiec', 27);

-- tu przykład gdy płeć nieznana
INSERT INTO Pets (name, species, breed, birth_date, weight,owner_id) VALUES
('Nela', 'pies','maltańczyk','2025-04-10', 3.3,10);


/*Tabela przechowuje informacje o weterynarzach pracujących w klinice. Zawiera dane takie jak imię, nazwisko, specjalizacja, numer 
telefonu oraz data zatrudnienia.*/
CREATE TABLE Vets (
    vet_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(30) NOT NULL,
    last_name NVARCHAR(30) NOT NULL,
    specialization NVARCHAR(50) NOT NULL,
    phone NVARCHAR(9) NOT NULL,
    hire_date DATE NOT NULL
);

INSERT INTO Vets (first_name, last_name, specialization, phone, hire_date) VALUES
('Marek', 'Nowak', 'chirurgia', '791227333', '2015-03-01'),
('Ewa', 'Lis', 'dermatologia', '324855166', '2020-06-15'),
('Tomasz', 'Kaczmarek', 'ortopedia', '127883919', '2018-09-10'),
('Anna', 'Wójcik', 'radiologia', '772333444', '2019-01-20'),
('Paweł', 'Mazur', 'asystent weterynarii', '755688717', '2019-11-05'),
('Janusz', 'Szymański', 'kardiologia', '744628788', '2018-10-15');

/*
Tabela Visits przechowuje informacje o wizytach pacjentów, takie jak termin wizyty, dane pacjenta oraz lekarza. Każdy rekord reprezentuje jedną --wizytę. Kolumna status określa aktualny stan wizyty i może przyjmować tylko wartości: "zaplanowana", "zakończona" lub "anulowana". Domyślnie każda nowa wizyta otrzymuje status "zaplanowana". Dodatkowe ograniczenie sprawdza, czy zakończona wizyta ma przypisanego weterynarza.*/
CREATE TABLE Visits (
    visit_id INT IDENTITY(1,1) PRIMARY KEY,
    animal_id INT NOT NULL,
    vet_id INT NULL,
    visit_date DATETIME NOT NULL,
    reason NVARCHAR(70) NOT NULL,
    notes NVARCHAR(255) NULL,      
    status NVARCHAR(20) DEFAULT 'zaplanowana'
        CHECK (status IN ('zaplanowana','zakończona','anulowana')),
    
    FOREIGN KEY (animal_id) REFERENCES Pets(animal_id),
    FOREIGN KEY (vet_id) REFERENCES Vets(vet_id),

	CHECK (
	(status = 'zakończona' AND vet_id IS NOT NULL)
	OR
	(status IN ('zaplanowana','anulowana'))
	)
);

INSERT INTO Visits (animal_id, vet_id, visit_date, reason, notes, status) VALUES
(1, 5, '2025-04-10 10:00', 'szczepienie', 'brak uwag', 'zakończona'),
(2, 2, '2025-04-11 12:00', 'alergia', 'wysypka na skórze', 'zakończona'),
(3, 1, '2025-04-15 09:00', 'kontrola', NULL, 'zakończona'),
(4, 3, '2025-04-16 11:00', 'uraz łapy', 'lekkie kulawienie', 'zakończona'),
(5, 1, '2025-05-16 13:00', 'operacja', 'usunięcie guza', 'zakończona'), 
(6, NULL, '2025-05-18 14:00', 'badanie ogólne', NULL, 'anulowana'),
(7, 4, '2025-05-16 11:00', 'diagnostyka', 'badanie krwi oraz badanie ogólne', 'zakończona'),
(8, 4, '2025-05-18 14:00', 'badanie ogólne', NULL, 'anulowana'),
(9, 3, '2025-05-16 11:00', 'uraz łapy','uraz spowodowany niefortunnym skokiem', 'zakończona'),
(10,1, '2025-05-18 14:00', 'badanie ogólne', NULL, 'zakończona'),
(11, 5, '2025-05-20 13:30', 'badanie ogólne', 'brak uwag', 'zakończona'),
(12, 5, '2025-05-21 10:00', 'szczepienie', NULL, 'zakończona'),
(13,1, '2025-05-21 11:30', 'kontrola - opatrzenie rany', 'rana w fazie gojenia', 'zakończona'),
(4, 3, '2025-05-22 10:00', 'kontrola - uraz łapy', 'lekkie kulawienie', 'zakończona'),
(9, 1, '2025-05-22 11:00', 'kontrola - uraz łapy','uraz spowodowany niefortunnym skokiem', 'zakończona'),
(5,1, '2025-05-22 12:00', 'kontrola po operacji chomika',NULL, 'zakończona'),
(14,  1, '2025-04-02 09:00', 'szczepienie',          'szczepionka przeciw parwowirozie', 'zakończona'),
(15,  2, '2025-04-02 10:30', 'kontrola skóry',       'alergia kontaktowa - podrażnienie', 'zakończona'),
(16,  3, '2025-04-03 11:00', 'uraz',                 'skręcenie łapy przedniej', 'zakończona'),
(17,  1, '2025-04-03 12:00', 'kastracja',            'zabieg kastracji - przebieg pomyślny', 'zakończona'),
(18,  4, '2025-04-04 09:30', 'badanie ogólne',       'zwierzę w dobrej kondycji', 'zakończona'),
(19,  5, '2025-04-04 11:00', 'szczepienie',          'szczepionka mix podstawowy', 'zakończona'),
(20,  2, '2025-04-07 10:00', 'alergia',              'nadwrażliwość pokarmowa', 'zakończona'),
(21,  3, '2025-04-07 13:00', 'uraz łapy',            'złamanie palca - szyna gipsowa', 'zakończona'),
(22,  6, '2025-04-08 09:00', 'badanie serca',        'EKG wykonane, brak nieprawidłowości', 'zakończona'),
(23,  1, '2025-04-08 10:30', 'sterylizacja',         'zabieg sterylizacji - bez komplikacji', 'zakończona'),
(24,  4, '2025-04-09 11:00', 'diagnostyka',          'badanie krwi i RTG klatki piersiowej', 'zakończona'),
(25,  2, '2025-04-09 12:30', 'kontrola',             'kontrola po alergii - poprawa', 'zakończona'),
(26,  5, '2025-04-10 09:00', 'odrobaczanie',         'podanie preparatu odrobaczającego', 'zakończona'),
(27,  3, '2025-04-10 10:30', 'badanie ogólne',       'brak uwag', 'zakończona'),
(28,  6, '2025-04-11 09:00', 'badanie serca',        'szmer sercowy - dalsza obserwacja', 'zakończona'),
(29,  2, '2025-04-11 11:00', 'dermatoza',            'grzybica skóry - leczenie miejscowe', 'zakończona'),
(30,  1, '2025-04-14 10:00', 'kastracja',            'kastracja samca - przebieg prawidłowy', 'zakończona'),
(31,  4, '2025-04-14 11:30', 'kontrola',             'kontrola po szczepieniu - brak odczynu', 'zakończona'),
(32,  3, '2025-04-15 09:00', 'uraz',                 'rany od zadrapania - oczyszczenie', 'zakończona'),
(33,  5, '2025-04-15 10:30', 'szczepienie',          'szczepionka przeciw kocim chorobom', 'zakończona'),
(34,  6, '2025-04-16 09:00', 'kardiologia',          'kontrola po wykrytym szmerze', 'zakończona'),
(35,  2, '2025-04-16 11:00', 'alergia',              'wyprysk alergiczny - poprawa', 'zakończona'),
(36,  1, '2025-04-17 09:30', 'badanie ogólne',       'zwierzę w dobrej kondycji', 'zakończona'),
(37,  3, '2025-04-17 11:00', 'ortopedia',            'ocena ruchomości stawów', 'zakończona'),
(38,  4, '2025-04-22 10:00', 'diagnostyka',          'morfologia krwi,  wyniki w normie', 'zakończona'),
(39,  5, '2025-04-22 11:30', 'odrobaczanie',         'profilaktyczne odrobaczanie', 'zakończona'),
(40,  6, '2025-04-23 09:00', 'badanie serca',        'USG serca', 'zakończona'),
(41,  2, '2025-04-23 10:30', 'dermatologia',         'Łupież', 'zakończona'),
(42,  1, '2025-04-24 09:00', 'operacja',             'usunięcie ciała obcego z żołądka', 'zakończona'),
(43,  3, '2025-04-24 10:30', 'uraz',                 'złamanie kości śródstopia', 'zakończona'),
(44,  4, '2025-04-25 09:00', 'szczepienie',          'szczepienie roczne - przypomnienie', 'zakończona'),
(45,  5, '2025-04-25 11:00', 'badanie ogólne',       'nadwaga - zalecona dieta', 'zakończona'),
(46,  6, '2025-04-28 10:00', 'kardiologia',          'wdrożenie leczenia sercowego', 'zakończona'),
(47,  2, '2025-04-28 11:30', 'alergia',              'pierwsza wizyta - wywiad alergiczny', 'zakończona'),
(48,  1, '2025-04-29 09:00', 'chirurgia',            'usunięcie tłuszczaka', 'zakończona'),
(49,  3, '2025-04-29 11:00', 'kontrola',             'kontrola po złamaniu - zrost', 'zakończona'),
(50,  4, '2025-04-30 10:00', 'diagnostyka',          'badanie moczu, ultrasonografia', 'zakończona'),
(51,  6, '2025-04-30 12:00', 'badanie serca',        'kontrola EKG - wyniki stabilne', 'zakończona'),
(52,  1, '2025-05-05 09:00', 'szczepienie',          'szczepionka DHPPI+Lepto', 'zakończona'),
(53,  2, '2025-05-05 10:30', 'kontrola skóry',       'liszaj - leczenie miejscowe', 'zakończona'),
(54,  3, '2025-05-06 11:00', 'kontrola ortopedyczna','kontrola po złamaniu – dobry zrost', 'zakończona'),
(55,  6, '2025-05-06 12:00', 'badanie ogólne',       'brak uwag', 'zakończona'),
(56,  4, '2025-05-07 09:30', 'diagnostyka',          'RTG klatki piersiowej', 'zakończona'),
(57,  5, '2025-05-07 11:00', 'odrobaczanie',         'odrobaczanie profilaktyczne', 'zakończona'),
(58,  1, '2025-05-12 10:00', 'operacja',             'usunięcie zęba mlecznego', 'zakończona'),
(59,  2, '2025-05-12 11:30', 'dermatologia',         'zapalenie skóry - maść', 'zakończona'),
(60,  3, '2025-05-13 09:00', 'uraz',                 'zwichnięcie stawu kolanowego', 'zakończona'),
(61,  6, '2025-05-13 10:30', 'kardiologia',          'kontrola - stabilny stan', 'zakończona'),
(62,  4, '2025-05-14 09:00', 'diagnostyka',          'badanie krwi pełne', 'zakończona'),
(63,  NULL, '2025-05-14 11:00','badanie ogólne',      NULL, 'anulowana'),
(64,  NULL, '2025-05-15 10:00','szczepienie',         NULL, 'anulowana'),
(65,  NULL, '2025-05-15 12:00','kontrola',            NULL, 'anulowana'),
(66,  1, '2025-05-19 09:00', 'chirurgia',            'biopsja guza', 'zakończona'),
(67,  2, '2025-05-19 10:30', 'kontrola',             'kontrola po leczeniu alergii', 'zakończona'),
(68,  3, '2025-05-20 11:00', 'ortopedia',            'ocena chodu po urazie', 'zakończona'),
(69,  5, '2025-05-21 09:30', 'badanie ogólne',       'profilaktyka - wiek 1 rok', 'zakończona'),
(70,  6, '2025-05-23 10:00', 'kardiologia',          'EKG - nieznaczne odchylenia', 'zakończona'),
(71,  NULL, '2025-05-23 12:00','badanie ogólne',      NULL, 'anulowana'),
(72,  NULL, '2025-05-26 10:00','szczepienie',         NULL, 'anulowana'),
(73,  4, '2025-05-27 09:00', 'diagnostyka',          'USG jamy brzusznej', 'zakończona'),
(74,  1, '2025-05-27 11:00', 'operacja',             'usunięcie kamieni nerkowych', 'zakończona'),
(75,  2, '2025-05-28 10:00', 'dermatologia',         'wyprysk - kontrola po leczeniu', 'zakończona'),
(76,  5, '2025-05-28 11:30', 'szczepienie',          'szczepionka przypominająca', 'zakończona'),
(77,  3, '2025-05-29 09:00', 'uraz',                 'rana cięta łapy - szwy', 'zakończona'),
(78,  6, '2025-05-30 10:00', 'badanie serca',        'kontrola - poprawa', 'zakończona'),
 

-- CZERWIEC 2025 (zakończone)

(14,  1, '2025-06-02 09:00', 'kontrola',             'kontrola po szczepieniu - brak odczynu', 'zakończona'),
(20,  2, '2025-06-02 10:30', 'kontrola alergii',     'alergia wygasza się', 'zakończona'),
(22,  6, '2025-06-03 09:00', 'kardiologia',          'EKG stabilne', 'zakończona'),
(30,  1, '2025-06-03 11:00', 'kontrola',             'kontrola po kastracji', 'zakończona'),
(34,  6, '2025-06-04 09:30', 'kardiologia',          'wdrożone leki działają', 'zakończona'),
(36,  5, '2025-06-04 11:00', 'badanie ogólne',       'brak uwag', 'zakończona'),
(42,  1, '2025-06-05 10:00', 'kontrola po operacji', 'rana zagojona w 80%', 'zakończona'),
(43,  3, '2025-06-05 11:30', 'ortopedia',            'kontrola złamania, zrost prawidłowy', 'zakończona'),
(46,  6, '2025-06-09 09:00', 'kardiologia',          'stabilizacja leczenia', 'zakończona'),
(48,  1, '2025-06-09 10:30', 'kontrola',             'kontrola po usunięciu tłuszczaka', 'zakończona'),
(50,  4, '2025-06-10 09:00', 'diagnostyka',          'wyniki moczu - prawidłowe', 'zakończona'),
(54,  3, '2025-06-10 11:00', 'ortopedia',            'zrost kompletny, zdejmowanie szyny', 'zakończona'),
(58,  1, '2025-06-11 10:00', 'kontrola',             'eana po ekstrakcji zagojona', 'zakończona'),
(60,  3, '2025-06-11 11:30', 'ortopedia',            'rehabilitacja stawu kolanowego', 'zakończona'),
(62,  4, '2025-06-12 09:00', 'diagnostyka',          'kontrola wyników', 'zakończona'),
(66,  1, '2025-06-12 10:30', 'chirurgia',            'wynik biopsji', 'zakończona'),
(68,  3, '2025-06-16 09:00', 'ortopedia',            'pełen powrót do sprawności', 'zakończona'),
(70,  6, '2025-06-16 11:00', 'kardiologia',          'EKG', 'zakończona'),
(74,  1, '2025-06-17 09:30', 'kontrola po operacji', 'gojenie po operacji nerek', 'zakończona'),
(77,  3, '2025-06-17 11:00', 'kontrola',             'szwy usunięte, rana zagojona', 'zakończona'),
(15,  2, '2025-06-18 10:00', 'dermatologia',         'alergia kontaktowa', 'zakończona'),
(28,  6, '2025-06-18 11:30', 'kardiologia',          'szmer sercowy', 'zakończona'),
(29,  2, '2025-06-19 09:00', 'dermatologia',         'grzybica', 'zakończona'),
(35,  2, '2025-06-19 10:30', 'dermatologia',         'wyprysk', 'zakończona'),
(16,  3, '2025-06-23 09:00', 'ortopedia',            'kontrola po urazie - pełne zdrowie', 'zakończona'),
(21,  3, '2025-06-23 10:30', 'ortopedia',            'kontrola po złamaniu, wyniki dobre', 'zakończona'),
(37,  3, '2025-06-24 09:00', 'ortopedia',            'ocena stawów, brak zmian', 'zakończona'),
(41,  2, '2025-06-24 10:30', 'dermatologia',         'łupież - poprawa po szamponie', 'zakończona'),
(44,  5, '2025-06-25 09:00', 'badanie ogólne',       'zwierzę w dobrej kondycji', 'zakończona'),
(45,  5, '2025-06-25 11:00', 'dieta',                'kontrola wagi', 'zakończona'),
(47,  2, '2025-06-26 10:00', 'alergia',              'kontrola po leczeniu - znaczna poprawa', 'zakończona'),
(53,  2, '2025-06-26 11:30', 'dermatologia',         'liszaj wyleczony', 'zakończona'),
(55,  5, '2025-06-27 09:00', 'badanie ogólne',       'profilaktyka, brak uwag', 'zakończona'),
(57,  5, '2025-06-27 10:30', 'odrobaczanie',         'kontrola po odrobaczaniu', 'zakończona'),
(59,  2, '2025-06-30 09:00', 'dermatologia',         'zapalenie skóry, wyleczone', 'zakończona'),
(61,  6, '2025-06-30 11:00', 'kardiologia',          'leczenie utrzymane', 'zakończona'),
 

-- LIPIEC 2025 (zakończone)
(1,   5, '2025-07-01 09:00', 'badanie ogólne',       'profilaktyczne badanie roczne', 'zakończona'),
(2,   2, '2025-07-01 10:30', 'kontrola alergii',     'alergia sezonowa - łagodna', 'zakończona'),
(3,   1, '2025-07-02 09:00', 'szczepienie',          'szczepionka DHPPI roczna', 'zakończona'),
(4,   3, '2025-07-02 10:30', 'ortopedia',            'kontrola łapy - brak dolegliwości', 'zakończona'),
(6,   2, '2025-07-03 09:30', 'dermatologia',         'wyprysk letni  leczenie', 'zakończona'),
(7,   4, '2025-07-03 11:00', 'badanie ogólne',       'zdrowy, brak uwag', 'zakończona'),
(8,   4, '2025-07-04 09:00', 'diagnostyka',          'morfologia, biochemia krwi', 'zakończona'),
(9,   3, '2025-07-04 10:30', 'ortopedia',            'łapa w pełni sprawna', 'zakończona'),
(11,  5, '2025-07-07 09:00', 'badanie ogólne',       'brak uwag', 'zakończona'),
(12,  1, '2025-07-07 10:30', 'szczepienie',          'wścieklizna - ważność 3 lata', 'zakończona'),
(17,  1, '2025-07-08 09:00', 'kontrola',             'kontrola po kastracji - pełne wygojenie', 'zakończona'),
(18,  4, '2025-07-08 10:30', 'diagnostyka',          'badanie ogólne - brak uwag', 'zakończona'),
(19,  5, '2025-07-09 09:00', 'szczepienie',          'szczepionka roczna', 'zakończona'),
(23,  1, '2025-07-09 11:00', 'kontrola',             'kontrola po sterylizacji - zagojone', 'zakończona'),
(24,  4, '2025-07-10 09:30', 'diagnostyka',          'USG profilaktyczne', 'zakończona'),
(26,  5, '2025-07-10 11:00', 'odrobaczanie',         'odrobaczanie letnie', 'zakończona'),
(31,  5, '2025-07-14 09:00', 'badanie ogólne',       'wyniki morfologii w normie', 'zakończona'),
(32,  1, '2025-07-14 10:30', 'kontrola',             'rany wygojone całkowicie', 'zakończona'),
(33,  5, '2025-07-15 09:00', 'szczepienie',          'przypomnienie szczepień', 'zakończona'),
(38,  4, '2025-07-15 11:00', 'diagnostyka',          'wyniki krwi - brak odchyleń', 'zakończona'),
(39,  5, '2025-07-16 09:00', 'odrobaczanie',         'odrobaczanie sezonowe', 'zakończona'),
(40,  6, '2025-07-16 10:30', 'kardiologia',          'USG serca - stabilnie', 'zakończona'),
(46,  6, '2025-07-17 09:00', 'kardiologia',          'dobra reakcja na leczenie', 'zakończona'),
(49,  3, '2025-07-17 10:30', 'ortopedia',            'kontrola kości - prawidłowy zrost', 'zakończona'),
(52,  1, '2025-07-21 09:00', 'szczepienie',          'szczepionka wścieklizna, DHPPI', 'zakończona'),
(56,  4, '2025-07-21 10:30', 'diagnostyka',          'kontrola RTG - poprawa', 'zakończona'),
(62,  4, '2025-07-22 09:00', 'diagnostyka',          'wyniki stabilne', 'zakończona'),
(63,  2, '2025-07-22 10:30', 'dermatologia',         'wysypka', 'zakończona'),
(64,  5, '2025-07-23 09:00', 'szczepienie',          'odroczone szczepienie wykonane', 'zakończona'),
(65,  5, '2025-07-23 10:30', 'badanie ogólne',       'kontrola, brak uwag', 'zakończona'),
(67,  2, '2025-07-24 09:00', 'alergia',              'koniec leczenia alergii', 'zakończona'),
(69,  5, '2025-07-24 11:00', 'szczepienie',          'szczepienie pełne wykonane', 'zakończona'),
(73,  4, '2025-07-28 09:00', 'diagnostyka',          'USG kontrola - wyniki dobre', 'zakończona'),
(74,  1, '2025-07-28 10:30', 'chirurgia',            'blizna po operacji prawidłowa', 'zakończona'),
(75,  2, '2025-07-29 09:00', 'dermatologia',         'wyprysk - całkowita remisja', 'zakończona'),
(76,  5, '2025-07-29 10:30', 'badanie ogólne',       'zdrowe zwierzę, brak uwag', 'zakończona'),
(78,  6, '2025-07-30 09:00', 'kardiologia',          'kontrola, stan dobry', 'zakończona'),
 

-- SIERPIEŃ 2025 (zaplanowane - wizyty przyszłe)
(1,   5, '2025-08-04 09:00', 'badanie ogólne', 'pacjent ospały od 2 dni. Planowane podstawowe badanie kliniczne', 'zaplanowana'),
(3,   1, '2025-08-04 10:30', 'szczepienie',  'zaplanowano szczepienie przypominające przeciw chorobom zakaźnym', 'zaplanowana'),
(5,   1, '2025-08-05 09:00', 'kontrola po operacji', 'kontrola gojenia rany po zabiegu chirurgicznym', 'zaplanowana'),
(7,   4, '2025-08-05 11:00', 'diagnostyka','planowane badania laboratoryjne krwi', 'zaplanowana'),
(10,  NULL,'2025-08-06 09:30','badanie ogólne',        NULL, 'zaplanowana'),
(12,  1, '2025-08-06 11:00', 'kontrola','kontrola po wcześniejszym leczeniu dermatologicznym', 'zaplanowana'),
(14,  2, '2025-08-07 09:00', 'dermatologia',           NULL, 'zaplanowana'),
(17,  5, '2025-08-07 10:30', 'badanie ogólne',         NULL, 'zaplanowana'),
(19,  5, '2025-08-11 09:00', 'odrobaczanie',           NULL, 'zaplanowana'),
(22,  6, '2025-08-11 10:30', 'kardiologia','kontrola po wdrożeniu leczenia kardiologicznego', 'zaplanowana'),
(25,  3, '2025-08-12 09:00', 'kontrola ortopedyczna','kontrola kończyny po wcześniejszym urazie', 'zaplanowana'),
(28,  6, '2025-08-12 11:00', 'kardiologia',            NULL, 'zaplanowana'),
(30,  1, '2025-08-13 09:00', 'badanie ogólne','profilaktyczne badanie kontrolne', 'zaplanowana'),
(33,  5, '2025-08-13 10:30', 'szczepienie',            NULL, 'zaplanowana'),
(36,  4, '2025-08-14 09:00', 'diagnostyka', 'podejrzenie infekcji układu moczowego', 'zaplanowana'),
(40,  6, '2025-08-14 11:00', 'badanie serca', 'właściciel zgłasza szybkie męczenie się zwierzęcia', 'zaplanowana'),
(42,  1, '2025-08-18 09:00', 'kontrola po operacji',   NULL, 'zaplanowana'),
(45,  5, '2025-08-18 10:30', 'dieta - kontrola wagi','kontrola postępów redukcji masy ciała', 'zaplanowana'),
(46,  6, '2025-08-19 09:00', 'kardiologia',            NULL, 'zaplanowana'),
(48,  1, '2025-08-19 10:30', 'badanie ogólne','okresowa kontrola stanu zdrowia', 'zaplanowana'),
(52,  3, '2025-08-20 09:00', 'ortopedia','kontrola po wcześniejszym złamaniu', 'zaplanowana'),
(55,  5, '2025-08-20 11:00', 'badanie ogólne',         NULL, 'zaplanowana'),
(57,  5, '2025-08-21 09:30', 'odrobaczanie', 'profilaktyczne odrobaczanie', 'zaplanowana'),
(60, 3, '2025-08-21 11:00', 'ortopedia', 'ocena stawu po rehabilitacji', 'zaplanowana'),
(62, 4, '2025-08-25 09:00', 'diagnostyka', 'kontrola wyników badań laboratoryjnych', 'zaplanowana'),
(64, NULL,'2025-08-25 10:30','badanie ogólne','pacjent osowiały według właściciela', 'zaplanowana'),
(66, 1, '2025-08-26 09:00', 'chirurgia - kontrola', 'kontrola po zabiegu usunięcia zmiany skórnej', 'zaplanowana'),
(70, 6, '2025-08-26 10:30', 'kardiologia', 'kontrola leczenia farmakologicznego', 'zaplanowana'),
(73, 4, '2025-08-27 09:00', 'diagnostyka', 'planowane badanie biochemiczne krwi', 'zaplanowana'),
(74, 1, '2025-08-27 11:00', 'kontrola po operacji', 'usunięcie szwów po zabiegu', 'zaplanowana'),
(76, 5, '2025-08-28 09:00', 'szczepienie', 'szczepienie przypominające', 'zaplanowana'),
(78, 6, '2025-08-28 10:30', 'kardiologia', 'kontrola rytmu serca i ciśnienia', 'zaplanowana');
 

/*Tabela Treatments przechowuje informacje o wykonanych zabiegach podczas wizyty. Zawiera nazwę zabiegu, jego opis, notatki lekarza, czas trwania oraz koszt. Każdy zabieg jest powiązany z konkretną wizytą. */
CREATE TABLE Treatments (
    treatment_id INT IDENTITY(1,1) PRIMARY KEY,
    visit_id INT NOT NULL,
    name NVARCHAR(50) NOT NULL,
    description NVARCHAR(255) NULL, -- opis zabiegu
    notes NVARCHAR(255) NULL, -- notatki lekarza
    duration INT NOT NULL, -- czas w minutach
    cost DECIMAL(7,2) NOT NULL,

    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);

INSERT INTO Treatments (visit_id, name,description, notes, duration, cost) VALUES
(1, 'szczepienie', 'podanie szczepionki przeciw wściekliźnie','Zwierzę było spokojne. Podano szczepionkę. Brak reakcji niepożądanych. Zalecana kontrola za rok.',40,50),
(2, 'alergia', 'podanie leków na alergię', 'Wysypka zniknęła częściowo. Zalecana kontrola po tygodniu. Podano lek przeciwhistaminowy.',30,40),
(3, 'kontrola', 'kontrola stanu zdrowia','Zwierzę w dobrej kondycji. Brak uwag.',60,30),
(4, 'uraz łapy','wykonanie zdjęcia RTG łapy','Rana oczyszczona i zabandażowana. Pacjent był niespokojny, zalecano ograniczenie ruchu przez 3 dni.',90,90),
(5, 'operacja','Przeprowadzono operacje guza u chomika. Pacjent był pod narkozą. Operacja przebiegła pomyślnie. Zalecono odpoczynek i leki przeciwbólowe.',NULL, 120,150),
(7, 'diagnostyka','Standardowe badanie ogólne.',' Informacja o profilaktyce.',60,15),
(9, 'uraz łapy','Oczyszczenie i zdezynfekowanie rany. Założenie opatrunku i stabilizacja kończyny.','Uraz spowodowany niefortunnym skokiem. Rana oczyszczona i zabandażowana. Pacjent był niespokojny, zalecano ograniczenie ruchu przez 3 dni. Kontrola za tydzień.',100,110),
(10, 'badanie ogólne','Standardowe badanie kontrolne zwierzęcia.','Pacjent zdrowy. Zalecono kontrolę profilaktyczną za 6 miesięcy.', 30, 60),
(11, 'badanie ogólne','Ocena kondycji oraz parametrów życiowych.', 'Brak nieprawidłowości.',25, 50),
(12, 'szczepienie','Podanie szczepionki przeciw wściekliźnie.', 'Brak reakcji poszczepiennej.',20, 70),
(13, 'kontrola rany', 'Kontrola procesu gojenia oraz wymiana opatrunku.', 'Rana goi się prawidłowo. Zmieniono opatrunek.', 35, 80),
(14, 'kontrola ortopedyczna', 'Kontrola urazu łapy po wcześniejszym leczeniu.', 'Kulawienie minimalne. Kontynuować ograniczenie ruchu.',40, 90),
(15, 'kontrola urazu', 'Ocena procesu gojenia kończyny.', 'Stan stabilny. Opatrunek wymieniony.', 35, 85),
(16, 'kontrola pooperacyjna', 'Kontrola po zabiegu usunięcia guza.', 'Pacjent w dobrej kondycji. Rana goi się prawidłowo.', 30, 75),
(17, 'szczepienie',     'Podanie szczepionki przeciw parwowirozie i nosówce.',
                        'Zwierzę spokojne. Brak reakcji niepożądanych. Zalecane szczepienie przypominające za rok.', 30, 55),
(18, 'dermatologia',    'Ocena zmian skórnych, pobranie próbki do badania.',
                        'Alergia kontaktowa potwierdzona. Zalecono eliminację czynnika drażniącego.', 45, 80),
(19, 'ortopedia',       'Badanie i ocena urazu łapy, wykonanie RTG.',
                        'Skręcenie I stopnia. Założono stabilizator. Zalecono 5 dni ograniczonego ruchu.', 60, 120),
(20, 'chirurgia',       'Zabieg kastracji samca w znieczuleniu ogólnym.',
                        'Zabieg przebiegł bez powikłań. Szwy do usunięcia po 10 dniach.', 90, 350),
(21, 'badanie ogólne',  'Standardowe badanie fizykalne: serce, płuca, jama brzuszna, skóra.',
                        'Zwierzę w pełni zdrowe. Brak odchyleń.', 30, 60),
(22, 'szczepienie',     'Podanie szczepionki mieszanej (mix podstawowy).',
                        'Brak reakcji. Kolejne szczepienie za rok.', 25, 50),
(23, 'dermatologia',    'Ocena stanu skóry, wywiad alergiczny.',
                        'Nadwrażliwość pokarmowa - zmiana karmy na hipoalergiczną.', 50, 90),
(24, 'ortopedia',       'Ocena złamania palca, założenie szyny gipsowej.',
                        'Złamanie palca IV lewej łapy tylnej. Szyna gipsowa – kontrola za 3 tyg.', 75, 150),
(25, 'kardiologia',     'EKG spoczynkowe, osłuchiwanie serca.',
                        'Brak nieprawidłowości. Rytm zatokowy prawidłowy.', 40, 110),
(26, 'chirurgia',       'Sterylizacja samicy w znieczuleniu ogólnym.',
                        'Ovariohysterektomia bez komplikacji. Szwy do zdjęcia po 10 dniach.', 95, 400),
(27, 'diagnostyka',     'Morfologia krwi + RTG klatki piersiowej.',
                        'Wyniki morfologii w normie. RTG bez zmian patologicznych.', 60, 180),
(28, 'kontrola',        'Kontrolna wizyta po leczeniu alergii.',
                        'Znaczna poprawa po zmianie diety. Leczenie kontynuować.', 30, 40),
(29, 'odrobaczanie',    'Podanie preparatu odrobaczającego (Milbactor).',
                        'Odrobaczanie profilaktyczne. Kolejne za 6 mies.', 15, 35),
(30, 'badanie ogólne',  'Kompleksowe badanie fizykalne.',
                        'Brak uwag. Zwierzę zdrowe.', 30, 60),
(31, 'kardiologia',     'Osłuchiwanie i EKG.',
                        'Szmer sercowy II stopnia. Zalecona kontrola za miesiąc, echo serca.', 45, 130),
(32, 'dermatologia',    'Diagnostyka mykologiczna, pobranie próbek.',
                        'Grzybica potwierdzona. Wdrożono leczenie miejscowe i ogólne.', 50, 100),
(33, 'chirurgia',       'Kastracja samca, zabieg standardowy.',
                        'Przebieg prawidłowy. Szwy wchłanialne. Kontrola za tydzień.', 85, 350),
(34, 'kontrola',        'Kontrola po szczepieniu.',
                        'Brak odczynu poszczepiennego. Zwierzę zdrowe.', 20, 40),
(35, 'chirurgia',       'Oczyszczenie ran od zadrapania, dezynfekcja.',
                        'Rany powierzchowne. Oczyszczone i zabezpieczone. Monitorować przez 3 dni.', 35, 70),
(36, 'szczepienie',     'Szczepionka wielowalentna dla kotów (HCPCh).',
                        'Brak reakcji poszczepiennej. Kolejne za rok.', 25, 55),
(37, 'kardiologia',     'Kontrola szmerów sercowych, EKG i echo.',
                        'Szmer sercowy stabilny. Wdrożono leczenie farmakologiczne.', 60, 220),
(38, 'dermatologia',    'Kontrola wyprysku alergicznego.',
                        'Poprawa po kortykoterapii. Dawka redukowana.', 35, 70),
(39, 'badanie ogólne',  'Pełne badanie fizykalne.',
                        'Brak uwag. Kondycja bardzo dobra.', 30, 60),
(40, 'ortopedia',       'Ocena ruchomości i zakresu ruchu stawów.',
                        'Nieznaczna sztywność bioder. Zalecona suplementacja glukosaminy.', 45, 90),
(41, 'diagnostyka',     'Morfologia krwi z rozmazem.',
                        'Wyniki w granicach normy dla gatunku.', 30, 85),
(42, 'odrobaczanie',    'Profilaktyczne odrobaczanie (Panacur).',
                        'Bez powikłań. Kolejne za 6 mies.', 15, 35),
(43, 'kardiologia',     'USG serca (echokardiografia).',
                        'Bez zmian strukturalnych. Frakcja wyrzutowa prawidłowa.', 50, 250),
(44, 'dermatologia',    'Ocena łupieżu, wywiad pielęgnacyjny.',
                        'Łupież suchy – zalecono szampony lecznicze 2x tydz.', 40, 80),
(45, 'chirurgia',       'Usunięcie ciała obcego z żołądka (laparotomia).',
                        'Ciało obce (fragment zabawki) usunięte. Przebieg operacji bez komplikacji.', 150, 900),
(46, 'ortopedia',       'RTG + ocena złamania kości śródstopia.',
                        'Złamanie poprzeczne III kości śródstopia. Unieruchomienie opatrunkiem.', 80, 160),
(47, 'szczepienie',     'Szczepienie roczne przypominające (wścieklizna + DHPPI).',
                        'Brak odczynu. Certyfikat wystawiony.', 25, 70),
(48, 'badanie ogólne',  'Kontrola kondycji ciała, pomiar BMI.',
                        'BMI wskazuje nadwagę. Zalecona dieta redukcyjna -15%.', 35, 65),
(49, 'kardiologia',     'Wdrożenie leczenia - Atenolol + Furosemid.',
                        'Kardiomiopatia rozstrzeniowa - leczenie przewlekłe wdrożone.', 50, 200),
(50, 'dermatologia',    'Wywiad alergiczny, testy skórne.',
                        'Alergia atopowa. Identyfikacja alergenów. Immunoterapia zalecona.', 60, 150),
(51, 'chirurgia',       'Chirurgiczne usunięcie tłuszczaka.',
                        'Lipoma 3 cm usunięta pod znieczuleniem miejscowym. Szwy wchłanialne.', 60, 300),
(52, 'ortopedia',       'Kontrola po złamaniu, ocena radiologiczna.',
                        'Zrost prawidłowy. Szyna usunięta. Pełen powrót do aktywności.', 40, 90),
(53, 'kardiologia',     'Stabilizacja leczenia - kontrola EKG.',
                        'EKG wskazuje stabilizację. Dawki leków utrzymane.', 35, 110),
 
-- MAJ – nowe zakończone wizyty
(54, 'szczepienie',     'Szczepionka DHPPI, Lepto.',
                        'Brak odczynu poszczepiennego. Certyfikat wystawiony.', 25, 70),
(55, 'dermatologia',    'Badanie zmian liszajowych.',
                        'Liszaj obrączkowy. Wdrożono leczenie przeciwgrzybicze.', 45, 100),
(56, 'ortopedia',       'Kontrola po złamaniu - RTG.',
                        'Zrost kompletny. Szyna usunięta.', 35, 80),
(57, 'badanie ogólne',  'Standardowe badanie fizykalne.',
                        'Brak uwag. Zwierzę w dobrej kondycji.', 30, 60),
(58, 'diagnostyka',     'RTG klatki piersiowej.',
                        'Płuca bez zmian. Serce prawidłowej wielkości.', 40, 130),
(59, 'odrobaczanie',    'Odrobaczanie - Milbactor tabletki.',
                        'Odrobaczanie profilaktyczne zrealizowane.', 15, 35),
(60, 'chirurgia',       'Ekstrakcja zęba mlecznego.',
                        'Ząb mleczny usunięty bez powikłań. Gojenie ok. 5 dni.', 40, 200),
(61, 'dermatologia',    'Ocena zapalenia skóry, pobranie wymazu.',
                        'Bakteryjne zapalenie skóry. Antybiotyk miejscowy.', 40, 85),
(62, 'ortopedia',       'Ocena zwichnięcia stawu kolanowego.',
                        'Zwichnięcie II stopnia. Repozycja manualna. Stabilizator na 2 tyg.', 90, 300),
(63, 'kardiologia',     'Kontrola kardiologiczna.',
                        'Stan stabilny. Leczenie kontynuowane.', 35, 110),
(64, 'diagnostyka',     'Morfologia, biochemia krwi.',
                        'Wyniki w normie.', 30, 90),
(65, 'chirurgia',       'Biopsja guza skóry.',
                        'Znaczna poprawa. Leki na 7 dni.', 25, 40),
(69, 'kardiologia',     'EKG - nieznaczne odchylenia.',
                        'Nieznaczne odchylenia STT. Zalecona kontrola za 2 tyg.', 40, 120),
(70, 'diagnostyka',     'USG jamy brzusznej.',
                        'Narządy wewnętrzne bez zmian patologicznych.', 45, 180),
(71, 'chirurgia',       'Usunięcie kamieni nerkowych (urolitotomia).',
                        'Urolitotomia zakończona sukcesem. Drenaż założony na 48 h.', 180, 1200),
(72, 'dermatologia',    'Kontrola po leczeniu wyprysku.',
                        'Poprawa - zmiana leku na słabszą maść.', 30, 65),
(73, 'szczepienie',     'Szczepionka przypominająca (wścieklizna).',
                        'Certyfikat wystawiony. Ważność 3 lata.', 20, 60),
 
-- CZERWIEC
(76, 'kontrola',        'Kontrola po szczepieniu.',
                        'Brak odczynu. Stan zdrowia dobry.', 20, 40),
(77, 'dermatologia',    'Kontrola alergii kontaktowej.',
                        'Alergia wygasa. Leki odstawione.', 25, 50),
(78, 'kardiologia',     'EKG stabilne, kontrola.',
                        'Rytm zatokowy prawidłowy. Brak zmian.', 30, 100),
(79, 'kontrola',        'Kontrola rany po kastracji.',
                        'Rana zagojona całkowicie. Brak infekcji.', 20, 40),
(80, 'kardiologia',     'Ocena odpowiedzi na leczenie.',
                        'Leki działają prawidłowo. Dawki utrzymane.', 35, 110),
(81, 'badanie ogólne',  'Profilaktyczne badanie fizykalne.',
                        'Brak uwag. Kondycja bardzo dobra.', 30, 60),
(82, 'chirurgia',       'Kontrola rany po laparotomii.',
                        'Rana 80% zagojona. Zmiana opatrunku. Kontynuacja leczenia.', 25, 80),
(83, 'ortopedia',       'Ocena radiologiczna złamania.',
                        'Zrost prawidłowy. Zalecona fizjoterapia.', 40, 100),
(84, 'kardiologia',     'Stabilizacja leczenia kardiologicznego.',
                        'Stan kliniczny poprawiony. Leki zredukowane.', 35, 110),
(85, 'kontrola',        'Kontrola po lipomektomii.',
                        'Blizna prawidłowo zagojona. Brak nawrotu.', 20, 40),
(86, 'diagnostyka',     'Badanie moczu - urinaliza.',
                        'Wyniki prawidłowe. Funkcja nerek zachowana.', 30, 70),
(87, 'ortopedia',       'Zdjęcie szyny, kontrola radiologiczna.',
                        'Zrost kompletny. Pełne obciążanie możliwe.', 35, 90),
(88, 'kontrola',        'Kontrola rany po ekstrakcji zęba.',
                        'Rana zagojona. Brak infekcji.', 20, 40),
(89, 'ortopedia',       'Rehabilitacja stawu kolanowego.',
                        'Zakres ruchomości 80%. Zalecono ćwiczenia w domu.', 45, 110),
(90, 'diagnostyka',     'Kontrola wyników krwi.',
                        'Normalizacja wartości. Leczenie zakończono.', 25, 80),
(91, 'chirurgia',       'Omówienie wyniku biopsji - zmiana łagodna.',
                        'Wynik histopatologiczny: gruczolak łojowy - zmiana łagodna. Obserwacja.', 30, 60),
(92, 'ortopedia',       'Pełna ocena funkcjonalna po urazie.',
                        'Zwierzę chodzi prawidłowo. Zakończenie leczenia.', 30, 70),
(93, 'kardiologia',     'Normalizacja EKG.',
                        'Pełna normalizacja zapisu. Dawki leków zredukowane o 50%.', 35, 100),
(94, 'chirurgia',       'Kontrola blizny po operacji nerek.',
                        'Gojenie prawidłowe. Drenaż usunięty. Antybiotyk zakończony.', 30, 80),
(95, 'ortopedia',       'Usunięcie szwów z łapy.',
                        'Rana zagojona. Szwy usunięte. Zakończenie leczenia.', 20, 50),
(96, 'dermatologia',    'Kontrola alergii kontaktowej.',
                        'Całkowita remisja. Leczenie zakończone.', 25, 50),
(97, 'kardiologia',     'Szmer sercowy stabilny.',
                        'Stan niezmienny. Obserwacja kontynuowana co 3 miesiące.', 35, 100),
(98, 'dermatologia',    'Grzybica wyleczona, kontrola.',
                        'Brak zmian grzybiczych. Leczenie zakończone.', 25, 50),
(99, 'dermatologia',    'Wyprysk - remisja.',
                        'Skóra czysta. Leczenie zakończone.', 25, 50),
(100, 'ortopedia',      'Kontrola po urazie, pełne zdrowie.',
                        'Brak dolegliwości. Leczenie zakończone.', 25, 60),
(101, 'ortopedia',      'Kontrola złamania, wyniki dobre.',
                        'Zrost kompletny. Aktywność nieograniczona.', 30, 70),
(102, 'ortopedia',      'Ocena stawów - brak zmian.',
                        'Stawy sprawne. Brak konieczności interwencji.', 35, 70),
(103, 'dermatologia',   'Kontrola po leczeniu łupieżu.',
                        'Łupież ustąpił po szamponie. Kontynuować profilaktycznie.', 25, 50),
(104, 'badanie ogólne', 'Profilaktyczne badanie roczne.',
                        'Brak uwag. Wagomiar prawidłowy.', 30, 60),
(105, 'dieta',          'Kontrola wagi - postęp leczenia otyłości.',
                        'Waga -1.2 kg vs wizyta wyjściowa. Dalej dieta redukcyjna.', 25, 45),
(106, 'dermatologia',   'Kontrola po immunoterapii alergicznej.',
                        'Reakcja na alergeny zmniejszona. Kontynuować cykl.', 40, 100),
(107, 'dermatologia',   'Liszaj wyleczony.',
                        'Skóra czysta. Terapia zakończona.', 25, 50),
(108, 'badanie ogólne', 'Profilaktyczna wizyta.',
                        'Brak uwag.', 30, 60),
(109, 'odrobaczanie',   'Kontrola po odrobaczaniu.',
                        'Brak pasożytów. Kolejne odrobaczanie za 6 mies.', 15, 30),
(110, 'dermatologia',   'Zapalenie skóry wyleczone.',
                        'Skóra czysta. Leczenie zakończone.', 25, 50),
(111, 'kardiologia',    'Kontrola - leczenie kardiologiczne.',
                        'Stan stabilny. Leki kontynuowane.', 35, 100),
 
-- LIPIEC
(112, 'badanie ogólne', 'Profilaktyczne badanie roczne.',
                        'Rex w pełni zdrowy. Waga prawidłowa.', 30, 65),
(113, 'dermatologia',   'Alergia sezonowa  ocena skóry.',
                        'Lekkie podrażnienie. Maść łagodząca. Kontrola za 2 tyg.', 35, 75),
(114, 'szczepienie',    'DHPPI roczna - przypomnienie.',
                        'Brak odczynu. Certyfikat wystawiony.', 25, 65),
(115, 'ortopedia',      'Kontrola łapy, badanie RTG.',
                        'Łapa w pełni sprawna. Brak dolegliwości.', 30, 80),
(116, 'dermatologia',   'Wyprysk letni, leczenie miejscowe.',
                        'Maść kortykosteroidowa na 7 dni. Kontrola.', 40, 80),
(117, 'badanie ogólne', 'Kompleksowe badanie fizykalne.',
                        'Zdrowy. Brak uwag.', 30, 60),
(118, 'diagnostyka',    'Morfologia, biochemia - kontrola.',
                        'Wyniki bez odchyleń.', 35, 95),
(119, 'ortopedia',      'Łapa w pełni sprawna - finalne badanie.',
                        'Zakończenie leczenia. Maks w pełni zdrowy.', 25, 60),
(120, 'badanie ogólne', 'Badanie profilaktyczne.',
                        'Brak uwag.', 30, 60),
(121, 'szczepienie',    'Wścieklizna - ważność 3 lata.',
                        'Certyfikat wystawiony.', 20, 60),
(122, 'kontrola',       'Kontrola po kastracji, wygojenie pełne.',
                        'Rana zagojona całkowicie. Leczenie zakończone.', 20, 40),
(123, 'badanie ogólne', 'Kompleksowe badanie profilaktyczne.',
                        'Brak uwag.', 30, 60),
(124, 'szczepienie',    'Szczepionka roczna.',
                        'Brak odczynu. Certyfikat.', 20, 55),
(125, 'kontrola',       'Kontrola po sterylizacji.',
                        'Pełne wygojenie. Leczenie zakończone.', 20, 40),
(126, 'diagnostyka',    'USG profilaktyczne.',
                        'Narządy bez zmian.', 40, 160),
(127, 'odrobaczanie',   'Odrobaczanie letnie.',
                        'Profilaktyka zrealizowana.', 15, 35),
(128, 'badanie ogólne', 'Morfologia profilaktyczna.',
                        'Wyniki w normie.', 30, 65),
(129, 'kontrola',       'Rany po zadrapaniu – wygojone.',
                        'Brak śladów po ranie. Zakończenie leczenia.', 20, 40),
(130, 'szczepienie',    'Szczepienie przypominające.',
                        'Brak odczynu.', 20, 55),
(131, 'diagnostyka',    'Kontrola morfologii.',
                        'Wyniki stabilne. Leczenie kontynuowane.', 30, 85),
(132, 'odrobaczanie',   'Odrobaczanie sezonowe.',
                        'Bez powikłań.', 15, 35),
(133, 'kardiologia',    'USG serca - kontrola.',
                        'Stan serca stabilny.', 45, 230),
(134, 'kardiologia',    'Kontrola, dobra odpowiedź na leczenie.',
                        'Dawki leków utrzymane.', 35, 100),
(135, 'ortopedia',      'Radiologiczna ocena złamania.',
                        'Kości całkowicie zrośnięte.', 35, 90),
(136, 'szczepienie',    'Szczepienie DHPPI, wścieklizna.',
                        'Podwójne szczepienie. Certyfikat wystawiony.', 25, 90),
(137, 'diagnostyka',    'RTG kontrolne.',
                        'Stan prawidłowy.', 35, 120),
(138, 'diagnostyka',    'Kontrola wyników krwi.',
                        'Wyniki stabilne.', 30, 85),
(139, 'dermatologia',   'Wizyta po anulowaniu, kontrola skóry.',
                        'Lekkia wyprysk. Maść na 5 dni.', 35, 75),
(140, 'szczepienie',    'Odroczone szczepienie wykonane.',
                        'Brak reakcji.', 20, 55),
(141, 'badanie ogólne', 'Kompleksowe badanie.',
                        'Brak uwag.', 30, 60),
(142, 'alergia',        'Koniec leczenia alergii.',
                        'Alergia w pełnej remisji.', 25, 50),
(143, 'szczepienie',    'Pełne szczepienie sezonowe.',
                        'Certyfikat wystawiony.', 20, 55),
(144, 'diagnostyka',    'USG kontrolne.',
                        'Narządy bez zmian.', 40, 160),
(145, 'chirurgia',      'Ocena blizny po operacji nerek.',
                        'Prawidłowe gojenie. Blizna dojrzała.', 25, 70),
(146, 'dermatologia',   'Wyprysk, pełna remisja.',
                        'Skóra czysta. Leczenie zakończone.', 25, 50),
(147, 'badanie ogólne', 'Profilaktyczna wizyta.',
                        'Brak uwag.', 30, 60),
(148, 'kardiologia',    'Stan dobry, kontrola.',
                        'Leczenie kardiologiczne przynosi efekty.', 35, 100),
(149, 'szczepienie','Szczepienie wykonane prawidłowo. Brak działań niepożądanych.', 'Zalecana obserwacja przez 24h po szczepieniu.',20, 55),
(150, 'diagnostyka', 'Kontrolne badanie USG jamy brzusznej.','Wyniki prawidłowe. Brak zmian.',35, 90),
(151, 'chirurgia','Kontrola pooperacyjna i ocena blizny.','Blizna zagojona prawidłowo. Brak infekcji.',25, 80),
(152, 'dermatologia', 'Kontrola dermatologiczna po leczeniu wyprysku.', 'Całkowita remisja zmian skórnych.',30, 65),
(153, 'badanie ogólne', 'Profilaktyczne badanie fizykalne.','Stan zdrowia bardzo dobry. Brak nieprawidłowości.',20, 50),
(154, 'kardiologia', 'Kontrolne badanie kardiologiczne.', 'Stan stabilny. Parametry sercowe prawidłowe.',40, 120);


/*Tabela Prescriptions przechowuje informacje o przepisanych lekach po wykonanym zabiegu. Zawiera nazwę leku, dawkowanie, czas trwania leczenia oraz dodatkowe uwagi lekarza. Każda recepta jest powiązana z konkretnym zabiegiem. Jeden zabieg może posiadać wiele recept, dlatego w tabeli może występować wiele rekordów przypisanych do tego samego zabiegu.*/

CREATE TABLE Prescriptions (
    prescription_id INT IDENTITY(1,1) PRIMARY KEY,
    treatment_id INT NOT NULL, 
    medicine_name NVARCHAR(100) NOT NULL,
    dosage NVARCHAR(50) NOT NULL, -- dawkowanie 
    duration_days INT NOT NULL, -- na ile dni lek
    notes NVARCHAR(MAX) NULL, -- uwagi lekarza

    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

INSERT INTO Prescriptions (treatment_id, medicine_name, dosage, duration_days, notes) VALUES
(2, 'Dolvit Allergy', '2x dziennie po 1 tabletce', 7, 'Podawać po posiłku.'),

-- uraz łapy
(4, 'RemediCann', '2x dziennie', 10, 'Maść przeciwzapalna. Nanieść cienką warstwę na ranę.'),
(4, 'Meloksykam', '1x dziennie', 5, 'Środek przeciwbólowy. Podawać w razie bólu.'),

-- operacja chomika
(5, 'Antybiotyk VetCure', '2x dziennie po 0.5 ml', 7, 'Podawać po jedzeniu. Obserwować stan zwierzęcia.'),
(5, 'Meloksykam', '1x dziennie', 5, 'Podawać zgodnie z zaleceniami lekarza.'),

-- diagnostyka
(6, 'Dolfos Vetcal D3', '1x dziennie', 14, 'Witamina D. Podawać razem z jedzeniem.'),

-- uraz łapy (drugi przypadek)
(7, 'Beaphar Wound Maść', '2x dziennie', 10, 'Maść łagodzącą stosować na oczyszczoną ranę. Kontrola za tydzień.'),
(8,  'NexGard Spectra', '1x w miesiącu', 3, 'Profilaktyka pcheł i kleszczy. Podawać z jedzeniem.'),
 
-- dermatologia (treatment_id=9, Luna)
(9,  'Apoquel', '1x dziennie 5.4 mg', 14, 'Lek przeciwświądowy. Podawać rano.'),
(9,  'Malaseb szampon', '2x w tygodniu', 14, 'Myć przez 5 min, spłukać dokładnie.'),
 
-- ortopedia / uraz łapy (treatment_id=10)
(10, 'Metacam 1.5 mg/ml', '1x dziennie', 7, 'NLPZ - podawać z jedzeniem. Nie przekraczać dawki.'),
(10, 'Gabapentyna 100 mg', '2x dziennie', 5, 'Środek przeciwbólowy neuropatyczny.'),
 
-- kastracja (treatment_id=11)
(11, 'Amoksycylina VetMax', '2x dziennie', 7, 'Antybiotyk pooperacyjny. Podawać 12h między dawkami.'),
(11, 'Metacam', '1x dziennie', 5, 'Przeciwbólowe i przeciwzapalne pooperacyjne.'),
 
-- alergia pokarmowa (treatment_id=14)
(14, 'Royal Canin Hypoallergenic', 'zgodnie z wagą', 30, 'Karma eliminacyjna. Inne pokarmy wykluczone.'),
 
-- grzybica skóry (treatment_id=17)
(17, 'Itrafungol 10 mg/ml', '1x dziennie 5 mg/kg', 21, 'Lek przeciwgrzybiczy systemowy. Podawać z tłuszczem.'),
(17, 'Malaseb szampon',     '2x tyg', 21, 'Myć 5 min, spłukać. Na zmiany skórne.'),
 
-- kontrola alergii (treatment_id=19)
(19, 'Apoquel 3.6 mg', '1x dziennie', 7, 'Redukcja dawki. Kontynuacja po poprawie.'),
 
-- kardiologia – szmer sercowy (treatment_id=22)
(22, 'Vetmedin 1.25 mg', '2x dziennie', 30, 'Lek inotropowy. Podawać 1 h przed jedzeniem.'),
(22, 'Furosemid 20 mg',  '1x dziennie', 30, 'Diuretyk - obserwować ilość oddawanego moczu.'),
 
-- dermatologia łupież (treatment_id=25)
(25, 'Douxo S3 Calm szampon', '2x tyg', 28, 'Szampon kojący. Pozostawić 5 min.'),
 
-- usunięcie ciała obcego (treatment_id=26)
(26, 'Amoksycylina 250 mg', '2x dziennie', 7, 'Antybiotyk pooperacyjny.'),
(26, 'Omeprazol wet 10 mg', '1x dziennie', 14, 'Ochrona błony śluzowej żołądka po operacji.'),
(26, 'Metacam',             '1x dziennie', 5,  'Analgetyk pooperacyjny.'),
 
-- złamanie kości śródstopia (treatment_id=27)
(27, 'Metacam 1.5 mg/ml', '1x dziennie', 10, 'Lek przeciwbólowy i przeciwzapalny. Z jedzeniem.'),
 
-- kardiomiopatia – wdrożenie leczenia (treatment_id=30)
(30, 'Atenolol 25 mg',    '1x dziennie', 30, 'Beta-bloker. Podawać rano. Nie przerywać nagle.'),
(30, 'Furosemid 20 mg',   '2x dziennie', 30, 'Diuretyk. Obserwować apetyt i pragnienie.'),
(30, 'Vetmedin 2.5 mg',   '2x dziennie', 30, 'Poprawa kurczliwości mięśnia sercowego.'),
 
-- alergia atopowa (treatment_id=31)
(31, 'Apoquel 5.4 mg',    '2x dziennie', 14, 'Faza indukcji. Po 14 dniach zmniejszyć do 1x.'),
(31, 'Cytopoint 2 mg/kg', 'iniekcja 1x na 4-8 tyg', 1, 'Podana przez lekarza. Kolejna iniekcja za 4-6 tygodni.'),
 
-- lipomektomia (treatment_id=32)
(32, 'Amoksycylina 500 mg', '2x dziennie', 5, 'Profilaktyka antybiotykowa.'),
(32, 'Metacam',             '1x dziennie', 3, 'Przeciwbólowe pooperacyjne.'),
 
-- złamanie – kontrola (treatment_id=33)
-- brak recept (zrost prawidłowy, bez nowych leków)
 
-- suplementacja glukosaminy (treatment_id=35)
(35, 'Cosequin DS', '2x dziennie', 60, 'Suplementacja stawów. Podawać z pokarmem.'),
 
-- liszaj (treatment_id=36)
(36, 'Terbinafina 250 mg', '1x dziennie', 28, 'Lek przeciwgrzybiczy. Z jedzeniem.'),
(36, 'Lamisil krem 1%',    '2x dziennie', 28, 'Stosować miejscowo na zmiany.'),
 
-- kastracja (treatment_id=18)
(18, 'Amoksycylina', '2x dziennie', 7,  'Antybiotyk pooperacyjny.'),
(18, 'Metacam',      '1x dziennie', 5,  'Analgetyk pooperacyjny.'),
 
-- sterylizacja (treatment_id=20)
(20, 'Amoksycylina clavulanate', '2x dziennie', 7, 'Antybiotyk o szerokim spektrum.'),
(20, 'Meloksykam',               '1x dziennie', 5, 'Przeciwbólowe i przeciwzapalne.'),
 
-- szczepienie (treatment_id=22) – już dodane wyżej dla kardiologii
-- diagnostyka (treatment_id=21) – brak recept (wyniki w normie)
 
-- ekstrakcja zęba (treatment_id=41)
(41, 'Amoksycylina 125 mg', '2x dziennie', 5, 'Profilaktyka po ekstrakcji. Kruszyć w pokarmie.'),
(41, 'Metacam 0.5 mg/ml',   '1x dziennie', 3, 'Ból poekstrakcyjny. Zmniejszyć dawkę po 2 dniach.'),
 
-- zapalenie skóry (treatment_id=42)
(42, 'Fuciderm żel',        '2x dziennie', 10, 'Antybiotyk + kortykosteroid miejscowo.'),
 
-- zwichnięcie stawu (treatment_id=43)
(43, 'Rimadyl 50 mg',       '1x dziennie', 7,  'NLPZ. Podawać z jedzeniem.'),
(43, 'Tramadol 50 mg',      '2x dziennie', 5,  'Silniejszy analgetyk. Krótkoterminowo.'),
 
-- biopsja (treatment_id=46)
(46, 'Amoksycylina 250 mg', '2x dziennie', 5, 'Profilaktycznie po biopsji.'),
 
-- odchylenia EKG (treatment_id=50)
(50, 'Sotalol 40 mg',       '2x dziennie', 30, 'Lek antyarytmiczny. Nie przerywać nagle.'),
 
-- usunięcie kamieni nerkowych (treatment_id=52)
(52, 'Amoksycylina 500 mg', '2x dziennie', 10, 'Antybiotyk pooperacyjny.'),
(52, 'Metacam 1.5 mg/ml',   '1x dziennie', 7,  'Przeciwbólowe pooperacyjne.'),
(52, 'Urinary S/O karma',   'zgodnie z wagą', 60,'Karma mokra nerkowa. Zmniejsza ryzyko nawrotu.'),
 
-- szwy na łapie (treatment_id=55)
(55, 'Fuciderm krem',       '2x dziennie', 10, 'Na ranę po dezynfekcji. Nie lizać - kołnierz.'),
(55, 'Metacam',             '1x dziennie', 5,  'Ból po urazie.'),
 
-- leczenie kardiologiczne (treatment_id=57)
(57, 'Atenolol 12.5 mg',    '1x dziennie', 30, 'Beta-bloker, dawka startowa.'),
(57, 'Furosemid 20 mg',     '1x dziennie', 30, 'Diuretyk pętlowy.'),
 
-- dieta redukcyjna (treatment_id=49)
(49, 'Royal Canin Satiety', 'zgodnie z wagą -15%', 60, 'Karma odchudzająca. Ważyć porcje. Nie dokarmia.'),
 
-- odrobaczanie profilaktyczne – bez recept (krótkoterminowe podanie w gabinecie)
 
-- kontrola alergii po immunoterapii (treatment_id=67)
(67, 'Alergen mix iniekcja', '1x na 4 tyg', 1, 'Iniekcja immunoterapeutyczna, kolejna za 4 tyg.'),
 
-- dermatologia letnia (treatment_id=74)
(74, 'Apoquel 3.6 mg', '1x dziennie', 10, 'Kontynuacja leczenia alergii sezonowej.'),
 
-- antyarytmiczne – lipiec (treatment_id=94)
(94, 'Sotalol 40 mg',  '2x dziennie', 30, 'Kontynuacja leczenia arytmii.'),
 
-- suplementacja po ortopedii (treatment_id=76)
(76, 'Cosequin DS', '1x dziennie', 90, 'Długoterminowa suplementacja stawów.'),
 
-- kardiologia – redukcja dawki (treatment_id=94)
-- już dodane wyżej
 
-- zakończenie leczenia kardiologicznego (treatment_id=109)
(109, 'Vetmedin 1.25 mg (zmniejszona)', '1x dziennie', 30, 'Dawka zredukowana o 50%. Kontynuować.'),
(109, 'Furosemid 10 mg',                '1x dziennie', 30, 'Dawka zredukowana. Obserwować obrzęki.');


/*
-- diagnostyka integralności
SELECT COUNT(*) AS pets_count FROM Pets;
SELECT MAX(animal_id) AS max_animal_id FROM Pets;
SELECT COUNT(*) AS visits_count FROM Visits;
SELECT COUNT(*) AS treatments_count FROM Treatments;

Select * from visits

Select * from pets

Select * from treatments

Select * from prescriptions

SELECT
    v.visit_id,
    v.visit_date,
    v.reason,
    v.status,
    t.treatment_id,
    t.name AS treatment_name,
    t.cost,
	v.status
FROM Visits v
LEFT JOIN Treatments t
    ON v.visit_id = t.visit_id
WHERE v.visit_date >= '2025-05-01'
  AND v.visit_date < '2025-06-01'
ORDER BY v.visit_date;
*/

/*
select v.reason, t.name
from visits v
join treatments t on v.visit_id = t.visit_id


-- sprawdzenie czy wizyty zakończone mają rekordy w tabeli treatments
select * from visits
SELECT v.visit_id, t.treatment_id, v.animal_id
FROM Visits v
LEFT JOIN Treatments t
ON v.visit_id = t.visit_id
WHERE v.status = 'zakończona'
AND t.visit_id IS NULL;

select * from visits where visit_id = 149
select * from treatments

select distinct name 
from treatments t 
order by name;

-- zobaczenie grup nazw zabiegów wraz z iloscią
select t.name, count(*) as ilosc
from treatments t 
group by t.name


*/