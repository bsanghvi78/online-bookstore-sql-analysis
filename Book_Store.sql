-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
     DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:\Users\TUF\Desktop\Books.csv'
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'C:\Users\TUF\Desktop\Customers.csv'
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'C:\Users\TUF\Desktop\Orders.csv'
CSV HEADER;


-- 1) Retrieve all books in the "Fiction" genre:
Select  * FROM Books 
Where Genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year > 1950
ORDER BY Published_Year;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
where Country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) as TOTAL_STOCK 
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY price DESC 
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM ORDERS
WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE total_amount > 20
ORDER BY total_amount;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books
WHERE stock = (SELECT MIN(stock) FROM Books);

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) as Total_Revenue 
FROM Orders;

--FOR DEEPER UNDERSTANDING OF DATA 
-- 1) Retrieve the total number of books sold for each genre:

SELECT b.Genre,SUM(o.Quantity) as Total_books
FROM Orders o
JOIN Books b on o.book_id = b.book_id
GROUP BY b.Genre ; 


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT * FROM Books;
SELECT ROUND(AVG(price),2) as Average_price
FROM books 
WHERE genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) as Order_count 
FROM Orders o 
JOIN Customers c on c.Customer_ID = o.Customer_ID 
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 4) Find the most frequently ordered book:

SELECT o.Book_ID,b.Title, COUNT(o.Order_ID) as Order_count
FROM Orders o
JOIN Books b on b.Book_ID = o.Book_ID
GROUP BY o.Book_ID , b.Title 
ORDER BY Order_count DESC
FETCH FIRST 1 ROWS WITH TIES;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT Title,Price
FROM Books
WHERE Genre = 'Fantasy'
Order BY Price DESC 
Limit 3 ;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) as Total_quantity 
FROM Orders o 
JOIN Books b on b.book_id = o.book_id
GROUP BY b.author 
ORDER BY Total_quantity DESC; 

-- 7) List the cities where customers who spent over $30 are located:
SELECT  DISTINCT c.city, o.total_amount
FROM Customers c
JOIN Orders o On c.customer_id = o.customer_id
Where total_amount >30 ; 

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id,c.name , SUM(o.total_amount) as Total_spent
FROM Orders o 
JOIN customers c on c.customer_id = o.customer_id 
GROUP BY c.customer_id,c.name
ORDER BY Total_spent DESC 
LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id , b.title, b.stock , COALESCE(SUM(o.quantity),0) as Order_quantity,
	b.stock - COALESCE(SUM(o.quantity),0) as Remaining_stock 
FROM Books b 
LEFT JOIN orders o on b.book_id = o.book_id 
GROUP BY b.book_id 
ORDER BY b.book_id; 

