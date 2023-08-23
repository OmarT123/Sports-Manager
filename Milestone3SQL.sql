CREATE DATABASE Project3;

SELECT name
FROM sys.tables

--1.a
GO
CREATE PROC createAllTables
AS
BEGIN
CREATE TABLE SystemUser(
	username VARCHAR(20) PRIMARY KEY NOT NULL,
	password VARCHAR(20) NOT NULL
	);
CREATE TABLE SystemAdmin(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	username VARCHAR(20),
	FOREIGN KEY(username) REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE SportsAssociationManager(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	username VARCHAR(20),
	FOREIGN KEY(username) REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Club(
	club_id INT PRIMARY KEY IDENTITY,
	name VARCHAR(20) UNIQUE,
	location VARCHAR(20)
);
CREATE TABLE Stadium(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(20) UNIQUE,
	location VARCHAR(20),
	capacity INT,
	status BIT,
);
CREATE TABLE StadiumManager(
	id INT PRIMARY kEY IDENTITY,
	name VARCHAR(20),
	stadium_id INT NOT NULL UNIQUE ,
	username VARCHAR(20),
	FOREIGN KEY(stadium_id) REFERENCES Stadium ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(username) REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ClubRepresentitive(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	club_id INT NOT NULL UNIQUE,
	username VARCHAR(20),
	FOREIGN KEY(club_id) REFERENCES Club ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(username) REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE Match(
	match_id INT PRIMARY KEY IDENTITY,
	start_time DATETIME,
	end_time DATETIME,
	host_club_id INT,
	guest_club_id INT,
	stadium_id INT,
	FOREIGN KEY(host_club_id) REFERENCES Club ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(guest_club_id) REFERENCES Club ,
	FOREIGN KEY(stadium_id) REFERENCES Stadium ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE HostRequest(
	id INT PRIMARY KEY IDENTITY,
	representative_id INT,
	manager_id INT,
	match_id INT,
    status VARCHAR(20) CHECK (status IN ('accepted', 'rejected', 'unhandled')) DEFAULT 'unhandled',
	FOREIGN KEY(representative_id) REFERENCES ClubRepresentitive,
	FOREIGN KEY(manager_id) REFERENCES StadiumManager,
	FOREIGN KEY(match_id) REFERENCES Match  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Ticket(
	id INT PRIMARY KEY IDENTITY,
	status BIT,
	match_id INT,
	FOREIGN KEY(match_id) REFERENCES Match  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Fan(
	national_id VARCHAR(20) PRIMARY KEY,
	name VARCHAR(20),
	birth_date DATETIME,
	address VARCHAR(20),
	phone_number VARCHAR(20),
	status BIT,
	username VARCHAR(20),
	FOREIGN KEY(username) REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE TicketBuyingTransactions(
	fan_national_id VARCHAR(20),
	ticket_id INT,
	FOREIGN KEY(fan_national_id) REFERENCES Fan ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ticket_id) REFERENCES Ticket ON DELETE CASCADE ON UPDATE CASCADE
);
END

--1.b
GO
CREATE PROC dropAllTables
AS 
BEGIN
DROP TABLE TicketBuyingTransactions;
DROP TABLE HostRequest;
DROP TABLE ClubRepresentitive;
DROP TABLE Ticket;
DROP TABLE Match;
DROP TABLE StadiumManager;
DROP TABLE Stadium;
DROP TABLE Fan;
DROP TABLE Club;
DROP TABLE SportsAssociationManager;
DROP TABLE SystemAdmin;
DROP TABLE SystemUser;
END

--1.c
GO
CREATE PROC dropAllProceduresFunctionsViews
AS
BEGIN
DROP PROC createAllTables;
DROP PROC dropAllTables;
DROP PROC clearAllTables;
DROP VIEW allAssocManagers;
DROP VIEW allClubRepresentatives;
DROP VIEW allStadiumManagers;
DROP VIEW allFans;
DROP VIEW allMatches;
DROP VIEW allTickets;
DROP VIEW allCLubs;
DROP VIEW allStadiums;
DROP VIEW allRequests;
DROP PROC addAssociationManager;
DROP PROC addNewMatch;
DROP VIEW clubsWithNoMatches;
DROP PROC deleteMatch;
DROP PROC deleteMatchesOnStadium;
DROP PROC addClub;
DROP PROC addTicket;
DROP PROC deleteClub;
DROP PROC addStadium;
DROP PROC deleteStadium;
DROP PROC blockFan;
DROP PROC unblockFan;
DROP PROC addRepresentative;
DROP FUNCTION viewAvailableStadiumsOn;
DROP PROC addHostRequest;
DROP FUNCTION allUnassignedMatches;
DROP PROC addStadiumManager;
DROP FUNCTION allPendingRequests;
DROP PROC acceptRequest;
DROP PROC rejectRequest;
DROP PROC addFan;
DROP FUNCTION upcomingMatchesOfClub;
DROP FUNCTION availableMatchesToAttend;
DROP PROC purchaseTicket;
DROP PROC updateMatchTiming;
DROP VIEW matchesPerTeam;
DROP PROC deleteMatchesOn;
DROP VIEW matchWithMostSoldTickets;
DROP VIEW matchesRankedBySoldTickets;
DROP PROC clubWithTheMostSoldTickets;
DROP VIEW clubsRankedBySoldTickets;
DROP FUNCTION stadiumsNeverPlayedOn;
DROP PROC userLogin;
DROP VIEW playedMatches;
DROP VIEW twoclubsneverplay
DROP VIEW upcomingMatches
END

--1.d
GO
CREATE PROC clearAllTables
AS
BEGIN
DELETE HostRequest;
DELETE TicketBuyingTransactions;
DELETE Ticket;
DELETE Match;
DELETE SportsAssociationManager;
DELETE ClubRepresentitive;
DELETE StadiumManager;
DELETE SystemAdmin;
DELETE Fan;
DELETE Stadium;
DELETE Club;
DELETE SystemUser;
END

--2.a
GO
CREATE VIEW allAssocManagers AS
SELECT SA.username, S.password, SA.name
FROM SystemUser S INNER JOIN SportsAssociationManager SA ON S.username=SA.username

--2.b
GO
CREATE VIEW allClubRepresentatives AS
SELECT CR.username AS Username,S.password AS Password,CR.name AS club_representative,C.name AS Club
FROM ClubRepresentitive CR INNER JOIN SystemUser S ON CR.username=S.username
INNER JOIN Club C ON CR.club_id=C.club_id

--2.c
GO
CREATE VIEW allStadiumManagers AS
SELECT SM.username AS Username,SU.password AS Password,SM.name AS Name,S.name AS Stadium
FROM StadiumManager SM INNER JOIN SystemUser SU ON SM.username=SU.username
INNER JOIN Stadium S ON S.id=SM.stadium_id

--2.d
GO
CREATE VIEW allFans AS
SELECT F.username, S.password, F.name, F.national_id,F.birth_date,CASE WHEN F.status=1 THEN 'unblocked' ELSE 'blocked' END AS status
FROM Fan F INNER JOIN SystemUser S ON F.username=S.username

--2.e
GO
CREATE VIEW allMatches AS
SELECT C1.name AS host, C2.name As away, M.start_time AS startTime,M.end_time AS endTime
FROM Match M INNER JOIN Club C1 ON M.host_club_id=C1.club_id
INNER JOIN Club C2 ON M.guest_club_id=C2.club_id

--2.f
GO
CREATE VIEW allTickets AS
SELECT C1.name AS host,C2.name AS away,S.name AS stadium,M.start_time
FROM Ticket T,Match M,Club C1, Club C2,Stadium S
WHERE T.match_id=M.match_id AND M.host_club_id=C1.club_id 
AND M.guest_club_id=C2.club_id AND M.stadium_id=S.id

--2.g
GO
CREATE VIEW allClubs AS
SELECT name,location 
FROM Club

--2.h
GO
CREATE VIEW allStadiums AS
SELECT name,location,capacity,CASE WHEN status=1 THEN 'available' ELSE 'unavailable' END AS status
FROM Stadium

--2.i
GO
CREATE VIEW allRequests AS
SELECT CR.username AS club_representative, SM.username AS stadium_manager, HR.status
FROM HostRequest HR,ClubRepresentitive CR, StadiumManager SM
WHERE HR.representative_id=CR.id AND HR.manager_id=SM.id

--3.i
GO
CREATE PROCEDURE addAssociationManager 
@name VARCHAR(20), 
@username VARCHAR(20), 
@password VARCHAR(20),
@successful BIT OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT username FROM SystemUser WHERE username=@username)
	BEGIN
	INSERT INTO SystemUser(username, password)
	VALUES (@username, @password);

	INSERT INTO SportsAssociationManager(name, username)
	VALUES (@name, @username);
	SET @successful=1;
	END
	ELSE BEGIN
	SET @successful=0;
	END;
END;


--3.ii
GO
CREATE PROCEDURE addNewMatch 
@hostClubName VARCHAR(20), 
@guestClubName VARCHAR(20), 
@startTime DATETIME, 
@endTime DATETIME
AS
BEGIN
DECLARE @HOST_ID INT ,@GUEST_ID INT
	SELECT @HOST_ID=c1.club_id ,@GUEST_ID=c2.club_id
	FROM Club c1, Club c2
	WHERE c1.name = @hostClubName AND c2.name = @guestClubName

	INSERT INTO Match(start_time, end_time, host_club_id, guest_club_id) 
	VALUES(@startTime,@endTime,@HOST_ID,@GUEST_ID)

END;


--3.iii
GO
CREATE VIEW clubsWithNoMatches AS
SELECT name
FROM Club
WHERE club_id NOT IN (SELECT host_club_id FROM Match) AND club_id NOT IN (SELECT guest_club_id FROM Match);

--3.iv
GO 
CREATE PROCEDURE deleteMatch
@hostClubName VARCHAR(20), 
@guestClubName VARCHAR(20),
@starttime DATETIME,
@endtime DATETIME
AS 
BEGIN
DELETE FROM Match where (
host_club_id=(SELECT C1.club_id FROM Club C1 where (C1.name =@hostClubName ))
and guest_club_id=(SELECT C2.club_id FROM Club C2  where (C2.name=@guestClubName))
AND start_time=@starttime AND end_time=@endtime
)
END

--3.v
GO
CREATE PROCEDURE deleteMatchesOnStadium
@stadiumname VARCHAR(20)
AS 
BEGIN
DELETE FROM Match where (
stadium_id=(SELECT stadium_id FROM Stadium  where (name=@stadiumname ))
)
END

--3.vi
GO
CREATE PROCEDURE addClub
@club_name VARCHAR(20),
@club_location VARCHAR(20)
AS 
BEGIN
IF NOT EXISTS (SELECT * FROM Club C WHERE C.name=@club_name)
BEGIN
INSERT INTO Club(name,location)
VALUES(@club_name,@club_location);
END
END

--3.vii
GO
CREATE PROCEDURE addTicket
@host_club_name VARCHAR(20),
@guest_club_name VARCHAR(20),
@match_start_time DATETIME
AS 
BEGIN
DECLARE @MATCH_ID INT
SELECT @MATCH_ID=m.match_id from Match m where ( m.start_time=@match_start_time and ( m.host_club_id =  (SELECT club_id from club c1 WHERE c1.name=@host_club_name))and
( m.guest_club_id =  (SELECT CLUB_id from club c2 WHERE c2.name=@guest_club_name)))   
INSERT INTO Ticket(status,match_id)
VALUES(1,@MATCH_ID)
END

--3.viii
GO
CREATE PROCEDURE deleteClub
@club_name VARCHAR(20)
AS 
BEGIN
DECLARE @rep_username VARCHAR(20)
SELECT @rep_username=cr.username
FROM Club c , ClubRepresentitive cr
WHERE c.club_id=cr.club_id

DELETE FROM ClubRepresentitive WHERE username=@rep_username
DELETE FROM SystemUser WHERE username=@rep_username
DELETE FROM club where (name=@club_name)
END

--3.ix
GO
CREATE PROCEDURE addStadium
@stadium_name VARCHAR(20),
@stadium_location VARCHAR(20),
@capacity INT
AS 
BEGIN
IF NOT EXISTS (SELECT * FROM Stadium WHERE name=@stadium_name)
BEGIN
INSERT INTO Stadium(name,location,capacity,status)
VALUES(@stadium_name,@stadium_location,@capacity,1);
END
END

--3.x
GO
CREATE PROCEDURE deleteStadium
@st_name VARCHAR(20)
AS 
BEGIN
DECLARE @stadium_id INT,
@username_manager VARCHAR(20)
SELECT @stadium_id=s.id,@username_manager=sm.username  FROM Stadium s,StadiumManager sm
WHERE( sm.stadium_id=s.id AND s.name=@st_name)
DELETE FROM StadiumManager WHERE (stadium_id=@stadium_id)
DELETE FROM SystemUser WHERE (username=@username_manager)
DELETE FROM Stadium WHERE (name=@st_name)
END


--3.xi
GO
CREATE PROCEDURE blockFan
@id VARCHAR(20)
AS
BEGIN
UPDATE FAN 
SET status=0
WHERE (national_id=@id)
END

--3.xii
GO
CREATE PROCEDURE unblockFan
@id VARCHAR(20)
AS
BEGIN
UPDATE FAN 
SET status=1
WHERE (national_id=@id)
END

--3.xiii
GO
CREATE PROCEDURE addRepresentative
@name VARCHAR(20) ,
@club_name VARCHAR(20),
@user_name VARCHAR(20),
@password VARCHAR(20),
@successful INT OUTPUT
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Club WHERE name=@club_name)OR EXISTS (SELECT * FROM ClubRepresentitive WHERE club_id=(SELECT id FROM Club WHERE name=@club_name))
SET @successful = 2;
ELSE
BEGIN
IF NOT EXISTS (SELECT username FROM SystemUser WHERE username=@user_name) 
BEGIN
INSERT INTO SystemUser(username,password)
VALUES(@user_name,@password);
INSERT INTO		ClubRepresentitive(name,username,club_id)
VALUES(@name,@user_name,
(   SELECT club_id From club C1 where (c1.name=@club_name)   )
)
SET @successful=1;
END
ELSE
BEGIN
SET @successful=0;
END
END
END
--3.xiv
GO
CREATE FUNCTION viewAvailableStadiumsOn
(@date DATETIME)
RETURNS TABLE
AS
RETURN (
(
SELECT S.name,S.location,S.capacity
FROM Stadium S, Match M
WHERE (S.status = 1 AND S.id=M.stadium_id AND @date NOT BETWEEN M.start_time AND M.end_time)
)
UNION
(
SELECT S1.name,S1.location,S1.capacity
FROM Stadium S1
WHERE S1.status = 1 AND NOT EXISTS(SELECT * FROM Stadium S2,Match M WHERE S1.id=S2.id AND S2.id=M.stadium_id)
))

--3.xv
GO
CREATE PROCEDURE addHostRequest
@club_name VARCHAR(20),
@stadium_name VARCHAR(20),
@start_time DATETIME
AS
BEGIN
INSERT INTO HostRequest (representative_id,manager_id,match_id,status)
VALUES(
(SELECT cr.id FROM Club c, ClubRepresentitive cr WHERE (cr.club_id=c.club_id and c.name=@club_name)),
(SELECT sm.id FROM Stadium s,StadiumManager sm  WHERE (s.id=sm.stadium_id and s.name=@stadium_name)),
(SELECT m.match_id FROM Match m WHERE ( (m.start_time=@start_time)
AND (m.host_club_id=(SELECT C1.club_id FROM Club C1 where c1.name=@club_name  ))) ),
'unhandled'
);
END;

--3.xvi
GO
CREATE FUNCTION allUnsignedMatches
(@club_name VARCHAR(20))
RETURNS TABLE
AS
RETURN (
SELECT C2.name,M.start_time
FROM Club C1,Match M,Club C2
WHERE @club_name=C1.name AND M.stadium_id IS NULL 
AND C1.club_id=M.host_club_id AND C2.club_id=M.guest_club_id 
);
--3.xvii
GO
CREATE PROCEDURE addStadiumManager
@name VARCHAR(20) ,
@st_name VARCHAR(20),
@user_name VARCHAR(20),
@password VARCHAR(20),
@successful INT OUTPUT
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Stadium WHERE name=@st_name) OR EXISTS (SELECT * FROM StadiumManager WHERE stadium_id=(SELECT id FROM Stadium WHERE name=@st_name))
SET @successful=2
ELSE
BEGIN
IF NOT EXISTS (SELECT username FROM SystemUser WHERE username=@user_name)
BEGIN
INSERT INTO SystemUser(username,password)
VALUES(@user_name,@password);
INSERT INTO StadiumManager(name,username,stadium_id)
VALUES(@name,@user_name,
(   SELECT id From Stadium s where (s.name=@st_name)   )
)
SET @successful=1;
END
ELSE
BEGIN
SET @successful=0;
END
END
END

--3.xviii
GO
CREATE FUNCTION allPendingRequests
(@stadiummanager_username VARCHAR(20) )
RETURNS TABLE
AS
RETURN(
SELECT cr.name AS Club_representative,c.name AS Guest_club,m.start_time AS start_time
FROM HostRequest hr ,StadiumManager sm,ClubRepresentitive cr,Match m,Club c
WHERE( sm.username=@stadiummanager_username and sm.id=hr.manager_id
and hr.representative_id=cr.id and hr.match_id=m.match_id and m.guest_club_id=c.club_id
and hr.status='unhandled'
));

--3.xix 

GO
CREATE PROC acceptRequest
@stadium_manager_username VARCHAR(20),
@host_club_name VARCHAR(20),
@guest_club_name VARCHAR(20),
@start_time DATETIME
AS
BEGIN
DECLARE 
@st_id INT,
@hclub_id INT,
@gclub_id INT,
@req_id INT

SELECT @st_id=sm.stadium_id,@gclub_id=m.guest_club_id,@hclub_id=m.host_club_id ,@req_id=hr.id
FROM HostRequest hr,StadiumManager sm ,Match m , Club gc ,Club hc 
WHERE(
hc.club_id = m.host_club_id AND hr.match_id = m.match_id AND sm.id = hr.manager_id AND gc.club_id=m.guest_club_id 
 AND sm.username = @stadium_manager_username AND hc.name = @host_club_name
AND gc.name = @guest_club_name AND m.start_time = @start_time
);

UPDATE HostRequest
SET status = 'accepted'
WHERE(id=@req_id )
UPDATE MATCH 
SET stadium_id=@st_id
WHERE(host_club_id=@hclub_id AND guest_club_id=@gclub_id AND start_time=@start_time)


DECLARE @i INT =0
WHILE (@i<(SELECT capacity FROM Stadium WHERE ID=@st_id))
	BEGIN 
		EXEC addTicket @host_club_name,@guest_club_name,@start_time
		SET @i+=1
	END
END;
--3.xx

GO
CREATE PROC rejectRequest
@stadium_manager_username VARCHAR(20),
@host_club_name VARCHAR(20),
@guest_club_name VARCHAR(20),
@start_time DATETIME
AS
BEGIN

DECLARE @hclub_id INT,
@gclub_id INT,
@req_id INT,
@match_id INT
SELECT @gclub_id=m.guest_club_id,@hclub_id=m.host_club_id ,@req_id=hr.id,@match_id=m.match_id
FROM HostRequest hr,StadiumManager sm ,Match m , Club gc ,Club hc 
WHERE(
hc.club_id = m.host_club_id AND hr.match_id = m.match_id AND sm.id = hr.manager_id AND gc.club_id=m.guest_club_id 
 AND sm.username = @stadium_manager_username AND hc.name = @host_club_name
AND gc.name = @guest_club_name AND m.start_time = @start_time
)


UPDATE HostRequest
SET status = 'rejected'
WHERE(id=@req_id )

UPDATE MATCH 
SET stadium_id = NULL
WHERE(host_club_id=@hclub_id AND guest_club_id=@gclub_id AND start_time=@start_time)

DELETE FROM TICKET 
WHERE (match_id=@match_id)
END;
--3.xxi
GO
CREATE PROC addFan
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@national_id_number VARCHAR(20),
@birth_date DATETIME,
@address VARCHAR(20),
@phone VARCHAR(20),
@successful INT OUTPUT
AS
BEGIN
IF NOT EXISTS (SELECT username FROM SystemUser WHERE username=@username)
BEGIN
IF NOT EXISTS (SELECT * FROM Fan WHERE national_id=@national_id_number)
BEGIN
INSERT INTO SystemUser(username,password) VALUES(@username,@password);

INSERT INTO Fan(national_id,name,birth_date,address,phone_number,status,username)
VALUES(@national_id_number,@name,@birth_date,@address,@phone,1,@username)
SET @successful=1;
END
ELSE
SET @successful=2;
END
ELSE
BEGIN
SET @successful=0;
END
END;
--3.xxii
GO 
CREATE FUNCTION  MatchesOfClub(@clubName VARCHAR(20))
RETURNS TABLE
AS
RETURN
    (SELECT
        c1.name AS given_club_name,
        c2.name AS competing_club_name,
        m.start_time AS match_start_time,
        s.name AS stadium_name
    FROM Match m
    INNER JOIN Club c1 ON m.host_club_id = c1.club_id
    INNER JOIN Club c2 ON m.guest_club_id = c2.club_id
    INNER JOIN Stadium s ON m.stadium_id = s.id
    WHERE c1.name = @clubName AND m.start_time > GETDATE()
	)
	UNION
	(SELECT
        c1.name AS given_club_name,
        c2.name AS competing_club_name,
        m.start_time AS match_start_time,
        s.name AS stadium_name
    FROM Match m
    INNER JOIN Club c1 ON m.guest_club_id = c1.club_id
    INNER JOIN Club c2 ON m.host_club_id= c2.club_id
    INNER JOIN Stadium s ON m.stadium_id = s.id
    WHERE c1.name = @clubName AND m.start_time > GETDATE()
	)

--3.xxiii
GO
CREATE FUNCTION availableMatchesToAttend
(@date DATETIME)
RETURNS TABLE
AS
RETURN(
SELECT DISTINCT C1.name AS Host_Club_Name,C2.name AS Guest_Club_Name, M.start_time ,S.name
FROM Match M ,Club C1 ,Club C2 ,Stadium S, Ticket T
WHERE( M.host_club_id=C1.club_id AND M.guest_club_id=c2.club_id AND M.stadium_id=S.id
       AND T.match_id=M.match_id AND m.start_time >= GETDATE() AND  T.status=1

));


--3.xxiv
GO
CREATE PROCEDURE purchaseTicket
(
  @fan_national_id VARCHAR(20),
  @host_club_name VARCHAR(20),
  @guest_club_name VARCHAR(20),
  @start_time DATETIME
)
AS
BEGIN
DECLARE @match_id INT, @ticket_id INT
SELECT @match_id = match_id
FROM Match
INNER JOIN Club host ON host.club_id = Match.host_club_id
INNER JOIN Club guest ON guest.club_id = Match.guest_club_id
WHERE host.name = @host_club_name AND guest.name = @guest_club_name AND start_time = @start_time

SELECT @ticket_id = id
FROM Ticket
WHERE match_id = @match_id AND status = 1
  
  IF ((SELECT status FROM Fan WHERE national_id=@fan_national_id)=1 AND (@ticket_id IS NOT NULL))
  BEGIN
     UPDATE Ticket
     SET status = 0
	 WHERE id = @ticket_id
	 INSERT INTO TicketBuyingTransactions (fan_national_id, ticket_id)
	 VALUES (@fan_national_id, @ticket_id)
   END;

END;
--3.xxv
GO
CREATE PROC updateMatchTiming 
@host_club_name VARCHAR(20),
@guest_club_name VARCHAR(20),
@current_start VARCHAR(20),
@new_start VARCHAR(20),
@new_end VARCHAR(20)
AS
BEGIN
DECLARE @host_id INT,@guest_id INT
SELECT @host_id=c1.club_id, @guest_id=c2.club_id
FROM Match m ,Club c1 , Club c2
WHERE m.host_club_id=c1.club_id AND m.guest_club_id=c2.club_id
AND c1.name=@host_club_name AND c2.name=@guest_club_name
UPDATE Match
SET start_time=@new_start ,end_time=@new_end
where(start_time=@current_start and host_club_id=@host_id 
AND guest_club_id=@guest_id)
END;

--3.xxvi
GO 
CREATE VIEW matchesPerTeam AS
SELECT c.name AS club_name, COUNT(m.match_id) AS total_matches
FROM Club c
LEFT OUTER JOIN Match m ON c.club_id = m.host_club_id OR c.club_id = m.guest_club_id
GROUP BY c.name;


--3.xxvii
GO
CREATE PROCEDURE deleteMatchesOn 
@given_date DATETIME
AS
BEGIN
DELETE FROM Match 
WHERE DAY(start_time)=DAY(@given_date) AND
MONTH(start_time)=MONTH(@given_date)AND
YEAR(start_time)=YEAR(@given_date)
END;

--3.xxviii
GO
CREATE VIEW  matchWithMostSoldTickets AS
SELECT TOP 1 WITH TIES c1.name AS host_club_name, c2.name AS guest_club_name
FROM Match m INNER JOIN Club c1 ON c1.club_id = m.host_club_id
INNER JOIN Club c2 ON c2.club_id = m.guest_club_id INNER JOIN Ticket t ON t.match_id = m.match_id
WHERE T.status=0
GROUP BY m.match_id, c1.name, c2.name
ORDER BY COUNT(t.id) DESC

--3.xxix
GO
CREATE VIEW matchesRankedBySoldTickets AS
SELECT c1.name AS host_club_name, c2.name AS guest_club_name, COUNT(t.id) AS num_tickets
FROM Match m INNER JOIN Club c1 ON c1.club_id = m.host_club_id
INNER JOIN Club c2 ON c2.club_id = m.guest_club_id INNER JOIN Ticket t ON t.match_id = m.match_id
WHERE t.status = 0
GROUP BY m.match_id, c1.name, c2.name
ORDER BY num_tickets DESC OFFSET 0 ROWS;

--3.xxx
GO
CREATE PROC clubWithTheMostSoldTickets
@club_name VARCHAR(20) OUTPUT
AS
BEGIN
SELECT TOP 1 @club_name=C.name
FROM Club C INNER JOIN Match M ON (C.club_id=M.host_club_id OR C.club_id=M.guest_club_id)
INNER JOIN Ticket T ON T.match_id=M.match_id
WHERE T.status=0
GROUP BY C.name
ORDER BY COUNT(T.id) DESC
PRINT @club_name
END;

--3.xxxi
GO

CREATE VIEW clubsRankedBySoldTickets
AS
SELECT C.name,COUNT(T.id) AS num_tickets
FROM Club C INNER JOIN Match M ON (C.club_id=M.host_club_id OR C.club_id=M.guest_club_id)
INNER JOIN Ticket T ON T.match_id=M.match_id
WHERE T.status=0
GROUP BY C.name
ORDER BY COUNT(T.id) DESC OFFSET 0 ROWS

--3.xxxii
GO 
CREATE FUNCTION stadiumsNeverPlayedOn 
(@clubname VARCHAR(20)) 
RETURNS TABLE 
AS
RETURN(
SELECT DISTINCT S.name, S.capacity
FROM Stadium S
EXCEPT
SELECT S1.name,S1.capacity
FROM MATCH M,CLUB C,STADIUM S1
WHERE  C.name=@clubname AND( C.club_id=M.guest_club_id OR C.club_id=M.host_club_id) AND M.stadium_id= S1.id
)

GO

--Milestone 3 additional Procedures
CREATE PROC userLogin
@username VARCHAR(20),
@password VARCHAR(20),
@success bit output,
@type int output,
@error int output
AS
BEGIN

IF EXISTS (SELECT username,password FROM SystemUser WHERE username=@username AND password=@password)
BEGIN
SET @success=1
IF EXISTS (SELECT username FROM SystemAdmin WHERE username=@username)
BEGIN
SET @type=1
END
IF EXISTS (SELECT username FROM SportsAssociationManager WHERE username=@username)
BEGIN
SET @type=2
END
IF EXISTS (SELECT username FROM ClubRepresentitive WHERE username=@username)
BEGIN
SET @type=3
END
IF EXISTS (SELECT username FROM StadiumManager WHERE username=@username)
BEGIN
SET @type=4
END
IF EXISTS (SELECT username FROM Fan WHERE username=@username)
BEGIN
SET @type=5
IF EXISTS (SELECT username FROM Fan WHERE username=@username AND status=0)
BEGIN 
SET @success=0
SET @error=2
END
END
END
ELSE
BEGIN
SET @success=0
SET @type=0
SET @error=1
END
END

GO
CREATE VIEW playedMatches AS
SELECT C1.name AS Host, C2.name AS Guest, M.start_time AS 'Start Time', M.end_time AS 'End Time'
FROM Match M INNER JOIN Club C1 ON M.host_club_id=C1.club_id
INNER JOIN Club C2 ON M.guest_club_id=C2.club_id
WHERE M.start_time < CURRENT_TIMESTAMP;

GO
CREATE VIEW twoclubsneverplay
AS
SELECT C1.name AS 'First Club',C2.name AS 'Second Club'
FROM CLUB C1,CLUB C2 
WHERE NOT EXISTS (
select *
FROM Match M
WHERE (M.guest_club_id=C1.club_id AND M.host_club_id=C2.club_id) OR (M.guest_club_id=C2.club_id AND M.host_club_id=C1.club_id)
) AND C1.club_id<C2.club_id;

GO 
CREATE VIEW upcomingMatches AS
SELECT C1.name AS Host, C2.name As Guest, M.start_time AS 'Start Time',M.end_time AS 'End Time'
FROM Match M INNER JOIN Club C1 ON M.host_club_id=C1.club_id
INNER JOIN Club C2 ON M.guest_club_id=C2.club_id
WHERE M.start_time>=CURRENT_TIMESTAMP

GO
CREATE PROC repClubInfo
@username VARCHAR(20)
AS
BEGIN
SELECT C.club_id AS 'Club ID',C.name AS 'Club Name',C.location AS Location
FROM Club C INNER JOIN ClubRepresentitive CR ON CR.club_id=C.club_id
WHERE CR.username=@username
END

GO
CREATE PROC repUpcomingMatch
@username VARCHAR(20)
AS
BEGIN
SELECT C1.name AS Host,C2.name AS Guest,M.start_time AS 'Start Time',M.end_time AS 'End Time',S.name AS Stadium 
FROM Club C1 INNER JOIN Match M ON M.host_club_id=C1.club_id
INNER JOIN Club C2 ON M.guest_club_id=C2.club_id
LEFT OUTER JOIN Stadium S ON (M.stadium_id=S.id)
WHERE M.start_time >= CURRENT_TIMESTAMP 
AND EXISTS (SELECT * FROM ClubRepresentitive WHERE username=@username AND (club_id=C1.club_id OR club_id=C2.club_id))
END

GO
CREATE PROC viewAvailableStadiumsOnDate
@date DATETIME
AS
BEGIN
(
SELECT S.name AS 'Stadium Name',S.location AS Location,S.capacity AS Capacity
FROM Stadium S, Match M
WHERE (S.status = 1 AND S.id=M.stadium_id AND @date NOT BETWEEN M.start_time AND M.end_time)
)
UNION
(
SELECT S1.name AS 'Stadium Name',S1.location AS Location,S1.capacity AS Capacity
FROM Stadium S1
WHERE S1.status = 1 AND NOT EXISTS(SELECT * FROM Stadium S2,Match M WHERE S1.id=S2.id AND S2.id=M.stadium_id)
)
END

GO
CREATE PROC getClubName
@username VARCHAR(20),
@cname VARCHAR(20) OUTPUT
AS
BEGIN
SET @cname=(SELECT C.name
FROM Club C INNER JOIN ClubRepresentitive CR ON CR.club_id=C.club_id
WHERE CR.username=@username)
END

GO
CREATE PROC getStadiumName
@username VARCHAR(20),
@sname VARCHAR(20) OUTPUT
AS
BEGIN
SET @sname=(SELECT S.name FROM Stadium S INNER JOIN StadiumManager SM ON SM.stadium_id=S.id WHERE SM.username=@username)
END

GO
CREATE PROC stadiumInfo
@sname VARCHAR(20)
AS
BEGIN
SELECT S.id AS 'Stadium ID',S.name AS 'Stadium Name',S.location AS 'Location',S.capacity AS 'Capacity',S.status AS 'Status'
FROM Stadium S WHERE S.name=@sname
END

GO
CREATE PROC allStadRequests
@username VARCHAR(20)
AS
SELECT CR.name AS Representative, C1.name AS Host, C2.name AS Guest, M.start_time AS 'Start Time',M.end_time AS 'End Time',HR.status AS 'Status'
FROM HostRequest HR INNER JOIN StadiumManager SM ON HR.manager_id=SM.id
INNER JOIN ClubRepresentitive CR ON CR.id=HR.representative_id
INNER JOIN Match M ON M.match_id=HR.match_id
INNER JOIN Club C1 ON M.host_club_id=C1.club_id
INNER JOIN Club C2 ON M.guest_club_id=C2.club_id
WHERE SM.username=@username AND HR.status='unhandled';

GO
CREATE VIEW allMatches2 AS
SELECT C1.name AS Host, C2.name AS Guest, S.name AS Stadium, S.location AS 'Stadium Location'
FROM Club C1 INNER JOIN Match M ON M.host_club_id=C1.club_id
INNER JOIN Club C2 ON M.guest_club_id=C2.club_id
INNER JOIN Stadium S ON M.stadium_id=S.id

GO
CREATE PROC getNatId
@username VARCHAR(20),
@nat VARCHAR(20) OUTPUT
AS
BEGIN
SELECT @nat=national_id FROM Fan WHERE username=@usernameG
END


INSERT INTO SystemUser VALUES ('admin','admin')
INSERT INTO SystemAdmin(username,name) VALUES ('admin','Omar')

select * from club
select * from ClubRepresentitive
select * from SystemUser
select * from HostRequest

select * from ticket