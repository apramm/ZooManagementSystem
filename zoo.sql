
drop table Zoo1;
drop table Zoo2;
drop table ZooManager;
drop table Order1;
drop table Ticket1;
drop table Ticket2;
drop table Animal1;
drop table FeatureAnimal1;
drop table ResidentAnimal1;
drop table Habitat1;
drop table Habitat2;
drop table Exhibits;
drop table TemporaryVisit;
drop table FoodVendor1;
drop table FoodVendor2;

CREATE TABLE Zoo1 (
    zName CHAR(32) PRIMARY KEY,
    city CHAR(32)
);

CREATE TABLE Zoo2 (
   zooID INTEGER PRIMARY KEY,
   zName CHAR(32),
   province CHAR(32),
   employeeID INTEGER NOT NULL,
   UNIQUE (employeeID)
);

CREATE TABLE ZooManager (
    eName CHAR(32),
    employeeID INTEGER,
    joinDate DATE,
    zooID INTEGER NOT NULL,
    UNIQUE (zooID),
    PRIMARY KEY (employeeID),
    FOREIGN KEY (zooID)
        REFERENCES Zoo2(zooID)
        ON DELETE CASCADE
);

ALTER TABLE Zoo2
    ADD FOREIGN KEY (employeeID)
        REFERENCES ZooManager(employeeID)
        ON DELETE CASCADE;

CREATE TABLE Order1 (
    orderNumber INTEGER,
    orderDate DATE,
    paymentMethod CHAR(4),
    zooID INTEGER NOT NULL,
    PRIMARY KEY (orderNumber),
    FOREIGN KEY (zooID)
        REFERENCES Zoo2(zooID)
        ON DELETE CASCADE
);

CREATE TABLE Ticket1 (
    ticketType CHAR(4) PRIMARY KEY,
    price REAL
);

CREATE TABLE Ticket2 (
    ticketID INTEGER,
    orderNumber INTEGER,
    ticketType CHAR(4),
    PRIMARY KEY (ticketID, orderNumber),
    FOREIGN KEY (orderNumber)
        REFERENCES Order1(orderNumber)
        ON DELETE CASCADE
);

CREATE TABLE Exhibits (
    exhibitID INTEGER,
    exhibitTitle CHAR(32),
    visitorCapacity INTEGER,
    popularityRating INTEGER,
    zooID INTEGER NOT NULL,
    PRIMARY KEY (exhibitID),
    FOREIGN KEY (zooID)
        REFERENCES Zoo2(zooID)
        ON DELETE CASCADE
);

CREATE TABLE Habitat1 (
    habitatType CHAR(32),
    humidity REAL,
    temperature REAL,
    PRIMARY KEY (habitatType)
);

CREATE TABLE Habitat2 (
    habitatID INTEGER,
    exhibitID INTEGER,
    habitatType CHAR(32),
    vegetation CHAR(32),
    PRIMARY KEY (habitatID),
    FOREIGN KEY (exhibitID)
        REFERENCES Exhibits(exhibitID)
        ON DELETE CASCADE
);

CREATE TABLE Animal1 (
    species CHAR(32) PRIMARY KEY,
    conservationStatus CHAR(4)
);

CREATE TABLE ResidentAnimal1 (
    animalID INTEGER,
    habitatID INTEGER NOT NULL,
    species CHAR(32),
    sex CHAR(2),
    age INTEGER,
    healthStatus CHAR(4),
    conservationStatus CHAR(4),
    monthsAtZoo INTEGER,
    favouriteFood CHAR(32),
    PRIMARY KEY (animalID),
    FOREIGN KEY (habitatID)
        REFERENCES Habitat2(habitatID)
        ON DELETE CASCADE
);

CREATE TABLE FeatureAnimal1 (
    animalID INTEGER,
    habitatID INTEGER NOT NULL,
    species CHAR(32),
    sex CHAR(2),
    age INTEGER,
    healthStatus CHAR(4),
    originLocation CHAR(32),
    PRIMARY KEY (animalID),
    FOREIGN KEY (habitatID)
        REFERENCES Habitat2(habitatID)
        ON DELETE CASCADE
);

CREATE TABLE TemporaryVisit (
    startDate DATE,
    endDate DATE,
    animalID INTEGER,
    employeeID INTEGER,
    PRIMARY KEY (startDate, endDate, animalID),
    FOREIGN KEY (employeeID)
        REFERENCES ZooManager(employeeID)
        ON DELETE CASCADE,
    FOREIGN KEY (animalID)
        REFERENCES FeatureAnimal1(animalID)
        ON DELETE CASCADE
);

CREATE TABLE FoodVendor1 (
    vName CHAR(32) PRIMARY KEY,
    foodType CHAR(32)
);

CREATE TABLE FoodVendor2 (
    vendorID INTEGER,
    vName CHAR(32),
    rating REAL,
    zooID INTEGER NOT NULL,
    PRIMARY KEY (vendorID),
    FOREIGN KEY (zooID)
        REFERENCES Zoo2(zooID)
        ON DELETE CASCADE
);

