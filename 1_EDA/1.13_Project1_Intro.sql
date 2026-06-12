SELECT DISTINCT
    job_title_short
FROM
    job_postings_fact
WHERE
    job_title_short IS NOT NULL;


SHOW 
TABLES;

DESCRIBE job_postings_fact;

-- MOST IN DEMAND JOBs
