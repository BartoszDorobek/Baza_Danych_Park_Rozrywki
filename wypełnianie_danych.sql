/*
Created: 21.11.2020
Modified: 27.11.2020
Model: Park_Rozrywki_MR
Version: 1b885c1
Database: Oracle 19c
*/


-- Create sequences section -------------------------------------------------

CREATE SEQUENCE AtrakcjaSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE SektorSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE Park_rozrywkiSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE WlascicielSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE AdresSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE KlientSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE Punkt_SprzedazySeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE PracownikSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE BiletSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE RabatSeq
 INCREMENT BY 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE WynagrodzenieSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

CREATE SEQUENCE StanowiskoSeq
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 NOMINVALUE
 CACHE 20
/

-- Create tables section -------------------------------------------------

-- Table Atrakcje

CREATE TABLE Atrakcje(
  id_atrakcji Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  producent Varchar2(30 ) NOT NULL,
  typ_atrakcji Varchar2(30 ) NOT NULL,
  opis Varchar2(400 ) NOT NULL,
  wymagania_wiekowe Integer NOT NULL,
  status Varchar2(9 ) NOT NULL
        CHECK (Status IN ('Otwarte','Zamkniete')),
  data_powstania Date NOT NULL,
  wysokosc Integer,
  predkosc Integer,
  przeciazenie Integer,
  przepustowosc Integer,
  dlugosc_trasy Integer,
  data_przegladu Date,
  waznosc_przegladu Date,
  id_sektora Integer NOT NULL
)
/

-- Create indexes for table Atrakcje

CREATE INDEX IX_Posiada_atrakcje ON Atrakcje (id_sektora)
/

-- Add keys for table Atrakcje

ALTER TABLE Atrakcje ADD CONSTRAINT Atrakcja_PK PRIMARY KEY (id_atrakcji)
/

-- Table and Columns comments section

COMMENT ON COLUMN Atrakcje.typ_atrakcji IS 'Typ atrakcji'
/
COMMENT ON COLUMN Atrakcje.opis IS 'Opis atrakcji'
/
COMMENT ON COLUMN Atrakcje.data_przegladu IS 'Data wykonania przeglądu technicznego atrakcji'
/
COMMENT ON COLUMN Atrakcje.waznosc_przegladu IS 'Data ważności przeglądu technicznego atrakcji'
/

-- Table Park_Rozrywki

CREATE TABLE Park_Rozrywki(
  id_parku_rozrywki Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  data_zalozenia Date NOT NULL,
  id_adresu Integer NOT NULL
)
/

-- Create indexes for table Park_Rozrywki

CREATE INDEX IX_Relationship3 ON Park_Rozrywki (id_adresu)
/

-- Add keys for table Park_Rozrywki

ALTER TABLE Park_Rozrywki ADD CONSTRAINT Park_rozrywki_PK PRIMARY KEY (id_parku_rozrywki)
/

-- Table Punkty_sprzedazy

