
-- Question 2

SELECT i.dealership_id, i.vin, d.name, d.address, v.make, v.model, v.SOLD
FROM inventory i
INNER JOIN dealerships d ON i.dealership_id = d.dealership_id
INNER JOIN vehicles v ON i.vin = v.vin
WHERE i.dealership_id = 1234;