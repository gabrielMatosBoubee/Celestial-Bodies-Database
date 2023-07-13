CREATE DATABASE universe;

CREATE TABLE
    galaxy (
        galaxy_id BIGSERIAL PRIMARY KEY,
        name VARCHAR(250) UNIQUE NOT NULL,
        price INTEGER,
        qty INTEGER,
        length NUMERIC(10, 2),
        hasLife BOOLEAN,
        hasWater BOOLEAN
    );

CREATE TABLE
    star (
        galaxy_id BIGINT NOT NULL,
        star_id BIGSERIAL PRIMARY KEY,
        name VARCHAR(250) UNIQUE,
        price INTEGER,
        qty INTEGER,
        length NUMERIC(10, 2),
        hasLife BOOLEAN,
        hasWater BOOLEAN,
        FOREIGN KEY (galaxy_id) REFERENCES galaxy (galaxy_id)
    );

CREATE TABLE
    planet (
        galaxy_id BIGINT NOT NULL,
        star_id BIGINT NOT NULL,
        planet_id BIGSERIAL PRIMARY KEY,
        description TEXT,
        name VARCHAR(250) UNIQUE,
        price INTEGER,
        qty INTEGER,
        length NUMERIC(10, 2),
        hasLife BOOLEAN,
        hasWater BOOLEAN,
        distance_from_earth BIGINT NOT NULL,
        age BIGINT NOT NULL,
        FOREIGN KEY (galaxy_id) REFERENCES galaxy (galaxy_id),
        FOREIGN KEY (star_id) REFERENCES star (star_id)
    );

CREATE TABLE
    moon (
        galaxy_id BIGINT NOT NULL,
        planet_id BIGINT NOT NULL,
        moon_id BIGSERIAL PRIMARY KEY,
        description TEXT,
        name VARCHAR(250) UNIQUE,
        price INTEGER,
        qty INTEGER,
        length NUMERIC(10, 2),
        hasLife BOOLEAN,
        hasWater BOOLEAN,
        FOREIGN KEY (galaxy_id) REFERENCES galaxy (galaxy_id),
        FOREIGN KEY (planet_id) REFERENCES planet (planet_id)
    );

CREATE TABLE
    race (
        race_id BIGSERIAL PRIMARY KEY,
        name VARCHAR(250) UNIQUE,
        description TEXT NOT NULL,
        qty BIGINT,
        planet_id BIGINT,
        FOREIGN KEY (planet_id) REFERENCES planet (planet_id)
    );

INSERT INTO
    galaxy (
        name,
        price,
        qty,
        length,
        hasLife,
        hasWater
    )
SELECT
    'Galaxy ' || gs.n,
    gs.n * 1000,
    gs.n,
    gs.n * 1.5,
    true,
    false
FROM
    generate_series(1, 20) AS gs(n);

INSERT INTO
    star (
        galaxy_id,
        name,
        price,
        qty,
        length,
        hasLife,
        hasWater
    )
SELECT
    gs.n % 3 + 1,
    'Star ' || gs.n,
    gs.n * 100,
    gs.n,
    gs.n * 0.5,
    true,
    true
FROM
    generate_series(1, 20) AS gs(n);

INSERT INTO
    planet (
        galaxy_id,
        star_id,
        name,
        price,
        qty,
        length,
        hasLife,
        hasWater,
        distance_from_earth,
        age
    )
SELECT
    gs.n % 3 + 1,
    gs.n % 5 + 1,
    'Planet ' || gs.n,
    gs.n * 50,
    gs.n,
    gs.n * 0.3,
    true,
    true,
    gs.n * 1000,
    gs.n * 100
FROM
    generate_series(1, 20) AS gs(n);

INSERT INTO
    moon (
        galaxy_id,
        planet_id,
        name,
        price,
        qty,
        length,
        hasLife,
        hasWater
    )
SELECT
    gs.n % 3 + 1,
    gs.n % 10 + 1,
    'Moon ' || gs.n,
    gs.n * 20,
    gs.n,
    gs.n * 0.1,
    false,
    false
FROM
    generate_series(1, 20) AS gs(n);

INSERT INTO
    race (
        name,
        description,
        qty,
        planet_id
    )
SELECT
    'Race ' || gs.n,
    'Description ' || gs.n,
    gs.n * 100,
    gs.n % 20 + 1
FROM
    generate_series(1, 20) AS gs(n);