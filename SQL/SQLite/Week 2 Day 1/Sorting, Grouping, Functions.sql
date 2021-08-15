/*1. Write SQL query to sum all the funding AmountinUSD, where City location equals “Bengaluru”*/
SELECT SUM(AmountinUSD) FROM indian_startup_funding WHERE CityLocation = 'Bengaluru';

/*2. Write SQL query to sort the table by startup name DESC*/
SELECT * FROM indian_startup_funding ORDER BY LOWER(StartupName) DESC;

/*3. Write SQL query to sum all the funding AmountinUSD, where City location equals “Bengaluru”
and AmountinUSD>380000*/
SELECT SUM(AmountinUSD) FROM indian_startup_funding 
	WHERE CityLocation = 'Bengaluru' AND AmountinUSD>380000;

/*4. Write SQL query to get all CityLocations that has an AmountinUSD >380000*/
SELECT CityLocation FROM indian_startup_funding  WHERE AmountinUSD>380000;

/*5. Write SQL query to get only unique CityLocations that has an AmountinUSD >380000*/
SELECT DISTINCT CityLocation FROM indian_startup_funding  WHERE AmountinUSD>380000;

/*6. Write SQL query to get all StartupNames where AmountinUSD<380000*/
SELECT StartupName FROM indian_startup_funding  WHERE AmountinUSD<380000;

/*7. Write SQL query to sort the output from the previous question DESC*/
SELECT StartupName FROM indian_startup_funding  WHERE AmountinUSD<380000 
	ORDER BY AmountinUSD DESC;

/*8. Write SQL query to get the City location that has the maximum funding amount “Note that is the
data is not cleaned properly you will get non logical result”*/
SELECT CityLocation, MAX(AmountinUSD) FROM indian_startup_funding GROUP BY CityLocation 
	ORDER BY MAX(AmountinUSD) DESC LIMIT 1 OFFSET 3;

/*9. Write SQL query to get the total funding AmountinUSD for each IndustryVertical*/
SELECT IndustryVertical, SUM(AmountinUSD) FROM indian_startup_funding GROUP BY IndustryVertical;

/*10. Write SQL query to get the total funding AmountinUSD for each IndustryVertical that starts with
letter “A”*/
SELECT IndustryVertical, SUM(AmountinUSD) FROM indian_startup_funding 
		WHERE IndustryVertical LIKE 'A%' GROUP BY IndustryVertical;
		
/*11. Write SQL query to get the total funding AmountinUSD for each IndustryVertical that starts with
letter “A” and sort the output DESC by the total AmountinUSD*/
SELECT IndustryVertical, SUM(AmountinUSD) FROM indian_startup_funding 
		WHERE IndustryVertical LIKE 'A%' GROUP BY IndustryVertical ORDER BY SUM(AmountinUSD) DESC;
		
/*12. Write SQL query to count all the start_ups in the Education field*/
SELECT COUNT(StartupName) FROM indian_startup_funding WHERE IndustryVertical LIKE 'Ed%';

/*13. Write SQL query to count all the start_Ups in the E-Commerce field*/
SELECT COUNT(StartupName) FROM indian_startup_funding WHERE IndustryVertical = 'E-commerce';

/*14. Write SQL query to count all the start_Ups in the E-Commerce field, where city location equals
“Bengaluru”*/
SELECT COUNT(StartupName) FROM indian_startup_funding 
	WHERE IndustryVertical = 'E-commerce' AND CityLocation = 'Bengaluru';
	
/*15. For each Industry Vertical find the total funding amount*/
SELECT IndustryVertical, SUM(AmountinUSD) FROM indian_startup_funding GROUP BY IndustryVertical;

/*16. For each Industry Vertical find the total funding amount as “Total_fund” and the average
funding amount as “Avg_Fund”. In this question provide two answer 1- using group by Industry
Vertical, 2- using sub_queries*/
SELECT IndustryVertical, SUM(AmountinUSD) AS Total_fund,  AVG(AmountinUSD) AS Avg_Fund
	FROM indian_startup_funding GROUP BY IndustryVertical;
	


/*17. Write SQL query to get the minimum value of funding for the “Uniphore” start_up*/
SELECT MIN(AmountinUSD) FROM indian_startup_funding WHERE StartupName = 'Uniphore';

/*18. Write SQL query to get the length of the city location names*/
SELECT DISTINCT LENGTH(CityLocation), CityLocation FROM indian_startup_funding;

/*19. Write SQL query to convert start_ups names into uppercase if the funding amount is >380,000*/
SELECT UPPER(StartupName) FROM indian_startup_funding WHERE AmountinUSD>380000;

/*20. Write SQL query to select distinct industry vertical names, knowing that names are mix of
lowercase and uppercase values.*/
SELECT DISTINCT StartupName FROM indian_startup_funding;