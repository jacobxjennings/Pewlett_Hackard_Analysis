-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no


-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;
SELECT * FROM unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;
SELECT * FROM retiring_titles;

-- Create a Mentorship Eligibility table that holds the employees who are eligible
-- to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

-- How many roles will need to be filled as the "silver tsunami" begins to make an impact?

SELECT SUM(count) FROM retiring_titles

-- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

SELECT COUNT(emp_no) FROM mentorship_eligibility

-- Retrieve the number of employees retiring per department.

SELECT COUNT(ut.emp_no), d.dept_name
INTO retirees_per_dept
FROM unique_titles as ut
INNER JOIN dept_emp as de
ON (ut.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
GROUP BY dept_name
ORDER BY count DESC
SELECT * FROM retirees_per_dept
