CREATE DATABASE Sakila_Staging
GO
USE Sakila_Staging

CREATE TABLE address_dm(
address_id SMALLINT IDENTITY(1,1),
bussiness_address_id SMALLINT NULL,
[address] VARCHAR(50) NULL,
district  VARCHAR(20) NULL,
city VARCHAR(50) NULL,
country VARCHAR(50) NULL,
postal_code VARCHAR(10) NULL,
)
GO

CREATE TABLE film_actor_dm(
actor_id SMALLINT IDENTITY(1,1),
bussiness_actor_id SMALLINT NULL,
film_id SMALLINT NULL,
first_name_actors VARCHAR(50) NULL,
last_name_actors VARCHAR(50) NULL
)   

CREATE TABLE film_dm(
film_id SMALLINT IDENTITY(1,1),
bussiness_film_id SMALLINT NULL,
title VARCHAR(255) NULL,
[description] VARCHAR(MAX) NULL,
release_year INT NULL,
language_name CHAR(20) NULL,
rental_duration TINYINT NULL,
rental_rate DECIMAL NULL,
[length] SMALLINT NULL,
rating VARCHAR(50) NULL,
category VARCHAR(30) NULL,
)
GO

CREATE TABLE store_dm(
store_id TINYINT IDENTITY(1,1),
bussiness_store_id TINYINT NULL,
staff_id TINYINT NULL,
address_id SMALLINT NULL
)
GO

CREATE TABLE rental_facts(
rental_id INT NULL,
film_id SMALLINT NULL,
customer_id SMALLINT NULL,
staff_id TINYINT NULL,
store_id TINYINT NULL,
rental_date_id INT NULL,
return_date_id INT NULL
)
GO


CREATE TABLE payment_dm(
payment_id SMALLINT IDENTITY(1,1),
bussiness_payment_id SMALLINT NULL,
customer_id SMALLINT NULL,
staff_id TINYINT NULL,
rental_id INT NULL,
amount DECIMAL NULL,
payment_date DATETIME NULL
)
GO

CREATE TABLE customer_dm(
customer_id SMALLINT IDENTITY(1,1),
bussiness_customer_id SMALLINT NULL,
store_id TINYINT NULL,
first_name VARCHAR(50) NULL,
last_name VARCHAR(50) NULL,
address_id SMALLINT NULL,
create_date DATETIME NULL
)
GO

CREATE TABLE staff_dm(
staff_id TINYINT IDENTITY(1,1),
bussiness_staff_id TINYINT NULL,
first_name VARCHAR(50) NULL,
last_name VARCHAR(50) NULL,
address_id SMALLINT NULL,
store_id TINYINT NULL
)
GO

DECLARE @DateDim TABLE (
    [FullDate] [datetime] NOT NULL,
    [Year] [smallint] NOT NULL,
    [HalfYear] [tinyint] NOT NULL,
    [Quarter] [tinyint] NOT NULL,
    [MonthNumOfYear] [tinyint] NOT NULL,
    [DayNumOfMonth] [tinyint] NOT NULL,
    [WeekNumOfMonth] [tinyint] NOT NULL
)

DECLARE 
    @Start_Date datetime,
    @End_Date datetime

SET @Start_Date = '1900-12-31 00:00:00.000'
SET @End_Date = '2100-12-31 00:00:00.000'

WHILE (@Start_Date < @End_Date)
BEGIN
    SET @Start_Date = DATEADD(day, 1, @Start_Date)
    INSERT INTO @DateDim
    VALUES (
        @Start_Date,
        DATEPART(year, @Start_Date),
        CASE
            WHEN DATEPART(month, @Start_Date) BETWEEN 1 AND 6 THEN 1
            WHEN DATEPART(month, @Start_Date) BETWEEN 7 AND 12 THEN 2
        END,
        DATEPART(quarter , @Start_Date),
        DATEPART(month, @Start_Date),
        DATEPART(day , @Start_Date),
        CASE
            WHEN DATEPART(day , @Start_Date) BETWEEN 1 AND 7 THEN 1
            WHEN DATEPART(day , @Start_Date) BETWEEN 8 AND 14 THEN 2
            WHEN DATEPART(day , @Start_Date) BETWEEN 15 AND 21 THEN 3
            WHEN DATEPART(day , @Start_Date) BETWEEN 22 AND 28 THEN 4
            WHEN DATEPART(day , @Start_Date) BETWEEN 29 AND 31 THEN 5
        END
    )
END

SELECT * FROM @DateDim