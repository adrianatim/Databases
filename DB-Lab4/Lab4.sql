USE DrivingSchoolDB

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO

 --implement a set of stored procedures for running tests and storing their results

 --a table with a single-column primary key and no foreign keys;
 --examiner table
 CREATE OR ALTER PROCEDURE InsertIntoExaminer
 @nrRows INT
 AS
	BEGIN
	DECLARE @int INT
	SET @int=1
	DECLARE @eName VARCHAR(50)
		WHILE @int <= @nrRows
		BEGIN
		SET @eName = 'New Examiner' + CONVERT(VARCHAR(2), @int)
		INSERT INTO examiner(eId, eName) VALUES(@int+10, @eName)
		SET @int +=1
		END
	END
GO
EXEC InsertIntoExaminer 5
SELECT * FROM examiner
GO

CREATE OR ALTER PROCEDURE DeleteFromExaminer
 @nrRows INT
 AS
	BEGIN
	DECLARE @int INT
	SET @int = 1
		WHILE @int <= @nrRows
		BEGIN
		DELETE FROM examiner
		WHERE eId = @int + 10
		SET @int +=1
		END
	END
 GO

EXEC DeleteFromExaminer 5
SELECT * FROM examiner
GO

CREATE OR ALTER VIEW ExaminerTable
AS
	SELECT * FROM examiner
GO

SELECT * FROM ExaminerTable
GO

--a table with a single-column primary key and at least one foreign key;
--written_driving_school_exam

CREATE OR ALTER PROCEDURE InsertIntoWDSE
@nrRows INT
AS
	BEGIN
	DECLARE @universalId INT
	DECLARE @score INT
	SET @universalId=1
	SET @score = 10
		WHILE @universalId <= @nrRows
		BEGIN
		INSERT INTO written_driving_school_exam(wdseId, score, hId, statusWExam) VALUES (@universalId+10, @score, @universalId + 2, 'Failed') 
		SET @universalId +=1
		SET @score +=1
		END
	END
GO

EXEC InsertIntoWDSE 3
SELECT * FROM written_driving_school_exam
GO

CREATE OR ALTER PROCEDURE DeleteFromWDSE
@nrRows INT
AS
	BEGIN
	DECLARE @id INT
	SET @id =1
		WHILE @id <= @nrRows
		BEGIN
		DELETE FROM written_driving_school_exam
		WHERE wdseId = @id+10
		SET @id +=1
		END
	END
GO

EXEC DeleteFromWDSE 3
SELECT * FROM written_driving_school_exam
GO

--view 
CREATE OR ALTER VIEW WDSETable
AS
	SELECT * FROM written_driving_school_exam
GO

SELECT * FROM WDSETable
GO

--a table with a multicolumn primary key
--practical_driving_school_exam

CREATE OR ALTER PROCEDURE InsertIntoPDSE
@nrRows INT
AS
	BEGIN
	DECLARE @universalId INT, @points INT
	SET @universalId = 1
	SET @points = 21
		WHILE @universalId <= @nrRows
		BEGIN
		INSERT INTO practical_driving_school_exam(eId, hId, points,statusExam) VALUES (@universalId, @universalId+3, @points, 'Failed')
		SET @points +=1
		SET @universalId +=1
		END
	END
GO

EXEC InsertIntoPDSE 3
SELECT * FROM practical_driving_school_exam
GO

CREATE OR ALTER PROCEDURE DeleteFromPDSE
@nrRows INT
AS
	BEGIN
	DECLARE @universalId INT
	SET @universalId = 1
		WHILE @universalId <= @nrRows
		BEGIN
		DELETE FROM practical_driving_school_exam
		WHERE eId = @universalId AND hId = @universalId + 3
		SET @universalId +=1
		END
	END
GO

EXEC DeleteFromPDSE 3
SELECT * FROM practical_driving_school_exam
GO

CREATE OR ALTER VIEW PDSETable
AS
	SELECT * FROM practical_driving_school_exam
GO

