DROP VIEW IF EXISTS orders;
CREATE VIEW orders AS
SELECT po.order_id, po.order_ts, po.user_id, po.bonus_payment,
		po.payment, po.cost, po.bonus_grant, pl.status_id  FROM production.orders po
JOIN (
SELECT DISTINCT ON (order_id) order_id,  dttm, status_id
FROM production.orderstatuslog ORDER BY order_id, dttm DESC) pl 
ON po.order_id=pl.order_id; 
