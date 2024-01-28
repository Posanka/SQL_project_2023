-- První otázka – za sledované období 2000 – 2020 v České republice 
-- vzrostly mzdy ve všech sledovaných odvětvích
-- nepoužila jsem primární tabulku, protože v ní nemám zahrnuté mzdy na úrovni odvětví, pouze roční mzdy
-- výsledky jsem si vyexportovala do excelu, kde v grafu bylo lépe vidět, jak mzdy rostly a kdy případně došlo k poklesu

SELECT cp.payroll_year, cpib.name, ROUND(AVG(cp.value),0) AS avg_mzdy
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
GROUP BY cp.payroll_year, cpib.name
ORDER BY name, payroll_year;	

-- konec dotazu k otázce 1

SELECT cp.payroll_year, ROUND(AVG(cp.value),0) AS avg_mzdy
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
ORDER BY cp.payroll_year;	








