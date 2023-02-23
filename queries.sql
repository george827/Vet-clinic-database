/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, date_of_birth FROM animals WHERE weight_kg >10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--  start transaction
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name Like '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


-- answer queries
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered,name
 FROM animals
 WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals)
  GROUP BY neutered,name;

SELECT species, MIN(weight_kg), MAX(weight_kg) 
  FROM animals GROUP BY species;
SELECT species, ROUND(AVG(escape_attempts)) FROM animals 
  WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

  -- Write queries (using JOIN)

  -- What animals belong to Melody Pond?
SELECT animals.name,owner.full_name 
  FROM animals 
  JOIN owner 
  ON animals.owner_id = owner.id 
  WHERE owner.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name
  FROM animals
  JOIN species 
  ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

  -- List all owners and their animals, remember to include those that don't own any animal.

SELECT owner.full_name, animals.name 
  FROM owner
  LEFT JOIN animals 
  ON owner.id = animals.owner_id;

--   How many animals are there per species

SELECT species.name, COUNT(animals.id)
FROM animals
JOIN species 
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT owner.full_name, animals.name, species.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owner ON animals.owner_id = owner.id
WHERE species.name = 'Digimon' and owner.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name, owner.full_name 
  FROM animals
  JOIN owner 
  ON animals.owner_id = owner.id
  WHERE animals.escape_attempts=0
  AND owner.full_name = 'Dean Winchester';

  -- Who owns the most animals?
SELECT count(*), owner.full_name 
  FROM animals 
  JOIN owner 
  ON animals.owner_id = owner.id
  GROUP BY owner.full_name ORDER BY count desc;