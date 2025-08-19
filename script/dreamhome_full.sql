-- Script para crear las tablas de la base de datos 
-- dreamhome de una empresa de bienes raices
--- 

DROP TABLE IF EXISTS branch CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS privateowner CASCADE;
DROP TABLE IF EXISTS propertyforrent CASCADE;
DROP TABLE IF EXISTS registration CASCADE;
DROP TABLE IF EXISTS viewing CASCADE;


CREATE TABLE branch (
  branchNo CHAR(4) NOT NULL,
  street VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  postcode CHAR(8) DEFAULT NULL,
    CONSTRAINT branch_pk PRIMARY KEY(branchNo)
);

CREATE TABLE  staff  (
   staffNo  CHAR(4) NOT NULL,
   fName  VARCHAR(15) NOT NULL,
   lName  VARCHAR(15) NOT NULL,
   position  VARCHAR(15) NOT NULL,
   sex  CHAR(1) NOT NULL CHECK( sex = 'm' OR  sex = 'M' OR  sex = 'f' OR  sex = 'F') ,
   dob  DATE NOT NULL,
   salary  NUMERIC(8,2) NOT NULL CHECK(salary > 800),
   branchNo  CHAR(4) NOT NULL,
    CONSTRAINT staff_pk PRIMARY KEY(staffNo),
    CONSTRAINT branch_staff_fk FOREIGN KEY (branchNo)
        REFERENCES branch (branchNo)
        ON UPDATE CASCADE 
        ON DELETE SET NULL
);

CREATE TABLE client (
  clientNo  CHAR(4) NOT NULL,
  fName  VARCHAR(15) NOT NULL,
  lName  VARCHAR(15) NOT NULL,
  telNo  VARCHAR(45) DEFAULT NULL,
  prefType  VARCHAR(10) DEFAULT NULL,
  maxRent  INTEGER DEFAULT NULL,
   CONSTRAINT client_pk PRIMARY KEY(clientNo)
);

CREATE TABLE  privateowner  (
   ownerNo  CHAR(4) NOT NULL,
   fName  VARCHAR(15) NOT NULL,
   lName  VARCHAR(15) NOT NULL,
   address  VARCHAR(35) DEFAULT NULL,
   telNo  VARCHAR(25) DEFAULT NULL,
    CONSTRAINT owner_pk PRIMARY KEY(ownerNo)
);

CREATE TABLE  propertyforrent  (
   propertyNo  CHAR(4) NOT NULL,
   street  VARCHAR(25) NOT NULL,
   city  VARCHAR(15) NOT NULL,
   postcode  VARCHAR(8) NOT NULL,
   type  VARCHAR(10) NOT NULL,
   rooms  SMALLINT NOT NULL,
   rent  INTEGER NOT NULL,
   ownerNo  CHAR(4) DEFAULT NULL,
   staffNo  CHAR(4) DEFAULT NULL,
   branchNo  CHAR(4) DEFAULT NULL,
    CONSTRAINT property_pk PRIMARY KEY(propertyNo),
    CONSTRAINT owner_property_fk FOREIGN KEY (ownerNo)
        REFERENCES privateowner (ownerNo)
        ON UPDATE CASCADE 
        ON DELETE SET NULL,
    CONSTRAINT staff_property_fk FOREIGN KEY (staffNo)
        REFERENCES staff (staffNo)
        ON UPDATE CASCADE 
        ON DELETE SET NULL,
    CONSTRAINT branch_property_fk FOREIGN KEY (branchNo)
        REFERENCES branch (branchNo)
        ON UPDATE CASCADE ON DELETE SET NULL

) ;

CREATE TABLE  registration  (
   clientNo  CHAR(4) NOT NULL,
   branchNo  CHAR(4) NOT NULL,
   staffNo  CHAR(4) NOT NULL,
   dateJoined  DATE NOT NULL,
   CONSTRAINT client_registration_fk FOREIGN KEY (clientNo)
        REFERENCES client (clientNo)
        ON UPDATE CASCADE ON DELETE SET NULL,
   CONSTRAINT staff_registration_fk FOREIGN KEY (staffNo)
        REFERENCES staff (staffNo)
        ON UPDATE CASCADE ON DELETE SET NULL,
   CONSTRAINT branch_registration_fk FOREIGN KEY (branchNo)
        REFERENCES branch (branchNo)
        ON UPDATE CASCADE ON DELETE SET NULL
) ;

