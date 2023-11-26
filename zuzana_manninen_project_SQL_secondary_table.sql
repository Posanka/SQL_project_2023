
-- t_zuzana_manninen_project_SQL_secondary_final 
-- pro dodatečná data o dalších evropských státech

CREATE TABLE t_zuzana_manninen_project_sql_secondary_final 
SELECT e.country, 
	e.GDP, 
	e.`year` AS gdp_y1, 
	e2.`year` AS gdp_y2, 
	round((e2.GDP - e.GDP)/e.GDP*100, 0) AS gdp_diff_prc
FROM economies e
JOIN economies e2 
	ON e.country = e2.country 
	AND e.`year` = e2.`year`-1
JOIN countries c 
	ON e.country = c.country
WHERE c.continent = 'Europe'
AND e.YEAR BETWEEN 2006 AND 2018;

SELECT *
FROM t_zuzana_manninen_project_sql_secondary_final;

-- po vytvoření tabulky se všemi relevatními daty spustíme select
SELECT *
FROM t_zuzana_manninen_project_sql_secondary_final
WHERE gdp_diff_prc IS NOT NULL 
ORDER BY gdp_diff_prc ;