CREATE TABLE Punkty_sprzedazy(
  id_punktu_sprzedazy Integer NOT NULL,
  nazwa Varchar2(20 ) NOT NULL,
  liczba_kas Integer NOT NULL,
  status Varchar2(9 ) NOT NULL
        CONSTRAINT CheckConstraintA3 CHECK (Status IN ('Otwarte','Zamkniete'))
        CHECK (Status IN ('Otwarte','Zamkniete')),
  id_parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Punkty_sprzedazy

CREATE INDEX IX_Posiada_punkt_sprzedazy ON Punkty_sprzedazy (id_parku_rozrywki)
/

-- Add keys for table Punkty_sprzedazy

ALTER TABLE Punkty_sprzedazy ADD CONSTRAINT Punkt_sprzedazy_PK PRIMARY KEY (id_punktu_sprzedazy)
/

-- Table Klienci

CREATE TABLE Klienci(
  id_klienta Integer NOT NULL,
  imie Varchar2(30 ) NOT NULL,
  nazwisko Varchar2(30 ) NOT NULL,
  email Varchar2(30 ) NOT NULL,
  nr_telefonu Varchar2(13 ) NOT NULL,
  id_parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Klienci

CREATE INDEX IX_Przyjmuje ON Klienci (id_parku_rozrywki)
/

-- Add keys for table Klienci

ALTER TABLE Klienci ADD CONSTRAINT Klient_PK PRIMARY KEY (id_klienta)
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  id_pracownika Integer NOT NULL,
  imie Varchar2(30 ) NOT NULL,
  nazwisko Varchar2(30 ) NOT NULL,
  data_urodzenia Date NOT NULL,
  PESEL Char(11 ),
  nr_telefonu Varchar2(13 ) NOT NULL,
  email Varchar2(30 ) NOT NULL,
  nr_konta_bankowego Varchar2(26 ) NOT NULL,
  data_zatrudnienia Date NOT NULL,
  data_zwolnienia Date,
  id_parku_rozrywki Integer NOT NULL,
  id_adresu Integer NOT NULL,
  id_stanowiska Integer NOT NULL
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_Zatrudnia ON Pracownicy (id_parku_rozrywki)
/

CREATE INDEX IX_Relationship6 ON Pracownicy (id_adresu)
/

CREATE INDEX IX_Relationship9 ON Pracownicy (id_stanowiska)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_PK PRIMARY KEY (id_pracownika)
/

-- Table Bilety

CREATE TABLE Bilety(
  id_biletu Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  czy_rabat Char(1 ) NOT NULL,
  cena Number(10,2) NOT NULL,
  id_punktu_sprzedazy Integer NOT NULL,
  id_rabatu Integer
)
/

-- Create indexes for table Bilety

CREATE INDEX IX_Sprzedaje ON Bilety (id_punktu_sprzedazy)
/

CREATE INDEX IX_Relationship2b ON Bilety (id_rabatu)
/

-- Add keys for table Bilety

ALTER TABLE Bilety ADD CONSTRAINT Bilet_PK PRIMARY KEY (id_biletu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Bilety.czy_rabat IS 'Czy przysługuje rabat (Boolean)'
/

-- Table Sektory

CREATE TABLE Sektory(
  id_sektora Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  data_zalozenia Date NOT NULL,
  status Varchar2(9 ) NOT NULL
        CONSTRAINT CheckConstraintA1 CHECK (Status IN ('Otwarte','Zamkniete'))
        CHECK (Status IN ('Otwarte','Zamkniete')),
  opis Varchar2(400 ),
  id_parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Sektory

CREATE INDEX IX_Posiada_sektory ON Sektory (id_parku_rozrywki)
/

-- Add keys for table Sektory

ALTER TABLE Sektory ADD CONSTRAINT Sektor_PK PRIMARY KEY (id_sektora)
/

-- Table and Columns comments section

COMMENT ON COLUMN Sektory.opis IS 'Opis sektora'
/

-- Table Punkty_sprzedazy_Pracownicy

CREATE TABLE Punkty_sprzedazy_Pracownicy(
  id_punktu_sprzedazy Integer NOT NULL,
  id_pracownika Integer NOT NULL
)
/

-- Table Pracownicy_Atrakcje

CREATE TABLE Pracownicy_Atrakcje(
  id_pracownika Integer NOT NULL,
  id_atrakcji Integer NOT NULL
)
/

-- Table Bilety_Sektory

CREATE TABLE Bilety_Sektory(
  id_biletu Integer NOT NULL,
  id_sektora Integer NOT NULL
)
/

-- Table Rabaty

CREATE TABLE Rabaty(
  id_rabatu Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  wartosc Integer NOT NULL
)
/

-- Add keys for table Rabaty

ALTER TABLE Rabaty ADD CONSTRAINT PK_Rabaty PRIMARY KEY (id_rabatu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Rabaty.id_rabatu IS 'Unikatowy identyfikator rabatu'
/
COMMENT ON COLUMN Rabaty.nazwa IS 'Nazwa rabatu'
/
COMMENT ON COLUMN Rabaty.wartosc IS 'ile % rabatu'
/

-- Table Adresy

CREATE TABLE Adresy(
  id_adresu Integer NOT NULL,
  miasto Varchar2(30 ) NOT NULL,
  Ulica Varchar2(30 ) NOT NULL,
  nr_lokalu Varchar2(30 ) NOT NULL,
  kod_poczty Char(6 ) NOT NULL
)
/

-- Add keys for table Adresy

ALTER TABLE Adresy ADD CONSTRAINT PK_Adresy PRIMARY KEY (id_adresu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Adresy.id_adresu IS 'Unikatowy identyfikator adresu'
/
COMMENT ON COLUMN Adresy.miasto IS 'Miasto'
/
COMMENT ON COLUMN Adresy.Ulica IS 'Ulica'
/
COMMENT ON COLUMN Adresy.nr_lokalu IS 'Numer lokalu'
/
COMMENT ON COLUMN Adresy.kod_poczty IS 'Kod pocztowy'
/

-- Table Wlasciciele

CREATE TABLE Wlasciciele(
  id_wlasciciela Integer NOT NULL,
  imie Varchar2(30 ) NOT NULL,
  nazwisko Varchar2(30 ) NOT NULL,
  id_adresu Integer NOT NULL,
  id_parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Wlasciciele

CREATE INDEX IX_Relationship4 ON Wlasciciele (id_adresu)
/

CREATE INDEX IX_Relationship5 ON Wlasciciele (id_parku_rozrywki)
/

-- Add keys for table Wlasciciele

ALTER TABLE Wlasciciele ADD CONSTRAINT PK_Wlasciciele PRIMARY KEY (id_wlasciciela)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wlasciciele.id_wlasciciela IS 'Unikatowy identyfikatow właściciela'
/

-- Table Stanowiska

CREATE TABLE Stanowiska(
  id_stanowiska Integer NOT NULL,
  nazwa Varchar2(30 ) NOT NULL,
  opis Varchar2(400 ) NOT NULL
)
/

-- Add keys for table Stanowiska

ALTER TABLE Stanowiska ADD CONSTRAINT PK_Stanowiska PRIMARY KEY (id_stanowiska)
/

ALTER TABLE Stanowiska ADD CONSTRAINT Nazwa UNIQUE (nazwa)
/

-- Table and Columns comments section

COMMENT ON COLUMN Stanowiska.id_stanowiska IS 'Unikatowy identyfikator stanowiska'
/
COMMENT ON COLUMN Stanowiska.nazwa IS 'Nazwa stanowiska'
/
COMMENT ON COLUMN Stanowiska.opis IS 'Opis stanowiska'
/

-- Table Wynagrodzenia

CREATE TABLE Wynagrodzenia(
  id_wynagrodzenia Integer NOT NULL,
  data_wynagrodzenia Date NOT NULL,
  kwota_pod Number(8,2) NOT NULL,
  kwota_dod Number(8,2),
  id_pracownika Integer NOT NULL
)
/

-- Create indexes for table Wynagrodzenia

CREATE INDEX IX_Relationship10 ON Wynagrodzenia (id_pracownika)
/

-- Add keys for table Wynagrodzenia

ALTER TABLE Wynagrodzenia ADD CONSTRAINT PK_Wynagrodzenia PRIMARY KEY (id_wynagrodzenia)
/

-- Table and Columns comments section

COMMENT ON COLUMN Wynagrodzenia.id_wynagrodzenia IS 'Unikatowy identyfikator wynagrodzenia'
/
COMMENT ON COLUMN Wynagrodzenia.data_wynagrodzenia IS 'Data wypłaty wynagrodzenia'
/
COMMENT ON COLUMN Wynagrodzenia.kwota_pod IS 'Kwota podstawowa'
/
COMMENT ON COLUMN Wynagrodzenia.kwota_dod IS 'Kwota dodatkowa'
/

-- Table Jezyki

CREATE TABLE Jezyki(
  id_jezyka Integer NOT NULL,
  kod_jezyka Char(2 ) NOT NULL,
  nazwa Varchar2(20 ) NOT NULL
)
/

-- Add keys for table Jezyki

ALTER TABLE Jezyki ADD CONSTRAINT PK_Jezyki PRIMARY KEY (id_jezyka)
/

ALTER TABLE Jezyki ADD CONSTRAINT kod_jezyka UNIQUE (kod_jezyka)
/

-- Table and Columns comments section

COMMENT ON COLUMN Jezyki.id_jezyka IS 'Unikatowy identyfikator języka'
/
COMMENT ON COLUMN Jezyki.kod_jezyka IS 'Kod języka zgodnie ze standardem ISO'
/
COMMENT ON COLUMN Jezyki.nazwa IS 'Nazwa języka'
/

-- Table znajomosc_jezykow

CREATE TABLE znajomosc_jezykow(
  id_pracownika Integer NOT NULL,
  id_jezyka Integer NOT NULL,
  id_poziomu_jezyka Integer NOT NULL
)
/

-- Create indexes for table znajomosc_jezykow

CREATE INDEX IX_Relationship2 ON znajomosc_jezykow (id_poziomu_jezyka)
/

-- Add keys for table znajomosc_jezykow

ALTER TABLE znajomosc_jezykow ADD CONSTRAINT PK_znajomosc_jezykow PRIMARY KEY (id_pracownika,id_jezyka)
/

-- Table Poziomy_jezykow

CREATE TABLE Poziomy_jezykow(
  id_poziomu_jezyka Integer NOT NULL,
  kod_poziomu Char(2 ) NOT NULL,
  Opis Varchar2(800 ) NOT NULL
)
/

-- Add keys for table Poziomy_jezykow

ALTER TABLE Poziomy_jezykow ADD CONSTRAINT PK_Poziomy_jezykow PRIMARY KEY (id_poziomu_jezyka)
/

ALTER TABLE Poziomy_jezykow ADD CONSTRAINT kod_poziomu UNIQUE (kod_poziomu)
/

-- Table and Columns comments section

COMMENT ON COLUMN Poziomy_jezykow.id_poziomu_jezyka IS 'Unikatowy identyfikatow języka'
/
COMMENT ON COLUMN Poziomy_jezykow.kod_poziomu IS 'Kod poziomu'
/
COMMENT ON COLUMN Poziomy_jezykow.Opis IS 'Opis wymagań'
/

-- Table Bilety_klienta

CREATE TABLE Bilety_klienta(
  id_biletu Integer NOT NULL,
  id_klienta Integer NOT NULL,
  data_zakupu Date NOT NULL,
  data_aktywacji Date NOT NULL,
  data_waznosci Date NOT NULL
)
/

-- Add keys for table Bilety_klienta

ALTER TABLE Bilety_klienta ADD CONSTRAINT PK_Bilety_klienta PRIMARY KEY (id_biletu,id_klienta)
/

-- Table and Columns comments section

COMMENT ON COLUMN Bilety_klienta.data_zakupu IS 'Data i godzina zakupu biletu'
/
COMMENT ON COLUMN Bilety_klienta.data_aktywacji IS 'Data i godzina, o której bilet się aktywuje'
/
COMMENT ON COLUMN Bilety_klienta.data_waznosci IS 'Data i godzina, o której bilet traci ważność'
/

-- Table Pracownicy_Sektory

CREATE TABLE Pracownicy_Sektory(
  id_pracownika Integer NOT NULL,
  id_sektora Integer NOT NULL
)
/

-- Add keys for table Pracownicy_Sektory

ALTER TABLE Pracownicy_Sektory ADD CONSTRAINT PK_Pracownicy_Sektory PRIMARY KEY (id_pracownika,id_sektora)
/

-- Trigger for sequence AtrakcjaSeq for column id_atrakcji in table Atrakcje ---------
CREATE OR REPLACE TRIGGER ts_Atrakcje_AtrakcjaSeq BEFORE INSERT
ON Atrakcje FOR EACH ROW
BEGIN
  :new.id_atrakcji := AtrakcjaSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Atrakcje_AtrakcjaSeq AFTER UPDATE OF id_atrakcji
ON Atrakcje FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_atrakcji in table Atrakcje as it uses sequence.');
END;
/

-- Trigger for sequence Park_rozrywkiSeq for column id_parku_rozrywki in table Park_Rozrywki ---------
CREATE OR REPLACE TRIGGER ts_Park_Rozrywki_Park_rozrywkiSeq BEFORE INSERT
ON Park_Rozrywki FOR EACH ROW
BEGIN
  :new.id_parku_rozrywki := Park_rozrywkiSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Park_Rozrywki_Park_rozrywkiSeq AFTER UPDATE OF id_parku_rozrywki
ON Park_Rozrywki FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_parku_rozrywki in table Park_Rozrywki as it uses sequence.');
END;
/

-- Trigger for sequence Punkt_SprzedazySeq for column id_punktu_sprzedazy in table Punkty_sprzedazy ---------
CREATE OR REPLACE TRIGGER ts_Punkty_sprzedazy_Punkt_SprzedazySeq BEFORE INSERT
ON Punkty_sprzedazy FOR EACH ROW
BEGIN
  :new.id_punktu_sprzedazy := Punkt_SprzedazySeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Punkty_sprzedazy_Punkt_SprzedazySeq AFTER UPDATE OF id_punktu_sprzedazy
ON Punkty_sprzedazy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_punktu_sprzedazy in table Punkty_sprzedazy as it uses sequence.');
END;
/

-- Trigger for sequence KlientSeq for column id_klienta in table Klienci ---------
CREATE OR REPLACE TRIGGER ts_Klienci_KlientSeq BEFORE INSERT
ON Klienci FOR EACH ROW
BEGIN
  :new.id_klienta := KlientSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Klienci_KlientSeq AFTER UPDATE OF id_klienta
ON Klienci FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_klienta in table Klienci as it uses sequence.');
END;
/

-- Trigger for sequence PracownikSeq for column id_pracownika in table Pracownicy ---------
CREATE OR REPLACE TRIGGER ts_Pracownicy_PracownikSeq BEFORE INSERT
ON Pracownicy FOR EACH ROW
BEGIN
  :new.id_pracownika := PracownikSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Pracownicy_PracownikSeq AFTER UPDATE OF id_pracownika
ON Pracownicy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_pracownika in table Pracownicy as it uses sequence.');
END;
/

-- Trigger for sequence BiletSeq for column id_biletu in table Bilety ---------
CREATE OR REPLACE TRIGGER ts_Bilety_BiletSeq BEFORE INSERT
ON Bilety FOR EACH ROW
BEGIN
  :new.id_biletu := BiletSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Bilety_BiletSeq AFTER UPDATE OF id_biletu
ON Bilety FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_biletu in table Bilety as it uses sequence.');
END;
/

-- Trigger for sequence SektorSeq for column id_sektora in table Sektory ---------
CREATE OR REPLACE TRIGGER ts_Sektory_SektorSeq BEFORE INSERT
ON Sektory FOR EACH ROW
BEGIN
  :new.id_sektora := SektorSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Sektory_SektorSeq AFTER UPDATE OF id_sektora
ON Sektory FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_sektora in table Sektory as it uses sequence.');
END;
/

-- Trigger for sequence RabatSeq for column id_rabatu in table Rabaty ---------
CREATE OR REPLACE TRIGGER ts_Rabaty_RabatSeq BEFORE INSERT
ON Rabaty FOR EACH ROW
BEGIN
  :new.id_rabatu := RabatSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Rabaty_RabatSeq AFTER UPDATE OF id_rabatu
ON Rabaty FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_rabatu in table Rabaty as it uses sequence.');
END;
/

-- Trigger for sequence AdresSeq for column id_adresu in table Adresy ---------
CREATE OR REPLACE TRIGGER ts_Adresy_AdresSeq BEFORE INSERT
ON Adresy FOR EACH ROW
BEGIN
  :new.id_adresu := AdresSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Adresy_AdresSeq AFTER UPDATE OF id_adresu
ON Adresy FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_adresu in table Adresy as it uses sequence.');
END;
/

-- Trigger for sequence WlascicielSeq for column id_wlasciciela in table Wlasciciele ---------
CREATE OR REPLACE TRIGGER ts_Wlasciciele_WlascicielSeq BEFORE INSERT
ON Wlasciciele FOR EACH ROW
BEGIN
  :new.id_wlasciciela := WlascicielSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wlasciciele_WlascicielSeq AFTER UPDATE OF id_wlasciciela
ON Wlasciciele FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_wlasciciela in table Wlasciciele as it uses sequence.');
END;
/

-- Trigger for sequence StanowiskoSeq for column id_stanowiska in table Stanowiska ---------
CREATE OR REPLACE TRIGGER ts_Stanowiska_StanowiskoSeq BEFORE INSERT
ON Stanowiska FOR EACH ROW
BEGIN
  :new.id_stanowiska := StanowiskoSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Stanowiska_StanowiskoSeq AFTER UPDATE OF id_stanowiska
ON Stanowiska FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_stanowiska in table Stanowiska as it uses sequence.');
END;
/

-- Trigger for sequence WynagrodzenieSeq for column id_wynagrodzenia in table Wynagrodzenia ---------
CREATE OR REPLACE TRIGGER ts_Wynagrodzenia_WynagrodzenieSeq BEFORE INSERT
ON Wynagrodzenia FOR EACH ROW
BEGIN
  :new.id_wynagrodzenia := WynagrodzenieSeq.nextval;
END;
/
CREATE OR REPLACE TRIGGER tsu_Wynagrodzenia_WynagrodzenieSeq AFTER UPDATE OF id_wynagrodzenia
ON Wynagrodzenia FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20010,'Cannot update column id_wynagrodzenia in table Wynagrodzenia as it uses sequence.');
END;
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Pracownicy ADD CONSTRAINT Zatrudnia FOREIGN KEY (id_parku_rozrywki) REFERENCES Park_Rozrywki (id_parku_rozrywki)
/



ALTER TABLE Bilety ADD CONSTRAINT Sprzedaje FOREIGN KEY (id_punktu_sprzedazy) REFERENCES Punkty_sprzedazy (id_punktu_sprzedazy)
/



ALTER TABLE Sektory ADD CONSTRAINT Posiada_sektory FOREIGN KEY (id_parku_rozrywki) REFERENCES Park_Rozrywki (id_parku_rozrywki)
/



ALTER TABLE Atrakcje ADD CONSTRAINT Posiada_atrakcje FOREIGN KEY (id_sektora) REFERENCES Sektory (id_sektora)
/



ALTER TABLE Klienci ADD CONSTRAINT Przyjmuje FOREIGN KEY (id_parku_rozrywki) REFERENCES Park_Rozrywki (id_parku_rozrywki)
/



ALTER TABLE Punkty_sprzedazy ADD CONSTRAINT Posiada_punkt_sprzedazy FOREIGN KEY (id_parku_rozrywki) REFERENCES Park_Rozrywki (id_parku_rozrywki)
/



ALTER TABLE Bilety ADD CONSTRAINT Posiada_rabat FOREIGN KEY (id_rabatu) REFERENCES Rabaty (id_rabatu)
/



ALTER TABLE Park_Rozrywki ADD CONSTRAINT Park_ma_adres FOREIGN KEY (id_adresu) REFERENCES Adresy (id_adresu)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Wlasciciel_ma_adres FOREIGN KEY (id_adresu) REFERENCES Adresy (id_adresu)
/



ALTER TABLE Wlasciciele ADD CONSTRAINT Park_ma_wlasciciela FOREIGN KEY (id_parku_rozrywki) REFERENCES Park_Rozrywki (id_parku_rozrywki)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_ma_adres FOREIGN KEY (id_adresu) REFERENCES Adresy (id_adresu)
/



ALTER TABLE Pracownicy ADD CONSTRAINT Pracownik_ma_stanowisko FOREIGN KEY (id_stanowiska) REFERENCES Stanowiska (id_stanowiska)
/



ALTER TABLE Wynagrodzenia ADD CONSTRAINT Otrzymuje_wynagrodzenie FOREIGN KEY (id_pracownika) REFERENCES Pracownicy (id_pracownika)
/



ALTER TABLE znajomosc_jezykow ADD CONSTRAINT Pracownik_zna_jezyk FOREIGN KEY (id_pracownika) REFERENCES Pracownicy (id_pracownika)
/



ALTER TABLE znajomosc_jezykow ADD CONSTRAINT Jezyk_jest_znany FOREIGN KEY (id_jezyka) REFERENCES Jezyki (id_jezyka)
/



ALTER TABLE Bilety_klienta ADD CONSTRAINT Jest_kupowany FOREIGN KEY (id_biletu) REFERENCES Bilety (id_biletu)
/



ALTER TABLE Bilety_klienta ADD CONSTRAINT Kupuje FOREIGN KEY (id_klienta) REFERENCES Klienci (id_klienta)
/



ALTER TABLE Pracownicy_Sektory ADD CONSTRAINT Pracuje_w_sektorze_Pracownik FOREIGN KEY (id_pracownika) REFERENCES Pracownicy (id_pracownika)
/



ALTER TABLE Pracownicy_Sektory ADD CONSTRAINT Pracuje_w_sektorze_Sektor FOREIGN KEY (id_sektora) REFERENCES Sektory (id_sektora)
/



ALTER TABLE znajomosc_jezykow ADD CONSTRAINT Jezyk_jest_znany_na_poziomie FOREIGN KEY (id_poziomu_jezyka) REFERENCES Poziomy_jezykow (id_poziomu_jezyka)
/





