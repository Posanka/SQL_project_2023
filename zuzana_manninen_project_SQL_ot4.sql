
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin
-- výrazně vyšší než růst mezd (větší než 10 %)?
SELECT price_y1, price_y2, price_diff_prc, payroll_diff_prc 
FROM t_zuzana_manninen_project_sql_primary_final tzmpspf;
WHERE price_diff_prc - payroll_diff_prc > 10; 
