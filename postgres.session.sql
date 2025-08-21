--top sales by genre
SELECT
g.name AS genre_name,
sum(total) AS total_revenue
from genre as g
join track as t 
    on g.genre_id = t.genre_id
join invoice_line as il
    on t.track_id = il.track_id
join invoice as i
    on il.invoice_id = i.invoice_id
group by  g.name
ORDER BY total_revenue DESC
;
--top sales by genre_enhacned 
SELECT
    g.name AS genre_name,
    SUM(il.unit_price * il.quantity) AS total_revenue
FROM genre AS g
JOIN track AS t ON g.genre_id = t.genre_id
JOIN invoice_line AS il ON t.track_id = il.track_id
GROUP BY g.name
ORDER BY total_revenue DESC;

--sales  by customer 
SELECT c.customer_id,
       concat(first_name, ' ', last_name) as customer_name,
       SUM(i.total) as total_revenue
FROM customer as c 
join invoice as i 
    on c.customer_id = i.customer_id
GROUP BY c.customer_id,customer_name
ORDER BY total_revenue desc
--average sales by customer
SELECT c.customer_id,
       concat(first_name, ' ', last_name) as customer_name,
       AVG(i.total) as average_revenue 
from customer as c
join invoice as i 
    on c.customer_id = i.customer_id
GROUP BY c.customer_id,customer_name
ORDER BY average_revenue desc
--avg spend per customer 
SELECT
    SUM(i.total) / COUNT(DISTINCT c.customer_id) AS avg_spend_per_customer
FROM customer AS c
JOIN invoice AS i ON c.customer_id = i.customer_id;
--loyalty
SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name AS CustomerName,
  COUNT(i.invoice_id) AS PurchaseCount
FROM
  customer c
JOIN
  invoice i ON c.customer_id = i.customer_id
GROUP BY
  c.customer_id, c.first_name, c.last_name
HAVING
  COUNT(i.invoice_id) > 1
ORDER BY PurchaseCount asc;
