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
