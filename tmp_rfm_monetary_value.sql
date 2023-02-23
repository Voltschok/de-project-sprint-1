DROP TABLE IF EXISTS  analysis.tmp_rfm_monetary_value;
CREATE TABLE analysis.tmp_rfm_monetary_value (
 user_id INT NOT NULL PRIMARY KEY,
 monetary_value INT NOT NULL CHECK(monetary_value >= 1 AND monetary_value <= 5)
);
INSERT INTO analysis.tmp_rfm_monetary_value  (
SELECT 
	user_id,
	NTILE(5) over (ORDER BY order_sum ASC)
FROM
(
-- выборка для исключения пользователя с user_id со значением NULL
SELECT * FROM 
	--  выборка пользователей по максимальной дате заказа, имеющего статус closed
	(WITH sm AS (SELECT * FROM orders WHERE status = 4), sm2 AS (SELECT sm.user_id,  
	max(sm.order_ts) AS last_order_dt FROM sm GROUP BY sm.user_id, sm.status)
	
	-- выборка суммы платжей по заказам (со статусом closed) с группировкой по пользователям
	SELECT user_id, sum(payment) AS order_sum FROM sm GROUP BY user_id  
	
	UNION 
	-- выборка пользователей, не совершивших заказов (со статусом closed) и присвоением им значения 0 
	SELECT * FROM (SELECT 
	DISTINCT (CASE WHEN user_id NOT IN (SELECT user_id FROM sm2) THEN user_id END) AS user_id,
	0 AS order_sum
	FROM orders) AS sm3
GROUP BY user_id, order_sum) AS sm4
WHERE user_id IS NOT NULL)  AS sm5
ORDER BY ntile DESC);
