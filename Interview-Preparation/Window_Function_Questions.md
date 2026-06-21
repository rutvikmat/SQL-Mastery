# Window Function Interview Questions

## SQL-Mastery-Portfolio

---

# Introduction

Window Functions are among the most frequently asked SQL topics in:

* Data Analyst Interviews
* Data Engineer Interviews
* Analytics Engineer Interviews
* Backend Developer Interviews
* FAANG SQL Interviews

Companies like:

* Amazon
* Google
* Microsoft
* Meta
* Netflix
* Uber
* Airbnb

heavily use Window Functions for analytics and reporting.

---

# Table of Contents

1. Window Function Fundamentals
2. Ranking Functions
3. Aggregate Window Functions
4. LEAD & LAG
5. FIRST_VALUE & LAST_VALUE
6. NTILE
7. Advanced Window Functions
8. Scenario-Based Questions
9. FAANG Interview Questions
10. Interview Checklist

---

# WINDOW FUNCTION FUNDAMENTALS

---

## Q1. What is a Window Function?

### Answer

A Window Function performs calculations across a set of rows related to the current row without collapsing the result set.

Unlike GROUP BY:

* GROUP BY returns one row per group.
* Window Functions return all rows.

Example:

```sql
SELECT
employee_id,
salary,
AVG(salary) OVER()
FROM employees;
```

---

## Q2. Syntax of Window Function

```sql
FUNCTION_NAME()

OVER
(
PARTITION BY column_name
ORDER BY column_name
)
```

Components:

### OVER()

Defines the window.

### PARTITION BY

Divides rows into groups.

### ORDER BY

Defines row order.

---

## Q3. Difference Between GROUP BY and Window Functions

| GROUP BY             | Window Function       |
| -------------------- | --------------------- |
| Collapses rows       | Keeps rows            |
| One result per group | Result per row        |
| Aggregate only       | Aggregate + Analytics |

Example:

GROUP BY

```sql
SELECT department_id,
AVG(salary)
FROM employees
GROUP BY department_id;
```

Window Function

```sql
SELECT
employee_id,
department_id,
salary,
AVG(salary)
OVER(PARTITION BY department_id)
FROM employees;
```

---

# RANKING FUNCTIONS

---

## Q4. What is ROW_NUMBER()?

Assigns unique numbers.

```sql
SELECT
employee_id,
salary,

ROW_NUMBER()
OVER(
ORDER BY salary DESC
)
AS row_num

FROM employees;
```

Example:

| Salary | ROW_NUMBER |
| ------ | ---------- |
| 100000 | 1          |
| 100000 | 2          |
| 90000  | 3          |

---

## Q5. What is RANK()?

Assigns ranking with gaps.

```sql
SELECT
employee_id,
salary,

RANK()
OVER(
ORDER BY salary DESC
)
AS rank_no

FROM employees;
```

Example:

| Salary | Rank |
| ------ | ---- |
| 100000 | 1    |
| 100000 | 1    |
| 90000  | 3    |

---

## Q6. What is DENSE_RANK()?

Assigns ranking without gaps.

```sql
SELECT
employee_id,
salary,

DENSE_RANK()
OVER(
ORDER BY salary DESC
)
AS dense_rank

FROM employees;
```

Example:

| Salary | Dense Rank |
| ------ | ---------- |
| 100000 | 1          |
| 100000 | 1          |
| 90000  | 2          |

---

## Q7. Difference Between ROW_NUMBER, RANK and DENSE_RANK

| Function   | Duplicate Values | Gaps |
| ---------- | ---------------- | ---- |
| ROW_NUMBER | No               | No   |
| RANK       | Yes              | Yes  |
| DENSE_RANK | Yes              | No   |

---

## Q8. Find Top 3 Employees Per Department

```sql
WITH ranked_employees AS
(
SELECT *,
ROW_NUMBER()
OVER(
PARTITION BY department_id
ORDER BY salary DESC
) rn
FROM employees
)

SELECT *
FROM ranked_employees
WHERE rn <= 3;
```

Interview Favorite ⭐

---

# AGGREGATE WINDOW FUNCTIONS

---

