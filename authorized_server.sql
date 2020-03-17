-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: authorized_server | type: DATABASE --
-- -- DROP DATABASE IF EXISTS authorized_server;
-- CREATE DATABASE authorized_server;
-- -- ddl-end --
-- 

-- object: party | type: SCHEMA --
-- DROP SCHEMA IF EXISTS party CASCADE;
CREATE SCHEMA party;
-- ddl-end --
-- ALTER SCHEMA party OWNER TO postgres;
-- ddl-end --

-- object: look_up | type: SCHEMA --
-- DROP SCHEMA IF EXISTS look_up CASCADE;
CREATE SCHEMA look_up;
-- ddl-end --
-- ALTER SCHEMA look_up OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,party,look_up;
-- ddl-end --

-- object: party.party | type: TABLE --
-- DROP TABLE IF EXISTS party.party CASCADE;
CREATE TABLE party.party (
	party_id bigserial NOT NULL,
	party_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	birth_date timestamptz,
	death_date timestamp,
	row_creation_time timestamptz DEFAULT CURRENT_TIMESTAMP,
	row_update_time timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	row_update_info text,
	CONSTRAINT party_pk PRIMARY KEY (party_id)

);
-- ddl-end --
-- ALTER TABLE party.party OWNER TO postgres;
-- ddl-end --

-- object: "uuid-ossp" | type: EXTENSION --
-- DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;
CREATE EXTENSION "uuid-ossp"
WITH SCHEMA public;
-- ddl-end --

-- object: btree_gist | type: EXTENSION --
-- DROP EXTENSION IF EXISTS btree_gist CASCADE;
CREATE EXTENSION btree_gist
WITH SCHEMA public;
-- ddl-end --

