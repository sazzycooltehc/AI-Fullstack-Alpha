CREATE TABLE "login" (
  "id" SERIAL NOT NULL,
  "userid" varchar(255) NOT NULL,
  "password" varchar(255) NOT NULL,
  "token" varchar(16) NOT NULL DEFAULT substring(md5(random()::text), 1, 16),
  PRIMARY KEY ("id","userid"),
  UNIQUE ("token")
);
