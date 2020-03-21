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

-- object: btree_gist | type: EXTENSION --
-- DROP EXTENSION IF EXISTS btree_gist CASCADE;
CREATE EXTENSION btree_gist
WITH SCHEMA public;
-- ddl-end --

-- object: "uuid-ossp" | type: EXTENSION --
-- DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;
CREATE EXTENSION "uuid-ossp"
WITH SCHEMA public;
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
	generic_cd bigint NOT NULL,
	start_time timestamptz NOT NULL,
	end_time timestamptz,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_info text,
	CONSTRAINT party_type_pk PRIMARY KEY (party_type_id)

);
-- ddl-end --
COMMENT ON TABLE party.party_type IS E'Created by Thirumal';
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
	start_time timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	end_time timestamptz,
	preferred bool NOT NULL DEFAULT false,
	row_creation_time timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
	row_update_time timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
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

-- object: party.login | type: TABLE --
-- DROP TABLE IF EXISTS party.login CASCADE;
CREATE TABLE party.login (
	login_id bigserial NOT NULL,
	party_id bigint NOT NULL,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_info text,
	CONSTRAINT login_pk PRIMARY KEY (login_id)

);
-- ddl-end --
-- ALTER TABLE party.login OWNER TO postgres;
-- ddl-end --

