<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Sections</title>
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

        $course_number = $_GET['student_course_number'];

        $query = "SELECT Section.S_Number, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time, COUNT(*) as Enrolled_Students
        FROM (Course JOIN Section ON Course.C_Number = Section.C_Number) JOIN Enrollment_Record ON Course.C_Number = Enrollment_Record.C_Number AND Section.S_Number = Enrollment_Record.Section_Number
        WHERE Course.C_Number = '$course_number'
        GROUP BY Section.S_Number, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time;";

        $result = $conn->query($query);

        if ($result->num_rows > 0) {
            echo "<h2>Sections for Course: $course_number</h2>";
            echo "<table>
                    <tr>
                        <th>Section</th>
                        <th>Classroom</th>
                        <th>Meeting Days</th>
                        <th>Time</th>
                        <th>Enrolled Students</th>
                    </tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>" . htmlspecialchars($row["S_Number"]) . "</td>
                        <td>" . htmlspecialchars($row["Classroom"]) . "</td>
                        <td>" . htmlspecialchars($row["Meeting_Days"]) . "</td>
                        <td>" . htmlspecialchars($row["Beginning_Time"]) . " to " . htmlspecialchars($row["Ending_Time"]) . "</td>
                        <td>" . htmlspecialchars($row["Enrolled_Students"]) . "</td>
                      </tr>";
            }
            echo "</table>";
        } else {
            echo "<h2>No sections found for course: $course_number</h2>";
        }

        $conn->close();
        ?>
        <button class="go-back-btn" onclick="window.history.back()">Go Back</button>
    </div>
</body>
</html>
