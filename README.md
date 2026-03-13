# E-Commerce Customer Retention & Revenue Analytics

An end-to-end analytics project using Python, PostgreSQL, SQL, and Tableau to analyze customer retention, churn, revenue trends, and RFM customer segments.

Built from raw transactional data through Python-based cleaning, SQL validation, and Tableau dashboarding for business-ready insights.

**Why this project matters:** It demonstrates end-to-end analytics delivery from raw transactional data to business-ready retention, churn, revenue, and customer segmentation insights.

![Python](https://img.shields.io/badge/Python-Data%20Cleaning%20%26%20Analysis-blue?style=flat-square&logo=python)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Data%20Warehouse%20%26%20SQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-KPI%20Validation%20%26%20Retention%20Logic-orange?style=flat-square)
![Pandas](https://img.shields.io/badge/Pandas-Feature%20Engineering%20%26%20KPIs-150458?style=flat-square&logo=pandas)
![Tableau](https://img.shields.io/badge/Tableau-Dashboarding%20%26%20Storytelling-E97627?style=flat-square&logo=tableau&logoColor=white)
![Customer Analytics](https://img.shields.io/badge/Customer%20Analytics-Retention%20%26%20Churn-success?style=flat-square)
![RFM Analysis](https://img.shields.io/badge/RFM-Segmentation-6f42c1?style=flat-square)
![Kaggle Dataset](https://img.shields.io/badge/Kaggle-Superstore%20Dataset-20BEFF?style=flat-square&logo=kaggle&logoColor=white)

This project analyzes e-commerce transactions to answer business-critical questions such as:
- Which customers are most likely to churn?
- Which segments contribute the most revenue?
- How does revenue change over time?
- Which customer groups are high-value, loyal, or at risk?

The workflow covers **data cleaning, feature engineering, SQL-based validation, KPI generation, and dashboard development** for a business-facing analytics use case.

## Dashboard Preview
<img width="2400" height="1600" alt="Executive Dashboard" src="https://github.com/user-attachments/assets/3e7e16e3-1869-476f-9239-a580f91ab392" />

---

## Project Highlights

- Cleaned and prepared **9,993 transactional records** for analysis
- Built customer-level metrics for **repeat purchase rate, churn, recency, frequency, and monetary value**
- Validated KPIs and retention logic in **PostgreSQL using SQL**
- Developed a **Tableau executive dashboard** for stakeholder-ready reporting
- Identified key business patterns across **revenue, region, segment, and customer lifecycle behavior**

---

## Key Results

- **Total Revenue:** 2,296,919.49
- **Total Orders:** 5,009
- **Total Customers:** 793
- **Average Order Value:** 458.56
- **Repeat Purchase Rate:** 98.49%
- **Churn Rate (90-day inactivity rule):** 45.02%
- **Total Profit:** 286,409.08

---

## Business Insights

- **Technology** generated the highest revenue among all categories
- The **West** region contributed the most revenue, while the **South** contributed the least
- **Home Office** had the highest churn rate among customer segments
- The largest RFM bucket was **Lost / Low Value**, showing clear room for re-engagement
- Monthly revenue showed noticeable volatility, with stronger peaks in **late 2016** and **late 2017**

---

## Tech Stack

- **Python**
- **Pandas**
- **PostgreSQL**
- **SQL**
- **Tableau Public**
- **Jupyter Notebook**
- **Dataset: https://www.kaggle.com/datasets/vivek468/superstore-dataset-final**
---

## Project Workflow

1. Downloaded the Superstore dataset from Kaggle
2. Cleaned and validated the raw data in Python
3. Standardized schema and engineered time-based fields
4. Built customer-level summaries and churn logic
5. Exported analysis-ready CSV outputs
6. Loaded cleaned data into PostgreSQL
7. Created staging, dimension, and fact tables
8. Ran SQL queries to validate KPIs and retention metrics
9. Built an executive Tableau dashboard for reporting

---

## Data Cleaning and Feature Engineering

Main preparation steps:
- Converted date fields to datetime
- Standardized column names to snake_case
- Checked missing values and duplicates
- Removed 1 true business duplicate
- Created derived fields such as:
  - `order_month`
  - `order_year`
  - `order_quarter`
- Built customer-level fields such as:
  - `first_order_date`
  - `last_order_date`
  - `total_orders`
  - `total_revenue`
  - `avg_order_value`
  - `days_since_last_order`
  - `is_repeat_customer`
  - `is_churned_customer`

---

## Retention Logic

### Repeat Customer
Customer with **2 or more distinct orders**

### Churned Customer
Customer whose **last order date was more than 90 days before the latest order date in the dataset**

### RFM Segmentation
Customers were segmented using:
- **Recency** = days since last order
- **Frequency** = number of orders
- **Monetary** = total revenue

RFM buckets used:
- Champions
- Loyal Customers
- Potential Loyalists
- At Risk
- Lost / Low Value

---

## SQL Data Model

Tables created in PostgreSQL:
- `stg_superstore_orders`
- `dim_customers`
- `dim_products`
- `fact_orders`

SQL scripts included:
- `kpi_queries.sql`
- `retention_queries.sql`
- `retention_by_region_corrected.sql`
- `debug_customer_region.sql`

---

## Tableau Dashboard

The final dashboard includes:
- Executive KPI cards
- Monthly revenue trend
- Revenue by category
- Revenue by region
- Retention by segment
- RFM customer segment distribution

---

## Repository Structure

```text
ecommerce-retention-revenue-analytics/
├── README.md
├── .gitignore
├── notebooks/
│   └── 01_data_cleaning_and_validation.ipynb
├── sql/
│   ├── kpi_queries.sql
│   ├── retention_queries.sql
│   ├── retention_by_region_corrected.sql
│   └── debug_customer_region.sql
├── data/
├── raw/
│   │   └── Superstore.csv
│   ├── cleaned/
│   │   └── superstore_cleaned.csv
│   └── outputs/
│       ├── executive_summary.csv
│       ├── monthly_kpis.csv
│       ├── category_performance.csv
│       ├── subcategory_performance.csv
│       ├── region_performance.csv
│       ├── segment_performance.csv
│       ├── customer_summary_final.csv
│       ├── retention_by_segment.csv
│       ├── retention_by_region.csv
│       ├── rfm_customer_segments.csv
│       └── cohort_retention_matrix.csv
├── tableau/
│   └── ecommerce_retention_dashboard.twb
└── visuals/
    └── dashboard_screenshots/
        ├── executive_dashboard.png
        ├── monthly_revenue_trend.png
        ├── revenue_by_category.png
        ├── revenue_by_region.png
        ├── retention_by_segment.png
        └── rfm_customer_segments.png
```

---

## How to Run

1. Place the raw dataset in `data/raw/`
2. Run the notebook to clean data and generate outputs
3. Load cleaned data into PostgreSQL
4. Create staging, dimension, and fact tables
5. Run SQL scripts for KPI validation
6. Open Tableau Public and connect the cleaned and output CSVs
7. Rebuild or review the dashboard

---

## Next Improvements

- Add cohort retention visualization to the dashboard
- Include profit-focused sub-category analysis
- Add dashboard filters for segment and region
- Extend the project with churn driver analysis or predictive modeling
