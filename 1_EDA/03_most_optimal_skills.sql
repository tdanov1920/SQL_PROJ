--BEST POSSIBLE JOB that combines demand and pay

/*SHOW TABLES;

DESCRIBE job_postings_fact;

DESCRIBE skills_dim;

DESCRIBE skills_job_dim; */


SELECT
    sd.skills,
    COUNT(jpf.*) AS demand,
    ROUND(LN(COUNT(jpf.*)), 3 ) AS log_demand,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS Median_salary,
    ROUND((MEDIAN(jpf.salary_year_avg) * COUNT(jpf.*)) / 1000000, 2) AS Optimal_salary
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer' AND
    jpf.job_work_from_home = 'True' AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
     COUNT(jpf.*) > 100
ORDER BY
    Optimal_salary DESC
LIMIT 25;


┌────────────┬────────┬────────────┬───────────────┬────────────────┐
│   skills   │ demand │ log_demand │ Median_salary │ Optimal_salary │
│  varchar   │ int64  │   double   │    double     │     double     │
├────────────┼────────┼────────────┼───────────────┼────────────────┤
│ python     │   1133 │      7.033 │      135000.0 │         152.96 │
│ sql        │   1128 │      7.028 │      130000.0 │         146.64 │
│ aws        │    783 │      6.663 │      137320.0 │         107.52 │
│ spark      │    503 │      6.221 │      140000.0 │          70.42 │
│ azure      │    475 │      6.163 │      128000.0 │           60.8 │
│ snowflake  │    438 │      6.082 │      135500.0 │          59.35 │
│ airflow    │    386 │      5.956 │      150000.0 │           57.9 │
│ kafka      │    292 │      5.677 │      145000.0 │          42.34 │
│ java       │    303 │      5.714 │      135000.0 │          40.91 │
│ redshift   │    274 │      5.613 │      130000.0 │          35.62 │
│ terraform  │    193 │      5.263 │      184000.0 │          35.51 │
│ databricks │    266 │      5.583 │      132750.0 │          35.31 │
│ scala      │    247 │      5.509 │      137290.0 │          33.91 │
│ git        │    208 │      5.338 │      140000.0 │          29.12 │
│ hadoop     │    198 │      5.288 │      135000.0 │          26.73 │
│ gcp        │    196 │      5.278 │      136000.0 │          26.66 │
│ nosql      │    193 │      5.263 │      134415.0 │          25.94 │
│ kubernetes │    147 │       4.99 │      150500.0 │          22.12 │
│ pyspark    │    152 │      5.024 │      140000.0 │          21.28 │
│ docker     │    144 │       4.97 │      135000.0 │          19.44 │
│ tableau    │    164 │        5.1 │      115000.0 │          18.86 │
│ mongodb    │    136 │      4.913 │      135750.0 │          18.46 │
│ r          │    133 │       4.89 │      134775.0 │          17.93 │
│ github     │    127 │      4.844 │      135000.0 │          17.15 │
│ sql server │    139 │      4.934 │      120000.0 │          16.68 │
└────────────┴────────┴────────────┴───────────────┴────────────────┘
  25 rows                                                 5 column