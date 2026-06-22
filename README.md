COVID-19 Data Analysis using SQL Server

📌 Introduction

This project analyses a global COVID-19 dataset using Microsoft SQL Server to uncover trends in cases, deaths, vaccination rates, and continent-level performance.

The analysis focuses on transforming raw COVID-19 data into meaningful insights through SQL querying, aggregation, ranking, and KPI calculations.

🔍 SQL script: Covid19_SQL_Analysis.sql

📊 Background

The COVID-19 pandemic generated vast amounts of data across countries and continents. Understanding patterns in infections, deaths, and vaccination coverage requires more than simply querying data—it requires selecting the correct analytical approach and aggregations to produce reliable insights.

Using a dimensional data model consisting of country, case, and vaccination tables, this project explores key global COVID-19 trends.

❓ Business Questions Answered
How many countries are in the dataset?
What is the earliest and latest date available?
Which countries recorded the highest total COVID-19 cases?
Which countries recorded the highest total COVID-19 deaths?
Which countries had the highest COVID-19 death rates?
Which countries vaccinated the highest percentage of their population?
Which continent recorded the highest total COVID-19 cases?
Which continent recorded the highest death rate?
Which continent recorded the highest vaccination rate?
Which countries exceeded 1 million confirmed cases?
How do countries rank by total cases?
Which are the Top 3 countries within each continent by total cases?

🗂️ Dataset Structure

DimCountry
Contains:

Country
Continent
Population
GDP per Capita
Human Development Index

CovidCasesDaily
Contains:

Date
Total Cases
New Cases
Total Deaths
New Deaths

CovidVaccinationsDaily
Contains:

Total Vaccinations
People Vaccinated
People Fully Vaccinated

🛠️ SQL Skills Demonstrated:

INNER JOIN
Aggregate Functions (COUNT, MAX, SUM)
GROUP BY
HAVING
Subqueries
Common Table Expressions (CTEs)
Window Functions (ROW_NUMBER, RANK)
KPI Calculations
Data Modelling
Data Exploration

📈 Key Insights:
Highest Total Cases by Country
United States recorded the highest number of confirmed cases.
China and India followed closely behind.
Several European countries featured prominently in the Top 10.
Vaccination Analysis
Gibraltar achieved the highest vaccination coverage relative to population.
Several smaller nations demonstrated exceptionally high vaccination rates.
Continent Analysis
Africa recorded the highest calculated death rate among continents.
Asia recorded the lowest death rate in the analysis.
Vaccination coverage varied significantly between continents.

🖼️ Sample Analysis Outputs
Highest Death Rate by Continent

(Insert screenshot here)

Top 10 Countries by Total Cases

(Insert screenshot here)

Top 10 Countries by Vaccination Percentage

(Insert screenshot here)

Top 3 Countries Within Each Continent by Total Cases

(Insert screenshot here)

💻 Tools Used
Microsoft SQL Server
SQL Server Management Studio (SSMS)
GitHub

📂 Repository Contents
Covid19_SQL_Analysis.sql
README.md
/images

🚀 Conclusion

This project demonstrates how SQL can be used to answer business-focused analytical questions through data modelling, aggregation, ranking, and KPI calculations. It highlights the importance of understanding data behaviour and selecting the appropriate analytical approach to generate accurate insights.
