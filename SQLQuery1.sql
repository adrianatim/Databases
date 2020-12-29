DROP TABLE written_driving_school_exam;
DROP TABLE practical_driving_school_exam;
DROP TABLE dual_control_car;
DROP TABLE personal_car;
DROP TABLE di_h;
DROP TABLE di_dc;
DROP TABLE driving_company;
DROP TABLE examiner;
DROP TABLE human;
DROP TABLE driving_instructor;
DROP TABLE new;

CREATE TABLE new
(nName VARCHAR(100),
hight FLOAT,
age INT)

CREATE TABLE driving_instructor
(diId INT PRIMARY KEY,
 diName VARCHAR(100))

 CREATE TABLE human
 (hId INT PRIMARY KEY,
 hName VARCHAR(100),
 DOB DATE)

 --driver_instrocutor works with human
 CREATE TABLE di_h
 (diId INT REFERENCES driving_instructor(diId),
 hId INT REFERENCES human(hId),
 nrOfHours INT,
 PRIMARY KEY(diId, hId))

 --examiner examines humans
 CREATE TABLE examiner
 (eId INT PRIMARY KEY,
 eName VARCHAR(100))

 CREATE TABLE driving_company
 (dcId INT PRIMARY KEY,
 dcName VARCHAR(100),
 dcTopDrivingCompanies INT)

 --driving_instructor works at a driving_company
 CREATE TABLE di_dc
 (diID INT REFERENCES driving_instructor(diId),
 dcId INT REFERENCES driving_company(dcId),
 since DATE,
 PRIMARY KEY(diId, dcId))

 --drivingInstructor drives a dualControlCar
 CREATE TABLE dual_control_car
 (dccId INT PRIMARY KEY,
 dccBrand VARCHAR(100),
 dccFuel INT,
 diId INT REFERENCES driving_instructor(diId))

 CREATE TABLE personal_car
 (pcId INT PRIMARY KEY,
 pcBrand VARCHAR(50),
 diId INT REFERENCES driving_instructor(diId))

 CREATE TABLE written_driving_school_exam
 (wdseId INT PRIMARY KEY,
 score INT,
 hId INT REFERENCES human(hId))

 CREATE TABLE practical_driving_school_exam
 (eId INT REFERENCES examiner(eId),
 hId INT REFERENCES human(hId),
 points INT,
 PRIMARY KEY(eId, hId))

ALTER TABLE practical_driving_school_exam
ADD statusExam VARCHAR(20);

ALTER TABLE human
ADD statusFile VARCHAR(50), medicalFile VARCHAR(50);

ALTER TABLE written_driving_school_exam
ADD statusWExam VARCHAR(50);

ALTER TABLE driving_instructor
ADD yearsOfExperience INT, categoryTeaching VARCHAR(10);

ALTER TABLE personal_car
ADD pcColor VARCHAR(20);

ALTER TABLE dual_control_car
ADD carTypeCategory VARCHAR(5)

ALTER TABLE driving_company
ADD priceCatA INT, priceCatB INT, priceCatC INT, priceCatD INT;

ALTER TABLE di_dc
ADD salary INT;

ALTER TABLE di_h
ADD nrOfKm INT;

