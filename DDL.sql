-- First Table; Professor

CREATE TABLE Professor (
    SSN VARCHAR(9) PRIMARY KEY NOT NULL,
    P_name VARCHAR(50),
    Area_Code VARCHAR(3),
    Phone_Number VARCHAR(7),
    Sex ENUM('M', 'F'),
    Title VARCHAR(30),
    Salary INTEGER,
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(2),
    Zipcode VARCHAR(5)
);

INSERT INTO Professor (SSN, P_name, Area_Code, Phone_Number, Sex, Title, Salary, Street, City, State, Zipcode)
VALUES
('123456789', 'John Smith', '555', '1234567', 'M', 'Professor', 80000, '123 Main St', 'Anytown', 'CA', '12345'),
('234567890', 'Jane Doe', '555', '2345678', 'F', 'Assistant Professor', 60000, '456 Oak St', 'Othertown', 'NY', '23456'),
('345678901', 'David Johnson', '555', '3456789', 'M', 'Associate Professor', 70000, '789 Elm St', 'Somewhere', 'TX', '34567');

-- Second Table; College Degrees

CREATE TABLE College_Degrees (
    College_Degree VARCHAR(40) PRIMARY KEY,
    P_SSN VARCHAR(9),
    FOREIGN KEY (P_SSN) REFERENCES Professor(SSN)
);

INSERT INTO College_Degrees (College_Degree, P_SSN)
VALUES
('Bachelors of Science, Computer Science', '123456789'),
('Bachelors of Science, Mathematics', '234567890'),
('Bachelors of Science, Biology', '345678901');

-- Third Table; Department

CREATE TABLE Department (
    D_Number VARCHAR(6) PRIMARY KEY,
    D_Name VARCHAR(50),
    D_Telephone VARCHAR(10),
    D_Address VARCHAR(90),
    Department_Chair_SSN VARCHAR(9),
    FOREIGN KEY (Department_Chair_SSN) REFERENCES Professor(SSN)
);

INSERT INTO Department (D_Number, D_Name, D_Telephone, D_Address, Department_Chair_SSN)
VALUES
('D001', 'Computer Science', '9515551234', '123 Tech Blvd, Techville, CA 12345', '123456789'),
('D002', 'Mathematics', '9515552345', '456 Math Ave, Mathland, NY 23456', '234567890');

-- Fourth Table; Course

CREATE TABLE Course (
    C_Number VARCHAR(12) PRIMARY KEY,
    C_Title VARCHAR(50),
    C_Textbook VARCHAR(60),
    C_Units CHAR(1),
    D_Number VARCHAR(6),
    FOREIGN KEY (D_Number) REFERENCES Department(D_Number)
);

INSERT INTO Course (C_Number, C_Title, C_Textbook, C_Units, D_Number)
VALUES
('CS101', 'Introduction to Computer Science', 'Intro to CS', '3', 'D001'),
('CS201', 'Data Structures', 'Data Structures Book', '3', 'D001'),
('MATH101', 'Calculus I', 'Calculus I Book', '4', 'D002'),
('MATH201', 'Linear Algebra', 'Linear Algebra Book', '4', 'D002');


-- Fifth Table; Student

CREATE TABLE Student (
    CWID VARCHAR(12) PRIMARY KEY,
    S_Address VARCHAR(90),
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    S_Telephone VARCHAR(10),
    Major_ID VARCHAR(6),
    FOREIGN KEY (Major_ID) REFERENCES Department(D_Number)
);

INSERT INTO Student (CWID, S_Address, First_name, Last_name, S_Telephone, Major_ID)
VALUES
('C001', '111 College St', 'Alice', 'Johnson', '9515551111', 'D001'),
('C002', '222 University Ave', 'Bob', 'Smith', '9515552222', 'D001'),
('C003', '333 Campus Dr', 'Charlie', 'Brown', '9515553333', 'D002'),
('C004', '444 Academic Rd', 'Diana', 'Lee', '9515554444', 'D002'),
('C005', '555 Education Blvd', 'Emma', 'Garcia', '9515555555', 'D001'),
('C006', '666 Student Ln', 'Frank', 'Miller', '9515556666', 'D002'),
('C007', '777 Learning St', 'Grace', 'Wilson', '9515557777', 'D001'),
('C008', '888 Study Rd', 'Henry', 'Martinez', '9515558888', 'D002');

