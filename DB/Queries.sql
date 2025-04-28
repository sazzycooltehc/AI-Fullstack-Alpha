DROP TABLE IF EXISTS "login";

CREATE TABLE "login" (
  "id" SERIAL NOT NULL,
  "email" varchar(255) NOT NULL,
  "password" varchar(255) NOT NULL,
  "token" varchar(16) NOT NULL DEFAULT substring(md5(random()::text), 1, 16), 
  PRIMARY KEY ("id","email"),
  UNIQUE ("token")
); 
