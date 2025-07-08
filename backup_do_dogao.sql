--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: delivery_clientes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_clientes (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    telefone character varying(20),
    endereco text,
    bairro character varying(100)
);


--
-- Name: delivery_clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_clientes_id_seq OWNED BY public.delivery_clientes.id;


--
-- Name: delivery_itens_pedido; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_itens_pedido (
    id integer NOT NULL,
    pedido_id integer NOT NULL,
    produto_id integer NOT NULL,
    produto_descricao character varying(200) NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    quantidade integer NOT NULL
);


--
-- Name: delivery_itens_pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_itens_pedido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_itens_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_itens_pedido_id_seq OWNED BY public.delivery_itens_pedido.id;


--
-- Name: delivery_pedidos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_pedidos (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    nome_cliente character varying(100) NOT NULL,
    tipo_pedido character varying(20) NOT NULL,
    valor_entrega numeric(10,2),
    valor_total numeric(10,2) NOT NULL,
    data_pedido timestamp without time zone
);


--
-- Name: delivery_pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_pedidos_id_seq OWNED BY public.delivery_pedidos.id;


--
-- Name: delivery_produtos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_produtos (
    id integer NOT NULL,
    descricao character varying(200) NOT NULL,
    valor numeric(10,2) NOT NULL
);


--
-- Name: delivery_produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_produtos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_produtos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_produtos_id_seq OWNED BY public.delivery_produtos.id;


--
-- Name: delivery_usuarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_usuarios (
    id integer NOT NULL,
    username character varying(80) NOT NULL,
    password_hash character varying(255) NOT NULL
);


--
-- Name: delivery_usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_usuarios_id_seq OWNED BY public.delivery_usuarios.id;


--
-- Name: transacoes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transacoes (
    id integer NOT NULL,
    data_transacao date NOT NULL,
    tipo character varying(10) NOT NULL,
    descricao character varying(200) NOT NULL,
    valor numeric(10,2) NOT NULL
);


--
-- Name: transacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transacoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transacoes_id_seq OWNED BY public.transacoes.id;


--
-- Name: delivery_clientes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_clientes ALTER COLUMN id SET DEFAULT nextval('public.delivery_clientes_id_seq'::regclass);


--
-- Name: delivery_itens_pedido id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_itens_pedido ALTER COLUMN id SET DEFAULT nextval('public.delivery_itens_pedido_id_seq'::regclass);


--
-- Name: delivery_pedidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_pedidos ALTER COLUMN id SET DEFAULT nextval('public.delivery_pedidos_id_seq'::regclass);


--
-- Name: delivery_produtos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_produtos ALTER COLUMN id SET DEFAULT nextval('public.delivery_produtos_id_seq'::regclass);


--
-- Name: delivery_usuarios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_usuarios ALTER COLUMN id SET DEFAULT nextval('public.delivery_usuarios_id_seq'::regclass);


--
-- Name: transacoes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transacoes ALTER COLUMN id SET DEFAULT nextval('public.transacoes_id_seq'::regclass);


--
-- Data for Name: delivery_clientes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_clientes (id, nome, telefone, endereco, bairro) FROM stdin;
1	Alex Sandro Vaz de Lima	19994196236	Rua Argemiro Acaiaba, 397	Centro
2	Stefany		Rua Vereador Argemiro Custódio Alexandre 231	Monte Libano
3	Mayane		Rua João Silva Barbosa, 246	Montevidel
4	William		Miralys	
5	Jenniffer		Estação Vli	
6	Giovani		Rua XV de Novembro 1217	Centro
\.


