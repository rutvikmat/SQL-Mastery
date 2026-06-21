-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 1 : ADVANCED JOINS (Q1 - Q20)
-- ==========================================================

-- Assumed Tables:
--
-- employees
-- (
--     employee_id,
--     full_name,
--     department_id,
--     manager_id,
--     salary,
--     city,
--     joining_date
-- )
--
-- departments
-- (
--     department_id,
--     department_name,
--     location
-- )
--
-- projects
-- (
--     project_id,
--     project_name,
--     budget,
--     start_date
-- )
--
-- employee_projects
-- (
--     employee_id,
--     project_id,
--     assigned_date
-- )

-- ==========================================================
-- Q1
-- Display employees with department details
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    d.department_name,
    d.location
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- ==========================================================
-- Q2
-- Display employees and manager names
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name AS employee_name,
    m.full_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- ==========================================================
-- Q3
-- Find employees earning more than their manager
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    e.salary,
    m.full_name AS manager_name,
    m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- ==========================================================
-- Q4
-- Find employees in the same department as their manager
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    d.department_name,
    m.full_name AS manager_name
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = m.department_id;

-- ==========================================================
-- Q5
-- Find departments without employees
-- ==========================================================

SELECT
    d.department_id,
    d.department_name
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- ==========================================================
-- Q6
-- Find employees without projects
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name
FROM employees e
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;

-- ==========================================================
-- Q7
-- Find projects without employees
-- ==========================================================

SELECT
    p.project_id,
    p.project_name
FROM projects p
LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;

-- ==========================================================
-- Q8
-- Show employee-project assignments
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    p.project_name,
    ep.assigned_date
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
JOIN projects p
ON ep.project_id = p.project_id
ORDER BY e.full_name;

-- ==========================================================
-- Q9
-- Show project count per employee
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    COUNT(ep.project_id) AS project_count
FROM employees e
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY
    e.employee_id,
    e.full_name
ORDER BY project_count DESC;

-- ==========================================================
-- Q10
-- Show employee count per project
-- ==========================================================

SELECT
    p.project_id,
    p.project_name,
    COUNT(ep.employee_id) AS employee_count
FROM projects p
LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id
GROUP BY
    p.project_id,
    p.project_name
ORDER BY employee_count DESC;

-- ==========================================================
-- Q11
-- Find departments managing the most projects
-- ==========================================================

SELECT
    d.department_name,
    COUNT(DISTINCT ep.project_id) AS total_projects
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY d.department_name
ORDER BY total_projects DESC;

-- ==========================================================
-- Q12
-- Find employees working on multiple projects
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    COUNT(ep.project_id) AS total_projects
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY
    e.employee_id,
    e.full_name
HAVING COUNT(ep.project_id) > 1
ORDER BY total_projects DESC;

-- ==========================================================
-- Q13
-- Find projects involving multiple departments
-- ==========================================================

SELECT
    p.project_id,
    p.project_name,
    COUNT(DISTINCT e.department_id) AS department_count
FROM projects p
JOIN employee_projects ep
ON p.project_id = ep.project_id
JOIN employees e
ON ep.employee_id = e.employee_id
GROUP BY
    p.project_id,
    p.project_name
HAVING COUNT(DISTINCT e.department_id) > 1
ORDER BY department_count DESC;

-- ==========================================================
-- Q14
-- Generate complete employee-department-project report
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    d.department_name,
    p.project_name,
    ep.assigned_date
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
LEFT JOIN projects p
ON ep.project_id = p.project_id
ORDER BY
    d.department_name,
    e.full_name;

-- ==========================================================
-- Q15
-- Find employees assigned to every project
-- Relational Division Problem
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY
    e.employee_id,
    e.full_name
HAVING COUNT(DISTINCT ep.project_id) =
(
    SELECT COUNT(*)
    FROM projects
);

-- ==========================================================
-- Q16
-- Find employees assigned to no project
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name
FROM employees e
WHERE NOT EXISTS
(
    SELECT 1
    FROM employee_projects ep
    WHERE ep.employee_id = e.employee_id
);

-- ==========================================================
-- Q17
-- Find managers supervising more than 5 employees
-- ==========================================================

SELECT
    m.employee_id,
    m.full_name,
    COUNT(e.employee_id) AS team_size
FROM employees m
JOIN employees e
ON m.employee_id = e.manager_id
GROUP BY
    m.employee_id,
    m.full_name
HAVING COUNT(e.employee_id) > 5
ORDER BY team_size DESC;

-- ==========================================================
-- Q18
-- Find department heads
-- Assumption:
-- Department Head = Employee without manager
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,
    d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.manager_id IS NULL;

-- ==========================================================
-- Q19
-- Find departments with highest salary expense
-- ==========================================================

SELECT
    d.department_name,
    SUM(e.salary) AS total_salary_expense
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY total_salary_expense DESC;

-- ==========================================================
-- Q20
-- Generate workforce hierarchy report
-- Multi-Level Reporting Structure
-- ==========================================================

SELECT
    emp.employee_id,
    emp.full_name AS employee_name,

    mgr.employee_id AS manager_id,
    mgr.full_name AS manager_name,

    dir.employee_id AS director_id,
    dir.full_name AS director_name

FROM employees emp

LEFT JOIN employees mgr
ON emp.manager_id = mgr.employee_id

LEFT JOIN employees dir
ON mgr.manager_id = dir.employee_id

ORDER BY employee_name;

-- ==========================================================
-- END OF SECTION 1
-- ADVANCED JOINS COMPLETED
-- ==========================================================

-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 2 : ADVANCED SUBQUERIES (Q21 - Q40)
-- ==========================================================

-- ==========================================================
-- Q21
-- Find second highest salary
-- ==========================================================

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
);

-- ==========================================================
-- Q22
-- Find third highest salary
-- ==========================================================

SELECT MAX(salary) AS third_highest_salary
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
    WHERE salary <
    (
        SELECT MAX(salary)
        FROM employees
    )
);

-- ==========================================================
-- Q23
-- Find top 5 salaries
-- ==========================================================

SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- ==========================================================
-- Q24
-- Find employees above company average salary
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;

-- ==========================================================
-- Q25
-- Find employees below department average salary
-- Correlated Subquery
-- ==========================================================

SELECT
    e1.employee_id,
    e1.full_name,
    e1.salary,
    e1.department_id
FROM employees e1
WHERE salary <
(
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ==========================================================
-- Q26
-- Find departments above company average salary
-- ==========================================================

SELECT
    department_id,
    AVG(salary) AS department_avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) >
(
    SELECT AVG(salary)
    FROM employees
);

-- ==========================================================
-- Q27
-- Find projects above average budget
-- ==========================================================

SELECT
    project_id,
    project_name,
    budget
FROM projects
WHERE budget >
(
    SELECT AVG(budget)
    FROM projects
);

-- ==========================================================
-- Q28
-- Find employees in largest department
-- ==========================================================

