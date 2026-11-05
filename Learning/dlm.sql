SELECT COUNT(*) FROM staging.jobs_postings_flat;
SELECT COUNT(*) FROM staging.jobs_postings_flat_view;
SELECT COUNT(*) FROM data_scientist;


"DELETE 
FROM staging.jobs_postings_flat
WHERE staging.jobs_postings_flat.job_posted_date < '2024-01-01';"

SELECT COUNT(*) FROM staging.jobs_postings_flat;
SELECT COUNT(*) FROM staging.jobs_postings_flat_view;
SELECT COUNT(*) FROM data_scientist;


TRUNCATE TABLE staging.jobs_postings_flat;

INSERT INTO staging.jobs_postings_flat
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.search_location,
    jpf.job_no_degree_mention,
    jpf.job_country,
    jpf.salary_year_avg,
    jpf.job_posted_date,
    jpf.job_country,
    jpf.job_work_from_home,
    cd.company_id,
    cd.name,
    cd.link,
    cd.link_google,
    cd.thumbnail
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id
WHERE  jpf.job_posted_date >= '2024-01-01';
