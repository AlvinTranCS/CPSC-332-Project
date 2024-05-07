<?php
include 'db_connect.php';

$ssn = $_GET['prof_ssn']; 

$query = "SELECT Course.C_Title, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time
          FROM Professor 
          JOIN Section ON Professor.SSN = Section.Teacher_SSN
          JOIN Course ON Section.C_Number = Course.C_Number
          WHERE Professor.SSN = '$ssn'";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "<h2>Classes Taught by Professor (SSN: $ssn)</h2>";
    while ($row = $result->fetch_assoc()) {
        echo "Title: " . $row["C_Title"] . " - Classroom: " . $row["Classroom"] .
             " - Days: " . $row["Meeting_Days"] . " - Time: " . $row["Beginning_Time"] . " to " . $row["Ending_Time"] . "<br>";
    }
} else {
    echo "No classes found for professor with SSN: $ssn";
}
$conn->close();
?>
