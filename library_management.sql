-- ============================================================
--  SECTION A: TABLE CREATION
-- ============================================================

CREATE TABLE Author (
    author_id    INT          PRIMARY KEY,
    author_name  VARCHAR(100) NOT NULL,
    nationality  VARCHAR(50)
);

CREATE TABLE Book (
    book_id      INT          PRIMARY KEY,
    title        VARCHAR(150) NOT NULL,
    author_id    INT          NOT NULL,
    genre        VARCHAR(50),
    price        DECIMAL(8,2) NOT NULL CHECK (price > 0),
    stock        INT          NOT NULL DEFAULT 1 CHECK (stock >= 0),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

CREATE TABLE Member (
    member_id    INT          PRIMARY KEY,
    member_name  VARCHAR(100) NOT NULL,
    phone        VARCHAR(15)  UNIQUE NOT NULL,
    email        VARCHAR(100),
    join_date    DATE         NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE Librarian (
    librarian_id   INT          PRIMARY KEY,
    librarian_name VARCHAR(100) NOT NULL,
    shift          VARCHAR(10)  CHECK (shift IN ('Morning','Evening','Night'))
);

CREATE TABLE Issue (
    issue_id      INT  PRIMARY KEY,
    book_id       INT  NOT NULL,
    member_id     INT  NOT NULL,
    librarian_id  INT  NOT NULL,
    issue_date    DATE NOT NULL,
    due_date      DATE NOT NULL,
    return_date   DATE,
    fine          DECIMAL(6,2) DEFAULT 0.00,
    FOREIGN KEY (book_id)      REFERENCES Book(book_id),
    FOREIGN KEY (member_id)    REFERENCES Member(member_id),
    FOREIGN KEY (librarian_id) REFERENCES Librarian(librarian_id),
    CHECK (due_date > issue_date),
    CHECK (return_date IS NULL OR return_date >= issue_date)
);


-- ============================================================
--  SECTION B: SAMPLE DATA INSERTION  (10 rows per table)
-- ============================================================

INSERT INTO Author (author_id, author_name, nationality) VALUES
(1,  'Chetan Bhagat',   'Indian'),
(2,  'J.K. Rowling',    'British'),
(3,  'George Orwell',   'British'),
(4,  'R.K. Narayan',    'Indian'),
(5,  'Paulo Coelho',    'Brazilian'),
(6,  'Dan Brown',       'American'),
(7,  'Agatha Christie', 'British'),
(8,  'Mark Twain',      'American'),
(9,  'Jane Austen',     'British'),
(10, 'Leo Tolstoy',     'Russian');

INSERT INTO Book (book_id, title, author_id, genre, price, stock) VALUES
(101, 'Five Point Someone',             1, 'Fiction',   500.00, 3),
(102, 'Harry Potter',                   2, 'Fantasy',   800.00, 5),
(103, '1984',                           3, 'Dystopian', 600.00, 2),
(104, 'Animal Farm',                    3, 'Dystopian', 450.00, 4),
(105, 'Malgudi Days',                   4, 'Fiction',   550.00, 3),
(106, 'The Alchemist',                  5, 'Philosophy',700.00, 6),
(107, 'The Da Vinci Code',              6, 'Thriller',  900.00, 2),
(108, 'Murder on the Orient Express',   7, 'Mystery',   650.00, 3),
(109, 'Adventures of Tom Sawyer',       8, 'Adventure', 400.00, 5),
(110, 'Pride and Prejudice',            9, 'Romance',   750.00, 4);

INSERT INTO Member (member_id, member_name, phone, email, join_date) VALUES
(1,  'Ram',   '9800000001', 'ram@example.com',   '2024-01-05'),
(2,  'Sita',  '9800000002', 'sita@example.com',  '2024-02-10'),
(3,  'Hari',  '9800000003', 'hari@example.com',  '2024-03-15'),
(4,  'Gita',  '9800000004', 'gita@example.com',  '2024-04-01'),
(5,  'Shyam', '9800000005', 'shyam@example.com', '2024-04-20'),
(6,  'Rita',  '9800000006', 'rita@example.com',  '2024-05-05'),
(7,  'Amit',  '9800000007', 'amit@example.com',  '2024-06-11'),
(8,  'Nita',  '9800000008', 'nita@example.com',  '2024-07-22'),
(9,  'Rohan', '9800000009', 'rohan@example.com', '2024-08-30'),
(10, 'Sneha', '9800000010', 'sneha@example.com', '2024-09-14');

INSERT INTO Librarian (librarian_id, librarian_name, shift) VALUES
(1,  'Anil',    'Morning'),
(2,  'Sunita',  'Evening'),
(3,  'Rajesh',  'Morning'),
(4,  'Pooja',   'Night'),
(5,  'Kiran',   'Evening'),
(6,  'Neha',    'Morning'),
(7,  'Suresh',  'Night'),
(8,  'Manisha', 'Evening'),
(9,  'Ramesh',  'Morning'),
(10, 'Kavita',  'Night');

INSERT INTO Issue (issue_id, book_id, member_id, librarian_id, issue_date, due_date, return_date, fine) VALUES
(1,  101, 1,  1,  '2025-01-10', '2025-01-24', '2025-01-22', 0.00),
(2,  102, 2,  2,  '2025-01-12', '2025-01-26', '2025-01-28', 20.00),
(3,  103, 3,  3,  '2025-01-15', '2025-01-29', '2025-01-29', 0.00),
(4,  104, 4,  4,  '2025-01-18', '2025-02-01', NULL,         0.00),
(5,  105, 5,  5,  '2025-01-20', '2025-02-03', '2025-02-05', 20.00),
(6,  106, 6,  6,  '2025-01-22', '2025-02-05', NULL,         0.00),
(7,  107, 7,  7,  '2025-01-25', '2025-02-08', '2025-02-07', 0.00),
(8,  108, 8,  8,  '2025-01-27', '2025-02-10', '2025-02-12', 20.00),
(9,  109, 9,  9,  '2025-01-28', '2025-02-11', NULL,         0.00),
(10, 110, 10, 10, '2025-01-30', '2025-02-13', '2025-02-13', 0.00);


-- ============================================================
--  SECTION C: QUERIES
-- ============================================================

-- -------------------------------------------------------
-- Q1. INNER JOIN — Every book with its author name
-- -------------------------------------------------------
SELECT b.book_id, b.title, a.author_name, b.genre, b.price
FROM   Book b
INNER JOIN Author a ON b.author_id = a.author_id
ORDER BY b.title;

-- -------------------------------------------------------
-- Q2. LEFT JOIN — All members and any books they borrowed
--     (members who never borrowed a book also appear)
-- -------------------------------------------------------
SELECT m.member_id, m.member_name,
       b.title         AS book_title,
       i.issue_date,
       i.due_date
FROM   Member m
LEFT  JOIN Issue i ON m.member_id = i.member_id
LEFT  JOIN Book  b ON i.book_id   = b.book_id
ORDER BY m.member_id;

-- -------------------------------------------------------
-- Q3. RIGHT JOIN — All librarians and issues they handled
-- -------------------------------------------------------
SELECT l.librarian_name, l.shift,
       i.issue_id, i.issue_date
FROM   Issue i
RIGHT JOIN Librarian l ON i.librarian_id = l.librarian_id
ORDER BY l.librarian_id;

-- -------------------------------------------------------
-- Q4. Aggregate — COUNT books per author
-- -------------------------------------------------------
SELECT a.author_name,
       COUNT(b.book_id) AS total_books
FROM   Author a
LEFT  JOIN Book b ON a.author_id = b.author_id
GROUP BY a.author_id, a.author_name
ORDER BY total_books DESC;

-- -------------------------------------------------------
-- Q5. Aggregate — SUM & AVG price per genre
-- -------------------------------------------------------
SELECT genre,
       COUNT(*)          AS total_titles,
       SUM(price)        AS total_value,
       ROUND(AVG(price), 2) AS avg_price,
       MIN(price)        AS cheapest,
       MAX(price)        AS most_expensive
FROM   Book
GROUP BY genre
ORDER BY avg_price DESC;

-- -------------------------------------------------------
-- Q6. Aggregate — Total fine collected per member
-- -------------------------------------------------------
SELECT m.member_name,
       COUNT(i.issue_id)   AS books_borrowed,
       SUM(i.fine)         AS total_fine
FROM   Member m
JOIN   Issue i ON m.member_id = i.member_id
GROUP BY m.member_id, m.member_name
HAVING SUM(i.fine) > 0
ORDER BY total_fine DESC;

-- -------------------------------------------------------
-- Q7. Subquery — Books priced above average price
-- -------------------------------------------------------
SELECT title, genre, price
FROM   Book
WHERE  price > (SELECT AVG(price) FROM Book)
ORDER BY price DESC;

-- -------------------------------------------------------
-- Q8. Subquery — Members who have NOT yet returned a book
-- -------------------------------------------------------
SELECT member_name, phone, email
FROM   Member
WHERE  member_id IN (
    SELECT member_id
    FROM   Issue
    WHERE  return_date IS NULL
);

-- -------------------------------------------------------
-- Q9. VIEW — Issue details (member + book + librarian)
-- -------------------------------------------------------
CREATE VIEW IssueDetails AS
SELECT i.issue_id,
       m.member_name,
       b.title            AS book_title,
       a.author_name,
       l.librarian_name,
       i.issue_date,
       i.due_date,
       i.return_date,
       CASE
           WHEN i.return_date IS NULL THEN 'Not Returned'
           WHEN i.return_date > i.due_date THEN 'Returned Late'
           ELSE 'Returned On Time'
       END                AS status,
       i.fine
FROM   Issue i
JOIN   Member    m ON i.member_id    = m.member_id
JOIN   Book      b ON i.book_id      = b.book_id
JOIN   Author    a ON b.author_id    = a.author_id
JOIN   Librarian l ON i.librarian_id = l.librarian_id;

-- Use the view
SELECT * FROM IssueDetails;

-- -------------------------------------------------------
-- Q10. VIEW — Available stock summary
-- -------------------------------------------------------
CREATE VIEW BookStock AS
SELECT b.book_id, b.title, a.author_name, b.genre,
       b.stock                                             AS total_stock,
       COUNT(i.issue_id)                                  AS currently_issued,
       (b.stock - COUNT(i.issue_id))                      AS available
FROM   Book b
JOIN   Author a ON b.author_id = a.author_id
LEFT  JOIN Issue i ON b.book_id = i.book_id AND i.return_date IS NULL
GROUP BY b.book_id, b.title, a.author_name, b.genre, b.stock;

SELECT * FROM BookStock ORDER BY available;

-- -------------------------------------------------------
-- Q11. TRANSACTION — Issue a new book safely
-- -------------------------------------------------------
START TRANSACTION;

    -- Step 1: Insert the issue record
    INSERT INTO Issue (issue_id, book_id, member_id, librarian_id,
                       issue_date, due_date)
    VALUES (11, 101, 2, 3, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY));

    -- Step 2: Reduce stock
    UPDATE Book SET stock = stock - 1 WHERE book_id = 101;

    -- Verify stock has not gone negative
    -- (In application code you would check and ROLLBACK if stock < 0)

COMMIT;

-- -------------------------------------------------------
-- Q12. TRANSACTION — ROLLBACK demo (duplicate member)
-- -------------------------------------------------------
START TRANSACTION;

    INSERT INTO Member (member_id, member_name, phone, email, join_date)
    VALUES (3, 'Hari Duplicate', '9800000003', 'x@x.com', CURRENT_DATE);
    -- This INSERT will fail because member_id=3 already exists.
    -- ROLLBACK keeps the database clean.

ROLLBACK;

-- -------------------------------------------------------
-- Q13. TRANSACTION — Return a book and apply fine
-- -------------------------------------------------------
START TRANSACTION;

    UPDATE Issue
    SET    return_date = CURRENT_DATE,
           fine = GREATEST(0, DATEDIFF(CURRENT_DATE, due_date)) * 10
    WHERE  issue_id = 9;

    UPDATE Book SET stock = stock + 1 WHERE book_id = 109;

COMMIT;
