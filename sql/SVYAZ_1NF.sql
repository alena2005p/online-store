ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

CREATE TABLE SVYAZ_1NF (
    Order_ID NUMBER,
    Order_Date DATE,
    client_last_name VARCHAR(50) NOT NULL,   -- Исправлена опечатка
    client_first_name VARCHAR(50) NOT NULL,
    client_middle_name VARCHAR(50),
    Client_Phone VARCHAR2(20),
    Client_Email VARCHAR2(100),
    
    worker_last_name VARCHAR(50) NOT NULL,   -- Разбили ФИО сотрудника
    worker_first_name VARCHAR(50) NOT NULL,
    worker_middle_name VARCHAR(50),
    
    Worker_Position VARCHAR2(50),
    Worker_Phone VARCHAR2(20),
    Product_Name VARCHAR2(200),
    Product_Category VARCHAR2(100),
    Total_Amount NUMBER,
    Payment_Type VARCHAR2(50),
    Payment_Status VARCHAR2(30),
    Review_Text VARCHAR2(500),
    Review_Rating NUMBER,
    PRIMARY KEY (Order_ID, Product_Name)
);