

--SUBQUERY EXAMPLE

SELECT *
FROM (
    SELECT *
    FROM staging.jobs_postings_flat
    WHERE job_title_short = 'Data Scientist'
) AS ds_jobs;

-- COMMON TABLE EXPRESSIONS (CTE) EXAMPLE
WITH ds_jobs AS (
    SELECT *
    FROM staging.jobs_postings_flat
    WHERE job_title_short = 'Data Scientist'
)

SELECT *
FROM ds_jobs;



-- 🧩 SCENARIO 1- Subquery in 'SELECT'
-- SHOW each job's salary next to the overall market median:
SELECT
    DISTINCT(job_title_short),
    salary_year_avg,
    ( SELECT
        MEDIAN(staging.jobs_postings_flat.salary_year_avg)
        FROM staging.jobs_postings_flat
) as 'Median Salary for job'
FROM staging.jobs_postings_flat
WHERE salary_year_avg IS NOT NULL
LIMIT 10;


-- 🧩 SCENARIO 2- Subquery in 'FROM'
-- Stage only jobs that are remote before aggregating:
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    ( SELECT
        MEDIAN(staging.jobs_postings_flat.salary_year_avg)
        FROM staging.jobs_postings_flat
        WHERE job_work_from_home = 'True'
        ) as 'Median Salary for job'
FROM (SELECT 
    job_title_short, 
    salary_year_avg
    FROM staging.jobs_postings_flat
    WHERE job_work_from_home = 'True') AS remote_jobs
GROUP BY job_title_short
LIMIT 10;

-- 🧩 SCENARIO 3- Subquery in 'HAVING'
-- Keep only jobs with above market median salary:
SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    ( SELECT
        MEDIAN(staging.jobs_postings_flat.salary_year_avg)
        FROM staging.jobs_postings_flat
        WHERE job_work_from_home = 'True'
        ) as 'Median Salary for job'
FROM (SELECT 
    job_title_short, 
    salary_year_avg
    FROM staging.jobs_postings_flat
    WHERE job_work_from_home = 'True') AS remote_jobs
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > ( SELECT
        MEDIAN(staging.jobs_postings_flat.salary_year_avg)
        FROM staging.jobs_postings_flat
        WHERE job_work_from_home = 'True'
        )
LIMIT 10;


-- Another CTE Example
-- Compare how much more (or less) remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calculate the median salary by title and work arranment, then compare those medians


WITH title_median AS (
    SELECT
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM staging.jobs_postings_flat
    WHERE job_country = 'United States'
    GROUP BY job_title_short, job_work_from_home
)  

SELECT
    r.job_title_short,
    r.median_salary as remote_median_salary, 
    o.median_salary as onsite_median_salary,
    (r.median_salary - o.median_salary) AS salary_difference
FROM title_median AS r
INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = 'True' AND o.job_work_from_home = 'False'
ORDER BY salary_difference DESC;



SELECT *
FROM range(3) as src(key);


SELECT *
FROM range(4) as tgt(key);

SELECT *
FROM range(3) as src(key)
WHERE NOT EXISTS(
    SELECT 1
    FROM range(2) as tgt(key)
    WHERE src.key = tgt.key
);

-- final example
-- Indefy job postings that have no associated skills before loadingthem into a data mark

SELECT *
FROM data_jobs.job_postings_fact
ORDER BY job_id
LIMIT 10;

SELECT *
FROM  data_jobs.skills_job_dim
ORDER BY job_id
LIMIT 40;


SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS(
    SELECT 1
    FROM data_jobs.skills_job_dim as src
    WHERE src.job_id = tgt.job_id
)
ORDER BY job_id;