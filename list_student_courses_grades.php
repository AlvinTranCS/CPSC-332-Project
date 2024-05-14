<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Course Grades</title>
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
            width: 500px; /* Reduced width */
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

        if (isset($_GET['student_id'])) {
            $student_id = $_GET['student_id'];

            // Query to get the student's first and last name
            $student_query = "SELECT First_name, Last_name FROM Student WHERE CWID = ?";
            if ($stmt = $conn->prepare($student_query)) {
                $stmt->bind_param("s", $student_id);
                $stmt->execute();
                $stmt->bind_result($first_name, $last_name);
                $stmt->fetch();
                $stmt->close();
                $student_name = $first_name . ' ' . $last_name;
            } else {
                echo "<h2>Error preparing the statement: " . $conn->error . "</h2>";
                $conn->close();
                exit();
            }

            $query = "SELECT Course.C_Title, Enrollment_Record.Grade
                      FROM Enrollment_Record
                      JOIN Course ON Enrollment_Record.C_Number = Course.C_Number
                      WHERE Enrollment_Record.S_CWID = ?";

            if ($stmt = $conn->prepare($query)) {
                $stmt->bind_param("s", $student_id);
                $stmt->execute();
                $result = $stmt->get_result();

                if ($result->num_rows > 0) {
                    echo "<h2>Course Grades for $student_name</h2>";
                    echo "<h2>(CWID: $student_id)</h2>";
                    echo "<table>
                            <tr>
                                <th>Course Title</th>
                                <th>Grade</th>
                            </tr>";
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . htmlspecialchars($row["C_Title"]) . "</td>
                                <td>" . htmlspecialchars($row["Grade"]) . "</td>
                              </tr>";
                    }
                    echo "</table>"; // Close the table
                } else {
                    echo "<h2>No grades found for student with CWID: $student_id</h2>";
                }
                $stmt->close();
            } else {
                echo "<h2>Error preparing the statement: " . $conn->error . "</h2>";
            }
        } else {
            echo "<h2>Student ID is required.</h2>";
        }

        $conn->close();
        ?>
        <button class="go-back-btn" onclick="window.history.back()">Go Back</button>
    </div>
</body>
</html>
