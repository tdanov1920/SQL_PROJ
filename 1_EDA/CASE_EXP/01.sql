-- BUCKET Salaries


-- < 25 = 'Low'

-- 25 - 50 = 'Medium'

-- ?50 = 'High'

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg >= 25 AND salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL;



-- HANDLING MISSING DATA (NULLS)

-FILTER NULL salary values


SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg >= 25 AND salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category,
FROM job_postings_fact;


-- Categorizing Categorical Values
-- Clasify the 'job_title' column values as:
    -- 'Data Analyst'
    -- 'Data Engineer'
    --Data Scientist'

SELECT
    job_title,
    job_title_short,
    CASE
        -- Exclude non-target roles first if they sneak in
        WHEN LOWER(job_title) LIKE '%tutor%' THEN 'Other'
        
        WHEN LOWER(job_title) LIKE '%analyst%' THEN 'Data Analyst'
        WHEN LOWER(job_title) LIKE '%engineer%' THEN 'Data Engineer'
        WHEN LOWER(job_title) LIKE '%scientist%' OR LOWER(job_title) LIKE '%science%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_category
FROM job_postings_fact;



-- Conditional Aggregation
-- Calculate Median Salaries for Different Buckets
    -- < 100k
    -- >= 100k

SELECT
    job_title_short,
    COUNT(*) as total_postings,
    MEDIAN(
            CASE
                WHEN salary_year_avg < 100000 THEN salary_year_avg
            END
    ) as median_low_salary,
    MEDIAN(
            CASE
                WHEN salary_year_avg >= 100000 THEN salary_year_avg
            END
    ) as median_high_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP by job_title_short
ORDER by total_postings DESC
LIMIT 20;


--FINAL EXAMPLE: Conditional Calculations

-- Compute a standardized_salary using yearly salary and adjusted hourlysalary (e.g. 2080 hours per year)
-- Categorize salaries into tiers of:
    -- < 75k = 'Low'
    -- 75k - 150k = 'Medium'
    -- > 150k = 'High'

SELECT
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    CASE 
        WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
        WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
        ELSE NULL
    END AS standartized_salary,
    CASE
        WHEN standartized_salary < 75000 THEN  'Low'
        WHEN standartized_salary >= 75000 AND standartized_salary < 150000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg is NOT NULL OR salary_year_avg is NOT NULL;

