USE DrivingSchoolDB;

DROP PROCEDURE modifyColumn;
DROP PROCEDURE unmodifyColumn;
DROP PROCEDURE addColumn;
DROP PROCEDURE removeColumn;
DROP PROCEDURE addDefaultConstraint
DROP PROCEDURE removeDefaultConstraint
DROP PROCEDURE addPrimaryKey
DROP PROCEDURE removePrimaryKey
DROP PROCEDURE addCandidateKey
DROP PROCEDURE removeCandidateKey
DROP PROCEDURE addForeignKey
DROP PROCEDURE removeForeignKey
DROP PROCEDURE createTable;
DROP PROCEDURE dropTable;
DROP PROCEDURE runProcedures;

DROP TABLE dictionary
DROP TABLE databasesVersion

CREATE TABLE dictionary
(id INT,
procedureName VARCHAR(50),
undoProcedureName VARCHAR(50))

INSERT INTO dictionary(id, procedureName, undoProcedureName)
VALUES
(1, 'modifyColumn', 'unmodifyColumn'),
(2, 'addColumn','removeColumn'),
(3, 'addDefaultConstraint', 'removeDefaultConstraint'),
(4, 'addPrimaryKey', 'removePrimaryKey'),
(5, 'addCandidateKey', 'removeCandidateKey'),
(6, 'addForeignKey', 'removeForeignKey'),
(7, 'createTable', 'dropTable');

CREATE TABLE databasesVersion
(versionId INT PRIMARY KEY)

INSERT databasesVersion(versionID) VALUES
  (0);

SELECT * FROM dictionary;
SELECT * From new;

--a)modify the type of a column
CREATE PROCEDURE modifyColumn
AS 
ALTER TABLE new
ALTER COLUMN age FLOAT;
GO
--EXEC modifyColumn

 -- unmodify column
CREATE PROCEDURE unmodifyColumn
AS 
ALTER TABLE new
ALTER COLUMN age INT;
GO
--EXEC unmodifyColumn

--b) add column
CREATE PROCEDURE addColumn
AS
ALTER TABLE new
ADD id INT NOT NULL;
GO
--EXEC addColumn

-- remove column
CREATE PROCEDURE removeColumn
AS
ALTER TABLE new
DROP COLUMN id;
GO
--EXEC removeColumn
 
 --c) add DEFAULT constraint
 CREATE PROCEDURE addDefaultConstraint
 AS
 ALTER TABLE new
 ADD CONSTRAINT df_Name
 DEFAULT '-' FOR nName
 GO
 --EXEC addDefaultConstraint

 -- remove DEFAULT constraint
 CREATE PROCEDURE removeDefaultConstraint
 AS
 ALTER TABLE new
 DROP CONSTRAINT df_Name;
 GO
 --EXEC removeDefaultConstraint

 --d) add primary key
 CREATE PROCEDURE addPrimaryKey
 AS
 ALTER TABLE new
 ADD CONSTRAINT PK_id PRIMARY KEY (id);
 GO
 --EXEC addPrimaryKey

 -- remove primary key
 CREATE PROCEDURE removePrimaryKey
 AS
 ALTER TABLE new
 DROP CONSTRAINT PK_id;
 GO
 --EXEC removePrimaryKey

 --e) add candidate key
 CREATE PROCEDURE addCandidateKey
 AS
 ALTER TABLE new
 ADD CONSTRAINT new_high UNIQUE(hight);
 GO
 --EXEC addCandidateKey

 -- remove constraint key
CREATE PROCEDURE removeCandidateKey
AS
ALTER TABLE new
DROP CONSTRAINT new_high;
GO
--EXEC removeCandidateKey

 --f) add foreign key
 CREATE PROCEDURE addForeignKey
 AS
 ALTER TABLE new
 ADD CONSTRAINT FK_id
 FOREIGN KEY (id) REFERENCES new(id);
 GO
 --EXEC addForeignKey

 -- remove foreign key
 CREATE PROCEDURE removeForeignKey
 AS
 ALTER TABLE new
 DROP CONSTRAINT FK_id;
 GO
 --EXEC removeForeignKey

 --g)create table
 CREATE PROCEDURE createTable
 AS
 CREATE TABLE Fish
 (id INT,
 kg FLOAT,
 species VARCHAR(50))
 GO
 --EXEC createTable

 --g)drop table
 CREATE PROCEDURE dropTable
 AS
 DROP TABLE Fish;
GO

--MAIN PROCEDURE
CREATE PROCEDURE runProcedures(@newId INT) AS
BEGIN
	DECLARE @currentId INT
	DECLARE @procedure VARCHAR(50)

	SET @currentId = (SELECT DV.versionId
					 FROM databasesVersion DV)
	WHILE @currentId < @newId
	BEGIN 
		SET @currentId = @currentId +1
		SET @procedure = (SELECT D.procedureName
						 FROM dictionary D
						 WHERE @currentId = D.id)
		EXEC @procedure
		PRINT('Run procedure:')
		PRINT @procedure
	END

	WHILE @currentId > @newId
	BEGIN
		SET @procedure = (SELECT D.undoProcedureName
						  FROM dictionary D
						  WHERE @currentId = D.id)
		EXEC @procedure
		SET @currentId = @currentId -1
		PRINT 'Run procedure:'
		PRINT @procedure
	END

	UPDATE databasesVersion
	SET versionId = @currentId

END
GO
EXEC runProcedures 3

SELECT * FROM databasesVersion
SELECT * FROM Fish;