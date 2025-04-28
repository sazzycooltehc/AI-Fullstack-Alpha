DROP TABLE IF EXISTS "login"

CREATE TABLE 'login' (
  'id' int NOT NULL AUTO_INCREMENT,
  'email' varchar(255) NOT NULL,
  'password' varchar(255) NOT NULL,
  'token' varchar(16) NOT NULL DEFAULT (substr(md5(rand()),1,16)),
  PRIMARY KEY ('id','email'),
  UNIQUE KEY 'token' ('token'`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
