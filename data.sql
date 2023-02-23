/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon','2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

-- insert animals with spicies
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '2022-05-14', 4, true, 22);

-- data into owner
INSERT INTO owner (full_name, age)
  VALUES ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob',45), ('Melody Pond', 77), 
  ('Dean Winchester', 14), 
  ('Joddie Whittaker', 38);

  SELECT * FROM owner;
--  Insert the following data into the species table:(Pokemon Digimon)
  INSERT INTO species (name)
  VALUES ('Pokemon'),
  ('Digimon');

  SELECT * FROM species;

--  If the name ends in "mon" it will be Digimon All other animals are Pokemon 
 SELECT * FROM animals;
  UPDATE animals
SET species_id = CASE 
					 WHEN name ILIKE '%mon' THEN  2
					 ELSE 1
				 END
;
SELECT * FROM animals;

/* the inserted animals to include owner information (owner_id): */
UPDATE animals
SET owner_id = CASE 
					 WHEN name = 'Agumon' THEN 1
					 WHEN name IN ('Gabumon','Pikachu') THEN 2
					 WHEN name IN ('Devimon','Plantmon') THEN 3
					 WHEN name IN ('Charmander','Squirtle','Blossom') THEN 4
					 WHEN name IN ('Angemon','Boarmon') THEN 5
				 END;

SELECT * FROM animals;