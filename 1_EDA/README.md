# Data Engineering Job Market Analysis

> SQL-driven insights into the most in-demand, highest-paying, and optimal skills for remote Data Engineer positions.

---

## Table of Contents

- [Overview](#overview)
- [Project Goals](#project-goals)
- [Database Schema](#database-schema)
- [Queries & Insights](#queries--insights)
  - [1. Top Demanded Skills](#1-top-demanded-skills)
  - [2. Top Paying Skills](#2-top-paying-skills)
  - [3. Most Optimal Skills](#3-most-optimal-skills)
- [Key Findings](#key-findings)
- [Tools & Technologies](#tools--technologies)
- [How to Run](#how-to-run)
- [About the Data](#about-the-data)

---

## Overview

This project analyzes a dataset of job postings to identify which technical skills provide the best return on investment for aspiring and practicing **Data Engineers** targeting **remote** positions.

Rather than relying on anecdotal advice, these queries use real market data to rank skills by:
- **Demand** — how often a skill appears in job postings
- **Compensation** — median salary for roles requiring that skill
- **Optimal Value** — a composite score balancing both demand and pay

---

## Project Goals

1. **Identify core skills** every remote Data Engineer should prioritize.
2. **Discover high-value niche skills** that command premium salaries.
3. **Find the sweet spot** — skills that are both highly demanded *and* well-compensated.

---

## Database Schema

The analysis is built on three main tables:

| Table | Description |
|-------|-------------|
| `job_postings_fact` | Individual job postings with titles, locations, salaries, and remote-work flags. |
| `skills_dim` | Dimension table mapping `skill_id` to human-readable skill names (e.g., *Python*, *AWS*). |
| `skills_job_dim` | Bridge table linking job postings to the skills they require. |

### Entity Relationship

```
job_postings_fact  ←──  skills_job_dim  ──→  skills_dim
   (jobs)               (bridge)            (skills)
```

---

## Queries & Insights

### 1. Top Demanded Skills

**File:** `01_top_demanded_skills.sql`

**Question:** *What are the 10 most frequently requested skills in remote Data Engineer job postings?*

**Approach:**
- Filter for `job_title_short = 'Data Engineer'` and `job_work_from_home = 'True'`.
- Join `job_postings_fact` → `skills_job_dim` → `skills_dim`.
- Count occurrences per skill and rank descending.

**Results:**

| Rank | Skill | Demand |
|:----:|-------|-------:|
| 1 | SQL | 29,221 |
| 2 | Python | 28,776 |
| 3 | AWS | 17,823 |
| 4 | Azure | 14,143 |
| 5 | Spark | 12,799 |
| 6 | Airflow | 9,996 |
| 7 | Snowflake | 8,639 |
| 8 | Databricks | 8,183 |
| 9 | Java | 7,267 |
| 10 | GCP | 6,446 |

**Takeaway:** SQL and Python are non-negotiable baseline skills. Cloud platforms (AWS, Azure, GCP) and orchestration tools (Airflow) form the next critical tier.

---

### 2. Top Paying Skills

**File:** `02_top_paying_skills.sql`

**Question:** *Which skills are associated with the highest median salaries for remote Data Engineers?*

**Approach:**
- Same filters as above, plus `HAVING COUNT(*) > 100` to ensure statistical relevance.
- Use `MEDIAN(salary_year_avg)` to avoid outlier distortion.
- Rank by median salary descending.

**Top 10 Results:**

| Rank | Skill | Demand | Median Salary (USD) |
|:----:|-------|-------:|--------------------:|
| 1 | Rust | 232 | $210,000 |
| 2 | Terraform | 3,248 | $184,000 |
| 3 | Go | 912 | $184,000 |
| 4 | Spring | 364 | $175,500 |
| 5 | Neo4j | 277 | $170,000 |
| 6 | GDPR | 582 | $169,616 |
| 7 | Zoom | 127 | $168,438 |
| 8 | GraphQL | 445 | $167,500 |
| 9 | MongoDB | 265 | $162,250 |
| 10 | FastAPI | 204 | $157,500 |

**Takeaway:** Niche and infrastructure-heavy skills (Rust, Terraform, Go) command top dollar, often because fewer candidates possess them. However, demand is significantly lower than for core skills.

---

### 3. Most Optimal Skills

**File:** `03_most_optimal_skills.sql`

**Question:** *Which skills offer the best balance of high demand and high salary?*

**Approach:**
- Introduce a composite metric:  
  `Optimal_Salary = (Median_Salary × Demand) / 1,000,000`
- This rewards skills that are both *well-paid* and *marketable*.
- Also includes `log_demand` to visualize demand on a compressed scale.

**Top 10 Results:**

| Rank | Skill | Demand | Median Salary (USD) | Optimal Score |
|:----:|-------|-------:|--------------------:|--------------:|
| 1 | Python | 1,133 | $135,000 | 152.96 |
| 2 | SQL | 1,128 | $130,000 | 146.64 |
| 3 | AWS | 783 | $137,320 | 107.52 |
| 4 | Spark | 503 | $140,000 | 70.42 |
| 5 | Azure | 475 | $128,000 | 60.80 |
| 6 | Snowflake | 438 | $135,500 | 59.35 |
| 7 | Airflow | 386 | $150,000 | 57.90 |
| 8 | Kafka | 292 | $145,000 | 42.34 |
| 9 | Java | 303 | $135,000 | 40.91 |
| 10 | Redshift | 274 | $130,000 | 35.62 |

**Takeaway:** Python and SQL dominate the optimal ranking because their massive demand outweighs slightly lower individual salaries. Cloud and data-processing skills (AWS, Spark, Snowflake, Airflow) round out the high-value portfolio.

---

## Key Findings

| Insight | Recommendation |
|---------|----------------|
| **SQL & Python are foundational** | Prioritize fluency above all else. |
| **Cloud is mandatory** | AWS, Azure, and GCP appear in both high-demand and high-pay lists. |
| **Orchestration pays off** | Airflow and Kafka score well on the optimal metric—devops-like skills increase value. |
| **Niche skills = premium pay** | Rust, Terraform, and Go offer $180k+ medians but require deliberate specialization. |
| **The "Optimal" metric works** | Multiplying salary by demand surfaces practical career investments better than looking at pay alone. |

---

## Tools & Technologies

- **SQL Engine:** DuckDB / MotherDuck
- **Syntax:** Standard SQL with `MEDIAN()`, `LN()`, `ROUND()`, and CTE-friendly joins
- **Data Source:** Job postings dataset (see [About the Data](#about-the-data))
- **Editor:** gVim / Git Bash workflow

---

## How to Run

1. **Clone the repository** and navigate to the project folder.
2. **Start DuckDB** from the terminal:
   ```bash
   duckdb your_database.db
   ```
3. **Load the schema** (if not already present):
   ```sql
   .read schema_setup.sql
   ```
4. **Run any analysis query:**
   ```sql
   .read 01_top_demanded_skills.sql
   .read 02_top_paying_skills.sql
   .read 03_most_optimal_skills.sql
   ```

> **Tip:** If using MotherDuck, connect with:
> ```bash
> duckdb md:my_database
> ```

---

## About the Data

The underlying dataset contains anonymized job postings aggregated from multiple job boards. Key fields used:

- `job_title_short` — normalized role category (e.g., *Data Engineer*)
- `job_work_from_home` — boolean flag for remote eligibility
- `salary_year_avg` — estimated annual compensation in USD
- `skill_id` / `skills` — technical requirements per posting

> **Note:** Salary figures are estimates and may vary by region, experience level, and company size. The analysis focuses specifically on **remote** roles to remove geographic salary bias.

---

## Author

Built as a portfolio project by a Verification Engineer transitioning into Data Engineering. 

*If you found this useful, feel free to fork it and adapt the queries for your own target role (e.g., Data Analyst, Data Scientist, ML Engineer).*

---

## License

This project is open for educational and portfolio use. Data attribution belongs to the original job-postings dataset provider.
