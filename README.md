# SQLBolt SQL Learning Notes & PostgreSQL Practice

A structured, hands-on journey through SQL, documenting concepts, solving exercises, and executing queries against a real PostgreSQL database.


---

## Table of Contents

- [Overview](#overview)
- [Learning Objectives](#learning-objectives)
- [Project Structure](#project-structure)
- [Technology Stack](#technology-stack)
- [Environment Setup](#environment-setup)
  - [Prerequisites](#1-prerequisites)
  - [Start PostgreSQL with Docker](#2-start-postgresql-with-docker)
  - [Install PostgreSQL Client](#3-install-the-postgresql-client-psql)
  - [Initialize the Database](#4-initialize-the-database)
  - [Verify the Installation](#5-verify-the-installation)
- [Working Through the Lessons](#working-through-the-lessons)
- [Executing SQL Files](#executing-sql-files)
- [Writing Notes and Solutions](#writing-notes-and-solutions)
- [Database Management](#database-management)
- [PostgreSQL vs. Standard SQL](#postgresql-vs-standard-sql)
- [Troubleshooting](#troubleshooting)
- [References](#references)

---

## Overview

[SQLBolt](https://sqlbolt.com/) is an interactive SQL tutorial consisting of 18 lessons covering fundamental SQL concepts, querying relational databases, manipulating data, and managing database structures.

This repository extends that learning experience beyond the browser.

Instead of relying exclusively on SQLBolt's interactive environment, exercises are documented and executed locally against a PostgreSQL database.

The repository maintains two complementary learning resources:

| Resource         | Purpose                                                                 |
| ---------------- | ----------------------------------------------------------------------- |
| Markdown (`.md`) | Document concepts, explanations, examples, observations, and takeaways. |
| SQL (`.sql`)     | Store executable exercise solutions and additional queries.             |

The goal is not simply to collect exercise answers. It is to understand how SQL works, why particular queries produce particular results, and how to work with a database using tools and workflows commonly found in software development.

## Learning Objectives

By completing this repository, the objectives are to:

- Understand relational databases, tables, rows, columns, and relationships.
- Write SQL queries to retrieve, filter, sort, and transform data.
- Understand and apply different types of JOIN operations.
- Work with NULL values and conditional expressions.
- Perform aggregations using functions such as COUNT, SUM, AVG, MIN, and MAX.
- Understand GROUP BY, HAVING, and SQL query execution order.
- Manipulate existing records using INSERT, UPDATE, and DELETE.
- Create, modify, and remove database tables.
- Understand the distinction between querying data and modifying database structures.
- Become comfortable using PostgreSQL, Docker, and the `psql` command-line interface.

## Project Structure

The repository follows a paired-file approach: each lesson has a Markdown document for learning notes and an SQL file containing executable solutions.

```text
SQL-Bolt/
│
├── README.md
├── init_db.sql
│
├── 01_select_queries/
│   ├── README.md
│   └── solution.sql
│
├── 02_queries_with_constraints_pt1/
│   ├── README.md
│   └── solution.sql
│
├── 03_queries_with_constraints_pt2/
│   ├── README.md
│   └── solution.sql
│
├── 04_filtering_and_sorting/
│   ├── README.md
│   └── solution.sql
│
├── 05_simple_select_review/
│   ├── README.md
│   └── solution.sql
│
├── 06_multi_table_joins/
│   ├── README.md
│   └── solution.sql
│
├── 07_outer_joins/
│   ├── README.md
│   └── solution.sql
│
├── 08_null_values/
│   ├── README.md
│   └── solution.sql
│
├── 09_expressions/
│   ├── README.md
│   └── solution.sql
│
├── 10_aggregate_functions_pt1/
│   ├── README.md
│   └── solution.sql
│
├── 11_aggregate_functions_pt2/
│   ├── README.md
│   └── solution.sql
│
├── 12_query_execution_order/
│   ├── README.md
│   └── solution.sql
│
├── 13_inserting_rows/
│   ├── README.md
│   └── solution.sql
│
├── 14_updating_rows/
│   ├── README.md
│   └── solution.sql
│
├── 15_deleting_rows/
│   ├── README.md
│   └── solution.sql
│
├── 16_creating_tables/
│   ├── README.md
│   └── solution.sql
│
├── 17_altering_tables/
│   ├── README.md
│   └── solution.sql
│
└── 18_dropping_tables/
    ├── README.md
    └── solution.sql
```

### Why this structure?

- Each lesson is self-contained.
- Notes and executable queries are kept together.
- The root `init_db.sql` prepares the initial database and its sample data.
- Lessons can be revisited independently.
- The repository remains easy to navigate as more material is added.

The database initialization script is separate because the exercises depend on predefined tables and sample records.

**Important:** The initial schema must include every table and dataset required by the lessons, not just `movies`. As the course progresses, some exercises also modify or delete existing data and tables.

---

## Technology Stack

| Technology    | Role                                       |
| ------------- | ------------------------------------------ |
| SQL           | Query and manipulate relational data.      |
| PostgreSQL 16 | Local relational database engine.          |
| Docker        | Run PostgreSQL in an isolated container.   |
| psql          | PostgreSQL command-line client.            |
| Markdown      | Document concepts and learning notes.      |
| Git & GitHub  | Track progress and version the repository. |

### Understanding the architecture

The local environment consists of three separate components:

```text
             Your Computer
                   |
          +--------+--------+
          |                 |
      SQL Files         psql Client
          |                 |
          +--------+--------+
                   |
              localhost
                :5432
                   |
          Docker Port Mapping
                   |
          +------------------+
          |    PostgreSQL    |
          |     Container    |
          |                  |
          |   sqlbolt DB     |
          |                  |
          |   Tables         |
          |   Records        |
          +------------------+
```

**PostgreSQL** is the actual database server that stores and processes data.

**Docker** runs the database server in an isolated environment without requiring a native PostgreSQL server installation.

**psql** is the client that connects to PostgreSQL and sends SQL commands for execution.

The SQL files are simply scripts. They do not execute themselves; `psql` reads them and sends their statements to the database server.

---

## Environment Setup

The recommended setup uses Docker to run PostgreSQL on both Linux and Windows.

This avoids maintaining two different database installations and provides a consistent environment across operating systems.

### 1. Prerequisites

Install the following:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) on Windows.
- Docker Engine on Linux.
- PostgreSQL client (`psql`).

Verify Docker is installed:

```bash
docker --version
```

Verify Docker is running:

```bash
docker info
```

### 2. Start PostgreSQL with Docker

Run the following command in PowerShell, Bash, or Fish:

```bash
docker run --name sqlbolt-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=postgres \
  -p 5432:5432 \
  -v sqlbolt-data:/var/lib/postgresql/data \
  -d postgres:16
```

On PowerShell, you can use the same command on one line, or use PowerShell's backtick character for line continuation.

#### Breaking down the command

| Argument                      | Explanation                                         |
| ----------------------------- | --------------------------------------------------- |
| `docker run`                  | Creates and starts a new container.                 |
| `--name sqlbolt-postgres`     | Assigns a recognizable name to the container.       |
| `-e POSTGRES_USER=postgres`   | Sets the initial PostgreSQL superuser.              |
| `-e POSTGRES_PASSWORD=secret` | Sets the initial user's password.                   |
| `-e POSTGRES_DB=postgres`     | Creates the initial database.                       |
| `-p 5432:5432`                | Maps host port 5432 to container port 5432.         |
| `-v sqlbolt-data:...`         | Persists database files in a Docker-managed volume. |
| `-d`                          | Runs the container in the background.               |
| `postgres:16`                 | Uses the official PostgreSQL 16 Docker image.       |

**Why use a Docker volume?**

Containers and their stored data are different things.

The named volume `sqlbolt-data` keeps your database files outside the container's writable layer. Restarting or recreating the container does not automatically erase your database.

The database password is for local learning only. Do not reuse it for production applications.

### 3. Install the PostgreSQL Client (psql)

You need `psql` to execute your `.sql` files from your host terminal.

**Linux (Fedora):**

```bash
sudo dnf install postgresql
```

**Linux (Ubuntu/Debian):**

```bash
sudo apt install postgresql-client
```

**Windows:**

Install PostgreSQL using the official [PostgreSQL Windows installer](https://www.postgresql.org/download/windows/).

During installation, you can install the command-line tools. Add PostgreSQL's `bin` directory to your Windows PATH if `psql` is not recognized.

Alternatively, you can execute `psql` directly inside the running Docker container, without installing it on Windows:

```powershell
docker exec -it sqlbolt-postgres psql -U postgres
```

Verify the client installation:

```bash
psql --version
```

### 4. Initialize the Database

Before executing lesson solutions, the database must contain the required tables and sample records.

This repository uses `init_db.sql` as the initial database setup script.

Execute it from the repository root:

```bash
psql -h localhost -p 5432 -U postgres -d postgres -f init_db.sql
```

Enter the password:

```text
secret
```

#### What does this command do?

| Argument         | Explanation                                                       |
| ---------------- | ----------------------------------------------------------------- |
| `psql`           | Launches the PostgreSQL command-line client.                      |
| `-h localhost`   | Connects to PostgreSQL running on your computer.                  |
| `-p 5432`        | Connects through port 5432.                                       |
| `-U postgres`    | Authenticates as the PostgreSQL user `postgres`.                  |
| `-d postgres`    | Connects initially to the default `postgres` database.            |
| `-f init_db.sql` | Reads and executes the SQL commands from the initialization file. |

The initialization script is responsible for creating the `sqlbolt` database, creating the necessary tables, and inserting their initial records.

For example, the script can contain:

```sql
CREATE DATABASE sqlbolt;

\connect sqlbolt

CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    director VARCHAR(255),
    year INT,
    length_minutes INT
);
```

The `\connect` command is a `psql` meta-command, not standard SQL. It switches the active connection to the newly created database.

**Note:** This is a one-time initialization step for a fresh database. The complete seed script must be prepared before running the full course. Re-running database creation or insertion statements without handling existing objects can produce errors or duplicate records.

### 5. Verify the Installation

Connect to your new database:

```bash
psql -h localhost -p 5432 -U postgres -d sqlbolt
```

List all available tables:

```sql
\dt
```

Inspect the movies table:

```sql
\d movies
```

View its records:

```sql
SELECT * FROM movies;
```

Exit the PostgreSQL shell:

```sql
\q
```

If the tables and sample records are displayed correctly, your environment is ready.

---

## Working Through the Lessons

The learning workflow is intentionally simple:

1. Open the corresponding [SQLBolt lesson](https://sqlbolt.com/).
2. Read the explanation and understand the concept.
3. Attempt the interactive exercises yourself.
4. Write your solutions in the corresponding `solution.sql`.
5. Execute the SQL file against your local PostgreSQL database.
6. Document the concepts, syntax, and anything worth remembering in the lesson's `README.md`.
7. Commit your work to Git.

### Course Progress

The following checklist tracks the 18 main lessons.

#### Fundamentals

- [Lesson 1 SELECT Queries 101](01_select_queries/README.md)
- [Lesson 2 Queries With Constraints (Pt. 1)](02_queries_with_constraints_pt1/README.md)
- [Lesson 3 Queries With Constraints (Pt. 2)](03_queries_with_constraints_pt2/README.md)
- [Lesson 4 Filtering and Sorting Query Results](04_filtering_and_sorting/README.md)
- [Lesson 5 Simple SELECT Queries (Review)](05_simple_select_review/README.md)

#### Relationships and Data Analysis

- [Lesson 6 Multi-table Queries With JOINs](06_multi_table_joins/README.md)
- [Lesson 7 OUTER JOINs](07_outer_joins/README.md)
- [Lesson 8 A Short Note on NULLs](08_null_values/README.md)
- [Lesson 9 Queries With Expressions](09_expressions/README.md)
- [Lesson 10 Queries With Aggregates (Pt. 1)](10_aggregate_functions_pt1/README.md)
- [Lesson 11 Queries With Aggregates (Pt. 2)](11_aggregate_functions_pt2/README.md)
- [Lesson 12 Order of Execution of a Query](12_query_execution_order/README.md)

#### Data Manipulation and Database Structure

- [Lesson 13 Inserting Rows](13_inserting_rows/README.md)
- [Lesson 14 Updating Rows](14_updating_rows/README.md)
- [Lesson 15 Deleting Rows](15_deleting_rows/README.md)
- [Lesson 16 Creating Tables](16_creating_tables/README.md)
- [Lesson 17 Altering Tables](17_altering_tables/README.md)
- [Lesson 18 Dropping Tables](18_dropping_tables/README.md)

---

## Executing SQL Files

Each lesson's `solution.sql` contains the executable queries for that lesson.

For example, to execute Lesson 1:

**Linux / Windows PowerShell:**

```bash
psql -h localhost -p 5432 -U postgres -d sqlbolt -f 01_select_queries/solution.sql
```

This connects to the `sqlbolt` database and executes every SQL statement in the specified file.

The results of `SELECT` statements are printed directly in the terminal.

### Running SQL inside the Docker container

If you do not have `psql` installed on your host machine, you can use the PostgreSQL client bundled inside the container.

From the repository root:

**Linux:**

```bash
docker exec -i sqlbolt-postgres \
  psql -U postgres -d sqlbolt \
  < 01_select_queries/solution.sql
```

**Windows PowerShell:**

```powershell
Get-Content .\01_select_queries\solution.sql -Raw |
    docker exec -i sqlbolt-postgres psql -U postgres -d sqlbolt
```

### Avoid entering the password every time (Optional)

You can temporarily set the `PGPASSWORD` environment variable.

**Linux (Bash):**

```bash
PGPASSWORD=secret psql -h localhost -U postgres -d sqlbolt -f 01_select_queries/solution.sql
```

**Linux (Fish):**

```fish
env PGPASSWORD=secret psql -h localhost -U postgres -d sqlbolt -f 01_select_queries/solution.sql
```

**Windows PowerShell:**

```powershell
$env:PGPASSWORD = "secret"
psql -h localhost -U postgres -d sqlbolt -f .\01_select_queries\solution.sql
Remove-Item Env:PGPASSWORD
```

These approaches are convenient for local practice. Avoid putting real database credentials directly into scripts or Git-tracked files.

---

## Writing Notes and Solutions

Each lesson has two files.

### 1. README.md Concepts and Notes

The Markdown document should explain what you learned rather than simply reproduce the SQLBolt lesson.

Recommended structure:

````markdown
# Lesson X Lesson Title

## Overview

What does this lesson cover?

## Key Concepts

- Concept 1
- Concept 2
- Concept 3

## Syntax Reference

```sql
SELECT column_name
FROM table_name
WHERE condition;
````

## Examples

Explain important queries with sample SQL.

## Important Notes

- Rules worth remembering.
- Common mistakes.
- Edge cases and behavior.

## PostgreSQL Notes

Document any differences between SQLBolt's environment
and PostgreSQL.

## Takeaways

Summarize the most important things learned.

````

### 2. solution.sql Executable Queries

Keep the exercise solutions organized using SQL comments.

```sql
-- ==========================================
-- Lesson 1: SELECT Queries 101
-- ==========================================

-- Exercise 1: Find the title of each film.

SELECT title
FROM movies;


-- Exercise 2: Find the director of each film.

SELECT director
FROM movies;


-- Exercise 3: Find the title and director of each film.

SELECT title, director
FROM movies;
````

Keep queries independent where possible and make sure each statement ends with a semicolon.

The SQL file should be executable as a standalone lesson whenever its required tables and data are available.

---

## Database Management

These are the most frequently used Docker commands for managing the local database.

| Command                                 | Purpose                                         |
| --------------------------------------- | ----------------------------------------------- |
| `docker ps`                             | Display currently running containers.           |
| `docker ps -a`                          | Display all containers, including stopped ones. |
| `docker start sqlbolt-postgres`         | Start the existing container.                   |
| `docker stop sqlbolt-postgres`          | Stop the database container.                    |
| `docker restart sqlbolt-postgres`       | Restart the container.                          |
| `docker logs sqlbolt-postgres`          | View PostgreSQL container logs.                 |
| `docker exec -it sqlbolt-postgres bash` | Open a shell inside the container.              |
| `docker volume ls`                      | List Docker volumes.                            |

### Starting the database on subsequent sessions

You do not need to execute `docker run` again.

Simply run:

```bash
docker start sqlbolt-postgres
```

The existing container will start using the same persistent database volume.

### Important: Database State

Some SQLBolt exercises modify the database itself.

For example:

- `INSERT` adds records.
- `UPDATE` modifies existing records.
- `DELETE` removes records.
- `ALTER TABLE` changes table structures.
- `DROP TABLE` removes tables.

Consequently, completing later lessons can affect the environment required by earlier lessons.

If you want to rerun a lesson, make sure its required initial data and schema are still available. A fresh database initialization or a dedicated reset script may be necessary.

**Never run `DROP VOLUME` or delete your database volume unless you intentionally want to erase the stored database.**

---

## PostgreSQL vs. Standard SQL

SQLBolt teaches common SQL concepts that are supported by several relational database systems.

However, SQL dialects are not identical.

PostgreSQL has its own syntax, data types, functions, and database-specific features.

Examples:

| Concept              | SQLBolt-style SQL                     | PostgreSQL                                          |   |    |
| -------------------- | ------------------------------------- | --------------------------------------------------- | - | -- |
| Auto-incrementing ID | `INTEGER PRIMARY KEY` in some engines | `SERIAL PRIMARY KEY` or `GENERATED ... AS IDENTITY` |   |    |
| Limiting results     | `LIMIT 5`                             | `LIMIT 5`                                           |   |    |
| String concatenation | Varies by engine                      | \`                                                  |   | \` |
| Current timestamp    | Varies by engine                      | `CURRENT_TIMESTAMP`                                 |   |    |
| Modulo               | `%`                                   | `%` or `MOD()`                                      |   |    |

The objective is to understand the underlying SQL concept while learning how PostgreSQL implements it.

When a query behaves differently between environments, document the difference in the lesson's Markdown file.

---

## Troubleshooting

### Connection refused

**Possible cause:** The PostgreSQL container is not running.

Check:

```bash
docker ps
```

Start it if necessary:

```bash
docker start sqlbolt-postgres
```

### Password authentication failed

**Possible cause:** The password supplied does not match the password configured when the container's data volume was initially initialized.

Check your credentials. Remember that changing `POSTGRES_PASSWORD` on an already initialized container does not automatically change the existing database user's password.

### Port 5432 is already allocated

**Possible cause:** Another PostgreSQL instance is already using port 5432.

Check which process is using the port, or map PostgreSQL to another host port:

```bash
-p 5433:5432
```

If you do this, update your `psql` commands to use:

```bash
-p 5433
```

### Relation does not exist

**Possible cause:** The required table has not been created in the database you are connected to.

Check the active database:

```sql
SELECT current_database();
```

List the tables:

```sql
\dt
```

Make sure the database initialization script has created the necessary schema.

---

## References

- [SQLBolt Interactive SQL Tutorial](https://sqlbolt.com/)
- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL psql Documentation](https://www.postgresql.org/docs/current/app-psql.html)
- [Docker Official Documentation](https://docs.docker.com/)
- [PostgreSQL Docker Official Image](https://hub.docker.com/_/postgres)