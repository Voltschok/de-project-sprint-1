SELECT a.user_id, c.recency, a.frequency, b.monetary_value FROM analysis.tmp_rfm_frequency a  
LEFT JOIN analysis.tmp_rfm_monetary_value b ON a.user_id=b.user_id 
LEFT JOIN analysis.tmp_rfm_recency  c ON a.user_id=c.user_id
ORDER BY user_id ASC

user_id|recency|frequency|monetary_value|
-------+-------+---------+--------------+
      0|      5|        3|             2|
      1|      2|        3|             3|
      2|      4|        3|             1|
      3|      4|        3|             3|
      4|      2|        3|             3|
      5|      1|        1|             1|
      6|      5|        3|             1|
      7|      2|        3|             4|
      8|      5|        5|             3|
      9|      5|        4|             4|
     10|      3|        1|             4|
