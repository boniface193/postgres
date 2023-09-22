/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-2-3', 0, true, 4.12345);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Gabumon', '2021-1-7', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-5-12', 5, true, 11.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Charmander', '2020-02-08', 0, false, -11.0, 'Fire');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7, 'Grass');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13, 'Water');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Angemon', '2005-06-12', 1, true, -45.0, 'Holy');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4, 'Fire');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Blossom', '1998-10-13', 3, true, 17.0, 'Grass');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Ditto', '2022-05-14', 4, true, 22.0, 'Normal');
-- Insert data into the owners table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),  ('Jennifer Orwell', 19), ('Bob', 45),  ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);
-- Insert data into the species table
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Modify inserted animals based on name and assign species_id
-- and owner_id accordingly
UPDATE animals SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon') ELSE (SELECT id FROM species WHERE name = 'Pokemon') END);

-- Modify inserted animals to include owner_id
UPDATE animals SET owner_id = (CASE WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob') WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester') END);