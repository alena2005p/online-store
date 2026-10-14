ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD;
CREATE TABLE SVYAZ_NT (
    Order_ID NUMBER PRIMARY KEY,
    Order_Date DATE,
    Client_Name VARCHAR2(100),
    Client_Phone VARCHAR2(20),
    Client_Email VARCHAR2(100),
    Worker_Name VARCHAR2(100),
    Worker_Position VARCHAR2(50),
    Worker_Phone VARCHAR2(20),
    Product_List VARCHAR2(500),
    Product_Categories VARCHAR2(300),
    Total_Amount NUMBER,
    Payment_Type VARCHAR2(50),
    Payment_Status VARCHAR2(30),
    Review_Text VARCHAR2(500),
    Review_Rating NUMBER
);

-- Заполнение данными

INSERT INTO SVYAZ_NT VALUES (
    1, TO_DATE('2026-10-10'),
    'Иванов И.И.', '+79991112233', 'ivanov@mail.ru',
    'Петров П.П.', 'Менеджер', '+79994445566',
    'iPhone 15, Чехол для iPhone 15',
    'Смартфоны, Аксессуары',
    85000, 'Карта', 'Оплачен',
    'Отличный телефон, рекомендую!', 5
);

INSERT INTO SVYAZ_NT VALUES (
    2, TO_DATE('2026-10-11'),
    'Сидоров С.С.', '+79997778899', 'sidorov@mail.ru',
    'Смирнов А.А.', 'Администратор', '+79990001122',
    'Samsung Galaxy S24',
    'Смартфоны',
    70000, 'Наличные', 'Ожидает',
    NULL, NULL
);

INSERT INTO SVYAZ_NT VALUES (
    3, TO_DATE('2026-10-12',),
    'Иванов И.Иники.', '+79991112233', 'ivanov@ Sonymail.ru',
    'Петров П.П.', 'Менеджер', '+79994445566',
    'На WH-1000XM5, PowerBank Xiaomi',
    'Аудио, Аксессуары',
    35000, 'Карта', 'Оплачен',
    'Наушники супер!', 5
);

COMMIT;