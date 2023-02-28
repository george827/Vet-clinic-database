/* Database schema to keep the structure of entire database. */
-- vet_clinic database

CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
    name  VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg Decimal
);

ALTER TABLE animals
ADD species VARCHAR(255);

/* query multiple tables. */

CREATE TABLE owner (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

ALTER TABLE animals 
    DROP COLUMN species;

SELECT * FROM animals;

ALTER TABLE animals
ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT references owner(id);

-- vets, visits joining table

-- create vets table 
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    date_of_graduation DATE
);


-- create specializations join table (vets table and species table)
CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

-- create visits  join table (animals table and vets table)
CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    visited_date DATE NOT NULL
);


-- WEEK 2 PERFORMANCE AUDIT

ALTER TABLE owner ADD COLUMN email VARCHAR(120);

--  improve performance 
CREATE INDEX animal_id_index ON visits (animal_id);
CREATE INDEX vet_id_index ON visits (vet_id);
CREATE INDEX owners_email_index ON owner (email);