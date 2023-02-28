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

  --day 4-
  -- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.visited_date 
  FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visits.visited_date DESC 
  lIMIT 1;


-- How many different animals did Stephanie Mendez see?
SELECT vets.name, animals.name, count(animals.name) 
  FROM animals 
  JOIN visits on visits.animal_id = animals.id
  JOIN vets on vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
   GROUP BY vets.name, animals.name;
  
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
  FROM vets
  LEFT JOIN specializations on specializations.vet_id = vets.id
  LEFT JOIN species on specializations.species_id = species.id
  ORDER BY vets.name, species.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, ve.name, vi.visited_date
  FROM animals a 
  JOIN visits vi 
  ON vi.animal_id = a.id
  JOIN vets ve 
  ON ve.id = vi.vet_id
  WHERE ve.name = 'Stephanie Mendez'
    AND vi.visited_date
    BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name, count(*) 
  FROM animals a
  JOIN visits vi
  ON vi.animal_id = a.id
  GROUP BY a.name
  ORDER BY count DESC 
  limit 1;

-- Who was Maisy Smith's first visit?
SELECT a.name, ve.name, vi.visited_date 
  FROM animals a
  JOIN visits vi
  ON a.id = vi.animal_id
  JOIN vets ve
  ON vi.vet_id = ve.id
  WHERE ve.name = 'Maisy SMith'
  ORDER BY vi.visited_date
  lIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.id, a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.weight_kg, ve.name, ve.age,
  ve.date_of_graduation, ve.id, vi.visited_date
  FROM animals a
  JOIN visits vi
  on a.id = vi.animal_id
  JOIN vets ve
  on vi.vet_id = ve.id
  ORDER BY vi.visited_date DESC 
  lIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) 
  FROM vets ve
  JOIN visits vi 
  ON vi.vet_id = ve.id
  JOIN animals a
  ON vi.animal_id = a.id
  JOIN specializations s 
  ON ve.id = s.vet_id
  WHERE s.species_id != a.species_id OR s.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT ve.name, spe.name, count(spe.name)
  FROM vets ve
  JOIN visits vi
  ON vi.vet_id = ve.id 
  JOIN animals a
  ON vi.animal_id = a.id 
  JOIN species spe 
  ON a.species_id = spe.id 
  WHERE ve.name = 'Maisy SMith' 
  GROUP BY spe.name, ve.name 
  ORDER BY count DESC 
  lIMIT 1;

-- week 2

-- performance audit
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owner where email = 'owner_18327@mail.com';