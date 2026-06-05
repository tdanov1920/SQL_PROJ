--Left join

SELECT 
    jpf.job_id,
    cd.name AS company_name,
    jpf.job_title_short
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id;

SELECT 
    jpf.*,
    cd.*
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id
LIMIT 5;