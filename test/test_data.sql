IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'w3')
BEGIN
  CREATE DATABASE w3
END

USE w3

GO;
IF NOT EXISTS (
    SELECT  schema_name
    FROM    information_schema.schemata
    WHERE   schema_name = 'fact' )
BEGIN
  EXEC sp_executesql N'CREATE SCHEMA fact'
END
GO;


IF OBJECT_ID('w3.fact.Orders', 'U') IS NOT NULL
  DROP TABLE w3.fact.Orders;
IF OBJECT_ID('w3.dbo.Customers', 'U') IS NOT NULL
  DROP TABLE w3.dbo.Customers;
IF OBJECT_ID('w3.dbo.Agents', 'U') IS NOT NULL
  DROP TABLE w3.dbo.Agents;
IF OBJECT_ID('w3.dbo.Types', 'U') IS NOT NULL
  DROP TABLE w3.dbo.Types;

IF OBJECT_ID('w3.dbo.PrePost', 'U') IS NOT NULL
  DROP TABLE w3.dbo.PrePost;

GO;

CREATE TABLE  w3.dbo.Types
(
  "int" int NOT NULL PRIMARY KEY,
  "bigint" bigint,
  "numeric" numeric(18,5),
  "bit" bit,
  "smallint" smallint,
  "decimal" decimal(18,4),
  "smallmoney" smallmoney,
  "tinyint" tinyint,
  "money" money,
  "float" float,
  "real" real,
  "date" date,
  "datetimeoffset" datetimeoffset,
  "datetime2" datetime2,
  "smalldatetime" smalldatetime,
  "datetime" datetime,
  "time" time,
  "char" char(6),
  "varchar" varchar(10),
  "text" text,
  "nchar" nchar(6),
  "nvarchar" nvarchar(10),
  "ntext" ntext,
  "binary" binary(3),
  "varbinary" varbinary(100),
)

GO;

INSERT INTO w3.dbo.Types
    VALUES(
      42,
      9223372036854775807, -- bigint
      1234.5678,-- numeric
      1,-- bit
      123,-- smallint
      1234.5678,-- decimal
      12.56,-- smallmoney
      12,-- tinyint
      1234.56,-- money
      123456.789,-- float
      123456.789,-- real
      '1970-1-1',-- date
      '2007-05-08 12:35:29.1234567 +12:15', -- datetimeoffset
      '2007-05-08 12:35:29.1234567+12:15', -- datetime2
      '2007-05-08 12:35:29.123',-- smalldatetime
      '2007-05-08 12:35:29.123',-- datetime
      '12:35:29.123',-- time
      'char',-- char
      'abc',-- varchar
      'abc',-- text
      'nchar',-- nchar
      'nvarchar',-- nvarchar
      'ntext',-- ntext
      CAST('abc' as BINARY(3)),-- binary
      CAST('cde' as VARBINARY(6))-- varbinary
    )

GO;

CREATE TABLE  w3.dbo.Agents
(
  "AGENT_CODE" CHAR(4) NOT NULL PRIMARY KEY,
  "AGENT_NAME" VARCHAR(40),
  "WORKING_AREA" VARCHAR(35),
  "COMMISSION" float,
  "PHONE_NO" CHAR(12),
  "UPDATED_AT" DATETIMEOFFSET,
  "BIOGRAPHY" VARCHAR(MAX)
)

GO;

INSERT INTO w3.dbo.Agents VALUES ('A007', 'Ramasundar', 'Bangalore', null, '077-25814763', '1969-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A003', 'Alex', 'London', '0.13', '075-12458969', '1970-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '1970-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '1970-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '1970-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '1971-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '1971-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '1971-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '1971-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '1971-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '1971-01-02T00:00:00Z', '');
INSERT INTO w3.dbo.Agents VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '1971-01-02T00:00:00Z', '');

GO;

CREATE TABLE  w3.dbo.Customers
(	"CUST_CODE" VARCHAR(6) NOT NULL PRIMARY KEY,
   "CUST_NAME" VARCHAR(40) NOT NULL,
   "CUST_CITY" VARCHAR(MAX),
   "WORKING_AREA" VARCHAR(35) NOT NULL,
   "CUST_COUNTRY" VARCHAR(20) NOT NULL,
   "GRADE" NUMERIC,
   "OPENING_AMT" NUMERIC(12,2) NOT NULL,
   "RECEIVE_AMT" NUMERIC(12,2) NOT NULL,
   "PAYMENT_AMT" NUMERIC(12,2) NOT NULL,
   "OUTSTANDING_AMT" NUMERIC(12,2) NOT NULL,
   "PHONE_NO" VARCHAR(17) NOT NULL,
   "AGENT_CODE" CHAR(4) NOT NULL REFERENCES w3.dbo.Agents
);

GO;

