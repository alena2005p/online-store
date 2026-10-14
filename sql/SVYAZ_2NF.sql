ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- 1. Клиенты
CREATE TABLE Clients (
    Client_ID NUMBER PRIMARY KEY,
    Client_Name VARCHAR2(100),
    Client_Phone VARCHAR2(20),
    Client_Email VARCHAR2(100)
);

-- 2. Работники (объединяем админов и менеджеров)
CREATE TABLE Workers (
    Worker_ID NUMBER PRIMARY KEY,
    Worker_Name VARCHAR2(100),
    Worker_Position VARCHAR2(50),
    Worker_Phone VARCHAR2(20)
);

-- 3. Товары
CREATE TABLE Products (
    Product_ID NUMBER PRIMARY KEY,
    Product_Name VARCHAR2(200),
    Product_Category VARCHAR2(100)
);

-- 4. Заказы
CREATE TABLE Orders (
    Order_ID NUMBER PRIMARY KEY,
    Order_Date DATE,
    Client_ID NUMBER,
    Worker_ID NUMBER,
    Total_Amount NUMBER,
    FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID),
    FOREIGN KEY (Worker_ID) REFERENCES Workers(Worker_ID)
);

-- 5. Состав заказа
CREATE TABLE Order_Items (
    Order_ID NUMBER,
    Product_ID NUMBER,
    Quantity NUMBER,
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- 6. Платежи
CREATE TABLE Payments (
    Payment_ID NUMBER PRIMARY KEY,
    Order_ID NUMBER,
    Payment_Type VARCHAR2(50),
    Payment_Status VARCHAR2(30),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- 7. Отзывы
CREATE TABLE Reviews (
    Review_ID NUMBER PRIMARY KEY,
    Client_ID NUMBER,
    Product_ID NUMBER,
    Review_Text VARCHAR2(500),
    Review_Rating NUMBER,
    FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Заполнение
INSERT INTO Clients VALUES (1, 'Иванов И.И.', '+79991112233', 'ivanov@mail.ru');
INSERT INTO Clients VALUES (2, 'Сидоров С.С.', '+79997778899', 'sidorov@mail.ru');

INSERT INTO Workers VALUES (1, 'Петров П.П.', 'Менеджер', '+79994445566');
INSERT INTO Workers VALUES (2, 'Смирнов А.А.', 'Администратор', '+79990001122');

INSERT INTO Products VALUES (1, 'iPhone 15', 'Смартфоны');
INSERT INTO Products VALUES (2, 'Чехол для iPhone 15', 'Аксессуары');
INSERT INTO Products VALUES (3, 'Samsung Galaxy S24', 'Смартфоны');
INSERT INTO Products VALUES (4, 'Наушники Sony WH-1000XM5', 'Аудио');
INSERT INTO Products VALUES (5, 'PowerBank Xiaomi', 'Аксессуары');

INSERT INTO Orders VALUES (1, TO_DATE('2026-10-10','YYYY-MM-DD'), 1, 1, 85000);
INSERT INTO Orders VALUES (2, TO_DATE('2026-10-11','YYYY-MM-DD'), 2, 2, 70000);
INSERT INTO Orders VALUES (3, TO_DATE('2026-10-12','YYYY-MM-DD'), 1, 1, 35000);

INSERT INTO Order_Items VALUES (1, 1, 1);
INSERT INTO Order_Items VALUES (1, 2, 1);
INSERT INTO Order_Items VALUES (2, 3, 1);
INSERT INTO Order_Items VALUES (3, 4, 1);
INSERT INTO Order_Items VALUES (3, 5, 1);

INSERT INTO Payments VALUES (1, 1, 'Карта', 'Оплачен');
INSERT INTO Payments VALUES (2, 2, 'Наличные', 'Ожидает');
INSERT INTO Payments VALUES (3, 3, 'Карта', 'Оплачен');

INSERT INTO Reviews VALUES (1, 1, 1, 'Отличный телефон, рекомендую!', 5);
INSERT INTO Reviews VALUES (2, 1, 4, 'Наушники супер!', 5);

COMMIT;