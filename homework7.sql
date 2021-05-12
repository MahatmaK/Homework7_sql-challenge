-- HOMEWORK 7 QUERIES --

-------------------------------------------------
-- 1: CREATE TABLES BEFORE IMPORT --
-------------------------------------------------


-- Create titles table --
CREATE TABLE titles (
	titles_id VARCHAR NOT NULL,
	PRIMARY KEY (titles_id),
	title VARCHAR NOT NULL
);


-- Create employees table --
CREATE TABLE employees (
	emp_no INT NOT NULL,
	PRIMARY KEY (emp_no),
	emp_title_id VARCHAR NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(titles_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);


-- Create salaries table --
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	PRIMARY KEY (emp_no, salary)
);


-- Create departments table --
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	PRIMARY KEY (dept_no),
	dept_name VARCHAR NOT NULL
);


-- Create department employees table --
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);


-- Create department manager table --
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);


-------------------------------------------------
-- 2: IMPORT CSV FILES --
-------------------------------------------------

-------------------------------------------------
-- 3: DATA COLLECTION --
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

SELECT COUNT(*)
FROM dept_emp AS d;
LEFT JOIN employees AS e ON
e.emp_no = d.emp_no;

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