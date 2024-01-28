-- Otázka 3: která kategorie  potravin zdražuje nejpomaleji ((je u ní nejnižší percentuální meziroční nárůst)?)


CREATE OR REPLACE VIEW rocni_prum_potravin AS (
	SELECT YEAR(cp2.date_from) year, cpc.name, round(AVG(cp2.value), 2) AS avg_price
	FROM czechia_price cp2
	JOIN czechia_price_category cpc 
		ON cp2.category_code = cpc.code 
	JOIN czechia_region cr
		ON cp2.region_code = cr.code
	WHERE 1=1
	GROUP BY YEAR(cp2.date_from), cpc.name 
);
SELECT * FROM rocni_prum_potravin;



CREATE OR REPLACE VIEW mezirocni_rust_potravin AS (
	SELECT
		rpp_1.`year` year1,
		rpp_2.`year` year2,
		rpp_1.name,
		rpp_1.avg_price price1,
		rpp_2.avg_price price2,
		round((rpp_2.avg_price - rpp_1.avg_price)/rpp_1.avg_price*100,0) price_change
	FROM rocni_prum_potravin rpp_1
	JOIN rocni_prum_potravin rpp_2
		ON rpp_1.`year` = rpp_2.`year` -1
		AND rpp_1.name = rpp_2.name
);

SELECT *
FROM mezirocni_rust_potravin mrp
ORDER BY mrp.price_change asc;



