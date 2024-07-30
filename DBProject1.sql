-- creating database 
CREATE DATABASE LibraryDB;

-- using newly created database 
USE LibraryDB;

--  creating books table that will hold attributes for books 
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    published_year INT
);

-- table that holds attriburtes for book burrowers 
CREATE TABLE Borrowers (
    borrower_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(15)
);

-- table for borrowed books that has id's of book and borrowers so we know who has burrowed which book in this table. 
CREATE TABLE BorrowedBooks (
    borrowed_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    borrower_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (borrower_id) REFERENCES Borrowers(borrower_id)
);

-- inserting sample data for books, burrowers and burrowedbooks

INSERT INTO Books (title, author, genre, published_year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
('1984', 'George Orwell', 'Dystopian', 1949);
 
INSERT INTO Borrowers (name, email, phone_number) VALUES
('John Doe', 'john@example.com', '1234567890'),
('Jane Smith', 'jane@example.com', '0987654321');

INSERT INTO BorrowedBooks (book_id, borrower_id, borrow_date, return_date) VALUES
(1, 1, '2024-07-01', NULL),
(2, 2, '2024-07-15', '2024-07-25');

-- doing basic query operations


-- quering all books / listing all books
SELECT * FROM Books;

-- listing all borrowers
SELECT * FROM Borrowers;


-- listing all burrowed books
SELECT BorrowedBooks.borrowed_id, Books.title, Borrowers.name, BorrowedBooks.borrow_date, BorrowedBooks.return_date
FROM BorrowedBooks
JOIN Books ON BorrowedBooks.book_id = Books.book_id
JOIN Borrowers ON BorrowedBooks.borrower_id = Borrowers.borrower_id;

-- updating return date for a returned book
UPDATE BorrowedBooks
SET return_date = '2024-08-01'
WHERE borrowed_id = 1;

-- listing updated burrowed books
SELECT BorrowedBooks.borrowed_id, Books.title, Borrowers.name, BorrowedBooks.borrow_date, BorrowedBooks.return_date
FROM BorrowedBooks
JOIN Books ON BorrowedBooks.book_id = Books.book_id
JOIN Borrowers ON BorrowedBooks.borrower_id = Borrowers.borrower_id;


-- Safely Deleting a Borrower Record

-- Check for Active Borrowed Books, Ensuring the borrower has no outstanding borrowed books (i.e., all borrowed books have a return_date set).
SELECT * FROM BorrowedBooks WHERE borrower_id = 2 AND return_date IS NULL;

-- Setting return_date if needed
UPDATE BorrowedBooks
SET return_date = '2024-08-01'
WHERE borrower_id = 2 AND return_date IS NULL;


-- Deleting Borrowed Books Records
DELETE FROM BorrowedBooks WHERE borrower_id = 2;

-- Delete the borrower record once all references are cleared (no books are borrowed by the user),then delete the borrower
DELETE FROM Borrowers WHERE borrower_id = 2;

-- listing updated burrowers
SELECT * FROM Borrowers;

