--SELECT CAST('123' AS INTEGER);

SELECT
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR) as 'unique id', -- from int to varchar,
    CAST(job_work_from_home AS INTEGER) as 'job work from home', -- from boolean to numeric
    CAST(job_posted_date AS DATE) as 'job posted date', -- from timestamp to date only
    CAST(salary_year_avg AS DECIMAL(10, 0)) AS 'Salary year average' -- from double to no decimal places
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 10;

-- OR you can interchange CAST for ::