SELECT * FROM PDSETable
GO

DELETE FROM Tests
DELETE FROM Tables
DELETE FROM Views
DELETE FROM TestTables
DELETE FROM TestViews

--populate tables 
INSERT INTO Tests(Name)
VALUES
('test1'),
('test2'),
('test3');

INSERT INTO Tables(Name)
VALUES 
('Examiner'),
('PDSE'),
('WDSE');

INSERT INTO TestTables(TestID, TableID, NoOfRows, Position)
VALUES
(1, 3, 3, 1),
(2, 2, 3, 2),
(3, 1, 3, 3);

INSERT INTO Views(Name)
VALUES
('ExaminerTable'),
('PDSETable'),
('WDSETable');

INSERT INTO TestViews(TestID, ViewID)
VALUES
(1,3),
(2,2),
(3,1);

SELECT * FROM Tests
SELECT * FROM Tables
Select * FROM TestTables
SELECT * FROM Views
SELECT * FROM TestViews


CREATE OR ALTER PROCEDURE myRun(@test VARCHAR(50))
AS
	IF @test NOT IN (SELECT Name FROM Tests) 
		BEGIN
		PRINT 'This test is not in table Tests!'
		RETURN
		END
	DECLARE @testId INT
	SET @testId = (SELECT TestID FROM Tests WHERE Name = @test)
	DECLARE @tableId INT
	DECLARE @startTestRun DATETIME
	DECLARE @startTime DATETIME
	DECLARE @endTime DATETIME
	DECLARE @option VARCHAR(100)
	DECLARE @funtionName VARCHAR(50)
	DECLARE @tableContor INT
	SET @tableContor = (SELECT TableID FROM TestTables WHERE TestID = @testId)
	DECLARE @viewContor INT
	SET @viewContor = (SELECT ViewID FROM TestViews WHERE TestID = @testId)
	DECLARE @row INT
	DECLARE @testRunId INT
	SET @testRunId = (SELECT MAX(TestRunID)+1 FROM TestRuns)
	IF @testRunId IS NULL
		BEGIN 
		SET @testRunId = 1
		END
	SET @startTestRun= SYSDATETIME()

--------------------insert into tables----------------------------------------
	SET @funtionName = (SELECT Name FROM Tables WHERE @tableContor = TableID)
	SET @option = 'InsertInto' + @funtionName

		------------insert into TestRuns--------------------------------------
		SET IDENTITY_INSERT TestRuns ON
			INSERT INTO TestRuns (TestRunID, Description, StartAt, EndAt)
			VALUES
			(@testRunId, 'Result for: ' + @funtionName , @startTestRun, NULL)
		SET IDENTITY_INSERT TestRuns OFF

	SET @row = (SELECT NoOfRows FROM TestTables WHERE @tableContor = TableID AND @testId = TestID)
	SET @startTime = SYSDATETIME()
	EXEC @option @row
	SET @endTime = SYSDATETIME()

    --------------insert into TestRunsTables-----------------------------------
		INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt) 
		VALUES
		(@testRunId, @tableContor, @startTime, @endTime)

-----------------------------view tables---------------------------------------
	SET @funtionName = (SELECT Name FROM Tables WHERE @viewContor = TableID)
	SET @option = 'SELECT * FROM '+ @funtionName + 'Table'
	SET @startTime = SYSDATETIME()
	EXEC(@option)
	SET @endTime = SYSDATETIME()

		---------------insert into TestRunViews--------------------------------
		INSERT INTO TestRunViews(TestRunID, ViewID ,StartAt, EndAt)
		VALUES
		(@testRunId, @tableContor, @startTime, @endTime)

----------------------delete from tables---------------------------------------
	SET @option = 'DeleteFrom'+ @funtionName
	EXEC @option @row

	UPDATE TestRuns
	SET EndAt = SYSDATETIME()
	WHERE TestRunID = @testRunId
GO

EXEC myRun 'test1'
EXEC myRun 'test2'
EXEC myRun 'test3' 

SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews
