DROP TABLE IF EXISTS "login";

CREATE TABLE "login" (
  "id" SERIAL NOT NULL,
  "email" varchar(255) NOT NULL,
  "password" varchar(255) NOT NULL,
  "token" varchar(16) NOT NULL DEFAULT substring(md5(random()::text), 1, 16), 
  PRIMARY KEY ("id","email"),
  UNIQUE ("token")
); 

SELECT * from "login";

ALTER TABLE "login"
RENAME COLUMN "email" to "userid";

INSERT INTO "login" (id, userid, password, token)
VALUES ('1', 'jack@gmail.com', 'usa12345', 'jack@gmail.com');

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  password TEXT NOT NULL,
  mobile_number VARCHAR(20) NOT NULL,
  token VARCHAR(16) NOT NULL PRIMARY KEY,
  CONSTRAINT unique_email UNIQUE (email),
  CONSTRAINT users_token_fkey FOREIGN KEY (token) REFERENCES login(token)
);


SELECT * FROM users;

--UPDATE: Modifies existing records in a table.

-- Update the password for a specific user
UPDATE login
SET password = 'new_strong_password'
WHERE userid = 'jack@gmail.com';

-- Update a user's mobile number
UPDATE users
SET mobile_number = '9876543210'
WHERE email = 'jack@gmail.com';

--DELETE: Removes existing records from a table.

-- Delete a specific user from the login table
DELETE FROM login
WHERE userid = 'jack@gmail.com';

-- Delete a specific user from the users table
DELETE FROM users
WHERE email = 'jack@gmail.com';

-- Delete all records from a table (use with caution!)
-- DELETE FROM users;

--TRUNCATE TABLE: Removes all rows from a table, but the table structure remains. It's faster than DELETE without a WHERE clause because it doesn't log individual row deletions.

-- Remove all data from the login table
TRUNCATE TABLE login;

Data Definition Language (DDL)
These commands are used for defining and managing database structure.

ALTER TABLE (Add Column): Adds a new column to an existing table.

-- Add a 'last_login' column to the login table
ALTER TABLE login
ADD COLUMN last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

--ALTER TABLE (Drop Column): Removes a column from an existing table.

-- Remove the 'token' column from the login table (if no longer needed and not referenced)
-- ALTER TABLE login
-- DROP COLUMN token;

--ALTER TABLE (Modify Column Type): Changes the data type or constraints of an existing column.

-- Change the length of the 'password' column in the login table
ALTER TABLE login
ALTER COLUMN password TYPE VARCHAR(500);

--CREATE INDEX: Creates an index on a table to speed up data retrieval.

-- Create an index on the 'userid' column for faster lookups
CREATE INDEX idx_login_userid ON login (userid);

DROP INDEX: Deletes an existing index.

-- Drop the index created above
DROP INDEX idx_login_userid;

-- Data Query Language (DQL)
-- These commands are used for retrieving data from the database.

-- SELECT with WHERE and LIKE: Selects records based on a pattern match.

-- Select users whose email starts with 'j'
SELECT *
FROM users
WHERE email LIKE 'j%';

SELECT with ORDER BY: Sorts the result set.

-- Select all users and order them by name alphabetically
SELECT *
FROM users
ORDER BY name ASC;

-- Order by mobile number in descending order
SELECT *
FROM users
ORDER BY mobile_number DESC;

SELECT with LIMIT and OFFSET: Limits the number of rows returned and specifies a starting point.

-- Select the first 5 users
SELECT *
FROM users
LIMIT 5;

-- Select 5 users starting from the 6th user
SELECT *
FROM users
LIMIT 5 OFFSET 5;

-- JOIN Operations: Combines rows from two or more tables based on a related column between them.

-- INNER JOIN: Returns records that have matching values in both tables.

-- Get user details along with their login token
SELECT u.name, u.email, l.token
FROM users u
INNER JOIN login l ON u.token = l.token;

-- LEFT JOIN (or LEFT OUTER JOIN): Returns all records from the left table, and the matching records from the right table. If there is no match, the result is NULL from the right side.

-- Get all login entries and matching user details (if any)
SELECT l.userid, l.token, u.name, u.email
FROM login l
LEFT JOIN users u ON l.token = u.token;

-- RIGHT JOIN (or RIGHT OUTER JOIN): Returns all records from the right table, and the matching records from the left table. If there is no match, the result is NULL from the left side.

-- Get all user details and matching login entries (if any)
SELECT u.name, u.email, l.userid, l.token
FROM users u
RIGHT JOIN login l ON u.token = l.token;

-- FULL JOIN (or FULL OUTER JOIN): Returns all records when there is a match in either left or right table.

-- Get all records from both tables, matching where possible
SELECT l.userid, l.token, u.name, u.email
FROM login l
FULL JOIN users u ON l.token = u.token;

-- GROUP BY and Aggregate Functions (COUNT, SUM, AVG, MIN, MAX): Groups rows that have the same values in specified columns into a summary row, often used with aggregate functions.

-- Count the total number of users
SELECT COUNT(*) AS total_users
FROM users;

-- Example: If you had a 'country' column, you could count users per country
-- SELECT country, COUNT(*) AS users_per_country
-- FROM users
-- GROUP BY country;

-- HAVING Clause: Used with GROUP BY to filter groups based on a specified condition.

-- Example: If you had a 'country' column and wanted countries with more than 10 users
-- SELECT country, COUNT(*) AS users_per_country
-- FROM users
-- GROUP BY country
-- HAVING COUNT(*) > 10;

-- Transaction Control Language (TCL)
-- These commands are used to manage transactions in the database.

-- BEGIN TRANSACTION (or START TRANSACTION): Marks the beginning of a transaction.

-- Start a new transaction
BEGIN TRANSACTION;

-- COMMIT: Saves all changes made during the current transaction permanently to the database.

-- Commit the changes made in the transaction
COMMIT;

-- ROLLBACK: Undoes all changes made during the current transaction, restoring the database to its state before the transaction began.

-- Rollback the changes made in the transaction
ROLLBACK;
