
1. -- Find the first name for all students who have a grade that's higher than the 10th highest grade (sorted descending)


SELECT firstname, grade
FROM gradestbl
JOIN studentstbl ON studentid = studentfk
ORDER BY grade DESC
LIMIT 10;


2. -- Find the first name and last name for all students who have taken a course (department and course number) where the course has a third section.

SELECT firstname, lastname, coursefk, section 
FROM sectionstbl
JOIN coursestbl ON courseid = coursefk
JOIN gradestbl ON sectionid = sectionfk
JOIN studentstbl ON studentid = studentfk
WHERE section = 3; 


3. -- Create a list of all students and the department and course where they earned their personal best grade.

SELECT firstname, lastname, MAX(grade), department, coursenumber
FROM gradestbl
JOIN studentstbl ON studentid = studentfk
JOIN sectionstbl ON sectionid = sectionfk
JOIN coursestbl ON courseid = coursefk
JOIN departmentstbl ON departmentid = departmentfk
GROUP BY lastname;

4. -- Create a VIEW that displays a listing of every department and each course number associated to that department.

CREATE VIEW department AS
SELECT department, coursenumber
FROM coursestbl
JOIN departmentstbl ON departmentid = departmentfk;

5. -- Create a list of all courses whose department starts with the letter "A"

SELECT coursenumber, department
FROM coursestbl
JOIN departmentstbl ON departmentid = departmentfk
WHERE department LIKE 'a%';


6. -- Create a list of all HIST, SOC, and CE courses

SELECT department, coursenumber 
FROM coursestbl
JOIN departmentstbl ON departmentid = departmentfk
WHERE department IN ('HIST','SOC','CE');

7. -- Create a list of all departments and courses where the departments start with the letters "A", "B", and "C"

SELECT department, coursenumber 
FROM coursestbl
JOIN departmentstbl ON departmentid = departmentfk
WHERE department LIKE 'A%'
OR department LIKE 'B%'
OR department LIKE 'C%';

8. -- Find all students first and last name who earned a grade between 1.5 and 3.0

SELECT DISTINCT firstname, lastname
FROM gradestbl
JOIN studentstbl ON studentid = studentfk
WHERE grade BETWEEN 1.5 AND 3.0

9. -- Find the department and course number for the three most-taken courses

SELECT department, coursenumber, COUNT(coursenumber) AS number_of_courses
FROM coursestbl
JOIN departmentstbl ON departmentid = departmentfk
JOIN sectionstbl ON courseid = coursefk
JOIN gradestbl ON sectionid = sectionfk
JOIN studentstbl ON studentid = studentfk
GROUP BY department  
ORDER BY number_of_courses DESC
LIMIT 3;

10 -- Find the department, course number, and semester for all instructors whose last names start with the letters 'P', 'R', 'S', and 'T'.

SELECT department, coursenumber, semester, instfirstname, instlastname
FROM sectionstbl
JOIN coursestbl ON courseid = coursefk
JOIN departmentstbl ON departmentid = departmentfk 
JOIN instructorstbl ON instructorid = instructorfk
JOIN semesterstbl ON semesterid = semesterfk
WHERE instlastname LIKE 'P%'
OR instlastname LIKE 'R%'
OR instlastname LIKE 'S%'
OR instlastname LIKE 'T%'