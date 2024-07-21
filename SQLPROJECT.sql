SELECT * from sqlproject.sales_data_sample
/*1. Sales Metrics Total Sales, Profit, and Number of Transactions By Region:)*/

SELECT
    COUNTRY,
    SUM(SALES) AS total_sales,
    COUNT(ORDERNUMBER) AS number_of_transactions,
    SUM(SALES) - SUM(QUANTITYORDERED * PRICEEACH) AS total_profit
FROM sqlproject.sales_data_sample
GROUP BY COUNTRY
ORDER BY total_sales DESC;
/*by product line*/
SELECT
    PRODUCTLINE,
    SUM(SALES) AS total_sales,
    COUNT(ORDERNUMBER) AS number_of_transactions,
    SUM(SALES) - SUM(QUANTITYORDERED * PRICEEACH) AS total_profit
FROM sqlproject.sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY total_sales DESC;
/*By Time Period (e.g., by Year):*/
SELECT
    YEAR_ID,
    SUM(SALES) AS total_sales,
    COUNT(ORDERNUMBER) AS number_of_transactions,
    SUM(SALES) - SUM(QUANTITYORDERED * PRICEEACH) AS total_profit
FROM sqlproject.sales_data_sample
GROUP BY YEAR_ID
ORDER BY YEAR_ID;


/*  2. Sales Trends   */

/*monthly sales*/

SELECT
    YEAR_ID,
    MONTH_ID,
    SUM(SALES) AS total_sales
FROM sqlproject.sales_data_sample
GROUP BY YEAR_ID, MONTH_ID
ORDER BY YEAR_ID, MONTH_ID;

/*yearly sales*/

SELECT
    YEAR_ID,
    SUM(SALES) AS total_sales
FROM sqlproject.sales_data_sample
GROUP BY YEAR_ID
ORDER BY YEAR_ID;


/*To analyze seasonal sales patterns, to aggregate sales by quarters:*/

SELECT
    YEAR_ID,
    QTR_ID,
    SUM(SALES) AS total_sales
FROM sqlproject.sales_data_sample
GROUP BY YEAR_ID, QTR_ID
ORDER BY YEAR_ID, QTR_ID;


/*   3. Customer Analysis  */

/* Customer Segmentation Based on Sales Data */


SELECT
    CUSTOMERNAME,
    SUM(SALES) AS total_sales,
    CASE
        WHEN SUM(SALES) >= 10000 THEN 'High Value'
        WHEN SUM(SALES) BETWEEN 5000 AND 9999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM sqlproject.sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY total_sales DESC;


/*Customer Lifetime Value Calculation*/


SELECT
    CUSTOMERNAME,
    SUM(SALES) AS lifetime_value
FROM sqlproject.sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY lifetime_value DESC;




CREATE VIEW vw_sales_by_region AS
SELECT
    COUNTRY,
    SUM(SALES) AS total_sales,
    COUNT(ORDERNUMBER) AS number_of_transactions
FROM sqlproject.sales_data_sample
GROUP BY COUNTRY;


/* 4. Preparing Data for Dashboard To prepare data for visualization in a dashboard tool: 
Total Sales by Region:*/


DROP VIEW IF EXISTS sqlproject.vw_sales_by_region;


CREATE VIEW sqlproject.vw_sales_by_region AS
SELECT
    COUNTRY,
    SUM(SALES) AS total_sales,
    COUNT(ORDERNUMBER) AS number_of_transactions
FROM sqlproject.sales_data_sample
GROUP BY COUNTRY;


SHOW FULL TABLES IN sqlproject WHERE TABLE_TYPE = 'VIEW';


SELECT * FROM sqlproject.vw_sales_by_region;

/*Total Sales by Product Category:*/

CREATE VIEW vw_sales_by_category AS
SELECT
    PRODUCTLINE,
    SUM(SALES) AS total_sales,
    COUNT(ORDERNUMBER) AS number_of_transactions
FROM sqlproject.sales_data_sample
GROUP BY PRODUCTLINE;


/*sales trend view*/

CREATE VIEW vw_sales_trends AS
SELECT
    YEAR_ID,
    MONTH_ID,
    SUM(SALES) AS total_sales
FROM sqlproject.sales_data_sample
GROUP BY YEAR_ID, MONTH_ID
ORDER BY YEAR_ID, MONTH_ID;

/* Customer Segmentation View: */

CREATE VIEW vw_customer_segmentation AS
SELECT
    CUSTOMERNAME,
    SUM(SALES) AS total_sales,
    CASE
        WHEN SUM(SALES) >= 10000 THEN 'High Value'
        WHEN SUM(SALES) BETWEEN 5000 AND 9999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM sqlproject.sales_data_sample
GROUP BY CUSTOMERNAME;
