DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE salaries;
DROP TABLE titles;
DROP TABLE department;
DROP TABLE employees;


CREATE TABLE department (
	dept_no VARCHAR(200) PRIMARY KEY
	,dept_name VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE employees (
	emp_no INT PRIMARY KEY
	,birth_date DATE NOT NULL
	,first_name VARCHAR(50) NOT NULL
	,last_name VARCHAR(100) NOT NULL
	,gender VARCHAR(10) NOT NULL
	,hire_date DATE NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INT REFERENCES employees(emp_no)
	,dept_no VARCHAR(200) REFERENCES department(dept_no)
	,from_date DATE
	,to_date DATE
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(200) REFERENCES department(dept_no)
	,emp_no INT REFERENCES employees(emp_no)
	,from_date DATE
	,to_date DATE
);

CREATE TABLE salaries (
	emp_no INT REFERENCES employees(emp_no)
	,salary INT NOT NULL
	,from_date DATE
	,to_date DATE
);

CREATE TABLE titles (
	emp_no INT REFERENCES employees(emp_no)
	,title VARCHAR(200) NOT NULL
	,from_date DATE
	,to_date DATE
);

SELECT * FROM employees;



-- List the following details of each employee: employee number, last name, first name,
-- gender, and salary.
SELECT employees.emp_no,employees.first_name,employees.last_name,employees.gender,salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no=salaries.emp_no
ORDER BY employees.emp_no
;


-- List employees who were hired in 1986.
-- SELECT * FROM employees
-- WHERE hire_date LIKE '1986%';
SELECT * FROM employees
WHERE hire_date BETWEEN 1986-01-01 AND 1986-12-31;


-- List the manager of each department with the following information: department number,
-- department name, the manager's employee number, last name, first name, and start and
-- end employment dates.
SELECT department.dept_no,department.dept_name,dept_manager.emp_no,employees.first_name
,employees.last_name,dept_manager.from_date,dept_manager.to_date
FROM department
LEFT JOIN dept_manager
ON department.dept_no=dept_manager.dept_no
LEFT JOIN employees
ON dept_manager.emp_no=employees.emp_no
ORDER BY dept_no,emp_no
;


-- List the department of each employee with the following information: employee number,
-- last name, first name, and department name.
SELECT employees.emp_no,employees.first_name,employees.last_name,department.dept_no,department.dept_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no
LEFT JOIN department
ON dept_emp.dept_no=department.dept_no
ORDER BY employees.emp_no;


-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';


-- List all employees in the Sales department, including their employee number, last name,
-- first name, and department name.
SELECT employees.emp_no,dept_emp.emp_no,first_name,last_name,department.dept_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no
LEFT JOIN department
ON dept_emp.dept_no=department.dept_no
WHERE department.dept_name='Sales'
ORDER BY employees.emp_no;


-- List all employees in the Sales and Development departments, including their employee 
-- number, last name, first name, and department name.
SELECT employees.emp_no,dept_emp.emp_no,first_name,last_name,department.dept_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no
LEFT JOIN department
ON dept_emp.dept_no=department.dept_no
WHERE department.dept_name='Sales'
OR department.dept_name='Development'
ORDER BY employees.emp_no;


-- In descending order, list the frequency count of employee last names, i.e., how many
-- employees share each last name.
SELECT last_name,COUNT(*) FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;






