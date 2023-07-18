
drop table Zoo1 CASCADE CONSTRAINTS;
drop table Zoo2 CASCADE CONSTRAINTS;
drop table ZooManager CASCADE CONSTRAINTS;
drop table Order1 CASCADE CONSTRAINTS;
drop table Ticket1 CASCADE CONSTRAINTS;
drop table Ticket2 CASCADE CONSTRAINTS;
drop table Animal1 CASCADE CONSTRAINTS;
drop table FeatureAnimal1 CASCADE CONSTRAINTS;
drop table ResidentAnimal1 CASCADE CONSTRAINTS;
drop table Habitat1 CASCADE CONSTRAINTS;
drop table Habitat2 CASCADE CONSTRAINTS;
drop table Exhibits CASCADE CONSTRAINTS;
drop table TemporaryVisit CASCADE CONSTRAINTS;
drop table FoodVendor1 CASCADE CONSTRAINTS;
drop table FoodVendor2 CASCADE CONSTRAINTS;

CREATE TABLE Zoo1 (
    zName CHAR(32) PRIMARY KEY,
    city CHAR(32)
);

INSERT ALL
  INTO Zoo1 (zName, city) VALUES ('Toronto Zoo', 'Toronto')
  INTO Zoo1 (zName, city) VALUES ('Greater Vancouver Zoo', 'Vancouver')
  INTO Zoo1 (zName, city) VALUES ('Winnipeg Zoo', 'Winnipeg')
  INTO Zoo1 (zName, city) VALUES ('Victoria Bug Zoo', 'Victoria')
  INTO Zoo1 (zName, city) VALUES ('Edmonton Valley Zoo', 'Edmonton')
SELECT 1 FROM DUAL;

CREATE TABLE Zoo2 (
   zooID INTEGER PRIMARY KEY,
   zName CHAR(32),
   province CHAR(32),
   employeeID INTEGER NOT NULL,
   UNIQUE (employeeID)
);

INSERT ALL
  INTO Zoo2 (zooID, zName, province, employeeID) VALUES (1, 'Toronto Zoo', 'ON', 101)
  INTO Zoo2 (zooID, zName, province, employeeID) VALUES (2, 'Greater Vancouver Zoo', 'BC', 102)
  INTO Zoo2 (zooID, zName, province, employeeID) VALUES (3, 'Winnipeg Zoo', 'MB', 103)
  INTO Zoo2 (zooID, zName, province, employeeID) VALUES (4, 'Victoria Bug Zoo', 'BC', 104)
  INTO Zoo2 (zooID, zName, province, employeeID) VALUES (5, 'Edmonton Valley Zoo', 'AB', 105)
  INTO Zoo2 (zooID, zName, province, employeeID) VALUES (6, 'Montreal Biodome', 'QC', 106)
SELECT 1 FROM DUAL;

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

INSERT ALL
  INTO ZooManager (eName, employeeID, joinDate, zooID) VALUES ('John Smith', 101, DATE '2022-01-15', 1)
  INTO ZooManager (eName, employeeID, joinDate, zooID) VALUES ('Emily Johnson', 102, DATE '2021-06-28', 2)
  INTO ZooManager (eName, employeeID, joinDate, zooID) VALUES ('Michael Williams', 103, DATE '2023-03-10', 3)
  INTO ZooManager (eName, employeeID, joinDate, zooID) VALUES ('Sophia Brown', 104, DATE '2022-09-05', 4)
  INTO ZooManager (eName, employeeID, joinDate, zooID) VALUES ('Daniel Davis', 105, DATE '2021-12-01', 5)
  INTO ZooManager (eName, employeeID, joinDate, zooID) VALUES ('Olivia Wilson', 106, DATE '2023-04-18', 6)
SELECT 1 FROM DUAL;

ALTER TABLE Zoo2
    ADD FOREIGN KEY (employeeID)
        REFERENCES ZooManager(employeeID)
        ON DELETE CASCADE;

CREATE TABLE Order1 (
    orderNumber INTEGER,
    orderDate DATE,
    paymentMethod CHAR(6),
    zooID INTEGER NOT NULL,
    PRIMARY KEY (orderNumber),
    FOREIGN KEY (zooID)
        REFERENCES Zoo2(zooID)
        ON DELETE CASCADE
);

