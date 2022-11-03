
USE DB211708033;

EXEC sys.sp_cdc_disable_table
@source_schema = N'dbo',
@source_name = N'includes',
@capture_instance = 'all'
go

EXEC sys.sp_cdc_disable_table
@source_schema = N'dbo',
@source_name = N'salestransaction',
@capture_instance = 'all'
go

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'includes',
@role_name = NULL,
@supports_net_changes = 1
go

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'salestransaction',
@role_name = NULL,
@supports_net_changes = 1
go

INSERT INTO salestransaction VALUES ('T536', '4-5-666','S4','03/Jan/2020');
INSERT INTO includes VALUES ('3X3','T536',8);

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_includes');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT productid, tid1, quantity
into DW211708033.dbo.staging_dbo_includes
FROM
[cdc].[fn_cdc_get_net_changes_dbo_includes](@S,@E,'all');

declare @A binary(10);
declare @B binary(10);
SET @A = sys.fn_cdc_get_min_lsn('dbo_salestransaction');
SET @B = sys.fn_cdc_get_max_lsn();
SELECT tid, customerid, storeid, tdate
into DW211708033.dbo.staging_dbo_salestransaction
FROM
[cdc].[fn_cdc_get_net_changes_dbo_salestransaction](@A,@B,'all')


INSERT INTO DW211708033.dbo.transactions( amount_prod, ID_transaction, ID_calendar, ID_customer, ID_product, ID_store)
SELECT 
quantity,
tid,
ID_calendar,
ID_customer,
ID_product,
ID_store
FROM 
DW211708033.dbo.staging_dbo_includes AS ic
INNER JOIN
DW211708033.dbo.staging_dbo_salestransaction AS sl
	ON sl.tid = ic.tid1
INNER JOIN
DW211708033.dbo.calendar AS cl 
	ON cl.complete_date = sl.tdate
INNER JOIN
DW211708033.dbo.product AS pr
	ON pr.ID_product = ic.productid
INNER JOIN
DW211708033.dbo.customer AS cn
	ON cn.ID_customer = sl.customerid
INNER JOIN
DW211708033.dbo.store AS lj
	ON lj.ID_store = sl.storeid;

