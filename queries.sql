-- INSERT
-- "Based on all the information user inputs which adheres to the bounds in php these SQL statements insert information in Animal1 and FeatureAnimal1"
insert into Animal1 values  (:bind5, :bind8 );
insert into FeatureAnimal1 values (:bind1, :bind6, :bind5, :bind3, :bind2, :bind4, :bind7 );

-- UPDATE
-- "Select an AnimalID whose attributes are to be updated"
SELECT * FROM FeatureAnimal1 WHERE animalID =  ($animalID);
-- "Then through multiple text boxes user can update the attributes they wish to be updated"
UPDATE FeatureAnimal1 SET Age=:bind2, Sex=:bind3, HealthStatus=:bind4,
            Species=:bind5, HabitatID=:bind6, OriginLocation=:bind7 WHERE AnimalID=:bind1;


-- COUNT
-- "Counts number of tuples in FeatureAnimal Table"
SELECT Count(*) FROM FeatureAnimal1;


-- VIEW
-- "Returns all the attributes in Animal1 and FeatureAnimal1"
SELECT * FROM Animal1, FeatureAnimal1
             WHERE Animal1.species = FeatureAnimal1.species;


-- DELETE
-- "Deletes all the information from Habitat2 and Habitat1 (due to cascade) with specified HabitatID"
DELETE FROM Habitat2 WHERE habitatID =($habitatID);

-- SELECTION
-- "Based on the table selected this query would find the value from Attribute specified in fromParam which satisfies the condition in WHERE clause "
SELECT ($_GET['selectParam']) FROM ($_GET['fromParam']) WHERE ($_GET['whereParam1']);


-- PROJECTION
-- "Returns values from the specified attributes in specified table"
SELECT ($_GET['selectAtt'])  FROM ($_GET['fromTab']);

-- JOIN
-- "Joins ResidentAnimal1, Habitat2 and Exhibits based on a condition in whereParam"
SELECT * FROM ResidentAnimal1 r, Habitat2 h, Exhibits e WHERE r.habitatID=h.habitatID AND h.exhibitID=e.exhibitID AND ($_GET['whereParam']);


-- HAVING 
-- Returns vName and foodType Having higher rating than Average Rating of every FoodVendors
SELECT fv1.vName, fv1.foodType FROM FoodVendor1 fv1 
                WHERE fv1.vName IN (SELECT fv2.vName FROM FoodVendor2 fv2 GROUP BY fv2.vName HAVING 
                AVG(fv2.rating) > (SELECT AVG(rating) FROM FoodVendor2));


-- Aggregated GROUP BY 
-- Returns Average Vistor Capacity and Habitat type where popularityRating is higher than 6 
SELECT h2.habitatType, AVG(e.visitorCapacity) as averageCapacity FROM Habitat2 h2, Exhibits e
                WHERE e.popularityRating > 6 AND h2.exhibitID = e.exhibitID GROUP BY h2.habitatType;



-- Nested Aggregated GROUP BY
-- Returns Average Age of FeatureAnimal1 where Popularity Rating is higher than Average in their species
SELECT a.species, AVG(a.age) AS averageAge,e.popularityRating
                                       FROM Exhibits e, FeatureAnimal1 a, Habitat2 h
                                       WHERE h.exhibitID = e.exhibitID AND a.habitatID = h.habitatID
                                       GROUP BY a.species,e.popularityRating
                                       HAVING  e.popularityRating >= AVG(e.popularityRating);

-- DIVISION
-- Returns Species of ResidentAnimal1 which are presented in Exhibits i.e., associated with them.
SELECT species FROM ResidentAnimal1 WHERE NOT EXISTS (SELECT habitatID FROM ResidentAnimal1 a1 WHERE NOT EXISTS 
                                        (SELECT h.habitatID
                                         FROM Habitat2 h, Exhibits e
                                         WHERE h.exhibitID = e.exhibitID AND a1.habitatID = h.habitatID));