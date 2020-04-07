DROP TABLE IF EXISTS concertEvents;

CREATE TABLE concertEvents (
    eventID	INT(11) NOT NULL
  , name	VARCHAR(128) NOT NULL
  , venue	VARCHAR(128) NOT NULL
  , perfDate	DATE NOT NULL
  , tksSold	INT(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 WITH SYSTEM VERSIONING;

INSERT INTO concertEvents VALUES
    (1,'Metallica with The San Francisco Symphony','Chase Center',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ), 6)
  , (2,'HG & EV: Huevos Revueltos','SAP Center',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),7)
  , (3,'Wicked San Jose','San Jose Center for the Performing Arts',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),8)
  , (4,'Smashing Pumpkins & Noel Gallagher','Shoreline Amphitheatre',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),9)
  , (5,'Hot Chip','Fox Theater Oakland',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),10)
  , (6,'The Cure: Live at the Shoreline','Shoreline Amphitheatre',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),11)
  , (7,'Miguel Bose: Papito Tour','Fox Theater Oakland',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),12)
  , (8,'Sleater Kinney','Fox Theater Oakland',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),13)
  , (9,'Van Morrison','Greek Theater Berkeley',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),6)
  , (10,'KoRn with Alice in Chains','Shoreline Amphitheatre',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),7)
  , (11,'Dave Matthews Band','Chase Center',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),8)
  , (12,'Lana Del Rey','Greek Theatre Berkley',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),9)
  , (13,'Vampire Weekend','Bill Graham Civic Auditorium',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),10)
  , (14,'Hamilton San Francisco','Orpheum Theatre San Francisco',DATE_ADD(NOW(), INTERVAL + FLOOR( 1 + RAND( ) * 100) DAY ),14);
