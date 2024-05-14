<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Professor Classes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #0c4c8c;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            width: 700px; /* Increased width */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
            text-align: center;
        }

        h1, h2 {
            color: #333;
        }

        .go-back-btn {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #ff0000; /* Red */
            color: white;
        }

        .go-back-btn:hover {
            background-color: #cc0000; /* Darker red */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: center; /* Center text inside table cells */
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <?php
        include 'db_connect.php';

        $ssn = $_GET['prof_ssn'];

        // Query to get the professor's name
        $prof_query = "SELECT P_Name FROM Professor WHERE SSN = '$ssn'";
        $prof_result = $conn->query($prof_query);

        if ($prof_result->num_rows > 0) {
            $prof_row = $prof_result->fetch_assoc();
            $prof_name = $prof_row['P_Name'];

            // Query to get the professor's classes
            $class_query = "SELECT Course.C_Title, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time
                            FROM Professor JOIN (Course JOIN Section ON Course.C_Number = Section.C_Number) ON Professor.SSN = Section.Teacher_SSN
                            WHERE Professor.SSN = '$ssn'";

            $class_result = $conn->query($class_query);

            if ($class_result->num_rows > 0) {
                echo "<h2>Courses You Teach ($prof_name)</h2>";
                echo "<table><tr><th>Title</th><th>Classroom</th><th>Meeting Days</th><th>Time</th></tr>";
                while ($row = $class_result->fetch_assoc()) {
                    echo "<tr><td>" . $row["C_Title"] . "</td><td>" . $row["Classroom"] .
                         "</td><td>" . $row["Meeting_Days"] . "</td><td>" . $row["Beginning_Time"] . " to " . $row["Ending_Time"] . "</td></tr>";
                }
                echo "</table>";
            } else {
                echo "<h2>No classes found for Professor $prof_name</h2>";
            }
        } else {
            echo "<h2>Professor not found</h2>";
        }

        $conn->close();
        ?>
        <button class="go-back-btn" onclick="window.history.back()">Go Back</button>
    </div>
</body>
</html>
