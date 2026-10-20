ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- 1. Клиенты
CREATE TABLE Clients_3NF (
    Client_ID NUMBER PRIMARY KEY,
    client_last_name VARCHAR2(50) NOT NULL,
    client_first_name VARCHAR2(50) NOT NULL,
    client_middle_name VARCHAR2(50),
    Client_Phone VARCHAR2(20),
    Client_Email VARCHAR2(100)
);

-- 2. Работники
CREATE TABLE Workers_3NF (
    Worker_ID NUMBER PRIMARY KEY,
    worker_last_name VARCHAR2(50) NOT NULL,
    worker_first_name VARCHAR2(50) NOT NULL,
    worker_middle_name VARCHAR2(50),
    Worker_Position VARCHAR2(50),
    Worker_Phone VARCHAR2(20)
);

-- 3. Категории (вынесены отдельно — устранена транзитивная зависимость)
CREATE TABLE Categories_3NF (
    Category_ID NUMBER PRIMARY KEY,
    Category_Name VARCHAR2(100)
);

-- 4. Товары (ссылаются на категорию)
CREATE TABLE Products_3NF (
    Product_ID NUMBER PRIMARY KEY,
    Product_Name VARCHAR2(200),
    Category_ID NUMBER,
    FOREIGN KEY (Category_ID) REFERENCES Categories_3NF(Category_ID)
);

-- 5. Заказы
CREATE TABLE Orders_3NF (
    Order_ID NUMBER PRIMARY KEY,
    Order_Date DATE,
    Client_ID NUMBER,
    Worker_ID NUMBER,
    Total_Amount NUMBER,
    FOREIGN KEY (Client_ID) REFERENCES Clients_3NF(Client_ID),
    FOREIGN KEY (Worker_ID) REFERENCES Workers_3NF(Worker_ID)
);

-- 6. Состав заказа
CREATE TABLE Order_Items_3NF (
  order_line_id NUMBER PRIMARY KEY,
    Order_ID NUMBER,
    Product_ID NUMBER,
    Quantity NUMBER,

    FOREIGN KEY (Order_ID) REFERENCES Orders_3NF(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products_3NF(Product_ID)
);

-- 7. Платежи
CREATE TABLE Payments_3NF (
    Payment_ID NUMBER PRIMARY KEY,
    Order_ID NUMBER,
    Payment_Type VARCHAR2(50),
    Payment_Status VARCHAR2(30),
    FOREIGN KEY (Order_ID) REFERENCES Orders_3NF(Order_ID)
);

-- 8. Отзывы
CREATE TABLE Reviews_3NF (
    Review_ID NUMBER PRIMARY KEY,
    Client_ID NUMBER,
    Product_ID NUMBER,
    Review_Text VARCHAR2(500),
    Review_Rating NUMBER,
    FOREIGN KEY (Client_ID) REFERENCES Clients_3NF(Client_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products_3NF(Product_ID)
);

-- Заполнение
INSERT INTO Clients_3NF VALUES (1, 'Иванов И.И.', '+79991112233', 'ivanov@mail.ru');
INSERT INTO Clients_3NF VALUES (2, 'Сидоров С.С.', '+79997778899', 'sidorov@mail.ru');

INSERT INTO Workers_3NF VALUES (1, 'Петров П.П.', 'Менеджер', '+79994445566');
INSERT INTO Workers_3NF VALUES (2, 'Смирнов А.А.', 'Администратор', '+79990001122');

INSERT INTO Categories_3NF VALUES (1, 'Смартфоны');
INSERT INTO Categories_3NF VALUES (2, 'Аксессуары');
INSERT INTO Categories_3NF VALUES (3, 'Аудио');

INSERT INTO Products_3NF VALUES (1, 'iPhone 15', 1);
INSERT INTO Products_3NF VALUES (2, 'Чехол для iPhone 15', 2);
INSERT INTO Products_3NF VALUES (3, 'Samsung Galaxy S24', 1);
INSERT INTO Products_3NF VALUES (4, 'Наушники Sony WH-1000XM5', 3);
INSERT INTO Products_3NF VALUES (5, 'PowerBank Xiaomi', 2);

INSERT INTO Orders_3NF VALUES (1, TO_DATE('2026-10-10','YYYY-MM-DD'), 1, 1, 85000);
INSERT INTO Orders_3NF VALUES (2, TO_DATE('2026-10-11','YYYY-MM-DD'), 2, 2, 70000);
INSERT INTO Orders_3NF VALUES (3, TO_DATE('2026-10-12','YYYY-MM-DD'), 1, 1, 35000);

INSERT INTO Order_Items_3NF VALUES (1, 1, 1);
INSERT INTO Order_Items_3NF VALUES (1, 2, 1);
INSERT INTO Order_Items_3NF VALUES (2, 3, 1);
INSERT INTO Order_Items_3NF VALUES (3, 4, 1);
INSERT INTO Order_Items_3NF VALUES (3, 5, 1);

INSERT INTO Payments_3NF VALUES (1, 1, 'Карта', 'Оплачен');
INSERT INTO Payments_3NF VALUES (2, 2, 'Наличные', 'Ожидает');
INSERT INTO Payments_3NF VALUES (3, 3, 'Карта', 'Оплачен');

INSERT INTO Reviews_3NF VALUES (1, 1, 1, 'Отличный телефон, рекомендую!', 5);
INSERT INTO Reviews_3NF VALUES (2, 1, 4, 'Наушники супер!', 5);

COMMIT;