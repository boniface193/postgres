/* Database schema to keep the structure of entire database. */

-- Database: vet_clinic

-- DROP DATABASE IF EXISTS vet_clinic;

CREATE TABLE animals(id INT PRIMARY NOT NULL, name VARCHAR(255), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL(4,0));