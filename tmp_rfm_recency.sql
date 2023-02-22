DROP TABLE IF EXISTS analysis.tmp_rfm_recency;
CREATE TABLE analysis.tmp_rfm_recency (
 user_id INT NOT NULL PRIMARY KEY,
 recency INT NOT NULL CHECK(recency >= 1 AND recency <= 5)
);
 
INSERT INTO analysis.tmp_rfm_recency
(
SELECT 
	user_id,
	NTILE(5) over (ORDER BY last_order_dt desc)
FROM (
-- выборка для исключения пользователя с user_id со значением NULL
SELECT * FROM
	--  выборка пользователей по максимальной дате заказа, имеющего статус closed
	(WITH rcn AS (SELECT * FROM orders WHERE status = 4), rcn2 AS (SELECT rcn.user_id,  
	 max(rcn.order_ts) as last_order_dt FROM rcn GROUP BY rcn.user_id, rcn.status)
	 
	-- выборка пользователей по максимальной дате заказа, имеющего статус closed
	SELECT * FROM rcn2
	UNION
	-- выборка пользователей, не совершивших заказов (со статусом closed) и присвоением им значения NULL
	SELECT * FROM (select 
	DISTINCT (CASE WHEN user_id NOT IN (SELECT user_id FROM rcn2) THEN user_id END) AS user_id,
	null::timestamp AS last_order_dt
	FROM orders) AS rcn3) as rcn4
WHERE user_id IS NOT NULL) AS rcn5
ORDER BY ntile DESC);
