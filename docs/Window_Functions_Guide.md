# 📊 SQL Window Functions Guide

## Overview

Window Functions are advanced SQL functions that perform calculations across a set of rows related to the current row without collapsing the result set.

Unlike aggregate functions, window functions:

✅ Keep individual rows

✅ Perform calculations across related rows

✅ Support ranking and analytics

✅ Enable advanced reporting

Window functions are heavily used in:

* Data Analytics
* Business Intelligence
* Data Engineering
* Financial Reporting
* Product Analytics
* SQL Interviews

---

# 🎯 Why Window Functions?

Consider the employee table:

| Employee | Salary |
| -------- | -----: |
| Rutvik   |  90000 |
| Kavya    |  85000 |
| Arjun    |  85000 |
| Sneha    |  70000 |

Suppose we need:

* Employee rankings
* Running totals
* Department-wise rankings
* Previous salary comparison
* Next transaction value

Traditional SQL becomes complex.

Window functions solve these problems efficiently.

---

# 📚 Window Function Syntax

General Syntax:

```sql
FUNCTION_NAME()
OVER (
    PARTITION BY column
    ORDER BY column
)
```

---

## Components

### Function

Examples:

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
LEAD()
LAG()
SUM()
AVG()
COUNT()
```

---

### OVER()

Defines the window.

Example:

```sql
ROW_NUMBER()
OVER()
```

---

### PARTITION BY

Creates groups.

Similar to GROUP BY but retains rows.

---

### ORDER BY

Determines processing order.

---

# 🔹 ROW_NUMBER()

## Purpose

Assigns a unique sequential number to each row.

---

## Example Table

| Employee | Salary |
| -------- | -----: |
| Rutvik   |  90000 |
| Kavya    |  85000 |
| Arjun    |  85000 |
| Sneha    |  70000 |

---

## Query

```sql
SELECT
employee_name,
salary,

ROW_NUMBER()
OVER(
ORDER BY salary DESC
) AS row_num

FROM employees;
```

---

## Output

| Employee | Salary | Row_Number |
| -------- | -----: | ---------: |
| Rutvik   |  90000 |          1 |
| Kavya    |  85000 |          2 |
| Arjun    |  85000 |          3 |
| Sneha    |  70000 |          4 |

---

## Use Cases

* Pagination
* Unique ranking
* Top-N queries

---

# 🔹 RANK()

## Purpose

Assigns rank with gaps.

---

## Query

```sql
SELECT
employee_name,
salary,

RANK()
OVER(
ORDER BY salary DESC
) AS employee_rank

FROM employees;
```

---

## Output

| Employee | Salary | Rank |
| -------- | -----: | ---: |
| Rutvik   |  90000 |    1 |
| Kavya    |  85000 |    2 |
| Arjun    |  85000 |    2 |
| Sneha    |  70000 |    4 |

Notice:

```text
1
2
2
4
```

Rank 3 is skipped.

---

## Use Cases

* Competition rankings
* Sales leaderboards
* Revenue rankings

---

# 🔹 DENSE_RANK()

## Purpose

Assigns rank without gaps.

---

## Query

```sql
SELECT
employee_name,
salary,

DENSE_RANK()
OVER(
ORDER BY salary DESC
)

FROM employees;
```

---

## Output

| Employee | Salary | Dense_Rank |
| -------- | -----: | ---------: |
| Rutvik   |  90000 |          1 |
| Kavya    |  85000 |          2 |
| Arjun    |  85000 |          2 |
| Sneha    |  70000 |          3 |

---

## Difference

### RANK()

```text
1
2
2
4
```

### DENSE_RANK()

```text
1
2
2
3
```

---

# 🔹 NTILE()

## Purpose

Divides rows into groups.

---

## Query

```sql
SELECT
employee_name,
salary,

NTILE(4)
OVER(
ORDER BY salary DESC
)

