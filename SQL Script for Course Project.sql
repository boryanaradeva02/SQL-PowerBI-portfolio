
--Част 1 : Database Preparation
--създай view v_Product_Enriched

	create or replace view v_Product_Enriched as
	select 
	p.product_id as "Product ID",
	p.product_name as "Product Name",
	c.category_name as "Category Name",
	s.company_name as "Supplier",
	p.unit_price as "Unit Price"
	from products as p
	left join categories as c on p.category_id = c.category_id 
	left join suppliers as s on p.supplier_id = s.supplier_id;
	
-- създай view v_Order_Sales
	
	create or replace view v_Order_Sales as
	select
	o.order_id,
	o.customer_id,
	o.employee_id,
	o.order_date,
	o.required_date,
	o.shipped_date,
	o.ship_via,
	o.freight,
	o.ship_name,
	o.ship_address,
	o.ship_city,
	o.ship_region,
	o.ship_postal_code,
	o.ship_country,
	od.product_id,
	od.unit_price,
	od.quantity,
	od.discount,
	(od.unit_price * od.quantity * (1-od.discount)) as "TotalLineAmount"
	from orders as o
	join order_details as od on o.order_id = od.order_id;
	
	--създаваме view v_Customer_Geo
	create or replace view v_Customer_Geo as
	select
	customer_id as "Customer ID",
	company_name as "Company Name",
	city as "City",
	country as "Country"
	from customers 
	where customer_id in (select customer_id from orders where customer_id is not null);