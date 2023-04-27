--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-27 23:41:43

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
-- TOC entry 215 (class 1259 OID 16795)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16794)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 214
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- TOC entry 217 (class 1259 OID 16802)
-- Name: image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image (
    id integer NOT NULL,
    file_name character varying(255),
    product_id integer NOT NULL
);


ALTER TABLE public.image OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16801)
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO postgres;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 216
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- TOC entry 227 (class 1259 OID 16874)
-- Name: order_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_person (
    id integer NOT NULL,
    date_time timestamp(6) without time zone,
    number character varying(255),
    price real NOT NULL,
    status smallint,
    person_id integer NOT NULL
);


ALTER TABLE public.order_person OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16873)
-- Name: order_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_person_id_seq OWNER TO postgres;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 226
-- Name: order_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_person_id_seq OWNED BY public.order_person.id;


--
-- TOC entry 219 (class 1259 OID 16809)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    count integer NOT NULL,
    date_time timestamp(6) without time zone,
    number character varying(255),
    price real NOT NULL,
    status smallint,
    person_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16808)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 218
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 221 (class 1259 OID 16816)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    login character varying(100),
    password character varying(255),
    role character varying(255),
    delivery_address character varying(255),
    email character varying(255),
    name_user character varying(255),
    phone_number character varying(255)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16815)
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_id_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 220
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;


--
-- TOC entry 223 (class 1259 OID 16825)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    date_time timestamp(6) without time zone,
    description text NOT NULL,
    price real NOT NULL,
    seller character varying(255) NOT NULL,
    title text NOT NULL,
    category_id integer NOT NULL,
    CONSTRAINT product_price_check CHECK ((price >= (1)::double precision))
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16835)
-- Name: product_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_cart (
    id integer NOT NULL,
    person_id integer,
    product_id integer
);


ALTER TABLE public.product_cart OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16834)
-- Name: product_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_cart_id_seq OWNER TO postgres;

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 224
-- Name: product_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_cart_id_seq OWNED BY public.product_cart.id;


--
-- TOC entry 222 (class 1259 OID 16824)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO postgres;

--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 222
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- TOC entry 3203 (class 2604 OID 16798)
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 16805)
-- Name: image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- TOC entry 3209 (class 2604 OID 16877)
-- Name: order_person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_person ALTER COLUMN id SET DEFAULT nextval('public.order_person_id_seq'::regclass);


--
-- TOC entry 3205 (class 2604 OID 16812)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 3206 (class 2604 OID 16819)
-- Name: person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);


--
-- TOC entry 3207 (class 2604 OID 16828)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 3208 (class 2604 OID 16838)
-- Name: product_cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_cart ALTER COLUMN id SET DEFAULT nextval('public.product_cart_id_seq'::regclass);


--
-- TOC entry 3377 (class 0 OID 16795)
-- Dependencies: 215
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.category (id, name) VALUES (1, 'Сыворотка');
INSERT INTO public.category (id, name) VALUES (2, 'Крем');
INSERT INTO public.category (id, name) VALUES (3, 'Тоник');


