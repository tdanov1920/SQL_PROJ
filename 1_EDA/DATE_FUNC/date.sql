SELECT 
    job_posted_date,
    job_posted_date::DATE as date_only,
    job_posted_date::TIME as time_only,
    job_posted_date::TIMESTAMP as timestamp_only,
    job_posted_date::TIMESTAMPTZ as timestampz_only
FROM job_postings_fact
ORDER BY job_posted_date DESC
LIMIT 10;


SELECT  
    EXTRACT(YEAR FROM job_posted_date) AS year,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(job_id) AS total_postings
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY year, month
ORDER BY COUNT(job_id) DESC;


SELECT
    DATE_TRUNC('month', job_posted_date) AS month_trunc,
    COUNT(job_id) AS total_postings
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer' AND EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY month_trunc
ORDER BY month_trunc DESC;


SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AS timestampz_value;

 SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'EST';   


SELECT
    job_posted_date AT TIME ZONE 'UTC' AS utc_time,
    job_posted_date AT TIME ZONE 'EST' AS est_time

FROM 
    job_postings_fact
LIMIT 10;
