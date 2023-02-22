CREATE TABLE dm_rfm_segments (
	user_id int4 NOT null ,
	recency int4 NOT null CHECK (recency BETWEEN 1 AND 5),
	frequency int4 NOT null CHECK(frequency BETWEEN 1 AND 5),
	monetary_value int4 NOT null CHECK (monetary_value BETWEEN 1 AND 5),
	CONSTRAINT dm_rfm_segments_pkey PRIMARY KEY (user_id)
);