INSERT INTO w3.dbo.Customers VALUES ('C00013', 'Holmes', 'London', 'London', 'UK', '2', '6000.00', '5000.00', '7000.00', '4000.00', 'BBBBBBB', 'A003');
INSERT INTO w3.dbo.Customers VALUES ('C00001', 'Micheal', 'New York', 'New York', 'USA', '2', '3000.00', '5000.00', '2000.00', '6000.00', 'CCCCCCC', 'A008');
INSERT INTO w3.dbo.Customers VALUES ('C00020', 'Albert', 'New York', 'New York', 'USA', '3', '5000.00', '7000.00', '6000.00', '6000.00', 'BBBBSBB', 'A008');
INSERT INTO w3.dbo.Customers VALUES ('C00025', 'Ravindran', 'Bangalore', 'Bangalore', 'India', '2', '5000.00', '7000.00', '4000.00', '8000.00', 'AVAVAVA', 'A011');
INSERT INTO w3.dbo.Customers VALUES ('C00024', 'Cook', 'London', 'London', 'UK', '2', '4000.00', '9000.00', '7000.00', '6000.00', 'FSDDSDF', 'A006');
INSERT INTO w3.dbo.Customers VALUES ('C00015', 'Stuart', 'London', 'London', 'UK', '1', '6000.00', '8000.00', '3000.00', '11000.00', 'GFSGERS', 'A003');
INSERT INTO w3.dbo.Customers VALUES ('C00002', 'Bolt', 'New York', 'New York', 'USA', '3', '5000.00', '7000.00', '9000.00', '3000.00', 'DDNRDRH', 'A008');
INSERT INTO w3.dbo.Customers VALUES ('C00018', 'Fleming', 'Brisban', 'Brisban', 'Australia', '2', '7000.00', '7000.00', '9000.00', '5000.00', 'NHBGVFC', 'A005');
INSERT INTO w3.dbo.Customers VALUES ('C00021', 'Jacks', 'Brisban', 'Brisban', 'Australia', '1', '7000.00', '7000.00', '7000.00', '7000.00', 'WERTGDF', 'A005');
INSERT INTO w3.dbo.Customers VALUES ('C00019', 'Yearannaidu', 'Chennai', 'Chennai', 'India', '1', '8000.00', '7000.00', '7000.00', '8000.00', 'ZZZZBFV', 'A010');
INSERT INTO w3.dbo.Customers VALUES ('C00005', 'Sasikant', 'Mumbai', 'Mumbai', 'India', '1', '7000.00', '11000.00', '7000.00', '11000.00', '147-25896312', 'A002');
INSERT INTO w3.dbo.Customers VALUES ('C00007', 'Ramanathan', 'Chennai', 'Chennai', 'India', '1', '7000.00', '11000.00', '9000.00', '9000.00', 'GHRDWSD', 'A010');
INSERT INTO w3.dbo.Customers VALUES ('C00022', 'Avinash', 'Mumbai', 'Mumbai', 'India', '2', '7000.00', '11000.00', '9000.00', '9000.00', '113-12345678','A002');
INSERT INTO w3.dbo.Customers VALUES ('C00004', 'Winston', 'Brisban', 'Brisban', 'Australia', '1', '5000.00', '8000.00', '7000.00', '6000.00', 'AAAAAAA', 'A005');
INSERT INTO w3.dbo.Customers VALUES ('C00023', 'Karl', 'London', 'London', 'UK', '0', '4000.00', '6000.00', '7000.00', '3000.00', 'AAAABAA', 'A006');
INSERT INTO w3.dbo.Customers VALUES ('C00006', 'Shilton', 'Torento', 'Torento', 'Canada', '1', '10000.00', '7000.00', '6000.00', '11000.00', 'DDDDDDD', 'A004');
INSERT INTO w3.dbo.Customers VALUES ('C00010', 'Charles', 'Hampshair', 'Hampshair', 'UK', '3', '6000.00', '4000.00', '5000.00', '5000.00', 'MMMMMMM', 'A009');
INSERT INTO w3.dbo.Customers VALUES ('C00017', 'Srinivas', 'Bangalore', 'Bangalore', 'India', '2', '8000.00', '4000.00', '3000.00', '9000.00', 'AAAAAAB', 'A007');
INSERT INTO w3.dbo.Customers VALUES ('C00012', 'Steven', 'San Jose', 'San Jose', 'USA', '1', '5000.00', '7000.00', '9000.00', '3000.00', 'KRFYGJK', 'A012');
INSERT INTO w3.dbo.Customers VALUES ('C00008', 'Karolina', 'Torento', 'Torento', 'Canada', '1', '7000.00', '7000.00', '9000.00', '5000.00', 'HJKORED', 'A004');
INSERT INTO w3.dbo.Customers VALUES ('C00003', 'Martin', 'Torento', 'Torento', 'Canada', '2', '8000.00', '7000.00', '7000.00', '8000.00', 'MJYURFD', 'A004');
INSERT INTO w3.dbo.Customers VALUES ('C00009', 'Ramesh', 'Mumbai', 'Mumbai', 'India', '3', '8000.00', '7000.00', '3000.00', '12000.00', 'Phone No', 'A002');
INSERT INTO w3.dbo.Customers VALUES ('C00014', 'Rangarappa', 'Bangalore', 'Bangalore', 'India', '2', '8000.00', '11000.00', '7000.00', '12000.00', 'AAAATGF', 'A001');
INSERT INTO w3.dbo.Customers VALUES ('C00016', 'Venkatpati', 'Bangalore', 'Bangalore', 'India', '2', '8000.00', '11000.00', '7000.00', '12000.00', 'JRTVFDD', 'A007');
INSERT INTO w3.dbo.Customers VALUES ('C00011', 'Sundariya', 'Chennai', 'Chennai', 'India', '3', '7000.00', '11000.00', '7000.00', '11000.00', 'PPHGRTS', 'A010');

