#1.Year-wise Trend of Rice Production Across States (Top 3)
	Select * from (
	Select year,statename,sum(rice_production) riceproduction,row_number() over (partition by year
	order by sum(rice_production) desc,statename) rowno
	 from agriinfo group by year,statename 
	 ) f where rowno <=3; 
	 
	Select * from (
	Select year,statename,sum(rice_production) riceproduction,dense_rank() over (partition by year
	order by sum(rice_production) desc) rowno
	 from agriinfo group by year,statename 
	 ) f where rowno <=3 order by year asc,rowno asc;
 
#2.Top 5 Districts by Wheat Yield increase Over the Last 5 Years
	Select * from
    (
    Select year,district_name,avg(wheat_yield) wheatyield ,
    row_number() over (partition by year order by avg(wheat_yield) desc) rono
    from agriinfo 
    where year >= ( Select max(year)-5 from agriinfo)
    group by year, district_name
    ) j where rono  <= 5
    order by year asc;

#3.States with the Highest Growth in Oilseed Production (5-Year Growth Rate)
	Select 
		a1.statename, 
		sum(a1.oilseeds_production) AS latest_production, 
		sum(a2.oilseeds_production) AS old_production,
		((sum(a1.oilseeds_production) - sum(a2.oilseeds_production)) / sum(a2.oilseeds_production)) * 100 AS growth_rate
	from Agriinfo a1
	JOin Agriinfo a2 
	ON a1.statename = a2.statename
	WHERE a1.year = (Select max(year) from Agriinfo) 
	AND a2.year = (Select max(year) - 5 from Agriinfo)
	group by a1.statename
	ORDER BY growth_rate DESC
	LIMIT 5;


#4.District-wise Correlation Between Area and Production for Major Crops (Rice, Wheat, and Maize)
	Select 
    district_name,
    (sum(rice_area * rice_production) - (sum(rice_area) * sum(rice_production)) / COUNT(*)) /
    (SQRT(sum(rice_area * rice_area) - (sum(rice_area) * sum(rice_area)) / COUNT(*)) *
     SQRT(sum(rice_production * rice_production) - (sum(rice_production) * sum(rice_production)) / COUNT(*))) 
     AS rice_correlation,

    (sum(wheat_area * wheat_production) - (sum(wheat_area) * sum(wheat_production)) / COUNT(*)) /
    (SQRT(sum(wheat_area * wheat_area) - (sum(wheat_area) * sum(wheat_area)) / COUNT(*)) *
     SQRT(sum(wheat_production * wheat_production) - (sum(wheat_production) * sum(wheat_production)) / COUNT(*))) 
     AS wheat_correlation,

    (sum(maize_area * maize_production) - (sum(maize_area) * sum(maize_production)) / COUNT(*)) /
    (SQRT(sum(maize_area * maize_area) - (sum(maize_area) * sum(maize_area)) / COUNT(*)) *
     SQRT(sum(maize_production * maize_production) - (sum(maize_production) * sum(maize_production)) / COUNT(*))) 
     AS maize_correlation

from Agriinfo
group by district_name
ORDER BY district_name;



#5.Yearly Production Growth of Cotton in Top 5 Cotton Producing States

WITH TopCottonStates AS (
    SELECT statename
    FROM (
        SELECT statename, SUM(cotton_production) AS total_cotton
        FROM AgriInfo
        GROUP BY statename
        ORDER BY total_cotton DESC
        LIMIT 5
    ) AS RankedStates
),
YearlyProduction AS (
    SELECT year, statename, SUM(cotton_production) AS total_production
    FROM AgriInfo
    WHERE statename IN (SELECT statename FROM TopCottonStates)
    GROUP BY year, statename
)
SELECT c1.year, c1.statename, c1.total_production,
       ((c1.total_production - c2.total_production) / c2.total_production) * 100 AS growth_rate
FROM YearlyProduction c1
LEFT JOIN YearlyProduction c2
ON c1.statename = c2.statename AND c1.year = c2.year + 1
ORDER BY c1.statename, c1.year;

#6.Districts with the Highest Groundnut Production in 2020
Select district_name, sum(groundnut_production) AS total_production
from Agriinfo
WHERE year = 2020
group by district_name
ORDER BY total_production DESC;

#7.Annual Average Maize Yield Across All States
Select statename, AVG(maize_yield) AS avg_yield
from Agriinfo
group by statename
ORDER BY avg_yield DESC;

#8.Total Area Cultivated for Oilseeds in Each State

Select statename, sum(oilseeds_area) AS total_area
from Agriinfo
group by statename
ORDER BY total_area DESC;


#9.Districts with the Highest Rice Yield

SELECT district_name, 
       SUM(rice_production) / NULLIF(SUM(rice_area), 0) AS avg_rice_yield
FROM AgriInfo
GROUP BY district_name
ORDER BY avg_rice_yield DESC;

#10.Compare the Production of Wheat and Rice for the Top 5 States Over 10 Years

	with TopStates AS (
		Select statename
		from (
			Select statename, sum(wheat_production + rice_production) AS total_production
			from Agriinfo
			WHERE year >= (Select max(year) - 10 from Agriinfo)
			group by statename
			order by total_production desc
			limit 5
		) as top_states
	)
	Select year, statename, 
		   sum(rice_production) as rice_production, 
		   sum(wheat_production) as wheat_production
	from Agriinfo
	WHERE statename in (Select statename from TopStates)
	AND year >= (Select max(year) - 10 from Agriinfo)
	group by year, statename
	order by year,statename 

