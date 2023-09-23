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
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet William Tatcher', 45, '2000-04-23'), ('Vet Maisy Smith', 26, '2019-01-17'), ('Vet Stephanie Mendez', 64, '1981-05-04'), ('Vet Jack Harkness', 38, '2008-06-08');

-- Vet William Tatcher's specializations
INSERT INTO specializations (vet_id, species_id) VALUES
    (1, 1), -- William Tatcher specialized in Pokemon
    (2, 1), -- Stephanie Mendez specialized in Pokemon
    (2, 2), -- Stephanie Mendez specialized in Digimon
    (3, 2); -- Jack Harkness specialized in Digimon

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
    (1, 1, '2020-05-24'),  -- Agumon visited William Tatcher on May 24th, 2020
    (1, 2, '2020-07-22'),  -- Agumon visited Stephanie Mendez on Jul 22nd, 2020
    (2, 4, '2021-02-02'),  -- Gabumon visited Jack Harkness on Feb 2nd, 2021
    (3, 2, '2020-01-05'),  -- Pikachu visited Maisy Smith on Jan 5th, 2020
    (3, 2, '2020-03-08'),  -- Pikachu visited Maisy Smith on Mar 8th, 2020
    (3, 2, '2020-05-14'),  -- Pikachu visited Maisy Smith on May 14th, 2020
    (4, 3, '2021-05-04'),  -- Devimon visited Stephanie Mendez on May 4th, 2021
    (5, 4, '2021-02-24'),  -- Charmander visited Jack Harkness on Feb 24th, 2021
    (6, 2, '2019-12-21'),  -- Plantmon visited Maisy Smith on Dec 21st, 2019
    (6, 1, '2020-08-10'),  -- Plantmon visited William Tatcher on Aug 10th, 2020
    (6, 2, '2021-04-07'),  -- Plantmon visited Maisy Smith on Apr 7th, 2021
    (7, 2, '2019-09-29'),  -- Squirtle visited Stephanie Mendez on Sep 29th, 2019
    (8, 4, '2020-10-03'),  -- Angemon visited Jack Harkness on Oct 3rd, 2020
    (8, 4, '2020-11-04'),  -- Angemon visited Jack Harkness on Nov 4th, 2020
    (9, 2, '2019-01-24'),  -- Boarmon visited Maisy Smith on Jan 24th, 2019
    (9, 2, '2019-05-15'),  -- Boarmon visited Maisy Smith on May 15th, 2019
    (9, 2, '2020-02-27'),  -- Boarmon visited Maisy Smith on Feb 27th, 2020
    (9, 2, '2020-08-03'),  -- Boarmon visited Maisy Smith on Aug 3rd, 2020
    (10, 3, '2020-05-24'), -- Blossom visited Stephanie Mendez on May 24th, 2020
    (10, 1, '2021-01-11'); -- Blossom visited William Tatcher on Jan 11th, 2021