FROM employees;
```

---

## Example

Create quartiles.

Output:

```text
Group 1
Group 2
Group 3
Group 4
```

---

## Use Cases

* Customer segmentation
* Revenue buckets
* Performance categories

---

# 🔹 LEAD()

## Purpose

Access next row value.

---

## Example

| Month | Revenue |
| ----- | ------: |
| Jan   |    1000 |
| Feb   |    1500 |
| Mar   |    1800 |

---

## Query

```sql
SELECT

month,

revenue,

LEAD(revenue)
OVER(
ORDER BY month
)

AS next_month_revenue

FROM sales;
```

---

## Output

| Month | Revenue | Next Revenue |
| ----- | ------: | -----------: |
| Jan   |    1000 |         1500 |
| Feb   |    1500 |         1800 |
| Mar   |    1800 |         NULL |

---

## Use Cases

* Trend analysis
* Forecasting
* Growth calculations

---

# 🔹 LAG()

## Purpose

Access previous row value.

---

## Query

```sql
SELECT

month,

revenue,

LAG(revenue)
OVER(
ORDER BY month
)

AS previous_revenue

FROM sales;
```

---

## Output

| Month | Revenue | Previous |
| ----- | ------: | -------: |
| Jan   |    1000 |     NULL |
| Feb   |    1500 |     1000 |
| Mar   |    1800 |     1500 |

---

## Use Cases

* Growth calculations
* Historical comparisons
* Trend analysis

---

# 🔹 FIRST_VALUE()

## Purpose

Returns first value in window.

---

## Query

```sql
SELECT

employee_name,

salary,

FIRST_VALUE(salary)
OVER(
ORDER BY salary DESC
)

AS highest_salary

FROM employees;
```

---

## Output

Every row shows highest salary.

---

# 🔹 LAST_VALUE()

## Purpose

Returns last value in window.

---

## Query

```sql
SELECT

employee_name,

salary,

LAST_VALUE(salary)
OVER(
ORDER BY salary
ROWS BETWEEN
UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING
)

FROM employees;
```

---

# 🔹 SUM() OVER()

## Running Total

---

## Example

| Day | Sales |
| --- | ----: |
| 1   |   100 |
| 2   |   200 |
| 3   |   150 |

---

## Query

```sql
SELECT

day,

sales,

SUM(sales)
OVER(
ORDER BY day
)

AS running_total

FROM sales;
```

---

## Output

| Day | Sales | Running Total |
| --- | ----: | ------------: |
| 1   |   100 |           100 |
| 2   |   200 |           300 |
| 3   |   150 |           450 |

---

# 🔹 AVG() OVER()

## Moving Average

---

## Query

```sql
SELECT

month,

sales,

AVG(sales)
OVER(
ORDER BY month
ROWS BETWEEN
2 PRECEDING
AND CURRENT ROW
)

AS moving_average

FROM sales;
```

---

## Use Cases

* Revenue trends
* Forecasting
* Stock analysis

---

# 🔹 COUNT() OVER()

## Row Counts Without Grouping

---

## Query

```sql
SELECT

employee_name,

COUNT(*)
OVER()

AS total_employees

FROM employees;
```

---

## Output

Each row contains:

```text
Total Employees = 100
```

---

# 🔹 PARTITION BY

## Purpose

Creates separate windows.

---

## Example

Employee Table

| Employee | Department | Salary |
| -------- | ---------- | -----: |
| Rutvik   | IT         |  90000 |
| Kavya    | IT         |  85000 |
| Sneha    | HR         |  70000 |

---

## Query

```sql
SELECT

employee_name,

department,

salary,

RANK()
OVER(
PARTITION BY department
ORDER BY salary DESC
)

AS dept_rank