-- object: look_up.generic_cd | type: TABLE --
-- DROP TABLE IF EXISTS look_up.generic_cd CASCADE;
CREATE TABLE look_up.generic_cd (
	generic_cd bigserial NOT NULL,
	code text,
	start_date date,
	end_date date,
	row_creation_time timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	row_created_by text NOT NULL DEFAULT 'திருமால்',
	row_updated_by text NOT NULL DEFAULT 'திருமால்',
	row_update_info text NOT NULL,
	parent_generic_cd bigint,
	CONSTRAINT party_type_pk PRIMARY KEY (generic_cd)

);
-- ddl-end --
-- ALTER TABLE look_up.generic_cd OWNER TO postgres;
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE look_up.generic_cd DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE look_up.generic_cd ADD CONSTRAINT generic_cd_fk FOREIGN KEY (parent_generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: party.party_type | type: TABLE --
-- DROP TABLE IF EXISTS party.party_type CASCADE;
CREATE TABLE party.party_type (
	party_type_id bigserial NOT NULL,
	party_id bigint NOT NULL,
	start_time timestamptz NOT NULL,
	end_time timestamptz,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_info text,
	generic_cd bigint NOT NULL,
	CONSTRAINT party_type_pk PRIMARY KEY (party_type_id)

);
-- ddl-end --
-- ALTER TABLE party.party_type OWNER TO postgres;
-- ddl-end --

-- object: party_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_type DROP CONSTRAINT IF EXISTS party_fk CASCADE;
ALTER TABLE party.party_type ADD CONSTRAINT party_fk FOREIGN KEY (party_id)
REFERENCES party.party (party_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_type DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE party.party_type ADD CONSTRAINT generic_cd_fk FOREIGN KEY (generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE RESTRICT ON UPDATE NO ACTION;
-- ddl-end --

-- object: party_type_uq | type: CONSTRAINT --
-- ALTER TABLE party.party_type DROP CONSTRAINT IF EXISTS party_type_uq CASCADE;
ALTER TABLE party.party_type ADD CONSTRAINT party_type_uq UNIQUE (generic_cd);
-- ddl-end --

-- object: party.party_name | type: TABLE --
-- DROP TABLE IF EXISTS party.party_name CASCADE;
CREATE TABLE party.party_name (
	party_name_id bigserial NOT NULL,
	party_id bigint NOT NULL,
	generic_cd bigint,
	first_name text NOT NULL,
	rest_of_name text,
	start_time timestamptz NOT NULL,
	end_time timestamptz,
	preferred bool NOT NULL DEFAULT false,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_info text,
	CONSTRAINT party_name_pk PRIMARY KEY (party_name_id)

);
-- ddl-end --
COMMENT ON COLUMN party.party_name.first_name IS E'first name for natural person and company name for legal party';
-- ddl-end --
-- ALTER TABLE party.party_name OWNER TO postgres;
-- ddl-end --

-- object: party_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_name DROP CONSTRAINT IF EXISTS party_fk CASCADE;
ALTER TABLE party.party_name ADD CONSTRAINT party_fk FOREIGN KEY (party_id)
REFERENCES party.party (party_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: look_up.locale_cd | type: TABLE --
-- DROP TABLE IF EXISTS look_up.locale_cd CASCADE;
CREATE TABLE look_up.locale_cd (
	locale_cd bigserial NOT NULL,
	code text NOT NULL,
	description text NOT NULL,
	start_date date NOT NULL,
	end_date date,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_created_by text NOT NULL DEFAULT 'திருமால்',
	row_updated_by text NOT NULL DEFAULT 'திருமால்',
	row_update_info text,
	CONSTRAINT locale_cd_pk PRIMARY KEY (locale_cd)

);
-- ddl-end --
-- ALTER TABLE look_up.locale_cd OWNER TO postgres;
-- ddl-end --

-- object: look_up.generic_locales | type: TABLE --
-- DROP TABLE IF EXISTS look_up.generic_locales CASCADE;
CREATE TABLE look_up.generic_locales (
	generic_locales bigserial NOT NULL,
	generic_cd bigint NOT NULL,
	locale_cd bigint NOT NULL,
	description text NOT NULL,
	start_date date NOT NULL,
	end_date date,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_created_by text NOT NULL DEFAULT 'திருமால்',
	row_updated_by text NOT NULL DEFAULT 'திருமால்',
	row_update_info text,
	CONSTRAINT party_type_locales_pk PRIMARY KEY (generic_locales)

);
-- ddl-end --
-- ALTER TABLE look_up.generic_locales OWNER TO postgres;
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE look_up.generic_locales DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE look_up.generic_locales ADD CONSTRAINT generic_cd_fk FOREIGN KEY (generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: locale_cd_fk | type: CONSTRAINT --
-- ALTER TABLE look_up.generic_locales DROP CONSTRAINT IF EXISTS locale_cd_fk CASCADE;
ALTER TABLE look_up.generic_locales ADD CONSTRAINT locale_cd_fk FOREIGN KEY (locale_cd)
REFERENCES look_up.locale_cd (locale_cd) MATCH FULL
ON DELETE RESTRICT ON UPDATE NO ACTION;
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_name DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE party.party_name ADD CONSTRAINT generic_cd_fk FOREIGN KEY (generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: party_name_uq | type: CONSTRAINT --
-- ALTER TABLE party.party_name DROP CONSTRAINT IF EXISTS party_name_uq CASCADE;
ALTER TABLE party.party_name ADD CONSTRAINT party_name_uq UNIQUE (generic_cd);
-- ddl-end --

-- object: party.party_identifier | type: TABLE --
-- DROP TABLE IF EXISTS party.party_identifier CASCADE;
CREATE TABLE party.party_identifier (
	party_identifier_id bigserial NOT NULL,
	party_id bigint NOT NULL,
	generic_cd bigint NOT NULL,
	identification text NOT NULL,
	start_time timestamptz NOT NULL,
	end_time timestamptz,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_info text,
	CONSTRAINT party_identifier_pk PRIMARY KEY (party_identifier_id)

);
-- ddl-end --
-- ALTER TABLE party.party_identifier OWNER TO postgres;
-- ddl-end --

-- object: party_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_identifier DROP CONSTRAINT IF EXISTS party_fk CASCADE;
ALTER TABLE party.party_identifier ADD CONSTRAINT party_fk FOREIGN KEY (party_id)
REFERENCES party.party (party_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_identifier DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE party.party_identifier ADD CONSTRAINT generic_cd_fk FOREIGN KEY (generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE RESTRICT ON UPDATE NO ACTION;
-- ddl-end --

-- object: party_identifier_uq | type: CONSTRAINT --
-- ALTER TABLE party.party_identifier DROP CONSTRAINT IF EXISTS party_identifier_uq CASCADE;
ALTER TABLE party.party_identifier ADD CONSTRAINT party_identifier_uq UNIQUE (generic_cd);
-- ddl-end --


