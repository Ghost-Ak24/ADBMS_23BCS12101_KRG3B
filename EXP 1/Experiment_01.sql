-- Create Tables
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    department VARCHAR(50)
);

CREATE TABLE Professors (
    professor_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Sample Data
INSERT INTO Students VALUES (1, 'Alice', 20, 'CSE'), (2, 'Bob', 22, 'ECE');

INSERT INTO Professors VALUES (101, 'Dr. Smith', 'CSE'), (102, 'Dr. John', 'ECE');

INSERT INTO Courses VALUES (201, 'DBMS', 101), (202, 'Networks', 102);

INSERT INTO Enrollments VALUES (301, 1, 201), (302, 2, 202);


-- Retrieve Data Using JOINs
SELECT s.name AS Student, c.course_name AS Course, p.name AS Professor
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Professors p ON c.professor_id = p.professor_id;

-- Access Control (GRANT / REVOKE)
GRANT SELECT ON Students TO user_name;

REVOKE SELECT ON Students FROM user_name;


-- Transaction Control
START TRANSACTION;

INSERT INTO Students VALUES (3, 'Charlie', 21, 'IT');
INSERT INTO Enrollments VALUES (303, 3, 201);


COMMIT;


