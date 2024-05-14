-- Drop existing tables if they exist
DROP TABLE IF EXISTS Enrollment_Record;
DROP TABLE IF EXISTS Prerequisite;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Minor;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS College_Degrees;
DROP TABLE IF EXISTS Professor;

-- Create new tables

-- Professor
CREATE TABLE Professor (
    SSN VARCHAR(9) PRIMARY KEY NOT NULL,
    P_name VARCHAR(50),
    Area_Code VARCHAR(3),
    Phone_Number VARCHAR(10),
    Sex ENUM('M', 'F'),
    Title VARCHAR(30),
    Salary INTEGER,
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(2),
    Zipcode VARCHAR(5)
);

-- College Degrees
CREATE TABLE College_Degrees (
    College_Degree VARCHAR(40) PRIMARY KEY,
    P_SSN VARCHAR(9),
    FOREIGN KEY (P_SSN) REFERENCES Professor(SSN)
);

-- Department
CREATE TABLE Department (
    D_Number VARCHAR(6) PRIMARY KEY,
    D_Name VARCHAR(50),
    D_Telephone VARCHAR(10),
    D_Address VARCHAR(90),
    Department_Chair_SSN VARCHAR(9),
    FOREIGN KEY (Department_Chair_SSN) REFERENCES Professor(SSN)
);

-- Course
CREATE TABLE Course (
    C_Number VARCHAR(12) PRIMARY KEY,
    C_Title VARCHAR(50),
    C_Textbook VARCHAR(60),
    C_Units CHAR(1),
    D_Number VARCHAR(6),
    FOREIGN KEY (D_Number) REFERENCES Department(D_Number)
);

-- Student
CREATE TABLE Student (
    CWID VARCHAR(12) PRIMARY KEY,
    S_Address VARCHAR(90),
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    S_Telephone VARCHAR(10),
    Major_ID VARCHAR(6),
    FOREIGN KEY (Major_ID) REFERENCES Department(D_Number)
);

-- Minor
CREATE TABLE Minor (
    S_CWID VARCHAR(12),
    Minor_ID VARCHAR(6),
    FOREIGN KEY (S_CWID) REFERENCES Student(CWID),
    FOREIGN KEY (Minor_ID) REFERENCES Department(D_Number)
);

-- Section
CREATE TABLE Section (
    S_Number VARCHAR(2),
    C_Number VARCHAR(12),
    Teacher_SSN VARCHAR(9),
    Classroom VARCHAR(30),
    Meeting_Days VARCHAR(20),
    No_of_Seats INT,
    Beginning_Time VARCHAR(10),
    Ending_Time VARCHAR(10),
    FOREIGN KEY (C_Number) REFERENCES Course(C_Number),
    FOREIGN KEY (Teacher_SSN) REFERENCES Professor(SSN),
    PRIMARY KEY (C_Number, S_Number)
);

-- Prerequisite
CREATE TABLE Prerequisite (
    Prereq_Number VARCHAR(12),
    C_Number VARCHAR(12),
    FOREIGN KEY (Prereq_Number) REFERENCES Course(C_Number),
    FOREIGN KEY (C_Number) REFERENCES Course(C_Number)
);

-- Enrollment Record
CREATE TABLE Enrollment_Record (
    S_CWID VARCHAR(12),
    Section_Number VARCHAR(2),
    C_Number VARCHAR(12),
    Grade ENUM('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'),
    FOREIGN KEY (S_CWID) REFERENCES Student(CWID),
    FOREIGN KEY (C_Number, Section_Number) REFERENCES Section(C_Number, S_Number)
);

-- Insert Professors
INSERT INTO Professor (SSN, P_name, Area_Code, Phone_Number, Sex, Title, Salary, Street, City, State, Zipcode)
VALUES
('123456789', 'Nicholas Anderson', '555', '2194857294', 'M', 'Professor', 80000, '134 Kenmore St', 'Irvine', 'CA', '12345'),
('234567890', 'Sarah Williams', '555', '6507965748', 'F', 'Assistant Professor', 60000, '128 Canton Ave', 'Buffalo', 'NY', '23456'),
('345678901', 'Marcus Sullivan', '555', '5308875534', 'M', 'Associate Professor', 70000, '189 Rainier St', 'Arlington', 'TX', '34567'),
('456789012', 'Emily Campbell', '555', '3235355652', 'F', 'Associate Professor', 75000, '221 Varna St', 'Riverside', 'CA', '98765');