--
-- TOC entry 3379 (class 0 OID 16802)
-- Dependencies: 217
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.image (id, file_name, product_id) VALUES (1, 'c2813b15-3175-48fd-8525-7d931c777734.01.jpg', 1);
INSERT INTO public.image (id, file_name, product_id) VALUES (2, '0e8aecdd-d693-4404-9d30-0e8d905e184f.02.jpg', 1);
INSERT INTO public.image (id, file_name, product_id) VALUES (3, '036722be-1add-4ab8-89a3-fb49d00fa74f.03.jpg', 1);
INSERT INTO public.image (id, file_name, product_id) VALUES (4, '010d261f-c24a-46ea-89c7-4027a3158af7.04.jpg', 1);
INSERT INTO public.image (id, file_name, product_id) VALUES (6, '6e8dabdd-5ed2-40f8-8a08-453f197f76b7.11.jpg', 2);
INSERT INTO public.image (id, file_name, product_id) VALUES (7, '6054b0c2-3b61-4fdd-8068-7e54d0f55bba.12.jpg', 2);
INSERT INTO public.image (id, file_name, product_id) VALUES (8, '14363a03-38db-4118-8503-7eda374b0b3c.13.jpg', 2);
INSERT INTO public.image (id, file_name, product_id) VALUES (9, 'bc3531bb-7ec1-47d0-a3d9-be4a95ba2f44.14.jpg', 2);
INSERT INTO public.image (id, file_name, product_id) VALUES (11, '9be57ba8-063a-4ab8-98cd-9da6ee92f7cd.21.jpg', 3);
INSERT INTO public.image (id, file_name, product_id) VALUES (12, '91c6b0e1-d6eb-41f6-88dd-78d6cc8ef1b0.22.jpg', 3);
INSERT INTO public.image (id, file_name, product_id) VALUES (13, '60559a72-23b7-4885-8c0e-c68ec73c06cd.23.jpg', 3);
INSERT INTO public.image (id, file_name, product_id) VALUES (14, '7274cadd-91d4-4d9e-accf-5155b4ac91d0.24.jpg', 3);
INSERT INTO public.image (id, file_name, product_id) VALUES (16, '736cfe2e-aa93-4a3f-ab0a-536c2c1e6189.31.jpg', 4);
INSERT INTO public.image (id, file_name, product_id) VALUES (17, 'f08c9ef5-b3a6-4da4-9c19-5bdd37c31c05.32.jpg', 4);
INSERT INTO public.image (id, file_name, product_id) VALUES (18, '3d3a1b06-0f80-48cd-aed9-7064f3e0611f.33.jpg', 4);
INSERT INTO public.image (id, file_name, product_id) VALUES (19, '536210c4-6b80-4baa-ac42-0f6633116d4b.34.jpg', 4);
INSERT INTO public.image (id, file_name, product_id) VALUES (21, 'fd466e83-cb41-4707-ba0f-1ef0325d14a0.41.jpg', 5);
INSERT INTO public.image (id, file_name, product_id) VALUES (22, 'e30ca66b-5dcd-4520-b0d9-8a335256aa60.42.jpg', 5);
INSERT INTO public.image (id, file_name, product_id) VALUES (23, '46168b94-c0eb-4103-98de-a2a476dc60ec.43.jpg', 5);
INSERT INTO public.image (id, file_name, product_id) VALUES (24, 'eafe37fe-1659-40f1-ad77-fa97f26d7756.44.jpg', 5);
INSERT INTO public.image (id, file_name, product_id) VALUES (26, '8fa8071c-e45b-4372-810f-83afba1e0d74.51.jpg', 6);
INSERT INTO public.image (id, file_name, product_id) VALUES (27, '6f65a289-37b4-4e96-9c2d-add6a6788b03.52.jpg', 6);
INSERT INTO public.image (id, file_name, product_id) VALUES (28, '3ff4e91a-5a3d-4803-9c7b-e49bed14ab7c.53.jpg', 6);
INSERT INTO public.image (id, file_name, product_id) VALUES (29, '1d1a6734-ba24-474a-ac08-5e37e195a532.54.jpg', 6);
INSERT INTO public.image (id, file_name, product_id) VALUES (31, '1699e736-4eff-4708-9f02-aac41315a721.61.jpg', 7);
INSERT INTO public.image (id, file_name, product_id) VALUES (32, 'da701f6b-a94f-4fa4-8a85-10cef0706c3f.62.jpg', 7);
INSERT INTO public.image (id, file_name, product_id) VALUES (33, '18780621-acad-43b7-9d3e-f6de17ba3227.63.jpg', 7);
INSERT INTO public.image (id, file_name, product_id) VALUES (34, 'ba482e38-1661-4553-ac70-6915b265c930.64.jpg', 7);
INSERT INTO public.image (id, file_name, product_id) VALUES (36, 'b0314e9e-c50e-4d29-bcf9-18670afb775a.71.jpg', 8);
INSERT INTO public.image (id, file_name, product_id) VALUES (37, '6c8b8a30-aa19-4ad8-9b9f-a8c641ed4ea2.72.jpg', 8);
INSERT INTO public.image (id, file_name, product_id) VALUES (38, '8a609cac-0fc1-4d49-a2e9-9c2eee91668a.73.jpg', 8);
INSERT INTO public.image (id, file_name, product_id) VALUES (39, 'fc13a46a-dc9a-4c00-b770-ebb47575bc9f.74.jpg', 8);
INSERT INTO public.image (id, file_name, product_id) VALUES (41, 'cf6b7729-0655-449d-88bf-aaeee40707c8.81.jpg', 9);
INSERT INTO public.image (id, file_name, product_id) VALUES (42, '53d71895-369e-47cf-9e98-2a5357d88a02.82.jpg', 9);
INSERT INTO public.image (id, file_name, product_id) VALUES (43, '43f26130-c59f-4aa9-91ec-df5addc4dbdf.83.jpg', 9);
INSERT INTO public.image (id, file_name, product_id) VALUES (44, 'dd8a5b56-73fc-4063-b509-c2bcf70453e9.84.jpg', 9);


