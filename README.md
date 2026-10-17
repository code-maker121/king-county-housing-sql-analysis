# King County Housing Market Analysis Using SQL

## Project Overview

This project analyzes 21,613 house sales in King County, Washington, from May 2014 to May 2015. The goal is to explore how housing prices vary based on location, property size, number of bedrooms, and time.

I used SQL with SQLite to explore the dataset, check data quality, and analyze housing prices. Python and Matplotlib were used to visualize the results.

## Tools Used

- **SQL (SQLite)** — Data exploration and analysis
- **Python (Pandas)** — Data loading and SQL query results
- **Matplotlib** — Data visualization
- **Google Colab** — Project development

## Dataset

**Source:** [King County House Sales Dataset — Kaggle](https://www.kaggle.com/datasets/harlfoxem/housesalesprediction)

- Records: 21,613
- Columns: 21
- Time Period: May 2014 – May 2015
- Location: King County, Washington, USA

The dataset includes housing prices, bedrooms, bathrooms, living area, ZIP codes, construction years, and other property information.

## Project Workflow

### 1. Data Exploration and Quality Checks

Used SQL to examine the dataset and identify potential data quality issues.

- Calculated average, minimum, and maximum housing prices.
- Checked five important columns for missing values.
- Checked for duplicate combinations of house ID and sale date.
- Identified invalid values and potential outliers.
- Found one unusual record with 33 bedrooms and 1,620 sqft of living space.

The original dataset was kept unchanged. For the bedroom price analysis, I focused on houses with 1–6 bedrooms.

### 2. SQL Analysis

Analyzed housing prices using SQL queries to answer the following questions:

- How do average house prices change with the number of bedrooms?
- Which ZIP codes have the highest average house prices?
- How does living area relate to housing prices?
- How did monthly average housing prices change over time?
- Which ZIP codes have the highest average price per square foot?

### 3. Advanced SQL Techniques

Used **Common Table Expressions (CTEs)** to calculate average price per square foot across ZIP codes.

Used the **LAG() Window Function** to calculate Month-over-Month changes in average housing prices.

SQL concepts used in this project include:

`SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `CASE WHEN`, `COUNT()`, `AVG()`, `CTE`, and `LAG()`.

### 4. Data Visualization

Created five charts using Matplotlib:

1. Monthly Average House Price
2. Average House Price by Bedrooms
3. Top 10 ZIP Codes by Average House Price
4. Average House Price by Living Area
5. Month-over-Month Average Price Change

All charts and their corresponding SQL queries are available in the Jupyter Notebook.

## Key Findings

**1. Bedrooms and Housing Prices**

Average house prices generally increased with the number of bedrooms. Three-bedroom houses were the most common, with 9,824 sales.

**2. Location and Housing Prices**

ZIP Code 98039 had the highest average house price at approximately $2.16 million, followed by 98004 and 98040.

**3. Living Area and Housing Prices**

Larger houses generally had higher average prices. Houses under 1,000 sqft averaged approximately $297K, while houses with 4,000 sqft or more averaged approximately $1.52 million.

**4. Price per Square Foot**

ZIP Code 98039 had the highest average price per square foot at approximately $568.08, followed by ZIP Code 98004 at $475.44.

**5. Monthly Price Trends**

Monthly average prices fluctuated throughout the dataset period. March 2015 had the largest Month-over-Month increase at 7.11%, while February 2015 had the largest decrease at 3.43%.

These changes describe monthly averages of sold properties, not changes in the value of the same properties.

## Project Files

| File | Description |
|---|---|
| `Housing_Market_SQL_Analysis.ipynb` | Complete SQL analysis, results, and visualizations |
| `housing_analysis.sql` | SQL queries used for the project |
| `README.md` | Project documentation |

## How to Run

1. Download `kc_house_data.csv` from the Kaggle dataset link above.
2. Open `Housing_Market_SQL_Analysis.ipynb` in Google Colab.
3. Upload the CSV file to the Colab runtime using the Files panel.
4. Update the CSV file path in `pd.read_csv()` if needed. The Notebook currently uses `/kc_house_data.csv`.
5. Run the Notebook cells in order to create the SQLite database and reproduce the SQL analysis and charts.

## Conclusion

This project helped me practice SQL for data exploration, data quality checks, and housing market analysis.

Using CTEs, aggregate functions, and window functions, I analyzed housing price differences across locations, property characteristics, and time.

The results suggest that location and living area are important factors associated with housing prices. This project also improved my ability to use SQL and Python together to communicate data insights.