-- object: party_fk | type: CONSTRAINT --
-- ALTER TABLE party.login DROP CONSTRAINT IF EXISTS party_fk CASCADE;
ALTER TABLE party.login ADD CONSTRAINT party_fk FOREIGN KEY (party_id)
REFERENCES party.party (party_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: login_uq | type: CONSTRAINT --
-- ALTER TABLE party.login DROP CONSTRAINT IF EXISTS login_uq CASCADE;
ALTER TABLE party.login ADD CONSTRAINT login_uq UNIQUE (party_id);
-- ddl-end --

-- object: party.login_identifier | type: TABLE --
-- DROP TABLE IF EXISTS party.login_identifier CASCADE;
CREATE TABLE party.login_identifier (
	login_identifier_id bigserial NOT NULL,
	login_id bigint NOT NULL,
	generic_cd bigint NOT NULL,
	identifier text NOT NULL,
	start_time timestamptz NOT NULL DEFAULT current_timestamp,
	end_time timestamptz,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_info text,
	CONSTRAINT login_identifier_pk PRIMARY KEY (login_identifier_id)

);
-- ddl-end --
-- ALTER TABLE party.login_identifier OWNER TO postgres;
-- ddl-end --

-- object: login_fk | type: CONSTRAINT --
-- ALTER TABLE party.login_identifier DROP CONSTRAINT IF EXISTS login_fk CASCADE;
ALTER TABLE party.login_identifier ADD CONSTRAINT login_fk FOREIGN KEY (login_id)
REFERENCES party.login (login_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: party.password | type: TABLE --
-- DROP TABLE IF EXISTS party.password CASCADE;
CREATE TABLE party.password (
	password_id bigserial NOT NULL,
	login_id bigint NOT NULL,
	secret text NOT NULL,
	start_time timestamptz NOT NULL DEFAULT current_timestamp,
	end_time timestamptz DEFAULT current_timestamp,
	CONSTRAINT password_pk PRIMARY KEY (password_id)

);
-- ddl-end --
-- ALTER TABLE party.password OWNER TO postgres;
-- ddl-end --

-- object: login_fk | type: CONSTRAINT --
-- ALTER TABLE party.password DROP CONSTRAINT IF EXISTS login_fk CASCADE;
ALTER TABLE party.password ADD CONSTRAINT login_fk FOREIGN KEY (login_id)
REFERENCES party.login (login_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: password_uq | type: CONSTRAINT --
-- ALTER TABLE party.password DROP CONSTRAINT IF EXISTS password_uq CASCADE;
ALTER TABLE party.password ADD CONSTRAINT password_uq UNIQUE (login_id);
-- ddl-end --

-- object: party.login_question | type: TABLE --
-- DROP TABLE IF EXISTS party.login_question CASCADE;
CREATE TABLE party.login_question (
	login_question_id bigserial NOT NULL,
	login_id bigint NOT NULL,
	generic_cd bigint NOT NULL,
	answer text NOT NULL,
	start_time timestamptz NOT NULL DEFAULT current_timestamp,
	end_time timestamptz,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz DEFAULT current_timestamp,
	row_update_info text,
	CONSTRAINT login_question_pk PRIMARY KEY (login_question_id)

);
-- ddl-end --
-- ALTER TABLE party.login_question OWNER TO postgres;
-- ddl-end --

-- object: login_fk | type: CONSTRAINT --
-- ALTER TABLE party.login_question DROP CONSTRAINT IF EXISTS login_fk CASCADE;
ALTER TABLE party.login_question ADD CONSTRAINT login_fk FOREIGN KEY (login_id)
REFERENCES party.login (login_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: party.party_picture | type: TABLE --
-- DROP TABLE IF EXISTS party.party_picture CASCADE;
CREATE TABLE party.party_picture (
	party_picture_id bigserial NOT NULL,
	party_id bigint NOT NULL,
	picture bytea NOT NULL,
	preferred bool NOT NULL DEFAULT false,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp,
	row_update_time timestamptz,
	row_update_info text,
	CONSTRAINT party_picture_pk PRIMARY KEY (party_picture_id)

);
-- ddl-end --
-- ALTER TABLE party.party_picture OWNER TO postgres;
-- ddl-end --

-- object: party_fk | type: CONSTRAINT --
-- ALTER TABLE party.party_picture DROP CONSTRAINT IF EXISTS party_fk CASCADE;
ALTER TABLE party.party_picture ADD CONSTRAINT party_fk FOREIGN KEY (party_id)
REFERENCES party.party (party_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE party.login_question DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE party.login_question ADD CONSTRAINT generic_cd_fk FOREIGN KEY (generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE RESTRICT ON UPDATE NO ACTION;
-- ddl-end --

-- object: login_question_uq | type: CONSTRAINT --
-- ALTER TABLE party.login_question DROP CONSTRAINT IF EXISTS login_question_uq CASCADE;
ALTER TABLE party.login_question ADD CONSTRAINT login_question_uq UNIQUE (generic_cd);
-- ddl-end --

-- object: generic_cd_fk | type: CONSTRAINT --
-- ALTER TABLE party.login_identifier DROP CONSTRAINT IF EXISTS generic_cd_fk CASCADE;
ALTER TABLE party.login_identifier ADD CONSTRAINT generic_cd_fk FOREIGN KEY (generic_cd)
REFERENCES look_up.generic_cd (generic_cd) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: login_identifier_uq | type: CONSTRAINT --
-- ALTER TABLE party.login_identifier DROP CONSTRAINT IF EXISTS login_identifier_uq CASCADE;
ALTER TABLE party.login_identifier ADD CONSTRAINT login_identifier_uq UNIQUE (generic_cd);
-- ddl-end --

-- object: ix_fk_party_type_party_id | type: INDEX --
-- DROP INDEX IF EXISTS party.ix_fk_party_type_party_id;
CREATE INDEX ix_fk_party_type_party_id ON party.party_type
	USING btree
	(
	  party_id
	)
	TABLESPACE pg_default;
-- ddl-end --

-- object: ix_fk_party_type_generic_cd | type: INDEX --
-- DROP INDEX IF EXISTS party.ix_fk_party_type_generic_cd CASCADE;
CREATE INDEX ix_fk_party_type_generic_cd ON party.party_type
	USING btree
	(
	  generic_cd
	);
-- ddl-end --

-- object: ix_party_type_end_time | type: INDEX --
-- DROP INDEX IF EXISTS party.ix_party_type_end_time CASCADE;
CREATE INDEX ix_party_type_end_time ON party.party_type
	USING btree
	(
	  (end_time IS NULL) ASC NULLS FIRST
	);
-- ddl-end --


