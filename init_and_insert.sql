--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Ubuntu 14.2-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.2

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

DROP DATABASE IF EXISTS piraterie;
--
-- Name: piraterie; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE piraterie WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C.UTF-8';


ALTER DATABASE piraterie OWNER TO postgres;

\connect piraterie

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cargaison; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargaison (
    id_cargaison integer NOT NULL,
    produit_id integer NOT NULL,
    "quantité" integer,
    voyage_id integer,
    etape integer
);


ALTER TABLE public.cargaison OWNER TO postgres;

--
-- Name: etape transitoire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."etape transitoire" (
    port_id integer,
    voyage_id integer,
    ordre integer,
    changement_passager integer
);


ALTER TABLE public."etape transitoire" OWNER TO postgres;

--
-- Name: nation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nation (
    nom character(20),
    id_nation integer NOT NULL
);


ALTER TABLE public.nation OWNER TO postgres;

--
-- Name: nation_id_nation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nation_id_nation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nation_id_nation_seq OWNER TO postgres;

--
-- Name: nation_id_nation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nation_id_nation_seq OWNED BY public.nation.id_nation;


--
-- Name: navires; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.navires (
    id_navire integer NOT NULL,
    categorie character varying(20),
    typet integer,
    volume integer,
    distancemax integer,
    passagermax integer,
    nation_id integer
);


ALTER TABLE public.navires OWNER TO postgres;

--
-- Name: navires_id_navire_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.navires_id_navire_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.navires_id_navire_seq OWNER TO postgres;

--
-- Name: navires_id_navire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.navires_id_navire_seq OWNED BY public.navires.id_navire;


--
-- Name: ports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ports (
    id_port integer NOT NULL,
    nom character varying(50),
    localisation character varying(50),
    taille integer,
    typet integer,
    nation_id integer NOT NULL
);


ALTER TABLE public.ports OWNER TO postgres;

--
-- Name: ports_id_port_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ports_id_port_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ports_id_port_seq OWNER TO postgres;

--
-- Name: ports_id_port_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ports_id_port_seq OWNED BY public.ports.id_port;


--
-- Name: produits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produits (
    id integer NOT NULL,
    nom character varying(50),
    perisable boolean NOT NULL,
    prix integer,
    poids integer
);


ALTER TABLE public.produits OWNER TO postgres;

--
-- Name: produits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produits_id_seq OWNER TO postgres;

--
-- Name: produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produits_id_seq OWNED BY public.produits.id;


--
-- Name: relation_diplo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relation_diplo (
    nation_id1 integer,
    nation_id2 integer,
    relation character varying(50),
    debut date
);


ALTER TABLE public.relation_diplo OWNER TO postgres;

--
-- Name: voyage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voyage (
    id_voyage integer NOT NULL,
    id_provenance integer,
    id_destination integer,
    distance integer,
    navire_id integer,
    intercontinental boolean,
    debut date,
    fin date,
    voyageur integer,
    CONSTRAINT intercontiental CHECK ((((intercontinental = true) AND (distance >= 1000)) OR (intercontinental <> true)))
);


ALTER TABLE public.voyage OWNER TO postgres;

--
-- Name: voyage_id_voyage_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.voyage_id_voyage_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voyage_id_voyage_seq OWNER TO postgres;

--
-- Name: voyage_id_voyage_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.voyage_id_voyage_seq OWNED BY public.voyage.id_voyage;


--
-- Name: nation id_nation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nation ALTER COLUMN id_nation SET DEFAULT nextval('public.nation_id_nation_seq'::regclass);


--
-- Name: navires id_navire; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.navires ALTER COLUMN id_navire SET DEFAULT nextval('public.navires_id_navire_seq'::regclass);


--
-- Name: ports id_port; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ports ALTER COLUMN id_port SET DEFAULT nextval('public.ports_id_port_seq'::regclass);


--
-- Name: produits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits ALTER COLUMN id SET DEFAULT nextval('public.produits_id_seq'::regclass);


--
-- Name: voyage id_voyage; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voyage ALTER COLUMN id_voyage SET DEFAULT nextval('public.voyage_id_voyage_seq'::regclass);