FROM employees;
```

---

## Output

IT Rankings:

```text
Rutvik → 1
Kavya → 2
```

HR Rankings:

```text
Sneha → 1
```

---

# 🔹 Window Frame Clauses

## Syntax

```sql
ROWS BETWEEN
start
AND
end
```

---

## Common Frames

### Current Row

```sql
CURRENT ROW
```

---

### Previous Rows

```sql
2 PRECEDING
```

---

### Following Rows

```sql
2 FOLLOWING
```

---

### Entire Window

```sql
UNBOUNDED PRECEDING
UNBOUNDED FOLLOWING
```

---

# 📊 Real-World Examples

## Top 5 Highest Paid Employees

```sql
SELECT *

FROM
(
SELECT

employee_name,

salary,

ROW_NUMBER()
OVER(
ORDER BY salary DESC
) rn

FROM employees
) t

WHERE rn <= 5;
```

---

## Department Wise Salary Ranking

```sql
SELECT

employee_name,

department,

salary,

RANK()
OVER(
PARTITION BY department
ORDER BY salary DESC
)

FROM employees;
```

---

## Running Revenue

```sql
SELECT

order_date,

revenue,

SUM(revenue)
OVER(
ORDER BY order_date
)

FROM sales;
```

---

## Month-over-Month Growth

```sql
SELECT

month,

revenue,

revenue -
LAG(revenue)
OVER(
ORDER BY month
)

AS growth

FROM sales;
```

---

# 📊 Interview Questions

## What is a Window Function?

A function that performs calculations across a set of rows while preserving individual rows.

---

## Difference Between GROUP BY and Window Functions?

### GROUP BY

Returns one row per group.

### Window Function

Retains all rows.

---

## Difference Between RANK and DENSE_RANK?

### RANK

```text
1
2
2
4
```

### DENSE_RANK

```text
1
2
2
3
```

---

## Difference Between LEAD and LAG?

### LEAD

Next row.

### LAG

Previous row.

---

## What Does PARTITION BY Do?

Creates separate windows for calculations.

---

# 📊 Common Analytics Patterns

### Employee Ranking

```sql
RANK()
```

### Customer Segmentation

```sql
NTILE()
```

### Running Revenue

```sql
SUM() OVER()
```

### Moving Average

```sql
AVG() OVER()
```

### Growth Analysis

```sql
LAG()
```

### Forecast Analysis

```sql
LEAD()
```

---

# 🏆 Most Important Window Functions

| Function       | Purpose              |
| -------------- | -------------------- |
| ROW_NUMBER()   | Unique Ranking       |
| RANK()         | Ranking with Gaps    |
| DENSE_RANK()   | Ranking without Gaps |
| NTILE()        | Bucketing            |
| LEAD()         | Next Row             |
| LAG()          | Previous Row         |
| FIRST_VALUE()  | First Value          |
| LAST_VALUE()   | Last Value           |
| SUM() OVER()   | Running Total        |
| AVG() OVER()   | Moving Average       |
| COUNT() OVER() | Window Count         |

---

# 🚀 Window Function Mastery Checklist

## Ranking

* [ ] ROW_NUMBER()
* [ ] RANK()
* [ ] DENSE_RANK()
* [ ] NTILE()

## Navigation

* [ ] LEAD()
* [ ] LAG()
* [ ] FIRST_VALUE()
* [ ] LAST_VALUE()

## Analytics

* [ ] SUM() OVER()
* [ ] AVG() OVER()
* [ ] COUNT() OVER()

## Partitioning

* [ ] PARTITION BY

## Frames

* [ ] ROWS BETWEEN

---

# 🎯 Window Functions Learning Path

```text
Basic SQL
      ↓
GROUP BY
      ↓
Subqueries
      ↓
CTEs
      ↓
Window Functions
      ↓
Analytics
      ↓
Business Intelligence
      ↓
Data Engineering
      ↓
SQL Mastery
```

Window Functions are among the most powerful SQL features and are heavily used in modern analytics, reporting, data engineering, and advanced SQL interviews. Mastering them will significantly improve your problem-solving ability and prepare you for real-world data challenges.
