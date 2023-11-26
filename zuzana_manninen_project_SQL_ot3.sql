-- ktera kategorie  potravin zdrazuje nejpomaleji

-- rok  2018
SELECT cpc.name, AVG(cp2.value)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cp2.date_from = '2018-12-10'
-- 	AND cpc.name = 'Mléko polotučné pasterované'
-- 	AND cpc.name = 'Chléb konzumní kmínový'
-- 	AND cr.name = 'Hlavní město Praha'
-- 	AND cp2.date_from > STR_TO_DATE('2012-01-01', '%Y-%m-%d')
-- 	AND cp2.date_to < STR_TO_DATE('2012-12-31', '%Y-%m-%d')
GROUP BY cpc.name
;

-- rok  2006
SELECT cpc.name, AVG(cp2.value)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
WHERE cp2.date_from = '2006-12-04'
GROUP BY cpc.name
;

-- rok  2006
SELECT cpc.name, MIN(cp2.date_from)
FROM czechia_price cp2
JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
JOIN czechia_region cr
	ON cp2.region_code = cr.code
GROUP BY cpc.name
ORDER BY MIN(cp2.date_from)
;

-- Která kategorie potravin zdražuje nejpomaleji 
-- (je u ní nejnižší percentuální meziroční nárůst)?
SELECT category_prices_2018.name,
	category_prices_2006.price_2006,
	category_prices_2018.price_2018, 
	round(category_prices_2018.price_2018 - category_prices_2006.price_2006,2) AS diff,
	round((category_prices_2018.price_2018 - category_prices_2006.price_2006)/category_prices_2006.price_2006*100,0) AS diff_percentage
FROM (
-- rok  2018
	SELECT cpc.name, AVG(cp2.value) AS price_2018
	FROM czechia_price cp2
	JOIN czechia_price_category cpc 
		ON cp2.category_code = cpc.code 
	JOIN czechia_region cr
		ON cp2.region_code = cr.code
	WHERE cp2.date_from = '2018-12-10'
	GROUP BY cpc.name
) AS category_prices_2018
JOIN (
-- rok  2006
	SELECT cpc.name, AVG(cp2.value) AS price_2006
	FROM czechia_price cp2
	JOIN czechia_price_category cpc 
		ON cp2.category_code = cpc.code 
	JOIN czechia_region cr
		ON cp2.region_code = cr.code
	WHERE cp2.date_from = '2006-12-04'
	GROUP BY cpc.name
) AS category_prices_2006
	ON category_prices_2018.name = category_prices_2006.name	
ORDER BY round((category_prices_2018.price_2018 - category_prices_2006.price_2006)/category_prices_2006.price_2006*100,0) DESC 
;


