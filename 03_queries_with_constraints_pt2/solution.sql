-- ==============================================
-- SQLBolt - Lesson 3: Queries With Constraints
-- Part 2: Text comparisons and pattern matching
-- =============================================

-- Exercise 1: Find all Toy Story movies

SELECT *
FROM movies
WHERE title LIKE 'Toy Story%';


-- Exercise 2: Find all the movies directed by John Lasseter

SELECT *
FROM movies
WHERE director = 'John Lasseter';

-- Exercise 3: Find all the movies (and director) not directed by John Lasseter

SELECT *
FROM movies
WHERE director != 'John Lasseter';

-- Exercise 4: Find all the WALL-* movies

SELECT *
FROM movies
WHERE title LIKE 'WALL-%';