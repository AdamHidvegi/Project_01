DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE categories;
DROP TABLE users;

CREATE TABLE users
(
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  wallet INT4,
  email VARCHAR(255),
  id INT4 PRIMARY KEY
);

CREATE TABLE merchants
(
  name VARCHAR(255),
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE categories
(
  tag VARCHAR(255),
  name VARCHAR(255),
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE transactions
(
  id SERIAL4 PRIMARY KEY,
  price INT4,
  merchant_id SERIAL4 REFERENCES merchants(id) ON DELETE CASCADE,
  category_id SERIAL4 REFERENCES categories(id) ON DELETE CASCADE,
  user_id SERIAL4 REFERENCES users(id) ON DELETE CASCADE
);
