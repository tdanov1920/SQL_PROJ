-- BUCKET SALARIES

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'LOW'
        WHEN salary_hour_avg < 50 THEN 'MEDIUM'
        --WHEN salary_hour_avg < 100 THEN 'HIGH'
        ELSE 'HIGH'
    END AS salary_bucket
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL;

-- FILTER NULL Salary values
SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'MISSING'
        WHEN salary_hour_avg < 25 THEN 'LOW'
        WHEN salary_hour_avg < 50 THEN 'MEDIUM'
        --WHEN salary_hour_avg < 100 THEN 'HIGH'
        ELSE 'HIGH'
    END AS salary_bucket
FROM job_postings_fact;


SELECT
    job_title,
    CASE
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'DATA_ANALYST'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'DATA_SCIENTIST'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'DATA_ENGINEER'
        ELSE 'OTHER'
    END AS job_title_category,
    job_title_short,
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;


-- MEDIAN

SELECT
    job_title_short,
    COUNT(*) AS total_postings,
    MEDIAN(CASE
        WHEN salary_year_avg < 100000 THEN salary_year_avg
    END) AS median_low_salary,
    MEDIAN(CASE
        WHEN salary_year_avg > 100000 THEN salary_year_avg
    END) AS median_high_salary,
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short;