-- Insert College Degrees
INSERT INTO College_Degrees (College_Degree, P_SSN)
VALUES
('Bachelors of Science, Computer Science', '123456789'),
('Bachelors of Science, Mathematics', '234567890'),
('Bachelors of Science, Biology', '345678901'),
('Bachelors of English', '456789012');

-- Insert Departments
INSERT INTO Department (D_Number, D_Name, D_Telephone, D_Address, Department_Chair_SSN)
VALUES
('D001', 'Computer Science', '2096485898', '789 Greenville Rd, Fullerton, CA 34567', '123456789'),
('D002', 'Mathematics', '6263929737', '789 Greenville Rd, Fullerton, CA 34567', '234567890'),
('D003', 'English', '7145356431', '789 Greenville Rd, Fullerton, CA 34567', '456789012');

-- Insert Courses
INSERT INTO Course (C_Number, C_Title, C_Textbook, C_Units, D_Number)
VALUES
('CS101', 'Introduction to Computer Science', 'Intro to CS', '3', 'D001'),
('CS201', 'Data Structures', 'Data Structures Book', '3', 'D001'),
('MATH101', 'Calculus I', 'Calculus I Book', '4', 'D002'),
('MATH201', 'Linear Algebra', 'Linear Algebra Book', '4', 'D002'),
('ENG101', 'English Composition', 'Basic Composition', '3', 'D003');

-- Insert Students
INSERT INTO Student (CWID, S_Address, First_name, Last_name, S_Telephone, Major_ID)
VALUES
('884763437', '123 Newman St', 'Clara', 'Johnson', '8583692225', 'D001'),
('884763438', '117 University Ave', 'Bobby', 'Morrigan', '3234944537', 'D001'),
('884763439', '101 Nieta Dr', 'Michael', 'Flynn', '9515553333', 'D002'),
('884763440', '124 Elmwood Rd', 'Diana', 'Lee', '7143768982', 'D002'),
('884763441', '192 Carnation Dr', 'Evan', 'Martinez', '6195336587', 'D003'),
('884763442', '112 Stoneridge Ave', 'Fay', 'Wright', '4088481740', 'D003'),
('884763443', '107 Crestwood Ln', 'George', 'Whitmore', '9254235037', 'D001'),
('884763444', '188 Carnelian Blvd', 'Hannah', 'Kim', '8185701149', 'D002'),
('884763445', '119 Pendleton Ave', 'Ian', 'Park', '7148758972', 'D002'),
('884763446', '140 Shadbush St', 'Julia', 'Langston', '8587295027', 'D003');

-- Insert Minor Relationships
INSERT INTO Minor (S_CWID, Minor_ID)
VALUES
('884763437', 'D002'),
('884763438', 'D003');

-- Insert Sections
INSERT INTO Section (S_Number, C_Number, Teacher_SSN, Classroom, Meeting_Days, No_of_Seats, Beginning_Time, Ending_Time)
VALUES
('01', 'CS101', '123456789', 'Room 101', 'Mon, Wed, Fri', 30, '08:00 AM', '09:30 AM'),
('02', 'CS101', '123456789', 'Room 102', 'Tue, Thu', 30, '10:00 AM', '11:30 AM'),
('03', 'CS201', '123456789', 'Room 103', 'Mon, Wed, Fri', 30, '01:00 PM', '02:30 PM'),
('01', 'MATH101', '234567890', 'Room 201', 'Mon, Wed, Fri', 40, '09:30 AM', '11:00 AM'),
('02', 'MATH101', '234567890', 'Room 202', 'Tue, Thu', 40, '11:00 AM', '12:30 PM'),
('01', 'MATH201', '234567890', 'Room 203', 'Mon, Wed, Fri', 35, '12:30 PM', '02:00 PM'),
('02', 'MATH201', '234567890', 'Room 204', 'Tue, Thu', 35, '02:00 PM', '03:30 PM'),
('01', 'ENG101', '456789012', 'Room 401', 'Mon, Wed, Fri', 25, '09:00 AM', '10:30 AM'),
('02', 'ENG101', '456789012', 'Room 402', 'Tue, Thu', 25, '10:30 AM', '12:00 PM');