SELECT *
FROM employees
WHERE department_id =
(
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- ==========================================================
-- Q29
-- Find employees in smallest department
-- ==========================================================

SELECT *
FROM employees
WHERE department_id =
(
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY COUNT(*) ASC
    LIMIT 1
);

-- ==========================================================
-- Q30
-- Find cities with above average employee count
-- ==========================================================

SELECT
    city,
    COUNT(*) AS employee_count
FROM employees
GROUP BY city
HAVING COUNT(*) >
(
    SELECT AVG(city_count)
    FROM
    (
        SELECT COUNT(*) AS city_count
        FROM employees
        GROUP BY city
    ) city_stats
);

-- ==========================================================
-- Q31
-- Find departments with highest employee count
-- ==========================================================

SELECT
    department_id,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department_id
HAVING COUNT(*) =
(
    SELECT MAX(emp_count)
    FROM
    (
        SELECT COUNT(*) AS emp_count
        FROM employees
        GROUP BY department_id
    ) dept_stats
);

-- ==========================================================
-- Q32
-- Find highest paid employee in each department
-- ==========================================================

SELECT *
FROM employees e1
WHERE salary =
(
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ==========================================================
-- Q33
-- Find lowest paid employee in each department
-- ==========================================================

SELECT *
FROM employees e1
WHERE salary =
(
    SELECT MIN(e2.salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ==========================================================
-- Q34
-- Find employees hired before department average joining date
-- ==========================================================

SELECT *
FROM employees e1
WHERE joining_date <
(
    SELECT AVG(joining_date)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ==========================================================
-- Q35
-- Find employees hired after department average joining date
-- ==========================================================

SELECT *
FROM employees e1
WHERE joining_date >
(
    SELECT AVG(joining_date)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- ==========================================================
-- Q36
-- Find employees sharing same salary
-- ==========================================================

SELECT *
FROM employees
WHERE salary IN
(
    SELECT salary
    FROM employees
    GROUP BY salary
    HAVING COUNT(*) > 1
)
ORDER BY salary DESC;

-- ==========================================================
-- Q37
-- Find duplicate employee names
-- ==========================================================

SELECT *
FROM employees
WHERE full_name IN
(
    SELECT full_name
    FROM employees
    GROUP BY full_name
    HAVING COUNT(*) > 1
);

-- ==========================================================
-- Q38
-- Find duplicate email addresses
-- ==========================================================

SELECT *
FROM employees
WHERE email IN
(
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) > 1
);

-- ==========================================================
-- Q39
-- Find employees not earning maximum salary
-- ==========================================================

SELECT *
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
);

-- ==========================================================
-- Q40
-- Find employees earning more than all employees in HR
-- Using ALL Operator
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary
FROM employees
WHERE salary > ALL
(
    SELECT e.salary
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id
    WHERE d.department_name = 'HR'
);

-- ==========================================================
-- BONUS INTERVIEW QUERIES
-- ==========================================================

-- Find employees whose salary is greater than manager salary

SELECT
    e.employee_id,
    e.full_name,
    e.salary
FROM employees e
WHERE salary >
(
    SELECT m.salary
    FROM employees m
    WHERE m.employee_id = e.manager_id
);

-- Find departments with no employees

SELECT *
FROM departments d
WHERE NOT EXISTS
(
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- Find projects with no assignments

SELECT *
FROM projects p
WHERE NOT EXISTS
(
    SELECT 1
    FROM employee_projects ep
    WHERE ep.project_id = p.project_id
);

-- ==========================================================
-- END OF SECTION 2
-- ADVANCED SUBQUERIES COMPLETED
-- ==========================================================
-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 3 : CTEs & RECURSIVE CTEs (Q41 - Q60)
-- ==========================================================

-- ==========================================================
-- Q41
-- Create department salary summary using CTE
-- ==========================================================

WITH department_salary_summary AS
(
    SELECT
        department_id,
        COUNT(*) AS employee_count,
        AVG(salary) AS avg_salary,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
)

SELECT *
FROM department_salary_summary
ORDER BY total_salary DESC;

-- ==========================================================
-- Q42
-- Create employee ranking report using CTE
-- ==========================================================

WITH employee_rankings AS
(
    SELECT
        employee_id,
        full_name,
        salary,
        RANK() OVER(ORDER BY salary DESC) AS salary_rank
    FROM employees
)

SELECT *
FROM employee_rankings
ORDER BY salary_rank;

-- ==========================================================
-- Q43
-- Create project budget report using CTE
-- ==========================================================

WITH project_budget_report AS
(
    SELECT
        project_id,
        project_name,
        budget
    FROM projects
)

SELECT *
FROM project_budget_report
ORDER BY budget DESC;

-- ==========================================================
-- Q44
-- Find top earning departments using CTE
-- ==========================================================

WITH dept_salary AS
(
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)

SELECT *
FROM dept_salary
ORDER BY avg_salary DESC
LIMIT 5;

-- ==========================================================
-- Q45
-- Find bottom earning departments using CTE
-- ==========================================================

WITH dept_salary AS
(
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)

SELECT *
FROM dept_salary
ORDER BY avg_salary ASC
LIMIT 5;

-- ==========================================================
-- Q46
-- Calculate company average salary using CTE
-- ==========================================================

WITH company_avg AS
(
    SELECT AVG(salary) AS avg_salary
    FROM employees
)

SELECT *
FROM company_avg;

-- ==========================================================
-- Q47
-- Generate employee analytics report
-- ==========================================================

WITH employee_analytics AS
(
    SELECT
        employee_id,
        full_name,
        salary,

        CASE
            WHEN salary >= 150000 THEN 'High'
            WHEN salary >= 80000 THEN 'Medium'
            ELSE 'Low'
        END AS salary_band
    FROM employees
)

SELECT *
FROM employee_analytics;

-- ==========================================================
-- Q48
-- Generate project analytics report
-- ==========================================================

WITH project_analytics AS
(
    SELECT
        p.project_id,
        p.project_name,
        COUNT(ep.employee_id) AS assigned_employees
    FROM projects p
    LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
    GROUP BY
        p.project_id,
        p.project_name
)

SELECT *
FROM project_analytics
ORDER BY assigned_employees DESC;

-- ==========================================================
-- Q49
-- Generate city analytics report
-- ==========================================================

WITH city_analytics AS
(
    SELECT
        city,
        COUNT(*) AS employee_count,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY city
)

SELECT *
FROM city_analytics
ORDER BY employee_count DESC;

-- ==========================================================
-- Q50
-- Generate workforce distribution report
-- ==========================================================

WITH workforce_distribution AS
(
    SELECT
        department_id,
        COUNT(*) AS workforce
    FROM employees
    GROUP BY department_id
)

SELECT *
FROM workforce_distribution
ORDER BY workforce DESC;

-- ==========================================================
-- RECURSIVE CTE SECTION
-- ==========================================================

-- ==========================================================
-- Q51
-- Create recursive number generator
-- Generate numbers from 1 to 20
-- ==========================================================

WITH RECURSIVE numbers AS
(
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 20
)

SELECT *
FROM numbers;

-- ==========================================================
-- Q52
-- Generate employee hierarchy using recursive CTE
-- ==========================================================

WITH RECURSIVE employee_hierarchy AS
(
    SELECT
        employee_id,
        full_name,
        manager_id,
        1 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.full_name,
        e.manager_id,
        eh.hierarchy_level + 1
    FROM employees e
    JOIN employee_hierarchy eh
    ON e.manager_id = eh.employee_id
)

SELECT *
FROM employee_hierarchy
ORDER BY hierarchy_level;

-- ==========================================================
-- Q53
-- Generate department hierarchy
-- ==========================================================

WITH RECURSIVE department_hierarchy AS
(
    SELECT
        department_id,
        department_name,
        1 AS level
    FROM departments

    UNION ALL

    SELECT
        dh.department_id,
        dh.department_name,
        level + 1
    FROM department_hierarchy dh
    WHERE level < 3
)

SELECT *
FROM department_hierarchy;

-- ==========================================================
-- Q54
-- Generate reporting chain
-- ==========================================================

WITH RECURSIVE reporting_chain AS
(
    SELECT
        employee_id,
        full_name,
        manager_id,
        full_name::TEXT AS reporting_path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.full_name,
        e.manager_id,
        rc.reporting_path || ' -> ' || e.full_name
    FROM employees e
    JOIN reporting_chain rc
    ON e.manager_id = rc.employee_id
)

SELECT *
FROM reporting_chain;

-- ==========================================================
-- Q55
-- Generate organizational structure
-- ==========================================================

WITH RECURSIVE organization_structure AS
(
    SELECT
        employee_id,
        full_name,
        manager_id,
        1 AS org_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.full_name,
        e.manager_id,
        os.org_level + 1
    FROM employees e
    JOIN organization_structure os
    ON e.manager_id = os.employee_id
)

SELECT *
FROM organization_structure
ORDER BY org_level;

-- ==========================================================
-- Q56
-- Find deepest management level
-- ==========================================================

WITH RECURSIVE hierarchy AS
(
    SELECT
        employee_id,
        manager_id,
        1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.manager_id,
        h.level + 1
    FROM employees e
    JOIN hierarchy h
    ON e.manager_id = h.employee_id
)

SELECT MAX(level) AS deepest_level
FROM hierarchy;

-- ==========================================================
-- Q57
-- Generate project dependency chain
-- ==========================================================

WITH RECURSIVE project_chain AS
(
    SELECT
        project_id,
        project_name,
        1 AS project_level
    FROM projects

    UNION ALL

    SELECT
        pc.project_id,
        pc.project_name,
        pc.project_level + 1
    FROM project_chain pc
    WHERE pc.project_level < 3
)

SELECT *
FROM project_chain;

-- ==========================================================
-- Q58
-- Calculate cumulative hierarchy depth
-- ==========================================================

WITH RECURSIVE hierarchy_depth AS
(
    SELECT
        employee_id,
        manager_id,
        1 AS depth
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.manager_id,
        hd.depth + 1
    FROM employees e
    JOIN hierarchy_depth hd
    ON e.manager_id = hd.employee_id
)

SELECT
    employee_id,
    depth
FROM hierarchy_depth
ORDER BY depth DESC;

-- ==========================================================
-- Q59
-- Generate recursive category structure
-- ==========================================================

WITH RECURSIVE categories AS
(
    SELECT
        1 AS category_id,
        'Root Category' AS category_name,
        1 AS level

    UNION ALL

    SELECT
        category_id + 1,
        'Sub Category',
        level + 1
    FROM categories
    WHERE level < 5
)

SELECT *
FROM categories;

-- ==========================================================
-- Q60
-- Generate recursive reporting dashboard
-- ==========================================================

WITH RECURSIVE reporting_dashboard AS
(
    SELECT
        employee_id,
        full_name,
        manager_id,
        1 AS reporting_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.full_name,
        e.manager_id,
        rd.reporting_level + 1
    FROM employees e
    JOIN reporting_dashboard rd
    ON e.manager_id = rd.employee_id
)

SELECT
    reporting_level,
    COUNT(*) AS employee_count
FROM reporting_dashboard
GROUP BY reporting_level
ORDER BY reporting_level;

-- ==========================================================
-- END OF SECTION 3
-- CTEs & RECURSIVE CTEs COMPLETED
-- ==========================================================
-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 4 : WINDOW FUNCTIONS (Q61 - Q90)
-- ==========================================================

-- ==========================================================
-- Q61
-- Assign ROW_NUMBER by salary
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;

-- ==========================================================
-- Q62
-- Assign RANK by salary
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,
    RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees;

-- ==========================================================
-- Q63
-- Assign DENSE_RANK by salary
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rank
FROM employees;

-- ==========================================================
-- Q64
-- Assign department-wise rank
-- ==========================================================

SELECT
    employee_id,
    full_name,
    department_id,
    salary,
    RANK() OVER(
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;

-- ==========================================================
-- Q65
-- Assign city-wise rank
-- ==========================================================

SELECT
    employee_id,
    full_name,
    city,
    salary,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY salary DESC
    ) AS city_rank
FROM employees;

-- ==========================================================
-- Q66
-- Find top employee in each department
-- ==========================================================

WITH ranked_employees AS
(
    SELECT *,
           ROW_NUMBER() OVER(
                PARTITION BY department_id
                ORDER BY salary DESC
           ) AS rn
    FROM employees
)

SELECT *
FROM ranked_employees
WHERE rn = 1;

-- ==========================================================
-- Q67
-- Find top 3 employees in each department
-- ==========================================================

WITH ranked_employees AS
(
    SELECT *,
           ROW_NUMBER() OVER(
                PARTITION BY department_id
                ORDER BY salary DESC
           ) AS rn
    FROM employees
)

SELECT *
FROM ranked_employees
WHERE rn <= 3;

-- ==========================================================
-- Q68
-- Find bottom employee in each department
-- ==========================================================

WITH ranked_employees AS
(
    SELECT *,
           ROW_NUMBER() OVER(
                PARTITION BY department_id
                ORDER BY salary ASC
           ) AS rn
    FROM employees
)

SELECT *
FROM ranked_employees
WHERE rn = 1;

-- ==========================================================
-- Q69
-- Calculate running salary total
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,

    SUM(salary) OVER(
        ORDER BY employee_id
    ) AS running_salary_total

FROM employees;

-- ==========================================================
-- Q70
-- Calculate running department salary total
-- ==========================================================

SELECT
    employee_id,
    department_id,
    salary,

    SUM(salary) OVER(
        PARTITION BY department_id
        ORDER BY employee_id
    ) AS department_running_total

FROM employees;

-- ==========================================================
-- Q71
-- Calculate cumulative employee count
-- ==========================================================

SELECT
    employee_id,
    joining_date,

    COUNT(*) OVER(
        ORDER BY joining_date
    ) AS cumulative_employee_count

FROM employees;

-- ==========================================================
-- Q72
-- Calculate moving average salary
-- ==========================================================

SELECT
    employee_id,
    salary,

    AVG(salary) OVER(
        ORDER BY employee_id
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS moving_avg_salary

FROM employees;

-- ==========================================================
-- Q73
-- Calculate moving average revenue
-- ==========================================================

SELECT
    sale_date,
    revenue,

    AVG(revenue) OVER(
        ORDER BY sale_date
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS moving_avg_revenue

FROM sales;

-- ==========================================================
-- Q74
-- Compare current salary with previous employee
-- ==========================================================

SELECT
    employee_id,
    salary,

    LAG(salary) OVER(
        ORDER BY employee_id
    ) AS previous_salary,

    salary -
    LAG(salary) OVER(
        ORDER BY employee_id
    ) AS salary_difference

FROM employees;

-- ==========================================================
-- Q75
-- Compare current revenue with previous month
-- ==========================================================

SELECT
    sale_date,
    revenue,

    LAG(revenue) OVER(
        ORDER BY sale_date
    ) AS previous_month_revenue,

    revenue -
    LAG(revenue) OVER(
        ORDER BY sale_date
    ) AS revenue_growth

FROM sales;

-- ==========================================================
-- Q76
-- Use LEAD to compare next salary
-- ==========================================================

SELECT
    employee_id,
    salary,

    LEAD(salary) OVER(
        ORDER BY employee_id
    ) AS next_salary

FROM employees;

-- ==========================================================
-- Q77
-- Use LAG to compare previous salary
-- ==========================================================

SELECT
    employee_id,
    salary,

    LAG(salary) OVER(
        ORDER BY employee_id
    ) AS previous_salary

FROM employees;

-- ==========================================================
-- Q78
-- Find salary difference between employees
-- ==========================================================

SELECT
    employee_id,
    salary,

    salary -
    LAG(salary) OVER(
        ORDER BY salary DESC
    ) AS salary_gap

FROM employees;

-- ==========================================================
-- Q79
-- Calculate percentage contribution by department
-- ==========================================================

SELECT
    department_id,

    SUM(salary) AS department_salary,

    ROUND(
        100.0 *
        SUM(salary)
        /
        SUM(SUM(salary)) OVER(),
        2
    ) AS contribution_percentage

FROM employees

GROUP BY department_id;

-- ==========================================================
-- Q80
-- Calculate percentage contribution by employee
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,

    ROUND(
        100.0 * salary
        /
        SUM(salary) OVER(),
        2
    ) AS salary_contribution

FROM employees;

-- ==========================================================
-- Q81
-- Create revenue quartiles using NTILE
-- ==========================================================

SELECT
    sale_id,
    revenue,

    NTILE(4) OVER(
        ORDER BY revenue DESC
    ) AS revenue_quartile

FROM sales;

-- ==========================================================
-- Q82
-- Create employee salary quartiles
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,

    NTILE(4) OVER(
        ORDER BY salary DESC
    ) AS salary_quartile

FROM employees;

-- ==========================================================
-- Q83
-- Find highest salary in department using FIRST_VALUE
-- ==========================================================

SELECT
    employee_id,
    department_id,
    salary,

    FIRST_VALUE(salary) OVER(
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS highest_department_salary

FROM employees;

-- ==========================================================
-- Q84
-- Find lowest salary in department using LAST_VALUE
-- ==========================================================

SELECT
    employee_id,
    department_id,
    salary,

    LAST_VALUE(salary) OVER(
        PARTITION BY department_id
        ORDER BY salary
        ROWS BETWEEN
        UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_department_salary

FROM employees;

-- ==========================================================
-- Q85
-- Generate salary trend report
-- ==========================================================

SELECT
    joining_date,
    salary,

    AVG(salary) OVER(
        ORDER BY joining_date
    ) AS salary_trend

FROM employees;

-- ==========================================================
-- Q86
-- Generate department ranking dashboard
-- ==========================================================

SELECT
    department_id,

    AVG(salary) AS avg_salary,

    RANK() OVER(
        ORDER BY AVG(salary) DESC
    ) AS department_rank

FROM employees

GROUP BY department_id;

-- ==========================================================
-- Q87
-- Generate employee leaderboard
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,

    DENSE_RANK() OVER(
        ORDER BY salary DESC
    ) AS leaderboard_rank

FROM employees;

-- ==========================================================
-- Q88
-- Generate monthly revenue leaderboard
-- ==========================================================

SELECT
    DATE_TRUNC('month', sale_date) AS month,

    SUM(revenue) AS monthly_revenue,

    RANK() OVER(
        ORDER BY SUM(revenue) DESC
    ) AS monthly_rank

FROM sales

GROUP BY DATE_TRUNC('month', sale_date);

-- ==========================================================
-- Q89
-- Generate performance ranking report
-- ==========================================================

SELECT
    employee_id,
    full_name,
    salary,

    PERCENT_RANK() OVER(
        ORDER BY salary
    ) AS performance_percentile

FROM employees;

-- ==========================================================
-- Q90
-- Create executive ranking dashboard
-- ==========================================================

WITH executive_dashboard AS
(
    SELECT
        employee_id,
        full_name,
        department_id,
        salary,

        DENSE_RANK() OVER(
            ORDER BY salary DESC
        ) AS company_rank,

        RANK() OVER(
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS department_rank

    FROM employees
)

SELECT *
FROM executive_dashboard
ORDER BY company_rank;

-- ==========================================================
-- END OF SECTION 4
-- WINDOW FUNCTIONS COMPLETED
-- ==========================================================
-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 5 : ADVANCED ANALYTICS (Q91 - Q120)
-- ==========================================================

-- Assumed Table:
--
-- sales
-- (
--     sale_id,
--     employee_id,
--     sale_date,
--     revenue
-- )

-- ==========================================================
-- Q91
-- Calculate monthly revenue
-- ==========================================================

SELECT
    DATE_TRUNC('month', sale_date) AS month,
    SUM(revenue) AS monthly_revenue
FROM sales
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY month;

-- ==========================================================
-- Q92
-- Calculate quarterly revenue
-- ==========================================================

SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(QUARTER FROM sale_date) AS quarter,
    SUM(revenue) AS quarterly_revenue
FROM sales
GROUP BY year, quarter
ORDER BY year, quarter;

-- ==========================================================
-- Q93
-- Calculate yearly revenue
-- ==========================================================

SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    SUM(revenue) AS yearly_revenue
FROM sales
GROUP BY year
ORDER BY year;

-- ==========================================================
-- Q94
-- Calculate revenue growth rate
-- ==========================================================

WITH monthly_revenue AS
(
    SELECT
        DATE_TRUNC('month', sale_date) AS month,
        SUM(revenue) AS revenue
    FROM sales
    GROUP BY DATE_TRUNC('month', sale_date)
)

SELECT
    month,
    revenue,

    LAG(revenue) OVER(ORDER BY month) AS previous_revenue,

    ROUND(
        (
            revenue -
            LAG(revenue) OVER(ORDER BY month)
        ) * 100.0
        /
        NULLIF(
            LAG(revenue) OVER(ORDER BY month),
            0
        ),
        2
    ) AS growth_percentage

FROM monthly_revenue;

-- ==========================================================
-- Q95
-- Calculate employee growth rate
-- ==========================================================

WITH yearly_hires AS
(
    SELECT
        EXTRACT(YEAR FROM joining_date) AS hire_year,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY hire_year
)

SELECT
    hire_year,
    employee_count,

    ROUND(
        (
            employee_count -
            LAG(employee_count)
            OVER(ORDER BY hire_year)
        ) * 100.0
        /
        NULLIF(
            LAG(employee_count)
            OVER(ORDER BY hire_year),
            0
        ),
        2
    ) AS growth_rate

FROM yearly_hires;

-- ==========================================================
-- Q96
-- Calculate department growth
-- ==========================================================

SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- ==========================================================
-- Q97
-- Calculate project budget utilization
-- ==========================================================

SELECT
    p.project_id,
    p.project_name,
    p.budget,

    COUNT(ep.employee_id) AS assigned_employees,

    ROUND(
        COUNT(ep.employee_id) * 100.0 /
        NULLIF(p.budget,0),
        2
    ) AS utilization_metric

FROM projects p

LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id

GROUP BY
    p.project_id,
    p.project_name,
    p.budget;

-- ==========================================================
-- Q98
-- Calculate employee productivity
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,

    COUNT(s.sale_id) AS total_sales,

    SUM(s.revenue) AS total_revenue

FROM employees e

LEFT JOIN sales s
ON e.employee_id = s.employee_id

GROUP BY
    e.employee_id,
    e.full_name

ORDER BY total_revenue DESC;

-- ==========================================================
-- Q99
-- Generate employee retention report
-- ==========================================================

SELECT
    department_id,

    ROUND(
        AVG(
            EXTRACT(
                YEAR FROM AGE(
                    CURRENT_DATE,
                    joining_date
                )
            )
        ),
        2
    ) AS avg_tenure_years

FROM employees

GROUP BY department_id

ORDER BY avg_tenure_years DESC;

-- ==========================================================
-- Q100
-- Generate turnover analysis
-- ==========================================================

SELECT
    department_id,
    COUNT(*) AS current_employees
FROM employees
GROUP BY department_id;

-- ==========================================================
-- Q101
-- Generate hiring trend report
-- ==========================================================

SELECT
    EXTRACT(YEAR FROM joining_date) AS year,
    EXTRACT(MONTH FROM joining_date) AS month,
    COUNT(*) AS hires
FROM employees
GROUP BY year, month
ORDER BY year, month;

-- ==========================================================
-- Q102
-- Generate city-wise workforce report
-- ==========================================================

SELECT
    city,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
GROUP BY city
ORDER BY employee_count DESC;

-- ==========================================================
-- Q103
-- Generate department-wise workforce report
-- ==========================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;

-- ==========================================================
-- Q104
-- Generate project allocation report
-- ==========================================================

SELECT
    p.project_name,
    COUNT(ep.employee_id) AS allocated_resources
FROM projects p
LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id
GROUP BY p.project_name
ORDER BY allocated_resources DESC;

-- ==========================================================
-- Q105
-- Generate project performance report
-- ==========================================================

SELECT
    p.project_name,
    p.budget,
    COUNT(ep.employee_id) AS team_size
FROM projects p
LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id
GROUP BY
    p.project_name,
    p.budget
ORDER BY p.budget DESC;

-- ==========================================================
-- Q106
-- Generate salary distribution report
-- ==========================================================

SELECT

CASE
    WHEN salary < 50000 THEN '0-50K'
    WHEN salary < 100000 THEN '50K-100K'
    WHEN salary < 150000 THEN '100K-150K'
    ELSE '150K+'
END AS salary_band,

COUNT(*) AS employees

FROM employees

GROUP BY salary_band

ORDER BY employees DESC;

-- ==========================================================
-- Q107
-- Generate compensation dashboard
-- ==========================================================

SELECT
    COUNT(*) AS employees,
    AVG(salary) AS avg_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    SUM(salary) AS total_payroll
FROM employees;

-- ==========================================================
-- Q108
-- Generate workforce diversity report
-- ==========================================================

SELECT
    city,
    COUNT(*) AS workforce
FROM employees
GROUP BY city
ORDER BY workforce DESC;

-- ==========================================================
-- Q109
-- Generate workforce utilization report
-- ==========================================================

SELECT
    e.employee_id,
    e.full_name,

    COUNT(ep.project_id) AS assigned_projects

FROM employees e

LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id

GROUP BY
    e.employee_id,
    e.full_name

ORDER BY assigned_projects DESC;

-- ==========================================================
-- Q110
-- Generate HR executive dashboard
-- ==========================================================

SELECT

COUNT(*) AS total_employees,

COUNT(DISTINCT department_id)
AS total_departments,

AVG(salary)
AS average_salary,

MAX(salary)
AS highest_salary,

MIN(salary)
AS lowest_salary

FROM employees;

-- ==========================================================
-- Q111
-- Generate revenue dashboard
-- ==========================================================

SELECT

COUNT(*) AS total_transactions,

SUM(revenue) AS total_revenue,

AVG(revenue) AS avg_transaction_value,

MAX(revenue) AS highest_transaction

FROM sales;

-- ==========================================================
-- Q112
-- Generate project dashboard
-- ==========================================================

SELECT

COUNT(*) AS total_projects,

AVG(budget) AS average_budget,

SUM(budget) AS total_budget

FROM projects;

-- ==========================================================
-- Q113
-- Generate department dashboard
-- ==========================================================

SELECT
    d.department_name,

    COUNT(e.employee_id) AS employees,

    AVG(e.salary) AS avg_salary

FROM departments d

LEFT JOIN employees e
ON d.department_id = e.department_id

GROUP BY d.department_name;

-- ==========================================================
-- Q114
-- Generate city dashboard
-- ==========================================================

SELECT
    city,

    COUNT(*) AS employees,

    AVG(salary) AS avg_salary

FROM employees

GROUP BY city;

-- ==========================================================
-- Q115
-- Generate profitability report
-- ==========================================================

SELECT
    project_name,
    budget
FROM projects
ORDER BY budget DESC;

-- ==========================================================
-- Q116
-- Generate budget report
-- ==========================================================

SELECT
    SUM(budget) AS total_budget,
    AVG(budget) AS avg_budget,
    MAX(budget) AS max_budget,
    MIN(budget) AS min_budget
FROM projects;

-- ==========================================================
-- Q117
-- Generate cost analysis report
-- ==========================================================

SELECT
    department_id,
    SUM(salary) AS department_cost
FROM employees
GROUP BY department_id
ORDER BY department_cost DESC;

-- ==========================================================
-- Q118
-- Generate executive KPI dashboard
-- ==========================================================

SELECT

(SELECT COUNT(*) FROM employees)
AS total_employees,

(SELECT COUNT(*) FROM projects)
AS total_projects,

(SELECT SUM(revenue) FROM sales)
AS total_revenue,

(SELECT AVG(salary) FROM employees)
AS avg_salary;

-- ==========================================================
-- Q119
-- Generate operational KPI dashboard
-- ==========================================================

SELECT

COUNT(DISTINCT department_id)
AS departments,

COUNT(*) AS employees,

AVG(salary) AS avg_salary

FROM employees;

-- ==========================================================
-- Q120
-- Generate strategic KPI dashboard
-- ==========================================================

SELECT

(SELECT SUM(revenue) FROM sales)
AS total_revenue,

(SELECT SUM(salary) FROM employees)
AS total_payroll,

(SELECT COUNT(*) FROM projects)
AS total_projects,

(SELECT COUNT(*) FROM employees)
AS workforce_size;

-- ==========================================================
-- END OF SECTION 5
-- ADVANCED ANALYTICS COMPLETED
-- ==========================================================
-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 6 : TRANSACTIONS (Q121 - Q130)
-- ==========================================================

-- Assumed Table Structure
--
-- accounts
-- (
--     account_id,
--     account_holder,
--     balance
-- )
--
-- transaction_audit
-- (
--     audit_id,
--     transaction_type,
--     transaction_time,
--     remarks
-- )

-- ==========================================================
-- Q121
-- Transfer funds between accounts using transaction
-- ==========================================================

BEGIN;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 101;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 202;

COMMIT;

-- ==========================================================
-- Q122
-- Demonstrate COMMIT
-- ==========================================================

BEGIN;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 1;

COMMIT;

-- Changes are permanently saved.

-- ==========================================================
-- Q123
-- Demonstrate ROLLBACK
-- ==========================================================

BEGIN;

UPDATE employees
SET salary = salary + 10000
WHERE employee_id = 2;

ROLLBACK;

-- Changes are discarded.

-- ==========================================================
-- Q124
-- Demonstrate SAVEPOINT
-- ==========================================================

BEGIN;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 3;

SAVEPOINT salary_update;

UPDATE employees
SET salary = salary + 3000
WHERE employee_id = 4;

ROLLBACK TO SAVEPOINT salary_update;

COMMIT;

-- Employee 3 update remains.
-- Employee 4 update is reverted.

-- ==========================================================
-- Q125
-- Simulate failed transaction
-- ==========================================================

BEGIN;

UPDATE accounts
SET balance = balance - 10000
WHERE account_id = 101;

-- Simulated failure
-- Division by zero

SELECT 10 / 0;

ROLLBACK;

-- Entire transaction is reverted.

-- ==========================================================
-- Q126
-- Simulate successful transaction
-- ==========================================================

BEGIN;

INSERT INTO transaction_audit
(
    transaction_type,
    transaction_time,
    remarks
)
VALUES
(
    'TRANSFER',
    CURRENT_TIMESTAMP,
    'Successful fund transfer'
);

COMMIT;

-- ==========================================================
-- Q127
-- Demonstrate ACID compliance
-- ==========================================================

BEGIN;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 101;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 202;

COMMIT;

-- Atomicity:
-- Both operations succeed together.

-- Consistency:
-- Total balance remains unchanged.

-- Isolation:
-- Other transactions cannot interfere.

-- Durability:
-- Changes persist after COMMIT.

-- ==========================================================
-- Q128
-- Demonstrate concurrent updates
-- ==========================================================

-- Session 1

BEGIN;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 5;

-- Row remains locked until COMMIT

COMMIT;

-- Session 2 waits until Session 1 completes.

-- ==========================================================
-- Q129
-- Demonstrate transaction isolation
-- ==========================================================

BEGIN;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SELECT *
FROM employees
WHERE department_id = 1;

COMMIT;

-- Highest isolation level
-- Prevents dirty reads, non-repeatable reads,
-- and phantom reads.

-- ==========================================================
-- Q130
-- Create transaction audit example
-- ==========================================================

BEGIN;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 10;

INSERT INTO transaction_audit
(
    transaction_type,
    transaction_time,
    remarks
)
VALUES
(
    'SALARY_UPDATE',
    CURRENT_TIMESTAMP,
    'Salary increment for employee_id = 10'
);

COMMIT;

-- ==========================================================
-- BONUS TRANSACTION EXAMPLES
-- ==========================================================

-- Example 1: Multiple Savepoints

BEGIN;

SAVEPOINT sp1;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 1;

SAVEPOINT sp2;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 2;

ROLLBACK TO sp2;

COMMIT;

-- ----------------------------------------------------------

-- Example 2: Rollback Entire Transaction

BEGIN;

DELETE FROM employees
WHERE employee_id = 999;

ROLLBACK;

-- ----------------------------------------------------------

-- Example 3: Commit After Verification

BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

SELECT *
FROM accounts
WHERE account_id IN (1,2);

COMMIT;

-- ==========================================================
-- TRANSACTION ISOLATION LEVELS
-- ==========================================================

-- READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- ==========================================================
-- COMMON TRANSACTION PROBLEMS
-- ==========================================================

-- Dirty Read
-- Reading uncommitted data

-- Non-Repeatable Read
-- Same query returns different results

-- Phantom Read
-- New rows appear during transaction

-- Deadlock
-- Two transactions waiting on each other

-- ==========================================================
-- END OF SECTION 6
-- TRANSACTIONS COMPLETED
-- ==========================================================
-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 7 : QUERY OPTIMIZATION (Q131 - Q140)
-- ==========================================================

-- Database: PostgreSQL
-- Focus:
-- EXPLAIN
-- EXPLAIN ANALYZE
-- Indexing
-- Execution Plans
-- Query Cost Optimization
-- Performance Tuning

-- ==========================================================
-- Q131
-- Analyze query using EXPLAIN
-- ==========================================================

EXPLAIN

SELECT *
FROM employees
WHERE department_id = 1;

-- Purpose:
-- View estimated execution plan.
-- Shows:
-- Cost
-- Rows
-- Width
-- Access Method

-- ==========================================================
-- Q132
-- Analyze query using EXPLAIN ANALYZE
-- ==========================================================

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE department_id = 1;

-- Purpose:
-- Executes query and shows actual statistics.

-- Displays:
-- Actual Rows
-- Actual Time
-- Loops
-- Planning Time
-- Execution Time

-- ==========================================================
-- Q133
-- Create index for employee search
-- ==========================================================

CREATE INDEX idx_employees_full_name
ON employees(full_name);

-- Verify Usage

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE full_name = 'Rutvik Mathapati';

-- ==========================================================
-- Q134
-- Create index for salary queries
-- ==========================================================

CREATE INDEX idx_employees_salary
ON employees(salary);

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE salary > 100000;

-- ==========================================================
-- Q135
-- Create composite index
-- ==========================================================

CREATE INDEX idx_dept_salary
ON employees(department_id, salary);

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE department_id = 1
AND salary > 80000;

-- ==========================================================
-- Q136
-- Compare indexed vs non-indexed query
-- ==========================================================

-- BEFORE INDEX

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE city = 'Bangalore';

-- Create Index

CREATE INDEX idx_city
ON employees(city);

-- AFTER INDEX

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE city = 'Bangalore';

-- Expected:
-- Sequential Scan
-- ↓
-- Index Scan

-- ==========================================================
-- Q137
-- Optimize slow JOIN query
-- ==========================================================

-- Original Query

EXPLAIN ANALYZE

SELECT
e.full_name,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- Optimization

CREATE INDEX idx_emp_department
ON employees(department_id);

CREATE INDEX idx_department_pk
ON departments(department_id);

-- Re-run EXPLAIN ANALYZE

-- Expected Improvement:
-- Faster Join Performance

-- ==========================================================
-- Q138
-- Optimize slow aggregation query
-- ==========================================================

EXPLAIN ANALYZE

SELECT
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;

-- Optimization

CREATE INDEX idx_group_department
ON employees(department_id);

-- Re-check execution plan

EXPLAIN ANALYZE

SELECT
department_id,
AVG(salary)
FROM employees
GROUP BY department_id;

-- ==========================================================
-- Q139
-- Optimize nested subquery
-- ==========================================================

-- Original Version

EXPLAIN ANALYZE

SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);

-- Optimized Version using CTE

EXPLAIN ANALYZE

WITH avg_salary AS
(
    SELECT AVG(salary) AS company_avg
    FROM employees
)

SELECT *
FROM employees
WHERE salary >
(
    SELECT company_avg
    FROM avg_salary
);

-- Alternative Optimization

WITH company_average AS
(
    SELECT AVG(salary) avg_sal
    FROM employees
)

SELECT
e.*
FROM employees e
CROSS JOIN company_average ca
WHERE e.salary > ca.avg_sal;

-- ==========================================================
-- Q140
-- Generate query performance report
-- ==========================================================

SELECT

schemaname,

relname AS table_name,

seq_scan,

idx_scan,

n_tup_ins,

n_tup_upd,

n_tup_del

FROM pg_stat_user_tables

ORDER BY seq_scan DESC;

-- ==========================================================
-- BONUS OPTIMIZATION QUERIES
-- ==========================================================

-- Query 1
-- Find Unused Indexes

SELECT
schemaname,
relname,
indexrelname,
idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0;

-- ----------------------------------------------------------

-- Query 2
-- Largest Tables

SELECT
relname AS table_name,

pg_size_pretty
(
    pg_total_relation_size(relid)
) AS table_size

FROM pg_catalog.pg_statio_user_tables

ORDER BY
pg_total_relation_size(relid) DESC;

-- ----------------------------------------------------------

-- Query 3
-- Largest Indexes

SELECT

indexrelname,

pg_size_pretty
(
    pg_relation_size(indexrelid)
) AS index_size

FROM pg_stat_user_indexes

ORDER BY
pg_relation_size(indexrelid) DESC;

-- ----------------------------------------------------------

-- Query 4
-- Table Row Counts

SELECT

relname,

n_live_tup

FROM pg_stat_user_tables

ORDER BY n_live_tup DESC;

-- ----------------------------------------------------------

-- Query 5
-- Missing Index Candidates

EXPLAIN ANALYZE

SELECT *
FROM employee_projects
WHERE employee_id = 1001;

-- Recommended:

CREATE INDEX idx_employee_projects_employee
ON employee_projects(employee_id);

-- ----------------------------------------------------------

-- Query 6
-- Analyze Database Statistics

ANALYZE employees;

ANALYZE departments;

ANALYZE projects;

ANALYZE employee_projects;

-- ----------------------------------------------------------

-- Query 7
-- Vacuum Table

VACUUM ANALYZE employees;

-- ----------------------------------------------------------

-- Query 8
-- Reindex Table

REINDEX TABLE employees;

-- ----------------------------------------------------------

-- Query 9
-- Show Active Queries

SELECT
pid,
query,
state
FROM pg_stat_activity
WHERE state = 'active';

-- ----------------------------------------------------------

-- Query 10
-- Detect Long Running Queries

SELECT

pid,

now() - query_start AS duration,

query

FROM pg_stat_activity

WHERE state != 'idle'

ORDER BY duration DESC;

-- ==========================================================
-- QUERY OPTIMIZATION BEST PRACTICES
-- ==========================================================

-- 1. Avoid SELECT *

-- Bad

SELECT *
FROM employees;

-- Good

SELECT
employee_id,
full_name,
salary
FROM employees;

-- ----------------------------------------------------------

-- 2. Filter Early

SELECT
employee_id,
full_name
FROM employees
WHERE department_id = 1;

-- ----------------------------------------------------------

-- 3. Index Frequently Queried Columns

CREATE INDEX idx_email
ON employees(email);

-- ----------------------------------------------------------

-- 4. Use EXISTS Instead of IN
-- For Large Datasets

SELECT *
FROM employees e
WHERE EXISTS
(
    SELECT 1
    FROM employee_projects ep
    WHERE ep.employee_id = e.employee_id
);

-- ----------------------------------------------------------

-- 5. Prefer CTEs for Readability

WITH high_salary_employees AS
(
    SELECT *
    FROM employees
    WHERE salary > 100000
)

SELECT *
FROM high_salary_employees;

-- ==========================================================
-- COMMON EXECUTION PLAN OPERATIONS
-- ==========================================================

-- Sequential Scan
-- Index Scan
-- Bitmap Heap Scan
-- Bitmap Index Scan
-- Nested Loop Join
-- Hash Join
-- Merge Join
-- Aggregate
-- Sort
-- Limit

-- ==========================================================
-- END OF SECTION 7
-- QUERY OPTIMIZATION COMPLETED
-- ==========================================================
-- ==========================================================
-- ADVANCED SQL PRACTICE SET
-- SECTION 8 : ENTERPRISE DASHBOARDS (Q141 - Q150)
-- ==========================================================

-- ==========================================================
-- Q141
-- Build Complete HR Analytics Dashboard
-- ==========================================================

SELECT

COUNT(*) AS total_employees,

COUNT(DISTINCT department_id)
AS total_departments,

AVG(salary)
AS average_salary,

MAX(salary)
AS highest_salary,

MIN(salary)
AS lowest_salary,

ROUND(
AVG(
EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date))
),
2
) AS average_experience_years

FROM employees;

-- ==========================================================
-- Q142
-- Build Employee Performance Dashboard
-- ==========================================================

SELECT

employee_id,

full_name,

department_id,

salary,

RANK()
OVER(
ORDER BY salary DESC
) AS performance_rank,

CASE
    WHEN salary >= 150000 THEN 'Outstanding'
    WHEN salary >= 100000 THEN 'Excellent'
    WHEN salary >= 70000 THEN 'Good'
    ELSE 'Average'
END AS performance_grade

FROM employees

ORDER BY performance_rank;

-- ==========================================================
-- Q143
-- Build Revenue Analytics Dashboard
-- ==========================================================

SELECT

DATE_TRUNC('month', sale_date) AS month,

SUM(revenue) AS total_revenue,

AVG(revenue) AS average_transaction,

COUNT(*) AS transactions,

MAX(revenue) AS highest_sale,

MIN(revenue) AS lowest_sale

FROM sales

GROUP BY DATE_TRUNC('month', sale_date)

ORDER BY month;

-- ==========================================================
-- Q144
-- Build Executive KPI Dashboard
-- ==========================================================

SELECT

(SELECT COUNT(*) FROM employees)
AS workforce_size,

(SELECT COUNT(*) FROM projects)
AS active_projects,

(SELECT SUM(revenue) FROM sales)
AS total_revenue,

(SELECT AVG(salary) FROM employees)
AS average_salary,

(SELECT COUNT(DISTINCT department_id)
 FROM employees)
AS departments_count;

-- ==========================================================
-- Q145
-- Build Workforce Planning Dashboard
-- ==========================================================

SELECT

department_id,

COUNT(*) AS current_headcount,

AVG(salary) AS average_salary,

ROUND(
AVG(
EXTRACT(YEAR FROM AGE(
CURRENT_DATE,
joining_date
))
),
2
) AS avg_experience

FROM employees

GROUP BY department_id

ORDER BY current_headcount DESC;

-- ==========================================================
-- Q146
-- Build Project Resource Dashboard
-- ==========================================================

SELECT

p.project_id,

p.project_name,

p.budget,

COUNT(ep.employee_id)
AS allocated_resources,

ROUND(
p.budget /
NULLIF(COUNT(ep.employee_id),0),
2
) AS budget_per_resource

FROM projects p

LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id

GROUP BY
p.project_id,
p.project_name,
p.budget

ORDER BY allocated_resources DESC;

-- ==========================================================
-- Q147
-- Build Department Performance Dashboard
-- ==========================================================

SELECT

d.department_name,

COUNT(e.employee_id)
AS employee_count,

AVG(e.salary)
AS average_salary,

SUM(e.salary)
AS total_salary_cost,

MAX(e.salary)
AS highest_salary,

MIN(e.salary)
AS lowest_salary

FROM departments d

LEFT JOIN employees e
ON d.department_id = e.department_id

GROUP BY d.department_name

ORDER BY average_salary DESC;

-- ==========================================================
-- Q148
-- Build Strategic Planning Dashboard
-- ==========================================================

WITH workforce_stats AS
(
    SELECT
        COUNT(*) AS employees,
        AVG(salary) AS avg_salary
    FROM employees
),

revenue_stats AS
(
    SELECT
        SUM(revenue) AS revenue
    FROM sales
),

project_stats AS
(
    SELECT
        COUNT(*) AS projects,
        SUM(budget) AS total_budget
    FROM projects
)

SELECT *

FROM workforce_stats,
     revenue_stats,
     project_stats;

-- ==========================================================
-- Q149
-- Build Enterprise BI Dashboard
-- ==========================================================

WITH department_metrics AS
(
    SELECT
        department_id,
        COUNT(*) AS employees,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),

revenue_metrics AS
(
    SELECT
        SUM(revenue) AS total_revenue
    FROM sales
),

project_metrics AS
(
    SELECT
        COUNT(*) AS total_projects
    FROM projects
)

SELECT *

FROM revenue_metrics,
     project_metrics;

-- ==========================================================
-- Q150
-- Build End-to-End Executive Reporting Dashboard
-- MASTER DASHBOARD
-- ==========================================================

WITH employee_summary AS
(
    SELECT
        COUNT(*) AS total_employees,
        AVG(salary) AS avg_salary,
        MAX(salary) AS max_salary,
        MIN(salary) AS min_salary
    FROM employees
),

department_summary AS
(
    SELECT
        COUNT(DISTINCT department_id)
        AS total_departments
    FROM employees
),

project_summary AS
(
    SELECT
        COUNT(*) AS total_projects,
        SUM(budget) AS total_project_budget
    FROM projects
),

revenue_summary AS
(
    SELECT
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS avg_revenue
    FROM sales
)

SELECT

es.total_employees,

ds.total_departments,

ps.total_projects,

ps.total_project_budget,

rs.total_revenue,

rs.avg_revenue,

es.avg_salary,

es.max_salary,

es.min_salary

FROM employee_summary es

CROSS JOIN department_summary ds

CROSS JOIN project_summary ps

CROSS JOIN revenue_summary rs;

-- ==========================================================
-- BONUS DASHBOARDS
-- ==========================================================

-- Dashboard 1
-- Top 10 Highest Paid Employees

SELECT
employee_id,
full_name,
salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- ----------------------------------------------------------

-- Dashboard 2
-- Top Departments by Salary Cost

SELECT
department_id,
SUM(salary) AS salary_cost
FROM employees
GROUP BY department_id
ORDER BY salary_cost DESC;

-- ----------------------------------------------------------

-- Dashboard 3
-- Monthly Revenue Trend

SELECT
DATE_TRUNC('month', sale_date) AS month,
SUM(revenue) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

-- ----------------------------------------------------------

-- Dashboard 4
-- Employee Growth Trend

SELECT
EXTRACT(YEAR FROM joining_date) AS year,
COUNT(*) AS employees
FROM employees
GROUP BY year
ORDER BY year;

-- ----------------------------------------------------------

-- Dashboard 5
-- Project Utilization Report

SELECT
p.project_name,
COUNT(ep.employee_id) AS resources
FROM projects p
LEFT JOIN employee_projects ep
ON p.project_id = ep.project_id
GROUP BY p.project_name
ORDER BY resources DESC;

-- ==========================================================
-- EXECUTIVE KPI LIBRARY
-- ==========================================================

-- KPI 1
-- Total Revenue

SELECT SUM(revenue)
FROM sales;

-- KPI 2
-- Average Salary

SELECT AVG(salary)
FROM employees;

-- KPI 3
-- Workforce Size

SELECT COUNT(*)
FROM employees;

-- KPI 4
-- Active Projects

SELECT COUNT(*)
FROM projects;

-- KPI 5
-- Revenue Per Employee

SELECT
SUM(revenue) /
COUNT(DISTINCT employee_id)
AS revenue_per_employee
FROM sales;

-- KPI 6
-- Payroll Cost

SELECT SUM(salary)
FROM employees;

-- KPI 7
-- Average Project Budget

SELECT AVG(budget)
FROM projects;

-- KPI 8
-- Employee Utilization

SELECT
AVG(project_count)
FROM
(
    SELECT
    employee_id,
    COUNT(*) AS project_count
    FROM employee_projects
    GROUP BY employee_id
) x;

-- ==========================================================
-- END OF SECTION 8
-- ENTERPRISE DASHBOARDS COMPLETED
-- ==========================================================

-- ==========================================================
-- END OF ADVANCED SQL SOLUTIONS
-- ==========================================================

-- SQL MASTERY PORTFOLIO COMPLETED
--
-- Beginner:
-- 50 Queries + Solutions
--
-- Intermediate:
-- 100 Queries + Solutions
--
-- Advanced:
-- 150 Queries + Solutions
--
-- Total:
-- 300 SQL Problems Solved
--
-- Projects:
-- 1. Student Management System
-- 2. Employee Management System
-- 3. E-Commerce Database System
-- 4. Hospital Management System
--
-- Documentation:
-- SQL Roadmap
-- SQL CheatSheet
-- SQL Interview Questions
-- SQL Best Practices
-- Normalization Guide
-- Database Design Guide
-- Window Functions Guide
--
-- Portfolio Status: COMPLETE
-- ==========================================================