-- ==============================================
-- SQLBolt - Lesson 2: Queries With Constraints
-- Part 1: Numerical Filtering
-- =============================================


----------------SYNTAX----------------
-- SELECT column, another_column, ...
-- FROM mytable
-- WHERE condition
--      AND/OR another_condition
--      AND/OR ...;


-- Operator 	                              Condition 	                                       SQL Example
-- =, !=, <, <=, >, >= 	           Standard numerical operators 	                        col_name != 4
-- BETWEEN _ AND _ 	               Number is within range of two values (inclusive) 	    col_name BETWEEN 1.5 AND 10.5
-- NOT BETWEEN _ AND _ 	           Number is not within range of two values (inclusive) 	col_name NOT BETWEEN 1 AND 10
-- IN (_) 	                       Number exists in a list 	                                col_name IN (2, 4, 6)
-- NOT IN (_) 	                   Number does not exist in a list 	                        col_name NOT IN (1, 3, 5)





-- Exercise 1: Find the movie with a row id of 6.

SELECT *
FROM movies
WHERE id = 6;

-- Exercise 2: Find the movies released in the years between 2000 and 2010.

SELECT *
FROM movies
WHERE year BETWEEN 2000 AND 2010;

-- Exercise 3: Find the movies not released in the years between 2000 and 2010.

SELECT *
FROM movies
WHERE year NOT BETWEEN 2000 AND 2010;

-- Exercise 4: Find the first 5 Pixar movies and their release year.

SELECT title, year
FROM movies
WHERE id <= 5;
