--
-- PostgreSQL database dump
--

\restrict 3lsILjnURCQYJwTkm8TGcmzcSSQBMUHvccW6qqnvm9XPaVCoPsLIS9f2lsmw1ka

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-31 12:17:32

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
-- TOC entry 6 (class 2615 OID 16548)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 16549)
-- Name: erp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA erp;


ALTER SCHEMA erp OWNER TO postgres;

--
-- TOC entry 902 (class 1247 OID 16551)
-- Name: enum_customers_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_customers_status AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE erp.enum_customers_status OWNER TO postgres;

--
-- TOC entry 1100 (class 1247 OID 18076)
-- Name: enum_inquiry_source; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_inquiry_source AS ENUM (
    'WEB',
    'PHONE'
);


ALTER TYPE erp.enum_inquiry_source OWNER TO postgres;

--
-- TOC entry 905 (class 1247 OID 16556)
-- Name: enum_inquiry_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_inquiry_status AS ENUM (
    'NEW',
    'QUOTED',
    'CLOSED'
);


ALTER TYPE erp.enum_inquiry_status OWNER TO postgres;

--
-- TOC entry 1115 (class 1247 OID 18159)
-- Name: enum_po_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_po_status AS ENUM (
    'DRAFT',
    'APPROVED',
    'REJECTED',
    'CLOSED'
);


ALTER TYPE erp.enum_po_status OWNER TO postgres;

--
-- TOC entry 908 (class 1247 OID 16564)
-- Name: enum_products_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_products_status AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE erp.enum_products_status OWNER TO postgres;

--
-- TOC entry 911 (class 1247 OID 16570)
-- Name: enum_purchase_orders_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_purchase_orders_status AS ENUM (
    'OPEN',
    'RECEIVED'
);


ALTER TYPE erp.enum_purchase_orders_status OWNER TO postgres;

--
-- TOC entry 914 (class 1247 OID 16576)
-- Name: enum_quotation_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_quotation_status AS ENUM (
    'DRAFT',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE erp.enum_quotation_status OWNER TO postgres;

--
-- TOC entry 917 (class 1247 OID 16584)
-- Name: enum_sales_orders_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_sales_orders_status AS ENUM (
    'OPEN',
    'IN_PRODUCTION',
    'COMPLETED'
);


ALTER TYPE erp.enum_sales_orders_status OWNER TO postgres;

--
-- TOC entry 920 (class 1247 OID 16592)
-- Name: enum_suppliers_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_suppliers_status AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE erp.enum_suppliers_status OWNER TO postgres;

--
-- TOC entry 923 (class 1247 OID 16598)
-- Name: enum_work_orders_status; Type: TYPE; Schema: erp; Owner: postgres
--

CREATE TYPE erp.enum_work_orders_status AS ENUM (
    'CREATED',
    'IN_PROGRESS',
    'DONE'
);


ALTER TYPE erp.enum_work_orders_status OWNER TO postgres;

--
-- TOC entry 926 (class 1247 OID 16606)
-- Name: enum_customers_customer_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_customers_customer_type AS ENUM (
    'retail',
    'wholesale',
    'corporate'
);


ALTER TYPE public.enum_customers_customer_type OWNER TO postgres;

--
-- TOC entry 929 (class 1247 OID 16614)
-- Name: enum_customers_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_customers_status AS ENUM (
    'active',
    'inactive',
    'blocked',
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public.enum_customers_status OWNER TO postgres;

--
-- TOC entry 1094 (class 1247 OID 18034)
-- Name: enum_inquiry_source; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_inquiry_source AS ENUM (
    'WEB',
    'PHONE'
);


ALTER TYPE public.enum_inquiry_source OWNER TO postgres;

--
-- TOC entry 932 (class 1247 OID 16626)
-- Name: enum_inquiry_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_inquiry_status AS ENUM (
    'NEW',
    'QUOTED',
    'CLOSED'
);


ALTER TYPE public.enum_inquiry_status OWNER TO postgres;

--
-- TOC entry 935 (class 1247 OID 16634)
-- Name: enum_inventory_transactions_reference_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_inventory_transactions_reference_type AS ENUM (
    'order',
    'purchase',
    'adjustment',
    'other'
);


ALTER TYPE public.enum_inventory_transactions_reference_type OWNER TO postgres;

--
-- TOC entry 938 (class 1247 OID 16644)
-- Name: enum_inventory_transactions_transaction_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_inventory_transactions_transaction_type AS ENUM (
    'in',
    'out',
    'adjustment',
    'transfer'
);


ALTER TYPE public.enum_inventory_transactions_transaction_type OWNER TO postgres;

--
-- TOC entry 941 (class 1247 OID 16654)
-- Name: enum_orders_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_orders_status AS ENUM (
    'pending',
    'processing',
    'completed',
    'cancelled'
);


ALTER TYPE public.enum_orders_status OWNER TO postgres;

--
-- TOC entry 944 (class 1247 OID 16664)
-- Name: enum_production_orders_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_production_orders_status AS ENUM (
    'planned',
    'in_progress',
    'completed',
    'cancelled'
);


ALTER TYPE public.enum_production_orders_status OWNER TO postgres;

--
-- TOC entry 947 (class 1247 OID 16674)
-- Name: enum_products_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_products_status AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public.enum_products_status OWNER TO postgres;

--
-- TOC entry 950 (class 1247 OID 16680)
-- Name: enum_purchase_orders_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_purchase_orders_status AS ENUM (
    'draft',
    'sent',
    'confirmed',
    'received',
    'cancelled',
    'OPEN',
    'RECEIVED'
);


ALTER TYPE public.enum_purchase_orders_status OWNER TO postgres;

--
-- TOC entry 953 (class 1247 OID 16696)
-- Name: enum_quotation_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_quotation_status AS ENUM (
    'DRAFT',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE public.enum_quotation_status OWNER TO postgres;

--
-- TOC entry 956 (class 1247 OID 16704)
-- Name: enum_sales_orders_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_sales_orders_status AS ENUM (
    'OPEN',
    'IN_PRODUCTION',
    'COMPLETED'
);


ALTER TYPE public.enum_sales_orders_status OWNER TO postgres;

--
-- TOC entry 959 (class 1247 OID 16712)
-- Name: enum_suppliers_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_suppliers_status AS ENUM (
    'active',
    'inactive',
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public.enum_suppliers_status OWNER TO postgres;

--
-- TOC entry 962 (class 1247 OID 16722)
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_role AS ENUM (
    'admin',
    'manager',
    'user',
    'guest'
);


ALTER TYPE public.enum_users_role OWNER TO postgres;

--
-- TOC entry 965 (class 1247 OID 16732)
-- Name: enum_users_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_status AS ENUM (
    'active',
    'inactive',
    'suspended'
);


ALTER TYPE public.enum_users_status OWNER TO postgres;

--
-- TOC entry 968 (class 1247 OID 16740)
-- Name: enum_work_orders_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_work_orders_status AS ENUM (
    'CREATED',
    'IN_PROGRESS',
    'DONE'
);


ALTER TYPE public.enum_work_orders_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16747)
-- Name: permissions; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.permissions (
    id uuid NOT NULL,
    permission_key character varying(255) NOT NULL,
    module character varying(255),
    description text
);


ALTER TABLE auth.permissions OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16754)
-- Name: role_permissions; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.role_permissions (
    role_id uuid NOT NULL,
    permission_id uuid NOT NULL
);


ALTER TABLE auth.role_permissions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16759)
-- Name: roles; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.roles (
    id uuid NOT NULL,
    role_name character varying(255) NOT NULL,
    description text,
    is_system boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE auth.roles OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16769)
-- Name: user_roles; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.user_roles (
    user_id uuid NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE auth.user_roles OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16774)
-- Name: users; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    is_active boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE auth.users OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16786)
-- Name: customers; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.customers (
    id uuid NOT NULL,
    customer_code character varying(255),
    name character varying(255) NOT NULL,
    phone character varying(255),
    email character varying(255),
    address text,
    status erp.enum_customers_status DEFAULT 'ACTIVE'::erp.enum_customers_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.customers OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16796)
-- Name: dispatch; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.dispatch (
    id uuid NOT NULL,
    so_id uuid,
    dispatch_no character varying(255),
    dispatch_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.dispatch OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16802)
-- Name: grn; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.grn (
    id uuid NOT NULL,
    po_id uuid,
    grn_no character varying(255),
    received_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.grn OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 18045)
-- Name: inquiry; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.inquiry (
    id uuid NOT NULL,
    inquiry_no character varying(50) NOT NULL,
    inquiry_date date DEFAULT CURRENT_DATE NOT NULL,
    company_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    expected_date date,
    status erp.enum_inquiry_status DEFAULT 'NEW'::erp.enum_inquiry_status NOT NULL,
    notes text,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    modified_by uuid NOT NULL,
    modified_at timestamp with time zone DEFAULT now() NOT NULL,
    source public.enum_inquiry_source DEFAULT 'WEB'::public.enum_inquiry_source
);


ALTER TABLE erp.inquiry OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 18082)
-- Name: inquiry_items; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.inquiry_items (
    id uuid NOT NULL,
    enquiry_id uuid NOT NULL,
    item_name character varying(255) NOT NULL,
    width numeric,
    thickness numeric,
    length numeric,
    density numeric,
    pricing_source character varying(50),
    uom character varying(50),
    qty numeric,
    weight numeric,
    unit_price numeric NOT NULL,
    total_price numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT inquiry_items_qty_check CHECK ((qty >= (0)::numeric)),
    CONSTRAINT inquiry_items_total_price_check CHECK ((total_price >= (0)::numeric)),
    CONSTRAINT inquiry_items_unit_price_check CHECK ((unit_price >= (0)::numeric)),
    CONSTRAINT inquiry_items_weight_check CHECK ((weight >= (0)::numeric))
);


ALTER TABLE erp.inquiry_items OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16821)
-- Name: inventory; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.inventory (
    id uuid NOT NULL,
    product_id uuid,
    quantity numeric
);


ALTER TABLE erp.inventory OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16827)
-- Name: invoice; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.invoice (
    id uuid NOT NULL,
    so_id uuid,
    invoice_no character varying(255),
    total_amount numeric,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.invoice OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16835)
-- Name: packing; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.packing (
    id uuid NOT NULL,
    wo_id uuid,
    packed_qty numeric,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.packing OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16843)
-- Name: payment; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.payment (
    id uuid NOT NULL,
    invoice_id uuid,
    amount numeric,
    payment_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.payment OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16851)
-- Name: production_logs; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.production_logs (
    id uuid NOT NULL,
    wo_id uuid,
    produced_qty numeric
);


ALTER TABLE erp.production_logs OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16857)
-- Name: products; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.products (
    id uuid NOT NULL,
    product_code character varying(255),
    name character varying(255) NOT NULL,
    unit character varying(255),
    category character varying(255),
    status erp.enum_products_status DEFAULT 'ACTIVE'::erp.enum_products_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.products OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 18150)
-- Name: purchase_order_line_attributes; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.purchase_order_line_attributes (
    id uuid NOT NULL,
    po_line_id uuid NOT NULL,
    attribute_name character varying(100) NOT NULL,
    attribute_value character varying(255)
);


ALTER TABLE erp.purchase_order_line_attributes OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 18136)
-- Name: purchase_order_lines; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.purchase_order_lines (
    id uuid NOT NULL,
    po_id uuid NOT NULL,
    material_name character varying(255) NOT NULL,
    count numeric,
    quantity numeric,
    weight numeric,
    unit character varying(20),
    unit_price numeric NOT NULL,
    line_total numeric NOT NULL,
    remarks text,
    CONSTRAINT purchase_order_lines_line_total_check CHECK ((line_total >= (0)::numeric)),
    CONSTRAINT purchase_order_lines_unit_price_check CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE erp.purchase_order_lines OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 18102)
-- Name: purchase_orders; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.purchase_orders (
    id uuid NOT NULL,
    document_number character varying(50) NOT NULL,
    quotation_id uuid,
    customer_id uuid NOT NULL,
    po_date date DEFAULT CURRENT_DATE NOT NULL,
    status character varying(30) DEFAULT 'DRAFT'::character varying NOT NULL,
    approved_by uuid,
    approved_date timestamp with time zone,
    remarks text,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE erp.purchase_orders OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16874)
-- Name: qc_reports; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.qc_reports (
    id uuid NOT NULL,
    production_id uuid,
    accepted_qty numeric,
    rejected_qty numeric
);


