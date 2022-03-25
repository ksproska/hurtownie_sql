DROP TABLE Nabywa;
DROP TABLE RobiZakupy;
DROP TABLE Magazynowanie;
DROP TABLE Klienci;
DROP TABLE Sklepy;
DROP TABLE Produkty;

CREATE TABLE Klienci (
	id INT NOT NULL IDENTITY,
	numerKartyLojalnosciowej CHAR(10) NOT NULL CONSTRAINT UNQ_Klienci_numerKartyLojalnoscowej UNIQUE,
	numerTelefonu CHAR(9) NOT NULL CONSTRAINT UNQ_Klienci_numerTelefonu UNIQUE,
	nazwisko VARCHAR(50) NOT NULL,
	imie VARCHAR(50) NOT NULL,

	PRIMARY KEY (id),
	CONSTRAINT CHK_Klienci_nazwisko CHECK(len(nazwisko) != 0),
	CONSTRAINT CHK_Klienci_imie CHECK(len(imie) != 0),
	CONSTRAINT CHK_Klienci_numerKartyLojalnoscowej CHECK(ISNUMERIC(numerKartyLojalnosciowej) != 0),
	CONSTRAINT CHK_Klienci_numerTelefonu CHECK(ISNUMERIC(numerTelefonu) != 0),
);

CREATE TABLE Sklepy (
	id INT NOT NULL IDENTITY,
	nip CHAR(10) NOT NULL CONSTRAINT UNQ_Sklepy_nip UNIQUE,
	miasto VARCHAR(50) NOT NULL,
	kodPocztowy CHAR(5) NOT NULL,

	PRIMARY KEY (id),
	CONSTRAINT CHK_Sklepy_miasto CHECK(len(miasto) != 0),
	CONSTRAINT CHK_Sklepy_nip CHECK(ISNUMERIC(nip) != 0),
	CONSTRAINT CHK_Sklepy_kodPocztowy CHECK(ISNUMERIC(kodPocztowy) != 0)
);

CREATE TABLE Produkty (
	id INT NOT NULL IDENTITY,
	kodKreskowy CHAR(13) NOT NULL CONSTRAINT UNQ_Produkty UNIQUE,
	nazwa VARCHAR(100) NOT NULL,
	cenaBazowa FLOAT NOT NULL,

	PRIMARY KEY (id),
	CONSTRAINT CHK_Produkty_cenaBazowa CHECK (cenaBazowa > 0 AND ROUND(cenaBazowa, 2) = cenaBazowa),
	CONSTRAINT CHK_Sklepy_kodKreskowy CHECK(ISNUMERIC(kodKreskowy) != 0)
);

CREATE TABLE RobiZakupy (
	id INT NOT NULL IDENTITY,
	zakupyTimestamp SMALLDATETIME NOT NULL CONSTRAINT DEF_RobiZakupy_zakupyTimestamp DEFAULT CURRENT_TIMESTAMP,
	fk_klient INT,
	fk_sklep INT NOT NULL,

	CONSTRAINT CHK_RobiZakupy_zakupyTimestamp CHECK(zakupyTimestamp <= CURRENT_TIMESTAMP),

	PRIMARY KEY (id),
	FOREIGN KEY (fk_klient) REFERENCES Klienci(id),
	FOREIGN KEY (fk_sklep) REFERENCES Sklepy(id),
);

CREATE TABLE Nabywa (
	id INT NOT NULL IDENTITY,
	ilosc FLOAT	NOT NULL CONSTRAINT DEF_Nabywa_ilosc DEFAULT 1,
	cenaNabywcza FLOAT NOT NULL,
	fk_produkty INT NOT NULL,
	fk_robiZakupy INT NOT NULL,

	CONSTRAINT CHK_Nabywa_ilosc CHECK(Ilosc > 0),
	CONSTRAINT CHK_Nabywa_cenaNabywcza CHECK(cenaNabywcza > 0 AND ROUND(cenaNabywcza, 2) = cenaNabywcza),
	CONSTRAINT UNQ_Nabywa_Produkty_RobiZakupy UNIQUE(fk_produkty, fk_robiZakupy),
	
	PRIMARY KEY (id),
	FOREIGN KEY (fk_robiZakupy) REFERENCES RobiZakupy(id),
	FOREIGN KEY (fk_produkty) REFERENCES Produkty(id)	
);

CREATE TABLE Magazynowanie (
	id INT NOT NULL IDENTITY,
	ilosc FLOAT NOT NULL,
	cenaSklepowa FLOAT NOT NULL,
	fk_sklep INT NOT NULL,
	fk_produkt INT NOT NULL,

	CONSTRAINT CHK_Magazynowanie_ilosc CHECK (ilosc > 0),
	CONSTRAINT CHK_Magazynowanie_cena CHECK (cenaSklepowa > 0 AND ROUND(cenaSklepowa, 2) = cenaSklepowa),
	CONSTRAINT UNQ_Magazynowanie_Produkty_Sklepy UNIQUE(fk_produkt, fk_sklep),
	
	PRIMARY KEY (id),
	FOREIGN KEY (fk_sklep) REFERENCES Sklepy(id),
	FOREIGN KEY (fk_produkt) REFERENCES Produkty(id)	
);
