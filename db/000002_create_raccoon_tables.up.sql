CREATE TABLE IF NOT EXISTS users (
  user_uuid uuid NOT NULL
  CONSTRAINT user_uuid_pkey PRIMARY KEY,
  username text,
  email text UNIQUE,
  phone text UNIQUE,
  validation_status text NOT NULL,
  first_name text,
  last_name text,
  addresses jsonb,
  avatar text,
  password text
);

CREATE INDEX IF NOT EXISTS user_phone_idx
    ON users USING btree(phone);


CREATE TABLE IF NOT EXISTS meals_db (
    meal_uuid uuid NOT NULL
    CONSTRAINT meal_uuid_pkey PRIMARY KEY,
    name text NOT NULL,
    description text,
    meal_settings jsonb,
    price float NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS meals_db_name_idx
    ON meals_db USING btree(name);


CREATE TABLE IF NOT EXISTS sms_db (
    sms_uuid uuid NOT NULL
    CONSTRAINT sms_uuid_pkey PRIMARY KEY,
    user_uuid uuid NOT NULL UNIQUE,
    api_sms_uuid  uuid NOT NULL UNIQUE,
    check_phrase text NOT NULL,
    is_approved bool,
    is_disapproved bool,
    FOREIGN KEY (user_uuid) REFERENCES users ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS user_uuid_idx
    ON sms_db USING btree(user_uuid);

CREATE TABLE IF NOT EXISTS orders_db (
    order_uuid uuid NOT NULL
    CONSTRAINT order_uuid_pkey PRIMARY KEY,
    user_uuid uuid NOT NULL,
    params jsonb,
    order_status text NOT NULL,
    FOREIGN KEY (user_uuid) REFERENCES users ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS user_uuid_idx
    ON orders_db USING btree(user_uuid);

CREATE TABLE IF NOT EXISTS delivery_db (
      delivery_uuid uuid NOT NULL
      CONSTRAINT delivery_uuid_pkey PRIMARY KEY,
      order_uuid uuid NOT NULL UNIQUE,
      FOREIGN KEY (order_uuid) REFERENCES orders_db ON DELETE CASCADE

);

CREATE INDEX IF NOT EXISTS order_uuid_idx
    ON delivery_db USING btree(order_uuid);


