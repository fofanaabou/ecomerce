--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: ecommerceapp
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO ecommerceapp;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: ecommerceapp
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO ecommerceapp;

--
-- Name: product; Type: TABLE; Schema: public; Owner: ecommerceapp
--

CREATE TABLE public.product (
    id integer NOT NULL,
    sku character varying(255) DEFAULT NULL::character varying,
    name character varying(255) DEFAULT NULL::character varying,
    description character varying(255) DEFAULT NULL::character varying,
    unit_price numeric(13,2) DEFAULT NULL::numeric,
    image_url character varying(255) DEFAULT NULL::character varying,
    active bit(1) DEFAULT '1'::"bit",
    units_in_stock integer,
    date_created date DEFAULT CURRENT_DATE,
    last_updated date DEFAULT CURRENT_DATE,
    category_id integer NOT NULL
);


ALTER TABLE public.product OWNER TO ecommerceapp;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: ecommerceapp
--

CREATE TABLE public.product_category (
    id integer NOT NULL,
    category_name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.product_category OWNER TO ecommerceapp;

--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: ecommerceapp
--

CREATE SEQUENCE public.product_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_category_id_seq OWNER TO ecommerceapp;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ecommerceapp
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: ecommerceapp
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO ecommerceapp;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ecommerceapp
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: ecommerceapp
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: ecommerceapp
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: ecommerceapp
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
AFO2021	30032021-01	db/changelog/changesets/V1.0/30_01_create.xml	2021-03-30 15:51:14.019591	1	EXECUTED	8:3c9f0a86e6c87f146bacc8f554ae1de0	sql		\N	4.3.2	\N	\N	7112273932
AFO2021	30032021-02	db/changelog/changesets/V1.0/30_01_create.xml	2021-03-30 15:51:14.036803	2	EXECUTED	8:efe11166357782e888bb634ec38235a7	sql		\N	4.3.2	\N	\N	7112273932
AFO2021	13042021-01	db/changelog/changesets/V2.0/30_02_insert.xml	2021-04-12 20:19:16.278118	3	EXECUTED	8:0c153261292c0d05387a272d8b197e97	sql		\N	4.3.2	\N	\N	8251556179
AFO2021	13042021-02	db/changelog/changesets/V2.0/30_02_insert.xml	2021-04-12 20:29:56.127943	4	EXECUTED	8:d2f646bf97eee88214ffae648cefbcf5	sql		\N	4.3.2	\N	\N	8252195888
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: ecommerceapp
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: ecommerceapp
--

COPY public.product (id, sku, name, description, unit_price, image_url, active, units_in_stock, date_created, last_updated, category_id) FROM stdin;
1	BOOK-TECH-1000	Crash Course in Python	Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	14.99	assets/images/products/books/book-luv2code-1000.png	1	100	2021-04-12	2021-04-12	1
2	BOOK-TECH-1001	Become a Guru in JavaScript	Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	20.99	assets/images/products/books/book-luv2code-1001.png	1	100	2021-04-12	2021-04-12	1
3	BOOK-TECH-1002	Exploring Vue.js	Learn Vue.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	14.99	assets/images/products/books/book-luv2code-1002.png	1	100	2021-04-12	2021-04-12	1
4	BOOK-TECH-1003	Advanced Techniques in Big Data	Learn Big Data at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	13.99	assets/images/products/books/book-luv2code-1003.png	1	100	2021-04-12	2021-04-12	1
5	BOOK-TECH-1004	Crash Course in Big Data	Learn Big Data at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	18.99	assets/images/products/books/book-luv2code-1004.png	1	100	2021-04-12	2021-04-12	1
6	BOOK-TECH-1005	JavaScript Cookbook	Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	23.99	assets/images/products/books/book-luv2code-1005.png	1	100	2021-04-12	2021-04-12	1
7	BOOK-TECH-1006	Beginners Guide to SQL	Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	14.99	assets/images/products/books/book-luv2code-1006.png	1	100	2021-04-12	2021-04-12	1
8	BOOK-TECH-1007	Advanced Techniques in JavaScript	Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	16.99	assets/images/products/books/book-luv2code-1007.png	1	100	2021-04-12	2021-04-12	1
9	BOOK-TECH-1008	Introduction to Spring Boot	Learn Spring Boot at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	25.99	assets/images/products/books/book-luv2code-1008.png	1	100	2021-04-12	2021-04-12	1
10	BOOK-TECH-1009	Become a Guru in React.js	Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	23.99	assets/images/products/books/book-luv2code-1009.png	1	100	2021-04-12	2021-04-12	1
11	BOOK-TECH-1010	Beginners Guide to Data Science	Learn Data Science at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	24.99	assets/images/products/books/book-luv2code-1010.png	1	100	2021-04-12	2021-04-12	1
12	BOOK-TECH-1011	Advanced Techniques in Java	Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	19.99	assets/images/products/books/book-luv2code-1011.png	1	100	2021-04-12	2021-04-12	1
13	BOOK-TECH-1012	Exploring DevOps	Learn DevOps at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	24.99	assets/images/products/books/book-luv2code-1012.png	1	100	2021-04-12	2021-04-12	1
14	BOOK-TECH-1013	The Expert Guide to SQL	Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	19.99	assets/images/products/books/book-luv2code-1013.png	1	100	2021-04-12	2021-04-12	1
15	BOOK-TECH-1014	Introduction to SQL	Learn SQL at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	22.99	assets/images/products/books/book-luv2code-1014.png	1	100	2021-04-12	2021-04-12	1
16	BOOK-TECH-1015	The Expert Guide to JavaScript	Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	22.99	assets/images/products/books/book-luv2code-1015.png	1	100	2021-04-12	2021-04-12	1
17	BOOK-TECH-1016	Exploring React.js	Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	27.99	assets/images/products/books/book-luv2code-1016.png	1	100	2021-04-12	2021-04-12	1
18	BOOK-TECH-1017	Advanced Techniques in React.js	Learn React.js at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	13.99	assets/images/products/books/book-luv2code-1017.png	1	100	2021-04-12	2021-04-12	1
19	BOOK-TECH-1018	Introduction to C#	Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	26.99	assets/images/products/books/book-luv2code-1018.png	1	100	2021-04-12	2021-04-12	1
20	BOOK-TECH-1019	Crash Course in JavaScript	Learn JavaScript at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	13.99	assets/images/products/books/book-luv2code-1019.png	1	100	2021-04-12	2021-04-12	1
21	BOOK-TECH-1020	Introduction to Machine Learning	Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	19.99	assets/images/products/books/book-luv2code-1020.png	1	100	2021-04-12	2021-04-12	1
22	BOOK-TECH-1021	Become a Guru in Java	Learn Java at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	18.99	assets/images/products/books/book-luv2code-1021.png	1	100	2021-04-12	2021-04-12	1
23	BOOK-TECH-1022	Introduction to Python	Learn Python at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	26.99	assets/images/products/books/book-luv2code-1022.png	1	100	2021-04-12	2021-04-12	1
24	BOOK-TECH-1023	Advanced Techniques in C#	Learn C# at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	22.99	assets/images/products/books/book-luv2code-1023.png	1	100	2021-04-12	2021-04-12	1
25	BOOK-TECH-1024	The Expert Guide to Machine Learning	Learn Machine Learning at your own pace. The author explains how the technology works in easy-to-understand language. This book includes working examples that you can apply to your own projects. Purchase the book and get started today!	16.99	assets/images/products/books/book-luv2code-1024.png	1	100	2021-04-12	2021-04-12	1
26	COFFEEMUG-1000	Coffee Mug - Express	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1000.png	1	100	2021-04-12	2021-04-12	2
27	COFFEEMUG-1001	Coffee Mug - Cherokee	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1001.png	1	100	2021-04-12	2021-04-12	2
28	COFFEEMUG-1002	Coffee Mug - Sweeper	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1002.png	1	100	2021-04-12	2021-04-12	2
29	COFFEEMUG-1003	Coffee Mug - Aspire	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1003.png	1	100	2021-04-12	2021-04-12	2
30	COFFEEMUG-1004	Coffee Mug - Dorian	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1004.png	1	100	2021-04-12	2021-04-12	2
31	COFFEEMUG-1005	Coffee Mug - Columbia	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1005.png	1	100	2021-04-12	2021-04-12	2
32	COFFEEMUG-1006	Coffee Mug - Worthing	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1006.png	1	100	2021-04-12	2021-04-12	2
33	COFFEEMUG-1007	Coffee Mug - Oak Cliff	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1007.png	1	100	2021-04-12	2021-04-12	2
34	COFFEEMUG-1008	Coffee Mug - Tachyon	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1008.png	1	100	2021-04-12	2021-04-12	2
35	COFFEEMUG-1009	Coffee Mug - Pan	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1009.png	1	100	2021-04-12	2021-04-12	2
36	COFFEEMUG-1010	Coffee Mug - Phase	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1010.png	1	100	2021-04-12	2021-04-12	2
37	COFFEEMUG-1011	Coffee Mug - Falling	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1011.png	1	100	2021-04-12	2021-04-12	2
38	COFFEEMUG-1012	Coffee Mug - Wispy	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1012.png	1	100	2021-04-12	2021-04-12	2
39	COFFEEMUG-1013	Coffee Mug - Arlington	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1013.png	1	100	2021-04-12	2021-04-12	2
40	COFFEEMUG-1014	Coffee Mug - Gazing	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1014.png	1	100	2021-04-12	2021-04-12	2
41	COFFEEMUG-1015	Coffee Mug - Azura	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1015.png	1	100	2021-04-12	2021-04-12	2
42	COFFEEMUG-1016	Coffee Mug - Quantum Leap	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1016.png	1	100	2021-04-12	2021-04-12	2
43	COFFEEMUG-1017	Coffee Mug - Light Years	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1017.png	1	100	2021-04-12	2021-04-12	2
44	COFFEEMUG-1018	Coffee Mug - Taylor	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1018.png	1	100	2021-04-12	2021-04-12	2
45	COFFEEMUG-1019	Coffee Mug - Gracia	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1019.png	1	100	2021-04-12	2021-04-12	2
46	COFFEEMUG-1020	Coffee Mug - Relax	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1020.png	1	100	2021-04-12	2021-04-12	2
47	COFFEEMUG-1021	Coffee Mug - Windermere	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1021.png	1	100	2021-04-12	2021-04-12	2
48	COFFEEMUG-1022	Coffee Mug - Prancer	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1022.png	1	100	2021-04-12	2021-04-12	2
49	COFFEEMUG-1023	Coffee Mug - Recursion	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1023.png	1	100	2021-04-12	2021-04-12	2
50	COFFEEMUG-1024	Coffee Mug - Treasure	Do you love mathematics? If so, then you need this elegant coffee mug with an amazing fractal design. You don\\'t have to worry about boring coffee mugs anymore. This coffee mug will be the topic of conversation in the office, guaranteed! Buy it now!	18.99	assets/images/products/coffeemugs/coffeemug-luv2code-1024.png	1	100	2021-04-12	2021-04-12	2
51	MOUSEPAD-1000	Mouse Pad - Express	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1000.png	1	100	2021-04-12	2021-04-12	3
52	MOUSEPAD-1001	Mouse Pad - Cherokee	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1001.png	1	100	2021-04-12	2021-04-12	3
53	MOUSEPAD-1002	Mouse Pad - Sweeper	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1002.png	1	100	2021-04-12	2021-04-12	3
54	MOUSEPAD-1003	Mouse Pad - Aspire	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1003.png	1	100	2021-04-12	2021-04-12	3
55	MOUSEPAD-1004	Mouse Pad - Dorian	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1004.png	1	100	2021-04-12	2021-04-12	3
56	MOUSEPAD-1005	Mouse Pad - Columbia	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1005.png	1	100	2021-04-12	2021-04-12	3
57	MOUSEPAD-1006	Mouse Pad - Worthing	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1006.png	1	100	2021-04-12	2021-04-12	3
58	MOUSEPAD-1007	Mouse Pad - Oak Cliff	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1007.png	1	100	2021-04-12	2021-04-12	3
59	MOUSEPAD-1008	Mouse Pad - Tachyon	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1008.png	1	100	2021-04-12	2021-04-12	3
60	MOUSEPAD-1009	Mouse Pad - Pan	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1009.png	1	100	2021-04-12	2021-04-12	3
61	MOUSEPAD-1010	Mouse Pad - Phase	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1010.png	1	100	2021-04-12	2021-04-12	3
62	MOUSEPAD-1011	Mouse Pad - Falling	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1011.png	1	100	2021-04-12	2021-04-12	3
63	MOUSEPAD-1012	Mouse Pad - Wispy	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1012.png	1	100	2021-04-12	2021-04-12	3
64	MOUSEPAD-1013	Mouse Pad - Arlington	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1013.png	1	100	2021-04-12	2021-04-12	3
65	MOUSEPAD-1014	Mouse Pad - Gazing	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1014.png	1	100	2021-04-12	2021-04-12	3
66	MOUSEPAD-1015	Mouse Pad - Azura	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1015.png	1	100	2021-04-12	2021-04-12	3
67	MOUSEPAD-1016	Mouse Pad - Quantum Leap	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1016.png	1	100	2021-04-12	2021-04-12	3
68	MOUSEPAD-1017	Mouse Pad - Light Years	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1017.png	1	100	2021-04-12	2021-04-12	3
69	MOUSEPAD-1018	Mouse Pad - Taylor	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1018.png	1	100	2021-04-12	2021-04-12	3
70	MOUSEPAD-1019	Mouse Pad - Gracia	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1019.png	1	100	2021-04-12	2021-04-12	3
71	MOUSEPAD-1020	Mouse Pad - Relax	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1020.png	1	100	2021-04-12	2021-04-12	3
72	MOUSEPAD-1021	Mouse Pad - Windermere	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1021.png	1	100	2021-04-12	2021-04-12	3
73	MOUSEPAD-1022	Mouse Pad - Prancer	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1022.png	1	100	2021-04-12	2021-04-12	3
74	MOUSEPAD-1023	Mouse Pad - Recursion	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1023.png	1	100	2021-04-12	2021-04-12	3
75	MOUSEPAD-1024	Mouse Pad - Treasure	Fractal images are amazing! You can now own a mouse pad with a unique and amazing fractal. The mouse pad is made of a durable and smooth material. Your mouse will easily glide across the mouse pad. This mouse pad will brighten your workspace. Buy it now!	17.99	assets/images/products/mousepads/mousepad-luv2code-1024.png	1	100	2021-04-12	2021-04-12	3
76	LUGGAGETAG-1000	Luggage Tag - Cherish	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1000.png	1	100	2021-04-12	2021-04-12	4
77	LUGGAGETAG-1001	Luggage Tag - Adventure	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1001.png	1	100	2021-04-12	2021-04-12	4
78	LUGGAGETAG-1002	Luggage Tag - Skyline	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1002.png	1	100	2021-04-12	2021-04-12	4
79	LUGGAGETAG-1003	Luggage Tag - River	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1003.png	1	100	2021-04-12	2021-04-12	4
80	LUGGAGETAG-1004	Luggage Tag - Trail Steps	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1004.png	1	100	2021-04-12	2021-04-12	4
81	LUGGAGETAG-1005	Luggage Tag - Blooming	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1005.png	1	100	2021-04-12	2021-04-12	4
82	LUGGAGETAG-1006	Luggage Tag - Park	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1006.png	1	100	2021-04-12	2021-04-12	4
83	LUGGAGETAG-1007	Luggage Tag - Beauty	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1007.png	1	100	2021-04-12	2021-04-12	4
84	LUGGAGETAG-1008	Luggage Tag - Water Fall	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1008.png	1	100	2021-04-12	2021-04-12	4
85	LUGGAGETAG-1009	Luggage Tag - Trail	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1009.png	1	100	2021-04-12	2021-04-12	4
86	LUGGAGETAG-1010	Luggage Tag - Skyscraper	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1010.png	1	100	2021-04-12	2021-04-12	4
87	LUGGAGETAG-1011	Luggage Tag - Leaf	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1011.png	1	100	2021-04-12	2021-04-12	4
88	LUGGAGETAG-1012	Luggage Tag - Jungle	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1012.png	1	100	2021-04-12	2021-04-12	4
89	LUGGAGETAG-1013	Luggage Tag - Shoreline	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1013.png	1	100	2021-04-12	2021-04-12	4
90	LUGGAGETAG-1014	Luggage Tag - Blossom	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1014.png	1	100	2021-04-12	2021-04-12	4
91	LUGGAGETAG-1015	Luggage Tag - Lock	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1015.png	1	100	2021-04-12	2021-04-12	4
92	LUGGAGETAG-1016	Luggage Tag - Cafe	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1016.png	1	100	2021-04-12	2021-04-12	4
93	LUGGAGETAG-1017	Luggage Tag - Darling	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1017.png	1	100	2021-04-12	2021-04-12	4
94	LUGGAGETAG-1018	Luggage Tag - Full Stack	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1018.png	1	100	2021-04-12	2021-04-12	4
95	LUGGAGETAG-1019	Luggage Tag - Courtyard	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1019.png	1	100	2021-04-12	2021-04-12	4
96	LUGGAGETAG-1020	Luggage Tag - Coaster	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1020.png	1	100	2021-04-12	2021-04-12	4
97	LUGGAGETAG-1021	Luggage Tag - Bridge	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1021.png	1	100	2021-04-12	2021-04-12	4
98	LUGGAGETAG-1022	Luggage Tag - Sunset	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1022.png	1	100	2021-04-12	2021-04-12	4
99	LUGGAGETAG-1023	Luggage Tag - Flames	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1023.png	1	100	2021-04-12	2021-04-12	4
100	LUGGAGETAG-1024	Luggage Tag - Countryside	This luggage tag will help you identify your luggage. The luggage tag is very unique and it will stand out from the crowd. The luggage tag is created out of a rugged and durable plastic. Buy this luggage tag now to make it easy to identify your luggage!	16.99	assets/images/products/luggagetags/luggagetag-luv2code-1024.png	1	100	2021-04-12	2021-04-12	4
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: ecommerceapp
--

COPY public.product_category (id, category_name) FROM stdin;
1	Books
2	Coffee Mugs
3	Mouse Pads
4	Luggage Tags
\.


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ecommerceapp
--

SELECT pg_catalog.setval('public.product_category_id_seq', 4, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ecommerceapp
--

SELECT pg_catalog.setval('public.product_id_seq', 100, true);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: ecommerceapp
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: ecommerceapp
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: ecommerceapp
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product fk_category; Type: FK CONSTRAINT; Schema: public; Owner: ecommerceapp
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES public.product_category(id);


--
-- PostgreSQL database dump complete
--

