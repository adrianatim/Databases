USE DrivingSchoolDB;

--a) UNION and OR operations

-- get the list with all the examiners and the humans that need to be at the practical exam
SELECT 'Examiner' AS PersonType ,eName FROM examiner
UNION ALL
SELECT 'Human', hName FROM human;

-- get all the cars on which you can learn driving if you fave under 21 yo
SELECT * FROM dual_control_car
WHERE carTypeCategory LIKE 'B%'  OR carTypeCategory LIKE 'A%';

--b) INTERSECT and IN operations 

--get the humans that have taken both of exams
SELECT H.hName
FROM human H 
WHERE H.hId IN
	(SELECT hId FROM written_driving_school_exam
	INTERSECT
	SELECT hId FROM practical_driving_school_exam)

--get the instructors that has an Mercedes dual_control car and consumes less than 15l/h
SELECT DI.diName
FROM driving_instructor DI
WHERE DI.diId IN
	(SELECT DCC.diId 
	FROM dual_control_car DCC
	WHERE DCC.dccBrand LIKE 'M%' AND DCC.dccFuel <=15)

--c) EXCEPT and NOT IN

--get all the intructors that has never worked at the Mis Pop driving company with a salary smaller than 2600RON

SELECT DI.diName
FROM driving_instructor DI
WHERE DI.diId NOT IN
	(SELECT DIDC.diID 
	FROM di_dc DIDC
	WHERE DIDC.dcId = 3 AND DIDC.salary < 2600)

--get all the humans that have take only the written exam and passed it
SELECT H.hName
FROM human H
WHERE H.hId IN 
	(SELECT WDSE.hId
	FROM written_driving_school_exam WDSE
	WHERE WDSE.score > 21
	EXCEPT 
	SELECT PDSE.hId
	FROM practical_driving_school_exam PDSE)

--d) INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN

-- INNER JOIN 
-- get all the written exams of an human, including the humans' name in the table
SELECT * 
FROM human H INNER JOIN written_driving_school_exam WDSE ON H.hId = WDSE.hId


-- LEFT JOIN
-- get all the humans, even those who didn't take the written exam also
SELECT *
FROM human H LEFT JOIN written_driving_school_exam WDSE ON H.hId = WDSE.hId


-- RIGHT JOIN (many to many)
--all the humans that failed the practical exam from the instructor
SELECT DISTINCT H.hName, DI.diName
FROM human H
RIGHT JOIN practical_driving_school_exam PDSE ON H.hId = PDSE.hId AND PDSE.points >21 
RIGHT JOIN di_h DH ON H.hId = DH.hId
RIGHT JOIN driving_instructor DI ON DI.diId = DH.diId


-- FULL JOIN
-- get all the humans that have taken both exam and their driving instructor
SELECT DISTINCT H.hName, PDSE.points, WDSE.score, DI.diName
FROM human H
FULL JOIN practical_driving_school_exam PDSE ON H.hId = PDSE.hId
FULL JOIN written_driving_school_exam WDSE ON H.hId = WDSE.hId
FULL JOIN di_h DH ON DH.hId = H.hId
FULL JOIN driving_instructor DI ON DI.diId = DH.diId

--e) IN -> subquery in the WHERE clause 
-- get all the humans that have failed the practical exam with Mia Cardos

SELECT H.hName 
FROM human H
WHERE H.hId IN
	(SELECT PE.hId
	FROM practical_driving_school_exam PE
	WHERE  PE.points>21 AND EXISTS
	(SELECT *
	FROM examiner E
	WHERE PE.eId = 3))

-- get all the instructors that work at the 5 top companies with the minimum amount of 2500$
SELECT DI.diName
FROM driving_instructor DI
WHERE DI.diId IN
	(SELECT DD.diID
	FROM di_dc DD
	WHERE DD.salary >2500 AND EXISTS
	(SELECT *
	FROM driving_company DC
	WHERE DC.dcTopDrivingCompanies <5))

--f) EXISTS -> subquery in the where clause
--get get all the humans that have the statusWExam 'Failed'
SELECT H.hName
FROM human H
WHERE EXISTS
	(SELECT *
	FROM written_driving_school_exam WDSE
	WHERE WDSE.statusWExam = 'Failed' AND WDSE.hId = H.hId)

--get all the instructors that have a red personal car
SELECT DI.diName
FROM driving_instructor DI
WHERE EXISTS 
	(SELECT *
	FROM personal_car PC
	WHERE PC.pcColor = 'Red' AND PC.diId= DI.diId)

--g) a subquery in the FORM clause
--get all the instructors that drives mercedes dual_control_car and has the experience > 5years
SELECT DiName
FROM (
		SELECT DI.diName
		FROM dual_control_car DCC, driving_instructor DI
		WHERE DI.yearsOfExperience > 3 AND DCC.diId = DI.diId AND DCC.dccBrand = 'Mercedes' 
	 )DI;

--get all humans that can take the written exam (means that he had to make 30h of driving with the instructor)
SELECT HName 
FROM(
	SELECT H.hName as HName
	FROM human H, di_h DIH
	WHERE DIH.nrOfHours >=30 AND DIH.hId = H.hId
	)H;

