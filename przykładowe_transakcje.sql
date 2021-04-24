--- liczba sprzedanych biletów ---
SELECT SUM(CENA) AS Suma_cen_Biletów, COUNT(ID_BILETU)
 AS Liczba_biletów FROM BILETY;
--- Wynagrodzenie dla Administracji---
SELECT IMIE, NAZWISKO, NR_KONTA_BANKOWEGO, Kwota_pod, Kwota_dod, Data_wynagrodzenia
 FROM PRACOWNICY NATURAL JOIN Wynagrodzenia;
---Liczba klientów---
SELECT COUNT(id_klienta) AS LICZBA_KLIENTOW FROM KLIENCI;

--- Modyfikacja rabatu---
UPDATE Rabaty SET wartosc=30 WHERE id_rabatu=1;

--- Modyfikacja statusu atrakcji ---
update atrakcje
  set status = case
                  when status = 'Otwarte' then 'Zamkniete'
                  else 'Otwarte'
                 end
where id_atrakcji=1;