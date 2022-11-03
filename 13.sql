USE DW211708033;

CREATE TABLE store
(
  size INT ,
  zipcode INT ,
  checkout_system VARCHAR(16) ,
  layout VARCHAR(16) ,
  region VARCHAR(16) ,
  ID_store VARCHAR(3) ,
  PRIMARY KEY (ID_store)
);

CREATE TABLE customer
(
  name VARCHAR(32) ,
  zipcode INT ,
  gender VARCHAR(16) ,
  marital_status VARCHAR(16) ,
  educational_level VARCHAR(16) ,
  credit_score INT ,
  ID_customer CHAR(7) ,
  PRIMARY KEY (ID_customer)
);

CREATE TABLE product
(
  name VARCHAR(32) ,
  price NUMERIC(7, 2) ,
  category VARCHAR(16) ,
  vendor VARCHAR(16) ,
  ID_product VARCHAR(4) ,
  PRIMARY KEY (ID_product)
);

CREATE TABLE calendar
(
  complete_date VARCHAR(16) ,
  week_day VARCHAR(16) ,
  month_day VARCHAR(16),
  trimester VARCHAR(16) ,
  year_date VARCHAR(16) ,
  ID_calendar INT IDENTITY (1,1),
  PRIMARY KEY (ID_calendar)
);
																																													
CREATE TABLE transactions
(
  ID_transaction VARCHAR(8) ,
  hour_time TIME  ,
  amount_prod INT ,
  ID_customer CHAR(7) ,
  ID_calendar INT ,
  ID_store VARCHAR(3) ,
  ID_product VARCHAR(4) ,
  PRIMARY KEY (ID_transaction, ID_customer, ID_calendar, ID_store, ID_product),
  FOREIGN KEY (ID_customer) REFERENCES customer(ID_customer),
  FOREIGN KEY (ID_calendar) REFERENCES calendar(ID_calendar),
  FOREIGN KEY (ID_store) REFERENCES store(ID_store),
  FOREIGN KEY (ID_product) REFERENCES product(ID_product)
);


INSERT INTO DW211708033.dbo.product (ID_product, name, price, category, vendor)
SELECT 
productid,
productname,
productprice,
categoryname,
vendorname
FROM
DB211708033.dbo.product,
DB211708033.dbo.category,
DB211708033.dbo.vendor

WHERE
DB211708033.dbo.product.categoryid = DB211708033.dbo.category.categoryid AND
DB211708033.dbo.product.vendorid = DB211708033.dbo.vendor.vendorid


INSERT INTO DW211708033.dbo.customer( ID_customer, name, zipcode, gender, marital_status, educational_level, credit_score)
SELECT 
customer_id,
customer_name,
customerzip,
Gender,
MaritalStatus,
EducationLevel,
CreditScore
FROM 
DB211708033.dbo.customer
LEFT JOIN
DB211708033.dbo.EXTERNAL_CUSTOMER
	ON DB211708033.dbo.customer.customer_id = DB211708033.dbo.EXTERNAL_CUSTOMER.CustomerID;


INSERT INTO DW211708033.dbo.store( ID_store, size, zipcode, checkout_system, layout, region)
SELECT 
storeid,
StoreSize,
storezip,
CSystem,
LayoutDesc,
regionname
FROM 
DB211708033.dbo.store AS s
LEFT JOIN
DB211708033.dbo.STORE_ZAGI AS sc
	ON s.storeid = sc.storecid
LEFT JOIN
DB211708033.dbo.region 
	ON s.regionid = DB211708033.dbo.region.regionid
LEFT JOIN
DB211708033.dbo.LAYOUT
	ON sc.LayoutID = DB211708033.dbo.LAYOUT.LayoutID
LEFT JOIN
DB211708033.dbo.CHECKOUTSYSTEM
	ON sc.CSID = DB211708033.dbo.CHECKOUTSYSTEM.CSID;


INSERT INTO DW211708033.dbo.calendar(complete_date, week_day, month_day, trimester, year_date)
SELECT 
tdate,
DATEPART(WEEKDAY, tdate),
DATEPART(DAY, tdate),
DATEPART(QUARTER, tdate),
DATEPART(YEAR, tdate)
FROM 
DB211708033.dbo.salestransaction;


INSERT INTO DW211708033.dbo.transactions( amount_prod, ID_transaction, ID_calendar, ID_customer, ID_product, ID_store)
SELECT 
quantity,
tid,
ID_calendar,
ID_customer,
ID_product,
ID_store
FROM 
DB211708033.dbo.includes AS ic
INNER JOIN
DB211708033.dbo.salestransaction AS sl
	ON sl.tid = ic.tid1
LEFT JOIN
DW211708033.dbo.calendar AS cl 
	ON cl.complete_date = sl.tdate
LEFT JOIN
DW211708033.dbo.product AS pr
	ON pr.ID_product = ic.productid
LEFT JOIN
DW211708033.dbo.customer AS cn
	ON cn.ID_customer = sl.customerid
LEFT JOIN
DW211708033.dbo.store AS lj
	ON lj.ID_store = sl.storeid;