--
-- Data for Name: delivery_itens_pedido; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_itens_pedido (id, pedido_id, produto_id, produto_descricao, valor_unitario, quantidade) FROM stdin;
1	1	1	Dogão Tradicional	20.00	1
2	2	1	Dogão Tradicional	20.00	1
3	2	15	Adicional Bacon	5.00	1
4	3	5	Dogão Bacon Catupiry	26.00	3
5	3	8	Dogão Frango Catupiry Bacon	30.00	1
6	4	5	Dogão Bacon Catupiry	26.00	1
7	5	19	Bolo de Laka com Morango	28.00	1
8	5	18	Bolo de Nozes	28.00	1
9	6	6	Dogão Bacon Cheddar	26.00	1
10	7	7	Dogão Doritos	26.00	1
14	9	1	Dogão Tradicional	20.00	1
15	9	2	Hot Dog Simples	12.00	2
16	9	17	Adicional Dobro de Purê	5.00	2
17	9	20	Fanta Laranja 2L	15.00	1
18	10	5	Dogão Bacon Catupiry	26.00	1
\.


--
-- Data for Name: delivery_pedidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_pedidos (id, cliente_id, nome_cliente, tipo_pedido, valor_entrega, valor_total, data_pedido) FROM stdin;
1	1	Alex Sandro Vaz de Lima	Delivery	5.00	25.00	2025-07-02 18:44:40.368469
2	1	Alex Sandro Vaz de Lima	Delivery	5.00	30.00	2025-07-02 21:58:41.155296
3	2	Stefany	Retirada	0.00	108.00	2025-07-03 23:07:41.2353
4	2	Stefany	Retirada	0.00	26.00	2025-07-03 23:09:00.56136
5	3	Mayane	Delivery	5.00	61.00	2025-07-03 23:48:27.044693
6	4	William	Delivery	8.00	34.00	2025-07-05 23:04:23.51979
7	5	Jenniffer	Delivery	5.00	31.00	2025-07-05 23:05:06.584716
9	6	Giovani	Delivery	5.00	74.00	2025-07-05 23:08:50.224046
10	1	Alex Sandro Vaz de Lima	Delivery	0.00	26.00	2025-07-06 21:02:53.332361
\.


--
-- Data for Name: delivery_produtos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_produtos (id, descricao, valor) FROM stdin;
1	Dogão Tradicional	20.00
2	Hot Dog Simples	12.00
3	Dogão Dois Queijos	24.00
4	Dogão Frango	24.00
5	Dogão Bacon Catupiry	26.00
6	Dogão Bacon Cheddar	26.00
7	Dogão Doritos	26.00
8	Dogão Frango Catupiry Bacon	30.00
9	Dogão Calabresa Catupiry Bacon	30.00
10	Dogão Brócolis Catupiry Bacon	30.00
11	Adicional Cheddar Original	6.00
13	Adicional Catupiry Original	6.00
14	Adicional Salsicha (unidade)	2.00
15	Adicional Bacon	5.00
16	Adicional Frango	5.00
17	Adicional Dobro de Purê	5.00
18	Bolo de Nozes	28.00
19	Bolo de Laka com Morango	28.00
20	Fanta Laranja 2L	15.00
\.


--
-- Data for Name: delivery_usuarios; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_usuarios (id, username, password_hash) FROM stdin;
1	admin	scrypt:32768:8:1$DsWBBaldpZIaYnWL$9d3110e082daa6e1ba18b1fa0d4e4f6a08a5eba49bc452f78d01c88c51ff86e6089942d6e428adc5d96a2db93a91a131294767fabd8ae51dafae4b7d136582d1
\.


