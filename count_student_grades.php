<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grade Distribution</title>
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

        $course_number = $_GET['course_number'];
        $section_number = $_GET['section_number'];

        $query = "SELECT Enrollment_Record.Grade, count(*) as Total_Students
        FROM Enrollment_Record JOIN Section ON Enrollment_Record.C_Number = Section.C_Number AND Enrollment_Record.Section_Number = Section.S_Number
        WHERE Section.C_Number = '$course_number' AND Section.S_Number = '$section_number'
        GROUP BY Enrollment_Record.Grade;";

        $result = $conn->query($query);

        if ($result->num_rows > 0) {
            echo "<h2>Grade Distribution for Course: $course_number, Section: $section_number</h2>";
            // Start the table
            echo "<table>
                    <tr>
                        <th>Grade</th>
                        <th>Count</th>
                    </tr>";
            // Output data of each row
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>" . htmlspecialchars($row["Grade"]) . "</td>
                        <td>" . htmlspecialchars($row["Total_Students"]) . "</td>
                      </tr>";
            }
            echo "</table>"; // Close the table
        } else {
            echo "<h2>No grade data found for the specified course and section.</h2>";
        }

        $conn->close();
        ?>
        <button class="go-back-btn" onclick="window.history.back()">Go Back</button>
    </div>
</body>
</html>