## Q9. Running Total

```sql
SELECT

employee_id,
salary,

SUM(salary)
OVER(
ORDER BY employee_id
)
AS running_total

FROM employees;
```

---

## Q10. Running Average

```sql
SELECT

employee_id,
salary,

AVG(salary)
OVER(
ORDER BY employee_id
)
AS running_average

FROM employees;
```

---

## Q11. Department-wise Average Salary

```sql
SELECT

employee_id,
department_id,
salary,

AVG(salary)
OVER(
PARTITION BY department_id
)
AS department_average

FROM employees;
```

---

## Q12. Department-wise Maximum Salary

```sql
SELECT

employee_id,
department_id,
salary,

MAX(salary)
OVER(
PARTITION BY department_id
)
AS department_max

FROM employees;
```

---

## Q13. Department-wise Minimum Salary

```sql
SELECT

employee_id,
department_id,
salary,

MIN(salary)
OVER(
PARTITION BY department_id
)
AS department_min

FROM employees;
```

---

# LEAD & LAG

---

## Q14. What is LAG()?

Returns previous row value.

```sql
SELECT

employee_id,
salary,

LAG(salary)
OVER(
ORDER BY employee_id
)
AS previous_salary

FROM employees;
```

---

## Q15. What is LEAD()?

Returns next row value.

```sql
SELECT

employee_id,
salary,

LEAD(salary)
OVER(
ORDER BY employee_id
)
AS next_salary

FROM employees;
```

---

## Q16. Compare Current Salary with Previous Salary

```sql
SELECT

employee_id,
salary,

salary -
LAG(salary)
OVER(
ORDER BY employee_id
)
AS salary_difference

FROM employees;
```

---

## Q17. Month-over-Month Revenue Growth

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

FROM monthly_sales;
```

Interview Favorite ⭐

---

## Q18. Year-over-Year Growth

```sql
SELECT

year,
revenue,

revenue -
LAG(revenue)
OVER(
ORDER BY year
)
AS yoy_growth

FROM yearly_sales;
```

---

# FIRST_VALUE & LAST_VALUE

---

## Q19. FIRST_VALUE()

Returns first value in partition.

```sql
SELECT

employee_id,
department_id,
salary,

FIRST_VALUE(salary)
OVER(
PARTITION BY department_id
ORDER BY salary DESC
)
AS highest_salary

FROM employees;
```

---

## Q20. LAST_VALUE()

Returns last value in partition.

```sql
SELECT

employee_id,
department_id,
salary,

LAST_VALUE(salary)
OVER(
PARTITION BY department_id
ORDER BY salary
ROWS BETWEEN
UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING
)
AS lowest_salary

FROM employees;
```

---

# NTILE

---

## Q21. What is NTILE()?

Divides rows into buckets.

```sql
SELECT

employee_id,
salary,

NTILE(4)
OVER(
ORDER BY salary DESC
)
AS quartile

FROM employees;
```

---

## Q22. Create Employee Salary Quartiles

```sql
SELECT

employee_id,
salary,

NTILE(4)
OVER(
ORDER BY salary DESC
)

FROM employees;
```

---

## Q23. Top 25 Percent Employees

```sql
WITH salary_groups AS
(
SELECT
*,

NTILE(4)
OVER(
ORDER BY salary DESC
)
AS quartile

FROM employees
)

SELECT *
FROM salary_groups
WHERE quartile = 1;
```

---

# ADVANCED WINDOW FUNCTIONS

---

## Q24. Moving Average

```sql
SELECT

employee_id,
salary,

AVG(salary)
OVER(
ORDER BY employee_id
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
)
AS moving_average

FROM employees;
```

---

## Q25. Moving Sum

```sql
SELECT

employee_id,
salary,

SUM(salary)
OVER(
ORDER BY employee_id
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
)
AS moving_sum

FROM employees;
```

---

## Q26. Cumulative Revenue

```sql
SELECT

sale_date,
revenue,

SUM(revenue)
OVER(
ORDER BY sale_date
)
AS cumulative_revenue

FROM sales;
```

---

## Q27. Percentage Contribution

```sql
SELECT

employee_id,
salary,