ALTER TABLE erp.qc_reports OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 18255)
-- Name: quotation_line_attributes; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.quotation_line_attributes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    quotation_line_id uuid NOT NULL,
    attribute_name character varying(50) NOT NULL,
    attribute_value character varying(100) NOT NULL
);


ALTER TABLE erp.quotation_line_attributes OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 18218)
-- Name: quotation_lines; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.quotation_lines (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    quotation_id uuid NOT NULL,
    product_id uuid NOT NULL,
    width numeric,
    thickness numeric,
    length numeric,
    density numeric,
    uom character varying(50),
    quantity numeric,
    weight numeric,
    unit_price numeric(12,2) NOT NULL,
    discount_percent numeric(5,2) DEFAULT 0,
    taxable_amount numeric(14,2) NOT NULL,
    cgst_percent numeric(5,2) DEFAULT 0,
    sgst_percent numeric(5,2) DEFAULT 0,
    igst_percent numeric(5,2) DEFAULT 0,
    cgst_amount numeric(12,2) DEFAULT 0,
    sgst_amount numeric(12,2) DEFAULT 0,
    igst_amount numeric(12,2) DEFAULT 0,
    line_total numeric(14,2) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT quotation_lines_quantity_check CHECK ((quantity >= (0)::numeric)),
    CONSTRAINT quotation_lines_unit_price_check CHECK ((unit_price >= (0)::numeric)),
    CONSTRAINT quotation_lines_weight_check CHECK ((weight >= (0)::numeric))
);


ALTER TABLE erp.quotation_lines OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 18171)
-- Name: quotations; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.quotations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    quotation_no character varying(50) NOT NULL,
    revision_no integer DEFAULT 1,
    inquiry_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    quotation_date date DEFAULT CURRENT_DATE NOT NULL,
    validity_date date,
    total_before_tax numeric(14,2) DEFAULT 0,
    cgst_amount numeric(14,2) DEFAULT 0,
    sgst_amount numeric(14,2) DEFAULT 0,
    igst_amount numeric(14,2) DEFAULT 0,
    total_tax_amount numeric(14,2) DEFAULT 0,
    net_amount numeric(14,2) DEFAULT 0,
    status character varying(30) DEFAULT 'DRAFT'::character varying,
    created_by uuid NOT NULL,
    approved_by uuid,
    approved_at timestamp with time zone,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT quotations_status_check CHECK (((status)::text = ANY ((ARRAY['DRAFT'::character varying, 'SENT'::character varying, 'APPROVED'::character varying, 'REJECTED'::character varying, 'EXPIRED'::character varying, 'CONVERTED_TO_PO'::character varying])::text[])))
);


ALTER TABLE erp.quotations OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16893)
-- Name: sales_orders; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.sales_orders (
    id uuid NOT NULL,
    quotation_id uuid,
    so_no character varying(255),
    status erp.enum_sales_orders_status DEFAULT 'OPEN'::erp.enum_sales_orders_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.sales_orders OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16900)
-- Name: suppliers; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.suppliers (
    id uuid NOT NULL,
    supplier_code character varying(255),
    name character varying(255) NOT NULL,
    phone character varying(255),
    email character varying(255),
    address text,
    status erp.enum_suppliers_status DEFAULT 'ACTIVE'::erp.enum_suppliers_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.suppliers OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16910)
-- Name: work_orders; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp.work_orders (
    id uuid NOT NULL,
    so_id uuid,
    wo_no character varying(255),
    status erp.enum_work_orders_status DEFAULT 'CREATED'::erp.enum_work_orders_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE erp.work_orders OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16917)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid NOT NULL,
    customer_code character varying(255),
    name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(255),
    address text,
    status public.enum_customers_status DEFAULT 'ACTIVE'::public.enum_customers_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16927)
-- Name: dispatch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dispatch (
    id uuid NOT NULL,
    so_id uuid,
    dispatch_no character varying(255),
    dispatch_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.dispatch OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16933)
-- Name: grn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grn (
    id uuid NOT NULL,
    po_id uuid,
    grn_no character varying(255),
    received_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.grn OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17978)
-- Name: inquiry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquiry (
    id uuid NOT NULL,
    inquiry_no character varying(50) NOT NULL,
    inquiry_date date DEFAULT CURRENT_DATE NOT NULL,
    company_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    product_id uuid NOT NULL,
    quantity numeric NOT NULL,
    expected_date date,
    status public.enum_inquiry_status DEFAULT 'NEW'::public.enum_inquiry_status NOT NULL,
    notes text,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    modified_by uuid NOT NULL,
    modified_at timestamp with time zone DEFAULT now() NOT NULL,
    source public.enum_inquiry_source DEFAULT 'WEB'::public.enum_inquiry_source,
    CONSTRAINT inquiry_quantity_check CHECK ((quantity > (0)::numeric))
);


ALTER TABLE public.inquiry OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16946)
-- Name: inquiry_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquiry_items (
    id uuid NOT NULL,
    inquiry_id uuid,
    product_id uuid,
    quantity numeric
);


ALTER TABLE public.inquiry_items OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16952)
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    id uuid NOT NULL,
    product_id uuid,
    quantity numeric
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16958)
-- Name: inventory_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_transactions (
    id uuid NOT NULL,
    transaction_type public.enum_inventory_transactions_transaction_type NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    reference_id character varying(255),
    reference_type public.enum_inventory_transactions_reference_type,
    notes text,
    transaction_date timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.inventory_transactions OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16969)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    id uuid NOT NULL,
    so_id uuid,
    invoice_no character varying(255),
    total_amount numeric,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16977)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16988)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    order_number character varying(255) NOT NULL,
    customer_id uuid NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status public.enum_orders_status DEFAULT 'pending'::public.enum_orders_status,
    order_date timestamp with time zone,
    delivery_date timestamp with time zone,
    notes text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17000)
-- Name: packing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.packing (
    id uuid NOT NULL,
    wo_id uuid,
    packed_qty numeric,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.packing OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17008)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    id uuid NOT NULL,
    invoice_id uuid,
    amount numeric,
    payment_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17016)
-- Name: production_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production_logs (
    id uuid NOT NULL,
    wo_id uuid,
    produced_qty numeric
);


ALTER TABLE public.production_logs OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17022)
-- Name: production_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production_orders (
    id uuid NOT NULL,
    production_number character varying(255) NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    status public.enum_production_orders_status DEFAULT 'planned'::public.enum_production_orders_status,
    start_date timestamp with time zone,
    completion_date timestamp with time zone,
    notes text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.production_orders OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17034)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    product_code character varying(255),
    name character varying(255) NOT NULL,
    category character varying(255),
    unit character varying(255),
    status public.enum_products_status DEFAULT 'ACTIVE'::public.enum_products_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17044)
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
    id uuid NOT NULL,
    supplier_id uuid,
    status public.enum_purchase_orders_status DEFAULT 'OPEN'::public.enum_purchase_orders_status,
    po_no character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17051)
-- Name: qc_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qc_reports (
    id uuid NOT NULL,
    production_id uuid,
    accepted_qty numeric,
    rejected_qty numeric
);


ALTER TABLE public.qc_reports OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17057)
-- Name: quotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotation (
    id uuid NOT NULL,
    inquiry_id uuid,
    quotation_no character varying(255),
    status public.enum_quotation_status DEFAULT 'DRAFT'::public.enum_quotation_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.quotation OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 17064)
-- Name: quotation_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotation_items (
    id uuid NOT NULL,
    quotation_id uuid,
    product_id uuid,
    rate numeric,
    quantity numeric
);


ALTER TABLE public.quotation_items OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17070)
-- Name: sales_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_orders (
    id uuid NOT NULL,
    quotation_id uuid,
    so_no character varying(255),
    status public.enum_sales_orders_status DEFAULT 'OPEN'::public.enum_sales_orders_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.sales_orders OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 17077)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id uuid NOT NULL,
    supplier_code character varying(255),
    name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(255),
    address text,
    status public.enum_suppliers_status DEFAULT 'ACTIVE'::public.enum_suppliers_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17087)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    role public.enum_users_role DEFAULT 'user'::public.enum_users_role,
    status public.enum_users_status DEFAULT 'active'::public.enum_users_status,
    last_login timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17100)
