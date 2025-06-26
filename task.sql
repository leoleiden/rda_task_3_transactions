-- Use our database
USE ShopDB;

-- Start the transaction 
START TRANSACTION;

-- 1. Створити нове замовлення від клієнта з ID = 1, дата = 2023-01-01
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- 2. Отримати ID створеного замовлення
SET @order_id = LAST_INSERT_ID();

-- 3. Додати товар AwersomeProduct (ID = 1, Count = 1)
INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@order_id, 1, 1);

-- 4. Зменшити залишок товару на складі
UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;

-- Завершити транзакцію
COMMIT;
