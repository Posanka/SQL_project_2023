
-- Kolik je možné si koupit litrů mléka a kilogramů chleba
-- za první a poslední srovnatelné období v dostupných datech cen a mezd?
SELECT *
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cpc.name = 'Mléko polotučné pasterované'
-- 	AND cpc.name = 'Chléb konzumní kmínový'
-- 	AND cr.name = 'Hlavní město Praha'
-- 	AND cp2.date_from > STR_TO_DATE('2012-01-01', '%Y-%m-%d')
-- 	AND cp2.date_to < STR_TO_DATE('2012-12-31', '%Y-%m-%d')
	ORDER BY cp2.date_from DESC 
	;

SELECT *
FROM czechia_price_category cpc
WHERE cpc.name LIKE '%chleb%';

SELECT *
FROM czechia_price_category cpc
WHERE cpc.name LIKE '%mleko%';

-- 2006, 1. kvartal. prumerna mzda za vsechna odvetvi
-- vysledek 19 252 CZK
SELECT AVG(cp.value) value_2006
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code  
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code  = cpib.code 
JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code
WHERE cp.payroll_year = 2006
 	AND cp.payroll_quarter = 1
	AND cpc.name = 'fyzický' 
	AND cpvt.name = 'Průměrná hrubá mzda na zaměstnance'
	AND cp.value IS NOT NULL 	
;

-- 2018, 4. kvartal. prumerna mzda za všechna odvetvi
-- vysledek 33 902CZK
SELECT AVG(cp.value) value_2018 
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code  
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code  = cpib.code 
JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code
WHERE cp.payroll_year = 2018
 	AND cp.payroll_quarter = 4
	AND cpc.name = 'fyzický'
	AND cpvt.name = 'Průměrná hrubá mzda na zaměstnance'
	AND cp.value IS NOT NULL 	
;

-- prumerna cena za litr mleka v prvnim obdobi (prumer za vsechny regiony) = 14.27
SELECT AVG(cp2.value)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cpc.name = 'Mléko polotučné pasterované'
	AND cp2.date_from = '2006-01-02'
-- 	AND cpc.name = 'Chléb konzumní kmínový'
-- 	AND cr.name = 'Hlavní město Praha'
-- 	AND cp2.date_from > STR_TO_DATE('2012-01-01', '%Y-%m-%d')
-- 	AND cp2.date_to < STR_TO_DATE('2012-12-31', '%Y-%m-%d')
;

-- prumerna cena za litr mleka v poslednim obdobi (prumer za vsechny regiony) = 19.55
SELECT AVG(cp2.value)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cpc.name = 'Mléko polotučné pasterované'
	AND cp2.date_from = '2018-12-10'
;
	
-- prumerna cena za kilo chleba v prvnim obdobi (prumer za vsechny regiony) = 14.90
SELECT AVG(cp2.value)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cpc.name = 'Chléb konzumní kmínový'
	AND cp2.date_from = '2006-01-02'
;


-- prumerna cena za kilo chleba v poslednim obdobi (prumer za vsechny regiony) = 24.74
SELECT AVG(cp2.value)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cpc.name = 'Chléb konzumní kmínový'
	AND cp2.date_from = '2018-12-10'
;


SELECT *
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cpc.name = 'Mléko polotučné pasterované'
	ORDER BY cp2.date_from 
;


--  v roce 2006 jsme si mohli koupit 1349 litrů mléka a v roce 2018 1734 litrů mléka
--  v roce 2006 jsme si mohli koupit 1292 kilo chleba a v roce 2018 1378 kilo chleba.

SELECT 
	19252 / 14.27 AS milk_2006,
	33902/19.55 AS milk_2018,
	19252/14.9 AS bread_2006,
	33902/24.74 AS bread_2018;

