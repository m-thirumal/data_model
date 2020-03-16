-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 0.9.2
-- Diff date: 2020-03-15 20:18:24
-- Source model: authorized_server
-- Database: authorized_server
-- PostgreSQL version: 12.0

-- [ Diff summary ]
-- Dropped objects: 0
-- Created objects: 4
-- Changed objects: 1
-- Truncated tables: 0

SET search_path=public,pg_catalog,party;
-- ddl-end --


-- [ Created objects ] --
-- object: row_creation_time | type: COLUMN --
-- ALTER TABLE party.party DROP COLUMN IF EXISTS row_creation_time CASCADE;
ALTER TABLE party.party ADD COLUMN row_creation_time timestamptz DEFAULT CURRENT_TIMESTAMP;
-- ddl-end --


-- object: row_update_time | type: COLUMN --
-- ALTER TABLE party.party DROP COLUMN IF EXISTS row_update_time CASCADE;
ALTER TABLE party.party ADD COLUMN row_update_time timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- ddl-end --


-- object: row_update_info | type: COLUMN --
-- ALTER TABLE party.party DROP COLUMN IF EXISTS row_update_info CASCADE;
ALTER TABLE party.party ADD COLUMN row_update_info text;
-- ddl-end --




-- [ Changed objects ] --
ALTER TABLE party.party ALTER COLUMN party_uuid SET DEFAULT uuid_generate_v4();
-- ddl-end --
ALTER TABLE party.party ALTER COLUMN party_uuid SET NOT NULL;
-- ddl-end --


-- [ Created constraints ] --
-- object: party_pk | type: CONSTRAINT --
-- ALTER TABLE party.party DROP CONSTRAINT IF EXISTS party_pk CASCADE;
ALTER TABLE party.party ADD CONSTRAINT party_pk PRIMARY KEY (party_id);
-- ddl-end --