--
-- Data for Name: transacoes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transacoes (id, data_transacao, tipo, descricao, valor) FROM stdin;
1	2025-07-02	entrada	Uai Rango	30.00
2	2025-07-02	entrada	iFood	120.00
3	2025-07-02	saida	Compra San Michel Salsicha	50.00
4	2025-07-02	saida	pgto pai Alex	100.00
5	2025-07-02	entrada	Movimento 02/07	236.00
6	2025-07-03	saida	Bandejas	10.00
7	2025-07-03	saida	Pães	51.00
9	2025-07-03	saida	San Michel	83.00
11	2025-07-03	saida	Pagamento Online Uai Rango	80.00
8	2025-07-03	saida	Altpack	82.00
13	2025-07-03	entrada	Movimento 03/08	565.00
14	2025-07-03	saida	Motoboy 	55.00
15	2025-07-03	saida	Combustível 	30.00
16	2025-07-03	saida	Doritos 	20.00
17	2025-07-03	saida	Esfiha 	30.00
18	2025-07-04	saida	Pagamento online Uai Rango 	34.00
19	2025-07-04	saida	Salgado Alex	20.00
20	2025-07-04	entrada	Bolo Mayane 	61.00
21	2025-07-04	entrada	Bolo	501.00
22	2025-07-04	saida	Pagani 	69.00
23	2025-07-05	saida	Empréstimo Pai Alex 	300.00
24	2025-07-05	fiado	Plínio 	98.00
25	2025-07-05	fiado	Adriana (bolo) atrasado 	110.00
26	2025-07-05	fiado	Fit 	68.00
10	2025-07-03	entrada	Bolo karina	150.00
32	2025-07-06	saida	Pães 	60.00
27	2025-07-05	entrada	Movimento 05/07	431.00
28	2025-07-05	entrada	Bolo Francielle 	140.00
33	2025-07-06	saida	Compra Fonseca 	72.00
31	2025-07-05	saida	Combustível 	50.00
29	2025-07-05	saida	Altpack 	7.00
30	2025-07-05	saida	Fonseca 	73.00
34	2025-07-07	saida	Combustível 	50.00
35	2025-07-07	entrada	Movimento 07/07	208.00
36	2025-07-07	saida	Jogo	13.00
\.


--
-- Name: delivery_clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_clientes_id_seq', 6, true);


--
-- Name: delivery_itens_pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_itens_pedido_id_seq', 19, true);


--
-- Name: delivery_pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_pedidos_id_seq', 11, true);


--
-- Name: delivery_produtos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_produtos_id_seq', 20, true);


--
-- Name: delivery_usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_usuarios_id_seq', 1, true);


--
-- Name: transacoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transacoes_id_seq', 36, true);


--
-- Name: delivery_clientes delivery_clientes_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_clientes
    ADD CONSTRAINT delivery_clientes_nome_key UNIQUE (nome);


--
-- Name: delivery_clientes delivery_clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_clientes
    ADD CONSTRAINT delivery_clientes_pkey PRIMARY KEY (id);


--
-- Name: delivery_itens_pedido delivery_itens_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_itens_pedido
    ADD CONSTRAINT delivery_itens_pedido_pkey PRIMARY KEY (id);


--
-- Name: delivery_pedidos delivery_pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_pedidos
    ADD CONSTRAINT delivery_pedidos_pkey PRIMARY KEY (id);


--
-- Name: delivery_produtos delivery_produtos_descricao_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_produtos
    ADD CONSTRAINT delivery_produtos_descricao_key UNIQUE (descricao);


--
-- Name: delivery_produtos delivery_produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_produtos
    ADD CONSTRAINT delivery_produtos_pkey PRIMARY KEY (id);


--
-- Name: delivery_usuarios delivery_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_usuarios
    ADD CONSTRAINT delivery_usuarios_pkey PRIMARY KEY (id);


--
-- Name: delivery_usuarios delivery_usuarios_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_usuarios
    ADD CONSTRAINT delivery_usuarios_username_key UNIQUE (username);


--
-- Name: transacoes transacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transacoes
    ADD CONSTRAINT transacoes_pkey PRIMARY KEY (id);


--
-- Name: delivery_itens_pedido delivery_itens_pedido_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_itens_pedido
    ADD CONSTRAINT delivery_itens_pedido_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.delivery_pedidos(id);


--
-- Name: delivery_itens_pedido delivery_itens_pedido_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_itens_pedido
    ADD CONSTRAINT delivery_itens_pedido_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.delivery_produtos(id);


--
-- Name: delivery_pedidos delivery_pedidos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_pedidos
    ADD CONSTRAINT delivery_pedidos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.delivery_clientes(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO app_dogao_duxi_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO app_dogao_duxi_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO app_dogao_duxi_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO app_dogao_duxi_user;


--
-- PostgreSQL database dump complete
--

