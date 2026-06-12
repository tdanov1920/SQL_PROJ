--MOST PAYING SKILLS

/*SHOW TABLES;

DESCRIBE job_postings_fact;

DESCRIBE skills_dim;

DESCRIBE skills_job_dim; */


SELECT
    sd.skills,
    COUNT(*) AS demand,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS Median_salary
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer' AND
    jpf.job_work_from_home = 'True'
GROUP BY
    sd.skills
HAVING
     COUNT(*) > 100
ORDER BY
    Median_salary DESC
LIMIT 25;

/*

This is a breakdown of the highest paying skills for Data Engineer with work from home option. The table includes the skill name, the number of job postings that require that skill, and the median salary for those job postings. The results are ordered by median salary in descending order, showing the highest paying skills at the top.
┌────────────┬────────┬───────────────┐
│   skills   │ demand │ Median_salary │
│  varchar   │ int64  │    double     │
├────────────┼────────┼───────────────┤
│ rust       │    232 │      210000.0 │
│ terraform  │   3248 │      184000.0 │
│ golang     │    912 │      184000.0 │
│ spring     │    364 │      175500.0 │
│ neo4j      │    277 │      170000.0 │
│ gdpr       │    582 │      169616.0 │
│ zoom       │    127 │      168438.0 │
│ graphql    │    445 │      167500.0 │
│ mongo      │    265 │      162250.0 │
│ fastapi    │    204 │      157500.0 │
│ bitbucket  │    478 │      155000.0 │
│ django     │    265 │      155000.0 │
│ crystal    │    129 │      154224.0 │
│ c          │    444 │      151500.0 │
│ atlassian  │    249 │      151500.0 │
│ typescript │    388 │      151000.0 │
│ kubernetes │   4202 │      150500.0 │
│ ruby       │    736 │      150000.0 │
│ css        │    262 │      150000.0 │
│ airflow    │   9996 │      150000.0 │
│ node       │    179 │      150000.0 │
│ redis      │    605 │      149000.0 │
│ vmware     │    136 │      148798.0 │
│ ansible    │    475 │      148798.0 │
│ jupyter    │    400 │      147500.0 │
└────────────┴────────┴───────────────┘
  25 rows                   3 columns
  */