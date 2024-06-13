
-- Creating dealershipDB and providing related tables

DROP DATABASE IF EXISTS dealershipDB;
CREATE DATABASE dealershipDB;


USE dealershipDB;


DROP TABLE IF EXISTS dealerships;
CREATE TABLE dearlerships(
	dealership_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	phone VARCHAR(12) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS vehicles;
CREATE TABLE vehicles(
	vin INT PRIMARY KEY,
    year INT NOT NULL,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
    type VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    odometer INT,
    price DECIMAL(15, 2),
    CONSTRAINT price_check CHECK(price > 0.00)
);
ALTER TABLE vehicles
ADD COLUMN SOLD BOOLEAN DEFAULT 0;

ALTER TABLE vehicles
ADD CONSTRAINT
chk_year CHECK(year >= 1886 AND year <= 2024);


DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory(
	dealership_id INT,
    vin INT,
    CONSTRAINT fk_id_dealership_id FOREIGN KEY(dealership_id) REFERENCES dealerships(dealership_id)
);
ALTER TABLE inventory
ADD CONSTRAINT
fk_iv_vin FOREIGN KEY(vin) REFERENCES vehicles(vin);


DROP TABLE IF EXISTS sales_contracts;
CREATE TABLE sales_contracts(
	id INT PRIMARY KEY AUTO_INCREMENT,
    customerName VARCHAR(50) NOT NULL,
    customerEmail VARCHAR(50) NOT NULL,
    vin INT,
    sale_date_and_time DATETIME,
    CONSTRAINT fk_scv_vin FOREIGN KEY(vin) REFERENCES vehicles(vin)
);


DROP TABLE IF EXISTS lease_contracts;
CREATE TABLE lease_contracts(
	id INT PRIMARY KEY AUTO_INCREMENT,
    customerName VARCHAR(50) NOT NULL,
    customerEmail VARCHAR(50) NOT NULL,
    vin INT,
    lease_date_and_time DATETIME,
    CONSTRAINT fk_lcv_vin FOREIGN KEY(vin) REFERENCES vehicles(vin)
);

-- populating and updating tables

-- pertaining to dealerships table
INSERT INTO dealerships(name, address, phone)
VALUES	('Car World', '123 Main St', '555-123-4567'),
		('Monroeville Best Cars', '5154 William Penn St', '555-555-5555'),
        ('Robinson New & Used Cars', 'Robinson Township', '555-123-5555'),
        ('Vibes Car World', '4707 Baum Blvd', '555-555-4567')
;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM dealerships;

ALTER TABLE dealerships
AUTO_INCREMENT = 1234;

INSERT INTO dealerships(name, address, phone)
VALUES	('Car World', '123 Main St', '555-123-4567'),
		('Monroeville Best Cars', '5154 William Penn St', '555-555-5555'),
        ('Robinson New & Used Cars', 'Robinson Township', '555-123-5555'),
        ('Vibes Car World', '4707 Baum Blvd', '555-555-4567')
;
SET SQL_SAFE_UPDATES = 1;

-- pertaining to vehicles table
ALTER TABLE vehicles
ADD COLUMN new BOOLEAN DEFAULT 0;

INSERT INTO vehicles (vin, year, make, model, type, color, odometer, price)
VALUES	(10234, 2015, 'Toyota', 'Camry', 'sedan', 'silver', 12000, 15995.99),
		(10567, 2018, 'Honda', 'Civic', 'sedan', 'black', 8000, 18995.99),
        (10987, 2017, 'Ford', 'Escape', 'SUV', 'white', 25000, 20995.99),
        (10999, 2024, 'Ford', 'Escape', 'SUV', 'blue', 15, 40995.99),
        (11000, 2018, 'Chevrolet', 'Malibu', 'sedan', 'red', 12000, 16995.99),
        (11111, 2019, 'Toyota', 'RAV4', 'SUV', 'blue', 10000, 27995.99)
;

ALTER TABLE vehicles
RENAME COLUMN new TO status;

UPDATE vehicles
SET status = 1
WHERE vin = 10999;

ALTER TABLE vehicles
ADD COLUMN electric BOOLEAN DEFAULT 0;

ALTER TABLE vehicles
MODIFY COLUMN SOLD BOOLEAN
AFTER electric;

UPDATE vehicles
SET electric = 1
WHERE vin = 10999;

INSERT INTO vehicles(vin, year, make, model, type, color, odometer, price, status, electric)
VALUES	(11133, 2024, 'Porsche', 'Taycan Turbo S', 'sedan', 'white', 0, 194499.99, 1, 1),
		(11233, 2022, 'Tesla', 'Model 3', 'sedan', 'red', 8000, 37998.99, 0, 1)
;

-- pertaining to inventory table
INSERT INTO inventory
VALUES	(1234, 10567),
		(1234, 10987),
        (1235, 10999),
        (1235, 11000),
        (1236, 11111),
        (1236, 11133),
        (1237, 11233),
        (1237, 10987)
;

-- pertaining to sales_contracts table
INSERT INTO sales_contracts(customerName, customerEmail, vin, sale_date_and_time)
VALUES	('Paul Tunda', 'pt@gmail.com', 11133, now()),		
		('Mikel Arteta', 'ma@gmail.com', 11111, now());
        
UPDATE vehicles
SET SOLD = 1
WHERE vin = 11133;

UPDATE vehicles
SET SOLD = 1
WHERE vin = 11111;

-- pertaining to lease_contracts table
INSERT INTO lease_contracts(customerName, customerEmail, vin, lease_date_and_time)
VALUES	('Dana Wyatt', 'dana@texas.com', 10999, now()),		
		('Zachary Westly', 'zach@texas.com', 10234, now());
        
UPDATE vehicles
SET SOLD = 1
WHERE vin = 10999;

UPDATE vehicles
SET SOLD = 1
WHERE vin = 10234;