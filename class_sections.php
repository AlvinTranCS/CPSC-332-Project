<?php
include 'db_connect.php';

$course_number = $_GET['student_course_number'];

$query = "SELECT Section.S_Number, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time, COUNT(Enrollment_Record.S_CWID) AS Enrolled_Students
          FROM Section 
          JOIN Enrollment_Record ON Section.C_Number = Enrollment_Record.C_Number AND Section.S_Number = Enrollment_Record.Section_Number
          WHERE Section.C_Number = '$course_number'
          GROUP BY Section.S_Number, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "<h2>Sections for Course: $course_number</h2>";
    while ($row = $result->fetch_assoc()) {
        echo "Section: " . $row["S_Number"] . " - Classroom: " . $row["Classroom"] .
             " - Days: " . $row["Meeting_Days"] . " - Time: " . $row["Beginning_Time"] . " to " . $row["Ending_Time"] .
             " - Enrolled Students: " . $row["Enrolled_Students"] . "<br>";
    }
} else {
    echo "No sections found for course: $course_number";
}
$conn->close();
?>
