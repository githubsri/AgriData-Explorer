#1 Top 7 RICE PRODUCTION State Data(Bar_plot)
	select statename,sum(rice_production) total_production
	from agriinfo group by statename order by total_production desc limit 7;

# 2Top 5 Wheat Producing States Data(Bar_chart)and its percentage(%)(Pie_chart)
	select statename,sum(wheat_production) totalProduction from agriinfo
	group by statename order by totalProduction desc limit 5;

#3 Oil seed production by top 5 state
	select statename,sum(oilseeds_production) totalProduction from agriinfo
	group by statename order by totalProduction desc limit 5;



# 4 Top 7 SUNFLOWER PRODUCTION  State
	select statename,sum(sunflower_production) totalProduction from agriinfo
	group by statename order by totalProduction desc limit 7;

# 5 India's SUGARCANE PRODUCTION From Last 50 Years(Line_plot)

	select year, SUM(sugarcane_production) AS total_production 
	FROM AgriInfo GROUP BY year ORDER BY year DESC LIMIT 50 ;

#Rice Production Vs Wheat Production (Last 50y)

	select year, SUM(rice_production) rice_production, SUM(wheat_production) wheat_production
	FROM AgriInfo GROUP BY year ORDER BY year DESC LIMIT 50;

#Rice Production By West Bengal Districts

	select district_name, SUM(rice_production) AS total_production 
	FROM AgriInfo WHERE statename= 'West Bengal' GROUP BY district_name ORDER BY total_production DESC;

#Top 10 Wheat Production Years From UP
	select year, SUM(wheat_production) AS total_production 
	FROM AgriInfo WHERE statename= 'Uttar Pradesh' GROUP BY year ORDER BY total_production DESC limit 10;

#Millet Production (Last 50y)

	select year,SUM(pearl_millet_production) AS total_production 
	FROM AgriInfo  group by year ORDER BY total_production DESC limit 50;

#Sorghum Production (Kharif and Rabi) by Region
	select statename,sum(kharif_sorghum_production) Kharif,sum(rabisorghum_production) Rabi from agriinfo
	group by statename order by statename;


# Top 7 States for Groundnut Production
	select statename,sum(groundnut_production) Total_Production from agriinfo
	group by statename order by Total_Production desc limit 7;


#Soybean Production by Top 5 States and Yield Efficiency
	select statename,sum(soyabean_production) Total_Production,avg(soyabean_yield) Average_yield from agriinfo
	group by statename order by Total_Production desc limit 5;


#Oilseed Production in Major States

	select statename,sum(oilseeds_production) Total_Production from agriinfo
	group by statename order by Total_Production desc ;

#Impact of Area Cultivated on Production (Rice, Wheat, Maize)
	select year,sum(rice_area) ,sum(rice_production),
    sum(wheat_area) ,sum(wheat_production),sum(maize_area),sum(maize_production) 
    from Agriinfo group by year order by year ;
    

#Rice vs. Wheat Yield Across States

	select statename,avg(rice_yield) ,avg(wheat_yield) 
    from Agriinfo group by statename order by statename ;