-- Sixth Table; Minor

CREATE TABLE Minor (
    S_CWID VARCHAR(12),
    Minor_ID VARCHAR(6),
    FOREIGN KEY (S_CWID) REFERENCES Student(CWID),
    FOREIGN KEY (Minor_ID) REFERENCES Department(D_Number)
);

INSERT INTO Minor (S_CWID, Minor_ID)
VALUES
('C001', 'D002'),
('C006', 'D001');

-- Seventh Table; Section

CREATE TABLE Section (
    S_Number VARCHAR(2),
    C_Number VARCHAR(12),
    Teacher_SSN VARCHAR(9),
    Classroom VARCHAR(30),
    Meeting_Days VARCHAR(8),
    No_of_Seats INT,
    Beginning_Time TIME,
    Ending_Time TIME,
    FOREIGN KEY (C_Number) REFERENCES Course(C_Number),
    FOREIGN KEY (Teacher_SSN) REFERENCES Professor(SSN),
    PRIMARY KEY (C_Number, S_Number)
);

INSERT INTO Section (S_Number, C_Number, Teacher_SSN, Classroom, Meeting_Days, No_of_Seats, Beginning_Time, Ending_Time)
VALUES
('01', 'CS101', '123456789', 'Room 101', 'MWF', 30, '08:00', '09:30'),
('02', 'CS101', '123456789', 'Room 102', 'TTh', 30, '10:00', '11:30'),
('01', 'MATH101', '345678901', 'Room 301', 'MWF', 40, '08:00', '09:30'),
('02', 'MATH101', '345678901', 'Room 302', 'TTh', 40, '10:00', '11:30'),
('01', 'MATH201', '345678901', 'Room 303', 'MWF', 35, '12:00', '13:30'),
('02', 'MATH201', '345678901', 'Room 304', 'TTh', 35, '14:00', '15:30');

-- Eighth Table; Prerequisite

CREATE TABLE Prerequisite (
    Prereq_Number VARCHAR(12),
    C_Number VARCHAR(12),
    FOREIGN KEY (Prereq_Number) REFERENCES Course(C_Number),
    FOREIGN KEY (C_Number) REFERENCES Course(C_Number)
);

INSERT INTO Prerequisite (Prereq_Number, C_Number)
VALUES
('MATH101', 'MATH201');

-- Ninth Table; Enrollment_Record

CREATE TABLE Enrollment_Record (
    S_CWID VARCHAR(12),
    Section_Number VARCHAR(2),
    C_Number VARCHAR(12),
    Grade ENUM('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'),
    FOREIGN KEY (S_CWID) REFERENCES Student(CWID),
    FOREIGN KEY (C_Number, Section_Number) REFERENCES Section(C_Number, S_Number)
);

INSERT INTO Enrollment_Record (S_CWID, C_Number, Section_Number, Grade)
VALUES
('C001', 'CS101', '01', 'A'),
('C002', 'CS101', '02', 'B+'),
('C003', 'CS101', '01', 'A-'),
('C004', 'CS101', '01', 'B'),
('C005', 'CS101', '01', 'A'),
('C006', 'CS101', '02', 'B+'),
('C007', 'CS101', '01', 'A-'),
('C008', 'CS101', '01', 'B'),
('C001', 'CS101', '01', 'A'),
('C002', 'CS101', '01', 'C+'),
('C003', 'CS101', '01', 'A-'),
('C004', 'CS101', '02', 'B'),
('C005', 'CS101', '01', 'A'),
('C006', 'CS101', '02', 'B+'),
('C007', 'CS101', '01', 'D-'),
('C008', 'CS101', '01', 'B'),
('C001', 'MATH101', '01', 'A'),
('C002', 'MATH101', '02', 'B+'),
('C003', 'MATH101', '01', 'A-'),
('C004', 'MATH101', '01', 'B');

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
GROUP BY Enrollment_Record.C_Number, Enrollment_Record.Section_Number, Enrollment_Record.Grade;

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