INSERT ALL
  INTO Order1 (orderNumber, orderDate, paymentMethod, zooID) VALUES (101, DATE '2023-01-15', 'CC', 1)
  INTO Order1 (orderNumber, orderDate, paymentMethod, zooID) VALUES (102, DATE '2023-02-20', 'PayPal', 2)
  INTO Order1 (orderNumber, orderDate, paymentMethod, zooID) VALUES (103, DATE '2023-03-10', 'CC', 1)
  INTO Order1 (orderNumber, orderDate, paymentMethod, zooID) VALUES (104, DATE '2023-04-05', 'Cash', 3)
  INTO Order1 (orderNumber, orderDate, paymentMethod, zooID) VALUES (105, DATE '2023-05-18', 'PayPal', 2)
  INTO Order1 (orderNumber, orderDate, paymentMethod, zooID) VALUES (106, DATE '2023-06-01', 'CC', 4)
SELECT 1 FROM DUAL;

CREATE TABLE Ticket1 (
    ticketType CHAR(7) PRIMARY KEY,
    price REAL
);

INSERT ALL
  INTO Ticket1 (ticketType, price) VALUES ('Adult', 20.99)
  INTO Ticket1 (ticketType, price) VALUES ('Child', 10.99)
  INTO Ticket1 (ticketType, price) VALUES ('Senior', 15.99)
  INTO Ticket1 (ticketType, price) VALUES ('Student', 17.99)
  INTO Ticket1 (ticketType, price) VALUES ('Family', 45.99)
  INTO Ticket1 (ticketType, price) VALUES ('Group', 12.99)
SELECT 1 FROM DUAL;

CREATE TABLE Ticket2 (
    ticketID INTEGER,
    orderNumber INTEGER,
    ticketType CHAR(7),
    PRIMARY KEY (ticketID, orderNumber),
    FOREIGN KEY (orderNumber)
        REFERENCES Order1(orderNumber)
        ON DELETE CASCADE
);

INSERT ALL
  INTO Ticket2 (ticketID, orderNumber, ticketType) VALUES (1001, 101, 'Adult')
  INTO Ticket2 (ticketID, orderNumber, ticketType) VALUES (1002, 102, 'Child')
  INTO Ticket2 (ticketID, orderNumber, ticketType) VALUES (1003, 103, 'Adult')
  INTO Ticket2 (ticketID, orderNumber, ticketType) VALUES (1004, 104, 'Senior')
  INTO Ticket2 (ticketID, orderNumber, ticketType) VALUES (1005, 105, 'Child')
  INTO Ticket2 (ticketID, orderNumber, ticketType) VALUES (1006, 106, 'Student')
SELECT 1 FROM DUAL;

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

INSERT ALL
  INTO Exhibits (exhibitID, exhibitTitle, visitorCapacity, popularityRating, zooID)
  VALUES (1, 'Big Cat', 100, 9, 1)
  INTO Exhibits (exhibitID, exhibitTitle, visitorCapacity, popularityRating, zooID)
  VALUES (2, 'Rainforest Adventure', 150, 8, 2)
  INTO Exhibits (exhibitID, exhibitTitle, visitorCapacity, popularityRating, zooID)
  VALUES (3, 'Grassland Safari', 80, 7, 1)
  INTO Exhibits (exhibitID, exhibitTitle, visitorCapacity, popularityRating, zooID)
  VALUES (4, 'Desert Oasis', 50, 6, 3)
  INTO Exhibits (exhibitID, exhibitTitle, visitorCapacity, popularityRating, zooID)
  VALUES (5, 'Tropical Paradise', 120, 9, 2)
  INTO Exhibits (exhibitID, exhibitTitle, visitorCapacity, popularityRating, zooID)
  VALUES (6, 'Savanna Safari', 90, 7, 1)
SELECT 1 FROM DUAL;


CREATE TABLE Habitat1 (
    habitatType CHAR(32),
    humidity REAL,
    temperature REAL,
    PRIMARY KEY (habitatType)
);

INSERT ALL
  INTO Habitat1 (habitatType, humidity, temperature)
  VALUES ('Savanna', 60.5, 30.2)
  INTO Habitat1 (habitatType, humidity, temperature)
  VALUES ('Rainforest', 80.2, 25.8)
  INTO Habitat1 (habitatType, humidity, temperature)
  VALUES ('Desert', 20.8, 40.6)
  INTO Habitat1 (habitatType, humidity, temperature)
  VALUES ('Grassland', 55.1, 28.5)
  INTO Habitat1 (habitatType, humidity, temperature)
  VALUES ('Arctic', 30.7, -10.2)
  INTO Habitat1 (habitatType, humidity, temperature)
  VALUES ('Woodland', 65.3, 24.9)
