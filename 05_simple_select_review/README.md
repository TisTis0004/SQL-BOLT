# SQL Lesson 5: Simple SELECT Queries Review

This lesson is a practical review of the concepts covered in the previous lessons.

The goal is to combine filtering, sorting, and result-limiting clauses to solve queries against a different dataset.

The exercise uses information about some of the most populous cities in North America, including their population and geographical coordinates.

## 1. SELECT Query Structure

The following is the general query structure covered so far:

```sql
SELECT column_name, another_column
FROM table_name
WHERE condition
ORDER BY column_name ASC
LIMIT number_of_rows
OFFSET number_of_rows_to_skip;
```

Each clause serves a different purpose:

| Clause / Keyword | Purpose |
|---|---|
| `SELECT` | Specifies which columns to retrieve |
| `FROM` | Specifies the source table |
| `WHERE` | Filters rows based on conditions |
| `DISTINCT` | Removes duplicate result rows |
| `ORDER BY` | Sorts the results |
| `LIMIT` | Restricts the number of returned rows |
| `OFFSET` | Skips a specified number of rows |

## 2. Combining What We've Learned

The previous lessons introduced the following concepts:

### Column Selection

```sql
SELECT name, population
FROM cities;
```

Retrieve only the columns required.

### Filtering with WHERE

```sql
SELECT *
FROM cities
WHERE population > 1000000;
```

Return cities with a population greater than one million.

### Text Constraints

```sql
SELECT *
FROM cities
WHERE name LIKE 'New%';
```

Find cities whose names start with `New`.

In PostgreSQL, use `ILIKE` instead if the matching should be case-insensitive.

### Multiple Conditions

```sql
SELECT *
FROM cities
WHERE population > 1000000
  AND country = 'United States';
```

Combine conditions using logical operators such as `AND` and `OR`.

### Unique Results

```sql
SELECT DISTINCT country
FROM cities;
```

Retrieve each country only once.

### Sorting

```sql
SELECT *
FROM cities
ORDER BY population DESC;
```

Display the most populous cities first.

### Limiting and Pagination

```sql
SELECT *
FROM cities
ORDER BY population DESC
LIMIT 5 OFFSET 5;
```

Skip the first five cities and retrieve the next five.

## 3. Geographical Coordinates

The dataset introduces two geographical measurements:

| Coordinate | Description |
|---|---|
| Latitude | Measures a location's position north or south of the equator |
| Longitude | Measures a location's position east or west of the prime meridian |

Coordinate conventions:

- Positive latitude: Northern Hemisphere.
- Negative latitude: Southern Hemisphere.
- Positive longitude: Eastern Hemisphere.
- Negative longitude: Western Hemisphere.

Since North America is north of the equator and west of the prime meridian, the cities in this dataset have positive latitudes and negative longitudes.

## 4. Problem-Solving Approach

When solving the exercises, identify the required output before writing the query.

A useful approach:

1. **Identify the table:** Which table contains the required information?
2. **Identify the columns:** Which columns need to be returned?
3. **Determine the conditions:** What rows should be included or excluded?
4. **Determine sorting:** Does the task require ascending or descending order?
5. **Apply limits:** Does the task request a specific number of results or a particular subset?

Not every query needs every clause. Use only the clauses required to solve the problem.

## 5. Key Takeaways

By completing this review, you should be comfortable with:

- Selecting specific columns.
- Filtering rows using comparison operators.
- Combining conditions using `AND` and `OR`.
- Matching text using `LIKE`, `ILIKE`, and wildcards.
- Checking values against lists using `IN` and `NOT IN`.
- Removing duplicate results with `DISTINCT`.
- Sorting results using `ORDER BY`.
- Restricting results using `LIMIT` and `OFFSET`.

The next lesson introduces **JOINs**, allowing queries to retrieve and combine related information from multiple tables.

**Reference:** [SQLBolt – Lesson 5](https://sqlbolt.com/lesson/select_queries_review)
