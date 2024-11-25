create database nihadb4;
use nihadb4;


#creating tables 
create table department
(
	department_id int primary key,
    department_name varchar(255)
);

create table employee
( 
	employee_id int primary key,
	employee_name varchar(255),
	salary decimal (10,2),
	department_id int,
    foreign key(department_id) references department(department_id)
    );

create table project
(
	project_id int primary key,
    project_name varchar(255),
    employee_id int,
    foreign key(employee_id) references employee(employee_id)
    );
 
 #insering data into department
 
 insert into department values
	(101, 'Finance'),
    (102, 'HR'),
    (103, 'Software Development'),
    (104, 'Finance'),
    (105, 'Marketing'),
    (106, 'New Project'),
    (107, 'Operations'),
    (108, 'IT'),
    (109, 'Customer Relations'),
    (110, 'Product Management'),
    (111, 'Sales'),
    (112, 'Supply Chain'),
    (113, 'Data Analytics'),
    (114, 'Quality Assurance'),
    (115, 'Business Development'),
    (116, 'Technical Support');
    
    insert into employee values
    (1, 'Max T', 60000, 101),
    (2, 'Raymond Zak', 650000, 101),
    (3, 'Jane Smith', 80000, 102),
    (4, 'Md Rahman', 70000, 103),
    (5, 'Jacquline Star', 80000, 104),
    (6, 'Julia More', 60000, 105),
    (7, 'Alice Brown', 55000, 106),
	(8, 'David Lee', 72000, 107),
	(9, 'Sophia Green', 85000, 108),
	(10, 'Liam Carter', 95000, 108),
	(11, 'Olivia Martinez', 63000, 109),
	(12, 'Noah Wilson', 58000, 110),
    (13, 'Emma Davis', 70000, 111),
	(14, 'William Brown', 78000, 112),
	(15, 'James Johnson', 67000, 113),
	(16, 'Isabella Garcia', 92000, 114),
	(17, 'Ethan Miller', 86000, 115),
	(18, 'Mia Hernandez', 75000, 116),
	(19, 'Michael Martinez', 64000, 114),
	(20, 'Charlotte Clark', 58000, 105),
	(21, 'Benjamin Rodriguez', 69000, 109),
	(22, 'Abigail Lopez', 87000, 111),
	(23, 'Lucas Gonzalez', 71000, 112),
	(24, 'Amelia Turner', 78000, 112),
	(25, 'Henry Walker', 66000, 113),
	(26, 'Harper Young', 74000, 114),
	(27, 'Alexander Hall', 91000, 115),
	(28, 'Ella King', 80000, 106),
	(29, 'Daniel Wright', 95000, 107),
	(30, 'Grace Scott', 60000, 110);
		
 insert into project values
 (1011, 'Project X', 1),
 (1012, 'Project Y', 2),
 (1013, 'Project Z', 3),
 (1014, 'Project M', 1),
 (1015, 'Project N', 5),
 (1016, 'Project O', 3),
 (1017, 'Project P', 10);
 
 #Select all employees along with their department names, including those who don't have a department.
 
 select 
	e.employee_id, e.employee_name, e.salary,
    d.department_name
from
	employee e
left join
	department d
on
	e.department_id = d.department_id;

#Find employees who earn more than their colleagues.
select e.employee_name, e.salary
from employee e
where e.salary > All
(
	select e2.salary
    from employee e2
    where e.employee_id != e2.employee_id
    AND e.department_id = e2.department_id
);

#Select employees who don't work in the Sales and IT departments

select e.employee_name from employee e
where e.department_id not in 
(select department_id
	from department
    where department_name in ('Sales', 'IT')
);

#Find departments with an average salary greater than $60,000

select d.department_name, Avg(e.salary) as AVG_Salary
from employee e
join department d
on e.department_id = d.department_id
group by d.department_name
having Avg(e.salary) > 60000;

#Select employees, their departments, and the projects they are working on

select e.employee_name, d.department_name, p.project_name
from employee e
left join department d
on e.employee_id = d.department_id
left join project p
on e.employee_id = p.employee_id;

#Write a query to find the total salary of employees working on more than one project, along with their project names and department names.

select Sum(e.salary) as Total_salary, d.department_name, p.project_name, group_concat(p.project_name) as Projects
from employee e
join project p
on e.employee_id = p.project_id
join department d
on e.department_id = d.department_id
group by e.employee_id, d.department_name
having count(p.employee_id) > 1;

#Write a query to find all employees who are not assigned to any project.
select e.employee_name
from employee e
left join project p
on e.employee_id = p.employee_id
where p.project_id is Null;

#Write a query to find employees who earn more than the average salary of their respective department.
select e.employee_name
from employee e
left join department d
on e.employee_id = d.department_name
where e.salary > (
select Avg(e2.salary)
from employee e2
where e2.department_id = e.department_id);
