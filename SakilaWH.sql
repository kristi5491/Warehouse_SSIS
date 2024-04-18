CREATE DATABASE Sakila_WH
GO
USE Sakila_WH

CREATE TABLE address_dm(
address_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
bussiness_address_id SMALLINT NOT NULL,
[address] VARCHAR(50) NOT NULL,
district  VARCHAR(20) NOT NULL,
city VARCHAR(50) NOT NULL,
country VARCHAR(50) NOT NULL,
postal_code VARCHAR(10) NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)
GO

CREATE TABLE film_actor_dm(
actor_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
bussiness_actor_id SMALLINT NOT NULL,
film_id SMALLINT NOT NULL,
full_name_actor NVARCHAR(101) NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)

CREATE TABLE film_dm(
film_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
bussiness_film_id SMALLINT NOT NULL,
title VARCHAR(255) NOT NULL,
[description] VARCHAR(MAX) NULL,
release_year INT NULL,
language_name CHAR(20) NOT NULL,
rental_duration TINYINT NOT NULL,
rental_rate DECIMAL NOT NULL,
[length] SMALLINT NULL,
rating VARCHAR(50) NULL,
category VARCHAR(30) NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)
GO

CREATE TABLE store_dm(
store_id TINYINT IDENTITY(1,1) PRIMARY KEY,
bussiness_store_id TINYINT NOT NULL,
staff_id TINYINT NOT NULL,
address_id SMALLINT NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)
GO

CREATE TABLE rental_facts(
rental_id INT NOT NULL,
film_id SMALLINT NOT NULL,
customer_id SMALLINT NOT NULL,
staff_id TINYINT NOT NULL,
store_id TINYINT NOT NULL,
rental_date_id INT NOT NULL,
return_date_id INT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL,
PRIMARY KEY CLUSTERED (
    rental_id ASC,
    film_id ASC,
    customer_id ASC,
    staff_id ASC,
    store_id ASC
))
GO


CREATE TABLE payment_dm(
payment_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
bussiness_payment_id SMALLINT NOT NULL,
customer_id SMALLINT NOT NULL,
staff_id TINYINT NOT NULL,
rental_id INT NOT NULL,
amount DECIMAL NOT NULL,
payment_date DATETIME NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)
GO

CREATE TABLE customer_dm(
customer_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
bussiness_customer_id SMALLINT NOT NULL,
store_id TINYINT NOT NULL,
full_name NVARCHAR(101) NOT NULL,
address_id SMALLINT NOT NULL,
create_date DATETIME NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)
GO

CREATE TABLE staff_dm(
staff_id TINYINT IDENTITY(1,1) PRIMARY KEY,
bussiness_staff_id TINYINT NOT NULL,
full_name NVARCHAR(101) NOT NULL,
address_id SMALLINT NOT NULL,
store_id TINYINT NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL
)
GO

CREATE TABLE DateDimension (
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    [FullDate] [datetime] NOT NULL,
    [Year] [smallint] NOT NULL,
    [HalfYear] [tinyint] NOT NULL,
    [Quarter] [tinyint] NOT NULL,
    [MonthNumOfYear] [tinyint] NOT NULL,
    [DayNumOfMonth] [tinyint] NOT NULL,
    [WeekNumOfMonth] [tinyint] NOT NULL
)
GO

ALTER TABLE film_actor_dm WITH CHECK ADD CONSTRAINT FK_Actor_film FOREIGN KEY (film_id)
REFERENCES film_dm (film_id)

ALTER TABLE customer_dm WITH CHECK ADD CONSTRAINT FK_Customer_Address FOREIGN KEY (address_id)
REFERENCES address_dm (address_id)

ALTER TABLE store_dm WITH CHECK ADD CONSTRAINT FK_Store_Address FOREIGN KEY (address_id)
REFERENCES address_dm (address_id)

ALTER TABLE staff_dm WITH CHECK ADD CONSTRAINT FK_Staff_Adress FOREIGN KEY (address_id)
REFERENCES address_dm (address_id)

ALTER TABLE staff_dm WITH CHECK ADD CONSTRAINT FK_Staff_Store FOREIGN KEY (store_id)
REFERENCES store_dm (store_id)

ALTER TABLE payment_dm WITH CHECK ADD CONSTRAINT FK_Payment_Staff FOREIGN KEY (staff_id)
REFERENCES staff_dm (staff_id)

ALTER TABLE payment_dm WITH CHECK ADD CONSTRAINT FK_Payment_Customer FOREIGN KEY (customer_id)
REFERENCES customer_dm (customer_id)

ALTER TABLE rental_facts WITH CHECK ADD CONSTRAINT FK_Rental_Staff FOREIGN KEY (staff_id)
REFERENCES staff_dm (staff_id)

ALTER TABLE rental_facts WITH CHECK ADD CONSTRAINT FK_Rental_Customer FOREIGN KEY (customer_id)
REFERENCES customer_dm (customer_id)

ALTER TABLE rental_facts WITH CHECK ADD CONSTRAINT FK_Rental_Store FOREIGN KEY (store_id)
REFERENCES store_dm (store_id)

ALTER TABLE rental_facts WITH CHECK ADD CONSTRAINT FK_Rental_Film FOREIGN KEY (film_id)
REFERENCES film_dm (film_id)

ALTER TABLE rental_facts WITH CHECK ADD CONSTRAINT FK_Rental_Date FOREIGN KEY (return_date_id)
REFERENCES DateDimension (DateID)

ALTER TABLE rental_facts WITH CHECK ADD CONSTRAINT FK_Rental_Date_2 FOREIGN KEY (rental_date_id)
REFERENCES DateDimension (DateID)

ALTER TABLE customer_dm WITH CHECK ADD CONSTRAINT FK_Customer_Store FOREIGN KEY (store_id)
REFERENCES store_dm (store_id)
