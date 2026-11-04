-- ==========================================
-- SQLBolt - Lesson 5: Review: Simple SELECT Queries
-- ==========================================

-- Exercise 1: List all the Canadian cities and their populations

SELECT city, population
from north_american_cities
WHERE country = 'Canada';

-- Exercise 2: Order all the cities in the United States by their latitude from north to south

SELECT *
FROM north_american_cities
WHERE country = 'United States'
ORDER BY latitude DESC;

-- Exercise 3: List all the cities west of Chicago, ordered from west to east

SELECT city
FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;

-- Exercise 4: List the two largest cities in Mexico (by population)

SELECT city
FROM north_american_cities
WHERE country = 'Mexico'
ORDER BY population DESC
LIMIT 2;

-- Exercise 5: List the third and fourth largest cities (by population) in the United States and their population

SELECT city, population
FROM north_american_cities
WHERE country = 'United States'
ORDER BY population DESC
LIMIT 2 OFFSET 2;
