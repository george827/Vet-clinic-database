/* Database schema to keep the structure of entire database. */

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
    age INT NOT NULL
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