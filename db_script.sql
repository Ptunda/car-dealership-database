
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
    price DECIMAL(15, 2)
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