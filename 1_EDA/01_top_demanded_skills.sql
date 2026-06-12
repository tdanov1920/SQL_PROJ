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
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_work_from_home = 'Yes'
GROUP BY
    sd.skills
ORDER BY
    demand DESC
LIMIT 10;