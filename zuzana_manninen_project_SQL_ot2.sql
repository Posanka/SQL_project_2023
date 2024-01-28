
-- Otázka 2: Kolik je možné si koupit litrů mléka a kilogramů chleba
-- za první a poslední srovnatelné období v dostupných datech cen a mezd?


-- průměrná roční cena za litr mléka a kilo chleba v roce 2006 a 2018
CREATE OR REPLACE VIEW rocni_prum_potravin AS (
	SELECT YEAR(cp2.date_from) year, cpc.name, round(AVG(cp2.value), 2) AS avg_price
	FROM czechia_price cp2
	JOIN czechia_price_category cpc 
		ON cp2.category_code = cpc.code 
	JOIN czechia_region cr
		ON cp2.region_code = cr.code
	WHERE 1=1
	 	AND (cpc.name = 'Mléko polotučné pasterované'
		OR cpc.name = 'Chléb konzumní kmínový')
	GROUP BY YEAR(cp2.date_from), cpc.name 
);
SELECT * FROM rocni_prum_potravin;



-- průměrné mzdy
CREATE OR REPLACE VIEW rocni_prum_mzda AS (
	SELECT cp.payroll_year year, ROUND(AVG(cp.value),0) AS avg_mzdy
	FROM czechia_payroll cp 
	JOIN czechia_payroll_calculation cpc 
		ON cp.calculation_code = cpc.code  
	JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code  = cpib.code 
	JOIN czechia_payroll_unit cpu 
		ON cp.unit_code = cpu.code 
	JOIN czechia_payroll_value_type cpvt 
		ON cp.value_type_code = cpvt.code
	WHERE 1=1 
		AND cpc.name = 'fyzický'
		AND cpvt.name = 'Průměrná hrubá mzda na zaměstnance'
		AND cp.value IS NOT NULL
	GROUP BY cp.payroll_year
	ORDER BY payroll_year
);
SELECT * FROM rocni_prum_mzda;



-- spojíme mzdy a ceny

SELECT rpp.`year`, rpp.name, rpp.avg_price, rpm.avg_mzdy, round(rpm.avg_mzdy / rpp.avg_price, 0) kolik_za_mzdy
FROM rocni_prum_potravin rpp
JOIN rocni_prum_mzda rpm
	ON rpp.`year` = rpm.`year`
WHERE rpp.`year` IN (2006, 2018)
;




