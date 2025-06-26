-- Use our database
USE ShopDB;

-- Start the transaction 
START TRANSACTION;

-- 1. Створити нове замовлення
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- 2. Отримати ID замовлення
SET @order_id = LAST_INSERT_ID();

-- 3. Встановити змінні для продукту та кількості
SET @product_id = 1;
SET @count = 1;

-- 4. Перевірити, чи є достатньо товару на складі
SELECT WarehouseAmount INTO @current_amount
FROM Products
WHERE ID = @product_id
FOR UPDATE;

-- 5. Якщо товару достатньо — оновити склад і додати товар у замовлення
IF @current_amount >= @count THEN
    -- Додати товар до замовлення
    INSERT INTO OrderItems (OrderID, ProductID, Count)
    VALUES (@order_id, @product_id, @count);

    -- Оновити склад
    UPDATE Products
    SET WarehouseAmount = WarehouseAmount - @count
    WHERE ID = @product_id;

    COMMIT;
ELSE
    -- Якщо недостатньо товару — відкотити транзакцію
    ROLLBACK;
END IF;
