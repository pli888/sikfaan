--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: NewTable; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public."NewTable" (
    name character varying(64) NOT NULL,
    address character varying(64) NOT NULL,
);

--
-- Name: AuthAssignment; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public."AuthAssignment" (
    itemname character varying(64) NOT NULL,
    userid character varying(64) NOT NULL,
    bizrule text,
    data_col text
);


ALTER TABLE public."AuthAssignment" OWNER TO gigadb;

--
-- Name: AuthItem; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public."AuthItem" (
    name character varying(64) NOT NULL,
    type integer NOT NULL,
    description text,
    bizrule text,
    data text,
    new_col text
);


ALTER TABLE public."AuthItem" OWNER TO gigadb;

--
-- Name: YiiSession; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public."YiiSession" (
    id character(32) NOT NULL,
    data bytea,
    expire integer
);


ALTER TABLE public."YiiSession" OWNER TO gigadb;


--
-- Name: user_command; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public.user_command (
    id integer NOT NULL,
    action_label character varying(32) NOT NULL,
    requester_id integer NOT NULL,
    actioner_id integer,
    actionable_id integer NOT NULL,
    request_date timestamp,
    action_date timestamp,
    status integer
);


ALTER TABLE public.user_command OWNER TO gigadb;

--
-- Name: user_command_id_seq; Type: SEQUENCE; Schema: public; Owner: gigadb
--

CREATE SEQUENCE user_command_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_command_id_seq OWNER TO gigadb;

--
-- Name: user_command_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigadb
--

ALTER SEQUENCE user_command_id_seq OWNED BY user_command.id;

--
-- Name: alternative_identifiers; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public.alternative_identifiers (
    id integer NOT NULL,
    sample_id integer NOT NULL,
    extdb_id integer NOT NULL,
    extdb_accession text
);


ALTER TABLE public.alternative_identifiers OWNER TO gigadb;

--
-- Name: COLUMN alternative_identifiers.id; Type: COMMENT; Schema: public; Owner: gigadb
--

COMMENT ON COLUMN alternative_identifiers.id IS '

';


--
-- Name: alternative_identifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: gigadb
--

CREATE SEQUENCE alternative_identifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.alternative_identifiers_id_seq OWNER TO gigadb;

--
-- Name: alternative_identifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigadb
--

ALTER SEQUENCE alternative_identifiers_id_seq OWNED BY alternative_identifiers.id;


--
-- Name: alternative_identifiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigadb
--

SELECT pg_catalog.setval('alternative_identifiers_id_seq', 1, false);


--
-- Name: attribute; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public.attribute (
    id integer NOT NULL,
    attribute_name character varying(100),
    definition character varying(1000),
    model character varying(100),
    structured_comment_name character varying(100),
    value_syntax character varying(500),
    allowed_units character varying(100),
    occurance character varying(5),
    ontology_link character varying(1000),
    note character varying(100)
);


ALTER TABLE public.attribute OWNER TO gigadb;

--
-- Name: attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: gigadb
--

CREATE SEQUENCE attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.attribute_id_seq OWNER TO gigadb;

--
-- Name: attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigadb
--

ALTER SEQUENCE attribute_id_seq OWNED BY attribute.id;


--
-- Name: attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigadb
--

SELECT pg_catalog.setval('attribute_id_seq', 422, true);


--
-- Name: author; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public.author (
    id integer NOT NULL,
    surname character varying(255) NOT NULL,
    middle_name character varying(255),
    first_name character varying(255),
    custom_name character varying(255),
    orcid character varying(255),
    gigadb_user_id integer UNIQUE
);


ALTER TABLE public.author OWNER TO gigadb;

--
-- Name: author_id_seq; Type: SEQUENCE; Schema: public; Owner: gigadb
--

CREATE SEQUENCE author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.author_id_seq OWNER TO gigadb;

--
-- Name: author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigadb
--

ALTER SEQUENCE author_id_seq OWNED BY author.id;


--
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigadb
--

SELECT pg_catalog.setval('author_id_seq', 3809, true);

--
-- TOC entry 252 (class 1259 OID 18403)
-- Name: author_rel; Type: TABLE; Schema: public; Owner: gigadb
--

CREATE TABLE public.author_rel (
    id integer NOT NULL,
    author_id integer NOT NULL,
    related_author_id integer NOT NULL,
    relationship_id integer
);


ALTER TABLE author_rel OWNER TO gigadb;

--
-- TOC entry 253 (class 1259 OID 18406)
-- Name: author_rel_id_seq; Type: SEQUENCE; Schema: public; Owner: gigadb
--

CREATE SEQUENCE author_rel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE author_rel_id_seq OWNER TO gigadb;

--
-- TOC entry 2903 (class 0 OID 0)
-- Dependencies: 253
-- Name: author_rel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigadb
--

ALTER SEQUENCE author_rel_id_seq OWNED BY author_rel.id;


--
-- Name: dataset; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public.dataset (
    id integer NOT NULL,
    submitter_id integer NOT NULL,
    image_id integer,
    curator_id integer,
    manuscript_id character varying(50),
    identifier character varying(32) NOT NULL,
    title character varying(300) NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    dataset_size bigint NOT NULL,
    ftp_site character varying(100) NOT NULL,
    upload_status character varying(45) DEFAULT 'Pending'::character varying NOT NULL,
    excelfile character varying(50),
    excelfile_md5 character varying(32),
    publication_date date,
    modification_date date,
    publisher_id integer,
    token character varying(16) DEFAULT NULL::character varying,
    fairnuse date
);


ALTER TABLE public.dataset OWNER TO gigadb;

--
-- Name: dataset_attributes; Type: TABLE; Schema: public; Owner: gigadb; Tablespace:
--

CREATE TABLE public.dataset_attributes (
    id integer NOT NULL,
    dataset_id integer,
    attribute_id integer,
    value character varying(200),
    units_id character varying(30),
    image_id integer,
    until_date date
);


ALTER TABLE public.dataset_attributes OWNER TO gigadb;

--
-- Name: dataset_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: gigadb
--

CREATE SEQUENCE dataset_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dataset_attributes_id_seq OWNER TO gigadb;

--
-- Name: dataset_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gigadb
--

ALTER SEQUENCE dataset_attributes_id_seq OWNED BY dataset_attributes.id;


--
-- Name: dataset_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gigadb
--

SELECT pg_catalog.setval('dataset_attributes_id_seq', 35, true);
