<?php

$servername = "localhost"; // I think for CSUF servers, this should be mariadb (not 100% sure though)
$username = "root"; // Default XAMPP username, but for CSUF servers it should assigned username
$password = ""; // Default XAMPP password is empty, but for CSUF servers it should the assigned password
$dbname = "cs332c33"; // Database username

$conn = mysqli_connect($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
