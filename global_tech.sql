use startup ; 
-- total startups 
select count(*) from ai;

--  Duplicate Company_ID 
select Company_ID, count(*) as duplicate_count from ai group by Company_ID having count(*) >1;
 
 -- Duplicate records details 
select * from ai where Company_ID in (select Company_ID from ai group by Company_ID having count(*)> 1 ) order by Company_ID;
select count(*) as total_rows,count(distinct Company_ID) as unique_comapanies from ai;

-- Top 10 Domains
select Domain, count(*) as startup_count from ai group by Domain order by startup_count desc limit 10; 

-- Top 10 Countries
select Country , count(*) as startup_count from ai group by Country order by startup_count desc limit 10 ;

--  Top 10 Cities
select City, count(*) as startup_count from ai group by City order by startup_count desc limit 10 ;

--   Funding Stage Distribution
select Funding_Stage, count(*) as startup_count from ai group by Funding_Stage order by startup_count desc;

--  Funding Year Trend
select Founding_Year, count(*) as startup_count from ai group by Founding_Year order by Founding_Year desc;

-- Funding Stage with Average Funding  
select Funding_Stage, count(*) as startup_count,
round(avg(Total_Funding_USD_millions),2) as avg_funding from ai
 group by Funding_Stage order by avg_funding desc;
 
 -- Funding Stage with Median Funding 
 select Funding_Stage, round(min(total_Funding_USD_Millions),2) as min_funding, round(max(Total_Funding_USD_Millions),2) as max_funding, 
round(avg(Total_Funding_USD_Millions),2) as avg_funding from ai group by Funding_Stage order by avg_funding desc;

-- Funding vs Valuation
select round(sum(Total_Funding_USD_Millions),2)as total_funding_millions, round(avg(Total_Funding_USD_Millions),2) as avg_funding_millions, 
round(sum(Valuation_USD_Millions),2)as total_valuation_million, round(avg(Valuation_USD_Millions),2) as avg_valuation_million from ai;

-- Top 10 Highest Valued Startups
select Company_ID, Domain,Country,Funding_Stage, 
Total_Funding_USD_Millions, Valuation_USD_millions from ai order by Valuation_USD_Millions desc limit 10; 

-- Top Highest Funded Startups
select Company_ID, Domain,Country,Funding_Stage,
Total_Funding_USD_Millions, Valuation_USD_Millions from ai order by Total_Funding_USD_Millions desc limit 10;

-- Investor Tier Analysis 
select Investor_Tier, count(*) as startup_count, round(avg(Total_Funding_USD_Millions),2) as avg_funding, round(avg(Valuation_USD_Millions),2) as avg_valuation from ai 
group by Investor_Tier order by avg_funding desc;

--  AI Adoption Distribution 
select AI_Adoption_Level, count(*)as startup_count from ai group by AI_Adoption_Level order by startup_count desc;

-- AI Adoption vs Funding
select AI_Adoption_Level,count(*) as startup_count, round(avg(Total_Funding_USD_Millions),2) as avg_funding, round(avg(Valuation_USD_Millions),2)as avg_valuation 
from ai group by AI_Adoption_Level order by avg_funding desc; 

-- Burn Rate with Runway by Funding Stage 
select Funding_Stage, count(*) as startup_count, round(avg(Monthly_Burn_Rate_Millions),2) as avg_burn_rate, 
round(avg(Runway_Months_2024),2) as avg_runway from ai group by Funding_Stage order by avg_burn_rate desc;

-- Acquisition Status
select Acquisition_Status, count(*) as startup_count, round(avg(Valuation_USD_Millions),2) as avg_valuation from ai 
group by Acquisition_Status order by startup_count desc;

--  Workforce Change by Funding Stage 
select Funding_Stage, count(*) as startup_count, round(avg(Peak_Headcount_2023),0)as avg_peak_headcount, 
round(avg(Current_Headcount_2026),0) as avg_current_headcount, round(avg(Headcount_Change),0) as avg_headcount_change from ai
 group by Funding_Stage order by avg_headcount_change;
 
 -- Layoffs by Funding Stage 
 select Funding_Stage, sum(Layoffs_2024_2025) as total_layoffs, 
 round(avg(Layoffs_2024_2025),2) as avg_layoffs from ai group by Funding_Stage order by total_layoffs desc;
 
 -- Top 10 Startups by Layoffs
 select Company_ID, Domain, Country,Funding_Stage,Peak_Headcount_2023,
 Current_Headcount_2026,Layoffs_2024_2025,Headcount_Change from ai order by Layoffs_2024_2025 desc limit 10;
 
 --  Financial Health - Burn vs Runway
 select Funding_Stage, round(avg(Monthly_Burn_Rate_Millions),2) as avg_monthly_burn, 
round(avg(Runway_Months_2024),2) as avg_runway,
round(avg(Monthly_Burn_Rate_Millions * Runway_Months_2024),2) as avg_cash_requirement
 from ai group by Funding_Stage order by avg_cash_requirement desc;
 
 -- Overall Business Snapshot
 select count(*) as total_startups, count(distinct Company_ID) as unique_companies, 
round(avg(Total_Funding_USD_Millions),2) as avg_funding, 
round(avg(Valuation_USD_Millions),2) as avg_valuation, 
round(avg(Revenue_ARR_Millions),2) as avg_revenue_arr, 
round(avg(Runway_Months_2024),2) as avg_runway, 
sum(Layoffs_2024_2025) as total_layoffs, 
sum(Current_Headcount_2026) as total_current_headcount from ai;


-- 5 Business Questions
-- 1 Highest Average Funding with Funding Stage
select Funding_Stage , round(avg(Total_Funding_USD_Millions),2) as
 avg_funding from ai group by Funding_Stage order by avg_funding desc limit 1;  
 
--  2 Highest Average Valuation with Domain
select Domain, round(avg(Valuation_USD_Millions),2) as
 avg_Valuation from ai group by Domain order by avg_Valuation desc limit 10;

-- 3 Which Average Funding Stage 
select Funding_Stage, round(avg(Headcount_Change),2) as 
avg_headcount_change from ai group by Funding_Stage order by avg_headcount_change asc limit 1;

-- 4 AL Adoption Level with Average Highest Funding
select AI_Adoption_Level, round(avg(Total_Funding_USD_Millions),2) as
 avg_funding from ai group by AI_Adoption_Level order by avg_funding desc;
 
-- 5 Top 10 Countries - Startups + Average Funding
select Country, count(*) as startup_count, round(avg(Total_Funding_USD_Millions),2) as avg_funding from ai 
group by Country order by startup_count desc limit 10;
   
