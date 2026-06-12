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
ORDER BY
    jpf.job_id  ASC
LIMIT 5;

-- LEFT Join takes all the data from the first table (in my case jpf) and bring only the related stuff from table b (in my case cd). If there is no match in table b, it will return NULL for those columns.

SELECT
    COUNT(*)
FROM
    job_postings_fact;


SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id;

-- RIGHT JOIN now
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
RIGHT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id;

-- INNER JOIN

SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
INNER JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id;

--FULL JOIN

SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
FULL OUTER JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id;

--MULTIPLE JoINS (LEFT)

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.job_id,
    sjd.skill_id,
    sd.skill_id
FROM
    job_postings_fact AS jpf
LEFT JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;

--MULTIPLE JoINS (INNER)
SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;

--MULTIPLE JoINS (FULL)
SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
FULL OUTER JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
FULL OUTER JOIN
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;