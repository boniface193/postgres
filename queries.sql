/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Start a transaction
BEGIN;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

-- Step 1: Update species column for animals with names ending in "mon"

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Rollback the transaction to revert changes
ROLLBACK;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

-- Start a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT weight_update_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = -weight_kg;

-- Rollback to the savepoint
ROLLBACK TO weight_update_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = -weight_kg WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS non_escapers FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS avg_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT a.name AS animal_name FROM animals AS a JOIN owners AS o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

SELECT a.name AS animal_name FROM animals AS a JOIN species AS s ON a.species_id = s.id WHERE s.name = 'Pokemon';

SELECT o.full_name AS owner_name, COALESCE(array_agg(a.name), '{}') AS owned_animals FROM owners AS o LEFT JOIN animals AS a ON o.id = a.owner_id GROUP BY o.full_name;

SELECT s.name AS species_name, COUNT(a.id) AS animal_count FROM species AS s LEFT JOIN animals AS a ON s.id = a.species_id GROUP BY s.name;

SELECT a.name AS digimon_name FROM animals AS a JOIN species AS s ON a.species_id = s.id JOIN owners AS o ON a.owner_id = o.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name AS animal_name FROM animals AS a JOIN owners AS o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name AS owner_name, COUNT(a.id) AS owned_animals_count FROM owners AS o LEFT JOIN animals AS a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY owned_animals_count DESC LIMIT 1;

SELECT a.name AS animal_name FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN vets vet ON v.vet_id = vet.id WHERE vet.name = 'William Tatcher' ORDER BY v.visit_date DESC LIMIT 1;

SELECT a.name AS animal_name, v.vet_id, MAX(v.visit_date) AS most_recent_visit FROM visits v INNER JOIN animals a ON v.animal_id = a.id WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher') GROUP BY a.name, v.vet_id ORDER BY most_recent_visit DESC LIMIT 1;

SELECT vet.name, s.name AS specialty FROM vets vet LEFT JOIN specializations spec ON vet.id = spec.vet_id LEFT JOIN species s ON spec.species_id = s.id;

SELECT a.name AS animal_name FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN vets vet ON v.vet_id = vet.id WHERE vet.name = 'Stephanie Mendez' AND v.visit_date >= '2020-04-01' AND v.visit_date <= '2020-08-30';

SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count FROM visits v INNER JOIN animals a ON v.animal_id = a.id GROUP BY a.name ORDER BY visit_count DESC LIMIT 1;

SELECT vet.name AS vet_name, MIN(v.visit_date) AS first_visit_date FROM visits v INNER JOIN vets vet ON v.vet_id = vet.id INNER JOIN animals a ON v.animal_id = a.id INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Maisy Smith' GROUP BY vet.name ORDER BY first_visit_date LIMIT 1;

SELECT a.name AS animal_name, vet.name AS vet_name, v.visit_date FROM visits v INNER JOIN vets vet ON v.vet_id = vet.id INNER JOIN animals a ON v.animal_id = a.id ORDER BY v.visit_date DESC LIMIT 1;

SELECT COUNT(*) AS num_visits FROM visits v INNER JOIN vets vet ON v.vet_id = vet.id INNER JOIN animals a ON v.animal_id = a.id LEFT JOIN specializations spec ON vet.id = spec.vet_id WHERE spec.species_id IS NULL OR spec.species_id <> a.species_id;

SELECT s.name AS specialty, COUNT(*) AS num_visits FROM visits v INNER JOIN animals a ON v.animal_id = a.id INNER JOIN owners o ON a.owner_id = o.id LEFT JOIN vets vet ON v.vet_id = vet.id LEFT JOIN specializations spec ON vet.id = spec.vet_id LEFT JOIN species s ON spec.species_id = s.id WHERE o.full_name = 'Maisy Smith' GROUP BY s.name ORDER BY num_visits DESC LIMIT 1;