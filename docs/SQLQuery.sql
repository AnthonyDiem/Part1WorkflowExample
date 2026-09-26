-- Create database if not exists
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'raceday_db')
BEGIN
    CREATE DATABASE raceday_db;
END;
GO

USE raceday_db;
GO

-- Create UserInfo table if not exists
IF OBJECT_ID('dbo.UserInfo', 'U') IS NULL
BEGIN 
    CREATE TABLE dbo.UserInfo (
    UserID INT PRIMARY KEY,
    Username VARCHAR(65) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Role VARCHAR(20) NOT NULL
    );
END;
GO

IF OBJECT_ID('dbo.Organizer', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Organizer (
    OrganizerID INT PRIMARY KEY,
    FirstName VARCHAR(65) NOT NULL,
    LastName VARCHAR(65) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    ContactEmail VARCHAR(65) NOT NULL,
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES dbo.UserInfo(UserID)
    );
END;
GO

IF OBJECT_ID('dbo.Participant', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Participant (
    ParticipantID INT PRIMARY KEY,
    FirstName VARCHAR(65) NOT NULL,
    LastName VARCHAR(65) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    ContactEmail VARCHAR(65) NOT NULL,
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES dbo.UserInfo(UserID)
    );
END;
GO

IF OBJECT_ID('dbo.Category', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Category (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(300) NOT NULL
    );
END;
GO

IF OBJECT_ID('dbo.Race', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Race (
    RaceID INT PRIMARY KEY,
    Title VARCHAR(65) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    StartDay DATE NOT NULL,
    StartTime TIME NOT NULL,
    Description VARCHAR(300) NOT NULL,
    OrganizerID INT,
    CategoryID INT,
    FOREIGN KEY (OrganizerID) REFERENCES dbo.Organizer(OrganizerID),
    FOREIGN KEY (CategoryID) REFERENCES dbo.Category(CategoryID)
    );
END;
GO

IF OBJECT_ID('dbo.Result', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Result (
    ResultID INT PRIMARY KEY,
    AchievedResult VARCHAR(50) NOT NULL,
    ParticipantID INT,
    RaceID INT,
    FOREIGN KEY (ParticipantID) REFERENCES dbo.Participant(ParticipantID),
    FOREIGN KEY (RaceID) REFERENCES dbo.Race(RaceID)
    );
END;
GO

IF OBJECT_ID('dbo.Enrolment', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Enrolment (
    EnrolmentID INT PRIMARY KEY,
    ParticipantID INT,
    RaceID INT,
    FOREIGN KEY (ParticipantID) REFERENCES dbo.Participant(ParticipantID),
    FOREIGN KEY (RaceID) REFERENCES dbo.Race(RaceID)
    );
END;
GO

-- DATA

INSERT INTO dbo.UserInfo (UserID, Username, Password, Role)
VALUES 
(1, 'a.diem', 'Password123', 'Organizer'),
(2, 'r.shade', '123Password', 'Organizer'),
(3, 'm.anne', '922Pass*1', 'Participant'),
(4, 's.quern', '201rismM', 'Participant'),
(5, 'w.white', '100%MarkAllocation', 'Organizer');
GO

INSERT INTO dbo.Organizer (OrganizerID, FirstName, LastName, ContactNumber, ContactEmail, UserID)
VALUES
(1, 'Anthony', 'Diem', '0610610611', 'anthony.diem@raceday.co.za', 1),
(2, 'Ronova', 'Shade', '0929839189', 'kelly.renny@raceday.co.za', 2),
(3, 'Walter', 'White', '308-87104', 'waltuh.white@raceday.co.za', 5);
GO

INSERT INTO dbo.Participant (ParticipantID, FirstName, LastName, ContactNumber, ContactEmail, UserID)
VALUES
(1, 'Mary', 'Anne', '0932819491', 'mary.anne929@gmail.com', 3),
(2, 'Saahid', 'Quern', '0791829453', 'saahid.applesauce@outlook.com', 4);
GO

INSERT INTO dbo.Category (CategoryID, Name, Description)
VALUES
(1, 'Snorkelling', 'Snorkelling events surrounding aquatic fishies.'),
(2, 'Cycling', 'Cycling events surrounding bikes.'),
(3, 'Running', 'Running events surrounding legs.'),
(4, 'Shooting', 'Shooting events surrounding mone- erm, skill.');
GO

INSERT INTO dbo.Race (RaceID, Title, Duration, Location, StartDay, StartTime, Description, OrganizerID, CategoryID)
VALUES
(1, 'Hazyview 50K Challenge', '00:45:01', 'Hazyview, Mpumalanga', '2026-11-11', '07:00:00', 'A very short and totally fun running event that you should totally join occuring in Hazyview!', 1, 3),
(2, 'Sabie 50 BirdCatcher', '02:00:00', 'Sabie, Mpumalanga', '2026-12-01', '09:30:00', 'Catch birds with our shiny, brand new lovely .50 cal rifle! Show 50 endangered birds some love!', 3, 4),
(3, 'Graskop Snorkel Snatcher', '00:30:00', 'Graskop, Mpumalanga', '2027-04-15', '15:00:00', 'Do not know how we have snorkelling in the mountains but hey, might see some floating fish!', 1, 3),
(4, 'Teyvat Ley Line Cycling', '00:30:00', 'Afterlife, Teyvat', '2926-01-29', '00:00:00', 'A lovely cycling experience in an unfamilar place. Lots to see, forever!', 2, 2);
GO

INSERT INTO dbo.Enrolment (EnrolmentID, ParticipantID, RaceID)
VALUES
(1, 1, 1),
(2, 1, 4),
(3, 1, 2),
(4, 2, 2),
(5, 2, 3);
GO

INSERT INTO dbo.Result (ResultID, AchievedResult, ParticipantID, RaceID)
VALUES
(1, '102 birds', 2, 2),
(2, '-1 birds', 1, 2),
(3, '00:00:10', 1, 1),
(4, '502 fish spotted supposedly', 2, 3);
GO
