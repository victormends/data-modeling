-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-03-31 17:59:20.621

-- tables
-- Table: adress
CREATE TABLE adress (
    id int  NOT NULL,
    street varchar(150)  NOT NULL,
    city varchar(150)  NOT NULL,
    state varchar(150)  NOT NULL,
    zipcode char(9)  NOT NULL,
    CONSTRAINT adress_pk PRIMARY KEY  (id)
);

-- Table: vehicles
CREATE TABLE vehicles (
    id int  NOT NULL,
    model varchar(100)  NOT NULL,
    type varchar(50)  NOT NULL,
    CONSTRAINT vehicles_pk PRIMARY KEY  (id)
);

-- Table: rooms
CREATE TABLE rooms (
    id int  NOT NULL,
    tag varchar(50)  NOT NULL,
    size int  NOT NULL,
    CONSTRAINT rooms_pk PRIMARY KEY  (id)
);

-- Table: job_title
CREATE TABLE job_title (
    id int  NOT NULL,
    title varchar(100)  NOT NULL,
    specialty varchar(100)  NULL,
    CONSTRAINT job_title_pk PRIMARY KEY  (id)
);


-- Table: staff
CREATE TABLE staff (
    id int  NOT NULL,
    name varchar(150)  NOT NULL,
    cpf char(11)  NOT NULL,
    job_title_id int  NOT NULL,
    email varchar(200)  NOT NULL,
    phone char(11)  NOT NULL,
    birth_date date  NOT NULL,
    adress_id int  NOT NULL,
    CONSTRAINT staff_pk PRIMARY KEY  (id),
    FOREIGN KEY (adress_id) REFERENCES adress (id),
    FOREIGN KEY (job_title_id) REFERENCES job_title (id)
);

-- Table: package
CREATE TABLE package (
    id int  NOT NULL,
    title varchar(100)  NOT NULL,
    description varchar(300)  NOT NULL,
    cost decimal(9,2)  NOT NULL,
    start_date date  NOT NULL,
    total_classes int  NOT NULL,
    CONSTRAINT package_pk PRIMARY KEY  (id)
);

-- Table: class_type
CREATE TABLE class_type (
    id int  NOT NULL,
    title varchar(150)  NOT NULL,
    specialty varchar(100)  NULL,
    CONSTRAINT class_type_pk PRIMARY KEY  (id)
);

-- Table: class
CREATE TABLE class (
    id int  NOT NULL,
    title varchar(100)  NOT NULL,
    staff_id int  NOT NULL,
    package_id int  NOT NULL,
    date date  NOT NULL,
    time time  NOT NULL,
    class_type_id int  NOT NULL,
    duration time  NOT NULL,
    CONSTRAINT class_pk PRIMARY KEY  (id),
    FOREIGN KEY (class_type_id) REFERENCES class_type (id),
    FOREIGN KEY (package_id) REFERENCES package (id),
    FOREIGN KEY (staff_id) REFERENCES staff (id)
);


-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL,
    name varchar(150)  NOT NULL,
    cpf char(11)  NOT NULL,
    birth_date date  NOT NULL,
    phone char(11)  NOT NULL,
    email varchar(200)  NOT NULL,
    adress_id int  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY  (id),
    FOREIGN KEY (adress_id) REFERENCES adress (id)
);


-- Table: purchase
CREATE TABLE purchase (
    id int  NOT NULL,
    customer_id int  NOT NULL,
    package_id int  NOT NULL,
    date date  NOT NULL,
    time time  NOT NULL,
    CONSTRAINT purchase_pk PRIMARY KEY  (id),
    FOREIGN KEY (customer_id) REFERENCES customer (id),
    FOREIGN KEY (package_id) REFERENCES package (id)
);



-- Table: registration
CREATE TABLE registration (
    id int  NOT NULL,
    date date  NOT NULL,
    time time  NOT NULL,
    customer_id int  NOT NULL,
    class_id int  NOT NULL,
    CONSTRAINT registration_pk PRIMARY KEY  (id),
    FOREIGN KEY (class_id) REFERENCES class (id),
    FOREIGN KEY (customer_id) REFERENCES customer (id)
);

-- Table: reservation
CREATE TABLE reservation (
    id int  NOT NULL,
    staff_id int  NOT NULL,
    vehicles_id int  NULL,
    rooms_id int  NULL,
    date date  NOT NULL,
    start_time time  NOT NULL,
    devolution datetime  NULL,
    class_id int  NOT NULL,
    CONSTRAINT reservation_pk PRIMARY KEY  (id),
    FOREIGN KEY (class_id) REFERENCES class (id),
    FOREIGN KEY (rooms_id) REFERENCES rooms (id),
    FOREIGN KEY (staff_id) REFERENCES staff (id),
    FOREIGN KEY (vehicles_id) REFERENCES vehicles (id)
);
