
-- Question 6

SELECT v.vin, v.year, v.make, v.model, v.price, v.SOLD, s.id, s.customerName, s.sale_date_and_time, i.dealership_id,
		(SELECT name FROM dealerships WHERE dealership_id = 1236) AS dealership_name
FROM vehicles v
INNER JOIN sales_contracts s ON v.vin = s.vin
INNER JOIN inventory i ON v.vin = i.vin
WHERE i.dealership_id = 1236 AND (s.sale_date_and_time BETWEEN "2022-06-12 10:55:11" AND now());