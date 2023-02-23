INSERT INTO analysis.dm_rfm_segments 
(SELECT a.user_id, c.recency, a.frequency, b.monetary_value FROM analysis.tmp_rfm_frequency a  
LEFT JOIN analysis.tmp_rfm_monetary_value b ON a.user_id=b.user_id 
LEFT JOIN analysis.tmp_rfm_recency  c ON a.user_id=c.user_id
ORDER BY user_id ASC)

    
user_id|recency|frequency|monetary_value|
-------+-------+---------+--------------+
      0|      1|        3|             4|
      1|      4|        3|             3|
      2|      2|        4|             5|
      3|      2|        3|             3|
      4|      4|        3|             3|
      5|      5|        5|             5|
      6|      1|        4|             5|
      7|      4|        2|             2|
      8|      1|        1|             3|
      9|      1|        2|             2|
     10|      3|        5|             2|
