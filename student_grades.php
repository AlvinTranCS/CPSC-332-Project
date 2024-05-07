<?php
include 'db_connect.php';

if (isset($_GET['student_id'])) {
    $student_id = $_GET['student_id'];

    $query = "SELECT Course.C_Title, Enrollment_Record.Grade
              FROM Enrollment_Record
              JOIN Course ON Enrollment_Record.C_Number = Course.C_Number
              WHERE Enrollment_Record.S_CWID = ?";

    if ($stmt = $conn->prepare($query)) {
        $stmt->bind_param("s", $student_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "<h2>Course Grades for Student ID: $student_id</h2>";
            while ($row = $result->fetch_assoc()) {
                echo "Course Title: " . htmlspecialchars($row["C_Title"]) . " - Grade: " . htmlspecialchars($row["Grade"]) . "<br>";
            }
        } else {
            echo "No grades found for student with CWID: $student_id";
        }
        $stmt->close();
    } else {
        echo "Error preparing the statement: " . $conn->error;
    }
} else {
    echo "Student ID is required.";
}

$conn->close();
?>
