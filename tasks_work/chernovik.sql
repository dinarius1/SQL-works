-- Создание таблицы Users
create table users(
userId serial primary key,
age int);

-- Создание таблицы Items
create table items(
itemId serial primary key,
price money);

SET lc_monetary = 'ru_RU.utf8';

UPDATE items SET price = price::money;

-- Создание таблицы 
create table Purchases(
purchaseId serial primary key,
userId int,
itemId int,
date date,
CONSTRAINT fk_user_Purchases
FOREIGN KEY (userId) REFERENCES users (userid));




-- код по экспортированию данных в бд!!!!!!!!!!




-- Ответ на вопрос А) 1
SELECT AVG(average_spent) AS average_monthly_spent
FROM (                                                   
  SELECT DATE_TRUNC('month', purchases.date) AS month,
         AVG(CAST(items.price AS decimal)) AS average_spent
  FROM items                                 
  JOIN purchases ON items.itemid = purchases.itemid
  JOIN users ON users.userid = purchases.userid
  WHERE users.age BETWEEN 18 AND 25
        AND purchases.date >= '2023-01-01'
        AND purchases.date < '2024-01-01'
  GROUP BY DATE_TRUNC('month', purchases.date)
) AS subquery;

 average_monthly_spent 
-----------------------
  569.8500000000000000
(1 row)

-- Ответ на вопрос А) 2
SELECT AVG(average_spent) AS average_monthly_spent
FROM (                                                   
  SELECT DATE_TRUNC('month', purchases.date) AS month,
         AVG(CAST(items.price AS decimal)) AS average_spent
  FROM items                                 
  JOIN purchases ON items.itemid = purchases.itemid
  JOIN users ON users.userid = purchases.userid
  WHERE users.age BETWEEN 26 AND 35
        AND purchases.date >= '2023-01-01'
        AND purchases.date < '2024-01-01'
  GROUP BY DATE_TRUNC('month', purchases.date)
) AS subquery;
 average_monthly_spent 
-----------------------
  582.0000000000000000
(1 row)

-- Ответ на вопрос Б)
SELECT DATE_TRUNC('month', purchases.date) AS month,
       MAX(CAST(items.price AS decimal)) AS max_spent
FROM items
JOIN purchases ON items.itemid = purchases.itemid
JOIN users ON users.userid = purchases.userid
WHERE users.age >= 35
      AND purchases.date >= '2023-01-01'
      AND purchases.date < '2024-01-01'
GROUP BY DATE_TRUNC('month', purchases.date)
ORDER BY max_spent DESC
LIMIT 2;
         month          | max_spent 
------------------------+-----------
 2023-03-01 00:00:00+06 |    984.00
 2023-02-01 00:00:00+06 |    984.00
(2 rows)


-- Ответ на вопрос В)
SELECT purchases.itemid AS the_most_profitable_product,
       SUM(CAST(items.price AS decimal)) AS total_spent
FROM items
JOIN purchases ON items.itemid = purchases.itemid
JOIN users ON users.userid = purchases.userid
WHERE purchases.date >= '2023-01-01'
      AND purchases.date < '2024-01-01'
GROUP BY purchases.itemid
ORDER BY total_spent DESC
LIMIT 1;
 the_most_profitable_product | total_spent 
-----------------------------+-------------
                          17 |     2880.00
(1 row)



-- Ответ на вопрос Г)
SELECT                         
    items.itemid,
    SUM(items.price) AS total_revenue,
    100 * SUM(items.price) / (SELECT SUM(price) FROM items) AS revenue_share
FROM
    purchases
JOIN
    items ON items.itemid = purchases.itemid
JOIN
    users ON users.userid = purchases.userid
WHERE purchases.date >= '2023-01-01'
    AND purchases.date < '2024-01-01'
GROUP BY
    items.itemid
ORDER BY
    total_revenue DESC
LIMIT 3;
 itemid | total_revenue |   revenue_share    
--------+---------------+--------------------
     17 |    2 880,00 ₽ |  5.416384563303994
     88 |    2 445,00 ₽ | 4.5982848115549535
     77 |    2 296,00 ₽ |  4.318062137967352
(3 rows)