CREATE TABLE  viewing  (
   clientNo  CHAR(4) NOT NULL,
   propertyNo  CHAR(4) NOT NULL,
   viewDate  DATE NOT NULL,
   comment  VARCHAR(45) DEFAULT NULL,
   CONSTRAINT client_viewing_fk FOREIGN KEY (clientNo)
        REFERENCES client (clientNo)
        ON UPDATE CASCADE ON DELETE SET NULL,
   CONSTRAINT property_viewing_fk FOREIGN KEY (propertyNo)
        REFERENCES propertyforrent (propertyNo)
        ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO branch (branchNo,street,city,postcode)  VALUES ('B005','22 Deer Rd','London','SW1 4EH');
INSERT INTO branch (branchNo,street,city,postcode)  VALUES ('B007','16 Argyll St','Aberdeen','AB2 3SU');
INSERT INTO branch (branchNo,street,city,postcode) VALUES ('B003','163 Main St','Glasgow','G11 9QX');
INSERT INTO branch (branchNo,street,city,postcode) VALUES ('B004','32 Manse Rd','Bristol','BS99 1NZ');
INSERT INTO branch (branchNo,street,city,postcode)  VALUES ('B002','56 Clover Dr','London','NW10 6EU');

INSERT INTO staff  (staffNo, fName ,lName,position, sex , dob , salary,branchNo)
    VALUES ('SL21','John','White','Manager','M','1945-10-01',300000,'B005');
INSERT INTO staff (staffNo, fName ,lName,position, sex , dob , salary,branchNo)
    VALUES ('SG37','Ann','Beech','Assistant','F','1960-11-10',12000,'B003');
INSERT INTO staff (staffNo, fName ,lName,position, sex , dob , salary,branchNo)
    VALUES ('SG14','David','Ford','Supervisor','M','1958-02-24',18000,'B003');
INSERT INTO staff (staffNo, fName ,lName,position, sex , dob , salary,branchNo) 
    VALUES ('SA9','Mary','Howe','Assistant','F','1070-02-19',9000,'B007');
INSERT INTO staff (staffNo, fName ,lName,position, sex , dob , salary,branchNo)
    VALUES  ('SG5','Susan','Brand','Manager','F','1940-06-03',24000,'B003');
INSERT INTO staff (staffNo, fName ,lName,position, sex , dob , salary,branchNo)
    VALUES ('SL41','Julie','Lee','Assistant','F','1965-06-13',9000,'B005');

INSERT INTO client (clientNo, fName,lName, telNo,prefType,maxRent) 
    VALUES ('CR76','John','Kay','0171-774-5632','Flat',425);
INSERT INTO client (clientNo, fName,lName, telNo,prefType,maxRent)  
    VALUES ('CR56','Aline','Steward','0141-848-1825','Flat',350);
INSERT INTO client (clientNo, fName,lName, telNo,prefType,maxRent)  
    VALUES ('CR74','Mike','Ritchie','01475-392178','House',750 );
INSERT INTO client (clientNo, fName,lName, telNo,prefType,maxRent) 
     VALUES ('CR62','Mary','Tregear','01224-196720','Flat',600);

INSERT INTO privateowner (ownerNo,fName,lName,address,telNo)  
     VALUES ('CO46','Joe','Keogh','2 Fergus Dr. Aberdeen AB2 7SX','01224-861212');
INSERT INTO privateowner (ownerNo,fName,lName,address,telNo) 
    VALUES ('CO87','Carol','Farrel','6 Achray St. Glasgow G32 9DX','0141-357-7419');
INSERT INTO privateowner (ownerNo,fName,lName,address,telNo) 
    VALUES ('CO40','Tina','Murphy','63 Well St. Glasgow G42','0141-943-1728');
INSERT INTO privateowner(ownerNo,fName,lName,address,telNo)  
    VALUES ('CO93','Tony','Shaw','12 Park Pl. Glasgow G4 0QR','0141-225-7025');

INSERT INTO propertyforrent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo)  
    VALUES ('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007'); 
INSERT INTO propertyforrent  (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo)
    VALUES ('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005');  
INSERT INTO propertyforrent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) 
    VALUES ('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40',NULL,'B003');  
INSERT INTO propertyforrent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo)
    VALUES ('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003');  
INSERT INTO propertyforrent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) 
    VALUES ('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');  
INSERT INTO propertyforrent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo)
    VALUES ('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003'); 
 
 INSERT INTO registration (clientNo, branchNo, staffNo,dateJoined)
    VALUES ('CR76','B005','SL41','2001-01-02');
INSERT INTO registration (clientNo, branchNo, staffNo,dateJoined) 
    VALUES ('CR56','B003','SG37','2000-04-11');
INSERT INTO registration (clientNo, branchNo, staffNo,dateJoined) 
    VALUES ('CR74','B003','SG37','1999-11-16');
INSERT INTO registration (clientNo, branchNo, staffNo,dateJoined) 
    VALUES ('CR62','B007','SA9','2000-03-07');

INSERT INTO viewing (clientNo, propertyNo,  viewDate, comment) 
    VALUES ('CR56','PA14','1995-05-24','too small');
INSERT INTO viewing (clientNo, propertyNo,  viewDate, comment) 
    VALUES ('CR76','PG4','1995-04-20','too remote');
INSERT INTO viewing (clientNo, propertyNo,  viewDate, comment) 
    VALUES ('CR56','PG4','1995-05-26',null);
INSERT INTO viewing (clientNo, propertyNo,  viewDate, comment) 
    VALUES ('CR62','PA14','1995-05-14','no dining room');
INSERT INTO viewing (clientNo, propertyNo,  viewDate, comment) 
    VALUES ('CR56','PG36','1995-04-28',null);    