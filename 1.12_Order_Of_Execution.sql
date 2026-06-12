EXPLAIN ANALYZE SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS num_job_postings
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_country = 'United States'
GROUP BY
    cd.name
HAVING
    COUNT(jpf.job_id) > 3000;
