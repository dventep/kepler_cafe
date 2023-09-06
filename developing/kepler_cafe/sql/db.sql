--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2023-09-06 00:25:29

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
-- TOC entry 216 (class 1259 OID 226382)
-- Name: Interaction_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Interaction_question" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(300) NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    with_product boolean NOT NULL
);


ALTER TABLE public."Interaction_question" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 226391)
-- Name: Interaction_question_answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Interaction_question_answer" (
    id bigint NOT NULL,
    score integer,
    description character varying(250),
    creation_date timestamp with time zone NOT NULL,
    product_id bigint,
    question_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public."Interaction_question_answer" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 226390)
-- Name: Interaction_question_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Interaction_question_answer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Interaction_question_answer_id_seq" OWNER TO postgres;

--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 217
-- Name: Interaction_question_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Interaction_question_answer_id_seq" OWNED BY public."Interaction_question_answer".id;


--
-- TOC entry 215 (class 1259 OID 226381)
-- Name: Interaction_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Interaction_question_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Interaction_question_id_seq" OWNER TO postgres;

--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 215
-- Name: Interaction_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Interaction_question_id_seq" OWNED BY public."Interaction_question".id;


--
-- TOC entry 212 (class 1259 OID 226357)
-- Name: Inventory_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Inventory_category" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(250) NOT NULL
);


ALTER TABLE public."Inventory_category" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 226356)
-- Name: Inventory_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Inventory_category_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Inventory_category_id_seq" OWNER TO postgres;

--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 211
-- Name: Inventory_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Inventory_category_id_seq" OWNED BY public."Inventory_category".id;


--
-- TOC entry 214 (class 1259 OID 226366)
-- Name: Inventory_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Inventory_product" (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    money_unit_price double precision NOT NULL,
    point_unit_price integer NOT NULL,
    description character varying(250) NOT NULL,
    quantity integer NOT NULL,
    weight double precision,
    measure_unit character varying(50),
    creation_date timestamp with time zone NOT NULL,
    category_id bigint NOT NULL,
    status boolean NOT NULL,
    image_product character varying(100)
);


ALTER TABLE public."Inventory_product" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 226365)
-- Name: Inventory_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Inventory_product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Inventory_product_id_seq" OWNER TO postgres;

--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 213
-- Name: Inventory_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Inventory_product_id_seq" OWNED BY public."Inventory_product".id;


--
-- TOC entry 235 (class 1259 OID 226544)
-- Name: Movement_main_purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movement_main_purchase" (
    id bigint NOT NULL,
    money_total_value double precision,
    point_total_value integer,
    creation_date timestamp with time zone NOT NULL,
    delivery_date timestamp with time zone,
    user_id bigint NOT NULL
);


ALTER TABLE public."Movement_main_purchase" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 226543)
-- Name: Movement_main_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Movement_main_purchase_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Movement_main_purchase_id_seq" OWNER TO postgres;

--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 234
-- Name: Movement_main_purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Movement_main_purchase_id_seq" OWNED BY public."Movement_main_purchase".id;


--
-- TOC entry 237 (class 1259 OID 226551)
-- Name: Movement_point_transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movement_point_transaction" (
    id bigint NOT NULL,
    quantity_point integer NOT NULL,
    action character varying(50) NOT NULL,
    transaction_date timestamp with time zone NOT NULL,
    purchase_detail_id bigint NOT NULL
);


ALTER TABLE public."Movement_point_transaction" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 226550)
-- Name: Movement_point_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Movement_point_transaction_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Movement_point_transaction_id_seq" OWNER TO postgres;

--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 236
-- Name: Movement_point_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Movement_point_transaction_id_seq" OWNED BY public."Movement_point_transaction".id;


--
-- TOC entry 239 (class 1259 OID 226558)
-- Name: Movement_purchase_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movement_purchase_detail" (
    id bigint NOT NULL,
    money_unit_value double precision,
    point_unit_value integer,
    quantity integer NOT NULL,
    main_purchase_id bigint NOT NULL,
    product_id bigint NOT NULL,
    description character varying(200),
    status character varying(50) NOT NULL
);


ALTER TABLE public."Movement_purchase_detail" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 226557)
-- Name: Movement_purchase_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Movement_purchase_detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Movement_purchase_detail_id_seq" OWNER TO postgres;

--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 238
-- Name: Movement_purchase_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Movement_purchase_detail_id_seq" OWNED BY public."Movement_purchase_detail".id;


--
-- TOC entry 244 (class 1259 OID 234852)
-- Name: Movement_shopping_car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movement_shopping_car" (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    description character varying(200),
    product_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public."Movement_shopping_car" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 234851)
-- Name: Movement_shopping_car_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Movement_shopping_car" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Movement_shopping_car_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 226469)
-- Name: User_charge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User_charge" (
    id bigint NOT NULL,
    name character varying(200) NOT NULL
);


ALTER TABLE public."User_charge" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 226468)
-- Name: User_charge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_charge_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_charge_id_seq" OWNER TO postgres;

--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 227
-- Name: User_charge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_charge_id_seq" OWNED BY public."User_charge".id;


--
-- TOC entry 229 (class 1259 OID 226477)
-- Name: User_userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User_userprofile" (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    identification bigint NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(50) NOT NULL,
    point integer NOT NULL,
    salary double precision,
    creation_date timestamp with time zone NOT NULL,
    entrance_date timestamp with time zone NOT NULL,
    inactive_date timestamp with time zone,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_superuser boolean NOT NULL,
    charge_id bigint,
    date_joined timestamp with time zone NOT NULL,
    birth_date date NOT NULL
);


ALTER TABLE public."User_userprofile" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 226487)
-- Name: User_userprofile_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User_userprofile_groups" (
    id bigint NOT NULL,
    userprofile_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."User_userprofile_groups" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 226486)
-- Name: User_userprofile_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_userprofile_groups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_userprofile_groups_id_seq" OWNER TO postgres;

--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 230
-- Name: User_userprofile_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_userprofile_groups_id_seq" OWNED BY public."User_userprofile_groups".id;


--
-- TOC entry 233 (class 1259 OID 226494)
-- Name: User_userprofile_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User_userprofile_user_permissions" (
    id bigint NOT NULL,
    userprofile_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public."User_userprofile_user_permissions" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 226493)
-- Name: User_userprofile_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_userprofile_user_permissions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_userprofile_user_permissions_id_seq" OWNER TO postgres;

--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 232
-- Name: User_userprofile_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_userprofile_user_permissions_id_seq" OWNED BY public."User_userprofile_user_permissions".id;


--
-- TOC entry 224 (class 1259 OID 226427)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 226426)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 223
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 226 (class 1259 OID 226436)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 226435)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 225
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 222 (class 1259 OID 226420)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 226419)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 221
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 241 (class 1259 OID 226620)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 226619)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 240
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 220 (class 1259 OID 226411)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 226410)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 219
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 210 (class 1259 OID 226348)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 226347)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 209
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 242 (class 1259 OID 226641)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 3255 (class 2604 OID 226385)
-- Name: Interaction_question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question" ALTER COLUMN id SET DEFAULT nextval('public."Interaction_question_id_seq"'::regclass);


