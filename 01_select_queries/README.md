# Lesson 1 SELECT Queries 101

## Overview

SQL queries are statements used to retrieve and manipulate data stored in relational databases.

A **SELECT statement** is the fundamental SQL command used to retrieve data from a table. A query specifies which columns to retrieve and which table contains the requested data.

To understand how relational data is organized, consider a table as an entity (e.g., `Movies`), each row as an individual instance of that entity (a particular movie), and each column as a property shared by those instances (title, director, release year, etc.).

A query returns a two-dimensional result set consisting of rows and columns. The original table remains unchanged.

## Key Concepts

### 1. Tables, Rows, and Columns

| Component | Description | Example |
|---|---|---|
| Table | Represents an entity or collection of related data. | `movies` |
| Row | Represents one individual record. | Toy Story |
| Column | Represents an attribute or property. | `title`, `year` |
| Query | A statement used to retrieve or manipulate data. | `SELECT * FROM movies;` |

### 2. SELECT Retrieve Specific Columns

Use `SELECT` to specify which columns should appear in the result.

**Syntax:**

```sql
SELECT column1, column2, ...
FROM table_name;
```

**Example:**

```sql
SELECT title, director
FROM movies;
```

This retrieves only the `title` and `director` columns from the `movies` table, including all available rows.

The order of the columns in the SELECT clause determines their order in the returned result.

### 3. SELECT * Retrieve All Columns

The asterisk (`*`) is shorthand for selecting every column in a table.

**Syntax:**

```sql
SELECT *
FROM table_name;
```

**Example:**

```sql
SELECT *
FROM movies;
```

This retrieves all columns and all rows from the `movies` table.

This is particularly useful when inspecting an unfamiliar table or exploring its data.

## Syntax Reference

| Syntax | Description |
|---|---|
| `SELECT column FROM table;` | Retrieve a specific column. |
| `SELECT col1, col2 FROM table;` | Retrieve multiple specific columns. |
| `SELECT * FROM table;` | Retrieve all columns. |

## Important Notes

- SQL keywords are conventionally written in uppercase to improve readability. SQL itself does not require uppercase keywords.
- Column names and table names identify the data being queried.
- Column order in the SELECT clause determines output column order.
- `SELECT *` retrieves all columns, but it does not modify the underlying table.
- Every SQL statement should conventionally end with a semicolon (`;`).
- A SELECT query returns a result set; it does not create a new permanent table.

## PostgreSQL Notes

The SELECT syntax introduced in this lesson is supported directly by PostgreSQL.

For example:

```sql
SELECT title, year
FROM movies;
```

No PostgreSQL-specific syntax is required for these basic queries.

## FINAL Takeaways (for quick revision)

1. `SELECT` determines which columns to retrieve.
2. `FROM` identifies the source table.
3. `SELECT *` retrieves every column.
4. A query can return a subset of a table's columns without changing the original data.
5. SQL keywords are conventionally capitalized for readability.