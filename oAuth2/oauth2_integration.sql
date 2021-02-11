-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: Thirumal

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public.oauth_integrated_app_details | type: TABLE --
-- DROP TABLE IF EXISTS public.oauth_integrated_app_details CASCADE;
CREATE TABLE public.oauth_integrated_app_details (
	oauth_integrated_app_details_id serial NOT NULL,
	client_id varchar(255),
	resource_ids varchar(255),
	client_secret varchar(255),
	scope varchar(255),
	authorized_grant_types varchar(255),
	web_server_redirect_uri varchar(255),
	authorities varchar(255),
	access_token_validity integer,
	refresh_token_validity integer,
	additional_information varchar(4096),
	autoapprove varchar(255),
	row_creation_time timestamptz DEFAULT current_timestamp,
	CONSTRAINT oauth_integrated_app_details_pk PRIMARY KEY (oauth_integrated_app_details_id)

);
-- ddl-end --
ALTER TABLE public.oauth_integrated_app_details OWNER TO postgres;
-- ddl-end --

-- object: public.oauth_integrated_app_tokens | type: TABLE --
-- DROP TABLE IF EXISTS public.oauth_integrated_app_tokens CASCADE;
CREATE TABLE public.oauth_integrated_app_tokens (
	oauth_integrated_app_details_id integer,
	refresh_token varchar(256) NOT NULL,
	access_token varchar(256) NOT NULL,
	row_creation_time timestamptz NOT NULL DEFAULT current_timestamp
);
-- ddl-end --
ALTER TABLE public.oauth_integrated_app_tokens OWNER TO postgres;
-- ddl-end --

-- object: oauth_integrated_app_details_fk | type: CONSTRAINT --
-- ALTER TABLE public.oauth_integrated_app_tokens DROP CONSTRAINT IF EXISTS oauth_integrated_app_details_fk CASCADE;
ALTER TABLE public.oauth_integrated_app_tokens ADD CONSTRAINT oauth_integrated_app_details_fk FOREIGN KEY (oauth_integrated_app_details_id)
REFERENCES public.oauth_integrated_app_details (oauth_integrated_app_details_id) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --


