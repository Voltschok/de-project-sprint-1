Качество данных
Данные не содержат дубликатов и значений NULL

Для обеспечения качества данных в таблице orders используются ограничения:
- CONSTRAINT orders_check CHECK ((cost = (payment + bonus_payment))) - ограничение исходя из бизнес-логики  
- CONSTRAINT orders_pkey PRIMARY KEY (order_id)  - ограничение первичного ключа  по колонке  order_id
- ограничение NOT NULL, для типов данных numeric - значение по умолчанию 0

Для обеспечения качества данных в таблице orders используются ограничения:
- CONSTRAINT orderstatuses_pkey PRIMARY KEY (id) - ограничение первичного ключа по колонке  id
- ограничение NOT NULL

Для обеспечения качества данных в таблице users используются ограничения:
- CONSTRAINT users_pkey PRIMARY KEY (id) - ограничение первичного ключа по колонке  id
- ограничение NOT NULL

Для обеспечения качества данных в таблице orderstatuslog используются ограничения:
- CONSTRAINT orderstatuslog_order_id_status_id_key UNIQUE (order_id, status_id) - ограничение по уникальности для order_id и status_id
- CONSTRAINT orderstatuslog_pkey PRIMARY KEY (id) - ограничение первичного ключа по колонке  id
- ограничение NOT NULL

Для обеспечения качества данных в таблице products используются ограничения:
- CONSTRAINT products_pkey PRIMARY KEY (id) - ограничение первичного ключа  по колонке  order_id
- CONSTRAINT products_price_check CHECK ((price >= (0)::numeric)) - ограничение исходя из бизнес-логики  
- ограничение NOT NULL, для типов данных numeric - значение по умолчанию 0