SELECT 1 FROM DUAL;

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

INSERT ALL
  INTO Habitat2 (habitatID, exhibitID, habitatType, vegetation)
  VALUES (1, 1, 'Savanna', 'Grass')
  INTO Habitat2 (habitatID, exhibitID, habitatType, vegetation)
  VALUES (2, 2, 'Rainforest', 'Trees')
  INTO Habitat2 (habitatID, exhibitID, habitatType, vegetation)
  VALUES (3, 3, 'Grassland', 'Grass')
  INTO Habitat2 (habitatID, exhibitID, habitatType, vegetation)
  VALUES (4, 4, 'Desert', 'Cacti')
  INTO Habitat2 (habitatID, exhibitID, habitatType, vegetation)
  VALUES (5, 2, 'Rainforest', 'Vines')
  INTO Habitat2 (habitatID, exhibitID, habitatType, vegetation)
  VALUES (6, 1, 'Savanna', 'Trees')
SELECT 1 FROM DUAL;

CREATE TABLE Animal1 (
    species CHAR(32) PRIMARY KEY,
    conservationStatus CHAR(4)
);

INSERT ALL
  INTO Animal1 (species, conservationStatus) VALUES ('Acinonyx jubatus', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Panthera pardus', 'NT')
  INTO Animal1 (species, conservationStatus) VALUES ('Antilocapra americana', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Lamprotornis superbus', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Ateles belzebuth', 'VU')
  INTO Animal1 (species, conservationStatus) VALUES ('Gazella dorcas', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Giraffa camelopardalis', 'VU')
  INTO Animal1 (species, conservationStatus) VALUES ('Panthera tigris', 'EN')
  INTO Animal1 (species, conservationStatus) VALUES ('Bison bison', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Ploceus cucullatus', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Alouatta caraya', 'LC')
  INTO Animal1 (species, conservationStatus) VALUES ('Oryx gazella', 'LC')
SELECT 1 FROM DUAL;

CREATE TABLE ResidentAnimal1 (
    animalID INTEGER,
    habitatID INTEGER NOT NULL,
    species CHAR(32),
    sex CHAR(2),
    age INTEGER,
    healthStatus CHAR(10),
    monthsAtZoo INTEGER,
    favouriteFood CHAR(32),
    PRIMARY KEY (animalID),
    FOREIGN KEY (habitatID)
        REFERENCES Habitat2(habitatID)
        ON DELETE CASCADE
);

INSERT ALL
  INTO ResidentAnimal1 (animalID, habitatID, species, sex, age, healthStatus, monthsAtZoo, favouriteFood) VALUES (19, 1, 'Giraffa camelopardalis', 'F', 9, 'Good', 18, 'Leaves')
  INTO ResidentAnimal1 (animalID, habitatID, species, sex, age, healthStatus, monthsAtZoo, favouriteFood) VALUES (20, 2, 'Panthera tigris', 'M', 6, 'Excellent', 12, 'Meat')
  INTO ResidentAnimal1 (animalID, habitatID, species, sex, age, healthStatus, monthsAtZoo, favouriteFood) VALUES (21, 3, 'Bison bison', 'M', 4, 'Good', 24, 'Grass')
  INTO ResidentAnimal1 (animalID, habitatID, species, sex, age, healthStatus, monthsAtZoo, favouriteFood) VALUES (22, 4, 'Ploceus cucullatus', 'F', 3, 'Good', 9, 'Seeds')
  INTO ResidentAnimal1 (animalID, habitatID, species, sex, age, healthStatus, monthsAtZoo, favouriteFood) VALUES (23, 5, 'Alouatta caraya', 'M', 5, 'Fair', 15, 'Fruits')
  INTO ResidentAnimal1 (animalID, habitatID, species, sex, age, healthStatus, monthsAtZoo, favouriteFood) VALUES (24, 6, 'Oryx gazella', 'F', 7, 'Good', 6, 'Grass')
SELECT 1 FROM DUAL;

CREATE TABLE FeatureAnimal1 (
    animalID INTEGER,
    habitatID INTEGER NOT NULL,
    species CHAR(32),
    sex CHAR(2),
    age INTEGER,
    healthStatus CHAR(10),
    originLocation CHAR(32),
    PRIMARY KEY (animalID),
    FOREIGN KEY (habitatID)
        REFERENCES Habitat2(habitatID)
        ON DELETE CASCADE
);

INSERT ALL
  INTO FeatureAnimal1 (animalID, habitatID, species, sex, age, healthStatus, originLocation) VALUES (13, 1, 'Acinonyx jubatus', 'M', 5, 'Good', 'Africa')
  INTO FeatureAnimal1 (animalID, habitatID, species, sex, age, healthStatus, originLocation) VALUES (14, 2, 'Panthera pardus', 'F', 7, 'Excellent', 'Asia')
  INTO FeatureAnimal1 (animalID, habitatID, species, sex, age, healthStatus, originLocation) VALUES (15, 3, 'Antilocapra americana', 'M', 3, 'Good', 'North America')
  INTO FeatureAnimal1 (animalID, habitatID, species, sex, age, healthStatus, originLocation) VALUES (16, 4, 'Lamprotornis superbus', 'F', 4, 'Good', 'Africa')
  INTO FeatureAnimal1 (animalID, habitatID, species, sex, age, healthStatus, originLocation) VALUES (17, 5, 'Ateles belzebuth', 'M', 6, 'Fair', 'South America')
  INTO FeatureAnimal1 (animalID, habitatID, species, sex, age, healthStatus, originLocation) VALUES (18, 6, 'Gazella dorcas', 'F', 2, 'Good', 'Africa')
SELECT 1 FROM DUAL;

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

INSERT ALL
  INTO TemporaryVisit (startDate, endDate, animalID, EmployeeID) VALUES (DATE '2023-01-15', DATE '2023-01-20', 13, 101)
  INTO TemporaryVisit (startDate, endDate, animalID, EmployeeID) VALUES (DATE '2023-02-05', DATE '2023-02-12', 14, 102)
  INTO TemporaryVisit (startDate, endDate, animalID, EmployeeID) VALUES (DATE '2023-03-10', DATE '2023-03-15', 15, 103)
  INTO TemporaryVisit (startDate, endDate, animalID, EmployeeID) VALUES (DATE '2023-04-01', DATE '2023-04-07', 16, 104)
  INTO TemporaryVisit (startDate, endDate, animalID, EmployeeID) VALUES (DATE '2023-05-18', DATE '2023-05-25', 17, 105)
  INTO TemporaryVisit (startDate, endDate, animalID, EmployeeID) VALUES (DATE '2023-06-10', DATE '2023-06-17', 18, 106)
SELECT 1 FROM DUAL;

CREATE TABLE FoodVendor1 (
    vName CHAR(32) PRIMARY KEY,
    foodType CHAR(32)
);

INSERT ALL
  INTO FoodVendor1 (vName, foodType)
  VALUES ('Japadog', 'Hot Dogs')
  INTO FoodVendor1 (vName, foodType)
  VALUES ('Rain or Shine', 'Ice-Cream')
  INTO FoodVendor1 (vName, foodType)
  VALUES ('Sushi Spot', 'Japanese')
  INTO FoodVendor1 (vName, foodType)
  VALUES ('Taco Truck', 'Mexican')
  INTO FoodVendor1 (vName, foodType)
  VALUES ('Pizza Palace', 'Italian')
  INTO FoodVendor1 (vName, foodType)
  VALUES ('Crepes Corner', 'French')
SELECT 1 FROM DUAL;

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

INSERT ALL
  INTO FoodVendor2 (vendorID, vName, rating, zooID)
  VALUES (1, 'Japadog', 4.2, 1)
  INTO FoodVendor2 (vendorID, vName, rating, zooID)
  VALUES (2, 'Rain or Shine', 4.5, 2)
  INTO FoodVendor2 (vendorID, vName, rating, zooID)
  VALUES (3, 'Sushi Spot', 4.1, 1)
  INTO FoodVendor2 (vendorID, vName, rating, zooID)
  VALUES (4, 'Taco Truck', 4.3, 3)
  INTO FoodVendor2 (vendorID, vName, rating, zooID)
  VALUES (5, 'Pizza Palace', 4.4, 2)
  INTO FoodVendor2 (vendorID, vName, rating, zooID)
  VALUES (6, 'Crepes Corner', 4.0, 1)
SELECT 1 FROM DUAL;

