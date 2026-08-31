DROP INDEX IF EXISTS fki_fk_order_products_prior_product;

CREATE INDEX idx_orders_user_id
ON orders (user_id);

CREATE INDEX idx_products_aisle_id
ON products (aisle_id);

CREATE INDEX idx_products_department_id
ON products (department_id);

CREATE INDEX idx_order_products_prior_product_id
ON order_products__prior (product_id);

CREATE INDEX idx_order_products_train_product_id
ON order_products__train (product_id);


DROP INDEX IF EXISTS fki_fk_order_products_prior_order;

DROP INDEX IF EXISTS fki_fk_order_products_train_o;

DROP INDEX IF EXISTS fki_fk_order_products_train_p;


DROP INDEX IF EXISTS fki_fk_order_products_prior_o;

DROP INDEX IF EXISTS fki_fk_order_products_prior_p;