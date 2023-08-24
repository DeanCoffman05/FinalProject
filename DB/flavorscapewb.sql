-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flavorscapedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `flavorscapedb` ;

-- -----------------------------------------------------
-- Schema flavorscapedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flavorscapedb` DEFAULT CHARACTER SET utf8 ;
USE `flavorscapedb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `role` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `about_me` TEXT NULL,
  `create_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_address_idx` (`address_id` ASC),
  CONSTRAINT `fk_user_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant` ;

CREATE TABLE IF NOT EXISTS `restaurant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `restaurant_url` VARCHAR(2000) NULL,
  `image_url` VARCHAR(2000) NULL,
  `phone_number` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restaurant_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_restaurant_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu` ;

CREATE TABLE IF NOT EXISTS `menu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `enabled` TINYINT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_restaurant1_idx` (`restaurant_id` ASC),
  CONSTRAINT `fk_menu_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `menu_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu_item` ;

CREATE TABLE IF NOT EXISTS `menu_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_name` VARCHAR(45) NULL,
  `item_url` VARCHAR(2000) NULL,
  `menu_id` INT NOT NULL,
  `price` DOUBLE NULL,
  `description` VARCHAR(150) NULL,
  `calories` INT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_item_menu1_idx` (`menu_id` ASC),
  CONSTRAINT `fk_menu_item_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_review` ;

CREATE TABLE IF NOT EXISTS `restaurant_review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(2000) NULL,
  `user_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `atmosphere` TEXT NULL,
  `smell` TEXT NULL,
  `service` TEXT NULL,
  `price` TEXT NULL,
  `food` TEXT NULL,
  `rating` INT NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  INDEX `fk_review_restaurant1_idx` (`restaurant_id` ASC),
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cuisine` ;

CREATE TABLE IF NOT EXISTS `cuisine` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `icon_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `menu_item_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu_item_review` ;

CREATE TABLE IF NOT EXISTS `menu_item_review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `menu_item_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `contents` TEXT NULL,
  `item_taste` VARCHAR(500) NULL,
  `item_price` VARCHAR(45) NULL,
  `rating` INT NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_item_review_menu_item1_idx` (`menu_item_id` ASC),
  INDEX `fk_menu_item_review_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_menu_item_review_menu_item1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `menu_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `content` TEXT NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_restaurant1_idx` (`restaurant_id` ASC),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comment_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_favorite_restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_favorite_restaurant` ;

CREATE TABLE IF NOT EXISTS `user_favorite_restaurant` (
  `user_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `restaurant_id`),
  INDEX `fk_user_has_restaurant_restaurant1_idx` (`restaurant_id` ASC),
  INDEX `fk_user_has_restaurant_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_restaurant_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurant_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `menu_item_has_cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu_item_has_cuisine` ;

CREATE TABLE IF NOT EXISTS `menu_item_has_cuisine` (
  `menu_item_id` INT NOT NULL,
  `cuisine_id` INT NOT NULL,
  PRIMARY KEY (`menu_item_id`, `cuisine_id`),
  INDEX `fk_menu_item_has_cuisine_cuisine1_idx` (`cuisine_id` ASC),
  INDEX `fk_menu_item_has_cuisine_menu_item1_idx` (`menu_item_id` ASC),
  CONSTRAINT `fk_menu_item_has_cuisine_menu_item1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `menu_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_has_cuisine_cuisine1`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `cuisine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_review_ratings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_review_ratings` ;

CREATE TABLE IF NOT EXISTS `restaurant_review_ratings` (
  `user_id` INT NOT NULL,
  `restaurant_review_id` INT NOT NULL,
  `rating` INT NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  PRIMARY KEY (`user_id`, `restaurant_review_id`),
  INDEX `fk_user_has_restaurant_review_restaurant_review1_idx` (`restaurant_review_id` ASC),
  INDEX `fk_user_has_restaurant_review_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_restaurant_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurant_review_restaurant_review1`
    FOREIGN KEY (`restaurant_review_id`)
    REFERENCES `restaurant_review` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `menu_item_review_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `menu_item_review_rating` ;

CREATE TABLE IF NOT EXISTS `menu_item_review_rating` (
  `user_id` INT NOT NULL,
  `menu_item_review_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `rating` INT NULL,
  PRIMARY KEY (`user_id`, `menu_item_review_id`),
  INDEX `fk_user_has_menu_item_review_menu_item_review1_idx` (`menu_item_review_id` ASC),
  INDEX `fk_user_has_menu_item_review_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_menu_item_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_menu_item_review_menu_item_review1`
    FOREIGN KEY (`menu_item_review_id`)
    REFERENCES `menu_item_review` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment_upvote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment_upvote` ;

CREATE TABLE IF NOT EXISTS `comment_upvote` (
  `user_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `comment_id`),
  INDEX `fk_user_has_comment_comment1_idx` (`comment_id` ASC),
  INDEX `fk_user_has_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_comment_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS flavorscapeuser;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'flavorscapeuser' IDENTIFIED BY 'flavorscape';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'flavorscapeuser';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (1, '123', 'street', 'colorado springs ', 'CO', '12345', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'admin', 'John', 'Doe', 'jdoe@gmail.com', 1, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (1, 'jacobs seafood shack', NULL, NULL, NULL, 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (1, 1, 'chineese', 1, 'yum');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (1, 'tomato fancy', NULL, 1, 50, 'fancy tomato', NULL, true);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (1, NULL, 1, 1, 'soft', 'spicy', NULL, NULL, NULL, 5, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cuisine`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (1, 'chineese', 'yum', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (1, 1, 1, 'yay food', NULL, NULL, NULL, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (1, 1, 1, 'yummy yummy', NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_favorite_restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item_has_cuisine`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant_review_ratings`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (1, 1, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item_review_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (1, 1, '2023-08-15 10:23:45', '2023-08-16 09:15:30', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment_upvote`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (1, 1);

COMMIT;