--
-- TOC entry 3256 (class 2604 OID 226394)
-- Name: Interaction_question_answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question_answer" ALTER COLUMN id SET DEFAULT nextval('public."Interaction_question_answer_id_seq"'::regclass);


--
-- TOC entry 3253 (class 2604 OID 226360)
-- Name: Inventory_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory_category" ALTER COLUMN id SET DEFAULT nextval('public."Inventory_category_id_seq"'::regclass);


--
-- TOC entry 3254 (class 2604 OID 226369)
-- Name: Inventory_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory_product" ALTER COLUMN id SET DEFAULT nextval('public."Inventory_product_id_seq"'::regclass);


--
-- TOC entry 3264 (class 2604 OID 226547)
-- Name: Movement_main_purchase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_main_purchase" ALTER COLUMN id SET DEFAULT nextval('public."Movement_main_purchase_id_seq"'::regclass);


--
-- TOC entry 3265 (class 2604 OID 226554)
-- Name: Movement_point_transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_point_transaction" ALTER COLUMN id SET DEFAULT nextval('public."Movement_point_transaction_id_seq"'::regclass);


--
-- TOC entry 3266 (class 2604 OID 226561)
-- Name: Movement_purchase_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_purchase_detail" ALTER COLUMN id SET DEFAULT nextval('public."Movement_purchase_detail_id_seq"'::regclass);


--
-- TOC entry 3261 (class 2604 OID 226472)
-- Name: User_charge id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_charge" ALTER COLUMN id SET DEFAULT nextval('public."User_charge_id_seq"'::regclass);


--
-- TOC entry 3262 (class 2604 OID 226490)
-- Name: User_userprofile_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_groups" ALTER COLUMN id SET DEFAULT nextval('public."User_userprofile_groups_id_seq"'::regclass);


--
-- TOC entry 3263 (class 2604 OID 226497)
-- Name: User_userprofile_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_user_permissions" ALTER COLUMN id SET DEFAULT nextval('public."User_userprofile_user_permissions_id_seq"'::regclass);


--
-- TOC entry 3259 (class 2604 OID 226430)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 226439)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 226423)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 226623)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 226414)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 3252 (class 2604 OID 226351)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3520 (class 0 OID 226382)
-- Dependencies: 216
-- Data for Name: Interaction_question; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Interaction_question" (id, name, description, creation_date, with_product) VALUES (1, 'Calificación de servicio de la aplicación', '¿Cómo calificas nuestro servicio?', '2023-08-28 19:34:06-05', false);
INSERT INTO public."Interaction_question" (id, name, description, creation_date, with_product) VALUES (2, 'Calificación del producto', '¿Cómo calificas nuestro producto?', '2023-08-28 19:58:42-05', true);


--
-- TOC entry 3522 (class 0 OID 226391)
-- Dependencies: 218
-- Data for Name: Interaction_question_answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Interaction_question_answer" (id, score, description, creation_date, product_id, question_id, user_id) VALUES (1, 5, 'mee gggs', '2023-08-28 20:25:20.211727-05', 1, 2, 4512);


--
-- TOC entry 3516 (class 0 OID 226357)
-- Dependencies: 212
-- Data for Name: Inventory_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Inventory_category" (id, name, description) VALUES (1, 'Bebidas calientes', 'Calienteee');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (2, 'Bebidas frías', 'Fríassssss');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (3, 'Galletas', 'Categoría de Galletas');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (4, 'Brownie', 'Brownie');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (5, 'Trufa de chocolate', 'Trufa de chocolate');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (6, 'Tarta', 'Tarta');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (7, 'Magdalenas', 'Magdalenas');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (8, 'Fertilizantes', 'Fertilizantes');
INSERT INTO public."Inventory_category" (id, name, description) VALUES (9, 'Composts', 'Composts');