-- Insert Prereqs
INSERT INTO Prerequisite (Prereq_Number, C_Number)
VALUES
('MATH101', 'MATH201');

-- Insert Enrollment Records
INSERT INTO Enrollment_Record (S_CWID, C_Number, Section_Number, Grade)
VALUES
('884763437', 'CS101', '01', 'A'),
('884763438', 'CS101', '02', 'D+'),
('884763439', 'CS201', '03', 'A'),
('884763440', 'CS201', '03', 'A-'),
('884763441', 'MATH101', '01', 'C+'),
('884763442', 'MATH101', '02', 'B-'),
('884763443', 'MATH101', '02', 'D'),
('884763444', 'MATH201', '01', 'A-'),
('884763445', 'MATH201', '01', 'B+'),
('884763446', 'MATH201', '02', 'A'),
('884763437', 'ENG101', '01', 'C'),
('884763438', 'ENG101', '01', 'A-'),
('884763439', 'ENG101', '02', 'B+'),
('884763440', 'ENG101', '01', 'A'),
('884763441', 'ENG101', '02', 'A-'),
('884763442', 'ENG101', '01', 'F'),
('884763443', 'ENG101', '02', 'A-'),
('884763444', 'ENG101', '01', 'B+'),
('884763445', 'ENG101', '02', 'C-'),
('884763446', 'ENG101', '02', 'B+'),
('884763437', 'CS101', '01', 'A'),
('884763438', 'CS201', '03', 'A-'),
('884763439', 'MATH101', '01', 'B+'),
('884763440', 'MATH201', '01', 'D-'),
('884763441', 'ENG101', '02', 'A+');


-- Professor SQLs

-- A : Given the social security number of a professor, list the titles, classrooms, meeting
-- days and time of his/her classes.

SELECT Course.C_Title, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time
FROM Professor JOIN (Course JOIN Section ON Course.C_Number = Section.C_Number) ON Professor.SSN = Section.Teacher_SSN
WHERE Professor.SSN = '345678901';

-- B : Given a course number and a section number, count how many students get each
-- distinct grade, i.e. ‘A’, ‘A-’, ‘B+’, ‘B’, ‘B-’, etc

SELECT Enrollment_Record.Grade, count(*) as Total_Students
FROM Enrollment_Record JOIN Section ON Enrollment_Record.C_Number = Section.C_Number AND Enrollment_Record.Section_Number = Section.S_Number
WHERE Section.C_Number = 'MATH101' AND Section.S_Number = '01'
GROUP BY Enrollment_Record.Grade;

-- Student SQLs

-- A : Given a course number list the sections of the course, including the classrooms, the
-- meeting days and time, and the number of students enrolled in each section.

SELECT Section.S_Number, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time, COUNT(*) as Enrolled_Students
FROM (Course JOIN Section ON Course.C_Number = Section.C_Number) JOIN Enrollment_Record ON Course.C_Number = Enrollment_Record.C_Number AND Section.S_Number = Enrollment_Record.Section_Number
WHERE Course.C_Number = 'CS101'
GROUP BY Section.S_Number, Section.Classroom, Section.Meeting_Days, Section.Beginning_Time, Section.Ending_Time;

-- B : Given the campus wide ID of a student, list all courses the student took and the
-- grades.

SELECT Student.First_name, Student.Last_name, Course.C_Title, Enrollment_Record.Grade
FROM (Enrollment_Record JOIN Student ON Student.CWID = Enrollment_Record.S_CWID) JOIN Course ON Enrollment_Record.C_Number = Course.C_Number
WHERE Enrollment_Record.S_CWID = 'C002';
