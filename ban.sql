-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bankbunny
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bankbunny
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bankbunny` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bankbunny` ;

-- -----------------------------------------------------
-- Table `bankbunny`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NULL DEFAULT NULL,
  `last_name` VARCHAR(30) NULL DEFAULT NULL,
  `age` INT NULL DEFAULT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `address` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `workplace` VARCHAR(100) NULL DEFAULT NULL,
  `auth0_id` VARCHAR(45) NOT NULL,
  `identification` VARCHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth0_id_UNIQUE` (`auth0_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `currency` VARCHAR(15) NOT NULL,
  `balance` DOUBLE NOT NULL DEFAULT '0',
  `interest` DOUBLE NOT NULL DEFAULT '0',
  `type` VARCHAR(10) NOT NULL DEFAULT 'DEBIT',
  `limit` DOUBLE NULL DEFAULT NULL,
  `deadline` DATETIME NULL DEFAULT NULL,
  `minimum_payment` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `account_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bankbunny`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`card` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `security_code` VARCHAR(3) NOT NULL,
  `pin` VARCHAR(4) NOT NULL,
  `expiration_date` DATE NOT NULL,
  `blocked` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `account_id` (`account_id` ASC) VISIBLE,
  CONSTRAINT `card_ibfk_1`
    FOREIGN KEY (`account_id`)
    REFERENCES `bankbunny`.`account` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`favorite_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`favorite_account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `account_id` (`account_id` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `favorite_account_ibfk_1`
    FOREIGN KEY (`account_id`)
    REFERENCES `bankbunny`.`account` (`id`),
  CONSTRAINT `favorite_account_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `bankbunny`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`phone_number` (
  `number` VARCHAR(11) NOT NULL,
  `user_id` INT NOT NULL,
  `type` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`number`),
  UNIQUE INDEX `number` (`number` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `phone_number_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bankbunny`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`saving`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`saving` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `currency` VARCHAR(10) NULL DEFAULT NULL,
  `type` VARCHAR(30) NOT NULL DEFAULT 'GENERAL',
  `name` VARCHAR(30) NOT NULL,
  `amount` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `saving_ibfk_1_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `saving_ibfk_1`
    FOREIGN KEY (`account_id`)
    REFERENCES `bankbunny`.`account` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `currency` VARCHAR(10) NULL DEFAULT NULL,
  `type` VARCHAR(30) NOT NULL DEFAULT 'GENERAL',
  `amount` INT NOT NULL DEFAULT '0',
  `expiration_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `service_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bankbunny`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bankbunny`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bankbunny`.`transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_to` INT NOT NULL,
  `account_from` INT NOT NULL,
  `amount` DOUBLE NOT NULL DEFAULT '0',
  `detail` VARCHAR(100) NULL DEFAULT NULL,
  `notification_email` VARCHAR(50) NULL DEFAULT NULL,
  `currency` VARCHAR(15) NOT NULL,
  `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `account_to` (`account_to` ASC) VISIBLE,
  INDEX `transaction_ibfk_3_idx` (`account_from` ASC) VISIBLE,
  CONSTRAINT `transaction_ibfk_2`
    FOREIGN KEY (`account_to`)
    REFERENCES `bankbunny`.`account` (`id`),
  CONSTRAINT `transaction_ibfk_3`
    FOREIGN KEY (`account_from`)
    REFERENCES `bankbunny`.`account` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
