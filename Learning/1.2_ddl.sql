-- CTA's are actual tables that store data physically in the database. They can be queried, updated, and manipulated like any other table.
-- VIEWS are virtual tables that are created by a query and do not store data physically. They are used to simplify complex queries and provide a way to encapsulate logic.
-- TEMP TABLES are temporary tables that are created for the duration of a session and are automatically dropped when the session ends. They are used to store intermediate results or temporary data that is needed for a specific query or operation.
 --USED DESCRIBE to see the structure of the table and its columns
CREATE OR REPLACE TABLE staging.jobs_postings_flat AS
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
LEFT JOIN data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id;

DROP TABLE IF EXISTS staging.job_postings_flat;

SELECT COUNT(*)  FROM staging.job_postings_flat ;


--BUILDING A VIEW

CREATE OR REPLACE VIEW staging.jobs_postings_flat_view AS
SELECT 
    jpf.*
FROM staging.jobs_postings_flat as jpf
INNER JOIN staging.priority_roles as pr 
ON jpf.job_title_short = pr.role_name
WHERE pr.priority_lvl = 1;

DROP VIEW IF EXISTS staging.job_postings_flat_view;


--TEMPORARY TABLE
CREATE OR REPLACE TEMPORARY TABLE data_scientist AS
SELECT
    *
FROM staging.jobs_postings_flat_view as jpf
WHERE jpf.job_title_short = 'Data Scientist';