SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.search_location,
    jpf.job_no_degree_mention,
    jpf.job_country,
    jpf.salary_year_avg,
    cd.company_id,
    cd.name,
    cd.link,
    cd.link_google,
    cd.thumbnail
FROM job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id
LIMIT 15;