--
-- TOC entry 3389 (class 0 OID 16874)
-- Dependencies: 227
-- Data for Name: order_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (3, '2023-04-25 17:22:15.251891', '7d9a5a28-3f60-4983-9846-ed3205f10dc3', 700, 1, 3);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (4, '2023-04-25 17:35:18.121715', '47db6df5-80f2-4507-a8e0-72728c5be043', 870, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (5, '2023-04-25 21:12:05.512797', 'a64c5b79-9bae-4fb8-9fd8-9cd920bd3923', 490, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (6, '2023-04-25 21:24:10.744917', 'c0dfc865-eb17-4f46-8518-4db57a067d52', 260, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (7, '2023-04-27 09:42:57.704687', '3cadbd1d-bfe7-48ac-82e7-46847db101d7', 560, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (9, '2023-04-27 10:05:21.072619', 'e5294317-8977-4407-8b1c-3555279a250c', 590, 1, 4);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (11, '2023-04-27 10:24:17.62906', 'a6f1d0b0-3a7d-46ad-a7a0-15a8d8e792d5', 690, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (12, '2023-04-27 10:27:07.430188', 'cc178b5a-2aed-461b-b40b-d9e4447cc3cd', 490, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (13, '2023-04-27 12:18:37.691778', '0797fcec-91cd-469e-a5da-0a9b7fa6627f', 170, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (14, '2023-04-27 16:27:32.440425', '640aaded-5539-4820-b8fa-acfa3639bcb5', 410, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (15, '2023-04-27 17:42:53.015936', '2efa2b4c-842a-4e7c-8c18-398fb922e7f5', 700, 1, 3);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (16, '2023-04-27 17:44:25.034398', '06d9116c-879d-403c-a679-716739ce2a89', 250, 1, 3);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (17, '2023-04-27 20:47:08.353395', '61a9f715-75d2-4045-851a-939018a35cd9', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (18, '2023-04-27 21:04:29.78927', '3499229c-869f-43ea-a1c9-fc210acfb4e8', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (19, '2023-04-27 21:41:53.253442', '0389a44e-7178-4fd9-a355-6b65d7eb67c3', 180, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (20, '2023-04-27 21:47:38.372734', '8f0f74b0-92bc-4fe1-abb3-b85fc065b373', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (21, '2023-04-27 22:09:43.214841', '69840280-8718-455e-a783-5da3776e032a', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (22, '2023-04-27 22:22:48.324732', 'd744e5b9-6945-402e-8ace-218d71dc8218', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (23, '2023-04-27 22:36:51.65224', 'd45749aa-e6fe-4971-9ded-373cb46a5e79', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (24, '2023-04-27 22:51:29.564123', '00cd2ac5-2a6a-41be-8b51-e944e16f4364', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (8, '2023-04-27 10:03:48.204705', 'b8d2e95a-f6ac-4c99-83aa-feec114697d3', 180, 0, 4);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (10, '2023-04-27 10:05:32.750065', '752b8043-8a00-4576-8cbd-405107859851', 350, 3, 4);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (25, '2023-04-27 22:58:35.857358', '6620a8fe-5285-4f17-b81b-63be8fde6b91', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (2, '2023-04-25 17:21:12.729679', 'b7143938-5b68-44da-b012-13d1603acc89', 460, 0, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (26, '2023-04-27 23:05:16.974842', 'f76f4414-8538-4f4f-bc18-88adffe87897', 360, 1, 2);
INSERT INTO public.order_person (id, date_time, number, price, status, person_id) VALUES (27, '2023-04-27 23:11:42.968613', '9c465535-06ec-49d3-8991-feea875b9ecf', 240, 1, 2);


--
-- TOC entry 3381 (class 0 OID 16809)
-- Dependencies: 219
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3383 (class 0 OID 16816)
-- Dependencies: 221
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person (id, login, password, role, delivery_address, email, name_user, phone_number) VALUES (1, 'admin', '$2a$10$X.Y.KZAuj8zH3XwXNmAY.e3FEMd6t0IYC1dPZFZ8j8851PhRdTv.i', 'ROLE_ADMIN', 'г.Якутск, ул.Строителей, 15, кв.36', 'uek@mail.ru', 'Устинова Елена Константиновна', '+79142751126');
INSERT INTO public.person (id, login, password, role, delivery_address, email, name_user, phone_number) VALUES (3, 'user2', '$2a$10$GVXzaXTXjrUWP36qGwbL1.eBVAXXHz3TFNUNTbmQKpCsyRLE7Ifxu', 'ROLE_USER', 'г.Якутск, ул.Старая, 88, кв.75', 'sos@mail.ru', 'Семенова Ольга Сергеевна', '+79678912345');
INSERT INTO public.person (id, login, password, role, delivery_address, email, name_user, phone_number) VALUES (5, 'user4', '$2a$10$xIuHiTCiN9KWDbTXGgMjTeXS3lV1oPUDvkENb5plXpiq7ZVXeapA2', 'ROLE_USER', 'г.Якутск, ул.Новая, 1', '123@mail.ru', 'Сидорова Светлана Игоревна', '+79142751125');
INSERT INTO public.person (id, login, password, role, delivery_address, email, name_user, phone_number) VALUES (4, 'user3', '$2a$10$vqQUBfO98dr1gycVd67rB.89Ca663inVHXbwcd1VbiFnjPrNRQIgG', 'ROLE_ADMIN', 'г.Якутск, ул.Новая, 1', 'iai@mail.ru', 'Иванова Анна Ивановна', '+79142345678');
INSERT INTO public.person (id, login, password, role, delivery_address, email, name_user, phone_number) VALUES (2, 'user1', '$2a$10$XIVz7mVFJw5stTIQ4//zTODBL.7e.yX/GL70j84zLdtmOMfC3S4XO', 'ROLE_USER', 'г.Якутск, ул.Ленина, 5, кв.7', 'paa@mail.ru', 'Петрова Арина Алексеевна', '+12345678901');


--
-- TOC entry 3385 (class 0 OID 16825)
-- Dependencies: 223
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (2, NULL, 'Объем: 50 мл
Крем-сыворотка создана на основе натуральных масел и экстрактов с применением новейших технологий.
Содержит 97,5% ингредиентов натурального происхождения.
Создана специально для восстановления сухой кожи. За счет высокого содержания масел макадамии, ши и миндаля кожа становится гладкой, эластичной и шелковистой. А экстракт жимолости в сочетании с гиалуроновой кислотой растительного происхождения помогает сохранить влагу в клетках кожи, тонизирует, и укрепляет стенки сосудов что препятствует ее увяданию.
Продукт не содержит парабенов и силиконов.
', 300, 'EO Laboratorie', ' Крем-сыворотка для лица ночная «Интенсивное увлажнение»', 1);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (5, NULL, 'Объем: 50 мл
Дневной крем для лица ECOLATIER® Organic Wild Rose с органическим экстрактом дикой розы предназначен для укрепления коллаген-эластиновых волокон. Разглаживает кожу, повышает тургор. Крем содержит фильтр SPF15, который снижает негативное влияние ультрафиолета.
Соответствует требованиям Vegan Society (Великобритания).
Органические ингредиенты:
Органический экстракт розы является растительным «ретинолом» из -за высокой концентрации био-ретинольных компонентов и еще трехсот активных ингредиентов, что делает его незаменимым компонентом антивозрастных средств. Стимулирует естественные процессы обновления, эффективно разглаживает, восстанавливает кожу, придает ей здоровый и свежий вид.
Активные ингредиенты:
Гиалуроновая кислота интенсивно увлажняет и тонизирует зрелую кожу, активно омолаживает.
Витамин Е питает и защищает клетки кожи, предотвращает разрушение коллагена и замедляет естественное старение.  
Фильтр SPF15 защищает кожу и предупреждает фотостарение: появление сухости, преждевременных морщин и пигментных пятен.
', 250, 'ECOLATIER', 'Дневной крем для лица Серия ORGANIC WILD ROSE', 2);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (3, NULL, 'Объем: 50 мл
Крем-сыворотка создана на основе натуральных масел и экстрактов с применением новейших технологий.
Содержит 97,5% ингредиентов натурального происхождения.
Создана специально для восстановления сухой кожи. За счет высокого содержания масел макадамии, ши и миндаля кожа становится гладкой, эластичной и шелковистой. А экстракт жимолости в сочетании с гиалуроновой кислотой растительного происхождения помогает сохранить влагу в клетках кожи, тонизирует, и укрепляет стенки сосудов что препятствует ее увяданию.
Продукт не содержит парабенов и силиконов.
', 360, 'EO Laboratorie', 'Крем-сыворотка для лица ночная «Интенсивное увлажнение»', 1);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (9, '2023-04-23 21:27:26.603452', 'Объем: 250 мл
Тоник для лица ECOLATIER® Organic Aloe Vera прекрасно тонизирует кожу, наполняет клетки влагой, стимулирует выработку коллагена и эластина. Устраняет чувство стянутости, восстанавливает естественный баланс кожи, сужает поры, подготавливает к дальнейшему уходу.
Соответствует требованиям Vegan Society (Великобритания).
Продукт содержит 100% органический зкстракт алоэ вера.
Органические ингредиенты: Экстракт органического алоэ вера содержит витамины, аминокислоты, минералы, полисахариды, фитонциды, обладает высокой био доступностью и является природным стимулятором регенерации клеток и тканей, обеспечивает глубокое увлажнение, успокаивает кожу, делает ее нежной, мягкой и ухоженной.
Активные ингредиенты: Специальный увлажняющий комплекс восстанавливает гидра-баланс и нормализует распределение влаги в слоях эпидермиса, улучшает эластичность кожи. Витамин Е питает и защищает клетки кожи, предотвращает разрушение коллагена.
', 180, 'ECOLATIER', 'Тоник для лица ОЧИЩЕНИЕ & УВЛАЖНЕНИЕ Серия ORGANIC ALOE VERA', 3);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (1, NULL, 'Объем: 50 мл
Сыворотка в масле ORGANIC Sambuca – это уникальное сочетание обогащенной сыворотки и комплекса масел для ухода за проблемной и склонной к жирности кожей. Активные ингредиенты нормализуют гидро-липидный баланс, оказывают успокаивающее действие, снимают раздражение. Матирует кожу и выравнивает тон.
Соответствует требованиям Vegan Society (Великобритания).
Органические ингредиенты:
Органический экстракт самбуки содержит уникальные фитокомпоненты, которые эффективно успокаивают кожу, устраняют отечность. Самбука является природным антиоксидантом, насыщает клетки кислородом и защищает от воздействия свободных радикалов.
Косметика для лица с экстрактом самбуки направлена на повышение тонуса кожи и снятие воспаления.
Экстракт айвы способствует сужению пор и нормализует выработку кожного себума, обладает матирующим эффектом, разглаживает кожу, восстанавливает ее эластичность.
Масло самбуки содержит натуральные бактерицидные компоненты для ухода за проблемной кожей, которые обладают противовоспалительным и ранозаживляющим действием.
Витамин Е питает и защищает клетки кожи, предотвращает разрушение коллагена и замедляет естественное старение.
', 350, 'ECOLATIER', 'Сыворотка в масле Серия ORGANIC SAMBUCA', 1);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (6, NULL, 'Объем: 50 мл
Крем для лица ECOLATIER® Organic Sambuca деликатно матирует кожу, сохраняя естественный гидро- баланс, выравнивает тон. Активные ингредиенты уменьшают раздражение, увлажняют кожу и сохраняют ее молодость. Может использоваться в качестве крема под макияж.
Соответствует требованиям Vegan Society (Великобритания).
Органические ингредиенты:
Органический экстракт самбуки содержит уникальные фитокомпоненты, которые эффективно успокаивают кожу, устраняют отечность. Самбука является природным антиоксидантом, насыщает клетки кислородом и защищает от воздействия свободных радикалов. Косметика для лица с экстрактом самбуки направлена на повышение тонуса кожи и снятие воспаления.
Экстракт айвы способствует сужению пор и нормализует выработку кожного себума, обладает матирующим эффектом, разглаживает кожу, восстанавливает ее эластичность.
Масло ши обладает выраженными антиоксидантными и восстанавливающими свойствами, помогает сохранить упругость и сияние кожи, улучшает ее состояние и внешний вид.
Витамин Е питает и защищает клетки кожи, предотвращает разрушение коллагена и замедляет естественное старение.
', 240, 'ECOLATIER', 'Дневной крем для лица матирующий Серия ORGANIC SAMBUCA', 2);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (8, NULL, 'Объем: 250 мл
Тоник для лица ECOLAТIER® Organic Cactus прекрасно тонизирует кожу, наполняет клетки влагой, стимулирует выработку коллагена и эластина. Устраняет чувство стянутости, восстанавливает естественный баланс кожи, сужает поры, подготавливает к дальнейшему уходу.
Соответствует требованиям Vegan Society [Великобритания).
Продукт содержит более 98% ингредиентов растительного происхождения.
Органические ингредиенты: Органический экстракт кактуса содержит антиоксиданты, флавоноиды, каротин и витамин С, восстанавливает естественный баланс кожи, интенсивно увлажняет ее, улучшает эластичность.
Активные ингредиенты: Экстракт перуанской маки богат комплексом витаминов и аминокислот для сияния кожи. Тонизирует кожу и придает ей свежий вид. Экстракт австралийского лайма содержит АНА кислоты и обеспечивает деликатное отшелушивание клеток, выравнивает тон лица, делая кожу более гладкой и сияющей.
', 190, 'ECOLATIER', 'Tоник для лица освежающий ГЛАДКОСТЬ & КРАСОТА Серия ORGANIC CACTUS', 3);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (4, NULL, 'Объем: 50 мл
Ночной крем ECOLATIER® Organic Cactus с натуральными активными компонентами в составе создан для глубокого питания, восстановления и омоложения кожи лица. Стимулирует естественные процессы обновления кожи во время сна. Уменьшает выраженность морщин, помогает коже выглядеть свежей и подтянутой.
Соответствует требованиям Vegan Society (Великобритания).
Органические ингредиенты:
Органический экстракт кактуса в высокой концентрации содержит антиоксиданты, флавоноиды, каротин и витамин С, восстанавливает естественный баланс кожи, интенсивно увлажняет ее, улучшает эластичность. Борется с преждевременным старением.
Активные ингредиенты:
Масло ши обладает выраженными восстанавливающими свойствами, стимулируя выработку коллагена. Помогает сохранить упругость кожи, улучшает ее состояние и внешний вид.
Витамин Е питает и защищает клетки кожи, предотвращает разрушение коллагена и замедляет естественное старение.
', 281, 'ECOLATIER', 'Ночной крем для лица Серия ORGANIC CACTUS', 2);
INSERT INTO public.product (id, date_time, description, price, seller, title, category_id) VALUES (7, NULL, 'Объем: 250 мл
Тоник для лица ECOLATIER® ORGANIC Sambuca убирает излишки себума с проблемной и склонной к жирности кожи, сужает поры, снимает раздражение и тонизирует. Восстанавливает гидра-липидный баланс, подготавливает кожу к дальнейшему уходу.
Соответствует требованиям Vegan Society (Великобритания).
Органические ингредиенты:
Органический экстракт самбуки содержит уникальные фитокомпоненты, которые эффективно успокаивают кожу, устраняют отечность. Самбука является природным антиоксидантом, насыщает клетки кислородом и защищает от воздействия свободных радикалов. Косметика для лица с экстрактом самбуки предназначена для ухода за проблемной кожей.
Активные ингредиенты:
Экстракт айвы способствует сужению пор и нормализует выработку кожного себума, обладает матирующим эффектом, разглаживает кожу,
восстанавливает ее эластичность.
Ниацинамид - основной элемент в восстановительном процессе клеток.
', 170, 'ECOLATIER', 'Тоник для лица Серия ORGANIC SAMBUCA', 3);


--
-- TOC entry 3387 (class 0 OID 16835)
-- Dependencies: 225
-- Data for Name: product_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 214
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 3, true);


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 216
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.image_id_seq', 45, true);


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 226
-- Name: order_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_person_id_seq', 27, true);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 218
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 52, true);


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 220
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 5, true);


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 224
-- Name: product_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_cart_id_seq', 88, true);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 222
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 9, true);


--
-- TOC entry 3212 (class 2606 OID 16800)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3214 (class 2606 OID 16807)
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- TOC entry 3226 (class 2606 OID 16879)
-- Name: order_person order_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_person
    ADD CONSTRAINT order_person_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 16814)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3218 (class 2606 OID 16823)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 3224 (class 2606 OID 16840)
-- Name: product_cart product_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT product_cart_pkey PRIMARY KEY (id);


--
-- TOC entry 3220 (class 2606 OID 16833)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 3222 (class 2606 OID 16842)
-- Name: product uk_qka6vxqdy1dprtqnx9trdd47c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c UNIQUE (title);


--
-- TOC entry 3228 (class 2606 OID 16848)
-- Name: orders fk1b0m4muwx1t377w9if3w6wwqn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk1b0m4muwx1t377w9if3w6wwqn FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 3230 (class 2606 OID 16858)
-- Name: product fk1mtsbur82frn64de7balymq9s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk1mtsbur82frn64de7balymq9s FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- TOC entry 3229 (class 2606 OID 16853)
-- Name: orders fk787ibr3guwp6xobrpbofnv7le; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk787ibr3guwp6xobrpbofnv7le FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 3233 (class 2606 OID 16880)
-- Name: order_person fkep8v4imh31iqqdxnt5isiuhq2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_person
    ADD CONSTRAINT fkep8v4imh31iqqdxnt5isiuhq2 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 3227 (class 2606 OID 16843)
-- Name: image fkgpextbyee3uk9u6o2381m7ft1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1 FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 3231 (class 2606 OID 16868)
-- Name: product_cart fkhpnrxdy3jhujameyod08ilvvw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT fkhpnrxdy3jhujameyod08ilvvw FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 3232 (class 2606 OID 16863)
-- Name: product_cart fksgnkc1ko2i1o9yr2p63ysq3rn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT fksgnkc1ko2i1o9yr2p63ysq3rn FOREIGN KEY (person_id) REFERENCES public.person(id);


-- Completed on 2023-04-27 23:41:43

--
-- PostgreSQL database dump complete
--

