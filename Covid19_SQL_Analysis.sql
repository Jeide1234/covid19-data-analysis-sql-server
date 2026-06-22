--Phase 1 – Exploratory Analysis

--Total countries are in the dataset?

SELECT 
COUNT(country) AS TotalCountries
FROM PortfolioProject.dbo.DimCountry;

--The earliest and latest date?

SELECT 
MIN(date) AS earliest_date, 
MAX(date) AS latest_date
FROM PortfolioProject.dbo.CovidCasesDaily;

--Top 10 countries with the highest total COVID cases?

SELECT TOP 10 
dc.country,
MAX(cc.total_cases) AS TotalCases
FROM PortfolioProject.dbo.DimCountry AS dc
JOIN PortfolioProject.dbo.CovidCasesDaily AS cc
ON dc.code = cc.code
GROUP BY dc.country
ORDER BY TotalCases DESC;

--Top 10 countries with the highest total deaths?

SELECT TOP 10
country,
MAX(cc.total_deaths) AS TotalDeaths
FROM PortfolioProject.dbo.CovidCasesDaily AS cc
JOIN PortfolioProject.dbo.DimCountry AS dc
ON cc.code = dc.code
GROUP BY dc.country
ORDER BY TotalDeaths DESC;

--Countries with the highest COVID death rate?--

SELECT 
country,
ROUND(MAX(cc.total_deaths) * 100.0/NULLIF(MAX(cc.total_cases), 0),2 ) AS HighestDeathRate
FROM PortfolioProject.dbo.CovidCasesDaily AS cc 
JOIN PortfolioProject.dbo.DimCountry AS dc
ON cc.code = dc.code
GROUP BY dc.country
ORDER BY HighestDeathRate DESC;


--Top 10 countries with the highest percentage of their population vaccinated?

SELECT TOP 10
dc.country,
ROUND(MAX(cd.people_fully_vaccinated) * 100.0 /NULLIF(MAX(dc.population), 0),2) AS VaccinationPercentage
FROM PortfolioProject.dbo.CovidVaccinationsDaily AS cd
JOIN PortfolioProject.dbo.DimCountry AS dc
ON cd.code = dc.code
GROUP BY dc.country
ORDER BY VaccinationPercentage DESC;

--Highest vaccination rate by continent

SELECT 
continent,
ROUND(SUM(CAST(CountryPeopleVaccinated AS FLOAT)) * 100.0 / NULLIF(SUM(CAST(CountryPopulation AS FLOAT)),0),2
) AS ContinentVaccinationRate
FROM

(SELECT dc.continent,
        dc.country,
        MAX(cv.people_fully_vaccinated) AS CountryPeopleVaccinated,
        MAX(dc.population) AS CountryPopulation
   FROM PortfolioProject.dbo.CovidVaccinationsDaily AS cv
   JOIN PortfolioProject.dbo.DimCountry AS dc
     ON cv.code = dc.code
GROUP BY dc.continent,dc.country
) AS CountryCases
GROUP BY continent
ORDER BY ContinentVaccinationRate DESC;


--Highest death rate by continent

SELECT 
continent,
ROUND(SUM(CAST(CountryTotalDeaths AS FLOAT)) * 100.0 /NULLIF(SUM(CAST(CountryTotalCases AS FLOAT)), 0),2
) AS ContinentDeathRate
FROM

(SELECT dc.continent,
        dc.country,
        MAX(cc.total_deaths) AS CountryTotalDeaths,
        MAX(cc.total_cases) AS CountryTotalCases
    FROM PortfolioProject.dbo.CovidCasesDaily AS cc
    JOIN PortfolioProject.dbo.DimCountry AS dc
        ON cc.code = dc.code
    GROUP BY dc.continent, dc.country
) AS CountryCases
GROUP BY continent
ORDER BY ContinentDeathRate DESC;

--Highest vaccination rate by country

SELECT
dc.country,
ROUND((MAX(cd.people_fully_vaccinated) *100.0/NULLIF(MAX(dc.population),0)),2) AS HighestVaccinationRate
FROM PortfolioProject.dbo.CovidVaccinationsDaily AS cd
JOIN PortfolioProject.dbo.DimCountry AS dc
ON cd.code = dc.code
GROUP BY dc.country
ORDER BY HighestVaccinationRate DESC;

--Highest total cases by continent

SELECT continent, 
       SUM(CountryHighestCases) AS TotalContinentCases
FROM 

(SELECT 
dc.country,dc.continent,MAX(cc.total_cases) AS CountryHighestCases
FROM PortfolioProject.dbo.DimCountry AS dc
JOIN PortfolioProject.dbo.CovidCasesDaily AS cc
ON dc.code = cc.code
GROUP BY dc.continent,dc.country) AS CountryCases
GROUP BY continent
ORDER BY TotalContinentCases DESC;

--Countries with >1M cases--

SELECT 
dc.country,
MAX(cc.total_cases) AS TotalCases
FROM PortfolioProject.dbo.DimCountry AS dc
JOIN PortfolioProject.dbo.CovidCasesDaily AS cc
ON dc.code = cc.code
GROUP BY dc.country
HAVING MAX(total_cases) >1000000
ORDER BY TotalCases DESC;

--Rank countries by cases

SELECT
country,
TotalCases,
RANK() OVER (ORDER BY TotalCases DESC) AS CountryRank
FROM

(SELECT 
dc.country,MAX(cc.total_cases)AS TotalCases
FROM PortfolioProject.dbo.DimCountry AS dc
JOIN PortfolioProject.dbo.CovidCasesDaily AS cc
ON dc.code = cc.code
GROUP BY country)
AS CountryCases;

--Top 3 countries within each continent by total cases

WITH CountryCases AS (
    SELECT 
        dc.continent,
        dc.country,
        MAX(cc.total_cases) AS TotalCases
    FROM PortfolioProject.dbo.DimCountry AS dc
    JOIN PortfolioProject.dbo.CovidCasesDaily AS cc
        ON dc.code = cc.code
    GROUP BY dc.continent, dc.country
),
RankedCountries AS (
    SELECT 
        continent,
        country,
        TotalCases,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY TotalCases DESC) AS CountryRank
    FROM CountryCases
)
SELECT 
    continent,
    country,
    TotalCases,
    CountryRank
FROM RankedCountries
WHERE CountryRank <= 3
ORDER BY continent, CountryRank;

















