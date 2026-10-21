
 1. СОЗДАНИЕ ПОСЛЕДОВАТЕЛЬНОСТЕЙ
CREATE SEQUENCE seq_clients_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_orders_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_order_items_id START WITH 1 INCREMENT BY 1;

 2. СОЗДАНИЕ СПЕЦИФИКАЦИИ ПАКЕТА
CREATE OR REPLACE PACKAGE pkg_online_store AS
   
    FUNCTION get_new_id RETURN NUMBER;
    

    PROCEDURE add_client(
        p_last_name IN VARCHAR2,
        p_first_name IN VARCHAR2,
        p_phone IN VARCHAR2,
        p_email IN VARCHAR2
    );
    

    PROCEDURE add_order(
        p_date IN DATE,
        p_client_id IN NUMBER,
        p_worker_id IN NUMBER,
        p_total_amount IN NUMBER
    );
END pkg_online_store;
/

3. СОЗДАНИЕ ТЕЛА ПАКЕТА 
CREATE OR REPLACE PACKAGE BODY pkg_online_store AS


    FUNCTION get_new_id RETURN NUMBER IS
        v_max_id NUMBER;
    BEGIN
        SELECT NVL(MAX(Product_ID), 0) INTO v_max_id FROM Products_3NF;
        RETURN v_max_id + 1;
    END get_new_id;

   
    PROCEDURE add_client(
        p_last_name IN VARCHAR2,
        p_first_name IN VARCHAR2,
        p_phone IN VARCHAR2,
        p_email IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Clients_3NF (Client_ID, client_last_name, client_first_name, Client_Phone, Client_Email)
        VALUES (seq_clients_id.NEXTVAL, p_last_name, p_first_name, p_phone, p_email);
        COMMIT;
    END add_client;

  
    PROCEDURE add_order(
        p_date IN DATE,
        p_client_id IN NUMBER,
        p_worker_id IN NUMBER,
        p_total_amount IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Orders_3NF (Order_ID, Order_Date, Client_ID, Worker_ID, Total_Amount)
        VALUES (seq_orders_id.NEXTVAL, p_date, p_client_id, p_worker_id, p_total_amount);
        COMMIT;
    END add_order;

END pkg_online_store;
/

4. СОЗДАНИЕ ПРЕДСТАВЛЕНИЯ 
CREATE OR REPLACE VIEW v_orders_info AS
SELECT 
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    c.client_last_name || ' ' || c.client_first_name AS Client_Name, -- Объединяем ФИО клиента
    c.Client_Phone,
    w.worker_last_name || ' ' || w.worker_first_name AS Worker_Name, -- Объединяем ФИО сотрудника
    w.Worker_Position
FROM 
    Orders_3NF o
JOIN 
    Clients_3NF c ON o.Client_ID = c.Client_ID
JOIN 
    Workers_3NF w ON o.Worker_ID = w.Worker_ID;

