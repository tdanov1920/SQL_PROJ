--MOST IN DEMAND SKILLS

/*SHOW TABLES;

DESCRIBE job_postings_fact;

DESCRIBE skills_dim;

DESCRIBE skills_job_dim; */


SELECT
    sd.skills,
    COUNT(*) AS demand
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
ORDER BY
    demand DESC
LIMIT 10;


/*
This table provide information about the top 10 most in demand skills for Data Engineer with work from home option. The table includes the skill name and the number of job postings that require that skill. The results are ordered by demand in descending order, showing the most sought-after skills at the top.
*/
/*
┌────────────┬────────┐
│   skills   │ demand │
│  varchar   │ int64  │
├────────────┼────────┤
│ sql        │  29221 │
│ python     │  28776 │
│ aws        │  17823 │
│ azure      │  14143 │
│ spark      │  12799 │
│ airflow    │   9996 │
│ snowflake  │   8639 │
│ databricks │   8183 │
│ java       │   7267 │
│ gcp        │   6446 │
└────────────┴────────┘
  10 rows   2 columns
  */