SELECT *
FROM Supermarket

SELECT DISTINCT (Customer_type)
FROM supermarket

SELECT DISTINCT (Branch)
FROM supermarket

SELECT COUNT(*) AS ROW_COUNT
FROM Supermarket

SELECT MAX(Unit_price) AS Max_price, MIN(Unit_price) AS MIN_price
FROM Supermarket

SELECT TOTAL
CASE WHEN TOTAL > 500 THEN 'High' ELSE 'LOW' END AS Total_status
FROM supermarket

SELECT *
FROM Supermarket
WHERE City is NULL OR Branch is NULL


SELECT DISTINCT (Payment)
FROM Supermarket


-----------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM SUPERSTORE

SELECT COUNT(*) AS No_ROW
FROM SUPERSTORE 

SELECT COUNT (*)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SUPERSTORE'


SELECT *
FROM SUPERSTORE
WHERE ROW_ID IS NULL OR Order_ID IS NULL OR Order_Date IS NULL OR Ship_Date IS NULL OR Ship_Mode is NULL OR Customer_ID IS NULL OR Customer_Name IS NULL OR Segment IS NULL 
OR Country_Region IS NULL OR City IS NULL OR state IS NULL OR Postal_Code IS NULL OR Region IS NULL OR Product_ID IS NULL OR Category IS NULL OR Sub_Category IS NULL OR Product_Name 
IS NULL OR Sales IS NULL OR Quantity IS NULL OR Discount IS NULL OR Profit IS NULL;


SELECT *
FROM SUPERSTORE
WHERE State = 'Vermont'


UPDATE SUPERSTORE
SET Postal_Code = '05401'
WHERE State = 'Vermont' AND City = 'Burlington' AND Postal_Code IS NULL;


ALTER TABLE SUPERSTORE
ALTER COLUMN Postal_code VARCHAR (10);

UPDATE SUPERSTORE
SET Postal_Code = RIGHT('00000' + postal_code, 5)
WHERE State = 'Vermont' AND City = 'Burlington' AND Postal_Code IS NOT NULL;


UPDATE SUPERSTORE
SET PROFIT = 0
WHERE Row_ID = 7345 AND Profit IS NULL
ge  

SELECT CONVERT (Date,Order_Date) AS Other_Date_Only
FROM SUPERSTORE

UPDATE SUPERSTORE
SET Order_Date = CONVERT (Date,Order_Date);


SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SUPERSTORE' AND COLUMN_NAME = 'Order_date';

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SUPERSTORE';

ALTER TABLE SUPERSTORE
ALTER COLUMN Order_Date DATE;

UPDATE SUPERSTORE
SET Ship_Date = DATEADD(Year, 2, Ship_Date);


SELECT 
   DATEPART(day, order_date) AS Order_Day,
   DATENAME(month, order_date) AS Order_Month,
   DATEPART(year, order_date) AS Order_Year,
   DATENAME(Weekday, Order_date) AS Order_Day_Of_Week
   FROM SUPERSTORE



------------------------------------------------

SELECT *
FROM SUPERSTORE

ALTER TABLE SUPERSTORE
ADD Order_day INT,
    Order_month varchar (10),
	Order_year INT,
	Order_day_of_week varchar (10),
	Order_month_No INT;

UPDATE SUPERSTORE
SET Order_day = DATEPART(day, order_date),
    Order_month = DATENAME(month, order_date),
    Order_year = DATEPART(year, order_date),
    Order_day_of_week = DATENAME(Weekday, Order_date),
	Order_month_No = DATEPART (month, Order_date);

ALTER TABLE SUPERSTORE
ADD Ship_day_of_week varchar (10),
    Ship_month varchar (10),
	Ship_month_No INT,
	Ship_year INT;
	
UPDATE SUPERSTORE
SET Ship_day_of_week = DATENAME(Weekday, Ship_Date),
    Ship_month = DATENAME(month, Ship_date),
    Ship_month_No = DATEPART (month,Ship_date),
	Ship_year = DATEPART(year,Ship_date);


ALTER TABLE SUPERSTORE
DROP COLUMN Row_ID 

SELECT Order_year,
       SUM(Sales) AS Total_Sales,
	   SUM(Profit) AS Total_Profit
FROM SUPERSTORE 
GROUP BY Order_year
ORDER BY Total_Profit

SELECT Order_year,
       SUM(Sales) AS TotaL_Sales,
	   Total_Sales * 100 / SUM( Total_sales) OVER () AS Percentage_Sales
From SUPERSTORE
GROUP BY Order_year


WITH YearlySales AS (
SELECT Order_year,
       SUM(Sales) AS TotaL_Sales
From SUPERSTORE
GROUP BY Order_year
)
 
SELECT Order_year, 
       Total_Sales,
	   Total_Sales / SUM (Total_Sales) OVER () * 100 AS Percentage_Sales
FROM YearlySales
GROUP BY Order_year, Total_Sales;


SELECT Order_month,
	   Order_month_No,
       Order_year,
       SUM(Sales) AS TotaL_Sales
From SUPERSTORE
GROUP BY Order_month, Order_month_No, Order_year



WITH YEARLYPROFIT AS (
SELECT Order_year,
       SUM (Profit) AS Total_Profit
FROM SUPERSTORE
GROUP BY Order_year
)
SELECT Order_year,
       Total_Profit,
	   Total_Profit / SUM (Total_Profit) OVER ()* 100 AS Percentage_Profit
FROM YEARLYPROFIT
GROUP BY Order_year, Total_Profit;




WITH Processingdaily AS (
SELECT Order_Date,
       Ship_Date,
DATEDIFF (Day, Order_Date, Ship_Date) AS Day_Processing
FROM SUPERSTORE
GROUP BY Order_Date, Ship_Date
)
SELECT Order_Date,
       Ship_Date,
MAX (Day_Processing) AS MAX_Day_Processing, MIN (Day_Processing) AS MIN_Day_Processin, AVG (Day_processing) AS AVG_Day_Processing
FROM Processingdaily
GROUP BY Order_Date, Ship_Date;














