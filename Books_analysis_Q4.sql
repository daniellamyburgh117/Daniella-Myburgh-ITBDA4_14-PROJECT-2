CREATE DATABASE books_analysis;

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    price NUMERIC(10,2),
    rating VARCHAR(20),
    rating_number INTEGER,
    availability VARCHAR(50)
);

copy books(title, price, rating, rating_number, availability)
FROM '/Users/dani-myburgh/Downloads/books_clean.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM books;

SELECT COUNT(*)
FROM books;


SELECT
    rating,
    COUNT(*) AS number_of_books,
    ROUND(AVG(price), 2) AS average_price
FROM books
GROUP BY rating
ORDER BY average_price DESC;


SELECT
    CASE
        WHEN price < 20 THEN 'Low'
        WHEN price BETWEEN 20 AND 40 THEN 'Medium'
        ELSE 'High'
    END AS price_band,

    COUNT(*) AS number_of_books,

    ROUND(AVG(rating_number), 2) AS average_rating

FROM books

GROUP BY
    CASE
        WHEN price < 20 THEN 'Low'
        WHEN price BETWEEN 20 AND 40 THEN 'Medium'
        ELSE 'High'
    END

ORDER BY average_rating DESC;