--
-- Data for Name: cargaison; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (1, 4, 50, 1, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (1, 5, 50, 1, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (12, 3, 100, 12, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (12, 5, 50, 12, 2);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (12, 5, 100, 12, 1);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (12, 4, 100, 12, 2);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (12, 3, 0, 12, 2);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (12, 3, 50, 12, 1);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (11, 1, 20, 11, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (14, 2, 40, 14, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (13, 1, 20, 13, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (15, 5, 60, 15, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (16, 4, 40, 16, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (17, 1, 20, 17, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (23, 3, 100, 23, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (25, 5, 500, 25, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (26, 1, 100, 26, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (26, 2, 100, 26, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (24, 4, 10, 24, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (22, 3, 300, 22, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (21, 4, 30, 21, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (20, 2, 10, 20, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (19, 5, 20, 19, 0);
INSERT INTO public.cargaison (id_cargaison, produit_id, "quantité", voyage_id, etape) VALUES (18, 3, 100, 18, 0);


--
-- Data for Name: etape transitoire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."etape transitoire" (port_id, voyage_id, ordre, changement_passager) VALUES (16, 12, 1, NULL);
INSERT INTO public."etape transitoire" (port_id, voyage_id, ordre, changement_passager) VALUES (17, 12, 2, 0);
INSERT INTO public."etape transitoire" (port_id, voyage_id, ordre, changement_passager) VALUES (2, 13, 1, -100);
INSERT INTO public."etape transitoire" (port_id, voyage_id, ordre, changement_passager) VALUES (17, 23, 1, NULL);


--
-- Data for Name: nation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.nation (nom, id_nation) VALUES ('France              ', 1);
INSERT INTO public.nation (nom, id_nation) VALUES ('Angleterre          ', 2);
INSERT INTO public.nation (nom, id_nation) VALUES ('Espagne             ', 3);
INSERT INTO public.nation (nom, id_nation) VALUES ('Portugal            ', 4);
INSERT INTO public.nation (nom, id_nation) VALUES ('Norvège             ', 5);
INSERT INTO public.nation (nom, id_nation) VALUES ('Italy               ', 6);


--
-- Data for Name: navires; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (1, 'Gallion', 5, 500, 5000, 500, 1);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (2, 'Flute', 1, 10, 500, 20, 1);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (3, 'Gabarre', 2, 30, 800, 50, 1);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (4, 'Gallion', 5, 500, 5000, 500, 2);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (5, 'Flute', 1, 10, 500, 20, 2);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (6, 'Flute', 1, 10, 500, 20, 3);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (7, 'Gallion', 5, 500, 5000, 500, 3);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (8, 'Gabarre', 2, 30, 800, 50, 4);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (9, 'Flute', 1, 10, 500, 20, 4);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (10, 'Gallion', 5, 500, 5000, 500, 5);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (11, 'Gabarre', 2, 30, 800, 50, 5);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (12, 'Drakar', 5, 1000, 10000, 1000, 5);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (13, 'Gallion', 5, 500, 5000, 500, 6);
INSERT INTO public.navires (id_navire, categorie, typet, volume, distancemax, passagermax, nation_id) VALUES (14, 'Gabarre', 2, 30, 800, 50, 6);


--
-- Data for Name: ports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (3, 'Londre', 'Tamise', 5, 2, 2);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (2, 'Bordeaux', 'atlantique', 5, 3, 1);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (1, 'Havre', 'atlantique', 20, 5, 1);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (8, 'Barcelone', 'Mediteranne', 20, 5, 3);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (9, 'Cadix', 'Gibraltar cap', 17, 4, 3);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (10, 'Lisbonne', 'atlantique', 30, 5, 4);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (11, 'Lagos', 'atlantique', 2, 1, 4);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (12, 'Oslo', 'mer du nord', 4, 3, 5);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (13, 'Bergen', 'mer du nord', 2, 1, 5);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (14, 'Venise', 'Mediteranne', 50, 5, 6);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (15, 'Gènes', 'Mediteranne', 5, 3, 6);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (16, 'New York', 'atlantique', 5, 5, 2);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (17, 'Louisiane du Sud', 'atlantique', 2, 5, 1);
INSERT INTO public.ports (id_port, nom, localisation, taille, typet, nation_id) VALUES (4, 'Portsmouth', 'La Manche', 10, 4, 2);


--
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produits (id, nom, perisable, prix, poids) VALUES (2, 'Citron', true, 2, 5);
INSERT INTO public.produits (id, nom, perisable, prix, poids) VALUES (5, 'Sel', false, 20, 1);
INSERT INTO public.produits (id, nom, perisable, prix, poids) VALUES (3, 'Laine', false, 4, 3);
INSERT INTO public.produits (id, nom, perisable, prix, poids) VALUES (1, 'Orange', true, 1, 4);
INSERT INTO public.produits (id, nom, perisable, prix, poids) VALUES (4, 'Poivre', false, 15, 1);


--
-- Data for Name: relation_diplo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 2, 'WAR', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 2, 'PEACE', '1750-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 3, 'PEACE', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 5, 'PEACE', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 5, 'WAR', '1750-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 6, 'WAR', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (1, 4, 'ALLIED', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (2, 3, 'PEACE', '1710-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (2, 3, 'WAR', '1740-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (2, 3, 'PEACE', '1750-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (2, 4, 'PEACE', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (2, 5, 'PEACE', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (2, 6, 'PEACE', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (3, 4, 'PEACE', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (3, 6, 'WAR', '1700-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (3, 4, 'ALLIED', '1750-01-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (4, 6, 'WAR', '1700-05-01');
INSERT INTO public.relation_diplo (nation_id1, nation_id2, relation, debut) VALUES (4, 6, 'PEACE', '1750-01-02');


--
-- Data for Name: voyage; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (1, 1, 2, 300, 3, false, '1700-01-01', '1700-03-01', NULL);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (12, 1, 1, 4000, 1, true, '1750-01-01', '1751-01-01', NULL);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (21, 10, 4, 800, 8, false, '1732-05-13', '1732-07-15', NULL);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (22, 4, 14, 1500, 13, false, '1802-03-08', '1802-07-05', NULL);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (26, 9, 13, 1000, 12, false, '1682-06-01', '1683-01-06', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (11, 2, 1, 300, 3, false, '1700-03-16', '1700-06-01', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (20, 14, 8, 400, 14, false, '1802-05-03', '1802-06-08', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (19, 10, 4, 500, 8, false, '1685-01-02', '1685-05-08', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (14, 12, 13, 100, 10, false, '1768-01-01', '1768-02-01', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (17, 16, 17, 200, 2, false, '1762-05-01', '1762-06-01', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (25, 1, 17, 2000, 1, true, '1812-06-01', '1812-11-09', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (24, 10, 11, 100, 9, false, '1762-05-24', '1762-06-14', 0);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (13, 10, 1, 700, 8, false, '1723-05-10', '1723-08-01', 100);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (15, 15, 9, 200, 14, false, '1742-05-01', '1742-10-01', NULL);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (18, 12, 4, 300, 12, false, '1800-05-09', '1800-07-15', 200);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (16, 3, 4, 100, 5, false, '1708-01-01', '1708-02-01', NULL);
INSERT INTO public.voyage (id_voyage, id_provenance, id_destination, distance, navire_id, intercontinental, debut, fin, voyageur) VALUES (23, 1, 16, 2000, 4, true, '1750-03-18', '1751-02-15', 300);


--
-- Name: nation_id_nation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nation_id_nation_seq', 1, false);


--
-- Name: navires_id_navire_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.navires_id_navire_seq', 1, false);


--
-- Name: ports_id_port_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ports_id_port_seq', 1, false);


--
-- Name: produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produits_id_seq', 1, false);


--
-- Name: voyage_id_voyage_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.voyage_id_voyage_seq', 1, false);


--
-- Name: nation nation_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nation
    ADD CONSTRAINT nation_pk PRIMARY KEY (id_nation);


--
-- Name: navires navires_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.navires
    ADD CONSTRAINT navires_pk PRIMARY KEY (id_navire);


--
-- Name: ports ports_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ports
    ADD CONSTRAINT ports_pk PRIMARY KEY (id_port);


--
-- Name: produits produits_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_pk PRIMARY KEY (id);


--
-- Name: voyage voyage_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voyage
    ADD CONSTRAINT voyage_pk PRIMARY KEY (id_voyage);


--
-- Name: cargaison cargaison_voyage_id_voyage_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargaison
    ADD CONSTRAINT cargaison_voyage_id_voyage_fk FOREIGN KEY (voyage_id) REFERENCES public.voyage(id_voyage);


--
-- Name: etape transitoire etape transitoire_ports_id_port_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."etape transitoire"
    ADD CONSTRAINT "etape transitoire_ports_id_port_fk" FOREIGN KEY (port_id) REFERENCES public.ports(id_port);


--
-- Name: etape transitoire etape transitoire_voyage_id_voyage_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."etape transitoire"
    ADD CONSTRAINT "etape transitoire_voyage_id_voyage_fk" FOREIGN KEY (voyage_id) REFERENCES public.voyage(id_voyage);


--
-- Name: relation_diplo n1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relation_diplo
    ADD CONSTRAINT n1 FOREIGN KEY (nation_id1) REFERENCES public.nation(id_nation);


--
-- Name: relation_diplo n2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relation_diplo
    ADD CONSTRAINT n2 FOREIGN KEY (nation_id2) REFERENCES public.nation(id_nation);


--
-- Name: navires navires_nation_id_nation_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.navires
    ADD CONSTRAINT navires_nation_id_nation_fk FOREIGN KEY (nation_id) REFERENCES public.nation(id_nation);


--
-- Name: ports nid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ports
    ADD CONSTRAINT nid FOREIGN KEY (nation_id) REFERENCES public.nation(id_nation);


--
-- Name: voyage port_destination; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voyage
    ADD CONSTRAINT port_destination FOREIGN KEY (id_destination) REFERENCES public.ports(id_port);


--
-- Name: voyage port_provenance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voyage
    ADD CONSTRAINT port_provenance FOREIGN KEY (id_provenance) REFERENCES public.ports(id_port);


--
-- Name: voyage voyage_navires_id_navire_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voyage
    ADD CONSTRAINT voyage_navires_id_navire_fk FOREIGN KEY (navire_id) REFERENCES public.navires(id_navire);


--
-- PostgreSQL database dump complete
--

