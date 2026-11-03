# Lesson 2 Queries With Constraints (Pt. 1)

## Overview

When working with databases containing large amounts of data, retrieving every row from a table is often unnecessary and inefficient.

SQL provides the `WHERE` clause to filter records based on specified conditions.

Unlike the SELECT clause, which determines which columns are returned, WHERE determines which rows qualify for inclusion in the result.

A condition is evaluated against the rows in the table, and only rows satisfying the specified condition are returned.

## Key Concepts

### 1. WHERE Filtering Rows

The WHERE clause specifies conditions that records must satisfy to appear in the query result.

**Syntax:**

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

**Example:**

```sql
SELECT title, year
FROM movies
WHERE year > 2000;
```

This retrieves the title and release year of movies released after 2000.

### 2. Comparison Operators

Comparison operators are used to compare numerical values.

| Operator | Meaning | Example |
|---|---|---|
| `=` | Equal to | `year = 1995` |
| `!=` | Not equal to | `year != 1995` |
| `<` | Less than | `year < 2000` |
| `<=` | Less than or equal to | `year <= 2000` |
| `>` | Greater than | `year > 2000` |
| `>=` | Greater than or equal to | `year >= 2000` |

**Examples:**

```sql
-- Movies released in 1995.
SELECT *
FROM movies
WHERE year = 1995;

-- Movies released before 2000.
SELECT *
FROM movies
WHERE year < 2000;

-- Movies released in or after 2000.
SELECT *
FROM movies
WHERE year >= 2000;

-- Movies not released in 1995.
SELECT *
FROM movies
WHERE year != 1995;
```

### 3. BETWEEN Filtering Within a Range

`BETWEEN` checks whether a value falls within a specified range.

Both boundary values are included (inclusive).

**Syntax:**

```sql
SELECT column1
FROM table_name
WHERE column_name BETWEEN lower_bound AND upper_bound;
```

**Example:**

```sql
SELECT title, year
FROM movies
WHERE year BETWEEN 1990 AND 2000;
```

This returns movies released from 1990 through 2000, including both 1990 and 2000.

To exclude a range, use `NOT BETWEEN`:

```sql
SELECT title, year
FROM movies
WHERE year NOT BETWEEN 1990 AND 2000;
```

### 4. IN Matching Values From a List

`IN` checks whether a column's value matches any value in a specified list.

**Syntax:**

```sql
SELECT column1
FROM table_name
WHERE column_name IN (value1, value2, value3);
```

**Example:**

```sql
SELECT title, year
FROM movies
WHERE year IN (1995, 1998, 2001);
```

This returns movies released in 1995, 1998, or 2001.

It is a convenient alternative to multiple OR conditions:

```sql
SELECT title, year
FROM movies
WHERE year = 1995
   OR year = 1998
   OR year = 2001;
```

Both queries express the same filtering requirement.

### 5. NOT IN Excluding Values From a List

`NOT IN` returns rows whose values do not match any value in the specified list.

**Syntax:**

```sql
SELECT column1
FROM table_name
WHERE column_name NOT IN (value1, value2, value3);
```

**Example:**

```sql
SELECT title, year
FROM movies
WHERE year NOT IN (1995, 1998, 2001);
```

This excludes movies released in those three years.

### 6. Logical Operators AND / OR

Logical operators allow multiple conditions to be combined within a WHERE clause.

**AND:** All conditions must be true.

```sql
SELECT title, year
FROM movies
WHERE year >= 1990
  AND year <= 2000;
```

Both conditions must be satisfied.

**OR:** At least one condition must be true.

```sql
SELECT title, year
FROM movies
WHERE year = 1995
   OR year = 2001;
```

A movie is returned if either condition is satisfied.

**Combining AND and OR:**

```sql
SELECT title, year
FROM movies
WHERE (year >= 1990 AND year <= 2000)
   OR year = 2005;
```

Parentheses make the intended logical grouping explicit.

## Syntax Reference

| Operator | Description | Example |
|---|---|---|
| `=` | Equal to | `year = 1995` |
| `!=` | Not equal to | `year != 1995` |
| `<` | Less than | `year < 2000` |
| `<=` | Less than or equal to | `year <= 2000` |
| `>` | Greater than | `year > 2000` |
| `>=` | Greater than or equal to | `year >= 2000` |
| `BETWEEN` | Within an inclusive range | `year BETWEEN 1990 AND 2000` |
| `NOT BETWEEN` | Outside an inclusive range | `year NOT BETWEEN 1990 AND 2000` |
| `IN` | Matches any value in a list | `year IN (1995, 1998)` |
| `NOT IN` | Matches none of the values in a list | `year NOT IN (1995, 1998)` |
| `AND` | Both conditions must be true | `year > 1990 AND year < 2000` |
| `OR` | At least one condition must be true | `year = 1995 OR year = 2000` |

## Important Notes

### Inclusive Range Boundaries

`BETWEEN` includes both boundary values.

```sql
WHERE year BETWEEN 1990 AND 2000;
```

This is equivalent to:

```sql
WHERE year >= 1990
  AND year <= 2000;
```

### AND vs. OR

- `AND` makes a condition more restrictive.
- `OR` makes a condition less restrictive.
- Parentheses should be used when combining logical conditions to make their intended evaluation explicit.

### Query Efficiency

Filtering rows can reduce the amount of data returned and the work required by the application consuming the results.

However, a WHERE clause does not automatically guarantee a faster database query. Actual performance depends on factors such as indexes, table size, selectivity, and the query execution plan.

## PostgreSQL Notes

All operators covered in this lesson are supported by PostgreSQL.

PostgreSQL also supports the standard SQL not-equal operator `<>`, which is equivalent to `!=`.

```sql
SELECT *
FROM movies
WHERE year <> 1995;
```

For more complex conditions, PostgreSQL follows SQL operator precedence rules. Parentheses are recommended whenever logical grouping might be unclear.

**NULL consideration:** Comparison operators do not match NULL values using ordinary equality or inequality. NULL handling is covered in a later lesson.

## Final Takeaways (for quick revision)

1. `WHERE` filters rows based on specified conditions.
2. Comparison operators allow numerical values to be compared.
3. `BETWEEN` checks an inclusive range.
4. `IN` and `NOT IN` simplify matching or excluding multiple values.
5. `AND` requires all conditions to be true.
6. `OR` requires at least one condition to be true.
7. Parentheses help control and clarify logical grouping.
8. Filtering reduces unnecessary returned data, but query performance also depends on database execution and indexing.