DROP TABLE IF EXISTS analysis.tmp_rfm_frequency; 
CREATE TABLE analysis.tmp_rfm_frequency (
 user_id INT NOT NULL PRIMARY KEY,
 frequency INT NOT NULL CHECK(frequency >= 1 AND frequency <= 5)
);

INSERT INTO analysis.tmp_rfm_frequency (
SELECT 
	user_id,
	NTILE(5) over (ORDER BY order_count ASC)
FROM (

-- выборка для исключения пользователя с user_id со значением NULL
 SELECT * FROM 
 	--  выборка пользователей по максимальной дате заказа, имеющего статус closed
	
	(WITH frq AS (SELECT * FROM orders WHERE status=4), frq1 AS ( 
	SELECT frq.user_id, max(frq.order_ts) AS last_order_dt 
	FROM frq GROUP BY frq.user_id, frq.status) 
	
	-- выборка кол-ва заказов (со статусом closed) с группировкой по пользователям
	SELECT user_id,  COUNT(*) AS order_count FROM frq GROUP BY  user_id  

	UNION
	
	-- выборка пользователей, не совершивших заказов (со статусом closed) и присвоением им значения 0 
	SELECT * FROM (
	 SELECT DISTINCT (CASE WHEN user_id NOT IN (SELECT user_id FROM frq1) THEN user_id END) AS user_id,
		0 AS order_count
		FROM orders) AS frq2
	 GROUP BY  user_id, order_count) AS frq3
 WHERE user_id IS NOT NULL)  AS frq4
 ORDER BY ntile DESC);
