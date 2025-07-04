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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: buyers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buyers (
    id bigint NOT NULL,
    name character varying NOT NULL,
    representative_name character varying DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    price numeric DEFAULT 0.0 NOT NULL,
    ringba_phone character varying,
    ringba_url character varying,
    everflow_oid character varying,
    payout_event character varying,
    exclude_conditions jsonb,
    include_conditions jsonb,
    daily_cap integer DEFAULT '-1'::integer NOT NULL
);


--
-- Name: buyers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buyers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buyers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buyers_id_seq OWNED BY public.buyers.id;


--
-- Name: buyers_stacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buyers_stacks (
    id bigint NOT NULL,
    description character varying NOT NULL,
    config jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: buyers_stacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buyers_stacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buyers_stacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buyers_stacks_id_seq OWNED BY public.buyers_stacks.id;


--
-- Name: clicks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clicks (
    id bigint NOT NULL,
    lead_id uuid NOT NULL,
    ip_address character varying NOT NULL,
    user_agent character varying NOT NULL,
    referrer character varying NOT NULL,
    current_url character varying NOT NULL,
    next_url character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: clicks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clicks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clicks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clicks_id_seq OWNED BY public.clicks.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leads (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    host character varying NOT NULL,
    path character varying NOT NULL,
    query jsonb DEFAULT '{}'::jsonb NOT NULL,
    ip_address character varying NOT NULL,
    referrer character varying,
    user_agent character varying,
    first_name character varying,
    last_name character varying,
    email character varying,
    phone character varying,
    work_phone character varying,
    address character varying,
    address2 character varying,
    city character varying,
    state character varying,
    zip character varying,
    country character varying,
    date_of_birth character varying,
    loan_types character varying[],
    loan_amount character varying,
    ssn character varying,
    jornaya_id character varying,
    tcpa_consent boolean,
    fcra_consent boolean,
    tcpa_language text,
    fcra_language text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.providers (
    id bigint NOT NULL,
    name character varying NOT NULL
);


--
-- Name: providers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.providers_id_seq OWNED BY public.providers.id;


--
-- Name: request_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request_logs (
    id bigint NOT NULL,
    lead_id uuid NOT NULL,
    provider_id bigint,
    buyer_id bigint,
    status_code integer NOT NULL,
    method character varying NOT NULL,
    success boolean NOT NULL,
    url character varying NOT NULL,
    request_body text NOT NULL,
    response_body text NOT NULL,
    total_time numeric(10,3) NOT NULL,
    metadata jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT request_logs_exactly_one_target CHECK ((((provider_id IS NOT NULL) AND (buyer_id IS NULL)) OR ((provider_id IS NULL) AND (buyer_id IS NOT NULL))))
);


--
-- Name: request_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.request_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: request_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.request_logs_id_seq OWNED BY public.request_logs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stack_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stack_results (
    id bigint NOT NULL,
    lead_id uuid NOT NULL,
    buyers_stack_id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    request_log_id bigint NOT NULL,
    stack_snapshot jsonb NOT NULL,
    status character varying NOT NULL,
    final_price numeric(10,2) NOT NULL,
    final_response_body character varying NOT NULL,
    offer_type character varying NOT NULL,
    won_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stack_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stack_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stack_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stack_results_id_seq OWNED BY public.stack_results.id;


--
-- Name: buyers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers ALTER COLUMN id SET DEFAULT nextval('public.buyers_id_seq'::regclass);


--
-- Name: buyers_stacks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers_stacks ALTER COLUMN id SET DEFAULT nextval('public.buyers_stacks_id_seq'::regclass);


--
-- Name: clicks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clicks ALTER COLUMN id SET DEFAULT nextval('public.clicks_id_seq'::regclass);


--
-- Name: providers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.providers ALTER COLUMN id SET DEFAULT nextval('public.providers_id_seq'::regclass);


--
-- Name: request_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_logs ALTER COLUMN id SET DEFAULT nextval('public.request_logs_id_seq'::regclass);


--
-- Name: stack_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stack_results ALTER COLUMN id SET DEFAULT nextval('public.stack_results_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: buyers buyers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (id);


--
-- Name: buyers_stacks buyers_stacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buyers_stacks
    ADD CONSTRAINT buyers_stacks_pkey PRIMARY KEY (id);


--
-- Name: clicks clicks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clicks
    ADD CONSTRAINT clicks_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- Name: request_logs request_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_logs
    ADD CONSTRAINT request_logs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stack_results stack_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stack_results
    ADD CONSTRAINT stack_results_pkey PRIMARY KEY (id);


--
-- Name: index_clicks_on_lead_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clicks_on_lead_id ON public.clicks USING btree (lead_id);


--
-- Name: index_request_logs_on_buyer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_request_logs_on_buyer_id ON public.request_logs USING btree (buyer_id);


--
-- Name: index_request_logs_on_lead_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_request_logs_on_lead_id ON public.request_logs USING btree (lead_id);


--
-- Name: index_request_logs_on_provider_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_request_logs_on_provider_id ON public.request_logs USING btree (provider_id);


--
-- Name: index_stack_results_on_buyer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stack_results_on_buyer_id ON public.stack_results USING btree (buyer_id);


--
-- Name: index_stack_results_on_buyers_stack_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stack_results_on_buyers_stack_id ON public.stack_results USING btree (buyers_stack_id);


--
-- Name: index_stack_results_on_lead_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stack_results_on_lead_id ON public.stack_results USING btree (lead_id);


--
-- Name: index_stack_results_on_request_log_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stack_results_on_request_log_id ON public.stack_results USING btree (request_log_id);


--
-- Name: request_logs fk_rails_013cf8d4b7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_logs
    ADD CONSTRAINT fk_rails_013cf8d4b7 FOREIGN KEY (buyer_id) REFERENCES public.buyers(id);


--
-- Name: stack_results fk_rails_122a19b77b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stack_results
    ADD CONSTRAINT fk_rails_122a19b77b FOREIGN KEY (lead_id) REFERENCES public.leads(id);


--
-- Name: request_logs fk_rails_36528ed1b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_logs
    ADD CONSTRAINT fk_rails_36528ed1b4 FOREIGN KEY (provider_id) REFERENCES public.providers(id);


--
-- Name: request_logs fk_rails_399d2916c4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_logs
    ADD CONSTRAINT fk_rails_399d2916c4 FOREIGN KEY (lead_id) REFERENCES public.leads(id);


--
-- Name: stack_results fk_rails_489a34ed7d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stack_results
    ADD CONSTRAINT fk_rails_489a34ed7d FOREIGN KEY (buyer_id) REFERENCES public.buyers(id);


--
-- Name: clicks fk_rails_ddcc93e045; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clicks
    ADD CONSTRAINT fk_rails_ddcc93e045 FOREIGN KEY (lead_id) REFERENCES public.leads(id);


--
-- Name: stack_results fk_rails_e021473b58; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stack_results
    ADD CONSTRAINT fk_rails_e021473b58 FOREIGN KEY (request_log_id) REFERENCES public.request_logs(id);


--
-- Name: stack_results fk_rails_f3ea1f1507; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stack_results
    ADD CONSTRAINT fk_rails_f3ea1f1507 FOREIGN KEY (buyers_stack_id) REFERENCES public.buyers_stacks(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250702215044'),
('20250702215033'),
('20250702214840'),
('20250702214658'),
('20250702214612'),
('20250702214602'),
('20250702211559');