-- Name: work_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_orders (
    id uuid NOT NULL,
    so_id uuid,
    wo_no character varying(255),
    status public.enum_work_orders_status DEFAULT 'CREATED'::public.enum_work_orders_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.work_orders OWNER TO postgres;

--
-- TOC entry 6079 (class 0 OID 16747)
-- Dependencies: 221
-- Data for Name: permissions; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.permissions (id, permission_key, module, description) FROM stdin;
ec52c726-7101-46e3-adfa-b1256451685e	USER_VIEW	USER MANAGEMENT	user view permission
4daaa1a3-a7f7-4704-b159-195fbd99fc1c	USER_CREATE	USER MANAGEMENT	user create permission
a2521b0c-6bc4-4163-a73a-68f963e5bc3c	USER_UPDATE	USER MANAGEMENT	user update permission
6f4dcf21-9618-4b57-820b-b6c3d87a8940	USER_DELETE	USER MANAGEMENT	user delete permission
9366c8e0-0a0c-4ad3-b918-4ea03db93761	ROLE_VIEW	USER MANAGEMENT	role view permission
b14e01e4-b3eb-48a9-b0b7-32211b61143e	ROLE_CREATE	USER MANAGEMENT	role create permission
c376d807-b18d-4359-9850-c7dbc5a4fc67	ROLE_UPDATE	USER MANAGEMENT	role update permission
bae17ffd-6fda-41e8-bb38-8c733f8b8fde	ROLE_DELETE	USER MANAGEMENT	role delete permission
29d050d4-fbc4-48ea-8a4b-043944ddc9dd	PERMISSION_MANAGE	USER MANAGEMENT	permission manage permission
31ccfc5a-4716-4fdd-961f-757e3935fb29	MASTER_VIEW	MASTER DATA	master view permission
84ec8452-b248-4a94-a8ba-87216bc0ced1	MASTER_CREATE	MASTER DATA	master create permission
4fd9875c-5dac-48e5-bfb0-6ce5bb30bc0e	MASTER_UPDATE	MASTER DATA	master update permission
99aef1db-14ec-4461-81f3-3f21cc1ebbf5	MASTER_DELETE	MASTER DATA	master delete permission
8787933a-bac6-41f6-a2db-9d8e8cd0f754	INQUIRY_VIEW	SALES	inquiry view permission
b4fc9691-b8e3-451b-abe7-78eedd8b81e4	INQUIRY_CREATE	SALES	inquiry create permission
ff26aee8-8b2a-4a7e-88b4-2a16c6a1b54c	INQUIRY_UPDATE	SALES	inquiry update permission
2b5e35a6-a4d7-418b-942b-2d3a5b1a7a88	INQUIRY_DELETE	SALES	inquiry delete permission
6ca6fe89-9385-4056-9f82-d835844d1323	QUOTATION_VIEW	SALES	quotation view permission
8a8444b6-fa62-4602-9dab-90bff6211c53	QUOTATION_CREATE	SALES	quotation create permission
3f48e15e-8873-4dfe-8b0e-f9a2fe5629fc	QUOTATION_UPDATE	SALES	quotation update permission
f4016ad4-80bc-4cb6-ae68-f8f4cdcd74f2	QUOTATION_DELETE	SALES	quotation delete permission
552085a6-194f-4c74-a37f-87931ff4511d	SALES_ORDER_VIEW	SALES	sales order_view permission
63202735-5ddd-448e-8d41-729d9bcd2e2f	SALES_ORDER_CREATE	SALES	sales order_create permission
a7416580-85ce-41da-9623-2b4c3d6c85b7	SALES_ORDER_UPDATE	SALES	sales order_update permission
e9c2ee38-6972-4dd2-a297-ecba06cd1490	SALES_ORDER_DELETE	SALES	sales order_delete permission
79baec5e-7834-43cd-b97e-59de8c61b1ab	PURCHASE_ORDER_VIEW	PURCHASE	purchase order_view permission
818346a2-1d0f-4ff3-b0a8-4d7620bd76d0	PURCHASE_ORDER_CREATE	PURCHASE	purchase order_create permission
120d08b9-1a50-4ed5-a578-f2a9daedef95	PURCHASE_ORDER_UPDATE	PURCHASE	purchase order_update permission
344fec4a-e5fa-4650-8a13-2a96d05270a3	PURCHASE_ORDER_DELETE	PURCHASE	purchase order_delete permission
0fd6ade6-00a8-4e1f-aad5-8a8568ffd6fc	GRN_VIEW	PURCHASE	grn view permission
def7962b-9022-459c-aeeb-d1fdb48edfcb	GRN_CREATE	PURCHASE	grn create permission
330f22c4-cf7f-4198-9fbb-218606c16531	GRN_UPDATE	PURCHASE	grn update permission
2b2360f4-e71a-442d-a3c3-618270b75037	GRN_DELETE	PURCHASE	grn delete permission
44cf0118-211b-476d-8682-cf08b0bfe0f9	WORK_ORDER_VIEW	MANUFACTURING	work order_view permission
dc176239-87b0-4d44-b8d6-997b4be014db	WORK_ORDER_CREATE	MANUFACTURING	work order_create permission
5511ff38-675d-4212-8039-4363e293a77c	WORK_ORDER_UPDATE	MANUFACTURING	work order_update permission
1633b51c-2479-492a-9e36-ac4d4643daec	WORK_ORDER_DELETE	MANUFACTURING	work order_delete permission
c420227b-d908-4a79-92a0-558902892528	PRODUCTION_VIEW	MANUFACTURING	production view permission
3a27763d-04ef-46df-80d1-c1530bd9f1e1	PRODUCTION_CREATE	MANUFACTURING	production create permission
4ea59eef-fe2e-49bd-84af-0a46c133b86d	PRODUCTION_UPDATE	MANUFACTURING	production update permission
a49b0866-4968-4c43-965d-e7256a6ca081	PRODUCTION_DELETE	MANUFACTURING	production delete permission
ea11d6fc-8095-454f-997f-24194c77d337	QC_VIEW	MANUFACTURING	qc view permission
b9611912-66fb-474e-8353-875805b2bb08	QC_CREATE	MANUFACTURING	qc create permission
c0494b7c-c929-4d81-9e15-8ca52f09f62e	QC_UPDATE	MANUFACTURING	qc update permission
e11aba2b-dd56-4497-a96a-d43d71cb2d54	QC_DELETE	MANUFACTURING	qc delete permission
0ec480eb-ceb8-493c-80f3-367ce7423a3f	INVENTORY_VIEW	INVENTORY	inventory view permission
84c70581-a61d-45d9-bbf0-2e5d29dda49a	INVENTORY_CREATE	INVENTORY	inventory create permission
abc37291-3011-4d44-a457-191382b8123d	INVENTORY_UPDATE	INVENTORY	inventory update permission
fe7f82e1-d396-4a88-8b94-40ed03edd86d	INVENTORY_DELETE	INVENTORY	inventory delete permission
32481008-5b60-4751-8dcc-5ef8ef387a77	STOCK_VIEW	INVENTORY	stock view permission
029017b0-1e2e-4b51-b142-cd8044466e42	STOCK_UPDATE	INVENTORY	stock update permission
87a0ccfe-0dba-4e4b-a27d-619a223777bc	INVOICE_VIEW	FINANCE	invoice view permission
0561406e-70d5-4dfc-bee6-aa7a91588cbb	INVOICE_CREATE	FINANCE	invoice create permission
dacf137e-0b56-4750-b76f-9f797331d9d0	INVOICE_UPDATE	FINANCE	invoice update permission
e428389e-d88d-474a-b2b1-904ab695c1c9	INVOICE_DELETE	FINANCE	invoice delete permission
eb6cab8a-4805-4c24-ab93-73c23d92b167	PAYMENT_VIEW	FINANCE	payment view permission
96dff0f3-463f-40b7-b634-958d4d00d108	PAYMENT_CREATE	FINANCE	payment create permission
b9c10d31-340f-4031-a4d5-2efda25fc9f8	PAYMENT_UPDATE	FINANCE	payment update permission
2e6e6c86-010f-4c7f-ac12-efc359f32cce	PAYMENT_DELETE	FINANCE	payment delete permission
0d0aebd8-6ec9-412d-aa84-6d5827497e79	REPORTS_VIEW	REPORTS	reports view permission
9fd13690-27eb-473c-9cfc-b316900581f8	REPORTS_EXPORT	REPORTS	reports export permission
c827040b-d260-434a-a153-4976c33dfe78	DASHBOARD_VIEW	REPORTS	dashboard view permission
a17fbbd2-95d0-471a-8e27-d9246d7a5500	CRUD_VIEW	CRUD OPERATIONS	crud view permission
3c36163b-1e1d-4a8e-a1d8-bacd0ced9272	CRUD_CREATE	CRUD OPERATIONS	crud create permission
fb7a80ed-bffd-4813-995f-72591734e414	CRUD_UPDATE	CRUD OPERATIONS	crud update permission
02454815-cbdc-4c0e-99b6-e9ff558cd737	CRUD_DELETE	CRUD OPERATIONS	crud delete permission
c8e6222b-9099-4dab-80c6-d66d9e539856	SUPER_ADMIN	SPECIAL	super admin permission
ec67533b-6a6d-4bd7-b66a-387a9984cb2d	CRUD_ALL	SPECIAL	crud all permission
\.


--
-- TOC entry 6080 (class 0 OID 16754)
-- Dependencies: 222
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.role_permissions (role_id, permission_id) FROM stdin;
\.


--
-- TOC entry 6081 (class 0 OID 16759)
-- Dependencies: 223
-- Data for Name: roles; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.roles (id, role_name, description, is_system, "createdAt", "updatedAt") FROM stdin;
9be1f199-0c59-4944-9d86-13f1843fb82e	ADMIN	System Administrator	t	2025-12-26 16:14:30.591+05:30	2025-12-26 16:14:30.591+05:30
15dd3be6-f846-4722-b896-3a3efbe02a32	STAFF	staff 	t	2025-12-29 12:52:05.314574+05:30	2025-12-29 12:52:05.314574+05:30
\.


--
-- TOC entry 6082 (class 0 OID 16769)
-- Dependencies: 224
-- Data for Name: user_roles; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.user_roles (user_id, role_id) FROM stdin;
9671657e-e227-47ee-92e9-d66525d8c733	9be1f199-0c59-4944-9d86-13f1843fb82e
b2dfd549-6dfa-4934-ad5a-f99b3e224dd7	9be1f199-0c59-4944-9d86-13f1843fb82e
\.


--
-- TOC entry 6083 (class 0 OID 16774)
-- Dependencies: 225
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.users (id, name, email, password_hash, is_active, "createdAt", "updatedAt") FROM stdin;
9671657e-e227-47ee-92e9-d66525d8c733	Admin	admin@erp.com	$2b$10$jSz33NKomMR4n2pv0l.IZeU1UyM329/NHuO8ZVuZEtQQdMIg3tUWm	t	2025-12-26 16:14:30.748+05:30	2025-12-26 16:14:30.748+05:30
b2dfd549-6dfa-4934-ad5a-f99b3e224dd7	Admin1	admin@erp1.com	$2a$12$FZZJhHrvKE3RMkdbeR8kleIr5q7m1TE29w8gpX1tXuwW49ur4p4M.	t	2025-12-29 12:56:11.141472+05:30	2025-12-29 12:56:11.141472+05:30
\.


--
-- TOC entry 6084 (class 0 OID 16786)
-- Dependencies: 226
-- Data for Name: customers; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.customers (id, customer_code, name, phone, email, address, status, "createdAt", "updatedAt") FROM stdin;
a4fbf838-9389-4b15-937d-edd10661d243	\N	SteelWorld Industries	\N	\N	\N	ACTIVE	2025-12-30 17:42:52.159306+05:30	2025-12-30 17:42:52.159306+05:30
\.


--
-- TOC entry 6085 (class 0 OID 16796)
-- Dependencies: 227
-- Data for Name: dispatch; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.dispatch (id, so_id, dispatch_no, dispatch_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6086 (class 0 OID 16802)
-- Dependencies: 228
-- Data for Name: grn; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.grn (id, po_id, grn_no, received_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6120 (class 0 OID 18045)
-- Dependencies: 262
-- Data for Name: inquiry; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.inquiry (id, inquiry_no, inquiry_date, company_id, customer_id, expected_date, status, notes, created_by, created_at, modified_by, modified_at, source) FROM stdin;
185aacb0-6f92-418e-b23b-dec3d29c32b7	INQ-2025-1767097258748	2025-12-30	8e8a9c10-30d9-4bf3-888e-6a75f69bd310	a4fbf838-9389-4b15-937d-edd10661d243	2026-01-10	QUOTED	Updated	b2dfd549-6dfa-4934-ad5a-f99b3e224dd7	2025-12-30 17:50:58.735393+05:30	b2dfd549-6dfa-4934-ad5a-f99b3e224dd7	2025-12-31 11:10:20.088384+05:30	WEB
\.


--
-- TOC entry 6121 (class 0 OID 18082)
-- Dependencies: 263
-- Data for Name: inquiry_items; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.inquiry_items (id, enquiry_id, item_name, width, thickness, length, density, pricing_source, uom, qty, weight, unit_price, total_price, created_at) FROM stdin;
53e62b89-430f-4c4c-a4d3-d169bbf17d75	3c89a08c-f9bc-4ae5-97f1-e8eeb3af0171	Steel Rod	10	5	100	7.85	SALES	QTY	100	\N	50	5000	2025-12-30 18:02:14.490534+05:30
563e633e-d3db-44c5-adb5-60b0196d3a1a	185aacb0-6f92-418e-b23b-dec3d29c32b7	Steel Rod	10	5	100	7.85	SALES	QTY	100	\N	56	8250	2025-12-30 17:50:58.735393+05:30
\.


--
-- TOC entry 6087 (class 0 OID 16821)
-- Dependencies: 229
-- Data for Name: inventory; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.inventory (id, product_id, quantity) FROM stdin;
\.


--
-- TOC entry 6088 (class 0 OID 16827)
-- Dependencies: 230
-- Data for Name: invoice; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.invoice (id, so_id, invoice_no, total_amount, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6089 (class 0 OID 16835)
-- Dependencies: 231
-- Data for Name: packing; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.packing (id, wo_id, packed_qty, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6090 (class 0 OID 16843)
-- Dependencies: 232
-- Data for Name: payment; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.payment (id, invoice_id, amount, payment_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6091 (class 0 OID 16851)
-- Dependencies: 233
-- Data for Name: production_logs; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.production_logs (id, wo_id, produced_qty) FROM stdin;
\.


--
-- TOC entry 6092 (class 0 OID 16857)
-- Dependencies: 234
-- Data for Name: products; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.products (id, product_code, name, unit, category, status, "createdAt", "updatedAt") FROM stdin;
c3e19878-02c9-4e64-bf77-c900bfa1a74a	P001	Steel Rod	KG	Steel	ACTIVE	2025-12-29 13:33:11.997902+05:30	2025-12-29 13:33:11.997902+05:30
\.


--
-- TOC entry 6124 (class 0 OID 18150)
-- Dependencies: 266
-- Data for Name: purchase_order_line_attributes; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.purchase_order_line_attributes (id, po_line_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- TOC entry 6123 (class 0 OID 18136)
-- Dependencies: 265
-- Data for Name: purchase_order_lines; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.purchase_order_lines (id, po_id, material_name, count, quantity, weight, unit, unit_price, line_total, remarks) FROM stdin;
\.


--
-- TOC entry 6122 (class 0 OID 18102)
-- Dependencies: 264
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.purchase_orders (id, document_number, quotation_id, customer_id, po_date, status, approved_by, approved_date, remarks, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 6093 (class 0 OID 16874)
-- Dependencies: 235
-- Data for Name: qc_reports; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.qc_reports (id, production_id, accepted_qty, rejected_qty) FROM stdin;
\.


--
-- TOC entry 6127 (class 0 OID 18255)
-- Dependencies: 269
-- Data for Name: quotation_line_attributes; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.quotation_line_attributes (id, quotation_line_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- TOC entry 6126 (class 0 OID 18218)
-- Dependencies: 268
-- Data for Name: quotation_lines; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.quotation_lines (id, quotation_id, product_id, width, thickness, length, density, uom, quantity, weight, unit_price, discount_percent, taxable_amount, cgst_percent, sgst_percent, igst_percent, cgst_amount, sgst_amount, igst_amount, line_total, created_at) FROM stdin;
\.


--
-- TOC entry 6125 (class 0 OID 18171)
-- Dependencies: 267
-- Data for Name: quotations; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.quotations (id, quotation_no, revision_no, inquiry_id, customer_id, quotation_date, validity_date, total_before_tax, cgst_amount, sgst_amount, igst_amount, total_tax_amount, net_amount, status, created_by, approved_by, approved_at, is_deleted, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6094 (class 0 OID 16893)
-- Dependencies: 236
-- Data for Name: sales_orders; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.sales_orders (id, quotation_id, so_no, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6095 (class 0 OID 16900)
-- Dependencies: 237
-- Data for Name: suppliers; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.suppliers (id, supplier_code, name, phone, email, address, status, "createdAt", "updatedAt") FROM stdin;
8e8a9c10-30d9-4bf3-888e-6a75f69bd310	SUP-001	ABC Steel Suppliers	9876543210	contact@abcsteel.com	No. 12, Industrial Estate, Chennai, Tamil Nadu	ACTIVE	2025-12-30 11:19:17.139943+05:30	2025-12-30 11:19:17.139943+05:30
\.


--
-- TOC entry 6096 (class 0 OID 16910)
-- Dependencies: 238
-- Data for Name: work_orders; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp.work_orders (id, so_id, wo_no, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6097 (class 0 OID 16917)
-- Dependencies: 239
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, customer_code, name, email, phone, address, status, "createdAt", "updatedAt") FROM stdin;
27a6c101-8aab-4bfb-8a07-7a92d4898652	\N	Evvi Industries	evvi@tbi.com	9342070133	\N	ACTIVE	2025-12-29 13:31:34.55304+05:30	2025-12-29 13:31:34.55304+05:30
1c38cb19-d3c5-49cd-a377-4cd59fe19a38	\N	XYZ Industries	\N	\N	\N	ACTIVE	2025-12-30 17:35:31.417962+05:30	2025-12-30 17:35:31.417962+05:30
0956a1f0-e4f0-426f-b1ff-2b34a732d72b	\N	Evvi Industries	\N	\N	\N	ACTIVE	2025-12-30 17:35:51.059537+05:30	2025-12-30 17:35:51.059537+05:30
efc520c4-cb1f-41d7-b925-8e3a237e2058	\N	XYZ Industries	\N	\N	\N	ACTIVE	2025-12-30 17:40:53.28215+05:30	2025-12-30 17:40:53.28215+05:30
\.


--
-- TOC entry 6098 (class 0 OID 16927)
-- Dependencies: 240
-- Data for Name: dispatch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dispatch (id, so_id, dispatch_no, dispatch_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6099 (class 0 OID 16933)
-- Dependencies: 241
-- Data for Name: grn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grn (id, po_id, grn_no, received_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6119 (class 0 OID 17978)
-- Dependencies: 261
-- Data for Name: inquiry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquiry (id, inquiry_no, inquiry_date, company_id, customer_id, product_id, quantity, expected_date, status, notes, created_by, created_at, modified_by, modified_at, source) FROM stdin;
3b9caf03-231e-4b02-befd-3317c780c147	INQ-2025-1767074514374	2025-12-30	8e8a9c10-30d9-4bf3-888e-6a75f69bd310	27a6c101-8aab-4bfb-8a07-7a92d4898652	27a6c101-8aab-4bfb-8a07-7a92d4898652	100	2025-01-20	NEW	Bulk order enquiry	b2dfd549-6dfa-4934-ad5a-f99b3e224dd7	2025-12-30 11:31:54.375737+05:30	b2dfd549-6dfa-4934-ad5a-f99b3e224dd7	2025-12-30 11:31:54.375737+05:30	PHONE
\.


--
-- TOC entry 6100 (class 0 OID 16946)
-- Dependencies: 242
-- Data for Name: inquiry_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquiry_items (id, inquiry_id, product_id, quantity) FROM stdin;
f580ea42-0e2c-42f2-9a5f-e4744a6d91fc	2bf449da-8fd7-41de-ba8d-dff7ffa808ad	c3e19878-02c9-4e64-bf77-c900bfa1a74a	20
\.


--
-- TOC entry 6101 (class 0 OID 16952)
-- Dependencies: 243
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (id, product_id, quantity) FROM stdin;
\.


--
-- TOC entry 6102 (class 0 OID 16958)
-- Dependencies: 244
-- Data for Name: inventory_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_transactions (id, transaction_type, product_id, quantity, reference_id, reference_type, notes, transaction_date, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6103 (class 0 OID 16969)
-- Dependencies: 245
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice (id, so_id, invoice_no, total_amount, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6104 (class 0 OID 16977)
-- Dependencies: 246
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity, unit_price, subtotal, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6105 (class 0 OID 16988)
-- Dependencies: 247
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_number, customer_id, total_amount, status, order_date, delivery_date, notes, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6106 (class 0 OID 17000)
-- Dependencies: 248
-- Data for Name: packing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.packing (id, wo_id, packed_qty, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6107 (class 0 OID 17008)
-- Dependencies: 249
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (id, invoice_id, amount, payment_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6108 (class 0 OID 17016)
-- Dependencies: 250
-- Data for Name: production_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.production_logs (id, wo_id, produced_qty) FROM stdin;
\.


--
-- TOC entry 6109 (class 0 OID 17022)
-- Dependencies: 251
-- Data for Name: production_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.production_orders (id, production_number, product_id, quantity, status, start_date, completion_date, notes, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6110 (class 0 OID 17034)
-- Dependencies: 252
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, product_code, name, category, unit, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6111 (class 0 OID 17044)
-- Dependencies: 253
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_orders (id, supplier_id, status, po_no, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6112 (class 0 OID 17051)
-- Dependencies: 254
-- Data for Name: qc_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qc_reports (id, production_id, accepted_qty, rejected_qty) FROM stdin;
\.


--
-- TOC entry 6113 (class 0 OID 17057)
-- Dependencies: 255
-- Data for Name: quotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotation (id, inquiry_id, quotation_no, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6114 (class 0 OID 17064)
-- Dependencies: 256
-- Data for Name: quotation_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotation_items (id, quotation_id, product_id, rate, quantity) FROM stdin;
\.


--
-- TOC entry 6115 (class 0 OID 17070)
-- Dependencies: 257
-- Data for Name: sales_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_orders (id, quotation_id, so_no, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6116 (class 0 OID 17077)
-- Dependencies: 258
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, supplier_code, name, email, phone, address, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 6117 (class 0 OID 17087)
-- Dependencies: 259
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, role, status, last_login, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 6118 (class 0 OID 17100)
-- Dependencies: 260
-- Data for Name: work_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_orders (id, so_id, wo_no, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5194 (class 2606 OID 17108)
-- Name: permissions permissions_permission_key_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key UNIQUE (permission_key);


--
-- TOC entry 5196 (class 2606 OID 17110)
-- Name: permissions permissions_permission_key_key1; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key1 UNIQUE (permission_key);


--
-- TOC entry 5198 (class 2606 OID 17112)
-- Name: permissions permissions_permission_key_key10; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key10 UNIQUE (permission_key);


--
-- TOC entry 5200 (class 2606 OID 17114)
-- Name: permissions permissions_permission_key_key11; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key11 UNIQUE (permission_key);


--
-- TOC entry 5202 (class 2606 OID 17116)
-- Name: permissions permissions_permission_key_key12; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key12 UNIQUE (permission_key);


--
-- TOC entry 5204 (class 2606 OID 17118)
-- Name: permissions permissions_permission_key_key13; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key13 UNIQUE (permission_key);


--
-- TOC entry 5206 (class 2606 OID 17120)
-- Name: permissions permissions_permission_key_key14; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key14 UNIQUE (permission_key);


--
-- TOC entry 5208 (class 2606 OID 17122)
-- Name: permissions permissions_permission_key_key15; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key15 UNIQUE (permission_key);


--
-- TOC entry 5210 (class 2606 OID 17124)
-- Name: permissions permissions_permission_key_key16; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key16 UNIQUE (permission_key);


--
-- TOC entry 5212 (class 2606 OID 17126)
-- Name: permissions permissions_permission_key_key17; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key17 UNIQUE (permission_key);


--
-- TOC entry 5214 (class 2606 OID 17128)
-- Name: permissions permissions_permission_key_key18; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key18 UNIQUE (permission_key);


--
-- TOC entry 5216 (class 2606 OID 17130)
-- Name: permissions permissions_permission_key_key19; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key19 UNIQUE (permission_key);


--
-- TOC entry 5218 (class 2606 OID 17132)
-- Name: permissions permissions_permission_key_key2; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key2 UNIQUE (permission_key);


--
-- TOC entry 5220 (class 2606 OID 17134)
-- Name: permissions permissions_permission_key_key20; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key20 UNIQUE (permission_key);


--
-- TOC entry 5222 (class 2606 OID 17136)
-- Name: permissions permissions_permission_key_key21; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key21 UNIQUE (permission_key);


--
-- TOC entry 5224 (class 2606 OID 17138)
-- Name: permissions permissions_permission_key_key22; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key22 UNIQUE (permission_key);


--
-- TOC entry 5226 (class 2606 OID 17140)
-- Name: permissions permissions_permission_key_key23; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key23 UNIQUE (permission_key);


--
-- TOC entry 5228 (class 2606 OID 17142)
-- Name: permissions permissions_permission_key_key24; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key24 UNIQUE (permission_key);


--
-- TOC entry 5230 (class 2606 OID 17144)
-- Name: permissions permissions_permission_key_key25; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key25 UNIQUE (permission_key);


--
-- TOC entry 5232 (class 2606 OID 17146)
-- Name: permissions permissions_permission_key_key26; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key26 UNIQUE (permission_key);


--
-- TOC entry 5234 (class 2606 OID 17148)
-- Name: permissions permissions_permission_key_key27; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key27 UNIQUE (permission_key);


--
-- TOC entry 5236 (class 2606 OID 17150)
-- Name: permissions permissions_permission_key_key28; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key28 UNIQUE (permission_key);


--
-- TOC entry 5238 (class 2606 OID 17152)
-- Name: permissions permissions_permission_key_key29; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key29 UNIQUE (permission_key);


--
-- TOC entry 5240 (class 2606 OID 17154)
-- Name: permissions permissions_permission_key_key3; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key3 UNIQUE (permission_key);


--
-- TOC entry 5242 (class 2606 OID 17156)
-- Name: permissions permissions_permission_key_key30; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key30 UNIQUE (permission_key);


--
-- TOC entry 5244 (class 2606 OID 17158)
-- Name: permissions permissions_permission_key_key31; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key31 UNIQUE (permission_key);


--
-- TOC entry 5246 (class 2606 OID 17160)
-- Name: permissions permissions_permission_key_key32; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key32 UNIQUE (permission_key);


--
-- TOC entry 5248 (class 2606 OID 17162)
-- Name: permissions permissions_permission_key_key4; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key4 UNIQUE (permission_key);


--
-- TOC entry 5250 (class 2606 OID 17164)
-- Name: permissions permissions_permission_key_key5; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key5 UNIQUE (permission_key);


--
-- TOC entry 5252 (class 2606 OID 17166)
-- Name: permissions permissions_permission_key_key6; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key6 UNIQUE (permission_key);


--
-- TOC entry 5254 (class 2606 OID 17168)
-- Name: permissions permissions_permission_key_key7; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key7 UNIQUE (permission_key);


--
-- TOC entry 5256 (class 2606 OID 17170)
-- Name: permissions permissions_permission_key_key8; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key8 UNIQUE (permission_key);


--
-- TOC entry 5258 (class 2606 OID 17172)
-- Name: permissions permissions_permission_key_key9; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_permission_key_key9 UNIQUE (permission_key);


--
-- TOC entry 5260 (class 2606 OID 17174)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5262 (class 2606 OID 17176)
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- TOC entry 5264 (class 2606 OID 17178)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 5266 (class 2606 OID 17180)
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- TOC entry 5268 (class 2606 OID 17182)
-- Name: roles roles_role_name_key1; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key1 UNIQUE (role_name);


--
-- TOC entry 5270 (class 2606 OID 17184)
-- Name: roles roles_role_name_key10; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key10 UNIQUE (role_name);


--
-- TOC entry 5272 (class 2606 OID 17186)
-- Name: roles roles_role_name_key11; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key11 UNIQUE (role_name);


--
-- TOC entry 5274 (class 2606 OID 17188)
-- Name: roles roles_role_name_key12; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key12 UNIQUE (role_name);


--
-- TOC entry 5276 (class 2606 OID 17190)
-- Name: roles roles_role_name_key13; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key13 UNIQUE (role_name);


--
-- TOC entry 5278 (class 2606 OID 17192)
-- Name: roles roles_role_name_key14; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key14 UNIQUE (role_name);


--
-- TOC entry 5280 (class 2606 OID 17194)
-- Name: roles roles_role_name_key15; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key15 UNIQUE (role_name);


--
-- TOC entry 5282 (class 2606 OID 17196)
-- Name: roles roles_role_name_key16; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key16 UNIQUE (role_name);


--
-- TOC entry 5284 (class 2606 OID 17198)
-- Name: roles roles_role_name_key17; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key17 UNIQUE (role_name);


--
-- TOC entry 5286 (class 2606 OID 17200)
-- Name: roles roles_role_name_key18; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key18 UNIQUE (role_name);


--
-- TOC entry 5288 (class 2606 OID 17202)
-- Name: roles roles_role_name_key19; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key19 UNIQUE (role_name);


--
-- TOC entry 5290 (class 2606 OID 17204)
-- Name: roles roles_role_name_key2; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key2 UNIQUE (role_name);


--
-- TOC entry 5292 (class 2606 OID 17206)
-- Name: roles roles_role_name_key20; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key20 UNIQUE (role_name);


--
-- TOC entry 5294 (class 2606 OID 17208)
-- Name: roles roles_role_name_key21; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key21 UNIQUE (role_name);


--
-- TOC entry 5296 (class 2606 OID 17210)
-- Name: roles roles_role_name_key22; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key22 UNIQUE (role_name);


--
-- TOC entry 5298 (class 2606 OID 17212)
-- Name: roles roles_role_name_key23; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key23 UNIQUE (role_name);


--
-- TOC entry 5300 (class 2606 OID 17214)
-- Name: roles roles_role_name_key24; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key24 UNIQUE (role_name);


--
-- TOC entry 5302 (class 2606 OID 17216)
-- Name: roles roles_role_name_key25; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key25 UNIQUE (role_name);


--
-- TOC entry 5304 (class 2606 OID 17218)
-- Name: roles roles_role_name_key26; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key26 UNIQUE (role_name);


--
-- TOC entry 5306 (class 2606 OID 17220)
-- Name: roles roles_role_name_key27; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key27 UNIQUE (role_name);


--
-- TOC entry 5308 (class 2606 OID 17222)
-- Name: roles roles_role_name_key28; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key28 UNIQUE (role_name);


--
-- TOC entry 5310 (class 2606 OID 17224)
-- Name: roles roles_role_name_key29; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key29 UNIQUE (role_name);


--
-- TOC entry 5312 (class 2606 OID 17226)
-- Name: roles roles_role_name_key3; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key3 UNIQUE (role_name);


--
-- TOC entry 5314 (class 2606 OID 17228)
-- Name: roles roles_role_name_key30; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key30 UNIQUE (role_name);


--
-- TOC entry 5316 (class 2606 OID 17230)
-- Name: roles roles_role_name_key31; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key31 UNIQUE (role_name);


--
-- TOC entry 5318 (class 2606 OID 17232)
-- Name: roles roles_role_name_key32; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key32 UNIQUE (role_name);


--
-- TOC entry 5320 (class 2606 OID 17234)
-- Name: roles roles_role_name_key4; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key4 UNIQUE (role_name);


--
-- TOC entry 5322 (class 2606 OID 17236)
-- Name: roles roles_role_name_key5; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key5 UNIQUE (role_name);


--
-- TOC entry 5324 (class 2606 OID 17238)
-- Name: roles roles_role_name_key6; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key6 UNIQUE (role_name);


--
-- TOC entry 5326 (class 2606 OID 17240)
-- Name: roles roles_role_name_key7; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key7 UNIQUE (role_name);


--
-- TOC entry 5328 (class 2606 OID 17242)
-- Name: roles roles_role_name_key8; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key8 UNIQUE (role_name);


--
-- TOC entry 5330 (class 2606 OID 17244)
-- Name: roles roles_role_name_key9; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.roles
    ADD CONSTRAINT roles_role_name_key9 UNIQUE (role_name);


--
-- TOC entry 5332 (class 2606 OID 17246)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5334 (class 2606 OID 17248)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5336 (class 2606 OID 17250)
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- TOC entry 5338 (class 2606 OID 17252)
-- Name: users users_email_key10; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key10 UNIQUE (email);


--
-- TOC entry 5340 (class 2606 OID 17254)
-- Name: users users_email_key11; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key11 UNIQUE (email);


--
-- TOC entry 5342 (class 2606 OID 17256)
-- Name: users users_email_key12; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key12 UNIQUE (email);


--
-- TOC entry 5344 (class 2606 OID 17258)
-- Name: users users_email_key13; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key13 UNIQUE (email);


--
-- TOC entry 5346 (class 2606 OID 17260)
-- Name: users users_email_key14; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key14 UNIQUE (email);


--
-- TOC entry 5348 (class 2606 OID 17262)
-- Name: users users_email_key15; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key15 UNIQUE (email);


--
-- TOC entry 5350 (class 2606 OID 17264)
-- Name: users users_email_key16; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key16 UNIQUE (email);


--
-- TOC entry 5352 (class 2606 OID 17266)
-- Name: users users_email_key17; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key17 UNIQUE (email);


--
-- TOC entry 5354 (class 2606 OID 17268)
-- Name: users users_email_key18; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key18 UNIQUE (email);


--
-- TOC entry 5356 (class 2606 OID 17270)
-- Name: users users_email_key19; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key19 UNIQUE (email);


--
-- TOC entry 5358 (class 2606 OID 17272)
-- Name: users users_email_key2; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);


--
-- TOC entry 5360 (class 2606 OID 17274)
-- Name: users users_email_key20; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key20 UNIQUE (email);


--
-- TOC entry 5362 (class 2606 OID 17276)
-- Name: users users_email_key21; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key21 UNIQUE (email);


--
-- TOC entry 5364 (class 2606 OID 17278)
-- Name: users users_email_key22; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key22 UNIQUE (email);


--
-- TOC entry 5366 (class 2606 OID 17280)
-- Name: users users_email_key23; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key23 UNIQUE (email);


--
-- TOC entry 5368 (class 2606 OID 17282)
-- Name: users users_email_key24; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key24 UNIQUE (email);


--
-- TOC entry 5370 (class 2606 OID 17284)
-- Name: users users_email_key25; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key25 UNIQUE (email);


--
-- TOC entry 5372 (class 2606 OID 17286)
-- Name: users users_email_key26; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key26 UNIQUE (email);


--
-- TOC entry 5374 (class 2606 OID 17288)
-- Name: users users_email_key27; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key27 UNIQUE (email);


--
-- TOC entry 5376 (class 2606 OID 17290)
-- Name: users users_email_key28; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key28 UNIQUE (email);


--
-- TOC entry 5378 (class 2606 OID 17292)
-- Name: users users_email_key29; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key29 UNIQUE (email);


--
-- TOC entry 5380 (class 2606 OID 17294)
-- Name: users users_email_key3; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key3 UNIQUE (email);


--
-- TOC entry 5382 (class 2606 OID 17296)
-- Name: users users_email_key30; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key30 UNIQUE (email);


--
-- TOC entry 5384 (class 2606 OID 17298)
-- Name: users users_email_key31; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key31 UNIQUE (email);


--
-- TOC entry 5386 (class 2606 OID 17300)
-- Name: users users_email_key32; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key32 UNIQUE (email);


--
-- TOC entry 5388 (class 2606 OID 17302)
-- Name: users users_email_key33; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key33 UNIQUE (email);


--
-- TOC entry 5390 (class 2606 OID 17304)
-- Name: users users_email_key4; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key4 UNIQUE (email);


--
-- TOC entry 5392 (class 2606 OID 17306)
-- Name: users users_email_key5; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key5 UNIQUE (email);


--
-- TOC entry 5394 (class 2606 OID 17308)
-- Name: users users_email_key6; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key6 UNIQUE (email);


--
-- TOC entry 5396 (class 2606 OID 17310)
-- Name: users users_email_key7; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key7 UNIQUE (email);


--
-- TOC entry 5398 (class 2606 OID 17312)
-- Name: users users_email_key8; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key8 UNIQUE (email);


--
-- TOC entry 5400 (class 2606 OID 17314)
-- Name: users users_email_key9; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_email_key9 UNIQUE (email);


--
-- TOC entry 5402 (class 2606 OID 17316)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5404 (class 2606 OID 17318)
-- Name: customers customers_customer_code_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key UNIQUE (customer_code);


--
-- TOC entry 5406 (class 2606 OID 17320)
-- Name: customers customers_customer_code_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key1 UNIQUE (customer_code);


--
-- TOC entry 5408 (class 2606 OID 17322)
-- Name: customers customers_customer_code_key10; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key10 UNIQUE (customer_code);


--
-- TOC entry 5410 (class 2606 OID 17324)
-- Name: customers customers_customer_code_key11; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key11 UNIQUE (customer_code);


--
-- TOC entry 5412 (class 2606 OID 17326)
-- Name: customers customers_customer_code_key12; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key12 UNIQUE (customer_code);


--
-- TOC entry 5414 (class 2606 OID 17328)
-- Name: customers customers_customer_code_key13; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key13 UNIQUE (customer_code);


--
-- TOC entry 5416 (class 2606 OID 17330)
-- Name: customers customers_customer_code_key14; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key14 UNIQUE (customer_code);


--
-- TOC entry 5418 (class 2606 OID 17332)
-- Name: customers customers_customer_code_key15; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key15 UNIQUE (customer_code);


--
-- TOC entry 5420 (class 2606 OID 17334)
-- Name: customers customers_customer_code_key16; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key16 UNIQUE (customer_code);


--
-- TOC entry 5422 (class 2606 OID 17336)
-- Name: customers customers_customer_code_key17; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key17 UNIQUE (customer_code);


--
-- TOC entry 5424 (class 2606 OID 17338)
-- Name: customers customers_customer_code_key18; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key18 UNIQUE (customer_code);


--
-- TOC entry 5426 (class 2606 OID 17340)
-- Name: customers customers_customer_code_key19; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key19 UNIQUE (customer_code);


--
-- TOC entry 5428 (class 2606 OID 17342)
-- Name: customers customers_customer_code_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key2 UNIQUE (customer_code);


--
-- TOC entry 5430 (class 2606 OID 17344)
-- Name: customers customers_customer_code_key20; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key20 UNIQUE (customer_code);


--
-- TOC entry 5432 (class 2606 OID 17346)
-- Name: customers customers_customer_code_key21; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key21 UNIQUE (customer_code);


--
-- TOC entry 5434 (class 2606 OID 17348)
-- Name: customers customers_customer_code_key22; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key22 UNIQUE (customer_code);


--
-- TOC entry 5436 (class 2606 OID 17350)
-- Name: customers customers_customer_code_key23; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key23 UNIQUE (customer_code);


--
-- TOC entry 5438 (class 2606 OID 17352)
-- Name: customers customers_customer_code_key24; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key24 UNIQUE (customer_code);


--
-- TOC entry 5440 (class 2606 OID 17354)
-- Name: customers customers_customer_code_key25; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key25 UNIQUE (customer_code);


--
-- TOC entry 5442 (class 2606 OID 17356)
-- Name: customers customers_customer_code_key26; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key26 UNIQUE (customer_code);


--
-- TOC entry 5444 (class 2606 OID 17358)
-- Name: customers customers_customer_code_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key3 UNIQUE (customer_code);


--
-- TOC entry 5446 (class 2606 OID 17360)
-- Name: customers customers_customer_code_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key4 UNIQUE (customer_code);


--
-- TOC entry 5448 (class 2606 OID 17362)
-- Name: customers customers_customer_code_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key5 UNIQUE (customer_code);


--
-- TOC entry 5450 (class 2606 OID 17364)
-- Name: customers customers_customer_code_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key6 UNIQUE (customer_code);


--
-- TOC entry 5452 (class 2606 OID 17366)
-- Name: customers customers_customer_code_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key7 UNIQUE (customer_code);


--
-- TOC entry 5454 (class 2606 OID 17368)
-- Name: customers customers_customer_code_key8; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key8 UNIQUE (customer_code);


--
-- TOC entry 5456 (class 2606 OID 17370)
-- Name: customers customers_customer_code_key9; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_customer_code_key9 UNIQUE (customer_code);


--
-- TOC entry 5458 (class 2606 OID 17372)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 5460 (class 2606 OID 17374)
-- Name: dispatch dispatch_dispatch_no_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key UNIQUE (dispatch_no);


--
-- TOC entry 5462 (class 2606 OID 17376)
-- Name: dispatch dispatch_dispatch_no_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key1 UNIQUE (dispatch_no);


--
-- TOC entry 5464 (class 2606 OID 17378)
-- Name: dispatch dispatch_dispatch_no_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key2 UNIQUE (dispatch_no);


--
-- TOC entry 5466 (class 2606 OID 17380)
-- Name: dispatch dispatch_dispatch_no_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key3 UNIQUE (dispatch_no);


--
-- TOC entry 5468 (class 2606 OID 17382)
-- Name: dispatch dispatch_dispatch_no_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key4 UNIQUE (dispatch_no);


--
-- TOC entry 5470 (class 2606 OID 17384)
-- Name: dispatch dispatch_dispatch_no_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key5 UNIQUE (dispatch_no);


--
-- TOC entry 5472 (class 2606 OID 17386)
-- Name: dispatch dispatch_dispatch_no_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key6 UNIQUE (dispatch_no);


--
-- TOC entry 5474 (class 2606 OID 17388)
-- Name: dispatch dispatch_dispatch_no_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key7 UNIQUE (dispatch_no);


--
-- TOC entry 5476 (class 2606 OID 17390)
-- Name: dispatch dispatch_dispatch_no_key8; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key8 UNIQUE (dispatch_no);


--
-- TOC entry 5478 (class 2606 OID 17392)
-- Name: dispatch dispatch_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.dispatch
    ADD CONSTRAINT dispatch_pkey PRIMARY KEY (id);


--
-- TOC entry 5480 (class 2606 OID 17394)
-- Name: grn grn_grn_no_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key UNIQUE (grn_no);


--
-- TOC entry 5482 (class 2606 OID 17396)
-- Name: grn grn_grn_no_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key1 UNIQUE (grn_no);


--
-- TOC entry 5484 (class 2606 OID 17398)
-- Name: grn grn_grn_no_key10; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key10 UNIQUE (grn_no);


--
-- TOC entry 5486 (class 2606 OID 17400)
-- Name: grn grn_grn_no_key11; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key11 UNIQUE (grn_no);


--
-- TOC entry 5488 (class 2606 OID 17402)
-- Name: grn grn_grn_no_key12; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key12 UNIQUE (grn_no);


--
-- TOC entry 5490 (class 2606 OID 17404)
-- Name: grn grn_grn_no_key13; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key13 UNIQUE (grn_no);


--
-- TOC entry 5492 (class 2606 OID 17406)
-- Name: grn grn_grn_no_key14; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key14 UNIQUE (grn_no);


--
-- TOC entry 5494 (class 2606 OID 17408)
-- Name: grn grn_grn_no_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key2 UNIQUE (grn_no);


--
-- TOC entry 5496 (class 2606 OID 17410)
-- Name: grn grn_grn_no_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key3 UNIQUE (grn_no);


--
-- TOC entry 5498 (class 2606 OID 17412)
-- Name: grn grn_grn_no_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key4 UNIQUE (grn_no);


--
-- TOC entry 5500 (class 2606 OID 17414)
-- Name: grn grn_grn_no_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key5 UNIQUE (grn_no);


--
-- TOC entry 5502 (class 2606 OID 17416)
-- Name: grn grn_grn_no_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key6 UNIQUE (grn_no);


--
-- TOC entry 5504 (class 2606 OID 17418)
-- Name: grn grn_grn_no_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key7 UNIQUE (grn_no);


--
-- TOC entry 5506 (class 2606 OID 17420)
-- Name: grn grn_grn_no_key8; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key8 UNIQUE (grn_no);


--
-- TOC entry 5508 (class 2606 OID 17422)
-- Name: grn grn_grn_no_key9; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_grn_no_key9 UNIQUE (grn_no);


--
-- TOC entry 5510 (class 2606 OID 17424)
-- Name: grn grn_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.grn
    ADD CONSTRAINT grn_pkey PRIMARY KEY (id);


--
-- TOC entry 5888 (class 2606 OID 18070)
-- Name: inquiry inquiry_inquiry_no_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.inquiry
    ADD CONSTRAINT inquiry_inquiry_no_key UNIQUE (inquiry_no);


--
-- TOC entry 5894 (class 2606 OID 18099)
-- Name: inquiry_items inquiry_items_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.inquiry_items
    ADD CONSTRAINT inquiry_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5890 (class 2606 OID 18068)
-- Name: inquiry inquiry_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.inquiry
    ADD CONSTRAINT inquiry_pkey PRIMARY KEY (id);


--
-- TOC entry 5512 (class 2606 OID 17476)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- TOC entry 5514 (class 2606 OID 17478)
-- Name: invoice invoice_invoice_no_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key UNIQUE (invoice_no);


--
-- TOC entry 5516 (class 2606 OID 17480)
-- Name: invoice invoice_invoice_no_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key1 UNIQUE (invoice_no);


--
-- TOC entry 5518 (class 2606 OID 17482)
-- Name: invoice invoice_invoice_no_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key2 UNIQUE (invoice_no);


--
-- TOC entry 5520 (class 2606 OID 17484)
-- Name: invoice invoice_invoice_no_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key3 UNIQUE (invoice_no);


--
-- TOC entry 5522 (class 2606 OID 17486)
-- Name: invoice invoice_invoice_no_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key4 UNIQUE (invoice_no);


--
-- TOC entry 5524 (class 2606 OID 17488)
-- Name: invoice invoice_invoice_no_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key5 UNIQUE (invoice_no);


--
-- TOC entry 5526 (class 2606 OID 17490)
-- Name: invoice invoice_invoice_no_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key6 UNIQUE (invoice_no);


--
-- TOC entry 5528 (class 2606 OID 17492)
-- Name: invoice invoice_invoice_no_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_invoice_no_key7 UNIQUE (invoice_no);


--
-- TOC entry 5530 (class 2606 OID 17494)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 5532 (class 2606 OID 17496)
-- Name: packing packing_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.packing
    ADD CONSTRAINT packing_pkey PRIMARY KEY (id);


--
-- TOC entry 5534 (class 2606 OID 17498)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 5536 (class 2606 OID 17500)
-- Name: production_logs production_logs_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.production_logs
    ADD CONSTRAINT production_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5538 (class 2606 OID 17502)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 5540 (class 2606 OID 17504)
-- Name: products products_product_code_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key UNIQUE (product_code);


--
-- TOC entry 5542 (class 2606 OID 17506)
-- Name: products products_product_code_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key1 UNIQUE (product_code);


--
-- TOC entry 5544 (class 2606 OID 17508)
-- Name: products products_product_code_key10; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key10 UNIQUE (product_code);


--
-- TOC entry 5546 (class 2606 OID 17510)
-- Name: products products_product_code_key11; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key11 UNIQUE (product_code);


--
-- TOC entry 5548 (class 2606 OID 17512)
-- Name: products products_product_code_key12; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key12 UNIQUE (product_code);


--
-- TOC entry 5550 (class 2606 OID 17514)
-- Name: products products_product_code_key13; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key13 UNIQUE (product_code);


--
-- TOC entry 5552 (class 2606 OID 17516)
-- Name: products products_product_code_key14; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key14 UNIQUE (product_code);


--
-- TOC entry 5554 (class 2606 OID 17518)
-- Name: products products_product_code_key15; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key15 UNIQUE (product_code);


--
-- TOC entry 5556 (class 2606 OID 17520)
-- Name: products products_product_code_key16; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key16 UNIQUE (product_code);


--
-- TOC entry 5558 (class 2606 OID 17522)
-- Name: products products_product_code_key17; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key17 UNIQUE (product_code);


--
-- TOC entry 5560 (class 2606 OID 17524)
-- Name: products products_product_code_key18; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key18 UNIQUE (product_code);


--
-- TOC entry 5562 (class 2606 OID 17526)
-- Name: products products_product_code_key19; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key19 UNIQUE (product_code);


--
-- TOC entry 5564 (class 2606 OID 17528)
-- Name: products products_product_code_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key2 UNIQUE (product_code);


--
-- TOC entry 5566 (class 2606 OID 17530)
-- Name: products products_product_code_key20; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key20 UNIQUE (product_code);


--
-- TOC entry 5568 (class 2606 OID 17532)
-- Name: products products_product_code_key21; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key21 UNIQUE (product_code);


--
-- TOC entry 5570 (class 2606 OID 17534)
-- Name: products products_product_code_key22; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key22 UNIQUE (product_code);


--
-- TOC entry 5572 (class 2606 OID 17536)
-- Name: products products_product_code_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key3 UNIQUE (product_code);


--
-- TOC entry 5574 (class 2606 OID 17538)
-- Name: products products_product_code_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key4 UNIQUE (product_code);


--
-- TOC entry 5576 (class 2606 OID 17540)
-- Name: products products_product_code_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key5 UNIQUE (product_code);


--
-- TOC entry 5578 (class 2606 OID 17542)
-- Name: products products_product_code_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key6 UNIQUE (product_code);


--
-- TOC entry 5580 (class 2606 OID 17544)
-- Name: products products_product_code_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key7 UNIQUE (product_code);


--
-- TOC entry 5582 (class 2606 OID 17546)
-- Name: products products_product_code_key8; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key8 UNIQUE (product_code);


--
-- TOC entry 5584 (class 2606 OID 17548)
-- Name: products products_product_code_key9; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.products
    ADD CONSTRAINT products_product_code_key9 UNIQUE (product_code);


--
-- TOC entry 5906 (class 2606 OID 18157)
-- Name: purchase_order_line_attributes purchase_order_line_attributes_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.purchase_order_line_attributes
    ADD CONSTRAINT purchase_order_line_attributes_pkey PRIMARY KEY (id);


--
-- TOC entry 5903 (class 2606 OID 18149)
-- Name: purchase_order_lines purchase_order_lines_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.purchase_order_lines
    ADD CONSTRAINT purchase_order_lines_pkey PRIMARY KEY (id);


--
-- TOC entry 5898 (class 2606 OID 18120)
-- Name: purchase_orders purchase_orders_document_number_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.purchase_orders
    ADD CONSTRAINT purchase_orders_document_number_key UNIQUE (document_number);


--
-- TOC entry 5900 (class 2606 OID 18118)
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5586 (class 2606 OID 17584)
-- Name: qc_reports qc_reports_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.qc_reports
    ADD CONSTRAINT qc_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 5914 (class 2606 OID 18264)
-- Name: quotation_line_attributes quotation_line_attributes_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotation_line_attributes
    ADD CONSTRAINT quotation_line_attributes_pkey PRIMARY KEY (id);


--
-- TOC entry 5912 (class 2606 OID 18242)
-- Name: quotation_lines quotation_lines_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotation_lines
    ADD CONSTRAINT quotation_lines_pkey PRIMARY KEY (id);


--
-- TOC entry 5908 (class 2606 OID 18195)
-- Name: quotations quotations_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);


--
-- TOC entry 5588 (class 2606 OID 17630)
-- Name: sales_orders sales_orders_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5590 (class 2606 OID 17632)
-- Name: sales_orders sales_orders_so_no_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key UNIQUE (so_no);


--
-- TOC entry 5592 (class 2606 OID 17634)
-- Name: sales_orders sales_orders_so_no_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key1 UNIQUE (so_no);


--
-- TOC entry 5594 (class 2606 OID 17636)
-- Name: sales_orders sales_orders_so_no_key10; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key10 UNIQUE (so_no);


--
-- TOC entry 5596 (class 2606 OID 17638)
-- Name: sales_orders sales_orders_so_no_key11; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key11 UNIQUE (so_no);


--
-- TOC entry 5598 (class 2606 OID 17640)
-- Name: sales_orders sales_orders_so_no_key12; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key12 UNIQUE (so_no);


--
-- TOC entry 5600 (class 2606 OID 17642)
-- Name: sales_orders sales_orders_so_no_key13; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key13 UNIQUE (so_no);


--
-- TOC entry 5602 (class 2606 OID 17644)
-- Name: sales_orders sales_orders_so_no_key14; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key14 UNIQUE (so_no);


--
-- TOC entry 5604 (class 2606 OID 17646)
-- Name: sales_orders sales_orders_so_no_key15; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key15 UNIQUE (so_no);


--
-- TOC entry 5606 (class 2606 OID 17648)
-- Name: sales_orders sales_orders_so_no_key16; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key16 UNIQUE (so_no);


--
-- TOC entry 5608 (class 2606 OID 17650)
-- Name: sales_orders sales_orders_so_no_key17; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key17 UNIQUE (so_no);


--
-- TOC entry 5610 (class 2606 OID 17652)
-- Name: sales_orders sales_orders_so_no_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key2 UNIQUE (so_no);


--
-- TOC entry 5612 (class 2606 OID 17654)
-- Name: sales_orders sales_orders_so_no_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key3 UNIQUE (so_no);


--
-- TOC entry 5614 (class 2606 OID 17656)
-- Name: sales_orders sales_orders_so_no_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key4 UNIQUE (so_no);


--
-- TOC entry 5616 (class 2606 OID 17658)
-- Name: sales_orders sales_orders_so_no_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key5 UNIQUE (so_no);


--
-- TOC entry 5618 (class 2606 OID 17660)
-- Name: sales_orders sales_orders_so_no_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key6 UNIQUE (so_no);


--
-- TOC entry 5620 (class 2606 OID 17662)
-- Name: sales_orders sales_orders_so_no_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key7 UNIQUE (so_no);


--
-- TOC entry 5622 (class 2606 OID 17664)
-- Name: sales_orders sales_orders_so_no_key8; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key8 UNIQUE (so_no);


--
-- TOC entry 5624 (class 2606 OID 17666)
-- Name: sales_orders sales_orders_so_no_key9; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key9 UNIQUE (so_no);


--
-- TOC entry 5626 (class 2606 OID 17668)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- TOC entry 5628 (class 2606 OID 17670)
-- Name: suppliers suppliers_supplier_code_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key UNIQUE (supplier_code);


--
-- TOC entry 5630 (class 2606 OID 17672)
-- Name: suppliers suppliers_supplier_code_key1; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key1 UNIQUE (supplier_code);


--
-- TOC entry 5632 (class 2606 OID 17674)
-- Name: suppliers suppliers_supplier_code_key10; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key10 UNIQUE (supplier_code);


--
-- TOC entry 5634 (class 2606 OID 17676)
-- Name: suppliers suppliers_supplier_code_key11; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key11 UNIQUE (supplier_code);


--
-- TOC entry 5636 (class 2606 OID 17678)
-- Name: suppliers suppliers_supplier_code_key12; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key12 UNIQUE (supplier_code);


--
-- TOC entry 5638 (class 2606 OID 17680)
-- Name: suppliers suppliers_supplier_code_key13; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key13 UNIQUE (supplier_code);


--
-- TOC entry 5640 (class 2606 OID 17682)
-- Name: suppliers suppliers_supplier_code_key14; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key14 UNIQUE (supplier_code);


--
-- TOC entry 5642 (class 2606 OID 17684)
-- Name: suppliers suppliers_supplier_code_key15; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key15 UNIQUE (supplier_code);


--
-- TOC entry 5644 (class 2606 OID 17686)
-- Name: suppliers suppliers_supplier_code_key16; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key16 UNIQUE (supplier_code);


--
-- TOC entry 5646 (class 2606 OID 17688)
-- Name: suppliers suppliers_supplier_code_key17; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key17 UNIQUE (supplier_code);


--
-- TOC entry 5648 (class 2606 OID 17690)
-- Name: suppliers suppliers_supplier_code_key18; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key18 UNIQUE (supplier_code);


--
-- TOC entry 5650 (class 2606 OID 17692)
-- Name: suppliers suppliers_supplier_code_key19; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key19 UNIQUE (supplier_code);


--
-- TOC entry 5652 (class 2606 OID 17694)
-- Name: suppliers suppliers_supplier_code_key2; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key2 UNIQUE (supplier_code);


--
-- TOC entry 5654 (class 2606 OID 17696)
-- Name: suppliers suppliers_supplier_code_key20; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key20 UNIQUE (supplier_code);


--
-- TOC entry 5656 (class 2606 OID 17698)
-- Name: suppliers suppliers_supplier_code_key21; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key21 UNIQUE (supplier_code);


--
-- TOC entry 5658 (class 2606 OID 17700)
-- Name: suppliers suppliers_supplier_code_key22; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key22 UNIQUE (supplier_code);


--
-- TOC entry 5660 (class 2606 OID 17702)
-- Name: suppliers suppliers_supplier_code_key23; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key23 UNIQUE (supplier_code);


--
-- TOC entry 5662 (class 2606 OID 17704)
-- Name: suppliers suppliers_supplier_code_key24; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key24 UNIQUE (supplier_code);


--
-- TOC entry 5664 (class 2606 OID 17706)
-- Name: suppliers suppliers_supplier_code_key3; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key3 UNIQUE (supplier_code);


--
-- TOC entry 5666 (class 2606 OID 17708)
-- Name: suppliers suppliers_supplier_code_key4; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key4 UNIQUE (supplier_code);


--
-- TOC entry 5668 (class 2606 OID 17710)
-- Name: suppliers suppliers_supplier_code_key5; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key5 UNIQUE (supplier_code);


--
-- TOC entry 5670 (class 2606 OID 17712)
-- Name: suppliers suppliers_supplier_code_key6; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key6 UNIQUE (supplier_code);


--
-- TOC entry 5672 (class 2606 OID 17714)
-- Name: suppliers suppliers_supplier_code_key7; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key7 UNIQUE (supplier_code);


--
-- TOC entry 5674 (class 2606 OID 17716)
-- Name: suppliers suppliers_supplier_code_key8; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key8 UNIQUE (supplier_code);


--
-- TOC entry 5676 (class 2606 OID 17718)
-- Name: suppliers suppliers_supplier_code_key9; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key9 UNIQUE (supplier_code);


--
-- TOC entry 5910 (class 2606 OID 18197)
-- Name: quotations uq_quotation_no_rev; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotations
    ADD CONSTRAINT uq_quotation_no_rev UNIQUE (quotation_no, revision_no);


--
-- TOC entry 5678 (class 2606 OID 17720)
-- Name: work_orders work_orders_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.work_orders
    ADD CONSTRAINT work_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5680 (class 2606 OID 17722)
-- Name: customers customers_customer_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_customer_code_key UNIQUE (customer_code);


--
-- TOC entry 5682 (class 2606 OID 17724)
-- Name: customers customers_customer_code_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_customer_code_key1 UNIQUE (customer_code);


--
-- TOC entry 5684 (class 2606 OID 17726)
-- Name: customers customers_customer_code_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_customer_code_key2 UNIQUE (customer_code);


--
-- TOC entry 5686 (class 2606 OID 17728)
-- Name: customers customers_customer_code_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_customer_code_key3 UNIQUE (customer_code);


--
-- TOC entry 5688 (class 2606 OID 17730)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 5690 (class 2606 OID 17732)
-- Name: dispatch dispatch_dispatch_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key UNIQUE (dispatch_no);


--
-- TOC entry 5692 (class 2606 OID 17734)
-- Name: dispatch dispatch_dispatch_no_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key1 UNIQUE (dispatch_no);


--
-- TOC entry 5694 (class 2606 OID 17736)
-- Name: dispatch dispatch_dispatch_no_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key10 UNIQUE (dispatch_no);


--
-- TOC entry 5696 (class 2606 OID 17738)
-- Name: dispatch dispatch_dispatch_no_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key11 UNIQUE (dispatch_no);


--
-- TOC entry 5698 (class 2606 OID 17740)
-- Name: dispatch dispatch_dispatch_no_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key2 UNIQUE (dispatch_no);


--
-- TOC entry 5700 (class 2606 OID 17742)
-- Name: dispatch dispatch_dispatch_no_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key3 UNIQUE (dispatch_no);


--
-- TOC entry 5702 (class 2606 OID 17744)
-- Name: dispatch dispatch_dispatch_no_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key4 UNIQUE (dispatch_no);


--
-- TOC entry 5704 (class 2606 OID 17746)
-- Name: dispatch dispatch_dispatch_no_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key5 UNIQUE (dispatch_no);


--
-- TOC entry 5706 (class 2606 OID 17748)
-- Name: dispatch dispatch_dispatch_no_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key6 UNIQUE (dispatch_no);


--
-- TOC entry 5708 (class 2606 OID 17750)
-- Name: dispatch dispatch_dispatch_no_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key7 UNIQUE (dispatch_no);


--
-- TOC entry 5710 (class 2606 OID 17752)
-- Name: dispatch dispatch_dispatch_no_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key8 UNIQUE (dispatch_no);


--
-- TOC entry 5712 (class 2606 OID 17754)
-- Name: dispatch dispatch_dispatch_no_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_dispatch_no_key9 UNIQUE (dispatch_no);


--
-- TOC entry 5714 (class 2606 OID 17756)
-- Name: dispatch dispatch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispatch
    ADD CONSTRAINT dispatch_pkey PRIMARY KEY (id);


--
-- TOC entry 5716 (class 2606 OID 17758)
-- Name: grn grn_grn_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key UNIQUE (grn_no);


--
-- TOC entry 5718 (class 2606 OID 17760)
-- Name: grn grn_grn_no_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key1 UNIQUE (grn_no);


--
-- TOC entry 5720 (class 2606 OID 17762)
-- Name: grn grn_grn_no_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key2 UNIQUE (grn_no);


--
-- TOC entry 5722 (class 2606 OID 17764)
-- Name: grn grn_grn_no_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key3 UNIQUE (grn_no);


--
-- TOC entry 5724 (class 2606 OID 17766)
-- Name: grn grn_grn_no_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key4 UNIQUE (grn_no);


--
-- TOC entry 5726 (class 2606 OID 17768)
-- Name: grn grn_grn_no_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key5 UNIQUE (grn_no);


--
-- TOC entry 5728 (class 2606 OID 17770)
-- Name: grn grn_grn_no_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key6 UNIQUE (grn_no);


--
-- TOC entry 5730 (class 2606 OID 17772)
-- Name: grn grn_grn_no_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_grn_no_key7 UNIQUE (grn_no);


--
-- TOC entry 5732 (class 2606 OID 17774)
-- Name: grn grn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grn
    ADD CONSTRAINT grn_pkey PRIMARY KEY (id);


--
-- TOC entry 5880 (class 2606 OID 18003)
-- Name: inquiry inquiry_inquiry_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_inquiry_no_key UNIQUE (inquiry_no);


--
-- TOC entry 5734 (class 2606 OID 17782)
-- Name: inquiry_items inquiry_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry_items
    ADD CONSTRAINT inquiry_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5882 (class 2606 OID 18001)
-- Name: inquiry inquiry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_pkey PRIMARY KEY (id);


--
-- TOC entry 5736 (class 2606 OID 17786)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- TOC entry 5738 (class 2606 OID 17788)
-- Name: inventory_transactions inventory_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 5740 (class 2606 OID 17790)
-- Name: invoice invoice_invoice_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key UNIQUE (invoice_no);


--
-- TOC entry 5742 (class 2606 OID 17792)
-- Name: invoice invoice_invoice_no_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key1 UNIQUE (invoice_no);


--
-- TOC entry 5744 (class 2606 OID 17794)
-- Name: invoice invoice_invoice_no_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key10 UNIQUE (invoice_no);


--
-- TOC entry 5746 (class 2606 OID 17796)
-- Name: invoice invoice_invoice_no_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key11 UNIQUE (invoice_no);


--
-- TOC entry 5748 (class 2606 OID 17798)
-- Name: invoice invoice_invoice_no_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key12 UNIQUE (invoice_no);


--
-- TOC entry 5750 (class 2606 OID 17800)
-- Name: invoice invoice_invoice_no_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key2 UNIQUE (invoice_no);


--
-- TOC entry 5752 (class 2606 OID 17802)
-- Name: invoice invoice_invoice_no_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key3 UNIQUE (invoice_no);


--
-- TOC entry 5754 (class 2606 OID 17804)
-- Name: invoice invoice_invoice_no_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key4 UNIQUE (invoice_no);


--
-- TOC entry 5756 (class 2606 OID 17806)
-- Name: invoice invoice_invoice_no_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key5 UNIQUE (invoice_no);


--
-- TOC entry 5758 (class 2606 OID 17808)
-- Name: invoice invoice_invoice_no_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key6 UNIQUE (invoice_no);


--
-- TOC entry 5760 (class 2606 OID 17810)
-- Name: invoice invoice_invoice_no_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key7 UNIQUE (invoice_no);


--
-- TOC entry 5762 (class 2606 OID 17812)
-- Name: invoice invoice_invoice_no_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key8 UNIQUE (invoice_no);


--
-- TOC entry 5764 (class 2606 OID 17814)
-- Name: invoice invoice_invoice_no_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_invoice_no_key9 UNIQUE (invoice_no);


--
-- TOC entry 5766 (class 2606 OID 17816)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 5768 (class 2606 OID 17818)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5770 (class 2606 OID 17820)
-- Name: orders orders_order_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key UNIQUE (order_number);


--
-- TOC entry 5772 (class 2606 OID 17822)
-- Name: orders orders_order_number_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key1 UNIQUE (order_number);


--
-- TOC entry 5774 (class 2606 OID 17824)
-- Name: orders orders_order_number_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key2 UNIQUE (order_number);


--
-- TOC entry 5776 (class 2606 OID 17826)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5778 (class 2606 OID 17828)
-- Name: packing packing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packing
    ADD CONSTRAINT packing_pkey PRIMARY KEY (id);


--
-- TOC entry 5780 (class 2606 OID 17830)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 5782 (class 2606 OID 17832)
-- Name: production_logs production_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_logs
    ADD CONSTRAINT production_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5784 (class 2606 OID 17834)
-- Name: production_orders production_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5786 (class 2606 OID 17836)
-- Name: production_orders production_orders_production_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_production_number_key UNIQUE (production_number);


--
-- TOC entry 5788 (class 2606 OID 17838)
-- Name: production_orders production_orders_production_number_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_production_number_key1 UNIQUE (production_number);


--
-- TOC entry 5790 (class 2606 OID 17840)
-- Name: production_orders production_orders_production_number_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_production_number_key2 UNIQUE (production_number);


--
-- TOC entry 5792 (class 2606 OID 17842)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 5794 (class 2606 OID 17844)
-- Name: products products_product_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_code_key UNIQUE (product_code);


--
-- TOC entry 5796 (class 2606 OID 17846)
-- Name: products products_product_code_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_code_key1 UNIQUE (product_code);


--
-- TOC entry 5798 (class 2606 OID 17848)
-- Name: products products_product_code_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_code_key2 UNIQUE (product_code);


--
-- TOC entry 5800 (class 2606 OID 17850)
-- Name: products products_product_code_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_code_key3 UNIQUE (product_code);


--
-- TOC entry 5802 (class 2606 OID 17852)
-- Name: products products_product_code_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_code_key4 UNIQUE (product_code);


--
-- TOC entry 5804 (class 2606 OID 17854)
-- Name: products products_product_code_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_code_key5 UNIQUE (product_code);


--
-- TOC entry 5806 (class 2606 OID 17856)
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5808 (class 2606 OID 17858)
-- Name: purchase_orders purchase_orders_po_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key UNIQUE (po_no);


--
-- TOC entry 5810 (class 2606 OID 17860)
-- Name: purchase_orders purchase_orders_po_no_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key1 UNIQUE (po_no);


--
-- TOC entry 5812 (class 2606 OID 17862)
-- Name: purchase_orders purchase_orders_po_no_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key2 UNIQUE (po_no);


--
-- TOC entry 5814 (class 2606 OID 17864)
-- Name: purchase_orders purchase_orders_po_no_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key3 UNIQUE (po_no);


--
-- TOC entry 5816 (class 2606 OID 17866)
-- Name: purchase_orders purchase_orders_po_no_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key4 UNIQUE (po_no);


--
-- TOC entry 5818 (class 2606 OID 17868)
-- Name: purchase_orders purchase_orders_po_no_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key5 UNIQUE (po_no);


--
-- TOC entry 5820 (class 2606 OID 17870)
-- Name: purchase_orders purchase_orders_po_no_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key6 UNIQUE (po_no);


--
-- TOC entry 5822 (class 2606 OID 17872)
-- Name: qc_reports qc_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qc_reports
    ADD CONSTRAINT qc_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 5836 (class 2606 OID 17874)
-- Name: quotation_items quotation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5824 (class 2606 OID 17876)
-- Name: quotation quotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_pkey PRIMARY KEY (id);


--
-- TOC entry 5826 (class 2606 OID 17878)
-- Name: quotation quotation_quotation_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_quotation_no_key UNIQUE (quotation_no);


--
-- TOC entry 5828 (class 2606 OID 17880)
-- Name: quotation quotation_quotation_no_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_quotation_no_key1 UNIQUE (quotation_no);


--
-- TOC entry 5830 (class 2606 OID 17882)
-- Name: quotation quotation_quotation_no_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_quotation_no_key2 UNIQUE (quotation_no);


--
-- TOC entry 5832 (class 2606 OID 17884)
-- Name: quotation quotation_quotation_no_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_quotation_no_key3 UNIQUE (quotation_no);


--
-- TOC entry 5834 (class 2606 OID 17886)
-- Name: quotation quotation_quotation_no_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_quotation_no_key4 UNIQUE (quotation_no);


--
-- TOC entry 5838 (class 2606 OID 17888)
-- Name: sales_orders sales_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5840 (class 2606 OID 17890)
-- Name: sales_orders sales_orders_so_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key UNIQUE (so_no);


--
-- TOC entry 5842 (class 2606 OID 17892)
-- Name: sales_orders sales_orders_so_no_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key1 UNIQUE (so_no);


--
-- TOC entry 5844 (class 2606 OID 17894)
-- Name: sales_orders sales_orders_so_no_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key2 UNIQUE (so_no);


--
-- TOC entry 5846 (class 2606 OID 17896)
-- Name: sales_orders sales_orders_so_no_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key3 UNIQUE (so_no);


--
-- TOC entry 5848 (class 2606 OID 17898)
-- Name: sales_orders sales_orders_so_no_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key4 UNIQUE (so_no);


--
-- TOC entry 5850 (class 2606 OID 17900)
-- Name: sales_orders sales_orders_so_no_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key5 UNIQUE (so_no);


--
-- TOC entry 5852 (class 2606 OID 17902)
-- Name: sales_orders sales_orders_so_no_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key6 UNIQUE (so_no);


--
-- TOC entry 5854 (class 2606 OID 17904)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- TOC entry 5856 (class 2606 OID 17906)
-- Name: suppliers suppliers_supplier_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key UNIQUE (supplier_code);


--
-- TOC entry 5858 (class 2606 OID 17908)
-- Name: suppliers suppliers_supplier_code_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key1 UNIQUE (supplier_code);


--
-- TOC entry 5860 (class 2606 OID 17910)
-- Name: suppliers suppliers_supplier_code_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key2 UNIQUE (supplier_code);


--
-- TOC entry 5862 (class 2606 OID 17912)
-- Name: suppliers suppliers_supplier_code_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key3 UNIQUE (supplier_code);


--
-- TOC entry 5864 (class 2606 OID 17914)
-- Name: suppliers suppliers_supplier_code_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_supplier_code_key4 UNIQUE (supplier_code);


--
-- TOC entry 5866 (class 2606 OID 17916)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5868 (class 2606 OID 17918)
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- TOC entry 5870 (class 2606 OID 17920)
-- Name: users users_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);


--
-- TOC entry 5872 (class 2606 OID 17922)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5874 (class 2606 OID 17924)
-- Name: work_orders work_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5883 (class 1259 OID 18071)
-- Name: idx_erp_inquiry_company_id; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_erp_inquiry_company_id ON erp.inquiry USING btree (company_id);


--
-- TOC entry 5884 (class 1259 OID 18074)
-- Name: idx_erp_inquiry_created_at; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_erp_inquiry_created_at ON erp.inquiry USING btree (created_at);


--
-- TOC entry 5885 (class 1259 OID 18072)
-- Name: idx_erp_inquiry_customer_id; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_erp_inquiry_customer_id ON erp.inquiry USING btree (customer_id);


--
-- TOC entry 5886 (class 1259 OID 18073)
-- Name: idx_erp_inquiry_status; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_erp_inquiry_status ON erp.inquiry USING btree (status);


--
-- TOC entry 5891 (class 1259 OID 18100)
-- Name: idx_inquiry_items_enquiry_id; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_inquiry_items_enquiry_id ON erp.inquiry_items USING btree (enquiry_id);


--
-- TOC entry 5892 (class 1259 OID 18101)
-- Name: idx_inquiry_items_item_name; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_inquiry_items_item_name ON erp.inquiry_items USING btree (item_name);


--
-- TOC entry 5895 (class 1259 OID 18167)
-- Name: idx_po_customer_id; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_po_customer_id ON erp.purchase_orders USING btree (customer_id);


--
-- TOC entry 5904 (class 1259 OID 18170)
-- Name: idx_po_line_attr_po_line_id; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_po_line_attr_po_line_id ON erp.purchase_order_line_attributes USING btree (po_line_id);


--
-- TOC entry 5901 (class 1259 OID 18169)
-- Name: idx_po_lines_po_id; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_po_lines_po_id ON erp.purchase_order_lines USING btree (po_id);


--
-- TOC entry 5896 (class 1259 OID 18168)
-- Name: idx_po_status; Type: INDEX; Schema: erp; Owner: postgres
--

CREATE INDEX idx_po_status ON erp.purchase_orders USING btree (status);


--
-- TOC entry 5875 (class 1259 OID 18030)
-- Name: idx_inquiry_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inquiry_company_id ON public.inquiry USING btree (company_id);


--
-- TOC entry 5876 (class 1259 OID 18032)
-- Name: idx_inquiry_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inquiry_created_at ON public.inquiry USING btree (created_at);


--
-- TOC entry 5877 (class 1259 OID 18029)
-- Name: idx_inquiry_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inquiry_customer_id ON public.inquiry USING btree (customer_id);


--
-- TOC entry 5878 (class 1259 OID 18031)
-- Name: idx_inquiry_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inquiry_status ON public.inquiry USING btree (status);


--
-- TOC entry 5915 (class 2606 OID 17925)
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth.permissions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5916 (class 2606 OID 17930)
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES auth.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5917 (class 2606 OID 17935)
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES auth.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5918 (class 2606 OID 17940)
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5925 (class 2606 OID 18213)
-- Name: quotations fk_quotation_approved_by; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotations
    ADD CONSTRAINT fk_quotation_approved_by FOREIGN KEY (approved_by) REFERENCES auth.users(id);


--
-- TOC entry 5926 (class 2606 OID 18208)
-- Name: quotations fk_quotation_created_by; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotations
    ADD CONSTRAINT fk_quotation_created_by FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- TOC entry 5927 (class 2606 OID 18203)
-- Name: quotations fk_quotation_customer; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotations
    ADD CONSTRAINT fk_quotation_customer FOREIGN KEY (customer_id) REFERENCES erp.customers(id);


--
-- TOC entry 5928 (class 2606 OID 18198)
-- Name: quotations fk_quotation_inquiry; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotations
    ADD CONSTRAINT fk_quotation_inquiry FOREIGN KEY (inquiry_id) REFERENCES erp.inquiry(id);


--
-- TOC entry 5931 (class 2606 OID 18265)
-- Name: quotation_line_attributes fk_quotation_line_attr; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotation_line_attributes
    ADD CONSTRAINT fk_quotation_line_attr FOREIGN KEY (quotation_line_id) REFERENCES erp.quotation_lines(id) ON DELETE CASCADE;


--
-- TOC entry 5929 (class 2606 OID 18243)
-- Name: quotation_lines fk_quotation_line_header; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotation_lines
    ADD CONSTRAINT fk_quotation_line_header FOREIGN KEY (quotation_id) REFERENCES erp.quotations(id) ON DELETE CASCADE;


--
-- TOC entry 5930 (class 2606 OID 18248)
-- Name: quotation_lines fk_quotation_line_product; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp.quotation_lines
    ADD CONSTRAINT fk_quotation_line_product FOREIGN KEY (product_id) REFERENCES erp.products(id);


--
-- TOC entry 5919 (class 2606 OID 17945)
-- Name: inventory_transactions inventory_transactions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_transactions
    ADD CONSTRAINT inventory_transactions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE;


--
-- TOC entry 5920 (class 2606 OID 17950)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE;


--
-- TOC entry 5921 (class 2606 OID 17955)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE;


--
-- TOC entry 5922 (class 2606 OID 17960)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON UPDATE CASCADE;


--
-- TOC entry 5923 (class 2606 OID 17965)
-- Name: production_orders production_orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE;


--
-- TOC entry 5924 (class 2606 OID 17970)
-- Name: purchase_orders purchase_orders_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON UPDATE CASCADE;


-- Completed on 2025-12-31 12:17:33

--
-- PostgreSQL database dump complete
--

\unrestrict 3lsILjnURCQYJwTkm8TGcmzcSSQBMUHvccW6qqnvm9XPaVCoPsLIS9f2lsmw1ka

