create table `user`(
   id INT NOT NULL AUTO_INCREMENT,
   `name` VARCHAR(15) NOT NULL,
   last_name VARCHAR(30) NOT NULL,
   age INT NOT NULL,
   birthday DATETIME,
   address VARCHAR(100),
   emaiL VARCHAR(50) NOT NULL,
   workplace VARCHAR(100),
   PRIMARY KEY ( id )
);

CREATE TABLE phone_number (
	`number` VARCHAR(11) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    `type` VARCHAR(10),
     PRIMARY KEY ( `number` ),
     FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `account` (
	id INT NOT NULL AUTO_INCREMENT,
    iban VARCHAR(22) NOT NULL,
    user_id INT NOT NULL,
    currency VARCHAR(15) NOT NULL,
    balance DOUBLE NOT NULL DEFAULT 0,
    interest DOUBLE NOT NULL DEFAULT 0,
    `type` VARCHAR(10) NOT NULL DEFAULT 'DEBIT',
    `limit`  DOUBLE,
    deadline DATETIME,
    minimum_payment DOUBLE,
     PRIMARY KEY (id ),
     FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE card(
id INT NOT NULL AUTO_INCREMENT,
    account_id INT NOT NULL,
    security_code VARCHAR(3) NOT NULL,
    pin VARCHAR(4) NOT NULL,	
     PRIMARY KEY (id ),
     FOREIGN KEY (account_id) REFERENCES `account`(id)
);

CREATE TABLE favorite_account(
	id INT NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    account_id INT NOT NULL,
     PRIMARY KEY (id ),
     FOREIGN KEY (account_id) REFERENCES `account`(id),
     FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `transaction`(
id INT NOT NULL AUTO_INCREMENT,
account_from INT NOT NULL,
account_to INT NOT NULL,
card_id INT NOT NULL,
amount DOUBLE NOT NULL DEFAULT 0,
detail VARCHAR(100),
notification_email VARCHAR(50),
currency VARCHAR(15) NOT NULL,
 PRIMARY KEY (id ),
     FOREIGN KEY (account_from) REFERENCES `account`(id),
     FOREIGN KEY (account_to) REFERENCES `account`(id),
     FOREIGN KEY (card_id) REFERENCES `card`(id)    
);

CREATE TABLE savings(
id INT NOT NULL AUTO_INCREMENT,
user_id INT NOT NULL,
currency VARCHAR(10),
`type` VARCHAR(30) NOT NULL DEFAULT 'GENERAL',
`name` VARCHAR(30) NOT NULL,
amount INT NOT NULL DEFAULT 0,
 PRIMARY KEY (id ),
FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE services(
id INT NOT NULL AUTO_INCREMENT,
user_id INT NOT NULL,
currency VARCHAR(10),
`type` VARCHAR(30) NOT NULL DEFAULT 'GENERAL',
amount INT NOT NULL DEFAULT 0,
expiration_date DATE NOT NULL,
PRIMARY KEY (id ),
FOREIGN KEY (user_id) REFERENCES `user`(id)
);