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
  `latitude` VARCHAR(45) NULL,
  `longitude` VARCHAR(45) NULL,
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
  `latitude` VARCHAR(45) NULL,
  `longitude` VARCHAR(45) NULL,
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
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (1, '123', 'street', 'Denver', 'CO', '12345', 'USA', '39.7462', '-104.9253');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (2, '345', 'way', 'Denver', 'CO', '45678', 'USA', '39.7135', '-104.9128');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (3, '123 Main St', '', 'Denver', 'CO', '12345', 'USA', '39.7839', '-104.8557');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (4, '456 Oak Ave', '', 'Denver', 'CO', '54321', 'USA', '39.6765', '-104.9301');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (5, '789 Elm Rd', 'Unit 204', 'Denver', 'CO', '98765', 'USA', '39.7281', '-105.0543');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (6, '234 Pine St', '', 'Denver', 'CO', '34567', 'USA', '39.7822', '-105.0231');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (7, '567 Maple Ln', '', 'Denver', 'CO', '67890', 'USA', '39.6978', '-105.0915');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (8, '890 Cedar Ave', '', 'Denver', 'CO', '45678', 'USA', '39.7204', '-104.8745');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (9, '123 Pineapple St', 'Apartment 101', 'Denver', 'CO', '23456', 'USA', '39.6991', '-105.0652');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (10, '456 Cherry Blvd', '', 'Denver', 'CO', '76543', 'USA', '39.7790', '-104.9582');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (11, '4759 Pecan Beech', '', 'Houston', 'TX', '97539', 'USA', '30.527287981958914', '-109.55202732530454');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (12, '9429 Balsam Silk', '', 'Chicago', 'IL', '52329', 'USA', '29.757524734701207', '-123.59472567317935');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (13, '8555 Juniper Fir', '', 'Houston', 'TX', '17680', 'USA', '39.37476381188174', '-81.1473411696877');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (14, '5802 Walnut Alder', '', 'Los Angeles', 'CA', '45884', 'USA', '41.47087548849043', '-106.12975897652376');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (15, '2492 Cottonwood Hemlock', '', 'San Jose', 'CA', '51299', 'USA', '37.86744322484707', '-84.97376719855708');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (16, '8587 Mahogany Larch', '', 'Philadelphia', 'PA', '27290', 'USA', '43.807332721878424', '-92.41323432078522');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (17, '4361 Chestnut Laurel', '', 'Austin', 'TX', '62659', 'USA', '36.93362990351942', '-80.9165203199128');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (18, '1814 Larch Pine', '', 'Portland', 'OR', '76196', 'USA', '41.24684918252626', '-83.50499087989147');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (19, '8285 Magnolia Redwood', '', 'Washington', 'DC', '44863', 'USA', '47.521245090748096', '-89.76331017068308');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (20, '9502 Sequoia Spruce', '', 'Austin', 'TX', '62624', 'USA', '46.81909009320087', '-104.16442183769786');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (21, '3351 Chestnut Yew', '', 'El Paso', 'TX', '40283', 'USA', '33.71878446399778', '-69.44660971549082');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (22, '2527 Holly Cypress', '', 'San Jose', 'CA', '24359', 'USA', '38.66819249952212', '-78.77419015339532');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (23, '2139 Sequoia Teak', '', 'Portland', 'OR', '27566', 'USA', '27.92877627690104', '-92.87055277465394');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (24, '6261 Alder Chestnut', '', 'San Jose', 'CA', '88992', 'USA', '27.156434294770964', '-82.03465033892877');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (25, '1532 Chestnut Rowan', '', 'Fort Worth', 'TX', '29087', 'USA', '44.4637397869797', '-83.66610434840237');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (26, '5454 Sequoia Sycamore', '', 'Austin', 'TX', '64084', 'USA', '29.869058740454737', '-111.55338210363726');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (27, '8450 Elm Juniper', '', 'Austin', 'TX', '90323', 'USA', '46.011548827032414', '-124.19880802824356');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (28, '5602 Sycamore Birch', '', 'Jacksonville', 'FL', '48768', 'USA', '29.675270537537948', '-115.36733119518483');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (29, '4333 Ash Birch', '', 'Las Vegas', 'NV', '09407', 'USA', '24.518214915524332', '-102.59032923237822');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (30, '4847 Ironwood Walnut', '', 'Charlotte', 'NC', '93831', 'USA', '37.32542599368054', '-93.42814443849784');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (31, '9591 Mango Pine', '', 'Jacksonville', 'FL', '28533', 'USA', '29.106302749193926', '-108.12820411549903');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (32, '3878 Rowan Cedar', '', 'Portland', 'OR', '60960', 'USA', '39.309176485189305', '-89.52532919040499');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (33, '7259 Balsam Pear', '', 'Chicago', 'IL', '18266', 'USA', '25.98038237932574', '-118.11665601623638');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (34, '7041 Sequoia Juniper', '', 'Boston', 'MA', '47928', 'USA', '27.481077155954736', '-89.77724583070336');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (35, '6324 Sequoia Juniper', '', 'Dallas', 'TX', '61452', 'USA', '47.74142271121313', '-118.17964001631356');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (36, '3057 Laurel Holly', '', 'Portland', 'OR', '05119', 'USA', '37.669062465005354', '-71.18472438775234');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (37, '4450 Silk Tamarack', '', 'Boston', 'MA', '01595', 'USA', '41.41398458684261', '-120.38368655901307');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (38, '3844 Oak Ash', '', 'San Francisco', 'CA', '41328', 'USA', '47.220648637262464', '-97.30461294912138');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (39, '3090 Mango Oak', '', 'Dallas', 'TX', '34571', 'USA', '31.065647788533166', '-79.08630397544204');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (40, '1671 Palm Balsam', '', 'Nashville', 'TN', '80345', 'USA', '42.05981439649852', '-102.06449435017983');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (41, '2547 Pear Basswood', '', 'Fort Worth', 'TX', '97599', 'USA', '41.099396429975684', '-97.05831470634529');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (42, '2384 Willow Larch', '', 'Denver', 'CO', '80600', 'USA', '38.719464751332254', '-109.81131459239637');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (43, '1069 Mahogany Blackwood', '', 'Philadelphia', 'PA', '91422', 'USA', '40.26715130968505', '-109.57191235119286');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (44, '8977 Birch Willow', '', 'Indianapolis', 'IN', '81501', 'USA', '40.87935277694704', '-73.46835043684187');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (45, '3622 Blackwood Cedar', '', 'Portland', 'OR', '03790', 'USA', '30.44219549208366', '-80.07374837340944');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (46, '6639 Olive Cedar', '', 'San Jose', 'CA', '97145', 'USA', '37.789274181619085', '-119.2545974761823');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (47, '3052 Poplar Teak', '', 'Columbus', 'OH', '92294', 'USA', '33.20596555047017', '-73.5924956347638');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (48, '1600 Redwood Poplar', '', 'Phoenix', 'AZ', '51919', 'USA', '47.336341444804475', '-72.18652443681916');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (49, '437 Maple Magnolia', '', 'Portland', 'OR', '97044', 'USA', '36.80752224785871', '-113.34190158531996');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (50, '9039 Mahogany Sequoia', '', 'Dallas', 'TX', '97456', 'USA', '34.49501940131834', '-101.48488881664446');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (51, '8594 Cottonwood Blackwood', '', 'Nashville', 'TN', '59015', 'USA', '25.92784886326735', '-88.53171163192465');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (52, '1321 Mahogany Cherry', '', 'Las Vegas', 'NV', '28487', 'USA', '34.13652176203472', '-93.08533747698587');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (53, '1334 Beech Mango', '', 'Portland', 'OR', '46811', 'USA', '46.53793635427555', '-80.88549369197317');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (54, '7366 Mahogany Mango', '', 'New York', 'NY', '99557', 'USA', '32.82779969474779', '-121.69337129743171');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (55, '8271 Ash Larch', '', 'San Antonio', 'TX', '85485', 'USA', '47.11452333298173', '-91.25691763515115');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (56, '4234 Birch Cottonwood', '', 'San Jose', 'CA', '03196', 'USA', '37.46938226132432', '-115.88615896412762');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (57, '1345 Blackwood Holly', '', 'Portland', 'OR', '07718', 'USA', '49.16619098530073', '-115.09787725673192');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (58, '3818 Plum Willow', '', 'Washington', 'DC', '27221', 'USA', '45.02380355062274', '-98.13151507125986');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (59, '5711 Pecan Elm', '', 'Nashville', 'TN', '66903', 'USA', '39.375173953741495', '-110.17846917152157');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (60, '2789 Juniper Elm', '', 'Denver', 'CO', '32322', 'USA', '40.23732985771242', '-105.81481118076076');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (61, '1254 grove cedar', '', 'Denver', 'CO', '25632', 'USA', '39.619466', '-104.780169');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (62, '6160 Blackwood Teak', '', 'Las Vegas', 'NV', '76517', 'USA', '32.05385158105224', '-86.87624696631319');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (63, '5673 Silk Cypress', '', 'Phoenix', 'AZ', '68226', 'USA', '30.020979444328745', '-99.65934691521838');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (64, '4196 Alder Ironwood', '', 'Boston', 'MA', '44081', 'USA', '32.55780424551187', '-92.18320251942163');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (65, '9203 Pear Birch', '', 'Las Vegas', 'NV', '49019', 'USA', '48.77390347665734', '-116.23901331754008');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (66, '225 Larch Walnut', '', 'Jacksonville', 'FL', '82579', 'USA', '35.90724250733186', '-91.45867258371986');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (67, '5117 Blackwood Alder', '', 'San Jose', 'CA', '10488', 'USA', '40.42211566394599', '-90.76764483855942');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (68, '3879 Dogwood Hemlock', '', 'San Jose', 'CA', '25672', 'USA', '32.15922431614808', '-97.00247858705703');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (69, '1691 Mahogany Palm', '', 'Indianapolis', 'IN', '81565', 'USA', '28.571917233093924', '-81.73747414989943');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (70, '3464 Zelkova Teak', '', 'Las Vegas', 'NV', '49828', 'USA', '48.90253486331969', '-80.85672739600098');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (71, '2061 Spruce Magnolia', '', 'Washington', 'DC', '62858', 'USA', '32.267734082805475', '-89.98692460735595');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (72, '1126 Hickory Silk', '', 'Fort Worth', 'TX', '49993', 'USA', '26.476369780029952', '-87.13016715552352');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (73, '4423 Sycamore Maple', '', 'San Antonio', 'TX', '61875', 'USA', '35.19866078160589', '-114.64375853628968');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (74, '7613 Birch Olive', '', 'Houston', 'TX', '79410', 'USA', '29.456262895408013', '-109.7992083684714');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (75, '7872 Beech Olive', '', 'Washington', 'DC', '53556', 'USA', '24.616332043913435', '-84.77770845690742');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (76, '9573 Aspen Hickory', '', 'San Jose', 'CA', '35256', 'USA', '32.59895722893655', '-102.21443189585261');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (77, '1259 Oak Larch', '', 'Washington', 'DC', '17225', 'USA', '36.75203314768131', '-71.01311657136013');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (78, '4377 Aspen Willow', '', 'Charlotte', 'NC', '95340', 'USA', '45.497567313137516', '-100.23042837447551');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (79, '1055 Sequoia Mahogany', '', 'San Jose', 'CA', '85689', 'USA', '40.19150401143648', '-106.15094688006947');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (80, '2326 Pewter Silk', '', 'El Paso', 'TX', '23216', 'USA', '40.04138598607256', '-85.8697981679114');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (81, '9120 Blackwood Fir', '', 'Houston', 'TX', '46516', 'USA', '26.812063261896785', '-124.18354432591298');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (82, '387 Hickory Oak', '', 'Jacksonville', 'FL', '33709', 'USA', '38.33135159809872', '-98.25390379320876');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (83, '8423 Redwood Mango', '', 'El Paso', 'TX', '67010', 'USA', '30.376441588379226', '-100.50902031161753');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (84, '3490 Dogwood Pine', '', 'Boston', 'MA', '65059', 'USA', '48.287181914405124', '-119.06395023775248');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (85, '8029 Mango Birch', '', 'Portland', 'OR', '39015', 'USA', '41.55835643507446', '-87.41744216963104');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (86, '501 Maple Sequoia', '', 'Houston', 'TX', '19916', 'USA', '37.390965439513664', '-94.25390605035018');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (87, '7606 Basswood Cedar', '', 'Phoenix', 'AZ', '83145', 'USA', '30.241324827346975', '-84.51163448139022');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (88, '153 Linden Laurel', '', 'Fort Worth', 'TX', '95355', 'USA', '47.72290161216857', '-78.5954322473142');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (89, '9197 Sequoia Tamarack', '', 'Portland', 'OR', '26551', 'USA', '26.382426611714205', '-93.82812461343329');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (90, '9256 Pewter Teak', '', 'Dallas', 'TX', '81322', 'USA', '43.49010244391353', '-124.90676850119735');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (91, '271 Mango Beech', '', 'New York', 'NY', '00841', 'USA', '24.77456523596799', '-98.87711694137104');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (92, '7173 Dogwood Elm', '', 'Las Vegas', 'NV', '96679', 'USA', '41.819578372306', '-72.23036931143596');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (93, '3536 Walnut Alder', '', 'Jacksonville', 'FL', '34137', 'USA', '45.227657951459236', '-71.2286228603761');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (94, '2833 Linden Maple', '', 'Philadelphia', 'PA', '22212', 'USA', '46.88116957357133', '-97.96983141371541');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (95, '5942 Hickory Poplar', '', 'Columbus', 'OH', '51464', 'USA', '43.11551543354193', '-106.15681930407499');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (96, '3439 Balsam Cherry', '', 'Houston', 'TX', '99807', 'USA', '29.087227519874187', '-113.21583527229187');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (97, '3998 Mahogany Walnut', '', 'Chicago', 'IL', '45920', 'USA', '48.47487105839855', '-118.47359647754553');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (98, '2800 Walnut Mango', '', 'Charlotte', 'NC', '56179', 'USA', '25.82133376136199', '-74.36986510901');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (99, '1627 Hickory Palm', '', 'Columbus', 'OH', '40266', 'USA', '34.237601920741284', '-70.6573181505446');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (100, '9838 Aspen Mango', '', 'Houston', 'TX', '39219', 'USA', '27.97355312009497', '-88.04821468559844');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (101, '7262 Palm Alder', '', 'Las Vegas', 'NV', '12372', 'USA', '25.877307050417084', '-123.57873074949266');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (102, '5257 Yew Teak', '', 'Jacksonville', 'FL', '43201', 'USA', '44.43742742377549', '-78.23423468998877');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (103, '9932 Hemlock Fir', '', 'Nashville', 'TN', '21087', 'USA', '42.11167658743818', '-100.68077192919404');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (104, '6833 Palm Olive', '', 'Portland', 'OR', '54886', 'USA', '46.15588973986269', '-104.77378996068039');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (105, '4138 Pine Pear', '', 'San Francisco', 'CA', '96497', 'USA', '34.429562610821684', '-117.47602949271852');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (106, '6485 Pewter Basswood', '', 'Chicago', 'IL', '39080', 'USA', '29.704649402608247', '-119.10652990807196');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (107, '4797 Zelkova Magnolia', '', 'Philadelphia', 'PA', '75628', 'USA', '38.9097717681912', '-106.60178683736109');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (108, '4370 Tamarack Walnut', '', 'Charlotte', 'NC', '84754', 'USA', '42.72312626221894', '-122.48177433185283');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (109, '6232 Elm Cedar', '', 'Jacksonville', 'FL', '53669', 'USA', '30.68923087324161', '-72.62386709096678');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (110, '1179 Plum Birch', '', 'Fort Worth', 'TX', '42100', 'USA', '44.00074350758573', '-108.28799729537035');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (111, '1543 Pine Pecan', '', 'Houston', 'TX', '92878', 'USA', '35.37629831611176', '-122.77088010096188');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (112, '7526 Cottonwood Birch', '', 'Houston', 'TX', '05729', 'USA', '49.31078331870101', '-76.56563330729091');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (113, '2506 Pear Balsam', '', 'Los Angeles', 'CA', '16882', 'USA', '44.11146890177176', '-105.99522621080624');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (114, '2202 Redwood Teak', '', 'San Antonio', 'TX', '03500', 'USA', '42.32614135178072', '-71.78424625920368');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (115, '2503 Sycamore Cedar', '', 'Dallas', 'TX', '38630', 'USA', '29.653578410850866', '-90.85951662641179');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (116, '1414 Alder Poplar', '', 'Indianapolis', 'IN', '21981', 'USA', '38.07433812794265', '-112.83090596138291');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (117, '6128 Beech Teak', '', 'New York', 'NY', '45510', 'USA', '44.609799559200326', '-119.28314448840744');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (118, '721 Plum Walnut', '', 'Houston', 'TX', '52836', 'USA', '36.05827506628225', '-105.70123064075324');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (119, '4375 Ironwood Maple', '', 'Charlotte', 'NC', '89075', 'USA', '32.04771492891516', '-77.0501169825946');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (120, '3298 Fir Pear', '', 'El Paso', 'TX', '73410', 'USA', '41.51230725270714', '-82.67075963795622');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (121, '8061 Redwood Juniper', '', 'Philadelphia', 'PA', '95482', 'USA', '45.41955443053011', '-75.04612701496988');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (122, '4082 Cottonwood Linden', '', 'Chicago', 'IL', '93180', 'USA', '48.35831933461264', '-97.48094897595614');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (123, '9889 Spruce Chestnut', '', 'San Francisco', 'CA', '23323', 'USA', '41.80750944193934', '-119.93267098395746');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (124, '8200 Ironwood Oak', '', 'Nashville', 'TN', '41220', 'USA', '37.63736147929397', '-102.66603773412253');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (125, '7071 Cottonwood Beech', '', 'Indianapolis', 'IN', '31357', 'USA', '25.187381336635255', '-113.15644339081432');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (126, '3710 Chestnut Mahogany', '', 'San Jose', 'CA', '29329', 'USA', '30.384526479840392', '-75.41605973459238');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (127, '6378 Poplar Pewter', '', 'San Francisco', 'CA', '38603', 'USA', '44.09492543869968', '-85.80517502112983');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (128, '6678 Ash Laurel', '', 'Chicago', 'IL', '43405', 'USA', '25.648728279511165', '-68.08915658938608');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (129, '8614 Linden Pear', '', 'Denver', 'CO', '96017', 'USA', '35.87485201169054', '-119.18534272298723');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (130, '9284 Palm Rowan', '', 'Houston', 'TX', '09832', 'USA', '42.54032348403536', '-90.77980923602745');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (131, '7067 Sycamore Teak', '', 'Denver', 'CO', '46463', 'USA', '32.64119902939906', '-93.60868986504353');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (132, '5313 Maple Plum', '', 'Houston', 'TX', '84450', 'USA', '43.550736026803555', '-96.41890432319181');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (133, '8277 Pear Laurel', '', 'Portland', 'OR', '68952', 'USA', '25.089882200674488', '-69.92930763884158');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (134, '2168 Pine Rowan', '', 'Boston', 'MA', '55319', 'USA', '37.024675743117896', '-85.43634561081795');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (135, '8362 Redwood Pecan', '', 'Houston', 'TX', '34178', 'USA', '43.08635708547409', '-93.70630836005503');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (136, '7215 Tamarack Sycamore', '', 'Los Angeles', 'CA', '79025', 'USA', '32.08707237495586', '-67.49011713886128');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (137, '3547 Redwood Laurel', '', 'Phoenix', 'AZ', '07598', 'USA', '45.38757383172025', '-69.42255794592228');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (138, '5997 Hemlock Basswood', '', 'Dallas', 'TX', '35419', 'USA', '36.66664142955159', '-114.23209524418523');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (139, '6508 Silk Olive', '', 'Indianapolis', 'IN', '05446', 'USA', '45.004855143131564', '-110.24771053215969');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (140, '8347 Beech Blackwood', '', 'Boston', 'MA', '77714', 'USA', '48.78051421191673', '-101.8360102412285');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (141, '5302 Plum Hemlock', '', 'Denver', 'CO', '95417', 'USA', '30.44846715232787', '-96.8052467620026');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (142, '231 Silk Hemlock', '', 'Columbus', 'OH', '10639', 'USA', '26.251172859770264', '-111.83096803490301');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (143, '9413 Dogwood Maple', '', 'Portland', 'OR', '08088', 'USA', '46.13978845384905', '-76.58193076525171');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (144, '6493 Ironwood Hemlock', '', 'New York', 'NY', '08501', 'USA', '31.76598744221485', '-109.65693429117576');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (145, '1277 Cherry Teak', '', 'Las Vegas', 'NV', '90161', 'USA', '35.40130086090097', '-117.54216199901715');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (146, '9035 Poplar Pecan', '', 'Indianapolis', 'IN', '71543', 'USA', '25.14922495648649', '-68.17963236592085');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (147, '147 Yew Holly', '', 'Chicago', 'IL', '10490', 'USA', '39.95948771153899', '-75.04736978160545');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (148, '6765 Dogwood Palm', '', 'Chicago', 'IL', '40089', 'USA', '32.39364149710309', '-73.48130151206989');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (149, '7333 Balsam Chestnut', '', 'Indianapolis', 'IN', '22649', 'USA', '30.808276335103578', '-81.19623394532096');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (150, '5725 Cottonwood Zelkova', '', 'Dallas', 'TX', '52018', 'USA', '32.8711049329022', '-108.69380030850297');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (151, '8350 Laurel Cedar', '', 'Indianapolis', 'IN', '21279', 'USA', '26.30590863194774', '-101.89645574629878');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (152, '5305 Pecan Basswood', '', 'Charlotte', 'NC', '36542', 'USA', '42.00709844622638', '-122.5025601202398');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (153, '4135 Cherry Pewter', '', 'Philadelphia', 'PA', '65928', 'USA', '25.436646935698114', '-99.5012095984664');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (154, '4990 Oak Willow', '', 'Nashville', 'TN', '23999', 'USA', '38.149718740458724', '-124.70212835373171');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (155, '825 Holly Poplar', '', 'New York', 'NY', '53422', 'USA', '27.155936449628985', '-102.94852617668326');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (156, '9323 Pewter Beech', '', 'San Jose', 'CA', '69881', 'USA', '47.17608371229639', '-79.26004152159595');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (157, '1515 Tamarack Holly', '', 'Boston', 'MA', '89134', 'USA', '47.818764740228445', '-105.88132378356109');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (158, '6403 Yew Linden', '', 'Jacksonville', 'FL', '62273', 'USA', '26.323164022325834', '-80.92689901793841');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (159, '4968 Pewter Tamarack', '', 'Indianapolis', 'IN', '45692', 'USA', '43.94724311744156', '-99.85552859385135');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (160, '2007 Cherry Linden', '', 'Boston', 'MA', '45894', 'USA', '32.03133883971976', '-100.37183937283218');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (161, '3277 Blackwood Linden', '', 'Charlotte', 'NC', '31094', 'USA', '38.34770678246965', '-124.1582114917425');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'admin', 'John', 'Doe', 'jdoe@gmail.com', 1, NULL, 'just a silly goofy', '2023-08-27 11:00:00', '34.733862', '-105.680433');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (2, 'Alice123', '$2a$10$KQgnO0rrm.hjSb5bm6eTOe3q3AeM6tx5MZWG1yxweIMXmGs6pgA6K', true, 'admin', 'Alice', 'Johnson', 'alice@example.com', 2, 'http://fakeurl.com/alice.jpg', 'Passionate about coding and coffee', '2023-08-27 10:15:00', '38.514364', '-110.765645');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (3, 'Bob456', '$2a$10$VH9aQBsEKf5cW4TjUdG2lOoVmXw0tS3b0lF6EGeqV9ZrVlty3RGWm', true, 'user', 'Bob', 'Smith', 'bob@example.com', 3, 'http://fakeurl.com/bob.jpg', 'Adventurer and book lover', '2023-08-26 14:30:00', '37.861189', '-121.984608');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (4, 'Charlie789', '$2a$10$FLCvj5HXphZS6EojK4FZIu1mN4UePmeOTiJl/EhEUCp5X8pB1zJXm', true, 'user', 'Charlie', 'Brown', 'charlie@example.com', 4, 'http://fakeurl.com/charlie.jpg', 'Foodie at heart', '2023-08-25 09:45:00', '44.694011', '-123.162729');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (5, 'David987', '$2a$10$X65NzNOeqoOHj4jp5jSxIuKQCMUbTmf9Eg5Fjx3aHIlrXcDV5uv9O', true, 'user', 'David', 'Miller', 'david@example.com', 5, 'http://fakeurl.com/david.jpg', 'Music is life', '2023-08-24 18:20:00', '38.854244', '-105.049779');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (6, 'William01', '$2a$10$Y7vRuTtVdc.I81C6ffD6mOxVT0v4Zw6iBCChLQabqz4hqFdjLsDD6', true, 'user', 'William', 'Johnson', 'william@example.com', 6, 'http://fakeurl.com/william.jpg', 'Explorer of nature and wildlife', '2023-08-18 19:25:00', '31.737163', '-98.739461');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (7, 'Maximus34', '$2a$10$Ur.PcAHusntaK08LB9y.KufAKU9Xa.Nb3YPmQg2hvBtJBJVlw6j5i', true, 'user', 'Maximus', 'Smith', 'maximus@example.com', 7, 'http://fakeurl.com/maximus.jpg', 'Adventurer with a love for the outdoors', '2023-08-26 09:45:00', '33.800536', '-83.946143');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (8, 'Olivia87', '$2a$10$EQLKcFGKpLO3b/jH0/W1..aXrJHroPsTqGwN1rCO0WEg7yTrQ3TDe', true, 'user', 'Olivia', 'Brown', 'olivia@example.com', 8, 'http://fakeurl.com/olivia.jpg', 'Bookworm and tea enthusiast', '2023-08-25 12:15:00', '35.841274', '-78.417964');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (9, 'Leo123', '$2a$10$qJTptnD2bwg.sq2bUCRuj.59m0dwwgrsI5N9z/9aSxOorWpOwv.kG', true, 'user', 'Leo', 'Miller', 'leo@example.com', 9, 'http://fakeurl.com/leo.jpg', 'Music lover and aspiring guitarist', '2023-08-24 14:20:00', '28.051661', '-81.484664');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (10, 'Ava456', '$2a$10$az4pIK7qPVq7b/cnPG2Zr.Z9Zi7p9DZ4Pqr7gEmO5uSfZ7FfUn0nW', true, 'user', 'Ava', 'Johnson', 'ava@example.com', 10, 'http://fakeurl.com/ava.jpg', 'Foodie exploring flavors from around the world', '2023-08-23 17:10:00', '32.640416', '-86.396264');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (11, 'alyssa45', 'hNMeS', true, 'user', 'Alyssa', 'Alex', 'alyssa.alex@yahoo.com', 11, 'http://fakeimages.com/alyssa_alex.jpg', 'creative honest professional knowledgeable.', '2023-08-28 17:58:16', '24.585979704375077', '-100.15655903667111');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (12, 'nicholas50', 'NDKMd', true, 'user', 'Nicholas', 'Sarah', 'nicholas.sarah@yahoo.com', 12, 'http://fakeimages.com/nicholas_sarah.jpg', 'patient smart passionate foodie open-minded.', '2023-08-28 17:58:16', '35.06372658773288', '-99.74720718499823');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (13, 'samuel10', 'cck3b', true, 'user', 'Samuel', 'Kayla', 'samuel.kayla@yahoo.com', 13, 'http://fakeimages.com/samuel_kayla.jpg', 'patient ambitious supportive passionate trustworthy.', '2023-08-28 17:58:16', '40.211269024899316', '-75.53629977600164');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (14, 'jacob24', 'N7ods', true, 'user', 'Jacob', 'Megan', 'jacob.megan@yahoo.com', 14, 'http://fakeimages.com/jacob_megan.jpg', 'genuine athletic dog-lover.', '2023-08-28 17:58:16', '37.29905382637888', '-74.65583624489031');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (15, 'sarah16', 'avgFs', true, 'user', 'Sarah', 'John', 'sarah.john@gmail.com', 15, 'http://fakeimages.com/sarah_john.jpg', 'committed passionate meticulous foodie easy-going.', '2023-08-28 17:58:16', '39.45593306494423', '-108.69328727289509');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (16, 'jonathan58', 'NEW9k', true, 'user', 'Jonathan', 'Samuel', 'jonathan.samuel@yahoo.com', 16, 'http://fakeimages.com/jonathan_samuel.jpg', 'musician meticulous nature-lover passionate motivated open-minded.', '2023-08-28 17:58:16', '37.59323652618055', '-67.35261422312993');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (17, 'nathan20', '8NnGQ', true, 'user', 'Nathan', 'Justin', 'nathan.justin@yahoo.com', 17, 'http://fakeimages.com/nathan_justin.jpg', 'innovative musician funny intelligent nature-lover.', '2023-08-28 17:58:16', '44.917612029604', '-86.68644207422211');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (18, 'john27', 'PjMTf', true, 'user', 'John', 'Brianna', 'john.brianna@hotmail.com', 18, 'http://fakeimages.com/john_brianna.jpg', 'sincere supportive patient.', '2023-08-28 17:58:16', '44.641692411628505', '-116.49627358049503');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (19, 'ryan96', '2lccz', true, 'user', 'Ryan', 'Heather', 'ryan.heather@hotmail.com', 19, 'http://fakeimages.com/ryan_heather.jpg', 'foodie adventurous supportive outgoing genuine intelligent.', '2023-08-28 17:58:16', '32.11559352747053', '-106.8012995704721');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (20, 'lauren73', 'Gmpfo', true, 'user', 'Lauren', 'Nathan', 'lauren.nathan@hotmail.com', 20, 'http://fakeimages.com/lauren_nathan.jpg', 'tech-savvy ambitious dedicated supportive.', '2023-08-28 17:58:16', '38.321095988441506', '-75.67726045118232');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (21, 'tyler45', 'hT37n', true, 'user', 'Tyler', 'Nathan', 'tyler.nathan@hotmail.com', 21, 'http://fakeimages.com/tyler_nathan.jpg', 'thoughtful passionate friendly loyal.', '2023-08-28 17:58:16', '36.14937885275977', '-102.01683919889949');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (22, 'hannah49', 'QRUwq', true, 'user', 'Hannah', 'Megan', 'hannah.megan@gmail.com', 22, 'http://fakeimages.com/hannah_megan.jpg', 'talented honest determined professional tech-savvy dog-lover.', '2023-08-28 17:58:16', '38.67763879537266', '-118.95423864533149');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (23, 'victoria44', 'lk5GJ', true, 'user', 'Victoria', 'Amanda', 'victoria.amanda@yahoo.com', 23, 'http://fakeimages.com/victoria_amanda.jpg', 'responsible tech-savvy easy-going genuine.', '2023-08-28 17:58:16', '48.998374825287456', '-74.52042429647392');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (24, 'dylan45', '8hGBW', true, 'user', 'Dylan', 'Daniel', 'dylan.daniel@yahoo.com', 24, 'http://fakeimages.com/dylan_daniel.jpg', 'down-to-earth caring supportive.', '2023-08-28 17:58:16', '42.587541220951934', '-67.03111155959846');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (25, 'jessica96', 'izIGH', true, 'user', 'Jessica', 'Megan', 'jessica.megan@yahoo.com', 25, 'http://fakeimages.com/jessica_megan.jpg', 'confident innovative loyal.', '2023-08-28 17:58:16', '33.860732395938186', '-117.507940818589');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (26, 'taylor62', 'fvgIC', true, 'user', 'Taylor', 'Jessica', 'taylor.jessica@hotmail.com', 26, 'http://fakeimages.com/taylor_jessica.jpg', 'dedicated caring funny professional outgoing.', '2023-08-28 17:58:16', '40.4251383402481', '-109.07371277667337');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (27, 'samuel27', 'w16My', true, 'user', 'Samuel', 'James', 'samuel.james@yahoo.com', 27, 'http://fakeimages.com/samuel_james.jpg', 'sincere supportive smart thoughtful enthusiastic open-minded.', '2023-08-28 17:58:16', '46.64695878046611', '-116.66897126544774');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (28, 'rachel94', 'UHucR', true, 'user', 'Rachel', 'Joseph', 'rachel.joseph@hotmail.com', 28, 'http://fakeimages.com/rachel_joseph.jpg', 'tech-savvy enthusiastic dedicated hard-working professional.', '2023-08-28 17:58:16', '48.48410199054622', '-82.0446076839628');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (29, 'daniel13', 'eg6px', true, 'user', 'Daniel', 'Amanda', 'daniel.amanda@yahoo.com', 29, 'http://fakeimages.com/daniel_amanda.jpg', 'hard-working reliable determined.', '2023-08-28 17:58:16', '37.18701965675181', '-101.1276350725719');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (30, 'jonathan71', 'dyPV2', true, 'user', 'Jonathan', 'Jacob', 'jonathan.jacob@yahoo.com', 30, 'http://fakeimages.com/jonathan_jacob.jpg', 'innovative talented ambitious committed.', '2023-08-28 17:58:16', '40.94867922398609', '-116.16466892946771');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (31, 'amanda37', 'w2aHB', true, 'user', 'Amanda', 'Courtney', 'amanda.courtney@gmail.com', 31, 'http://fakeimages.com/amanda_courtney.jpg', 'supportive musician motivated creative down-to-earth determined.', '2023-08-28 17:58:16', '47.26074752722392', '-98.4518666582745');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (32, 'hannah33', 'Fywh2', true, 'user', 'Hannah', 'James', 'hannah.james@hotmail.com', 32, 'http://fakeimages.com/hannah_james.jpg', 'respectful responsible curious nature-lover determined genuine.', '2023-08-28 17:58:16', '26.97932093311346', '-87.4074893962345');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (33, 'brandon20', 'eReUg', true, 'user', 'Brandon', 'Elizabeth', 'brandon.elizabeth@hotmail.com', 33, 'http://fakeimages.com/brandon_elizabeth.jpg', 'adventurous honest innovative easy-going smart.', '2023-08-28 17:58:16', '28.628652313000135', '-79.4191484822449');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (34, 'kayla76', 'GSnEn', true, 'user', 'Kayla', 'Andrew', 'kayla.andrew@yahoo.com', 34, 'http://fakeimages.com/kayla_andrew.jpg', 'motivated outgoing supportive.', '2023-08-28 17:58:16', '30.615060547636638', '-81.37731520280789');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (35, 'ashley25', 'T6W7s', true, 'user', 'Ashley', 'Courtney', 'ashley.courtney@hotmail.com', 35, 'http://fakeimages.com/ashley_courtney.jpg', 'ambitious optimistic patient honest adventurous.', '2023-08-28 17:58:16', '34.91847786167214', '-108.08155073875058');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (36, 'megan18', 'G7E35', true, 'user', 'Megan', 'Zachary', 'megan.zachary@yahoo.com', 36, 'http://fakeimages.com/megan_zachary.jpg', 'adventurous responsible hard-working talented open-minded passionate.', '2023-08-28 17:58:16', '32.234896673056475', '-110.53755238496905');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (37, 'brandon55', 'QZqVj', true, 'user', 'Brandon', 'Joseph', 'brandon.joseph@yahoo.com', 37, 'http://fakeimages.com/brandon_joseph.jpg', 'dynamic honest energetic talented ambitious.', '2023-08-28 17:58:16', '47.88929369959718', '-80.03180807845581');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (38, 'matthew24', 'u1GHE', true, 'user', 'Matthew', 'Rachel', 'matthew.rachel@gmail.com', 38, 'http://fakeimages.com/matthew_rachel.jpg', 'confident supportive innovative musician loyal.', '2023-08-28 17:58:16', '29.268473415157715', '-80.1021439600507');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (39, 'emily50', 'XRDlP', true, 'user', 'Emily', 'Lauren', 'emily.lauren@gmail.com', 39, 'http://fakeimages.com/emily_lauren.jpg', 'hard-working easy-going dynamic determined trustworthy.', '2023-08-28 17:58:16', '45.35056934246141', '-90.89743842398137');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (40, 'joseph44', 'uP4Gb', true, 'user', 'Joseph', 'Jasmine', 'joseph.jasmine@yahoo.com', 40, 'http://fakeimages.com/joseph_jasmine.jpg', 'respectful committed tech-savvy patient genuine.', '2023-08-28 17:58:16', '37.95084641884082', '-105.90281477735022');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (41, 'taylor12', 'a903l', true, 'user', 'Taylor', 'Christopher', 'taylor.christopher@gmail.com', 41, 'http://fakeimages.com/taylor_christopher.jpg', 'intelligent easy-going athletic friendly tech-savvy.', '2023-08-28 17:58:16', '39.9392459285367', '-91.56640934560423');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (42, 'taylor21', 'nOYKe', true, 'user', 'Taylor', 'Zachary', 'taylor.zachary@gmail.com', 42, 'http://fakeimages.com/taylor_zachary.jpg', 'generous dedicated kind innovative outgoing thoughtful.', '2023-08-28 17:58:16', '39.97496612051397', '-72.19960784221072');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (43, 'brandon62', 'nsypW', true, 'user', 'Brandon', 'Hannah', 'brandon.hannah@hotmail.com', 43, 'http://fakeimages.com/brandon_hannah.jpg', 'foodie down-to-earth innovative genuine respectful loyal.', '2023-08-28 17:58:16', '38.436290174093585', '-102.80276172791955');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (44, 'tyler13', 'tm3Y0', true, 'user', 'Tyler', 'Kayla', 'tyler.kayla@gmail.com', 44, 'http://fakeimages.com/tyler_kayla.jpg', 'talented honest traveler dynamic dog-lover.', '2023-08-28 17:58:16', '37.16026362415869', '-88.32897237611257');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (45, 'tyler50', '471Am', true, 'user', 'Tyler', 'Danielle', 'tyler.danielle@hotmail.com', 45, 'http://fakeimages.com/tyler_danielle.jpg', 'responsible confident enthusiastic dynamic foodie.', '2023-08-28 17:58:16', '43.046765330374384', '-100.02659142952533');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (46, 'hannah40', 'Iez1i', true, 'user', 'Hannah', 'Ashley', 'hannah.ashley@hotmail.com', 46, 'http://fakeimages.com/hannah_ashley.jpg', 'loyal determined enthusiastic.', '2023-08-28 17:58:16', '45.37293489907617', '-120.25790550578148');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (47, 'ryan87', 'dGxqG', true, 'user', 'Ryan', 'Heather', 'ryan.heather@yahoo.com', 47, 'http://fakeimages.com/ryan_heather.jpg', 'easy-going traveler funny.', '2023-08-28 17:58:16', '43.86999054079965', '-108.42549791412073');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (48, 'alyssa10', 'AsJhJ', true, 'user', 'Alyssa', 'Heather', 'alyssa.heather@hotmail.com', 48, 'http://fakeimages.com/alyssa_heather.jpg', 'dedicated reliable trustworthy smart easy-going.', '2023-08-28 17:58:16', '37.81786433567063', '-93.53674034186767');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (49, 'james88', 'lH4D9', true, 'user', 'James', 'Samuel', 'james.samuel@gmail.com', 49, 'http://fakeimages.com/james_samuel.jpg', 'knowledgeable dynamic motivated.', '2023-08-28 17:58:16', '48.4695032782262', '-119.1965446426177');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (50, 'elizabeth19', 'HsjyO', true, 'user', 'Elizabeth', 'Sarah', 'elizabeth.sarah@gmail.com', 50, 'http://fakeimages.com/elizabeth_sarah.jpg', 'tech-savvy knowledgeable funny friendly.', '2023-08-28 17:58:16', '40.00990559391465', '-113.99770723808454');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (51, 'elizabeth87', 'UFHiW', true, 'user', 'Elizabeth', 'Courtney', 'elizabeth.courtney@gmail.com', 51, 'http://fakeimages.com/elizabeth_courtney.jpg', 'passionate innovative patient genuine sincere.', '2023-08-28 17:58:16', '26.49051393706425', '-101.15858444277592');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (52, 'robert58', 'd4iZL', true, 'user', 'Robert', 'Alex', 'robert.alex@gmail.com', 52, 'http://fakeimages.com/robert_alex.jpg', 'open-minded dedicated sincere.', '2023-08-28 17:58:16', '43.7506744533347', '-90.4844880373769');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (53, 'alexis56', 'pJQOm', true, 'user', 'Alexis', 'Courtney', 'alexis.courtney@yahoo.com', 53, 'http://fakeimages.com/alexis_courtney.jpg', 'thoughtful sincere reliable.', '2023-08-28 17:58:16', '29.681949003655753', '-110.26035132516432');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (54, 'samuel87', 'Fs9YI', true, 'user', 'Samuel', 'Emily', 'samuel.emily@gmail.com', 54, 'http://fakeimages.com/samuel_emily.jpg', 'responsible innovative passionate patient funny dog-lover.', '2023-08-28 17:58:16', '39.17610998016751', '-120.89638086276663');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (55, 'alex18', 'eH3Kp', true, 'user', 'Alex', 'Emily', 'alex.emily@hotmail.com', 55, 'http://fakeimages.com/alex_emily.jpg', 'reliable hard-working enthusiastic professional intelligent.', '2023-08-28 17:58:16', '40.82466074043121', '-82.01142138230585');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (56, 'robert70', 'Extxy', true, 'user', 'Robert', 'Benjamin', 'robert.benjamin@gmail.com', 56, 'http://fakeimages.com/robert_benjamin.jpg', 'generous thoughtful sincere easy-going ambitious open-minded.', '2023-08-28 17:58:16', '35.544939039413364', '-71.73646878586653');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (57, 'rachel27', 'iKGB4', true, 'user', 'Rachel', 'Nicholas', 'rachel.nicholas@yahoo.com', 57, 'http://fakeimages.com/rachel_nicholas.jpg', 'committed friendly loyal dog-lover adventurous.', '2023-08-28 17:58:16', '46.590451011896924', '-114.33396197043496');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (58, 'john87', 'p2MUw', true, 'user', 'John', 'Brandon', 'john.brandon@hotmail.com', 58, 'http://fakeimages.com/john_brandon.jpg', 'friendly determined sincere innovative funny traveler.', '2023-08-28 17:58:16', '40.903463207125', '-101.765351758618');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (59, 'tyler32', 'OZTFJ', true, 'user', 'Tyler', 'Dylan', 'tyler.dylan@hotmail.com', 59, 'http://fakeimages.com/tyler_dylan.jpg', 'intelligent hard-working athletic professional.', '2023-08-28 17:58:16', '46.101024692313246', '-81.34185722264405');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (60, 'daniel24', 'vVJAq', true, 'user', 'Daniel', 'Joseph', 'daniel.joseph@yahoo.com', 60, 'http://fakeimages.com/daniel_joseph.jpg', 'dedicated honest outgoing sincere committed athletic.', '2023-08-28 17:58:16', '33.55900004777726', '-75.79209083369764');

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (1, 'jacobs seafood shack', NULL, NULL, NULL, 61, 1, 'seafood');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (2, 'athenas wonderland', NULL, NULL, NULL, 62, 1, 'is only cotton candy');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (3, 'Delicious Bites', 'http://deliciousbites.example', NULL, '(123) 456-7890', 63, 1, 'culinary adventure of flavors that tickle your taste buds.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (4, 'SunnySide Café', NULL, NULL, NULL, 64, 1, 'A place where every meal brings a touch of sunshine to your day.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (5, 'Urban Grill House', NULL, NULL, NULL, 65, 1, 'Savor the bold and smoky creations from the heart of the city.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (6, 'Green Oasis Eatery', NULL, NULL, NULL, 66, 1, 'A tranquil haven offering fresh and wholesome delights.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (7, 'SpiceFusion Bazaar', NULL, NULL, NULL, 67, 1, 'Embark on a journey through a vibrant marketplace of flavors.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (8, 'Sweet Serenity Café', NULL, NULL, NULL, 68, 1, 'Sweetness and serenity converge in every cup and bite.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (9, 'HarborView Grill', NULL, NULL, NULL, 69, 1, 'Captivating views meet delectable dishes at the water\'s edge.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (10, 'Artisan Bread Chronicles', NULL, NULL, NULL, 70, 1, 'Explore the saga of artisanal bread with every crust and crumb.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (11, 'Starlight', 'http://starlight.com', 'http://starlight.com/images/starlight.jpg', '045266617', 71, 1, 'sweet refined gourmet exquisite.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (12, 'Rustic', 'http://rustic.com', 'http://rustic.com/images/rustic.jpg', '660728153', 72, 1, 'authentic nutritious tasty wholesome.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (13, 'Rhythm', 'http://rhythm.com', 'http://rhythm.com/images/rhythm.jpg', '264589648', 73, 1, 'steamed wholesome melted artisanal elegant innovative zesty fried.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (14, 'Twilight', 'http://twilight.com', 'http://twilight.com/images/twilight.jpg', '630925686', 74, 1, 'sumptuous traditional seasoned braised filling exceptional.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (15, 'Taste', 'http://taste.com', 'http://taste.com/images/taste.jpg', '046091304', 75, 1, 'creamy fried tasty memorable delicious seasoned.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (16, 'Lavender', 'http://lavender.com', 'http://lavender.com/images/lavender.jpg', '295744742', 76, 1, 'refined steamed creamy braised.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (17, 'Serenade', 'http://serenade.com', 'http://serenade.com/images/serenade.jpg', '024007696', 77, 1, 'bright baked tasty scrumptious timeless savory exceptional smoky.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (18, 'Relish', 'http://relish.com', 'http://relish.com/images/relish.jpg', '235739421', 78, 1, 'delectable wholesome grilled gourmet refined scrumptious.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (19, 'Savory', 'http://savory.com', 'http://savory.com/images/savory.jpg', '114236867', 79, 1, 'filling melted unique delicious timeless roasted tender.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (20, 'Saffron', 'http://saffron.com', 'http://saffron.com/images/saffron.jpg', '857981662', 80, 1, 'crunchy savory scrumptious grilled sweet timeless rich toasted.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (21, 'Pepper', 'http://pepper.com', 'http://pepper.com/images/pepper.jpg', '002920477', 81, 1, 'toasted filling creamy creative outstanding grilled marinated juicy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (22, 'Bounty', 'http://bounty.com', 'http://bounty.com/images/bounty.jpg', '282854787', 82, 1, 'delectable toasted fluffy refined.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (23, 'Titan', 'http://titan.com', 'http://titan.com/images/titan.jpg', '883126319', 83, 1, 'melted innovative roasted hearty creamy steamed sumptuous.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (24, 'Pegasus', 'http://pegasus.com', 'http://pegasus.com/images/pegasus.jpg', '022494557', 84, 1, 'bright crisp seasoned innovative gourmet fried.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (25, 'Eclipse', 'http://eclipse.com', 'http://eclipse.com/images/eclipse.jpg', '537975556', 85, 1, 'fluffy outstanding exceptional timeless.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (26, 'Midnight', 'http://midnight.com', 'http://midnight.com/images/midnight.jpg', '991812663', 86, 1, 'memorable exceptional refined fluffy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (27, 'Unicorn', 'http://unicorn.com', 'http://unicorn.com/images/unicorn.jpg', '761884279', 87, 1, 'scrumptious sweet zesty juicy nutritious fried roasted exceptional.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (28, 'Rhapsody', 'http://rhapsody.com', 'http://rhapsody.com/images/rhapsody.jpg', '389774322', 88, 1, 'tender satisfying exceptional magnificent.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (29, 'Dragon', 'http://dragon.com', 'http://dragon.com/images/dragon.jpg', '130393453', 89, 1, 'fried savory melted zesty wholesome.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (30, 'Nebula', 'http://nebula.com', 'http://nebula.com/images/nebula.jpg', '438000853', 90, 1, 'traditional artisanal memorable signature.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (31, 'Feast', 'http://feast.com', 'http://feast.com/images/feast.jpg', '489145466', 91, 1, 'fried baked authentic fresh rich crunchy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (32, 'Harbor', 'http://harbor.com', 'http://harbor.com/images/harbor.jpg', '661613520', 92, 1, 'fluffy seasoned delicious exceptional creative satisfying.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (33, 'Joy', 'http://joy.com', 'http://joy.com/images/joy.jpg', '873236874', 93, 1, 'fresh tasty marinated signature.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (34, 'Symphony', 'http://symphony.com', 'http://symphony.com/images/symphony.jpg', '939538750', 94, 1, 'melted fluffy nutritious baked.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (35, 'Galaxy', 'http://galaxy.com', 'http://galaxy.com/images/galaxy.jpg', '466343877', 95, 1, 'memorable wholesome steamed fried seasoned tender.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (36, 'Pinecone', 'http://pinecone.com', 'http://pinecone.com/images/pinecone.jpg', '222253216', 96, 1, 'sweet roasted traditional innovative fried seasoned outstanding.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (37, 'Marina', 'http://marina.com', 'http://marina.com/images/marina.jpg', '596939427', 97, 1, 'zesty delicious modern baked spicy tasty.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (38, 'Harvest', 'http://harvest.com', 'http://harvest.com/images/harvest.jpg', '922026487', 98, 1, 'sumptuous sweet creamy authentic savory crisp.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (39, 'Harmony', 'http://harmony.com', 'http://harmony.com/images/harmony.jpg', '225336908', 99, 1, 'magnificent distinctive satisfying filling tender.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (40, 'Sunrise', 'http://sunrise.com', 'http://sunrise.com/images/sunrise.jpg', '812277399', 100, 1, 'fluffy braised elegant juicy creative exquisite.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (41, 'Oasis', 'http://oasis.com', 'http://oasis.com/images/oasis.jpg', '225817170', 101, 1, 'gourmet exquisite juicy hearty.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (42, 'Breeze', 'http://breeze.com', 'http://breeze.com/images/breeze.jpg', '189825409', 102, 1, 'baked grilled fried unique braised tangy modern exquisite.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (43, 'Tavern', 'http://tavern.com', 'http://tavern.com/images/tavern.jpg', '705980080', 103, 1, 'smoky tangy distinctive creamy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (44, 'Mirage', 'http://mirage.com', 'http://mirage.com/images/mirage.jpg', '720218871', 104, 1, 'tasty artisanal magnificent signature delicious smoky authentic.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (45, 'Melody', 'http://melody.com', 'http://melody.com/images/melody.jpg', '550368963', 105, 1, 'crunchy modern nutritious bright memorable.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (46, 'Thyme', 'http://thyme.com', 'http://thyme.com/images/thyme.jpg', '047639008', 106, 1, 'smoky filling modern spicy innovative tasty braised.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (47, 'Mint', 'http://mint.com', 'http://mint.com/images/mint.jpg', '510711758', 107, 1, 'tender exceptional filling sumptuous delicious.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (48, 'Orchid', 'http://orchid.com', 'http://orchid.com/images/orchid.jpg', '678128965', 108, 1, 'spicy refined melted sumptuous memorable.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (49, 'Phoenix', 'http://phoenix.com', 'http://phoenix.com/images/phoenix.jpg', '807304272', 109, 1, 'signature gourmet traditional tangy zesty melted modern timeless.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (50, 'Zest', 'http://zest.com', 'http://zest.com/images/zest.jpg', '360561496', 110, 1, 'tasty memorable juicy smoky refined exceptional.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (51, 'Nectar', 'http://nectar.com', 'http://nectar.com/images/nectar.jpg', '229942216', 111, 1, 'timeless baked fried sweet spicy bright crunchy nutritious.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (52, 'Kraken', 'http://kraken.com', 'http://kraken.com/images/kraken.jpg', '350502323', 112, 1, 'exceptional tangy nutritious savory seasoned.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (53, 'Flavor', 'http://flavor.com', 'http://flavor.com/images/flavor.jpg', '250058839', 113, 1, 'tender marinated modern wholesome toasted timeless steamed.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (54, 'Maple', 'http://maple.com', 'http://maple.com/images/maple.jpg', '053459122', 114, 1, 'rich melted memorable signature zesty sumptuous.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (55, 'Bliss', 'http://bliss.com', 'http://bliss.com/images/bliss.jpg', '478727524', 115, 1, 'traditional magnificent fried tender toasted.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (56, 'Blues', 'http://blues.com', 'http://blues.com/images/blues.jpg', '437915856', 116, 1, 'modern rich seasoned gourmet.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (57, 'Bistro', 'http://bistro.com', 'http://bistro.com/images/bistro.jpg', '343130789', 117, 1, 'roasted braised seasoned bright smoky.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (58, 'Mosaic', 'http://mosaic.com', 'http://mosaic.com/images/mosaic.jpg', '145160084', 118, 1, 'filling delectable juicy toasted crisp.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (59, 'Jazz', 'http://jazz.com', 'http://jazz.com/images/jazz.jpg', '300194243', 119, 1, 'spicy innovative creative nutritious fresh.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (60, 'The Harp', 'http://harp.com', 'http://harp.dom/images/harp.jpg', '2001653589', 120, 1, 'like angels singing in the air ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (1, 1, 'chineese', 1, 'yum');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (2, 2, 'Italian', true, 'Delicious pasta dishes and wood-fired pizzas with a modern twist.');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (3, 3, 'Sushi', true, 'Fresh and expertly crafted sushi rolls');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (4, 4, 'Mexican', true, 'Spicy and flavorful tacos');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (5, 5, 'Indian', true, 'Aromatic curries');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (6, 6, 'Chinese', true, 'Savory stir-fries');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (7, 7, 'Burger', true, 'Juicy burgers with a variety of toppings');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (8, 8, 'Thai', true, 'Exquisite Thai cuisine with a perfect balance of sweet');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (9, 9, 'Steakhouse', true, 'Premium cuts of steak');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (10, 10, 'Vegan', true, 'Plant-based dishes bursting with flavors');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (1, 'tomato fancy', NULL, 1, 50, 'fancy tomato', 100, true);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (2, 'Spaghetti Carbonara', 'http://fakeurl.com/spaghetti.jpg', 2, 12.99, 'A classic Italian pasta dish with eggs cheese and bacon', 550, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (3, 'Chicken Teriyaki Bowl', 'http://fakeurl.com/teriyaki.jpg', 3, 9.95, 'Grilled chicken served over a bed of rice with teriyaki sauce', 450, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (4, 'Margherita Pizza', 'http://fakeurl.com/margherita.jpg', 2, 14.50, 'A traditional pizza topped with tomato mozzarella and fresh basil', 800, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (5, 'Beef Stir-Fry', 'http://fakeurl.com/stirfry.jpg', 4, 11.75, 'Tender beef strips with colorful vegetables in a savory sauce', 520, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (6, 'Caesar Salad', 'http://fakeurl.com/caesarsalad.jpg', 3, 8.99, 'A refreshing salad with romaine lettuce croutons and Caesar dressing', 300, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (7, 'Grilled Salmon', 'http://fakeurl.com/salmon.jpg', 4, 17.25, 'Flaky salmon fillet with a lemon-dill glaze served with veggies', 600, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (8, 'Chocolate Lava Cake', 'http://fakeurl.com/lavacake.jpg', 6, 7.50, 'A decadent chocolate cake with a gooey molten center', 400, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (9, 'Vegetable Spring Rolls', 'http://fakeurl.com/springrolls.jpg', 5, 5.25, 'Crispy spring rolls filled with a mix of fresh vegetables', 250, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (10, 'BBQ Ribs Platter', 'http://fakeurl.com/bbqribs.jpg', 4, 22.99, 'Smoky and tender BBQ ribs served with coleslaw and fries', 800, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (1, NULL, 1, 1, 'soft', 'spicy', NULL, NULL, NULL, 5, NULL, NULL, 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (2, 'http://fakeurl.com/review-img2.jpg', 5, 3, 'Cozy and intimate', 'Aroma of freshly baked bread', 'Attentive staff', '23.50', 'Exquisite flavors', 5, '2023-08-27 14:30:00', '2023-08-27 14:30:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (3, 'http://fakeurl.com/review-img3.jpg', 8, 6, 'Lively and energetic', 'Hints of smoky barbecue', 'Courteous service', '15.75', 'Delicious and satisfying', 4, '2023-08-26 12:45:00', '2023-08-26 12:45:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (4, 'http://fakeurl.com/review-img4.jpg', 3, 1, 'Elegant and sophisticated', 'Fragrance of spices in the air', 'Quick and efficient', '12.50', 'Flavorsome and authentic', 3, '2023-08-25 10:20:00', '2023-08-25 10:20:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (5, 'http://fakeurl.com/review-img5.jpg', 7, 9, 'Relaxed beach vibes', 'A whiff of freshly brewed coffee', 'Friendly and attentive', '9.95', 'Simple yet satisfying', 5, '2023-08-24 18:15:00', '2023-08-24 18:15:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (6, 'http://fakeurl.com/review-img6.jpg', 1, 4, 'Homey and welcoming', 'Aroma of home-cooked meals', 'Warm and welcoming', '24.99', 'Mouthwatering and exceptional', 2, '2023-08-23 16:30:00', '2023-08-23 16:30:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (7, 'http://fakeurl.com/review-img7.jpg', 6, 2, 'Stylish and chic', 'Fresh sea breeze from the ocean', 'Caring and prompt', '22.50', 'Seafood at its finest', 5, '2023-08-22 13:10:00', '2023-08-22 13:10:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (8, 'http://fakeurl.com/review-img8.jpg', 4, 7, 'Relaxing and serene', 'Smell of spices and herbs', 'Genuine and attentive', '7.25', 'Flavorful and satisfying', 5, '2023-08-21 11:45:00', '2023-08-21 11:45:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (9, 'http://fakeurl.com/review-img9.jpg', 10, 5, 'Vibrant and bustling', 'Aromatic notes of herbs and garlic', 'Helpful and accommodating', '5.50', 'Fresh and invigorating', 2, '2023-08-20 09:30:00', '2023-08-20 09:30:00', 1);
INSERT INTO `restaurant_review` (`id`, `image_url`, `user_id`, `restaurant_id`, `atmosphere`, `smell`, `service`, `price`, `food`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (10, 'http://fakeurl.com/review-img10.jpg', 2, 8, 'Eclectic and diverse', 'Aromas of a global kitchen', 'Friendly and efficient', '18.75', 'Diverse and impressive', 4, '2023-08-19 07:55:00', '2023-08-19 07:55:00', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cuisine`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (1, 'chineese', 'yum', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (2, 'Italian', 'Indulge in the rich flavors of Italian cuisine, from pasta to pizza.', 'http://fakeurl.com/italian-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (3, 'Japanese', 'Experience the art of sushi, sashimi, and delicate Japanese flavors.', 'http://fakeurl.com/japanese-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (4, 'Mexican', 'Spice up your palate with vibrant Mexican dishes and bold spices.', 'http://fakeurl.com/mexican-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (5, 'Indian', 'Embark on a journey through aromatic curries, naan, and Indian spices.', 'http://fakeurl.com/indian-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (6, 'Chinese', 'Savor the variety of Chinese dishes, from stir-fries to dim sum.', 'http://fakeurl.com/chinese-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (7, 'French', 'Elevate your dining with elegant French classics and refined flavors.', 'http://fakeurl.com/french-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (8, 'Thai', 'Delight in the balance of sweet, sour, salty, and spicy Thai cuisine.', 'http://fakeurl.com/thai-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (9, 'American', 'Indulge in American comfort food, from burgers to mac and cheese.', 'http://fakeurl.com/american-icon.jpg');
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (10, 'Greek', 'Taste the freshness of Mediterranean ingredients in Greek dishes.', 'http://fakeurl.com/greek-icon.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (1, 1, 1, 'yay food', 'pickles', '100', 5, NULL, NULL, 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (2, 2, 8, 'Absolutely delicious! The flavors are outstanding.', 'Savory and satisfying', '18.50', 5, '2023-08-27 14:30:00', '2023-08-27 14:30:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (3, 3, 4, 'Tasted great, but a bit too salty for my liking.', 'Rich and flavorful', '12.75', 4, '2023-08-26 12:45:00', '2023-08-26 12:45:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (4, 4, 6, 'The dish was underwhelming. Expected more.', 'Bland and uninspiring', '9.95', 2, '2023-08-25 10:20:00', '2023-08-25 10:20:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (5, 5, 2, 'Loved every bite! A perfect blend of textures.', 'Deliciously balanced', '24.99', 5, '2023-08-24 18:15:00', '2023-08-24 18:15:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (6, 6, 9, 'Decent, but could use more seasoning.', 'Fairly good', '14.50', 3, '2023-08-23 16:30:00', '2023-08-23 16:30:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (7, 7, 7, 'An explosion of flavors that left me wanting more.', 'Bold and vibrant', '30.25', 5, '2023-08-22 13:10:00', '2023-08-22 13:10:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (8, 8, 5, 'Absolutely scrumptious! Worth every penny.', 'Indulgent and delightful', '8.75', 5, '2023-08-21 11:45:00', '2023-08-21 11:45:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (9, 9, 1, 'The taste didn\'t quite match the price.', 'Underwhelming', '6.50', 2, '2023-08-20 09:30:00', '2023-08-20 09:30:00', 1);
INSERT INTO `menu_item_review` (`id`, `menu_item_id`, `user_id`, `contents`, `item_taste`, `item_price`, `rating`, `create_date`, `update_date`, `enabled`) VALUES (10, 10, 3, 'Exquisite taste, but a bit on the expensive side.', 'Luxurious and exquisite', '19.95', 4, '2023-08-19 07:55:00', '2023-08-19 07:55:00', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (1, 1, 1, 'yummy yummy', NULL, NULL, 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (2, 5, 8, 'A hidden gem with a cozy ambiance and delectable menu.', '2023-08-27 14:30:00', '2023-08-27 14:30:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (3, 3, 4, 'A bustling spot known for its lively atmosphere and diverse cuisine.', '2023-08-26 12:45:00', '2023-08-26 12:45:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (4, 8, 6, 'An upscale dining experience with an extensive wine selection.', '2023-08-25 10:20:00', '2023-08-25 10:20:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (5, 2, 2, 'A family-friendly restaurant famous for its hearty comfort food.', '2023-08-24 18:15:00', '2023-08-24 18:15:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (6, 7, 9, 'A beachfront paradise offering fresh seafood and stunning views.', '2023-08-23 16:30:00', '2023-08-23 16:30:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (7, 6, 7, 'A vibrant establishment serving global cuisine in a lively setting.', '2023-08-22 13:10:00', '2023-08-22 13:10:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (8, 4, 5, 'A charming cafe perfect for a quick bite or a leisurely brunch.', '2023-08-21 11:45:00', '2023-08-21 11:45:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (9, 9, 1, 'A trendy spot known for its innovative dishes and chic decor.', '2023-08-20 09:30:00', '2023-08-20 09:30:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (10, 10, 3, 'An authentic eatery where traditional recipes shine.', '2023-08-19 07:55:00', '2023-08-19 07:55:00', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_favorite_restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (1, 1);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (2, 1);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (3, 2);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (4, 2);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (5, 3);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (6, 3);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (7, 4);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (8, 6);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (9, 7);
INSERT INTO `user_favorite_restaurant` (`user_id`, `restaurant_id`) VALUES (10, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item_has_cuisine`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (1, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (2, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (3, 3);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (4, 4);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (5, 5);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (6, 6);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (7, 7);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (8, 8);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (9, 9);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (10, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant_review_ratings`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (1, 1, 1, NULL, NULL);
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (2, 2, 4, '2023-08-27 14:30:00', '2023-08-27 14:30:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (3, 3, 5, '2023-08-26 12:45:00', '2023-08-26 12:45:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (4, 4, 3, '2023-08-25 10:20:00', '2023-08-25 10:20:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (5, 5, 5, '2023-08-24 18:15:00', '2023-08-24 18:15:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (6, 6, 2, '2023-08-23 16:30:00', '2023-08-23 16:30:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (7, 7, 5, '2023-08-22 13:10:00', '2023-08-22 13:10:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (8, 8, 5, '2023-08-21 11:45:00', '2023-08-21 11:45:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (9, 9, 2, '2023-08-20 09:30:00', '2023-08-20 09:30:00');
INSERT INTO `restaurant_review_ratings` (`user_id`, `restaurant_review_id`, `rating`, `create_date`, `update_date`) VALUES (10, 10, 4, '2023-08-19 07:55:00', '2023-08-19 07:55:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item_review_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (1, 1, '2023-08-15 10:23:45', '2023-08-16 09:15:30', 4);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (2, 2, '2023-08-27 14:30:00', '2023-08-27 14:30:00', 5);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (3, 3, '2023-08-26 12:45:00', '2023-08-26 12:45:00', 4);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (4, 4, '2023-08-25 10:20:00', '2023-08-25 10:20:00', 3);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (5, 5, '2023-08-24 18:15:00', '2023-08-24 18:15:00', 5);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (6, 6, '2023-08-23 16:30:00', '2023-08-23 16:30:00', 2);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (7, 7, '2023-08-22 13:10:00', '2023-08-22 13:10:00', 5);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (8, 8, '2023-08-21 11:45:00', '2023-08-21 11:45:00', 5);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (9, 9, '2023-08-20 09:30:00', '2023-08-20 09:30:00', 2);
INSERT INTO `menu_item_review_rating` (`user_id`, `menu_item_review_id`, `create_date`, `update_date`, `rating`) VALUES (10, 10, '2023-08-19 07:55:00', '2023-08-19 07:55:00', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment_upvote`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (1, 1);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (2, 2);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (3, 3);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (4, 4);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (5, 5);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (6, 6);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (7, 7);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (8, 8);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (9, 9);
INSERT INTO `comment_upvote` (`user_id`, `comment_id`) VALUES (10, 10);

COMMIT;

