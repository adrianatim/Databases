USE DrivingSchoolDB

DROP TABLE TA
DROP TABLE TB
DROP TABLE TC 

CREATE TABLE TA(
	aid INT PRIMARY KEY, -- IDENTITY(1,1),
	a2 INT UNIQUE,
	a3 INT
 )

 CREATE TABLE TB(
	bid INT PRIMARY KEY, --IDENTITY(1,1),
	b2 INT
 )

 CREATE TABLE TC(
	aid INT REFERENCES TA(aid),
	bid INT REFERENCES TB(bid),
	cid INT PRIMARY KEY 
 )

 --see all the indexes on a particular table 
 EXEC sp_helpindex TA
 EXEC sp_helpindex TB
 EXEC sp_helpindex TC

--------------------populate tables-----------------
CREATE OR ALTER PROCEDURE InsertTables(@noElems INT)
AS
	DECLARE @contor INT
	SET @contor =1
	WHILE @contor <= @noElems
		BEGIN
		-----------------insert into TA-----------------
		SET IDENTITY_INSERT TA ON
		INSERT INTO TA(aid, a2, a3)
		VALUES
		(@contor, @contor+10 , @contor +1)
		SET IDENTITY_INSERT TA OFF

		-----------------insert into TB-----------------
		SET IDENTITY_INSERT TB ON
		INSERT INTO TB(bid, b2)
		VALUES 
		(@contor + 1, @contor)
		SET IDENTITY_INSERT TB OFF
	
		-----------------insert into TC-----------------
		INSERT INTO TC(aid, bid, cid)
		VALUES 
		(@contor, @contor+1, @contor+2)
		SET @contor +=1
		END

GO
EXEC InsertTables 200

SELECT * FROM TA
SELECT * FROM TB
SELECT * FROM TC

DELETE FROM TC
DELETE FROM TA
DELETE FROM TB

 --a)Write queries on Ta such that their execution plans contain the following operators:
 SELECT aid FROM TA WHERE a3 = 0 --claustred index scan
 SELECT aid FROM TA WHERE aid BETWEEN 0 AND 5 --claustred index seek
 SELECT a2 FROM TA --nonclustered index scan
 SELECT aid FROM TA WHERE TA.a2 >2 --nonclustered index seek
 SELECT * FROM TA WHERE a2 = 3--key lookup

 --b)Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. Create a nonclustered index that can speed up the query. Examine the execution plan again.
 SELECT b2 FROM TB WHERE b2 BETWEEN 1 AND 5 -- claustred index scan 
											-- Cost: 0.003502

 CREATE NONCLUSTERED INDEX b3 on TB(b2)     -- creating a nonclustered index
 SELECT b2 FROM TB WHERE B2 BETWEEN 1 AND 5 -- Cost: 0.0032875
											--	0.0032875<0.00352 so the query is speeded up

 DROP INDEX b3 ON TB

 --c)Create a view that joins at least 2 tables. Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.
 CREATE OR ALTER VIEW viewTables
 AS
	SELECT TC.cid, TC.aid
	FROM TC INNER JOIN TA ON TC.aid = TA.aid
	WHERE TC.aid BETWEEN 2 AND 10
 GO

 SELECT * FROM viewTables --before indexing 
						  --cost : 0.004548
 CREATE NONCLUSTERED INDEX a4 on TC(aid)
 SELECT * FROM viewTables --after indexing
						  --cost: 0.0045479

 DROP INDEX a4 ON TC

 EXEC sp_helpindex TA
 EXEC sp_helpindex TB
 EXEC sp_helpindex TC