GO;


CREATE TABLE w3.fact.Orders
(
  "ORD_NUM" NUMERIC(6,0) NOT NULL PRIMARY KEY,
  "ORD_AMOUNT" NUMERIC(12,2) NOT NULL,
  "ADVANCE_AMOUNT" NUMERIC(12,2) NULL,
  "ORD_DATE" DATE NOT NULL,
  "CUST_CODE" VARCHAR(6) NOT NULL REFERENCES w3.dbo.Customers,
  "AGENT_CODE" CHAR(4) NOT NULL REFERENCES w3.dbo.Agents,
  "ORD_DESCRIPTION" VARCHAR(60) NOT NULL
);

GO;

INSERT INTO w3.fact.Orders VALUES('200100', '1000.00', NULL, '08/01/2008', 'C00013', 'A003', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200110', '3000.00', '500.00', '04/15/2008', 'C00019', 'A010', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200107', '4500.00', '900.00', '08/30/2008', 'C00007', 'A010', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200112', '2000.00', '400.00', '05/30/2008', 'C00016', 'A007', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200113', '4000.00', '600.00', '06/10/2008', 'C00022', 'A002', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200102', '2000.00', '300.00', '05/25/2008', 'C00012', 'A012', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200114', '3500.00', '2000.00', '08/15/2008', 'C00002', 'A008', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200122', '2500.00', '400.00', '09/16/2008', 'C00003', 'A004', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200118', '500.00', '100.00', '07/20/2008', 'C00023', 'A006', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200119', '4000.00', '700.00', '09/16/2008', 'C00007', 'A010', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200121', '1500.00', '600.00', '09/23/2008', 'C00008', 'A004', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200130', '2500.00', '400.00', '07/30/2008', 'C00025', 'A011', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200134', '4200.00', '1800.00', '09/25/2008', 'C00004', 'A005', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200108', '4000.00', '600.00', '02/15/2008', 'C00008', 'A004', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200103', '1500.00', '700.00', '05/15/2008', 'C00021', 'A005', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200105', '2500.00', '500.00', '07/18/2008', 'C00025', 'A011', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200109', '3500.00', '800.00', '07/30/2008', 'C00011', 'A010', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200101', '3000.00', '1000.00', '07/15/2008', 'C00001', 'A008', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200111', '1000.00', '300.00', '07/10/2008', 'C00020', 'A008', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200104', '1500.00', '500.00', '03/13/2008', 'C00006', 'A004', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200106', '2500.00', '700.00', '04/20/2008', 'C00005', 'A002', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200125', '2000.00', '600.00', '10/10/2008', 'C00018', 'A005', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200117', '800.00', '200.00', '10/20/2008', 'C00014', 'A001', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200123', '500.00', '100.00', '09/16/2008', 'C00022', 'A002', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200120', '500.00', '100.00', '07/20/2008', 'C00009', 'A002', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200116', '500.00', '100.00', '07/13/2008', 'C00010', 'A009', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200124', '500.00', '100.00', '06/20/2008', 'C00017', 'A007', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200126', '500.00', '100.00', '06/24/2008', 'C00022', 'A002', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200129', '2500.00', '500.00', '07/20/2008', 'C00024', 'A006', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200127', '2500.00', '400.00', '07/20/2008', 'C00015', 'A003', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200128', '3500.00', '1500.00', '07/20/2008', 'C00009', 'A002', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200135', '2000.00', '800.00', '09/16/2008', 'C00007', 'A010', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200131', '900.00', '150.00', '08/26/2008', 'C00012', 'A012', 'SOD');
INSERT INTO w3.fact.Orders VALUES('200133', '1200.00', '400.00', '06/29/2008', 'C00009', 'A002', 'SOD');

GO;

CREATE OR ALTER VIEW dbo.[Agents per Working Area] (WORKING_AREA, COUNT)
  AS SELECT WORKING_AREA, COUNT(AGENT_CODE)
      FROM w3.dbo.Agents
      GROUP BY WORKING_AREA;

GO;

CREATE TABLE w3.dbo.PrePost
(
  Message varchar(50)
)