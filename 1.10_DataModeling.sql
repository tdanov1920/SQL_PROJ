/*SELECT 
    j.job_title,
    c.company_id,
    c.name AS company_name
FROM 
    data_jobs.job_postings_fact AS j
JOIN 
    data_jobs.company_dim AS c
    ON j.company_id = c.company_id
LIMIT 10; */



SELECT *
FROM skills_dim
LIMIT 5;


SELECT *
FROM skills_job_dim
LIMIT 5;


SELECT *
FROM information_schema.tables
WHERE table_catalog = 'data_jobs';



SELECT *
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs';


PRAGMA show_tables;

DESCRIBE job_postings_fact;