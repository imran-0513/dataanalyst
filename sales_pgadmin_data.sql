select * from sales_data.sales


select count(*) from sales_data.sales
DROP TABLE temp_sales;

CREATE TEMP TABLE temp_sales_fact (
    OrderNo INT,
    ItemID INT,
    SalesDate TEXT, -- Assuming the date column in CSV is text
    CustomerId INT,
    CityId INT,
    Qty INT,
    Price NUMERIC,
    COGS NUMERIC,
    DiscountPercent NUMERIC
);

COPY temp_sales_fact (OrderNo, ItemID, SalesDate, CustomerId, CityId, Qty, Price, COGS, DiscountPercent)
FROM 'D:\Training\PowerBI\powerbi-main\csv\sales.csv'
DELIMITER ',' CSV HEADER;

INSERT INTO sales_data.sales_fact (OrderNo, ItemID, SalesDate, CustomerId, CityId, Qty, Price, COGS, DiscountPercent)
SELECT 
    OrderNo,
    ItemID,
    TO_DATE(SalesDate, 'MM/DD/YYYY') AS SalesDate,
    CustomerId,
    CityId,
    Qty,
    Price,
    COGS,
    DiscountPercent
FROM temp_sales_fact;


-- Create the sales table within the sales_data schema
CREATE TABLE sales_data.sales_fact (
    OrderNo INT,
    ItemID INT,
    SalesDate DATE, -- Using DATE type for SalesDate
    CustomerId INT,
    CityId INT,
    Qty INT,
    Price NUMERIC,
    COGS NUMERIC,
    DiscountPercent NUMERIC
);