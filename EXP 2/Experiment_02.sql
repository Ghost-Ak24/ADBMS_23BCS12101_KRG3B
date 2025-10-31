-- View – Modular Query Logic
CREATE VIEW StudentCourseView AS
SELECT 
    s.name AS StudentName,
    c.course_name AS CourseName,
    p.name AS ProfessorName
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Professors p ON c.professor_id = p.professor_id;

-- Use the view:
SELECT * FROM StudentCourseView;

-- Trigger – Automatic Data Validation
CREATE TRIGGER trg_StudentAgeCheck
ON Students
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE age < 17)
    BEGIN
        RAISERROR('Student must be at least 17 years old.', 16, 1);
        ROLLBACK;
    END
END;

-- Stored Procedure – Encapsulate Logic
CREATE PROCEDURE GetStudentsByDepartment
    @dept VARCHAR(50)
AS
BEGIN
    SELECT * FROM Students WHERE department = @dept;
END;

-- Call it
EXEC GetStudentsByDepartment 'CSE';

-- Scalar Function – Return a single value
CREATE FUNCTION TotalCoursesByStudent(@sid INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT
    SELECT @total = COUNT(*) FROM Enrollments WHERE student_id = @sid
    RETURN @total
END;

-- Use it:
SELECT name, dbo.TotalCoursesByStudent(student_id) AS CourseCount FROM Students;

--  Cursor – Iterative Processing
DECLARE @sid INT, @sname VARCHAR(100)

DECLARE student_cursor CURSOR FOR
SELECT student_id, name FROM Students

OPEN student_cursor
FETCH NEXT FROM student_cursor INTO @sid, @sname

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Student: ' + @sname + ' (ID: ' + CAST(@sid AS VARCHAR) + ')'
    FETCH NEXT FROM student_cursor INTO @sid, @sname
END

CLOSE student_cursor
DEALLOCATE student_cursor