ROUND(
100.0 * salary
/
SUM(salary)
OVER(),
2
)
AS contribution_percentage

FROM employees;
```

---

## Q28. PERCENT_RANK()

```sql
SELECT

employee_id,
salary,

PERCENT_RANK()
OVER(
ORDER BY salary
)

FROM employees;
```

---

## Q29. CUME_DIST()

```sql
SELECT

employee_id,
salary,

CUME_DIST()
OVER(
ORDER BY salary
)

FROM employees;
```

---

# SCENARIO-BASED QUESTIONS

---

## Q30. Find Highest Paid Employee in Each Department

```sql
WITH ranked AS
(
SELECT *,
ROW_NUMBER()
OVER(
PARTITION BY department_id
ORDER BY salary DESC
) rn
FROM employees
)

SELECT *
FROM ranked
WHERE rn = 1;
```

---

## Q31. Find Lowest Paid Employee in Each Department

```sql
WITH ranked AS
(
SELECT *,
ROW_NUMBER()
OVER(
PARTITION BY department_id
ORDER BY salary ASC
) rn
FROM employees
)

SELECT *
FROM ranked
WHERE rn = 1;
```

---

## Q32. Find Top 5 Customers by Revenue

```sql
SELECT

customer_id,

SUM(total_amount)
AS revenue,

DENSE_RANK()
OVER(
ORDER BY SUM(total_amount) DESC
)

FROM orders

GROUP BY customer_id;
```

---

## Q33. Build Revenue Leaderboard

```sql
SELECT

employee_id,

SUM(revenue)
AS total_sales,

RANK()
OVER(
ORDER BY SUM(revenue) DESC
)

FROM sales

GROUP BY employee_id;
```

---

## Q34. Build Employee Leaderboard

```sql
SELECT

employee_id,
salary,

DENSE_RANK()
OVER(
ORDER BY salary DESC
)
AS rank

FROM employees;
```

---

# FAANG INTERVIEW QUESTIONS

---

## Amazon

1. Top N Per Group
2. Running Totals
3. Ranking Problems
4. Revenue Growth

---

## Google

1. Window Frame Clauses
2. Moving Averages
3. Cumulative Analytics

---

## Microsoft

1. LEAD & LAG
2. Employee Ranking
3. Salary Analytics

---

## Meta

1. Ranking Problems
2. User Analytics
3. Growth Analysis

---

## Netflix

1. Retention Analysis
2. Watch-Time Analytics
3. Revenue Trends

---

# Common Interview Mistakes

❌ Using GROUP BY instead of Window Functions

❌ Forgetting PARTITION BY

❌ Forgetting ORDER BY

❌ Incorrect LAST_VALUE frame

❌ Confusing RANK and DENSE_RANK

---

# Window Function Interview Checklist

## Fundamentals

* [ ] OVER()
* [ ] PARTITION BY
* [ ] ORDER BY

---

## Ranking

* [ ] ROW_NUMBER()
* [ ] RANK()
* [ ] DENSE_RANK()

---

## Analytics

* [ ] Running Total
* [ ] Running Average
* [ ] Moving Average

---

## Comparison

* [ ] LEAD()
* [ ] LAG()

---

## Advanced

* [ ] NTILE()
* [ ] FIRST_VALUE()
* [ ] LAST_VALUE()
* [ ] PERCENT_RANK()
* [ ] CUME_DIST()

---

# Window Function Mastery Formula

```text
OVER()
      +
PARTITION BY
      +
ORDER BY
      +
Ranking Functions
      +
LEAD/LAG
      +
Moving Analytics
      +
Business Scenarios
      =
Window Function Mastery
```

---

# Summary

## Topics Covered

* Window Function Fundamentals
* Ranking Functions
* Running Totals
* LEAD & LAG
* NTILE
* FIRST_VALUE
* LAST_VALUE
* PERCENT_RANK
* CUME_DIST
* Business Analytics

## Questions Covered

34+ Window Function Interview Questions

## Difficulty Levels

* Beginner
* Intermediate
* Advanced
* FAANG-Level

---

**Portfolio Status:** Window Functions Interview Ready 🚀
