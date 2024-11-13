#get all the columns from the Customers table .
select * from customers;
#select the Country column from the Customers table
select Country from Customers;
#select the City column from the Customers table
select City from Customers;
#Select all the different values from the Country column in the Customers table.
select Distinct Country from Customers;
#Select all records where the City column has the value "Berlin"
select * from Customers
	where City = "Berlin";
#Select all records where the CustomerID column has the value 32
select * from Customers
	where CustomerID = 32;
#Select all records from the Customers table, sort the result alphabetically by the column City
select * from Customers
	order by City;
#Select all records from the Customers table, sort the result reversed alphabetically by the column City
select * from Customers
	order by City desc;
#Select all records from the Customers table, sort the result alphabetically,
#first by the column Country, then, by the column City
Select * from Customers 
	order by Country, City;
#Select all records where the City column has the value 'Berlin' and the PostalCode column has the value '12209'
Select * from Customers
	where City= "Berlin" And PostalCode = 12209;
#Select all records where the City column has the value 'Berlin' OR 'London'
select * from Customers
	where City = "Berlin" or City = "London";
#or using IN 
select * from Customers
where City IN ('Berlin', 'London');

#Use the NOT keyword to select all records where City is NOT "Berlin"
Select * from Customers
	where Not City = "Berlin";

#Insert a new record in the Customers table.
 Insert into Customers
	(CustomerID, CustomerName, Address, City, PostalCode, Country)
	values(6, 'Hekkan Burger', 'Gateveien 15', 'Sandnes', '4306', 'Norway');
select * from Customers;

#Select all records from the Customers where the PostalCode column is empty
select * from Customers
	where PostalCode is NUll;
#Select all records from the Customers where the PostalCode column is NOT empty
select * from Customers
	where PostalCode is Not Null;
    
#Select all records from the Customers where the ContactName empty
select * from Customers
	where ContactName is  Null;

#Update the City column of all records in the Customers table.
SET SQL_SAFE_UPDATES = 0;

UPDATE Customers
SET City = 'Oslo';

Select * from Customers;

SET SQL_SAFE_UPDATES = 1;

select * from Customers;



