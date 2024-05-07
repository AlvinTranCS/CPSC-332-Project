<?php
include 'db_connect.php';

$course_number = $_GET['course_number'];
$section_number = $_GET['section_number'];

$query = "SELECT Enrollment_Record.Grade, COUNT(*) AS Total_Students
          FROM Enrollment_Record
          WHERE Enrollment_Record.C_Number = '$course_number' AND Enrollment_Record.Section_Number = '$section_number'
          GROUP BY Enrollment_Record.Grade";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "<h2>Grade Distribution for Course: $course_number, Section: $section_number</h2>";
    // Start the table
    echo "<table border='1' style='width: 100%; text-align: left;'>
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
    echo "No grade data found for the specified course and section.";
}

$conn->close();
?>
