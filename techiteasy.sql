-- Database: TechItEasy

-- DROP DATABASE IF EXISTS "TechItEasy";

CREATE DATABASE "TechItEasy"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'nl_NL.UTF-8'
    LC_CTYPE = 'nl_NL.UTF-8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE "TechItEasy"
    IS 'huiswerkopdracht bij les 8: een database voor de tv-winkel';
	
-- =================
-- create tables
-- User details table
CREATE TABLE Person
(
	userID SERIAL PRIMARY KEY,
	username VARCHAR(100) not null Unique,
	secret VARCHAR(100) not null Unique
);

-- Product table (parent, from Java abstract class)
CREATE TABLE Product
(
	productID SERIAL PRIMARY KEY,
	productName VARCHAR(100) not null,
	brand VARCHAR(100) not null,
	price DECIMAL(10,2),
	currentStock INT,
	sold INT
);

--Television table
CREATE TABLE Television
(
	tvID SERIAL PRIMARY KEY,
	screentype VARCHAR(100),
	refreshRate VARCHAR(100),
	productID INT
);

--Remote Controller table
CREATE TABLE RemoteController
(
	remoteID SERIAL PRIMARY KEY,
	batterytype VARCHAR(100),
	compatibleWith INT,
	productID INT
);

--CI Module table
CREATE TABLE CIModule
(
	ciModuleID SERIAL PRIMARY KEY,
	productID INT
);

--Wallbracket table
CREATE TABLE WallBracket
(
	wallBracketID SERIAL PRIMARY KEY,
	adjustable BOOLEAN,
	productID INT
);

-- ============
--set foreign keys for TV, Remote, CIM and Wallbracket

--set foreign key in TV table relating it to the generic product table
ALTER TABLE Television
ADD CONSTRAINT FK_Television_Product
FOREIGN KEY(productID) REFERENCES Product(productID);

--set foreign key in RemoteController table relating to its compatible tv
ALTER TABLE RemoteController
ADD CONSTRAINT FK_Remote_Tv
FOREIGN KEY(CompatibleWith) REFERENCES Television(tvID);

--set foreign key in Remote relating it to the generic product table
ALTER TABLE RemoteController
ADD CONSTRAINT FK_Remote_Product
FOREIGN KEY(productID) REFERENCES Product(productID);

--set foreign key in CIModule table relating it to the generic product table
ALTER TABLE CIModule
ADD CONSTRAINT FK_CIModule_Product
FOREIGN KEY(productID) REFERENCES Product(productID);

--set foreign key in Wallbracket table relating it to the generic product table
ALTER TABLE Wallbracket
ADD CONSTRAINT FK_Wallbracket_Product
FOREIGN KEY(productID) REFERENCES Product(productID);

-- ===================
-- creating users  
INSERT into Person (userID,userName,secret) values (DEFAULT, 'hella','ikneemklaterdezeheletentover!MUHAHA!');
INSERT into Person (userID,userName,secret) values (DEFAULT, 'paulus','deboskabouter');
INSERT into Person (userID,userName,secret) values (DEFAULT, 'robin','kondenwenuechtgeenbeteredeveloperkrijgen??');
INSERT into Person (userID,userName,secret) values (DEFAULT, 'admin','admin_lekker_veilig');
INSERT into Person (userID,userName,secret) values (DEFAULT, 'stagiair','Zomer2024datradenzenooit!');

--create some products
--start with 3 tv's
INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'Ambillight Ultra','PH1000023','Philips',900.00,5,12);
INSERT into Television (tvID, screentype, refreshrate, productID) values (default, 'OLED', '80 Hz', 1);

INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'Bravia OLED XR','XR-55A95LAEP (2023) ','Sony',3299.99,20,0);
INSERT into Television (tvID, screentype, refreshrate, productID) values (default, 'QD OLED', '100 Hz', 2);

INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'OLED S95 serie','QD OLED 65S95C (2023)','Samsung',2500.00,10,3);
INSERT into Television (tvID, screentype, refreshrate, productID) values (default, 'HYPER LED', '120 Hz', 3);

-- create remote controllers
INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'Ambillight Ultra remote','PH1000023R','Philips',30.00,2,0);
INSERT into RemoteController(remoteID, batterytype, compatibleWith, productID) values (default, '2xAA', 1, 1);

INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'Bravia series remote','XR-55A95B','Sony',49.00,2,0);
INSERT into RemoteController(remoteID, batterytype, compatibleWith, productID) values (default, '3xAA', 2, 2);

INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'S95series remote','65S95C-B','Samsung',37.50,2,1);
INSERT into RemoteController(remoteID, batterytype, compatibleWith, productID) values (default, '4xCR2032', 3, 3);

--create CIModule
INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT, 'Quantis CI+ 1.3 Interactieve Module','130004 ','Quantis',69.95,10,3);
INSERT into CIModule (ciModuleID,productID) values (DEFAULT, 7);

--create Wallbracket
INSERT into Product (productID,productName,factoryID,brand,price,currentStock,sold) values (DEFAULT,'StrongArm 2000','mn93490','Muurvast',48.80,5,1);
INSERT into WallBracket (wallBracketID,adjustable,productID) values (DEFAULT,true, 8);
