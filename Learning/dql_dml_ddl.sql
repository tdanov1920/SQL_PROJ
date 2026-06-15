-- DQL - DATA QUERY LANGUAGE (SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY)
-- DML - DATA MANIPULATION LANGUAGE (INSERT, UPDATE, DELETE)
-- DDL - DATA DEFINITION LANGUAGE (CREATE, ALTER, DROP, TRUNCATE, RENAME)

-- CREATE DATABASE IF NOT EXISTS jobs_mart;
--SHOW DATABASES;
-- DROP DATABASE IF EXISTS jobs_mart;
SELECT * from information_schema.tables WHERE table_catalog = 'jobs_mart'; -- to see all schemas in the database

CREATE SCHEMA IF NOT EXISTS jobs_mart.staging;

USE jobs_mart;

-- DROP SCHEMA IF EXISTS jobs_mart.staging CASCADE; -- to drop the schema and all its objects

CREATE TABLE IF NOT EXISTS jobs_mart.staging.priority_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR(255),
);

-- DROP TABLE IF EXISTS jobs_mart.staging.priority_roles; -- to drop the table


INSERT INTO jobs_mart.staging.priority_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Data Scientist'),
    (3, 'Data Analyst'),
    (4, 'Machine Learning Engineer'),
    (5, 'Business Intelligence Analyst');

ALTER TABLE jobs_mart.staging.priority_roles
ADD COLUMN preferred_roles BOOLEAN;

--ALTER TABLE jobs_mart.staging.priority_roles
--DROP COLUMN preferred_roles ;

UPDATE jobs_mart.staging.priority_roles
SET preferred_roles = TRUE
WHERE role_id IN (1, 2, 4);

UPDATE jobs_mart.staging.priority_roles
SET preferred_roles = FALSE 
WHERE role_id IN (3, 5);

--ALTER TABLE jobs_mart.staging.priority_roles; -- to see the updated table structure

ALTER TABLE jobs_mart.staging.priority_roles
RENAME COLUMN preferred_roles TO priority_lvl;


ALTER TABLE jobs_mart.staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER  ;