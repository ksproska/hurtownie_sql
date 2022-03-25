INSERT INTO Sklepy VALUES ('1324354657', 'Wroc³aw', '56775');
INSERT INTO Sklepy VALUES ('8567348547', 'Wroc³aw', '34726');
INSERT INTO Sklepy VALUES ('8567485947', 'Wroc³aw', '94537');
--INSERT INTO Sklepy VALUES ('8567485947', 'Wroc³aw', '94537');
--INSERT INTO Sklepy([nip], [miasto], [kodPocztowy]) VALUES ('856748594a', 'Wroc³aw', '94537');
--INSERT INTO Sklepy([nip], [miasto], [kodPocztowy]) VALUES ('8567485944', 'Wroc³aw', '9 537');


INSERT INTO Klienci VALUES ('5464678865', '346296745', 'Sproska', 'Kamila');
INSERT INTO Klienci VALUES ('4564688646', '234123153', 'Fr¹cek', 'Witold');
INSERT INTO Klienci VALUES ('5643595837', '067946384', 'Soko³owska', 'Zuzanna');
--INSERT INTO Klienci([numerKartyLojalnosciowej], [numerTelefonu], [nazwisko], [imie]) VALUES ('564359587e', '848480309', 'Soko³owska', 'Zuzanna');
--INSERT INTO Klienci([numerKartyLojalnosciowej], [numerTelefonu], [nazwisko], [imie]) VALUES ('5643538387', '07946384e', 'Soko³owska', 'Zuzanna');

INSERT INTO Produkty VALUES ('564859582337', 'Mas³o', 5.32);
INSERT INTO Produkty VALUES ('563457895673', 'Ser', 6.32);
INSERT INTO Produkty VALUES ('658467594859', 'Telewizor', 3334.33);
----INSERT INTO Produkty([kodKreskowy], [nazwa], [cenaBazowa]) VALUES ('658467594859', 'Kie³basa', 34.33);
----INSERT INTO Produkty([kodKreskowy], [nazwa], [cenaBazowa]) VALUES ('939585948594', 'Kie³basa', -34.33);
----INSERT INTO Produkty([kodKreskowy], [nazwa], [cenaBazowa]) VALUES ('949505980949', 'Zegar', 3.4333);


INSERT INTO RobiZakupy ([fk_klient], [fk_sklep]) VALUES (1, 2);
INSERT INTO RobiZakupy ([fk_klient], [fk_sklep]) VALUES (2, 3);
INSERT INTO RobiZakupy VALUES ('2022-01-01 00:01:00', 1, 1);
INSERT INTO RobiZakupy ([fk_sklep]) VALUES (3);
--INSERT INTO RobiZakupy VALUES ('2025-01-01 00:01:00', 3, 3);

INSERT INTO Nabywa VALUES (2, 7.34, 1, 1);
INSERT INTO Nabywa VALUES (2.3, 7.34, 1, 2);
INSERT INTO Nabywa ([cenaNabywcza], [fk_produkty], [fk_robiZakupy]) VALUES (6.34, 2, 2);
--INSERT INTO Nabywa VALUES (3, 47.34, 1, 1);
--INSERT INTO Nabywa VALUES (3, 0.23534, 2, 1);
--INSERT INTO Nabywa VALUES (0, 47.34, 2, 1);

INSERT INTO Magazynowanie VALUES (2, 7.34, 1, 1);
INSERT INTO Magazynowanie VALUES (2, 7.34, 1, 2);

SELECT * FROM Nabywa;
SELECT * FROM RobiZakupy;
SELECT * FROM Magazynowanie;
SELECT * FROM Klienci;
SELECT * FROM Sklepy;
SELECT * FROM Produkty;
