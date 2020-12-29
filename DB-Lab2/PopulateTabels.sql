USE DrivingSchoolDB

DELETE FROM di_dc;
DELETE FROM practical_driving_school_exam;
DELETE FROM written_driving_school_exam;
DELETE FROM examiner;
DELETE FROM human;
DELETE FROM driving_instructor;
DELETE FROM driving_company;
DELETE FROM dual_control_car;

--populate table driving_instructor
INSERT INTO driving_instructor(diId, diName, yearsOfExperience, categoryTeaching)
VALUES 
(1, 'Popescu Laurian', 4, 'B'), 
(2, 'Font Dragos', 3, 'C'), 
(3, 'Gherman Vlad', 1, 'BE'), 
(4, 'Gavrilescu Onus', 5, 'C D'), 
(5, 'Ionescu Marian', 10, 'B BE C D'),
(6, 'Camilar Anton', 17, 'A B C D'),
(7, 'Vandra Ionut', 5, 'B'),
(8, 'Focsa Ghimbir', 2, 'B'),
(9, 'Gramma Horatiu', 2, 'B C');


--populate table human
INSERT INTO human(hId, hName, DOB, statusFile, medicalFile)
VALUES 
(1, 'Timis Adriana', '2001-01-22', 'Available', 'Available'),
(2, 'Sustic Alessandro', '2001-05-11', 'Closed', 'Available'),
(3, 'Danci Denisa', '2000-11-10', 'Closed', 'Expired'),
(4, 'George Camilar', '1998-03-25', 'Closed', 'Expired'),
(5, 'Timis Elena', '2002-09-04', 'Available', 'Expired'),
(8, 'Timis Iulia', '2001-04-23', NULL, 'Expired'),
(7, 'Stetco Diana', '2000-05-26', NULL, 'Available'),
(6, 'Stecko Daiana', '2000-09-13', 'Closed', 'Expired'),
(9, 'Tibre Diana', '2001-04-02', 'Available', 'Expired'),
(10, 'Zavorodnic Andrei', '2000-02-28', 'Expired', 'Available');

--populate table driving_complany
INSERT INTO driving_company(dcId, dcName, dcTopDrivingCompanies, priceCatA, priceCatB, priceCatC, priceCatD) 
VALUES 
(1, 'Alfa', 2, 1500, 1800, 2100, 2500), 
(2, 'Tony', 5, 1550, 1850, 2050, 2450),
(3, 'Mis Pop', 7, 1450, 1750, 2000, 2350),
(4, 'Excelent Drivers', 10, 1500, 1900, 2200, 2600),
(5, 'Best Driving School', 1, 1400, 1750, 2100, 2400);

--populate table di_dc (the relation between driving_instructor and driving_company)
INSERT INTO di_dc(diID, dcId, since, salary)
VALUES
(1, 3, '2018-02-26', 2500),
(2, 5, '2020-01-13', 2800),
(3, 3, '2019-05-30', 3100),
(3, 1, '2020-02-07', 3200),
(4, 2, '2005-03-01', 2850),
(5, 4, '2017-10-01', 2900),
(5, 1, '2019-09-15', 3100);

--populate table dual_control_car
INSERT INTO dual_control_car(dccId, dccBrand, dccFuel, diId, carTypeCategory)
VALUES
(101, 'Audi', 12, 4,'B'),
(102, 'Mercedes', 15, 2, 'B'),
(112, 'Volvo', 10, 2, 'D'),
(113, 'Volvo', 11, 2, 'C'),
(110, 'Volkswagen', 6, 1, 'B'),
(111, 'Volkswagen', 6, 3, 'B'),
(127, 'Dacia', 5, 5, 'B'),
(109, 'Dacia', 4, 5, 'B'),
(130, 'Mercedes', 15, 4, 'D'),
(131, 'Audi', 10, 3, 'C');

INSERT INTO examiner(eId, eName)
VALUES
(1, 'Put Vlad'),
(2, 'Marginean Ioan'),
(3, 'Mia Cardos'),
(4, 'Ghena Dorin'),
(5, 'Micu Bogdan'),
(6, 'Maier Horatiu'),
(7, 'Bety Danci'),
(8, 'Dorin Stanciu');


INSERT INTO written_driving_school_exam(wdseId, score, hId, statusWExam)
VALUES
(1, 26, 4, 'Passed'),
(2, 18 ,1, 'Failed'),
(3, 24, 3, 'Passed'),
(4, 15, 2, 'Failed'),
(5, 20, 5, 'Failed'),
(6, 25, 6, 'Passed'),
(7, NULL, 7, NULL),
(8, NULL, 8, NULL);

INSERT INTO practical_driving_school_exam(eId, hId, points, statusExam)
VALUES
(3, 4, 102, 'Failed'),
(1, 1, 24, 'Failed'),
(5, 3, 10, 'Passed'),
(3, 5, 29, 'Failed'),
(4, 2, 18, 'Passed'),
(2, 1, 58, 'Failed'),
(2, 8, NULL, NULL),
(4, 7, NULL, NULL);

INSERT INTO di_h(diId, hId, nrOfHours, nrOfKm)
VALUES
(1, 2, 34, 500),
(1, 3, 28, 320),
(2, 4, 12, 76),
(3, 5, 13, 121),
(5, 4, NULL, NULL),
(7, 6, 45, 430),
(8, 8, 32, 312),
(5, 10, 30, 250),
(4, 1, 36, 390),
(2, 1, NULL, NULL);


--the humans that failed the written exam will be updated 
UPDATE written_driving_school_exam
SET score = 24
WHERE score BETWEEN 1 AND 21;

--update the exams where we have NULL
UPDATE written_driving_school_exam
SET score = 21
WHERE score is NULL;

UPDATE written_driving_school_exam
SET statusWExam = 'Failed'
WHERE statusWExam is NULL;

UPDATE written_driving_school_exam
SET statusWExam = 'Passed'
WHERE score > 21;

--the top psition from the company 'Mis Pop' it's updated
UPDATE driving_company
SET dcTopDrivingCompanies = 4
WHERE dcId=3;

UPDATE human
SET statusFile = 'Processing'
WHERE statusFile IS NULL;

--updated the humans that had the examen with the examiner 'Mia Cardos'
UPDATE practical_driving_school_exam
SET points = 20
WHERE eId = 3;

UPDATE practical_driving_school_exam
SET statusExam = 'Passed' 
WHERE points <=20;

DELETE FROM practical_driving_school_exam
WHERE statusExam LIKE 'P%d';

DELETE FROM written_driving_school_exam
WHERE score <22;


SELECT * FROM human;
SELECT * FROM practical_driving_school_exam;
SELECT * FROM examiner;
SELECT * FROM written_driving_school_exam;

SELECT * FROM di_h;
SELECT * FROM driving_instructor;
SELECT * From driving_company;
SELECT * FROM di_dc;
SELECT * FROM dual_control_car;
