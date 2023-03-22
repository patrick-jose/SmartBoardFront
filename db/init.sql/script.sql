--
-- PostgreSQL database cluster dump
--

-- Started on 2023-03-14 06:14:24 -03

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;


--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-14 06:14:24 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2023-03-14 06:14:25 -03

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-14 06:14:25 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2023-03-14 06:14:25 -03

--
-- PostgreSQL database dump complete
--

--
-- Database "smartboarddb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-14 06:14:25 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3385 (class 1262 OID 16384)
-- Name: smartboarddb; Type: DATABASE; Schema: -; Owner: postgres
--


ALTER DATABASE smartboarddb OWNER TO postgres;

\connect smartboarddb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: smartboard; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA smartboard;


ALTER SCHEMA smartboard OWNER TO pg_database_owner;

--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA smartboard; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA smartboard IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16385)
-- Name: board; Type: TABLE; Schema: smartboard; Owner: postgres
--

CREATE TABLE smartboard.board (
    id integer NOT NULL,
    name character varying NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE smartboard.board OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16390)
-- Name: board_id_seq; Type: SEQUENCE; Schema: smartboard; Owner: postgres
--

CREATE SEQUENCE smartboard.board_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE smartboard.board_id_seq OWNER TO postgres;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 215
-- Name: board_id_seq; Type: SEQUENCE OWNED BY; Schema: smartboard; Owner: postgres
--

ALTER SEQUENCE smartboard.board_id_seq OWNED BY smartboard.board.id;


--
-- TOC entry 216 (class 1259 OID 16391)
-- Name: comment; Type: TABLE; Schema: smartboard; Owner: postgres
--

CREATE TABLE smartboard.comment (
    id integer NOT NULL,
    taskid integer NOT NULL,
    writerid integer NOT NULL,
    content character varying NOT NULL,
    datecreation timestamp without time zone NOT NULL
);


ALTER TABLE smartboard.comment OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16396)
-- Name: comment_id_seq; Type: SEQUENCE; Schema: smartboard; Owner: postgres
--

CREATE SEQUENCE smartboard.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE smartboard.comment_id_seq OWNER TO postgres;

--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 217
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: smartboard; Owner: postgres
--

ALTER SEQUENCE smartboard.comment_id_seq OWNED BY smartboard.comment.id;


--
-- TOC entry 218 (class 1259 OID 16397)
-- Name: section; Type: TABLE; Schema: smartboard; Owner: postgres
--

CREATE TABLE smartboard.section (
    id integer NOT NULL,
    name character varying NOT NULL,
    boardid integer NOT NULL,
    active boolean NOT NULL,
    "position" integer DEFAULT 1 NOT NULL
);


ALTER TABLE smartboard.section OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16402)
-- Name: section_id_seq; Type: SEQUENCE; Schema: smartboard; Owner: postgres
--

CREATE SEQUENCE smartboard.section_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE smartboard.section_id_seq OWNER TO postgres;

--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 219
-- Name: section_id_seq; Type: SEQUENCE OWNED BY; Schema: smartboard; Owner: postgres
--

ALTER SEQUENCE smartboard.section_id_seq OWNED BY smartboard.section.id;


--
-- TOC entry 220 (class 1259 OID 16403)
-- Name: statushistory; Type: TABLE; Schema: smartboard; Owner: postgres
--

CREATE TABLE smartboard.statushistory (
    taskid integer NOT NULL,
    datemodified timestamp without time zone,
    previoussectionid integer,
    userid integer NOT NULL,
    actualsectionid integer
);


ALTER TABLE smartboard.statushistory OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16406)
-- Name: task; Type: TABLE; Schema: smartboard; Owner: postgres
--

CREATE TABLE smartboard.task (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    datecreation timestamp without time zone NOT NULL,
    creatorid integer NOT NULL,
    sectionid integer NOT NULL,
    blocked boolean NOT NULL,
    assigneeid integer,
    "position" integer NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE smartboard.task OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16411)
