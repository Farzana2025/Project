create database employee_management;
use employee_management;
#create table

create table departments
(
	department_id int primary key auto_increment unique,
	department_name varchar(100),
    manager_id int
    
);

create table employees
(
	employee_id int primary key auto_increment unique,
	first_name varchar(50),
    last_name varchar(50),
	email varchar(100) unique,
	gender varchar(100),
    hire_date date,
    job_title varchar(50),
    department_id int,
    foreign key (department_id) references departments(department_id)
    
);

ALTER TABLE departments
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES employees(employee_id);




create table salaries
(
	salary_id int primary key auto_increment unique,
    employee_id int,
    basic_salary decimal(10,2),
    bonus decimal(10,2),
    total_salary decimal(10,2) generated always as (basic_salary +bonus ) stored,
    foreign key (employee_id) references employees(employee_id)
);


create table projects
(
	project_id int primary key auto_increment unique,
    project_name varchar(100),
    start_date Date,
    end_date date,
    status enum('Ongoing', 'Completed', 'On Hold')
);

create table employee_projects
(
	employee_id int,
    project_id int,
    assigned_date Date,
    foreign key (employee_id) references employees(employee_id),
    foreign key (project_id) references projects(project_id)
);

create table leaves
(
	leave_id int primary key unique auto_increment,
    employee_id int,
    leave_type enum('Sick', 'Casual', 'Paid', 'Unpaid'),
    start_date Date,
    end_date Date,
    status enum('Pending', 'Approved', 'Rejected'),
    foreign key (employee_id) references employees(employee_id)
);


INSERT INTO departments (department_name, manager_id) VALUES
('Human Resources', NULL),
('Engineering', NULL),
('Sales', NULL),
('Finance', NULL),
('IT Support', NULL);


INSERT INTO employees (first_name, last_name, email, gender, hire_date, job_title, department_id) VALUES
('Alice', 'Smith', 'alice.smith@example.com', 'Female', '2020-01-15', 'HR Manager', 1),
('Bob', 'Johnson', 'bob.johnson@example.com', 'Male', '2019-03-10', 'Engineer', 2),
('Charlie', 'Williams', 'charlie.w@example.com', 'Male', '2018-07-23', 'Sales Exec', 3),
('Diana', 'Brown', 'diana.b@example.com', 'Female', '2021-05-11', 'Finance Analyst', 4),
('Evan', 'Jones', 'evan.j@example.com', 'Male', '2020-11-02', 'IT Specialist', 5),
('Fiona', 'Garcia', 'fiona.g@example.com', 'Female', '2019-06-20', 'Engineer', 2),
('George', 'Martinez', 'george.m@example.com', 'Male', '2020-09-01', 'Sales Manager', 3),
('Hannah', 'Lee', 'hannah.l@example.com', 'Female', '2021-12-15', 'Accountant', 4),
('Ian', 'Perez', 'ian.p@example.com', 'Male', '2017-08-18', 'System Admin', 5),
('Julia', 'Clark', 'julia.c@example.com', 'Female', '2022-02-10', 'Recruiter', 1),
('Kyle', 'Lewis', 'kyle.l@example.com', 'Male', '2021-04-12', 'Developer', 2),
('Lily', 'Walker', 'lily.w@example.com', 'Female', '2020-10-25', 'Sales Rep', 3),
('Mike', 'Hall', 'mike.h@example.com', 'Male', '2019-12-30', 'Finance Officer', 4),
('Nina', 'Allen', 'nina.a@example.com', 'Female', '2021-07-04', 'Tech Support', 5),
('Owen', 'Young', 'owen.y@example.com', 'Male', '2022-05-16', 'HR Assistant', 1),
('Paula', 'King', 'paula.k@example.com', 'Female', '2020-03-09', 'Engineer', 2),
('Quinn', 'Wright', 'quinn.w@example.com', 'Non-binary', '2020-06-22', 'Sales Agent', 3),
('Rita', 'Scott', 'rita.s@example.com', 'Female', '2018-11-05', 'Finance Clerk', 4),
('Sam', 'Green', 'sam.g@example.com', 'Male', '2022-08-30', 'Helpdesk', 5),
('Tina', 'Baker', 'tina.b@example.com', 'Female', '2021-09-17', 'HR Coordinator', 1);


UPDATE departments
SET manager_id = 1
WHERE department_id = 1;

UPDATE departments
SET manager_id = 6
WHERE department_id = 2;

UPDATE departments
SET manager_id = 7
WHERE department_id = 3;

UPDATE departments
SET manager_id = 13
WHERE department_id = 4;

UPDATE departments
SET manager_id = 5
WHERE department_id = 5;

INSERT INTO salaries (employee_id, basic_salary, bonus) VALUES
(1, 60000, 5000),
(2, 75000, 7000),
(3, 55000, 4000),
(4, 68000, 6000),
(5, 52000, 3000),
(6, 72000, 6500),
(7, 65000, 5500),
(8, 70000, 5800),
(9, 53000, 3500),
(10, 48000, 2000),
(11, 78000, 8000),
(12, 57000, 4200),
(13, 69000, 6200),
(14, 50000, 2500),
(15, 46000, 1800),
(16, 73000, 7200),
(17, 56000, 3900),
(18, 64000, 5000),
(19, 49000, 2300),
(20, 51000, 2700);

INSERT INTO projects (project_name, start_date, end_date, status) VALUES
('Onboarding Revamp', '2022-01-10', '2022-06-30', 'Completed'),
('Salesforce Migration', '2023-03-01', NULL, 'Ongoing'),
('Payroll System Update', '2023-05-15', NULL, 'On Hold'),
('Cybersecurity Enhancement', '2022-08-01', '2023-02-28', 'Completed'),
('Mobile App Development', '2023-11-20', NULL, 'Ongoing');


