SELECT UNNEST([1,1,1,2])
UNION ALL
SELECT UNNEST([1,1,3]);

CREATE OR REPLACE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

select * from jobs_2023;


CREATE OR REPLACE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;


SELECT 
    *
FROM jobs_2023
WHERE job_title_short = 'Data Engineer'
UNION ALL
SELECT 
    *
FROM jobs_2024
WHERE job_title_short = 'Data Engineer'
LIMIT 10;


SELECT 
    '2023' AS year,
    COUNT(*) AS total_postings_23
FROM jobs_2023
UNION ALL
SELECT 
    '2024' AS year,
    COUNT(*) AS total_postings_24
FROM jobs_2024;



SELECT 
    job_title
FROM jobs_2024
EXCEPT
SELECT 
    job_title
FROM jobs_2023;


SELECT 
    *
FROM jobs_2023
EXCEPT ALL
SELECT 
    *
FROM jobs_2024;


SELECT 
    *
FROM jobs_2023
INTERSECT
SELECT 
    *
FROM jobs_2024;