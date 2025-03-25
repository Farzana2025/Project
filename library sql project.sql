create database LibraryDB;
use LibraryDB;
#create table
create table Books
(
	book_id int primary key auto_increment,
	title varchar(255) not null,
	author varchar(255) not null,
	genre varchar(100),
    published_year year,
    status ENUM('Available', 'Borrowed') DEFAULT 'Available' 
    
);

insert into Books (title, author, genre, published_year, status)
values
    ('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 'Borrowed'),
    ('1984', 'George Orwell', 'Dystopian', 1949, 'Available'),
    ('Moby Dick', 'Herman Melville', 'Adventure', 1901, 'Available'),
    ('Pride and Prejudice', 'Jane Austen', 'Romance', 1901, 'Borrowed');
    
SELECT 
    *
FROM
    Books;
    
create table Members
(
	member_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    address TEXT
);

INSERT INTO Members (name, email, phone, address) 
VALUES 
    ('Alice Johnson', 'alice.johnson@example.com', '123-456-7890', '123 Main St, New York, NY'),
    ('Bob Smith', 'bob.smith@example.com', '987-654-3210', '456 Oak St, Los Angeles, CA'),
    ('Charlie Brown', 'charlie.brown@example.com', '555-123-4567', '789 Pine St, Chicago, IL'),
    ('Diana Prince', 'diana.prince@example.com', '222-333-4444', '101 Maple St, Houston, TX'),
    ('Edward Wilson', 'edward.wilson@example.com', NULL, '202 Elm St, Miami, FL');
    
select * from Members;

create table Librarians 
(
    librarian_id INT PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL,
      email VARCHAR(255) UNIQUE NOT NULL,
       phone VARCHAR(20) UNIQUE
);

INSERT INTO Librarians (name, email, phone) 
VALUES 
    ('Emma Watson', 'emma.watson@example.com', '111-222-3333'),
    ('John Doe', 'john.doe@example.com', '444-555-6666'),
    ('Sarah Connor', 'sarah.connor@example.com', '777-888-9999'),
    ('Michael Scott', 'michael.scott@example.com', '123-321-4567'),
    ('Olivia Brown', 'olivia.brown@example.com', NULL);
    
select * from Librarians;

create table Borrowed_Books 
(
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT, 
	member_id INT,
	borrow_date DATE NOT NULL DEFAULT (CURDATE()), 
    return_date DATE DEFAULT NULL,
     FOREIGN KEY (book_id) REFERENCES Books(book_id),
      FOREIGN KEY (member_id) REFERENCES Members(member_id) 
);

INSERT INTO Borrowed_Books (book_id, member_id, borrow_date, return_date) 
VALUES 
    (1, 2, '2024-07-01', '2024-07-15'),
    (3, 1, '2024-07-05', NULL),
    (2, 4, '2024-07-10', '2024-07-20'),
    (4, 3, '2024-07-15', NULL),
    (5, 5, '2024-07-18', '2024-07-30');
select * from Borrowed_Books;

#View all available books: 
select * from Books where status = 'Available';

#Add a new book: 
insert into Books (title, author, genre, published_year, status)
values
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1980, 'Borrowed');

select * from Books;

#Update book status when borrowed: 
update Books set status = 'Borrowed' where book_id = 3;
select * from Books;

#Delete a member: 
#first need to check if borrowed book table and members table has common entry before deleting anything from members since both table is related via key member_id
DELETE FROM Borrowed_Books 
WHERE member_id IN (SELECT member_id FROM Members WHERE phone IS NULL);

DELETE FROM Members 
WHERE phone IS NULL;

select * from Members;

# Borrow a book:
select * from Books;
insert into Borrowed_Books (book_id, member_id, borrow_date, return_date) 
VALUES 
    (1, 2, '2024-10-05', '2024-10-15');
Update  Books 
set status ='Borrowed' where book_id = 1;
select * from Books;

#Return a book: 
UPDATE Borrowed_Books 
SET return_date = CURRENT_DATE 
WHERE book_id = 1 AND member_id = 2 AND return_date IS NULL;

UPDATE Books 
SET status = 'Available' 
WHERE book_id = 1;

select * from Borrowed_Books;
select * from Books;

#List of books currently borrowed: 
SELECT b.book_id, b.title, m.name, bb.borrow_date 
FROM Borrowed_Books bb
JOIN Books b ON bb.book_id = b.book_id
JOIN Members m ON bb.member_id = m.member_id
WHERE bb.return_date IS NULL;

#Overdue books (assuming a 14-day borrow period):
SELECT b.book_id, b.title, m.name AS borrowed_by, bb.borrow_date 
FROM Borrowed_Books bb
JOIN Books b ON bb.book_id = b.book_id
JOIN Members m ON bb.member_id = m.member_id
WHERE bb.return_date IS NULL AND bb.borrow_date < (CURRENT_DATE - INTERVAL 14 DAY);