--h)4 queries with the GROUP BY clause
--get the no of hours of all the humans gorup by status file
SELECT H.statusFile, AVG(nrOfHours) AS NoOfHours
FROM human H, di_h DH
WHERE H.hId = DH.diId
GROUP BY H.statusFile

--Group instructors by the years of experience, and get those with the salary grater than 2800
SELECT DISTINCT DI.yearsOfExperience, MAX(DD.salary)
FROM driving_instructor DI, di_dc DD
WHERE DI.diId = DD.diID
GROUP BY DI.yearsOfExperience
HAVING  2800 <= (SELECT MAX(DD1.salary) 
					FROM di_dc DD1)

--Group humans by the status file, ang get the ones who has the score from the practical exam bigger(in all of the humans tries in getting the driving license)than 21
SELECT DISTINCT H.statusFile, SUM(PDSE1.points) AS Points
FROM human H, practical_driving_school_exam PDSE1
GROUP BY H.statusFile, H.hId
HAVING 21 <= (SELECT SUM(PDSE.points)
			  FROM practical_driving_school_exam PDSE
			  WHERE PDSE.hId = H.hId) 

--group dual_control_cars by the car brand and get the ones that have the fuel consumation grater than 7
SELECT DISTINCT DCC.dccBrand
FROM dual_control_car DCC
GROUP BY DCC.dccBrand
HAVING  7 <= (SELECT MAX(DCC1.dccFuel)
			  FROM dual_control_car DCC1
			  WHERE DCC1.dccBrand = DCC.dccBrand )

--i)4 queries using ANY and ALL
--get the instructors that has the salary smaller than all the instructors form Alfa Company
SELECT DISTINCT DI.diName, DIDC.salary
FROM driving_instructor DI, di_dc DIDC
WHERE DI.diId = DIDC.diID AND DIDC.salary < ALL(SELECT DIDC1.salary
											 FROM driving_instructor DI1, di_dc DIDC1
										     WHERE DI1.diId = DIDC1.diID AND DIDC1.dcId=1)

--rewrite with aggregation operator MIN
SELECT DISTINCT DI.diName, DIDC.salary
FROM driving_instructor DI, di_dc DIDC
WHERE DI.diId = DIDC.diID AND DIDC.salary < (SELECT MIN(DIDC1.salary)
											 FROM driving_instructor DI1, di_dc DIDC1
										     WHERE DI1.diId = DIDC1.diID AND DIDC1.dcId=1)

--get the humans that didn't passed the exam but have more km done than the human that passed the exam
SELECT DISTINCT H.hName, PDSE.points
FROM human H, practical_driving_school_exam PDSE, di_h DH
WHERE PDSE.hId = H.hId AND H.hId = DH.hId AND PDSE.statusExam= 'Failed' AND DH.nrOfKm > ALL( SELECT DH1.nrOfHours
															  FROM practical_driving_school_exam PDSE1, di_h DH1
															  WHERE PDSE1.hId = DH1.hId AND PDSE.statusExam = 'Passed')

--rewrite with aggregation operator MAX
SELECT DISTINCT H.hName, PDSE.points
FROM human H, practical_driving_school_exam PDSE, di_h DH
WHERE PDSE.hId = H.hId AND H.hId = DH.hId AND PDSE.statusExam= 'Failed' AND DH.nrOfKm > ( SELECT MIN(DH1.nrOfHours)
															  FROM practical_driving_school_exam PDSE1, di_h DH1
															  WHERE PDSE1.hId = DH1.hId AND PDSE.statusExam = 'Passed')

--all the instructors that are teaching a category and have a dual_control_car for that and the years of experience are smaller than anyoane else
SELECT DISTINCT DI.diName, DI.categoryTeaching
FROM driving_instructor DI, dual_control_car DCR
WHERE DI.diId= DCR.diId AND DI.yearsOfExperience = ANY (SELECT DI1.yearsOfExperience
														FROM driving_instructor DI1, dual_control_car DCC
														WHERE DI1.diId = DCC.diId AND DI1.categoryTeaching = DCC.carTypeCategory)

--rewrite with IN operator
SELECT DISTINCT DI.diName, DI.categoryTeaching
FROM driving_instructor DI, dual_control_car DCR
WHERE DI.diId= DCR.diId AND DI.yearsOfExperience IN (SELECT DI1.yearsOfExperience
													FROM driving_instructor DI1, dual_control_car DCC
													WHERE DI1.diId = DCC.diId AND DI1.categoryTeaching = DCC.carTypeCategory)


--get the human that get the lowest score at the PRACTICAL exam with Mia Cardos
SELECT DISTINCT H.hName
FROM human H, practical_driving_school_exam PDSE
WHERE H.hId = PDSE.hId AND PDSE.points > ANY (SELECT PDSE1.points
											 FROM practical_driving_school_exam PDSE1
											 WHERE PDSE1.eId = 3 AND PDSE1.hId = H.hId)

--rewrite with NOT IN operator
SELECT DISTINCT H.hName, E1.eName
FROM human H, practical_driving_school_exam PDSE, examiner E1
WHERE H.hId = PDSE.hId AND PDSE.eId = 3 AND PDSE.points NOT IN (SELECT MIN(PDSE1.points)
											 FROM practical_driving_school_exam PDSE1
											 WHERE PDSE1.eId = 3 AND PDSE1.hId = H.hId)