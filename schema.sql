/* Database schema to keep the structure of entire database. */

-- Database: vet_clinic

-- DROP DATABASE IF EXISTS vet_clinic;

CREATE TABLE animals(id INT PRIMARY NOT NULL, name VARCHAR(255), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL(4,0));
CREATE TABLE owners (id serial PRIMARY KEY, full_name varchar(255), age integer);
CREATE TABLE species (id serial PRIMARY KEY, name varchar(255));
ALTER TABLE animals DROP COLUMN species, ADD COLUMN species_id integer, ADD COLUMN owner_id integer, ADD PRIMARY KEY (id), ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id), ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id);
CREATE TABLE vets (id serial PRIMARY KEY, name VARCHAR(255), age integer, date_of_graduation date);
CREATE TABLE specializations (vet_id integer, species_id integer, PRIMARY KEY (vet_id, species_id), FOREIGN KEY (vet_id) REFERENCES vets (id), FOREIGN KEY (species_id) REFERENCES species (id));
CREATE TABLE visits (animal_id integer, vet_id integer, visit_date date, PRIMARY KEY (animal_id, vet_id, visit_date), FOREIGN KEY (animal_id) REFERENCES animals (id), FOREIGN KEY (vet_id) REFERENCES vets (id));