--
-- TOC entry 3518 (class 0 OID 226366)
-- Dependencies: 214
-- Data for Name: Inventory_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (3, 'Café Nebulosa Frío', 2512, 360, 'Esta refrescante bebida fría es una mezcla celestial de café suave, leche condensada y un toque de vainilla. Está adornada con una capa de crema batida y un polvo de cacao que simula las estrellas de una nebulosa. Su sabor suave y dulce te transporta', 160, 350, 'mililitros', '2023-08-20 23:33:10.258459-05', 2, true, 'inventory/products/1.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (1, 'Espresso Galáctico', 4122, 400, 'Este intenso espresso galáctico es una explosión de sabor. Preparado con granos de café de alta calidad y un toque de licor de avellana, este espresso se sirve en una taza de porcelana negra, que parece una ventana al espacio exterior. Su aroma y sab', 51, 120, 'mililitros', '2023-08-20 23:32:22.529467-05', 1, true, 'inventory/products/2.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (2, 'Latte Solar', 5122, 421, 'El Latte Solar es una mezcla cálida y reconfortante de café espresso suave, leche caliente y jarabe de caramelo dorado. La leche vaporizada crea un efecto de remolino que recuerda a las llamaradas solares. Un toque de canela en la parte superior comp', 69, 300, 'mililitros', '2023-08-20 23:32:22.565324-05', 1, true, 'inventory/products/3.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (4, 'Mocha Meteorito', 6700, 700, 'El Mocha Meteorito combina el rico sabor del chocolate negro con el espresso y la leche caliente. Una pizca de polvo de cacao y un pequeño meteorito de malvavisco flotan en la superficie de esta bebida indulgente que te hará sentir como si estuvieras', 520, 220, 'mililitros', '2023-09-05 23:46:13.318435-05', 2, true, 'inventory/products/4.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (5, 'Café Exoplaneta', 6909, 780, 'El Café Exoplaneta es una bebida fría y refrescante que combina café helado con crema de coco y sirope de maracuyá. Su color naranja brillante evoca la imagen de un exoplaneta en el espacio. El toque tropical del maracuyá te hará sentir como si estu', 62, 450, 'mililitros', '2023-09-05 23:57:50.529561-05', 2, true, 'inventory/products/5.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (6, 'Galletas Galácticas de Café', 400, 90, 'Estas galletas son una mezcla celestial de café molido, chocolate negro y trozos de nueces tostadas. Cada galleta tiene forma de una pequeña galaxia con un centro de café y motas de chocolate que simulan las estrellas. Son crujientes por fuera y suav', 290, 20, 'gramos', '2023-09-06 00:05:36.453971-05', 3, true, 'inventory/products/C1.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (7, 'Brownie Planetario de Café', 1100, 120, 'Este brownie de café es una deliciosa obra maestra cósmica. Con capas de brownie de café oscuro y crema de café espiralada, cada porción se asemeja a un pequeño planeta en un plato. El sabor es una combinación perfecta de rico café y chocolate.', 512, 100, 'gramos', '2023-09-06 00:08:06.650178-05', 4, true, 'inventory/products/c2.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (8, 'Trufas Lunares de Café', 400, 70, 'Estas trufas son pequeñas joyas de café y chocolate. Cada trufa tiene un corazón de café espresso cubierto de chocolate negro y polvo de cacao. Su forma redonda y su aspecto brillante recuerdan a la superficie de la luna.', 523, 10, 'gramos', '2023-09-06 00:08:55.333491-05', 5, true, 'inventory/products/c3.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (9, 'Tartaleta de Café Nebulosa', 700, 90, 'Esta tartaleta es una obra de arte cósmica en forma de un pequeño planeta. Está rellena de crema de café suave y se adorna con espirales de caramelo que representan las nubes de una nebulosa. La base de la tartaleta es crujiente y deliciosa.', 51, 50, 'gramos', '2023-09-06 00:10:58.136908-05', 6, true, 'inventory/products/c4.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (10, 'Magdalenas Espaciales de Café', 1500, 140, 'Estas magdalenas son pequeñas obras maestras inspiradas en el espacio. Hechas con café recién molido, cada magdalena tiene un remolino de glaseado de café en la parte superior que simula una galaxia. Su interior es esponjoso y lleno de sabor a café.', 70, 30, 'gramos', '2023-09-06 00:11:46.598183-05', 7, true, 'inventory/products/c5.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (11, 'Fertilizante Estelar de Café', 60000, 890, 'El Fertilizante Estelar de Café es una mezcla especial de restos de café orgánico y nutrientes naturales. Este abono de alta calidad se inspira en la belleza del espacio, con pequeños gránulos que se asemejan a estrellas y planetas. Mejora la calid', 67, 500, 'gramos', '2023-09-06 00:15:37.261692-05', 8, true, 'inventory/products/f1.png');
INSERT INTO public."Inventory_product" (id, name, money_unit_price, point_unit_price, description, quantity, weight, measure_unit, creation_date, category_id, status, image_product) VALUES (12, 'Compost Cósmico de Café', 40000, 11200, 'El Compost Cósmico de Café es una mezcla enriquecida de posos de café, materia orgánica y nutrientes esenciales. Este abono celestial está diseñado para revitalizar el suelo y nutrir tus plantas como si estuvieran en un fértil planeta. Sus componente', 20, 750, 'gramos', '2023-09-06 00:17:54.863432-05', 9, true, 'inventory/products/f2.png');


--
-- TOC entry 3539 (class 0 OID 226544)
-- Dependencies: 235
-- Data for Name: Movement_main_purchase; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Movement_main_purchase" (id, money_total_value, point_total_value, creation_date, delivery_date, user_id) VALUES (9, 8244, 0, '2023-08-27 21:45:46.12528-05', NULL, 4512);


--
-- TOC entry 3541 (class 0 OID 226551)
-- Dependencies: 237
-- Data for Name: Movement_point_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Movement_point_transaction" (id, quantity_point, action, transaction_date, purchase_detail_id) VALUES (8, 10, 'in', '2023-08-27 21:45:46.121351-05', 8);


--
-- TOC entry 3543 (class 0 OID 226558)
-- Dependencies: 239
-- Data for Name: Movement_purchase_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Movement_purchase_detail" (id, money_unit_value, point_unit_value, quantity, main_purchase_id, product_id, description, status) VALUES (8, 4122, NULL, 2, 9, 1, NULL, 'waiting');


--
-- TOC entry 3548 (class 0 OID 234852)
-- Dependencies: 244
-- Data for Name: Movement_shopping_car; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Movement_shopping_car" (id, quantity, creation_date, description, product_id, user_id) VALUES (3, 6, '2023-09-06 00:19:57.823276-05', 'Quiero que sea en salsa de mora', 7, 12345151);


--
-- TOC entry 3532 (class 0 OID 226469)
-- Dependencies: 228
-- Data for Name: User_charge; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3533 (class 0 OID 226477)
-- Dependencies: 229
-- Data for Name: User_userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User_userprofile" (password, last_login, identification, first_name, last_name, email, phone_number, point, salary, creation_date, entrance_date, inactive_date, is_active, is_staff, is_superuser, charge_id, date_joined, birth_date) VALUES ('pbkdf2_sha256$600000$yRjXULy6Vlfw5GK85N8y1B$21yhDND9AIH8Ho/COJ5GcgU2EtXpYPEJb8PJ2xF++mg=', '2023-09-05 21:27:36.882076-05', 5122, 'David', 'Agua', 'shadow@gmail.com', '3125123', 0, NULL, '2023-09-05 20:16:12.788711-05', '2023-09-05 20:16:12.788711-05', NULL, true, false, false, NULL, '2023-09-05 20:16:12.870086-05', '2003-12-29');
INSERT INTO public."User_userprofile" (password, last_login, identification, first_name, last_name, email, phone_number, point, salary, creation_date, entrance_date, inactive_date, is_active, is_staff, is_superuser, charge_id, date_joined, birth_date) VALUES ('pbkdf2_sha256$600000$hg4wgfrge2h1aGtdcDgFBB$qRTrPh3be5EXrfTgaMrdxfz6HR/89OzU1nYbgit/rTU=', '2023-09-05 23:10:05.562716-05', 12345151, 'Admin Kepler', 'Papita Amarilla', 'admin@kepler.com', '', 0, 0, '2023-08-16 14:57:18.303094-05', '2023-08-16 14:57:18.303094-05', NULL, true, true, true, NULL, '2023-08-20 08:46:22.491677-05', '2023-09-08');
INSERT INTO public."User_userprofile" (password, last_login, identification, first_name, last_name, email, phone_number, point, salary, creation_date, entrance_date, inactive_date, is_active, is_staff, is_superuser, charge_id, date_joined, birth_date) VALUES ('pbkdf2_sha256$600000$sxQoGnAmSwh2pel7S87XIk$Jyv8HXEbvHHdmI4ynan9hawd8Tigsdo8O3R8PNgqR+E=', '2023-08-20 10:41:55.875309-05', 4513, 'Camargo Alf', 'Calargo', 'camargo1@gmail.com', '441232', 0, NULL, '2023-08-19 14:26:25.475358-05', '2023-08-19 14:26:25.475358-05', NULL, true, false, false, NULL, '2023-08-20 08:46:22-05', '2023-09-08');
INSERT INTO public."User_userprofile" (password, last_login, identification, first_name, last_name, email, phone_number, point, salary, creation_date, entrance_date, inactive_date, is_active, is_staff, is_superuser, charge_id, date_joined, birth_date) VALUES ('pbkdf2_sha256$600000$Z6yoc7jpWJGLv1UNGwwT3i$VM8QEIu2BtLCHvO7c48UaiATJGwBCux91AcMXKMyxvo=', '2023-08-27 20:13:22.352742-05', 4512, 'Camargo', 'Castañeda', 'davidventepolo@gmail.com', '5123', 10, 0, '2023-08-18 22:57:22.956075-05', '2023-08-18 22:57:22.956075-05', NULL, true, false, false, NULL, '2023-08-20 08:46:22-05', '2023-09-08');


--
-- TOC entry 3535 (class 0 OID 226487)
-- Dependencies: 231
-- Data for Name: User_userprofile_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3537 (class 0 OID 226494)
-- Dependencies: 233
-- Data for Name: User_userprofile_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3528 (class 0 OID 226427)
-- Dependencies: 224
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3530 (class 0 OID 226436)
-- Dependencies: 226
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3526 (class 0 OID 226420)
-- Dependencies: 222
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (1, 'Can add content type', 1, 'add_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (2, 'Can change content type', 1, 'change_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (3, 'Can delete content type', 1, 'delete_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (4, 'Can view content type', 1, 'view_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (13, 'Can add Cargo', 4, 'add_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (14, 'Can change Cargo', 4, 'change_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (15, 'Can delete Cargo', 4, 'delete_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (16, 'Can view Cargo', 4, 'view_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (17, 'Can add Producto', 5, 'add_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (18, 'Can change Producto', 5, 'change_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (19, 'Can delete Producto', 5, 'delete_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (20, 'Can view Producto', 5, 'view_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (25, 'Can add Compra principal', 7, 'add_custom_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (26, 'Can change Compra principal', 7, 'change_custom_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (27, 'Can delete Compra principal', 7, 'delete_custom_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (28, 'Can view Compra principal', 7, 'view_custom_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (29, 'Can add Compra principal', 8, 'add_main_purchase');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (30, 'Can change Compra principal', 8, 'change_main_purchase');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (31, 'Can delete Compra principal', 8, 'delete_main_purchase');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (32, 'Can view Compra principal', 8, 'view_main_purchase');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (33, 'Can add Transacción de puntos', 9, 'add_point_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (34, 'Can change Transacción de puntos', 9, 'change_point_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (35, 'Can delete Transacción de puntos', 9, 'delete_point_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (36, 'Can view Transacción de puntos', 9, 'view_point_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (37, 'Can add Detalle de compra', 10, 'add_purchase_detail');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (38, 'Can change Detalle de compra', 10, 'change_purchase_detail');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (39, 'Can delete Detalle de compra', 10, 'delete_purchase_detail');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (40, 'Can view Detalle de compra', 10, 'view_purchase_detail');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (41, 'Can add Carrito de compra', 11, 'add_product_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (42, 'Can change Carrito de compra', 11, 'change_product_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (43, 'Can delete Carrito de compra', 11, 'delete_product_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (44, 'Can view Carrito de compra', 11, 'view_product_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (45, 'Can add log entry', 12, 'add_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (46, 'Can change log entry', 12, 'change_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (47, 'Can delete log entry', 12, 'delete_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (48, 'Can view log entry', 12, 'view_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (49, 'Can add Pregunta', 13, 'add_question');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (50, 'Can change Pregunta', 13, 'change_question');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (51, 'Can delete Pregunta', 13, 'delete_question');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (52, 'Can view Pregunta', 13, 'view_question');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (53, 'Can add ', 14, 'add_question_answer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (54, 'Can change ', 14, 'change_question_answer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (55, 'Can delete ', 14, 'delete_question_answer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (56, 'Can view ', 14, 'view_question_answer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (57, 'Can add Cargo', 15, 'add_charge');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (58, 'Can change Cargo', 15, 'change_charge');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (59, 'Can delete Cargo', 15, 'delete_charge');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (60, 'Can view Cargo', 15, 'view_charge');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (61, 'Can add Usuario', 16, 'add_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (62, 'Can change Usuario', 16, 'change_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (63, 'Can delete Usuario', 16, 'delete_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (64, 'Can view Usuario', 16, 'view_userprofile');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (65, 'Can add Carrito de compra', 17, 'add_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (66, 'Can change Carrito de compra', 17, 'change_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (67, 'Can delete Carrito de compra', 17, 'delete_shopping_car');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (68, 'Can view Carrito de compra', 17, 'view_shopping_car');


--
-- TOC entry 3545 (class 0 OID 226620)
-- Dependencies: 241
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (1, '2023-08-20 08:57:13.627895-05', '4513', '4513 - Camargo Castañeda', 2, '[{"changed": {"fields": ["Es staff"]}}]', 16, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (2, '2023-08-20 23:31:41.828232-05', '1', 'ID 1 - Bebidas calientes', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (3, '2023-08-20 23:32:22.537513-05', '1', 'ID 1 - Café Qbano', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (4, '2023-08-20 23:32:22.574364-05', '2', 'ID 2 - Café Qbano', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (5, '2023-08-20 23:33:07.94817-05', '2', 'ID 2 - Bebidas frías', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (6, '2023-08-20 23:33:10.265415-05', '3', 'ID 3 - Café Alcabo', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (7, '2023-08-20 23:34:05.224375-05', '1', 'ID 1 - Café Alcanfort', 2, '[{"changed": {"fields": ["Name", "Valor monetario unitario", "Valor de puntos unitario", "Descripci\u00f3n"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (8, '2023-08-25 22:42:49.833972-05', '2', 'ID 2 - Café Qbano', 2, '[{"changed": {"fields": ["Image product"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (9, '2023-08-27 20:12:49.84323-05', '4512', '4512 - Camargo Castañeda', 2, '[{"changed": {"fields": ["Email"]}}]', 16, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (10, '2023-08-27 21:09:59.77374-05', '1', 'ID 1 - Camargo Castañeda -> None ~ None', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (11, '2023-08-27 21:41:27.794727-05', '2', 'ID 2 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (12, '2023-08-27 21:41:27.798229-05', '3', 'ID 3 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (13, '2023-08-27 21:41:27.799207-05', '4', 'ID 4 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (14, '2023-08-27 21:41:27.800175-05', '5', 'ID 5 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (15, '2023-08-27 21:41:27.801147-05', '6', 'ID 6 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (16, '2023-08-27 21:41:27.802123-05', '7', 'ID 7 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (17, '2023-08-27 21:41:27.8031-05', '8', 'ID 8 - Camargo Castañeda -> 8244.0 ~ 0', 3, '', 8, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (18, '2023-08-28 19:34:31.190989-05', '1', 'ID 1 - Calificación de servicio de la aplicación', 1, '[{"added": {}}]', 13, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (19, '2023-08-28 19:58:58.039892-05', '2', 'ID 2 - Calificación del producto', 1, '[{"added": {}}]', 13, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (20, '2023-09-05 23:32:37.247724-05', '3', 'ID 3 - Café Nebulosa Frío', 2, '[{"changed": {"fields": ["Name", "Valor de puntos unitario", "Descripci\u00f3n", "Cantidad", "Peso", "Image product"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (21, '2023-09-05 23:33:50.990263-05', '1', 'ID 1 - Espresso Galáctico', 2, '[{"changed": {"fields": ["Name", "Descripci\u00f3n", "Peso", "Image product"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (22, '2023-09-05 23:35:59.680991-05', '2', 'ID 2 - Latte Solar', 2, '[{"changed": {"fields": ["Name", "Descripci\u00f3n", "Cantidad", "Peso", "Image product"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (23, '2023-09-05 23:46:13.324281-05', '4', 'ID 4 - Mocha Meteorito', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (24, '2023-09-05 23:57:50.535442-05', '5', 'ID 5 - Café Exoplaneta', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (25, '2023-09-05 23:58:17.354685-05', '4', 'ID 4 - Mocha Meteorito', 2, '[{"changed": {"fields": ["Image product"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (26, '2023-09-05 23:59:56.306116-05', '5', 'ID 5 - Café Exoplaneta', 2, '[{"changed": {"fields": ["Valor de puntos unitario", "Cantidad"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (27, '2023-09-06 00:04:04.030093-05', '3', 'ID 3 - Galletas', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (28, '2023-09-06 00:05:36.458854-05', '6', 'ID 6 - Galletas Galácticas de Café', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (29, '2023-09-06 00:06:28.437897-05', '4', 'ID 4 - Brownie', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (30, '2023-09-06 00:08:06.655072-05', '7', 'ID 7 - Brownie Planetario de Café', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (31, '2023-09-06 00:08:53.624072-05', '5', 'ID 5 - Trufa de chocolate', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (32, '2023-09-06 00:08:55.341304-05', '8', 'ID 8 - Trufas Lunares de Café', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (33, '2023-09-06 00:09:51.152873-05', '6', 'ID 6 - Tarta', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (34, '2023-09-06 00:10:58.143731-05', '9', 'ID 9 - Tartaleta de Café Nebulosa', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (35, '2023-09-06 00:11:44.555361-05', '7', 'ID 7 - Magdalenas', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (36, '2023-09-06 00:11:46.599164-05', '10', 'ID 10 - Magdalenas Espaciales de Café', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (37, '2023-09-06 00:12:42.725621-05', '10', 'ID 10 - Magdalenas Espaciales de Café', 2, '[{"changed": {"fields": ["Image product"]}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (38, '2023-09-06 00:14:15.235777-05', '8', 'ID 8 - Fertilizantes', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (39, '2023-09-06 00:15:37.266729-05', '11', 'ID 11 - Fertilizante Estelar de Café', 1, '[{"added": {}}]', 5, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (40, '2023-09-06 00:16:18.397216-05', '9', 'ID 9 - Composts', 1, '[{"added": {}}]', 4, 12345151);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (41, '2023-09-06 00:17:54.86929-05', '12', 'ID 12 - Compost Cósmico de Café', 1, '[{"added": {}}]', 5, 12345151);


--
-- TOC entry 3524 (class 0 OID 226411)
-- Dependencies: 220
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_content_type (id, app_label, model) VALUES (1, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (4, 'Inventory', 'category');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (5, 'Inventory', 'product');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (6, 'sessions', 'session');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (7, 'Movement', 'custom_order');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (8, 'Movement', 'main_purchase');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (9, 'Movement', 'point_transaction');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (10, 'Movement', 'purchase_detail');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (11, 'Movement', 'product_shopping_car');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (12, 'admin', 'logentry');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (13, 'Interaction', 'question');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (14, 'Interaction', 'question_answer');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (15, 'User', 'charge');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (16, 'User', 'userprofile');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (17, 'Movement', 'shopping_car');


--
-- TOC entry 3514 (class 0 OID 226348)
-- Dependencies: 210
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_migrations (id, app, name, applied) VALUES (1, 'Inventory', '0001_initial', '2023-08-16 14:08:07.902728-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (2, 'Interaction', '0001_initial', '2023-08-16 14:08:07.954478-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (3, 'contenttypes', '0001_initial', '2023-08-16 14:08:07.974988-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (4, 'contenttypes', '0002_remove_content_type_name', '2023-08-16 14:08:08.008969-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (5, 'auth', '0001_initial', '2023-08-16 14:08:08.088096-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2023-08-16 14:08:08.100777-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (7, 'auth', '0003_alter_user_email_max_length', '2023-08-16 14:08:08.113064-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (8, 'auth', '0004_alter_user_username_opts', '2023-08-16 14:08:08.124782-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (9, 'auth', '0005_alter_user_last_login_null', '2023-08-16 14:08:08.136486-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (10, 'auth', '0006_require_contenttypes_0002', '2023-08-16 14:08:08.143337-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2023-08-16 14:08:08.155046-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (12, 'auth', '0008_alter_user_username_max_length', '2023-08-16 14:08:08.165796-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (13, 'auth', '0009_alter_user_last_name_max_length', '2023-08-16 14:08:08.177504-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (14, 'auth', '0010_alter_group_name_max_length', '2023-08-16 14:08:08.206431-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (15, 'auth', '0011_update_proxy_permissions', '2023-08-16 14:08:08.220104-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (16, 'auth', '0012_alter_user_first_name_max_length', '2023-08-16 14:08:08.230833-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (17, 'User', '0001_initial', '2023-08-16 14:08:08.335869-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (18, 'Movement', '0001_initial', '2023-08-16 14:08:08.411511-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (19, 'Movement', '0002_initial', '2023-08-16 14:08:08.509901-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (20, 'admin', '0001_initial', '2023-08-16 14:08:08.562606-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (21, 'admin', '0002_logentry_remove_auto_add', '2023-08-16 14:08:08.583107-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (22, 'admin', '0003_logentry_add_action_flag_choices', '2023-08-16 14:08:08.600702-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (23, 'sessions', '0001_initial', '2023-08-16 14:08:08.632509-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (24, 'Inventory', '0002_product_status', '2023-08-16 21:56:55.246768-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (25, 'Movement', '0003_alter_custom_order_options', '2023-08-16 21:56:55.283854-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (26, 'Interaction', '0002_alter_question_answer_product', '2023-08-16 22:15:31.429316-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (27, 'Movement', '0004_product_shopping_car_description_and_more', '2023-08-18 14:30:37.315504-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (28, 'User', '0002_userprofile_date_joined', '2023-08-20 08:46:22.572015-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (29, 'Inventory', '0003_alter_product_description', '2023-08-20 23:23:49.798712-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (30, 'Movement', '0005_shopping_car_delete_product_shopping_car', '2023-08-20 23:23:50.19766-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (31, 'User', '0003_alter_userprofile_salary', '2023-08-20 23:23:50.216441-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (32, 'Inventory', '0004_alter_category_options_product_image_product', '2023-08-25 22:41:11.023676-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (33, 'Movement', '0006_alter_main_purchase_delivery_date', '2023-08-26 09:03:42.482404-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (34, 'Interaction', '0003_question_with_product', '2023-08-28 00:33:48.53678-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (35, 'Interaction', '0004_question_answer_user', '2023-08-28 19:18:42.934049-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (36, 'Interaction', '0005_alter_question_answer_options', '2023-08-30 11:37:28.321033-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (37, 'User', '0004_userprofile_birth_date', '2023-08-30 11:51:17.761795-05');


--
-- TOC entry 3546 (class 0 OID 226641)
-- Dependencies: 242
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('iv1o4f3qg18hxohe334xzl8uk63jw7cn', '.eJxVjr0OwyAQg9-FuUJH-Asdu-cZ0AFHSVsRKSRT1XcvkTK0iwd_tuU387hvxe-NVj8ndmVikEoLLdjlFwWMT6oHTw-s94XHpW7rHPgR4SdtfFoSvW5n9m-gYCu9LYOkAQC0AjQ2ZwUwEnZJNpMRKGL3nUGK0cUsjTL9y4jJCFConGWfL9iNOL8:1qWMea:FrDbCMlnnWryOoGVo_NueoePBdWLkgHRTcYUozQDV64', '2023-08-30 14:58:04.803488-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('0fhgxpaesu8qcb3tpxx74v7rb8d2ihlf', '.eJxVjr0OwyAQg9-FuUJH-Asdu-cZ0AFHSVsRKSRT1XcvkTK0iwd_tuU387hvxe-NVj8ndmVikEoLLdjlFwWMT6oHTw-s94XHpW7rHPgR4SdtfFoSvW5n9m-gYCu9LYOkAQC0AjQ2ZwUwEnZJNpMRKGL3nUGK0cUsjTL9y4jJCFConGWfL9iNOL8:1qX51W:k4dU8ImySHbBzAp-sfUz_PkjkUOBxdFUYOz67FhLPL0', '2023-09-01 14:20:42.330158-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('vwa5hl5yxgta7jgkv4xvmpphu6qusuou', '.eJxVjMsOwiAUBf-FtSFQ3i7d9xsIXC5SNZCUdmX8d0vShW7PzJw38WHfit87rn5J5Eqk4oJcfucY4Il1sPQI9d4otLqtS6RDoSftdG4JX7fT_TsooZejztZY52ACEIAGwGamRBKBOwOcGRXjgXFiLpuoh6WZwJyjNDpIdIx8vmEEOLg:1qXkYt:mYr7Y36XnSQ7bP1oM-Cb35qxOALyc0nEh91W7NeNMG4', '2023-09-03 10:41:55.879303-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('ufar9jq88vm3i4obadvdtc0pwmnombyc', '.eJxVjDEOwjAMRe-SGUWNEzsVIztniOw4JQXUSk07Ie4OlTrA-t97_2USb2tNWytLGtWcTUAH5vQ7C-dHmXamd55us83ztC6j2F2xB232Omt5Xg7376Byq996iADaY4yhMAYgzIFAgLNToaKdkM_eB5KIDjtB7Zl87MPgIYIrZN4fP6A3pw:1qZ25i:_OkYvCjqMsZwCyuM9uJXDoygunsIC92OaSg0_El2XrE', '2023-09-06 23:37:06.837698-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('l4gsoo7bpb02oat8n70r036hwfoqp1dv', '.eJxVjDEOwjAMRe-SGUWNEzsVIztniOw4JQXUSk07Ie4OlTrA-t97_2USb2tNWytLGtWcTUAH5vQ7C-dHmXamd55us83ztC6j2F2xB232Omt5Xg7376Byq996iADaY4yhMAYgzIFAgLNToaKdkM_eB5KIDjtB7Zl87MPgIYIrZN4fP6A3pw:1qaQok:l6G3DtKM_Je5iPja_nX6EEt9T4U0-yJFDoTrFKwYomo', '2023-09-10 20:13:22.355674-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('kushy6v82xhqgi5ivm09pkdt34hzr916', '.eJxVjEEOwiAQRe_C2hChDBSX7nsGMjMMUjVtUtqV8e7apAvd_vfef6mE21rT1mRJY1YXBcZadfqdCfkh087yHafbrHme1mUkvSv6oE0Pc5bn9XD_Diq2-q1RrMkAwbtMXVd6AO8wFiieY3Bs-si2ZAnnYHx0JnpGSywknQMUIvX-AE65ONw:1qdi5F:39DEZSdfqXHhBq4xHwcrbLFEr-8OCN3-QJWMRU59F2M', '2023-09-19 21:15:57.180113-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('s5ptwczawlazplaeolpxanl2l5ie4mru', '.eJxVjEEOwiAQRe_C2hChDBSX7nsGMjMMUjVtUtqV8e7apAvd_vfef6mE21rT1mRJY1YXBcZadfqdCfkh087yHafbrHme1mUkvSv6oE0Pc5bn9XD_Diq2-q1RrMkAwbtMXVd6AO8wFiieY3Bs-si2ZAnnYHx0JnpGSywknQMUIvX-AE65ONw:1qdi5i:ru4Srv9KuSWQYyDO4MxP8lKjJAPu24p1Gl-hOygmgZk', '2023-09-19 21:16:26.291844-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('n8latrksid8efa3d7h04h5zahkvq7m4v', '.eJxVjEEOwiAQRe_C2hChDBSX7nsGMjMMUjVtUtqV8e7apAvd_vfef6mE21rT1mRJY1YXBcZadfqdCfkh087yHafbrHme1mUkvSv6oE0Pc5bn9XD_Diq2-q1RrMkAwbtMXVd6AO8wFiieY3Bs-si2ZAnnYHx0JnpGSywknQMUIvX-AE65ONw:1qdiGW:m5IkTAZBPq-bKQ0_U07HDXwFQViVqorOuIonS2d0LME', '2023-09-19 21:27:36.892693-05');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('cf06hivp5vkyg7hepy8tf64u1af5l284', '.eJxVjMsOwiAQRf-FtSHlMQVcuvcbyAwDtmpKUtqV8d-VpAvd3eScc18i4r5NcW95jTOLs1DaWFCgxOkXEaZHXjrnOy63KlNdtnUm2RV50CavlfPzcrh_BxO2qddcvLYFR2WVA0_AAJoDBrIAYSijceSCJ-2Lx-SsxQG_M5SkyTAq8f4A5Wk5UA:1qdjrh:9tpSm9u0S8IVZU6Wofr7xMEfSJfohfX6rfAi4OoQYhQ', '2023-09-19 23:10:05.569611-05');


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 217
-- Name: Interaction_question_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Interaction_question_answer_id_seq"', 1, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 215
-- Name: Interaction_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Interaction_question_id_seq"', 2, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 211
-- Name: Inventory_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Inventory_category_id_seq"', 9, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 213
-- Name: Inventory_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Inventory_product_id_seq"', 12, true);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 234
-- Name: Movement_main_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movement_main_purchase_id_seq"', 9, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 236
-- Name: Movement_point_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movement_point_transaction_id_seq"', 8, true);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 238
-- Name: Movement_purchase_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movement_purchase_detail_id_seq"', 8, true);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 243
-- Name: Movement_shopping_car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movement_shopping_car_id_seq"', 3, true);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 227
-- Name: User_charge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_charge_id_seq"', 1, false);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 230
-- Name: User_userprofile_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_userprofile_groups_id_seq"', 1, false);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 232
-- Name: User_userprofile_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_userprofile_user_permissions_id_seq"', 1, false);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 223
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 225
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 221
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 68, true);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 240
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 41, true);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 219
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 209
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 37, true);


--
-- TOC entry 3285 (class 2606 OID 226396)
-- Name: Interaction_question_answer Interaction_question_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question_answer"
    ADD CONSTRAINT "Interaction_question_answer_pkey" PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 226389)
-- Name: Interaction_question Interaction_question_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question"
    ADD CONSTRAINT "Interaction_question_name_key" UNIQUE (name);


--
-- TOC entry 3283 (class 2606 OID 226387)
-- Name: Interaction_question Interaction_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question"
    ADD CONSTRAINT "Interaction_question_pkey" PRIMARY KEY (id);


--
-- TOC entry 3273 (class 2606 OID 226364)
-- Name: Inventory_category Inventory_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory_category"
    ADD CONSTRAINT "Inventory_category_name_key" UNIQUE (name);


--
-- TOC entry 3275 (class 2606 OID 226362)
-- Name: Inventory_category Inventory_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory_category"
    ADD CONSTRAINT "Inventory_category_pkey" PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 226373)
-- Name: Inventory_product Inventory_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory_product"
    ADD CONSTRAINT "Inventory_product_pkey" PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 226549)
-- Name: Movement_main_purchase Movement_main_purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_main_purchase"
    ADD CONSTRAINT "Movement_main_purchase_pkey" PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 226556)
-- Name: Movement_point_transaction Movement_point_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_point_transaction"
    ADD CONSTRAINT "Movement_point_transaction_pkey" PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 226563)
-- Name: Movement_purchase_detail Movement_purchase_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_purchase_detail"
    ADD CONSTRAINT "Movement_purchase_detail_pkey" PRIMARY KEY (id);


--
-- TOC entry 3351 (class 2606 OID 234856)
-- Name: Movement_shopping_car Movement_shopping_car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_shopping_car"
    ADD CONSTRAINT "Movement_shopping_car_pkey" PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 226476)
-- Name: User_charge User_charge_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_charge"
    ADD CONSTRAINT "User_charge_name_key" UNIQUE (name);


--
-- TOC entry 3313 (class 2606 OID 226474)
-- Name: User_charge User_charge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_charge"
    ADD CONSTRAINT "User_charge_pkey" PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 226485)
-- Name: User_userprofile User_userprofile_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile"
    ADD CONSTRAINT "User_userprofile_email_key" UNIQUE (email);


--
-- TOC entry 3322 (class 2606 OID 226492)
-- Name: User_userprofile_groups User_userprofile_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_groups"
    ADD CONSTRAINT "User_userprofile_groups_pkey" PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 226509)
-- Name: User_userprofile_groups User_userprofile_groups_userprofile_id_group_id_6ef09298_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_groups"
    ADD CONSTRAINT "User_userprofile_groups_userprofile_id_group_id_6ef09298_uniq" UNIQUE (userprofile_id, group_id);


--
-- TOC entry 3319 (class 2606 OID 226483)
-- Name: User_userprofile User_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile"
    ADD CONSTRAINT "User_userprofile_pkey" PRIMARY KEY (identification);


--
-- TOC entry 3327 (class 2606 OID 226523)
-- Name: User_userprofile_user_permissions User_userprofile_user_pe_userprofile_id_permissio_b23258ac_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_user_permissions"
    ADD CONSTRAINT "User_userprofile_user_pe_userprofile_id_permissio_b23258ac_uniq" UNIQUE (userprofile_id, permission_id);


--
-- TOC entry 3330 (class 2606 OID 226499)
-- Name: User_userprofile_user_permissions User_userprofile_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_user_permissions"
    ADD CONSTRAINT "User_userprofile_user_permissions_pkey" PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 226466)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3305 (class 2606 OID 226452)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3308 (class 2606 OID 226441)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 226432)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3295 (class 2606 OID 226443)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3297 (class 2606 OID 226425)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 226628)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 226418)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3292 (class 2606 OID 226416)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 226355)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 226647)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3286 (class 1259 OID 226408)
-- Name: Interaction_question_answer_product_id_d8f450e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Interaction_question_answer_product_id_d8f450e9" ON public."Interaction_question_answer" USING btree (product_id);


--
-- TOC entry 3287 (class 1259 OID 226409)
-- Name: Interaction_question_answer_question_id_dfe4f2fd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Interaction_question_answer_question_id_dfe4f2fd" ON public."Interaction_question_answer" USING btree (question_id);


--
-- TOC entry 3288 (class 1259 OID 234926)
-- Name: Interaction_question_answer_user_id_39ecd8fb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Interaction_question_answer_user_id_39ecd8fb" ON public."Interaction_question_answer" USING btree (user_id);


--
-- TOC entry 3279 (class 1259 OID 226397)
-- Name: Interaction_question_name_bc91991f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Interaction_question_name_bc91991f_like" ON public."Interaction_question" USING btree (name varchar_pattern_ops);


--
-- TOC entry 3271 (class 1259 OID 226374)
-- Name: Inventory_category_name_1d375d68_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Inventory_category_name_1d375d68_like" ON public."Inventory_category" USING btree (name varchar_pattern_ops);


--
-- TOC entry 3276 (class 1259 OID 226380)
-- Name: Inventory_product_category_id_abccaca3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Inventory_product_category_id_abccaca3" ON public."Inventory_product" USING btree (category_id);


--
-- TOC entry 3334 (class 1259 OID 226616)
-- Name: Movement_main_purchase_user_id_7f326411; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movement_main_purchase_user_id_7f326411" ON public."Movement_main_purchase" USING btree (user_id);


--
-- TOC entry 3337 (class 1259 OID 226615)
-- Name: Movement_point_transaction_purchase_detail_id_9da1d112; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movement_point_transaction_purchase_detail_id_9da1d112" ON public."Movement_point_transaction" USING btree (purchase_detail_id);


--
-- TOC entry 3338 (class 1259 OID 226581)
-- Name: Movement_purchase_detail_main_purchase_id_e59d2237; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movement_purchase_detail_main_purchase_id_e59d2237" ON public."Movement_purchase_detail" USING btree (main_purchase_id);


--
-- TOC entry 3341 (class 1259 OID 226582)
-- Name: Movement_purchase_detail_product_id_6a5e6043; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movement_purchase_detail_product_id_6a5e6043" ON public."Movement_purchase_detail" USING btree (product_id);


--
-- TOC entry 3352 (class 1259 OID 234867)
-- Name: Movement_shopping_car_product_id_01e4ffef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movement_shopping_car_product_id_01e4ffef" ON public."Movement_shopping_car" USING btree (product_id);


--
-- TOC entry 3353 (class 1259 OID 234868)
-- Name: Movement_shopping_car_user_id_b60f18ce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movement_shopping_car_user_id_b60f18ce" ON public."Movement_shopping_car" USING btree (user_id);


--
-- TOC entry 3309 (class 1259 OID 226500)
-- Name: User_charge_name_23ef2c6a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_charge_name_23ef2c6a_like" ON public."User_charge" USING btree (name varchar_pattern_ops);


--
-- TOC entry 3314 (class 1259 OID 226507)
-- Name: User_userprofile_charge_id_908db123; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_userprofile_charge_id_908db123" ON public."User_userprofile" USING btree (charge_id);


--
-- TOC entry 3315 (class 1259 OID 226506)
-- Name: User_userprofile_email_0cda51af_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_userprofile_email_0cda51af_like" ON public."User_userprofile" USING btree (email varchar_pattern_ops);


--
-- TOC entry 3320 (class 1259 OID 226521)
-- Name: User_userprofile_groups_group_id_508a2183; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_userprofile_groups_group_id_508a2183" ON public."User_userprofile_groups" USING btree (group_id);


--
-- TOC entry 3323 (class 1259 OID 226520)
-- Name: User_userprofile_groups_userprofile_id_6b5554d1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_userprofile_groups_userprofile_id_6b5554d1" ON public."User_userprofile_groups" USING btree (userprofile_id);


--
-- TOC entry 3328 (class 1259 OID 226535)
-- Name: User_userprofile_user_permissions_permission_id_948bcf18; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_userprofile_user_permissions_permission_id_948bcf18" ON public."User_userprofile_user_permissions" USING btree (permission_id);


--
-- TOC entry 3331 (class 1259 OID 226534)
-- Name: User_userprofile_user_permissions_userprofile_id_4e02c612; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_userprofile_user_permissions_userprofile_id_4e02c612" ON public."User_userprofile_user_permissions" USING btree (userprofile_id);


--
-- TOC entry 3298 (class 1259 OID 226467)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3303 (class 1259 OID 226463)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3306 (class 1259 OID 226464)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3293 (class 1259 OID 226449)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3342 (class 1259 OID 226639)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3345 (class 1259 OID 226640)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3346 (class 1259 OID 226649)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3349 (class 1259 OID 226648)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3356 (class 2606 OID 226652)
-- Name: Interaction_question_answer Interaction_question_product_id_d8f450e9_fk_Inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question_answer"
    ADD CONSTRAINT "Interaction_question_product_id_d8f450e9_fk_Inventory" FOREIGN KEY (product_id) REFERENCES public."Inventory_product"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3355 (class 2606 OID 226403)
-- Name: Interaction_question_answer Interaction_question_question_id_dfe4f2fd_fk_Interacti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question_answer"
    ADD CONSTRAINT "Interaction_question_question_id_dfe4f2fd_fk_Interacti" FOREIGN KEY (question_id) REFERENCES public."Interaction_question"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3357 (class 2606 OID 234921)
-- Name: Interaction_question_answer Interaction_question_user_id_39ecd8fb_fk_User_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Interaction_question_answer"
    ADD CONSTRAINT "Interaction_question_user_id_39ecd8fb_fk_User_user" FOREIGN KEY (user_id) REFERENCES public."User_userprofile"(identification) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3354 (class 2606 OID 226375)
-- Name: Inventory_product Inventory_product_category_id_abccaca3_fk_Inventory_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Inventory_product"
    ADD CONSTRAINT "Inventory_product_category_id_abccaca3_fk_Inventory_category_id" FOREIGN KEY (category_id) REFERENCES public."Inventory_category"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3366 (class 2606 OID 226599)
-- Name: Movement_main_purchase Movement_main_purcha_user_id_7f326411_fk_User_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_main_purchase"
    ADD CONSTRAINT "Movement_main_purcha_user_id_7f326411_fk_User_user" FOREIGN KEY (user_id) REFERENCES public."User_userprofile"(identification) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3367 (class 2606 OID 226594)
-- Name: Movement_point_transaction Movement_point_trans_purchase_detail_id_9da1d112_fk_Movement_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_point_transaction"
    ADD CONSTRAINT "Movement_point_trans_purchase_detail_id_9da1d112_fk_Movement_" FOREIGN KEY (purchase_detail_id) REFERENCES public."Movement_purchase_detail"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3368 (class 2606 OID 226571)
-- Name: Movement_purchase_detail Movement_purchase_de_main_purchase_id_e59d2237_fk_Movement_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_purchase_detail"
    ADD CONSTRAINT "Movement_purchase_de_main_purchase_id_e59d2237_fk_Movement_" FOREIGN KEY (main_purchase_id) REFERENCES public."Movement_main_purchase"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3369 (class 2606 OID 226576)
-- Name: Movement_purchase_detail Movement_purchase_de_product_id_6a5e6043_fk_Inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_purchase_detail"
    ADD CONSTRAINT "Movement_purchase_de_product_id_6a5e6043_fk_Inventory" FOREIGN KEY (product_id) REFERENCES public."Inventory_product"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3372 (class 2606 OID 234857)
-- Name: Movement_shopping_car Movement_shopping_ca_product_id_01e4ffef_fk_Inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_shopping_car"
    ADD CONSTRAINT "Movement_shopping_ca_product_id_01e4ffef_fk_Inventory" FOREIGN KEY (product_id) REFERENCES public."Inventory_product"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3373 (class 2606 OID 234862)
-- Name: Movement_shopping_car Movement_shopping_ca_user_id_b60f18ce_fk_User_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movement_shopping_car"
    ADD CONSTRAINT "Movement_shopping_ca_user_id_b60f18ce_fk_User_user" FOREIGN KEY (user_id) REFERENCES public."User_userprofile"(identification) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3361 (class 2606 OID 226501)
-- Name: User_userprofile User_userprofile_charge_id_908db123_fk_User_charge_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile"
    ADD CONSTRAINT "User_userprofile_charge_id_908db123_fk_User_charge_id" FOREIGN KEY (charge_id) REFERENCES public."User_charge"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3362 (class 2606 OID 226510)
-- Name: User_userprofile_groups User_userprofile_gro_userprofile_id_6b5554d1_fk_User_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_groups"
    ADD CONSTRAINT "User_userprofile_gro_userprofile_id_6b5554d1_fk_User_user" FOREIGN KEY (userprofile_id) REFERENCES public."User_userprofile"(identification) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3363 (class 2606 OID 226515)
-- Name: User_userprofile_groups User_userprofile_groups_group_id_508a2183_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_groups"
    ADD CONSTRAINT "User_userprofile_groups_group_id_508a2183_fk_auth_group_id" FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3365 (class 2606 OID 226529)
-- Name: User_userprofile_user_permissions User_userprofile_use_permission_id_948bcf18_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_user_permissions"
    ADD CONSTRAINT "User_userprofile_use_permission_id_948bcf18_fk_auth_perm" FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3364 (class 2606 OID 226524)
-- Name: User_userprofile_user_permissions User_userprofile_use_userprofile_id_4e02c612_fk_User_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User_userprofile_user_permissions"
    ADD CONSTRAINT "User_userprofile_use_userprofile_id_4e02c612_fk_User_user" FOREIGN KEY (userprofile_id) REFERENCES public."User_userprofile"(identification) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3360 (class 2606 OID 226458)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3359 (class 2606 OID 226453)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3358 (class 2606 OID 226444)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3370 (class 2606 OID 226629)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3371 (class 2606 OID 226634)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_User_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT "django_admin_log_user_id_c564eba6_fk_User_user" FOREIGN KEY (user_id) REFERENCES public."User_userprofile"(identification) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2023-09-06 00:25:29

--
-- PostgreSQL database dump complete
--

