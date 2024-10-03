--Name : KRISHNAY MUDGAL
-- SQL Coding Challenge 
--TestName : PetPals


-- TASKS

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'PetPals')
BEGIN
    DROP DATABASE PetPals;
END

create database PetPals;
use PetPals;



--4--
IF OBJECT_ID('dbo.Pets', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Pets;
END

-- Drop the Shelters table if it exists
IF OBJECT_ID('dbo.Shelters', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Shelters;
END

-- Drop the Donations table if it exists
IF OBJECT_ID('dbo.Donations', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Donations;
END

-- Drop the AdoptionEvents table if it exists
IF OBJECT_ID('dbo.AdoptionEvents', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.AdoptionEvents;
END

-- Drop the Participants table if it exists
IF OBJECT_ID('dbo.Participants', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Participants;
END

--1--
--2--
--3--
CREATE TABLE Pets (
    PetID INT PRIMARY KEY,         
    Name VARCHAR(100),            
    Age INT,                       
    Breed VARCHAR(100), 
	OwnerId INT,
	ShelterId INT,
    Type VARCHAR(50),             
    AvailableForAdoption BIT   NOT NULL    -- (0 for not available, 1 for available)
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

ALTER TABLE Pets
ADD CONSTRAINT FK_Pets_OwnerID
FOREIGN KEY (OwnerID) REFERENCES Participants(ParticipantID);

CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(255)
);


CREATE TABLE Donations (
    DonationID INT PRIMARY KEY,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10, 2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME
);

ALTER TABLE Donations
ADD ShelterID INT;

ALTER TABLE Donations
ADD CONSTRAINT FK_Donations_Shelters
FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(255)
);

ALTER TABLE AdoptionEvents
ADD ShelterID INT;

ALTER TABLE AdoptionEvents
ADD CONSTRAINT FK_AdoptionEvents_ShelterID
FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);


CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

INSERT INTO Pets (PetID, Name, Age, Breed, Type, AvailableForAdoption, OwnerID, ShelterID)
VALUES
(1, 'Bella', 3, 'Labrador Retriever', 'Dog', 1, 1, 1),
(2, 'Milo', 2, 'Siamese', 'Cat', 0, NULL, 2),
(3, 'Charlie', 1, 'Golden Retriever', 'Dog', 1, 2, 1),
(4, 'Lucy', 4, 'Persian', 'Cat', 1, NULL, 2),
(5, 'Max', 5, 'Beagle', 'Dog', 0, 3, 3),
(6, 'Marlo', 6, 'Beagle', 'Dog', 0, NULL, 3);


INSERT INTO Shelters (ShelterID, Name, Location)
VALUES
(1, 'Happy Paws Shelter', '1234 Oak Street, New York, NY'),
(2, 'Safe Haven Animal Rescue', '5678 Elm Avenue, Los Angeles, CA'),
(3, 'Furry Friends Haven', '910 Maple Road, Chicago, IL'),
(4, 'Paws & Claws Shelter', '3456 Pine Lane, Austin, TX'),
(5, 'Whiskers & Wag Shelter', '789 Birch Boulevard, Seattle, WA');

INSERT INTO Shelters (ShelterID, Name, Location)
VALUES
(6, 'Happy Paws Shelter', 'Chennai'),
(7, 'City Animal Rescue', 'Mumbai'),
(8, 'Furry Friends Haven', 'Bangalore'),
(9, 'Safe Haven for Pets', 'Chennai'),
(10, 'Pawtastic Shelter', 'Hyderabad');

INSERT INTO Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID)
VALUES
(1, 'John Doe', 'Cash', 100.00, NULL, '2024-10-01 10:30:00', 1),
(2, 'Jane Smith', 'Item', NULL, 'Dog Food', '2024-09-25 14:15:00', 2),
(3, 'Emily Johnson', 'Cash', 250.00, NULL, '2024-09-30 09:00:00', 1),
(4, 'Michael Brown', 'Item', NULL, 'Blankets', '2024-10-02 12:45:00', 3),
(5, 'Laura Wilson', 'Cash', 50.00, NULL, '2024-09-28 16:20:00', 2);


INSERT INTO AdoptionEvents (EventID, EventName, EventDate, Location)
VALUES
(1, 'Fall Adoption Fair', '2024-10-15 10:00:00', 'City Park, New York, NY'),
(2, 'Summer Pet Extravaganza', '2024-07-20 11:00:00', 'Community Center, Los Angeles, CA'),
(3, 'Winter Warm-Up Adoption Day', '2024-12-05 09:00:00', 'Animal Shelter, Chicago, IL'),
(4, 'Spring Fling Adoption Event', '2024-04-10 13:00:00', 'Downtown Plaza, Austin, TX'),
(5, 'Pet Palooza Adoption Festival', '2024-08-25 12:00:00', 'Fairgrounds, Seattle, WA');

INSERT INTO AdoptionEvents (EventID, EventName, EventDate, Location, ShelterID)
VALUES
(6, 'Adoption Day', '2024-10-15 10:00:00', 'Chennai', 1),
(7, 'Paws and Claws Adoption Fair', '2024-10-20 14:00:00', 'Mumbai', 2),
(8, 'Furry Friends Meet and Greet', '2024-11-05 11:00:00', 'Bangalore', 3),
(9, 'Rescue Pet Adoption Drive', '2024-11-10 09:30:00', 'Chennai', 1),
(10, 'Cuddly Companions Adoption Event', '2024-11-15 13:00:00', 'Hyderabad', 4);

INSERT INTO Participants (ParticipantID, ParticipantName, ParticipantType, EventID)
VALUES
(1, 'Happy Paws Shelter', 'Shelter', 1),
(2, 'John Smith', 'Adopter', 1),
(3, 'Safe Haven Animal Rescue', 'Shelter', 2),
(4, 'Emily Johnson', 'Adopter', 3),
(5, 'Whiskers & Wag Shelter', 'Shelter', 4);


--5
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;

--6
DECLARE @EventID INT; 

SET @EventID = 1; 

SELECT ParticipantName, ParticipantType
FROM Participants
WHERE EventID = @EventID;

--7
CREATE PROCEDURE UpdateShelterInfo
    @ShelterID INT,
    @NewName VARCHAR(100),
    @NewLocation VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Checking if the shelter ID exists
    IF NOT EXISTS (SELECT 1 FROM Shelters WHERE ShelterID = @ShelterID)
    BEGIN
        RAISERROR('Shelter ID %d does not exist.', 16, 1, @ShelterID);
        RETURN;
    END

    
    UPDATE Shelters
    SET Name = @NewName,
        Location = @NewLocation
    WHERE ShelterID = @ShelterID;

    PRINT 'Shelter information updated successfully.';
END
GO
--Usage
EXEC UpdateShelterInfo @ShelterID = 1, @NewName = 'Indian Pet House', @NewLocation = '31, Andheri Road, Mumbai';
select * from Shelters;

--8
SELECT s.Name AS ShelterName, 
COALESCE(SUM(d.DonationAmount), 0) AS TotalDonationAmount
FROM Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterId
GROUP BY s.Name;

--9
SELECT Name, Age, Breed, Type
FROM Pets
WHERE OwnerID IS NULL;

--10
DECLARE @InputMonth INT = 10; -- Example: October
DECLARE @InputYear INT = 2024; -- Example: Year 2024

SELECT 
    FORMAT(DonationDate, 'MMMM yyyy') AS MonthYear,
    SUM(DonationAmount) AS TotalDonationAmount
FROM Donations
WHERE MONTH(DonationDate) = @InputMonth AND YEAR(DonationDate) = @InputYear
GROUP BY FORMAT(DonationDate, 'MMMM yyyy');

--11
SELECT DISTINCT Breed
FROM Pets
WHERE (Age BETWEEN 1 AND 3) OR (Age > 5);

--12
SELECT 
    p.Name AS PetName,
    p.Age,
    p.Breed,
    p.Type,
    s.Name AS ShelterName,
    s.Location
FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 1;

--13
SELECT COUNT(DISTINCT p.ParticipantID) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents e ON p.EventID = e.EventID
JOIN Shelters s ON e.ShelterID = s.ShelterID
WHERE s.Location = 'Chennai';

--14
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

--15
SELECT PetID, Name, Age, Breed, Type, AvailableForAdoption
FROM Pets
WHERE OwnerID IS NULL;

--16
SELECT p.Name AS PetName, par.ParticipantName AS AdopterName
FROM Pets p
JOIN Participants par ON p.OwnerID = par.ParticipantID
WHERE p.OwnerID IS NOT NULL;

--17
SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePetsCount
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID AND p.AvailableForAdoption = 1
GROUP BY s.ShelterID, s.Name;

--18
--Using self join on pets table
SELECT 
    p1.Name AS Pet1_Name,
    p2.Name AS Pet2_Name,
    p1.Breed,
    p1.ShelterID
FROM 
    Pets p1
JOIN 
    Pets p2 ON p1.Breed = p2.Breed 
              AND p1.ShelterID = p2.ShelterID
              AND p1.PetID < p2.PetID;

--19
--Cross join is used here
SELECT 
    s.ShelterID,
    s.Name AS ShelterName,
    ae.EventID,
    ae.EventName AS AdoptionEventName
FROM 
    Shelters s
CROSS JOIN 
    AdoptionEvents ae;

--20
SELECT TOP 1
    s.ShelterID,
    s.Name AS ShelterName,
    COUNT(p.PetID) AS AdoptedPetsCount
FROM 
    Shelters s
JOIN 
    Pets p ON s.ShelterID = p.ShelterID
WHERE 
    p.OwnerID IS NOT NULL
GROUP BY 
    s.ShelterID, s.Name
ORDER BY 
    AdoptedPetsCount DESC;


---===============XXX=================-----
--                END