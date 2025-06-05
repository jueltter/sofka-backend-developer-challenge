-- Drop the database if it already exists
DROP DATABASE IF EXISTS "ekumen-bank" WITH (FORCE);

-- Create the new database
CREATE DATABASE "ekumen-bank"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Connect to the newly created database using pgAdmin or a psql-specific command
-- \connect database

-- tables

DROP TABLE IF EXISTS cuenta cascade;

CREATE TABLE cuenta (
    id BIGSERIAL PRIMARY KEY,
    numero_cuenta VARCHAR(255) NOT NULL UNIQUE,
    tipo_cuenta VARCHAR(255) NOT NULL,
    saldo_inicial NUMERIC(19, 2) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    cliente_id VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS movimiento_cuenta cascade;

CREATE TABLE movimiento_cuenta (
    id BIGSERIAL PRIMARY KEY,
    fecha TIMESTAMP NOT NULL,
    tipo_movimiento VARCHAR(255) NOT NULL,
    valor NUMERIC(19, 2) NOT NULL,
    saldo NUMERIC(19, 2) NOT NULL,
    saldo_anterior NUMERIC(19, 2) NOT NULL,
    cuenta BIGINT NOT NULL,
    FOREIGN KEY (cuenta) REFERENCES cuenta(id)
);

DROP TABLE IF EXISTS cliente CASCADE;

CREATE TABLE cliente (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    genero VARCHAR(50),
    fecha_nacimiento DATE,
    identificacion VARCHAR(50) NOT NULL UNIQUE,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    cliente_id VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

/*
delete from movimiento_cuenta;
delete from cuenta;
delete from cliente;

INSERT INTO cliente (nombre, genero, fecha_nacimiento, identificacion, direccion, telefono, cliente_id, clave, estado) VALUES
    ('Paul Atreides', UPPER('Male'), '1965-08-01', 'c7e1a2b0-2e6a-4b7a-9c1e-1f2b3c4d5e6f', 'Arrakis', '555-1234', 'c7e1a2b0-2e6a-4b7a-9c1e-1f2b3c4d5e6f', MD5('password1'), UPPER('True')),
    ('Leia Organa', UPPER('Female'), '1956-10-21', 'f3b2c1d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d', 'Alderaan', '555-5678', 'f3b2c1d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d', MD5('password2'), UPPER('True')),
    ('Ender Wiggin', UPPER('Male'), '1985-06-15', 'a1b2c3d4-e5f6-4a7b-8c9d-1e2f3a4b5c6d', 'Battle School', '555-8765', 'a1b2c3d4-e5f6-4a7b-8c9d-1e2f3a4b5c6d', MD5('password3'), UPPER('True')),
    ('Arthur Dent', UPPER('Male'), '1979-03-11', 'b2c3d4e5-f6a7-4b8c-9d0e-2f3a4b5c6d7e', 'Earth', '555-4321', 'b2c3d4e5-f6a7-4b8c-9d0e-2f3a4b5c6d7e', MD5('password4'), UPPER('True')),
    ('Katniss Everdeen', UPPER('Female'), '2008-09-14', 'd3e4f5a6-b7c8-4d9e-0f1a-3b4c5d6e7f8a', 'District 12', '555-6789', 'd3e4f5a6-b7c8-4d9e-0f1a-3b4c5d6e7f8a', MD5('password5'), UPPER('True')),
    ('Rick Deckard', UPPER('Male'), '1968-01-01', 'e4f5a6b7-c8d9-4e0f-1a2b-4c5d6e7f8a9b', 'San Francisco', '555-9876', 'e4f5a6b7-c8d9-4e0f-1a2b-4c5d6e7f8a9b', MD5('password6'), UPPER('True')),
    ('Neo', UPPER('Male'), '1999-03-31', 'f5a6b7c8-d9e0-4f1a-2b3c-5d6e7f8a9b0c', 'Matrix', '555-1111', 'f5a6b7c8-d9e0-4f1a-2b3c-5d6e7f8a9b0c', MD5('password7'), UPPER('True')),
    ('Trillian', UPPER('Female'), '1979-03-11', 'a6b7c8d9-e0f1-4a2b-3c4d-6e7f8a9b0c1d', 'Heart of Gold', '555-2222', 'a6b7c8d9-e0f1-4a2b-3c4d-6e7f8a9b0c1d', MD5('password8'), UPPER('True')),
    ('Gully Foyle', UPPER('Male'), '1956-01-01', 'b7c8d9e0-f1a2-4b3c-4d5e-7f8a9b0c1d2e', 'Nomad', '555-3333', 'b7c8d9e0-f1a2-4b3c-4d5e-7f8a9b0c1d2e', MD5('password9'), UPPER('True')),
    ('Molly Millions', UPPER('Female'), '1984-07-01', 'c8d9e0f1-a2b3-4c5d-5e6f-8a9b0c1d2e3f', 'Chiba City', '555-4444', 'c8d9e0f1-a2b3-4c5d-5e6f-8a9b0c1d2e3f', MD5('password10'), UPPER('True'));


INSERT INTO cuenta (numero_cuenta, tipo_cuenta, saldo_inicial, estado, cliente_id) VALUES
    ('1e2f3a4b-5c6d-4e7f-8a9b-0c1d2e3f4a5b', 'AHORROS', 1000.00, 'TRUE', 'c7e1a2b0-2e6a-4b7a-9c1e-1f2b3c4d5e6f'),
    ('2f3a4b5c-6d7e-4f8a-9b0c-1d2e3f4a5b6c', 'CORRIENTE', 1500.50, 'TRUE', 'f3b2c1d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d'),
    ('3a4b5c6d-7e8f-4a9b-0c1d-2e3f4a5b6c7d', 'AHORROS', 2000.75, 'TRUE', 'a1b2c3d4-e5f6-4a7b-8c9d-1e2f3a4b5c6d'),
    ('4b5c6d7e-8f9a-4b0c-1d2e-3f4a5b6c7d8e', 'CORRIENTE', 2500.00, 'TRUE', 'b2c3d4e5-f6a7-4b8c-9d0e-2f3a4b5c6d7e'),
    ('5c6d7e8f-9a0b-4c1d-2e3f-4a5b6c7d8e9f', 'AHORROS', 3000.25, 'TRUE', 'd3e4f5a6-b7c8-4d9e-0f1a-3b4c5d6e7f8a'),
    ('6d7e8f9a-0b1c-4d2e-3f4a-5b6c7d8e9f0a', 'CORRIENTE', 3500.50, 'TRUE', 'e4f5a6b7-c8d9-4e0f-1a2b-4c5d6e7f8a9b'),
    ('7e8f9a0b-1c2d-4e3f-4a5b-6c7d8e9f0a1b', 'AHORROS', 4000.75, 'TRUE', 'f5a6b7c8-d9e0-4f1a-2b3c-5d6e7f8a9b0c'),
    ('8f9a0b1c-2d3e-4f4a-5b6c-7d8e9f0a1b2c', 'CORRIENTE', 4500.00, 'TRUE', 'a6b7c8d9-e0f1-4a2b-3c4d-6e7f8a9b0c1d'),
    ('9a0b1c2d-3e4f-4a5b-6c7d-8e9f0a1b2c3d', 'AHORROS', 5000.25, 'TRUE', 'b7c8d9e0-f1a2-4b3c-4d5e-7f8a9b0c1d2e'),
    ('0b1c2d3e-4f5a-4b6c-7d8e-9f0a1b2c3d4e', 'CORRIENTE', 5500.50, 'TRUE', 'c8d9e0f1-a2b3-4c5d-5e6f-8a9b0c1d2e3f');
*/