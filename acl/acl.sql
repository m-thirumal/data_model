-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: acl | type: DATABASE --
-- -- DROP DATABASE IF EXISTS acl;
-- CREATE DATABASE acl;
-- -- ddl-end --
-- 

-- object: public.acl_sid | type: TABLE --
-- DROP TABLE IF EXISTS public.acl_sid CASCADE;
CREATE TABLE public.acl_sid (
	id bigserial NOT NULL,
	principal boolean NOT NULL,
	sid text NOT NULL,
	CONSTRAINT unique_uk_1 UNIQUE (sid,principal),
	CONSTRAINT acl_sid_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.acl_sid IS E'Created by Thirumal';
-- ddl-end --
-- ALTER TABLE public.acl_sid OWNER TO postgres;
-- ddl-end --

-- object: public.acl_class | type: TABLE --
-- DROP TABLE IF EXISTS public.acl_class CASCADE;
CREATE TABLE public.acl_class (
	id bigserial NOT NULL,
	class text NOT NULL,
	CONSTRAINT unique_uk_2 UNIQUE (class),
	CONSTRAINT acl_class_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.acl_class IS E'Created by Thirumal';
-- ddl-end --
-- ALTER TABLE public.acl_class OWNER TO postgres;
-- ddl-end --

-- object: public.acl_object_identity | type: TABLE --
-- DROP TABLE IF EXISTS public.acl_object_identity CASCADE;
CREATE TABLE public.acl_object_identity (
	id bigserial NOT NULL,
	object_id_class bigint,
	object_id_identity text NOT NULL,
	parent_object bigint,
	owner_sid bigint,
	entries_inheriting boolean NOT NULL,
	CONSTRAINT acl_object_identity_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.acl_object_identity IS E'Created by Thirumal';
-- ddl-end --
-- ALTER TABLE public.acl_object_identity OWNER TO postgres;
-- ddl-end --

-- object: foreign_fk_2 | type: CONSTRAINT --
-- ALTER TABLE public.acl_object_identity DROP CONSTRAINT IF EXISTS foreign_fk_2 CASCADE;
ALTER TABLE public.acl_object_identity ADD CONSTRAINT foreign_fk_2 FOREIGN KEY (object_id_class)
REFERENCES public.acl_class (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: foreign_fk_1 | type: CONSTRAINT --
-- ALTER TABLE public.acl_object_identity DROP CONSTRAINT IF EXISTS foreign_fk_1 CASCADE;
ALTER TABLE public.acl_object_identity ADD CONSTRAINT foreign_fk_1 FOREIGN KEY (parent_object)
REFERENCES public.acl_object_identity (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: foreign_fk_3 | type: CONSTRAINT --
-- ALTER TABLE public.acl_object_identity DROP CONSTRAINT IF EXISTS foreign_fk_3 CASCADE;
ALTER TABLE public.acl_object_identity ADD CONSTRAINT foreign_fk_3 FOREIGN KEY (owner_sid)
REFERENCES public.acl_sid (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: unique_uk_3 | type: CONSTRAINT --
-- ALTER TABLE public.acl_object_identity DROP CONSTRAINT IF EXISTS unique_uk_3 CASCADE;
ALTER TABLE public.acl_object_identity ADD CONSTRAINT unique_uk_3 UNIQUE (object_id_class,object_id_identity);
-- ddl-end --

-- object: public.acl_entry | type: TABLE --
-- DROP TABLE IF EXISTS public.acl_entry CASCADE;
CREATE TABLE public.acl_entry (
	id bigserial NOT NULL,
	acl_object_identity bigint,
	ace_order integer NOT NULL,
	sid bigint,
	mask integer NOT NULL,
	granting boolean NOT NULL,
	audit_success boolean NOT NULL,
	audit_failure boolean NOT NULL,
	CONSTRAINT acl_entry_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.acl_entry IS E'Created by Thirumal';
-- ddl-end --
-- ALTER TABLE public.acl_entry OWNER TO postgres;
-- ddl-end --

-- object: foreign_fk_4 | type: CONSTRAINT --
-- ALTER TABLE public.acl_entry DROP CONSTRAINT IF EXISTS foreign_fk_4 CASCADE;
ALTER TABLE public.acl_entry ADD CONSTRAINT foreign_fk_4 FOREIGN KEY (acl_object_identity)
REFERENCES public.acl_object_identity (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: foreign_fk_5 | type: CONSTRAINT --
-- ALTER TABLE public.acl_entry DROP CONSTRAINT IF EXISTS foreign_fk_5 CASCADE;
ALTER TABLE public.acl_entry ADD CONSTRAINT foreign_fk_5 FOREIGN KEY (sid)
REFERENCES public.acl_sid (id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: unique_uk_4 | type: CONSTRAINT --
-- ALTER TABLE public.acl_entry DROP CONSTRAINT IF EXISTS unique_uk_4 CASCADE;
ALTER TABLE public.acl_entry ADD CONSTRAINT unique_uk_4 UNIQUE (acl_object_identity,ace_order);
-- ddl-end --

-- object: ix_fk_acl_object_identity_acl_class | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_fk_acl_object_identity_acl_class CASCADE;
CREATE INDEX ix_fk_acl_object_identity_acl_class ON public.acl_object_identity
	USING btree
	(
	  object_id_class ASC NULLS LAST
	);
-- ddl-end --

-- object: ix_fk_acl_object_identity_parent_object | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_fk_acl_object_identity_parent_object CASCADE;
CREATE INDEX ix_fk_acl_object_identity_parent_object ON public.acl_object_identity
	USING btree
	(
	  parent_object
	);
-- ddl-end --

-- object: ix_fk_acl_object_identity_owner_sid | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_fk_acl_object_identity_owner_sid CASCADE;
CREATE INDEX ix_fk_acl_object_identity_owner_sid ON public.acl_object_identity
	USING btree
	(
	  owner_sid
	);
-- ddl-end --

-- object: ix_fk_acl_entry_acl_object_identity | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_fk_acl_entry_acl_object_identity CASCADE;
CREATE INDEX ix_fk_acl_entry_acl_object_identity ON public.acl_entry
	USING btree
	(
	  acl_object_identity
	);
-- ddl-end --

-- object: ix_fk_acl_entry_sid | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_fk_acl_entry_sid CASCADE;
CREATE INDEX ix_fk_acl_entry_sid ON public.acl_entry
	USING btree
	(
	  sid
	);
-- ddl-end --


