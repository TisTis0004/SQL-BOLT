# SQL Lesson 4: Filtering and Sorting Query Results

This lesson introduces three important SQL clauses and keywords used to control query results:

- `DISTINCT` removes duplicate rows.
- `ORDER BY` sorts query results.
- `LIMIT` and `OFFSET` control how many rows are returned and where the results begin.

These features are particularly useful when working with large datasets.

## 1. DISTINCT Removing Duplicate Results

A database table may contain multiple rows with the same value in a particular column.

The `DISTINCT` keyword removes duplicate rows from the query result.

### Syntax

```sql
SELECT DISTINCT column_name
FROM table_name;
```

### Examples

```sql
-- Retrieve all unique release years
SELECT DISTINCT year
FROM movies;

-- Retrieve unique combinations of years and directors
SELECT DISTINCT year, director
FROM movies;
```

**Important:** `DISTINCT` considers the combination of all selected columns.

For example:

```sql
SELECT DISTINCT year, director
FROM movies;
```

This returns unique `(year, director)` combinations, not unique years independently.

## 2. ORDER BY Sorting Results

Database tables do not guarantee any particular row order unless you explicitly request one.

The `ORDER BY` clause sorts query results based on one or more columns.

### Syntax

```sql
SELECT column_name
FROM table_name
ORDER BY column_name ASC;
```

There are two sorting directions:

| Keyword | Description |
|---|---|
| `ASC` | Ascending order (default) |
| `DESC` | Descending order |

### Examples

```sql
-- Sort movies by release year, oldest first
SELECT *
FROM movies
ORDER BY year ASC;

-- Sort movies by release year, newest first
SELECT *
FROM movies
ORDER BY year DESC;

-- Sort by year, then title
SELECT *
FROM movies
ORDER BY year ASC, title ASC;
```

You can sort by multiple columns. PostgreSQL applies the next sorting column when values in the previous column are equal.

## 3. LIMIT Restricting the Number of Rows

The `LIMIT` clause specifies the maximum number of rows returned by a query.

### Syntax

```sql
SELECT column_name
FROM table_name
LIMIT number_of_rows;
```

### Examples

```sql
-- Return only the first five results
SELECT *
FROM movies
LIMIT 5;

-- Return the five newest movies
SELECT *
FROM movies
ORDER BY year DESC
LIMIT 5;
```

**Important:** Without `ORDER BY`, the rows returned by `LIMIT` are not guaranteed to be in a meaningful or consistent order.

## 4. OFFSET Skipping Rows

The `OFFSET` clause specifies how many rows to skip before returning results.

### Syntax

```sql
SELECT column_name
FROM table_name
LIMIT number_of_rows OFFSET number_of_rows_to_skip;
```

### Example

```sql
-- Skip the first five rows and return the next five
SELECT *
FROM movies
ORDER BY year ASC
LIMIT 5 OFFSET 5;
```

This is commonly used for pagination in applications.

For example, if a website displays 10 records per page:

| Page | LIMIT | OFFSET |
|---|---:|---:|
| 1 | 10 | 0 |
| 2 | 10 | 10 |
| 3 | 10 | 20 |
| 4 | 10 | 30 |

The offset can be calculated using:

```text
OFFSET = (page_number - 1) * page_size
```

## 5. Combining the Clauses

These clauses are frequently used together.

```sql
SELECT DISTINCT year
FROM movies
WHERE year >= 1990
ORDER BY year DESC
LIMIT 5;
```

This query:

1. Filters movies released in or after 1990.
2. Retrieves unique release years.
3. Sorts the years from newest to oldest.
4. Returns only the first five results.

## 6. Important Notes

- `DISTINCT` removes duplicate result rows, not duplicate records from the underlying table.
- When selecting multiple columns with `DISTINCT`, uniqueness applies to the entire selected combination.
- `ORDER BY` defaults to ascending order if no direction is specified.
- Multiple columns can be used for sorting.
- `LIMIT` controls the maximum number of returned rows.
- `OFFSET` skips rows before returning the result.
- Always use `ORDER BY` when you need predictable results with `LIMIT` and `OFFSET`.
- Large offsets can become inefficient in production systems. Keyset pagination is often preferable for large datasets.

**Reference:** [SQLBolt – Lesson 4](https://sqlbolt.com/lesson/filtering_sorting_query_results)
