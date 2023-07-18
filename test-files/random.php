<!--Test Oracle file for UBC CPSC304 2018 Winter Term 1
  Created by Jiemin Zhang
  Modified by Simona Radu
  Modified by Jessica Wong (2018-06-22)
  This file shows the very basics of how to execute PHP commands
  on Oracle.
  Specifically, it will drop a table, create a table, insert values
  update values, and then query for values
  IF YOU HAVE A TABLE CALLED "demoTable" IT WILL BE DESTROYED
  The script assumes you already have a server set up
  All OCI commands are commands to the Oracle libraries
  To get the file to work, you must place it somewhere where your
  Apache server can run it, and you must rename it to have a ".php"
  extension.  You must also change the username and password on the
  OCILogon below to be your ORACLE username and password -->

  <html>
    <head>
        <title>CPSC 304 PHP/Oracle Demonstration</title>
    </head>

    <body>
        <h2>Reset</h2>
        <p>If you wish to reset the table press on the reset button. If this is the first time you're running this page, you MUST use reset</p>

        <form method="POST" action="random.php">
            <!-- if you want another page to load after the button is clicked, you have to specify that page in the action parameter -->
            <input type="hidden" id="resetTablesRequest" name="resetTablesRequest">
            <p><input type="submit" value="Reset" name="reset"></p>
        </form>

        <hr />

        <h2>Add a Feature Animal</h2>
        <form method="POST" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="insertQueryRequest" name="insertQueryRequest">
            AnimalID: <input type="text" name="AnimalID"> <br /><br />
            Age: <input type="text" name="Age"> <br /><br />
            Sex: <input type="text" name="Sex"> <br /><br />
            Health Status: <input type="text" name="HealthStatus"> <br /><br />
            Origin Location: <input type="text" name="OriginLocation"> <br /><br />
            Species: <input type="text" name="Species"> <br /><br />
            Start Date: <input type="text" name="StartDate"> <br /><br />
            End Date: <input type="text" name="EndDate"> <br /><br />
            HabitatID: <input type="text" name="HabitatID"> <br /><br />
            <input type="submit" value="Add Feature Animal" name="insertSubmit"></p>
        </form>

        <hr />

        <h2>Delete a Habitat</h2>
        <p>The values are case sensitive and if you enter in the wrong case, the delete statement will not do anything.</p>

        <form method="POST" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="deleteHabitatRequest" name="deleteHabitatRequest">
            HabitatID: <input type="text" name="HabitatID"> <br /><br />

            <input type="submit" value="Delete" name="deleteSubmit"></p>
        </form>

        <hr />

        <h2>Selection Query</h2>
        <p>Enter values for SELECT FROM WHERE</p>
        <!-- USE POST because we are sending info that will be processed by server -->
        

        <form method="GET" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="selectionRequest" name="selectionRequest">
            SELECT: <input type="text" name="selectParam"> <br /><br />
            FROM: <input type="text" name="fromParam"> <br /><br />
            WHERE (var1): <input type="text" name="whereParam1"> <br /><br />
            <input type="submit" name="selectSubmit"></p>
        </form>

        <hr />


        <h2>Projection Query</h2>
        <form method="GET" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="projectionRequest" name="projectionRequest">
            SELECT: <input type="text" name="selectAtt"> <br /><br />
            FROM: <input type="text" name="fromTab"> <br /><br />
            <input type="submit" name="projectionSubmit"></p>
        </form>

        <hr />

        <h2>Update a Feature Animal</h2>
        <p> Enter the attributes and values which will update for all records with already existing attributes and value </p>
        <p>The values are case sensitive and if you enter in the wrong case, the update statement will not do anything also there would be an error on updating foreignkeys due to foreign key constraints.</p>

        <form method="POST" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="updateQueryRequest" name="updateQueryRequest">
            Old Attribute: <input type = "text" name = "oldattribute"> <br /> <br />
            Old Value: <input type="text" name="oldName"> <br /><br />
            New Attribute: <input type = "text" name = "newattribute"> <br /> <br />
            New Value: <input type="text" name="newName"> <br /><br />

            <input type="submit" value="Update" name="updateSubmit"></p>
        </form>

        <hr />

        <h2>Join Animals, Habitats, and Exhibits</h2>
        <form method="GET" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="joinAnimalsRequest" name="joinAnimalsRequest">
            WHERE: <input type="text" name="whereParam"> <br /><br />
            <input type="submit" name="joinAnimals"></p>
        </form>

        <hr />

        <h2>Count the Tuples in Feature Animal</h2>
        <form method="GET" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="countTupleRequest" name="countTupleRequest">
            <input type="submit" name="countTuples"></p>
        </form>

        <hr />

        <h2>View the Animals</h2>
        <form method="GET" action="random.php"> <!--refresh page when submitted-->
            <input type="hidden" id="viewAnimalsRequest" name="viewAnimalsRequest">
            <input type="submit" name="viewAnimals"></p>
        </form>

        <hr />

        <h2>Drop Down Form</h2>
        <form name="selection-form" id="selection-form" action="random.php" method="GET">
            Table: <select name="select-table" id="select-table">
                <option value="" selected="selected">Zoo</option>
                <option value="" selected="selected">Zoo Manager</option>
                <option value="" selected="selected">Exhibits</option>
                <option value="" selected="selected">Habitats</option>
                <option value="" selected="selected">Feature Animals</option>
                <option value="" selected="selected">Resident Animals</option>
                <option value="" selected="selected">Vendors</option>
                <option value="" selected="selected">Orders</option>
                <option value="" selected="selected">Tickets</option>
                <option value="" selected="selected">Select Table</option>
                
            </select>
            <br><br>
            Attributes: <select name="attributes" id="attributes">
                <option value="" selected="selected">Please select a table first</option>
            </select>
            <br><br>
            <input type="submit" value="Submit">
        </form>
        <hr/>

        <?php
		//this tells the system that it's no longer just parsing html; it's now parsing PHP

        $success = True; //keep track of errors so it redirects the page only if there are no errors
        $db_conn = NULL; // edit the login credentials in connectToDB()
        $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())

        function debugAlertMessage($message) {
            global $show_debug_alert_messages;

            if ($show_debug_alert_messages) {
                echo "<script type='text/javascript'>alert('" . $message . "');</script>";
            }
        }

        function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
            //echo "<br>running ".$cmdstr."<br>";
            global $db_conn, $success;

            $statement = OCIParse($db_conn, $cmdstr);
            //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
                echo htmlentities($e['message']);
                $success = False;
            }

            $r = OCIExecute($statement, OCI_DEFAULT);
            if (!$r) {
                echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
                echo htmlentities($e['message']);
                $success = False;
            }

			return $statement;
		}

        function executeBoundSQL($cmdstr, $list) {
            /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
		In this case you don't need to create the statement several times. Bound variables cause a statement to only be
		parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
		See the sample code below for how this function is used */

			global $db_conn, $success;
			$statement = OCIParse($db_conn, $cmdstr);

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn);
                echo htmlentities($e['message']);
                $success = False;
            }

            foreach ($list as $tuple) {
                foreach ($tuple as $bind => $val) {
                    //echo $val;
                    //echo "<br>".$bind."<br>";
                    OCIBindByName($statement, $bind, $val);
                    unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
				}

                $r = OCIExecute($statement, OCI_DEFAULT);
                if (!$r) {
                    echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
                    echo htmlentities($e['message']);
                    echo "<br>";
                    $success = False;
                }
            }
        }

        function printResult($result) { //prints results from a select statement
            echo "<br>Retrieved data:<br>";
            echo "<table>";
            // echo "<tr><th>ID</th><th>Name</th></tr>";
            echo "<tr>";
            // Fetch and display column names
            $columnNames = oci_num_fields($result);
            for ($i = 1; $i <= $columnNames; $i++) {
                $columnName = oci_field_name($result, $i);
                echo "<th>" . $columnName . "</th>";
            }
            echo "</tr>";

            while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                echo "<tr>";
                //will have same number of columns as specified in the actual database
                for ($i = 0; $i < count($row); $i++) {
                    echo "<td>" . $row[$i] . "</td>";
                }
                echo "</tr>";
            }
            echo "</table>";
        }

        function connectToDB() {
            global $db_conn;

            // Your username is ora_(CWL_ID) and the password is a(student number). For example,
			// ora_platypus is the username and a12345678 is the password.
            $db_conn = OCILogon("ora_apri", "a14367403", "dbhost.students.cs.ubc.ca:1522/stu");

            if ($db_conn) {
                debugAlertMessage("Database is Connected");
                return true;
            } else {
                debugAlertMessage("Cannot connect to Database");
                $e = OCI_Error(); // For OCILogon errors pass no handle
                echo htmlentities($e['message']);
                return false;
            }
        }

        function disconnectFromDB() {
            global $db_conn;

            debugAlertMessage("Disconnect from Database");
            OCILogoff($db_conn);
        }

        function handleUpdateRequest() {
            global $db_conn;
            
            $old_attribute = $_POST['oldattribute'];
            $old_name = $_POST['oldName'];
            $new_attribute = $_POST['newattribute'];
            $new_name = $_POST['newName'];
            echo "<br> updating values in Feature Animal table <br>";

            // you need the wrap the old name and new name values with single quotations
            executePlainSQL("UPDATE FeatureAnimal1 SET " . $new_attribute . " = '" . $new_name . "' WHERE " . $old_attribute . " = '" . $old_name . "'");
            OCICommit($db_conn);
        } 

        function handleResetRequest() {
            global $db_conn;
            // Drop old table
            executePlainSQL("DROP TABLE demoTable");

            // Create new table
            echo "<br> creating new table <br>";
            executePlainSQL("CREATE TABLE demoTable (id int PRIMARY KEY, name char(30))");
            OCICommit($db_conn);
        }

        function handleInsertRequest() {
            global $db_conn;

            $animalid = $_POST['AnimalID'];
            $age = $_POST['Age'];
            $sex = $_POST['Sex'];
            $healthstatus = $_POST['HealthStatus'];
            $species = $_POST['Species'];
            $habitatid = $_POST['HabitatID'];
            $originlocation = $_POST['OriginLocation'];

            if (empty($animalid) || empty($age) || empty($sex) || empty($healthstatus) || empty($species) || empty($habitatid) || empty($originlocation)) {
                echo "<script>alert('Please fill in all of the text values before hiting submit');</script>";
            }

            if(ctype_digit($animalid)) {
                if (ctype_digit($age)) {
                    if ($sex == "M" || $sex == "F") {
                        if ($healthstatus == 'Excellent' || $healthstatus == 'Good' || $healthstatus == 'Fair') {
                            if (ctype_alpha($species)) {
                                if (ctype_digit($habitatid)) {
                                    if (ctype_alpha($originlocation)) {
                                        //Getting the values from user and insert data into the table
                                        $tuple = array (
                                            ":bind1" => $_POST['AnimalID'],
                                            ":bind2" => $_POST['Age'],
                                            ":bind3" => $_POST['Sex'],
                                            ":bind4" => $_POST['HealthStatus'],
                                            ":bind5" => $_POST['Species'],
                                            ":bind6" => $_POST['HabitatID'],
                                            ":bind7" => $_POST['OriginLocation'],
                                        );

                                         $alltuples = array (
                                            $tuple
                                        );
                                        executeBoundSQL("insert into FeatureAnimal1 values 
                                        (:bind1, :bind6, :bind5, :bind3, :bind2, :bind4, :bind7 )", $alltuples);
                                        // executeBoundSQL("insert into demoTable values (:bind1, :bind2)", $alltuples);
                                        OCICommit($db_conn);
                                    } else {
                                        echo "<script>alert('Location of Origin must be a string that contains no special character (!@#$%^&*, etc.)');</script>";
                                    }
                                } else {
                                    echo "<script>alert('Habitat ID must be a int');</script>";
                                }
                            } else {
                                echo "<script>alert('Species must be a string that contains no special character (!@#$%^&*, etc.)');</script>";
                            }
                        } else {
                            echo "<script>alert('Health Status must be one of the following: Excellent, Good, Fair, Poor');</script>";
                        }
                    } else {
                        echo "<script>alert('Sex must be a 'M'''F' and contain no special character (!@#$%^&*, etc.));</script>";
                    }
                } else {
                    echo "<script>alert('Age must be a integer');</script>";
                }
            } else {
                echo "<script>alert('Animal ID must be an integer');</script>";

            }

 
        }

        function handleCountRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT Count(*) FROM FeatureAnimal1");

            if (($row = oci_fetch_row($result)) != false) {
                echo "<br> The number of tuples in FeatureAnimal: " . $row[0] . "<br>";
            }
        }

        function handleViewRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT * FROM Animal1, FeatureAnimal1
             WHERE Animal1.species = FeatureAnimal1.species");
            printResult($result);
        }

        function handleDeleteRequest() {
            global $db_conn;

            $habitatID = $_POST['HabitatID'];
            if(ctype_digit($habitatID)) {
                executePlainSQL("DELETE FROM Habitat2 WHERE habitatID ='" . $habitatID . "'");
                OCICommit($db_conn);
            } else {
                echo "<script>alert('Habitat ID must be a int');</script>";
            }

            
        }

        function handleSelectionRequest() {
            global $db_conn;

            // $tuple = array (
            //     ":selectParam" => $_POST['selectParam'],
            //     ":fromParam" => $_POST['fromParam'],
            //     ":var1" => $_POST['whereParam1']
            // );

            // $alltuples = array (
            //     $tuple
            // );            

            // $result = executeBoundSQL("SELECT :selectParam FROM :fromParam ", $alltuples);
            $result = executePlainSQL("SELECT " . $_GET['selectParam'] . " FROM " . $_GET['fromParam'] . " WHERE " . $_GET['whereParam1']);
            printResult($result);
        }

        function handleProjectionRequest(){
            global $db_conn;

            $result = executePlainSQL("SELECT " . $_GET['selectAtt'] . " FROM " . $_GET['fromTab']);
            printResult($result);
        }

        function handleJoinRequest(){
            global $db_conn;

            $result = executePlainSQL("SELECT * FROM ResidentAnimal1 r, Habitat2 h, Exhibits e WHERE r.habitatID=h.habitatID AND h.exhibitID=e.exhibitID AND " . $_GET['whereParam']);
            printResult($result);
        }

        // HANDLE ALL POST ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handlePOSTRequest() {
            if (connectToDB()) {
                if (array_key_exists('resetTablesRequest', $_POST)) {
                    handleResetRequest();
                } else if (array_key_exists('updateQueryRequest', $_POST)) {
                    handleUpdateRequest();
                } else if (array_key_exists('insertQueryRequest', $_POST)) {
                    handleInsertRequest();
                } else if(array_key_exists('deleteHabitatRequest', $_POST)) {
                    handleDeleteRequest();
                } 
                disconnectFromDB();
            }
        }

        // HANDLE ALL GET ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handleGETRequest() {
            if (connectToDB()) {
                if (array_key_exists('countTuples', $_GET)) {
                    handleCountRequest();
                }
                if (array_key_exists('viewAnimals', $_GET)) {
                    handleViewRequest();
                }
                if (array_key_exists('projectionRequest', $_GET)){
                    handleProjectionRequest();
                }
                if (array_key_exists('selectionRequest', $_GET)) {
                    handleSelectionRequest();
                } 
                if (array_key_exists('joinAnimals', $_GET)) {
                    handleJoinRequest();
                }
                disconnectFromDB();
            }
        }

		if (isset($_POST['reset']) || isset($_POST['updateSubmit']) || isset($_POST['deleteSubmit']) || isset($_POST['insertSubmit'])) {
            handlePOSTRequest();
        } else if (isset($_GET['countTupleRequest']) || isset($_GET['viewAnimalsRequest']) || isset($_GET['joinAnimalsRequest']) 
            || isset($_GET['projectionSubmit']) ||  isset($_GET['selectSubmit']) ) {
            handleGETRequest();
        }
		?>
	</body>
</html>
