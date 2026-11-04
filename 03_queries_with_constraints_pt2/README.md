# SQL Lesson 3: Queries with Constraints (Pt. 2)

This lesson focuses on filtering text-based columns using string comparison, pattern matching, and list membership operators.

These operators are useful when querying data based on names, titles, categories, or other textual values.

## 1. Text Comparison Operators

SQL supports several operators for comparing text values.

| Operator | Description | Example |
|:---:|---|---|
| `=` | Exact string match | `name = 'John'` |
| `!=` or `<>` | String inequality | `name != 'John'` |
| `LIKE` | Pattern matching (case-sensitive in PostgreSQL) | `name LIKE 'Jo%'` |
| `NOT LIKE` | Excludes matching patterns | `name NOT LIKE 'Jo%'` |
| `ILIKE` | Case-insensitive pattern matching (PostgreSQL) | `name ILIKE 'JO%'` |
| `NOT ILIKE` | Excludes case-insensitive matches (PostgreSQL) | `name NOT ILIKE 'JO%'` |
| `IN (...)` | Matches any value in a list | `name IN ('John', 'Jane')` |
| `NOT IN (...)` | Excludes values in a list | `name NOT IN ('John', 'Jane')` |

**PostgreSQL note:** SQLBolt describes `LIKE` as case-insensitive, but PostgreSQL's `LIKE` is case-sensitive. Use `ILIKE` when case-insensitive matching is required.

## 2. Wildcard Pattern Matching

The `LIKE` and `ILIKE` operators support wildcard characters that allow matching patterns instead of exact strings.

| Wildcard | Description | Example | Matches |
|:---:|---|---|---|
| `%` | Matches zero or more characters | `name LIKE 'Jo%'` | John, Joseph, Jo |
| `_` | Matches exactly one character | `name LIKE 'Jo_'` | Joe, Jon |

### Examples

```sql
-- Names starting with 'Jo'
SELECT *
FROM employees
WHERE name LIKE 'Jo%';

-- Names ending with 'son'
SELECT *
FROM employees
WHERE name LIKE '%son';

-- Names containing 'an'
SELECT *
FROM employees
WHERE name LIKE '%an%';

-- Names with exactly three characters, starting with 'Jo'
SELECT *
FROM employees
WHERE name LIKE 'Jo_';

-- Case-insensitive search in PostgreSQL
SELECT *
FROM employees
WHERE name ILIKE 'jo%';
```

## 3. List Membership: IN and NOT IN

Use `IN` to check whether a value matches any value in a specified list.

Use `NOT IN` to exclude values that appear in that list.

```sql
-- Select movies released in specific years
SELECT *
FROM movies
WHERE year IN (1995, 1997, 1999);

-- Exclude movies from specific years
SELECT *
FROM movies
WHERE year NOT IN (1995, 1997, 1999);
```

This is often cleaner than writing multiple conditions using `OR`.

For example:

```sql
-- Using OR
WHERE year = 1995 OR year = 1997 OR year = 1999;

-- Using IN
WHERE year IN (1995, 1997, 1999);
```

## 4. Important Notes

- String values must be enclosed in single quotes in PostgreSQL.
- `=` performs exact string comparison; it does not support wildcards.
- `%` matches zero or more characters.
- `_` matches exactly one character.
- `LIKE` is case-sensitive in PostgreSQL.
- `ILIKE` provides case-insensitive pattern matching in PostgreSQL.
- `IN` is useful for checking multiple possible values without chaining several `OR` conditions.
- `NOT IN` can behave unexpectedly when the list contains `NULL`, so be careful when using it with nullable data.

## 5. PostgreSQL vs. SQLBolt

| Feature | SQLBolt description | PostgreSQL |
|---|---|---|
| `LIKE` | Case-insensitive | Case-sensitive |
| `ILIKE` | Not covered in this lesson | Case-insensitive |
| String quotes | Double quotes in some examples | Single quotes for string literals |

**Reference:** [SQLBolt – Lesson 3](https://sqlbolt.com/lesson/select_queries_with_constraints_pt_2)
