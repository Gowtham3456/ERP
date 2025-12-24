CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role VARCHAR(50) NOT NULL
        CHECK (role IN ('SUPER_ADMIN', 'ADMIN', 'STAFF')),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(150),
    company_name VARCHAR(150),
    gst_number VARCHAR(20),
    billing_address TEXT,
    shipping_address TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    material_type VARCHAR(50)
        CHECK (material_type IN ('ALUMINIUM', 'STEEL')),
    quantity_available INT DEFAULT 0,
    width DECIMAL(10,2),
    height DECIMAL(10,2),
    thickness DECIMAL(10,2),
    unit VARCHAR(20) DEFAULT 'mm',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE enquiry (
    enquiry_id SERIAL PRIMARY KEY,
    customer_id INT,
    enquiry_status VARCHAR(50) DEFAULT 'PENDING'
        CHECK (enquiry_status IN ('PENDING', 'IN_PROGRESS', 'QUOTED', 'CLOSED')),
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_user
        FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON DELETE SET NULL
);

CREATE TABLE enquiry_items (
    id SERIAL PRIMARY KEY,
    enquiry_id INT NOT NULL,
    item_name VARCHAR(150) NOT NULL,
    width DECIMAL(10,2),
    thickness DECIMAL(10,2),
    length DECIMAL(10,2),
    density DECIMAL(10,4),
    pricing_source VARCHAR(20) NOT NULL
        CHECK (pricing_source IN ('PURCHASE', 'SALES')),
    uom VARCHAR(20) NOT NULL
        CHECK (uom IN ('QTY', 'WEIGHTS')),
    qty INT,
    weight DECIMAL(12,3),
    unit_price DECIMAL(12,2),
    total_price DECIMAL(14,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_enquiry
        FOREIGN KEY (enquiry_id)
        REFERENCES enquiry(enquiry_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_uom_logic CHECK (
        (uom = 'QTY' AND qty IS NOT NULL AND weight IS NULL)
        OR
        (uom = 'WEIGHTS' AND weight IS NOT NULL AND qty IS NULL)
    )
);

CREATE TABLE quotations (
    quotation_id SERIAL PRIMARY KEY,

    quotation_number VARCHAR(50) NOT NULL,
    revision_no INT DEFAULT 1,

    enquiry_id INT NOT NULL,
    customer_id INT NOT NULL,

    quotation_date DATE NOT NULL,
    valid_till DATE,

    total_before_tax DECIMAL(14,2) DEFAULT 0,
    cgst_amount DECIMAL(14,2) DEFAULT 0,
    sgst_amount DECIMAL(14,2) DEFAULT 0,
    igst_amount DECIMAL(14,2) DEFAULT 0,
    net_amount DECIMAL(14,2) DEFAULT 0,

    status VARCHAR(30) DEFAULT 'DRAFT'
        CHECK (status IN (
            'DRAFT',
            'SENT',
            'APPROVED',
            'REJECTED',
            'EXPIRED',
            'CONVERTED_TO_PO'
        )),

    created_by INT NOT NULL,
    approved_by INT,
    approved_at TIMESTAMP,

    is_deleted BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_quotation UNIQUE (quotation_number, revision_no),

    FOREIGN KEY (enquiry_id) REFERENCES enquiry(enquiry_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

CREATE TABLE quotation_items (
    quotation_item_id SERIAL PRIMARY KEY,
    quotation_id INT NOT NULL,

    item_description VARCHAR(200) NOT NULL,

    uom VARCHAR(20) NOT NULL
        CHECK (uom IN ('QTY','KG','MT')),

    quantity DECIMAL(12,3) NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,

    discount_percent DECIMAL(5,2) DEFAULT 0,
    taxable_amount DECIMAL(14,2) NOT NULL,

    cgst_percent DECIMAL(5,2) DEFAULT 0,
    sgst_percent DECIMAL(5,2) DEFAULT 0,
    igst_percent DECIMAL(5,2) DEFAULT 0,

    cgst_amount DECIMAL(12,2) DEFAULT 0,
    sgst_amount DECIMAL(12,2) DEFAULT 0,
    igst_amount DECIMAL(12,2) DEFAULT 0,

    line_total DECIMAL(14,2) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (quotation_id)
        REFERENCES quotations(quotation_id)
        ON DELETE CASCADE
);