INSERT INTO employee_projects (employee_id, project_id, assigned_date) VALUES
(1, 1, '2022-01-15'),
(2, 2, '2023-03-03'),
(3, 2, '2023-03-05'),
(4, 3, '2023-05-20'),
(5, 4, '2022-08-10'),
(6, 1, '2022-02-01'),
(7, 2, '2023-04-01'),
(8, 5, '2023-11-22'),
(9, 3, '2023-05-18'),
(10, 1, '2022-02-10'),
(11, 5, '2023-11-25'),
(12, 2, '2023-03-06'),
(13, 4, '2022-08-15'),
(14, 3, '2023-05-25'),
(15, 2, '2023-03-07'),
(16, 5, '2023-11-27'),
(17, 1, '2022-02-12'),
(18, 4, '2022-08-20'),
(19, 2, '2023-03-10'),
(20, 5, '2023-11-30');


INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status) VALUES
(1, 'Sick', '2023-01-10', '2023-01-12', 'Approved'),
(2, 'Casual', '2023-02-15', '2023-02-16', 'Approved'),
(3, 'Paid', '2023-03-01', '2023-03-05', 'Pending'),
(4, 'Unpaid', '2023-04-10', '2023-04-12', 'Rejected'),
(5, 'Sick', '2023-05-20', '2023-05-21', 'Approved'),
(6, 'Paid', '2023-06-10', '2023-06-14', 'Approved'),
(7, 'Casual', '2023-07-01', '2023-07-02', 'Approved'),
(8, 'Unpaid', '2023-08-05', '2023-08-07', 'Pending'),
(9, 'Sick', '2023-09-15', '2023-09-17', 'Approved'),
(10, 'Paid', '2023-10-10', '2023-10-15', 'Approved'),
(11, 'Casual', '2023-11-01', '2023-11-02', 'Approved'),
(12, 'Sick', '2023-12-20', '2023-12-22', 'Rejected'),
(13, 'Unpaid', '2024-01-05', '2024-01-06', 'Approved'),
(14, 'Paid', '2024-02-10', '2024-02-14', 'Approved'),
(15, 'Casual', '2024-03-01', '2024-03-03', 'Approved'),
(16, 'Sick', '2024-03-20', '2024-03-22', 'Pending'),
(17, 'Unpaid', '2024-04-05', '2024-04-07', 'Rejected'),
(18, 'Paid', '2024-05-10', '2024-05-15', 'Approved'),
(19, 'Casual', '2024-06-01', '2024-06-03', 'Approved'),
(20, 'Sick', '2024-07-10', '2024-07-12', 'Pending');

#employee management
#Add new employee
INSERT INTO employees (first_name, last_name, email, gender, hire_date, job_title, department_id)
VALUES ('John', 'Max', 'john.max@gmail.com', 'Male', '2023-09-01', 'Software Engineer', 2);
select* from employees;
#update
UPDATE employees
SET job_title = 'Senior Software Engineer', department_id = 2
WHERE employee_id = 1;

UPDATE employees
SET gender = 'Male', department_id = 3
WHERE employee_id = 17;
select * from employees;
#Delete newly added employee
DELETE FROM employees
WHERE employee_id = 21;
select * from employees;
#retrieve employee details based on department, job title, or project. 
select * from employees where department_id = 4;

#select employees who are assigned in a project with their department_id
select e.first_name, e.last_name, e.email, e.gender, e.hire_date, e.job_title, e.department_id, p.project_name
from employees e
join employee_projects ep on e.employee_id = ep.employee_id
join projects p on ep.employee_id= p.project_id;

#Department Management

# List departments with their managers

SELECT d.department_id,
       d.department_name,
       CONCAT(e.first_name, ' ', e.last_name) AS managers
FROM departments d
 JOIN employees e ON d.manager_id = e.employee_id;

#show employees within a department. 

SELECT *
FROM employees
WHERE department_id = 4;

#Salary Management

#generate payroll record
SELECT e.employee_id,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       s.basic_salary,
       s.bonus,
       s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id;



#Project Management

#Assign employees to projects
INSERT INTO employee_projects (employee_id, project_id, assigned_date)
VALUES (3, 1, '2023-10-01');

select * from employee_projects;


# track project progress and  completion status
SELECT project_id, project_name, status, start_date, end_date
FROM projects;

#Leave Management
# Request leave

INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status) VALUES
(1, 'Paid', '2024-02-12', '2024-02-13', 'Pending');

select * from leaves;


#track approval status

select * from leaves where status = 'Approved';


# generate reports on  leave history. 
SELECT
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       l.leave_type,
       l.start_date,
       l.end_date,
       l.status
FROM leaves l
JOIN employees e ON l.employee_id = e.employee_id;

#Fetch all employees along with their department and salary.

select 
 e.first_name, e. last_name, e.email, e.gender, e.hire_date, e.job_title, e.department_id, s.total_salary
 FROM employees e
 LEFT JOIN salaries s ON e.employee_id = s.employee_id;

#List employees working on a specific project name Mobile App Development. 

select 
	CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ep.assigned_date,
    p.project_name,
    p.status
    from employees e
    join employee_projects ep on e.employee_id = ep.employee_id
    join projects p on p.project_id = ep.project_id
    where p.project_name = 'Mobile App Development';
    
    
#Get the total salary expense for a given month. 





#Find employees with pending leave requests.
select 
CONCAT(e.first_name, ' ', e.last_name) as employee_name,
l.leave_type,
l.start_date,
l.end_date,
l.status
from employees e
join leaves l
on e.employee_id = l.employee_id
 where status = 'Pending';
 
#List departments along with the number of employees in each 
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employee
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;