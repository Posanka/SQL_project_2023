
-- První otázka – za sledované období 2000 – 2020 v České republice 
-- vzrostly mzdy ve všech sledovaných odvětvích
SELECT y2000.*, y2021.*, y2021.value_2021 - y2000.value_2000 AS rozdil
FROM (
	SELECT cp.value value_2000, cpib.name
	FROM czechia_payroll cp 
	JOIN czechia_payroll_calculation cpc 
		ON cp.calculation_code = cpc.code  
	JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code  = cpib.code 
	JOIN czechia_payroll_unit cpu 
		ON cp.unit_code = cpu.code 
	JOIN czechia_payroll_value_type cpvt 
		ON cp.value_type_code = cpvt.code
	WHERE cp.payroll_year = 2000
	 	AND cp.payroll_quarter = 1
		AND cpc.name = 'fyzický'
		AND cpvt.name = 'Průměrná hrubá mzda na zaměstnance'
		AND cp.value IS NOT NULL 		
) as y2000
JOIN (
	SELECT cp.value value_2021, cpib.name
	FROM czechia_payroll cp 
	JOIN czechia_payroll_calculation cpc 
		ON cp.calculation_code = cpc.code  
	JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code  = cpib.code 
	JOIN czechia_payroll_unit cpu 
		ON cp.unit_code = cpu.code 
	JOIN czechia_payroll_value_type cpvt 
		ON cp.value_type_code = cpvt.code
	WHERE cp.payroll_year = 2021
	 	AND cp.payroll_quarter = 1
		AND cpc.name = 'fyzický'
		AND cpvt.name = 'Průměrná hrubá mzda na zaměstnance'
		AND cp.value IS NOT NULL 		
) as y2021
	ON y2000.name = y2021.name
;
