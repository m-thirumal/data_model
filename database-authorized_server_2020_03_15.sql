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

SET search_path TO pg_catalog,public,party;
-- ddl-end --

-- object: party.party | type: TABLE --
-- DROP TABLE IF EXISTS party.party CASCADE;
CREATE TABLE party.party (
	party_id bigserial,
	party_uuid uuid,
	date_of_birth timestamptz,
	death_date timestamp
);
-- ddl-end --
-- ALTER TABLE party.party OWNER TO postgres;
-- ddl-end --


