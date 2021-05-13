-- HOMEWORK 7 QUERIES --

-------------------------------------------------
-- DATA COLLECTION --
-------------------------------------------------

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary --
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
LEFT JOIN salaries AS s ON
e.emp_no=s.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986. --
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name. --
SELECT dept.dept_no, d.dept_name, dept.emp_no, e.last_name, e.first_name
FROM dept_manager AS dept
LEFT JOIN  departments AS d ON
dept.dept_no = d.dept_no
LEFT JOIN employees AS e ON
dept.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name. --
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp as depte ON
e.emp_no = depte.emp_no
LEFT JOIN departments as d ON
d.dept_no = depte.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B." --
SELECT e.first_name, e.last_name, e.sex
FROM employees AS e
WHERE e.first_name = 'Hercules' AND 
LEFT(e.last_name, 1) = 'B';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name. --
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp
LEFT JOIN employees AS e ON
dept_emp.emp_no = e.emp_no
LEFT JOIN departments AS d ON
dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp
LEFT JOIN employees AS e ON
dept_emp.emp_no = e.emp_no
LEFT JOIN departments AS d ON
dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR
d.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name. --
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;