-- Name: task_id_seq; Type: SEQUENCE; Schema: smartboard; Owner: postgres
--

CREATE SEQUENCE smartboard.task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE smartboard.task_id_seq OWNER TO postgres;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 222
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: smartboard; Owner: postgres
--

ALTER SEQUENCE smartboard.task_id_seq OWNED BY smartboard.task.id;


--
-- TOC entry 223 (class 1259 OID 16412)
-- Name: user; Type: TABLE; Schema: smartboard; Owner: postgres
--

CREATE TABLE smartboard."user" (
    id integer NOT NULL,
    name character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE smartboard."user" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16417)
-- Name: user_id_seq; Type: SEQUENCE; Schema: smartboard; Owner: postgres
--

CREATE SEQUENCE smartboard.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE smartboard.user_id_seq OWNER TO postgres;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: smartboard; Owner: postgres
--

ALTER SEQUENCE smartboard.user_id_seq OWNED BY smartboard."user".id;


--
-- TOC entry 3200 (class 2604 OID 16418)
-- Name: board id; Type: DEFAULT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.board ALTER COLUMN id SET DEFAULT nextval('smartboard.board_id_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 16419)
-- Name: comment id; Type: DEFAULT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.comment ALTER COLUMN id SET DEFAULT nextval('smartboard.comment_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 16420)
-- Name: section id; Type: DEFAULT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.section ALTER COLUMN id SET DEFAULT nextval('smartboard.section_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 16421)
-- Name: task id; Type: DEFAULT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.task ALTER COLUMN id SET DEFAULT nextval('smartboard.task_id_seq'::regclass);


--
-- TOC entry 3206 (class 2604 OID 16422)
-- Name: user id; Type: DEFAULT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard."user" ALTER COLUMN id SET DEFAULT nextval('smartboard.user_id_seq'::regclass);


--
-- TOC entry 3369 (class 0 OID 16385)
-- Dependencies: 214
-- Data for Name: board; Type: TABLE DATA; Schema: smartboard; Owner: postgres
--

COPY smartboard.board (id, name, active) FROM stdin;
1	Board 1	t
2	Board 2	t
3	Board 3	f
\.


--
-- TOC entry 3371 (class 0 OID 16391)
-- Dependencies: 216
-- Data for Name: comment; Type: TABLE DATA; Schema: smartboard; Owner: postgres
--

COPY smartboard.comment (id, taskid, writerid, content, datecreation) FROM stdin;
2	1	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
3	1	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
4	2	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
5	3	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
6	3	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
7	3	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
8	3	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
9	5	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
10	6	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
11	7	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
12	9	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
13	9	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
14	10	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
15	11	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
16	11	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
17	11	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
26	17	1	Teste	2023-03-14 00:00:00
18	12	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
19	14	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
20	14	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
21	14	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
22	14	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
23	15	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
24	16	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
25	16	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
27	18	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
28	19	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
29	19	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
30	19	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
31	19	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
32	20	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
33	21	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
34	21	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
35	21	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
36	21	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
37	21	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
38	22	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
39	24	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
40	24	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
41	24	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
42	24	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
43	25	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
44	25	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
45	25	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
46	25	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
47	26	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
48	26	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
49	27	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
50	27	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
51	27	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
52	27	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
53	28	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
54	28	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
55	28	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
56	28	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
57	28	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
58	28	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
59	28	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
60	29	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
61	29	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
62	29	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
63	29	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
64	29	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
65	29	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
1	1	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
66	29	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
69	30	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
70	31	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
71	31	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
72	32	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
73	35	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
74	35	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
75	37	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
76	38	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
77	38	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
78	39	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
79	40	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
80	40	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
67	29	2	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
68	29	1	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2023-03-14 00:00:00
\.


--
-- TOC entry 3373 (class 0 OID 16397)
-- Dependencies: 218
-- Data for Name: section; Type: TABLE DATA; Schema: smartboard; Owner: postgres
--

COPY smartboard.section (id, name, boardid, active, "position") FROM stdin;
1	Backlog	1	t	1
5	Backlog	2	t	1
2	To Do	1	t	2
6	To Do	2	t	2
3	Doing	1	t	3
7	Doing	2	t	3
8	Done	2	t	5
4	Done	1	t	5
9	Testing	1	t	4
10	Testing	2	f	4
\.


--
-- TOC entry 3375 (class 0 OID 16403)
-- Dependencies: 220
-- Data for Name: statushistory; Type: TABLE DATA; Schema: smartboard; Owner: postgres
--

COPY smartboard.statushistory (taskid, datemodified, previoussectionid, userid, actualsectionid) FROM stdin;
5	2023-03-14 00:00:00	1	1	2
6	2023-03-14 00:00:00	1	1	2
7	2023-03-14 00:00:00	1	2	2
8	2023-03-14 00:00:00	1	2	2
9	2023-03-14 00:00:00	1	1	2
10	2023-03-14 00:00:00	1	1	2
11	2023-03-14 00:00:00	1	1	2
11	2023-03-14 00:00:00	2	2	3
12	2023-03-14 00:00:00	1	2	2
12	2023-03-14 00:00:00	2	2	3
13	2023-03-14 00:00:00	2	2	3
13	2023-03-14 00:00:00	3	1	9
14	2023-03-14 00:00:00	3	2	4
15	2023-03-14 00:00:00	2	1	3
15	2023-03-14 00:00:00	3	2	4
16	2023-03-14 00:00:00	1	1	2
16	2023-03-14 00:00:00	2	1	3
16	2023-03-14 00:00:00	3	2	4
17	2023-03-14 00:00:00	2	2	3
17	2023-03-14 00:00:00	3	2	4
18	2023-03-14 00:00:00	2	1	3
18	2023-03-14 00:00:00	3	2	4
25	2023-03-14 00:00:00	5	2	6
26	2023-03-14 00:00:00	5	1	6
27	2023-03-14 00:00:00	5	2	6
28	2023-03-14 00:00:00	5	2	6
29	2023-03-14 00:00:00	5	1	6
30	2023-03-14 00:00:00	5	2	6
30	2023-03-14 00:00:00	6	2	7
31	2023-03-14 00:00:00	6	1	7
31	2023-03-14 00:00:00	7	1	10
32	2023-03-14 00:00:00	6	2	7
32	2023-03-14 00:00:00	7	2	10
33	2023-03-14 00:00:00	6	1	7
33	2023-03-14 00:00:00	7	2	8
34	2023-03-14 00:00:00	6	1	7
34	2023-03-14 00:00:00	7	2	8
35	2023-03-14 00:00:00	7	1	8
36	2023-03-14 00:00:00	5	2	6
36	2023-03-14 00:00:00	6	1	7
36	2023-03-14 00:00:00	7	1	8
37	2023-03-14 00:00:00	5	2	6
37	2023-03-14 00:00:00	6	1	7
37	2023-03-14 00:00:00	7	2	8
38	2023-03-14 00:00:00	5	1	6
38	2023-03-14 00:00:00	6	2	7
38	2023-03-14 00:00:00	7	1	8
39	2023-03-14 00:00:00	5	1	6
39	2023-03-14 00:00:00	6	2	7
39	2023-03-14 00:00:00	7	1	8
40	2023-03-14 00:00:00	6	2	7
40	2023-03-14 00:00:00	7	1	8
\.


--
-- TOC entry 3376 (class 0 OID 16406)
-- Dependencies: 221
-- Data for Name: task; Type: TABLE DATA; Schema: smartboard; Owner: postgres
--

COPY smartboard.task (id, name, description, datecreation, creatorid, sectionid, blocked, assigneeid, "position", active) FROM stdin;
1	Task 1	Description of Task 1	2023-03-13 00:00:00	1	1	f	\N	1	t
2	Task 2	Description of Task 2	2023-03-13 00:00:00	1	1	f	\N	2	t
3	Task 3	Description of Task 3	2023-03-13 00:00:00	1	1	f	\N	3	t
4	Task 4	Description of Task 4	2023-03-13 00:00:00	1	1	f	\N	4	t
5	Task 5	Description of Task 5	2023-03-13 00:00:00	1	2	t	1	1	t
6	Task 6	Description of Task 6	2023-03-13 00:00:00	2	2	f	2	2	t
7	Task 7	Description of Task 7	2023-03-13 00:00:00	2	2	f	\N	3	t
8	Task 8	Description of Task 8	2023-03-13 00:00:00	2	2	f	1	4	t
9	Task 9	Description of Task 9	2023-03-13 00:00:00	1	2	f	1	5	t
10	Task 10	Description of Task 10	2023-03-13 00:00:00	1	2	f	1	6	t
11	Task 11	Description of Task 11	2023-03-13 00:00:00	2	3	f	1	1	t
12	Task 12	Description of Task 12	2023-03-13 00:00:00	2	3	t	2	2	t
13	Task 13	Description of Task 13	2023-03-13 00:00:00	1	9	f	\N	1	t
14	Task 14	Description of Task 14	2023-03-13 00:00:00	1	4	f	1	1	t
15	Task 15	Description of Task 15	2023-03-13 00:00:00	1	4	f	1	2	t
16	Task 16	Description of Task 16	2023-03-13 00:00:00	1	4	f	1	3	t
17	Task 17	Description of Task 17	2023-03-13 00:00:00	2	4	f	1	4	t
18	Task 18	Description of Task 18	2023-03-13 00:00:00	2	4	f	2	5	t
19	Task 19	Description of Task 19	2023-03-13 00:00:00	2	4	f	2	6	t
20	Task 1	Description of Task 1	2023-03-13 00:00:00	2	5	f	\N	1	t
21	Task 2	Description of Task 2	2023-03-13 00:00:00	2	5	f	\N	2	t
22	Task 3	Description of Task 3	2023-03-13 00:00:00	1	5	f	\N	3	t
23	Task 4	Description of Task 4	2023-03-13 00:00:00	1	5	f	\N	4	t
24	Task 5	Description of Task 5	2023-03-13 00:00:00	1	5	f	\N	5	t
25	Task 6	Description of Task 6	2023-03-13 00:00:00	1	6	f	1	1	t
26	Task 7	Description of Task 7	2023-03-13 00:00:00	1	6	t	1	2	t
27	Task 8	Description of Task 8	2023-03-13 00:00:00	1	6	f	2	3	t
28	Task 9	Description of Task 9	2023-03-13 00:00:00	1	6	t	2	4	t
29	Task 10	Description of Task 10	2023-03-13 00:00:00	1	6	f	\N	5	t
30	Task 11	Description of Task 11	2023-03-13 00:00:00	1	7	f	1	1	t
31	Task 12	Description of Task 12	2023-03-13 00:00:00	1	10	f	1	1	t
32	Task 13	Description of Task 13	2023-03-13 00:00:00	1	10	f	2	1	t
33	Task 14	Description of Task 14	2023-03-13 00:00:00	1	8	f	2	1	t
34	Task 15	Description of Task 15	2023-03-13 00:00:00	2	8	f	2	2	t
35	Task 16	Description of Task 16	2023-03-13 00:00:00	2	8	f	2	3	t
36	Task 17	Description of Task 17	2023-03-13 00:00:00	2	8	f	2	4	t
37	Task 18	Description of Task 18	2023-03-13 00:00:00	1	8	f	1	5	t
38	Task 19	Description of Task 19	2023-03-13 00:00:00	1	8	f	1	6	t
39	Task 20	Description of Task 20	2023-03-13 00:00:00	1	8	f	1	7	t
40	Task 21	Description of Task 21	2023-03-13 00:00:00	1	8	f	2	8	t
\.


--
-- TOC entry 3378 (class 0 OID 16412)
-- Dependencies: 223
-- Data for Name: user; Type: TABLE DATA; Schema: smartboard; Owner: postgres
--

COPY smartboard."user" (id, name, password) FROM stdin;
1	Patrick	patrickpw
2	Fabricio	fabriciopw
\.


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 215
-- Name: board_id_seq; Type: SEQUENCE SET; Schema: smartboard; Owner: postgres
--

SELECT pg_catalog.setval('smartboard.board_id_seq', 3, true);


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 217
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: smartboard; Owner: postgres
--

SELECT pg_catalog.setval('smartboard.comment_id_seq', 80, true);


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 219
-- Name: section_id_seq; Type: SEQUENCE SET; Schema: smartboard; Owner: postgres
--

SELECT pg_catalog.setval('smartboard.section_id_seq', 10, true);


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 222
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: smartboard; Owner: postgres
--

SELECT pg_catalog.setval('smartboard.task_id_seq', 40, true);


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: smartboard; Owner: postgres
--

SELECT pg_catalog.setval('smartboard.user_id_seq', 2, true);


--
-- TOC entry 3208 (class 2606 OID 16424)
-- Name: board board_pk; Type: CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.board
    ADD CONSTRAINT board_pk PRIMARY KEY (id);


--
-- TOC entry 3210 (class 2606 OID 16426)
-- Name: comment comment_pk; Type: CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.comment
    ADD CONSTRAINT comment_pk PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 16428)
-- Name: section section_pk; Type: CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.section
    ADD CONSTRAINT section_pk PRIMARY KEY (id);


--
-- TOC entry 3214 (class 2606 OID 16430)
-- Name: task task_pk; Type: CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.task
    ADD CONSTRAINT task_pk PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 16432)
-- Name: user user_pk; Type: CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- TOC entry 3217 (class 2606 OID 16433)
-- Name: comment comment_task_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.comment
    ADD CONSTRAINT comment_task_fk FOREIGN KEY (taskid) REFERENCES smartboard.task(id);


--
-- TOC entry 3218 (class 2606 OID 16438)
-- Name: comment comment_user_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.comment
    ADD CONSTRAINT comment_user_fk FOREIGN KEY (writerid) REFERENCES smartboard."user"(id);


--
-- TOC entry 3219 (class 2606 OID 16443)
-- Name: section section_board_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.section
    ADD CONSTRAINT section_board_fk FOREIGN KEY (boardid) REFERENCES smartboard.board(id);


--
-- TOC entry 3220 (class 2606 OID 16448)
-- Name: statushistory statushistory_actual_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.statushistory
    ADD CONSTRAINT statushistory_actual_fk FOREIGN KEY (actualsectionid) REFERENCES smartboard.section(id);


--
-- TOC entry 3221 (class 2606 OID 16453)
-- Name: statushistory statushistory_previus_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.statushistory
    ADD CONSTRAINT statushistory_previus_fk FOREIGN KEY (previoussectionid) REFERENCES smartboard.section(id);


--
-- TOC entry 3222 (class 2606 OID 16458)
-- Name: statushistory statushistory_task_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.statushistory
    ADD CONSTRAINT statushistory_task_fk FOREIGN KEY (taskid) REFERENCES smartboard.task(id);


--
-- TOC entry 3223 (class 2606 OID 16463)
-- Name: statushistory statushistory_user_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.statushistory
    ADD CONSTRAINT statushistory_user_fk FOREIGN KEY (userid) REFERENCES smartboard."user"(id);


--
-- TOC entry 3225 (class 2606 OID 16473)
-- Name: task task_creator_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.task
    ADD CONSTRAINT task_creator_fk FOREIGN KEY (creatorid) REFERENCES smartboard."user"(id);


--
-- TOC entry 3226 (class 2606 OID 16478)
-- Name: task task_section_fk; Type: FK CONSTRAINT; Schema: smartboard; Owner: postgres
--

ALTER TABLE ONLY smartboard.task
    ADD CONSTRAINT task_section_fk FOREIGN KEY (sectionid) REFERENCES smartboard.section(id);


-- Completed on 2023-03-14 06:14:25 -03

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-03-14 06:14:25 -03

--
-- PostgreSQL database cluster dump complete
--

