-- Creating Retirement Titles Tables
SELECT e.emp_no,
    e.first_name,
    e.last_name,
	ti.titles,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.titles
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Creating Retiring Titles Tables
SELECT COUNT (ut.emp_no), ut.titles
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.titles
ORDER BY COUNT (ut.emp_no) DESC;

-- Creating Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.titles
INTO mentorship_eligibility
FROM employees AS e
    INNER JOIN dept_emp AS de
--  Joining Employees and Dept Employees on the Primary Key
    ON (e.emp_no = de.emp_no)
	INNER JOIN titles as ti
-- Joining Employees and Titles on the Primary Key
    ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;