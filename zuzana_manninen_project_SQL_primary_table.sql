
-- t_zuzana_manninen_project_SQL_primary_final 
-- pro data mezd a cen potravin za Českou republiku sjednocených 
-- na totožné porovnatelné období – společné roky)

CREATE OR REPLACE TABLE t_zuzana_manninen_project_sql_primary_final
WITH price_growth AS (
	-- nárůst cen potravin
	WITH last_avg_price_year AS (
		SELECT YEAR(cp2.date_from) AS y, cp2.date_from, AVG(cp2.value) AS avg_price
		FROM czechia_price cp2
		WHERE cp2.date_from IN (
			SELECT max(cp2.date_from) AS latest_obs
			FROM czechia_price cp2
			GROUP BY YEAR(cp2.date_from)
		)
		GROUP BY cp2.date_from
	)
	SELECT
		price_y2.y AS price_y2,
		price_y1.y AS price_y1,
		price_y2.avg_price AS price_y2_value,
		price_y1.avg_price AS price_y1_value,
		price_y2.avg_price - price_y1.avg_price AS price_diff,
		round((price_y2.avg_price - price_y1.avg_price) / price_y1.avg_price * 100, 0) AS price_diff_prc
	FROM last_avg_price_year price_y1
	JOIN last_avg_price_year price_y2
		ON price_y2.y -1 = price_y1.y
),
payroll_growth AS (
	-- růst mezd
	WITH last_avg_payroll_year AS (
		SELECT cp.payroll_year AS y, AVG(cp.value) payroll
		FROM czechia_payroll cp 
		JOIN czechia_payroll_calculation cpc 
			ON cp.calculation_code = cpc.code  
		JOIN czechia_payroll_industry_branch cpib 
			ON cp.industry_branch_code  = cpib.code 
		JOIN czechia_payroll_unit cpu 
			ON cp.unit_code = cpu.code 
		JOIN czechia_payroll_value_type cpvt 
			ON cp.value_type_code = cpvt.code
		WHERE cp.payroll_quarter = 4
			AND cpc.name = 'fyzický'
			AND cpvt.name = 'Průměrná hrubá mzda na zaměstnance'
			AND cp.value IS NOT NULL 
		GROUP BY cp.payroll_year
	)
	SELECT
		payroll_y2.y AS payroll_y2,
		payroll_y1.y AS payroll_y1,
		payroll_y2.payroll AS payroll_y2_value,
		payroll_y1.payroll AS payroll_y1_value,
		payroll_y2.payroll - payroll_y1.payroll AS payroll_diff,
		round((payroll_y2.payroll - payroll_y1.payroll) / payroll_y1.payroll * 100, 0) AS payroll_diff_prc
	FROM last_avg_payroll_year payroll_y1
	JOIN last_avg_payroll_year payroll_y2
		ON payroll_y2.y -1 = payroll_y1.y
),
gdp_growth AS (
	SELECT e.country, 
		e.GDP, 
		e.`year` AS gdp_y1, 
		e2.`year` AS gdp_y2, 
		round((e2.GDP - e.GDP)/e.GDP*100, 0) AS gdp_diff_prc
	FROM economies e
	JOIN economies e2 
		ON e.country = e2.country 
		AND e.`year` = e2.`year`-1
	WHERE e.country LIKE '%czech%'
	AND e.YEAR BETWEEN 2006 AND 2018
)
SELECT price_growth.price_y1, 
	price_growth.price_y2, 
	price_growth.price_diff_prc, 
	payroll_growth.payroll_diff_prc, 
	gdp_growth.GDP_diff_prc
FROM price_growth 
JOIN payroll_growth
	ON price_growth.price_y1 = payroll_growth.payroll_y1
JOIN gdp_growth 
	ON price_growth.price_y1 = gdp_growth.gdp_y1
;

-- po vytvoření tabulky se všemi relevantními daty spustíme select
SELECT *
FROM t_zuzana_manninen_project_sql_primary_final;





