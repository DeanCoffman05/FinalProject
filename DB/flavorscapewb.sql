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
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (11, '4717 Linden Sycamore', '', 'San Francisco', 'CA', '84672', 'USA', '37.88260139316907', '-122.6768555020947');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (12, '4415 Pear Pear', '', 'Denver', 'CO', '11608', 'USA', '39.98294840927241', '-105.08174519881135');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (13, '8660 Cherry Hemlock', '', 'Washington', 'DC', '77996', 'USA', '38.984637833488634', '-76.92224478390175');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (14, '382 Maple Walnut', '', 'Chicago', 'IL', '37599', 'USA', '41.647250765152116', '-87.72789591458516');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (15, '8682 Pewter Laurel', '', 'Washington', 'DC', '38939', 'USA', '38.941265091133666', '-77.02300304679719');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (16, '6386 Sequoia Chestnut', '', 'Houston', 'TX', '79543', 'USA', '29.750587001300467', '-95.61264733093809');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (17, '4571 Fir Cottonwood', '', 'San Francisco', 'CA', '73932', 'USA', '37.95544638250798', '-122.96118853118213');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (18, '6105 Basswood Tamarack', '', 'New York', 'NY', '42489', 'USA', '40.64647543514917', '-73.6036286549998');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (19, '9997 Hickory Yew', '', 'San Francisco', 'CA', '36727', 'USA', '37.80642065624268', '-123.18707992196786');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (20, '6073 Tamarack Beech', '', 'Indianapolis', 'IN', '80393', 'USA', '39.77887984207028', '-85.89137215848875');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (21, '342 Dogwood Cedar', '', 'Austin', 'TX', '52479', 'USA', '30.172682816405537', '-97.9018699457076');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (22, '451 Balsam Cottonwood', '', 'Charlotte', 'NC', '62704', 'USA', '35.14465153420702', '-80.71937517505317');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (23, '8769 Aspen Redwood', '', 'San Diego', 'CA', '11363', 'USA', '32.52144753706201', '-116.83046828740079');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (24, '4978 Palm Zelkova', '', 'Charlotte', 'NC', '89776', 'USA', '35.117934663275676', '-80.82004065294063');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (25, '8213 Alder Fir', '', 'Houston', 'TX', '33486', 'USA', '29.705063155573843', '-95.21456466481834');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (26, '1310 Larch Cypress', '', 'Denver', 'CO', '07477', 'USA', '39.8707807004603', '-104.6724375940514');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (27, '232 Walnut Rowan', '', 'Memphis', 'TN', '00644', 'USA', '35.00497157441079', '-89.90280848603096');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (28, '8066 Magnolia Birch', '', 'Houston', 'TX', '03692', 'USA', '30.00762770852475', '-95.46567074911381');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (29, '3838 Larch Laurel', '', 'El Paso', 'TX', '88858', 'USA', '32.01289536033563', '-106.22289137649733');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (30, '2045 Sycamore Chestnut', '', 'Chicago', 'IL', '74290', 'USA', '41.80803815938011', '-87.51046791187177');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (31, '2421 Redwood Mango', '', 'Dallas', 'TX', '19152', 'USA', '32.8016478897522', '-96.77973891503717');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (32, '2468 Sequoia Pewter', '', 'Indianapolis', 'IN', '96031', 'USA', '39.78225678734862', '-86.03182541647082');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (33, '410 Mahogany Walnut', '', 'San Antonio', 'TX', '90461', 'USA', '29.27497082363047', '-98.35533530272751');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (34, '3474 Linden Dogwood', '', 'El Paso', 'TX', '98714', 'USA', '31.8334041631455', '-106.2652763736401');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (35, '8649 Birch Dogwood', '', 'San Jose', 'CA', '40640', 'USA', '37.27977131569811', '-121.70715982754194');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (36, '2486 Willow Sequoia', '', 'San Antonio', 'TX', '74892', 'USA', '29.484998137658604', '-98.58817445320099');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (37, '4981 Birch Pine', '', 'Boston', 'MA', '45228', 'USA', '42.33501986575686', '-71.02072128329');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (38, '6230 Cedar Teak', '', 'Fort Worth', 'TX', '10064', 'USA', '32.67183186500394', '-97.07315527944297');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (39, '6887 Linden Alder', '', 'Seattle', 'WA', '56760', 'USA', '47.59611644130151', '-122.20365065688867');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (40, '9992 Silk Tamarack', '', 'Charlotte', 'NC', '69725', 'USA', '35.17328790763588', '-80.61744907267753');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (41, '134 Cypress Palm', '', 'San Jose', 'CA', '78284', 'USA', '37.21149003815259', '-121.70264010064362');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (42, '4507 Maple Oak', '', 'Seattle', 'WA', '09769', 'USA', '47.60227128774771', '-122.47765230390387');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (43, '8684 Mahogany Palm', '', 'San Antonio', 'TX', '05172', 'USA', '29.40878525735707', '-98.25543491899374');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (44, '8385 Oak Pewter', '', 'Columbus', 'OH', '49831', 'USA', '39.95695600965695', '-82.84954343080067');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (45, '3616 Olive Redwood', '', 'Los Angeles', 'CA', '68777', 'USA', '33.649921244848386', '-118.4048191277676');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (46, '1470 Laurel Yew', '', 'Houston', 'TX', '41432', 'USA', '29.815664648454813', '-95.52042363033554');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (47, '5844 Mango Silk', '', 'Charlotte', 'NC', '63062', 'USA', '35.241687258392716', '-80.76974152984639');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (48, '3863 Holly Beech', '', 'New York', 'NY', '31623', 'USA', '40.6385469237933', '-73.93815805552099');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (49, '5940 Ironwood Fir', '', 'Nashville', 'TN', '47583', 'USA', '36.29263823586277', '-86.76504014197809');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (50, '1309 Sequoia Redwood', '', 'Detroit', 'MI', '47778', 'USA', '42.5892301088861', '-83.06997317975335');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (51, '2010 Spruce Pear', '', 'Charlotte', 'NC', '59837', 'USA', '35.44313585876208', '-80.70090020123179');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (52, '5032 Basswood Birch', '', 'Denver', 'CO', '18134', 'USA', '39.9696622287947', '-104.72299657116656');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (53, '1840 Pear Pear', '', 'San Jose', 'CA', '65020', 'USA', '37.2430713884472', '-121.81804670565198');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (54, '3918 Larch Laurel', '', 'New York', 'NY', '01450', 'USA', '40.82462029484664', '-73.91406620707679');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (55, '6715 Ash Cedar', '', 'San Francisco', 'CA', '90316', 'USA', '37.88735839637222', '-122.92705594203092');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (56, '4107 Pear Beech', '', 'Los Angeles', 'CA', '65280', 'USA', '33.93935202252724', '-118.63378657942158');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (57, '1761 Sycamore Juniper', '', 'Boston', 'MA', '10436', 'USA', '42.352288694061095', '-71.03051787007435');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (58, '4296 Aspen Yew', '', 'Nashville', 'TN', '04019', 'USA', '36.08197495610402', '-86.99625721025858');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (59, '5695 Pewter Cypress', '', 'Memphis', 'TN', '28855', 'USA', '35.14906888285033', '-89.89823609183603');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (60, '3922 Cypress Teak', '', 'Charlotte', 'NC', '19833', 'USA', '35.37294623540145', '-80.76982555896318');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (61, '7243 Plum Sycamore', '', 'Fort Worth', 'TX', '32783', 'USA', '32.99976418122793', '-97.30653824040944');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (62, '857 Yew Hickory', '', 'Fort Worth', 'TX', '04219', 'USA', '32.69776218643524', '-97.49050304391034');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (63, '1247 Ironwood Sycamore', '', 'Washington', 'DC', '45920', 'USA', '38.83741180366051', '-76.97945695934148');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (64, '9346 Plum Willow', '', 'Indianapolis', 'IN', '18559', 'USA', '39.80304524553432', '-85.99449697791087');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (65, '593 Pewter Mahogany', '', 'New York', 'NY', '85221', 'USA', '40.57109843859468', '-74.07533871997869');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (66, '8518 Ironwood Yew', '', 'Phoenix', 'AZ', '14507', 'USA', '33.414669019366606', '-112.18150277005579');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (67, '3104 Pewter Zelkova', '', 'Houston', 'TX', '68882', 'USA', '29.735832623826436', '-95.15694116238545');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (68, '7462 Elm Pewter', '', 'Jacksonville', 'FL', '48408', 'USA', '30.501930362979802', '-81.53594692796818');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (69, '8652 Basswood Zelkova', '', 'Detroit', 'MI', '21489', 'USA', '42.3089136913271', '-83.02862335813127');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (70, '9190 Holly Blackwood', '', 'Indianapolis', 'IN', '68046', 'USA', '39.82684193016764', '-85.96661867530169');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (71, '1816 Linden Aspen', '', 'San Antonio', 'TX', '82786', 'USA', '29.35420000217816', '-98.4257315796863');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (72, '6026 Redwood Larch', '', 'Seattle', 'WA', '94670', 'USA', '47.41888802669867', '-122.40421169761233');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (73, '2128 Dogwood Ironwood', '', 'San Jose', 'CA', '17247', 'USA', '37.48933346132004', '-121.77510628708264');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (74, '6990 Cedar Walnut', '', 'Fort Worth', 'TX', '54240', 'USA', '33.03867555536179', '-97.42277314930396');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (75, '5991 Dogwood Elm', '', 'Denver', 'CO', '54479', 'USA', '39.748484303920165', '-105.07213436436082');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (76, '327 Willow Yew', '', 'Indianapolis', 'IN', '37927', 'USA', '40.089489928959914', '-85.80589726540272');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (77, '424 Plum Zelkova', '', 'San Antonio', 'TX', '78393', 'USA', '29.402013526077855', '-98.32071286364794');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (78, '3877 Silk Larch', '', 'Washington', 'DC', '93279', 'USA', '38.90606184290767', '-76.99884988954261');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (79, '9447 Olive Hickory', '', 'San Antonio', 'TX', '25532', 'USA', '29.42431294863182', '-98.48985533180407');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (80, '1276 Aspen Blackwood', '', 'Fort Worth', 'TX', '23291', 'USA', '32.89943504610397', '-97.00065314577601');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (81, '2429 Alder Palm', '', 'Philadelphia', 'PA', '75361', 'USA', '39.95077565904242', '-75.15557401777053');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (82, '4867 Tamarack Maple', '', 'Phoenix', 'AZ', '82703', 'USA', '33.47477734722024', '-111.92931137066611');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (83, '8672 Hickory Linden', '', 'Houston', 'TX', '62115', 'USA', '29.5878784353494', '-95.79603876103927');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (84, '7302 Sequoia Mango', '', 'El Paso', 'TX', '36942', 'USA', '31.74669722476923', '-106.58129765905464');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (85, '708 Basswood Teak', '', 'Columbus', 'OH', '24979', 'USA', '40.02505003318614', '-83.058928046348');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (86, '4615 Mango Holly', '', 'New York', 'NY', '98795', 'USA', '40.57241178900886', '-74.17924940846035');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (87, '3643 Sycamore Yew', '', 'San Diego', 'CA', '24338', 'USA', '32.738782872718154', '-117.07039585305199');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (88, '5932 Beech Aspen', '', 'San Antonio', 'TX', '85676', 'USA', '29.207727840209007', '-98.41796581811604');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (89, '9016 Pine Yew', '', 'San Diego', 'CA', '23107', 'USA', '32.78774023909051', '-117.12793752724711');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (90, '4251 Walnut Ironwood', '', 'Columbus', 'OH', '04009', 'USA', '39.911788225596204', '-82.79738804368782');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (91, '3119 Spruce Ash', '', 'Fort Worth', 'TX', '11681', 'USA', '32.723409358911425', '-97.23235718432606');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (92, '362 Balsam Cypress', '', 'Fort Worth', 'TX', '76250', 'USA', '33.018325675302364', '-97.32805069785758');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (93, '3191 Hickory Basswood', '', 'Nashville', 'TN', '75496', 'USA', '36.298834919526826', '-86.76779555491653');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (94, '6684 Ironwood Pear', '', 'Austin', 'TX', '60026', 'USA', '30.29387995089284', '-98.02631624010309');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (95, '9169 Teak Blackwood', '', 'Denver', 'CO', '73093', 'USA', '39.83284058246526', '-104.83356886303105');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (96, '4669 Poplar Pear', '', 'Memphis', 'TN', '38534', 'USA', '35.27053697773534', '-90.06125200258496');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (97, '2502 Elm Willow', '', 'Columbus', 'OH', '34879', 'USA', '40.001406579976994', '-82.90887509790007');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (98, '9088 Birch Maple', '', 'Memphis', 'TN', '39681', 'USA', '35.0747734334164', '-89.83702975374055');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (99, '2914 Pine Larch', '', 'Boston', 'MA', '99902', 'USA', '42.47851896068746', '-70.9313530988203');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (100, '8900 Fir Sequoia', '', 'Philadelphia', 'PA', '80855', 'USA', '40.067622583933506', '-75.11192577278788');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (101, '6507 Poplar Palm', '', 'El Paso', 'TX', '87982', 'USA', '31.802372108245454', '-106.20033363226445');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (102, '9437 Redwood Laurel', '', 'Washington', 'DC', '44139', 'USA', '38.94808181780503', '-77.0880086635185');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (103, '881 Blackwood Holly', '', 'Dallas', 'TX', '40336', 'USA', '32.74658878263068', '-96.57901891322484');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (104, '9919 Birch Hickory', '', 'San Francisco', 'CA', '03874', 'USA', '38.00568655043887', '-122.50267777526126');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (105, '7870 Teak Sequoia', '', 'Chicago', 'IL', '29898', 'USA', '42.05780327296656', '-87.65784677740827');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (106, '4193 Spruce Plum', '', 'Philadelphia', 'PA', '98418', 'USA', '40.099792012034136', '-74.9208442545737');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (107, '5481 Maple Poplar', '', 'Seattle', 'WA', '62149', 'USA', '47.74880481968379', '-122.14716271104814');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (108, '5694 Aspen Blackwood', '', 'Philadelphia', 'PA', '17341', 'USA', '39.975793991252516', '-75.23505522207843');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (109, '1815 Dogwood Cypress', '', 'Houston', 'TX', '75335', 'USA', '30.018377113404725', '-95.368257065581');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (110, '5493 Cypress Hemlock', '', 'Fort Worth', 'TX', '50065', 'USA', '32.68347098535037', '-97.15647243950497');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (111, '7921 Elm Laurel', '', 'Nashville', 'TN', '71806', 'USA', '36.22146170073313', '-86.7986425130264');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (112, '7835 Basswood Walnut', '', 'Columbus', 'OH', '71732', 'USA', '39.968515903958505', '-82.93323740047225');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (113, '6640 Walnut Ironwood', '', 'Nashville', 'TN', '65283', 'USA', '36.05960563036833', '-86.78342361818679');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (114, '8357 Holly Sequoia', '', 'Chicago', 'IL', '97475', 'USA', '41.747010654694996', '-87.96469193665983');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (115, '6486 Magnolia Cypress', '', 'Washington', 'DC', '03223', 'USA', '38.9173103366271', '-76.91412209171926');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (116, '9465 Mango Willow', '', 'Philadelphia', 'PA', '68617', 'USA', '39.83756310593738', '-75.07397442586397');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (117, '5289 Oak Oak', '', 'Philadelphia', 'PA', '35552', 'USA', '40.03710971065525', '-75.24456449930808');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (118, '658 Yew Pewter', '', 'Nashville', 'TN', '16763', 'USA', '36.150473534683634', '-86.94293452992854');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (119, '9505 Pewter Elm', '', 'Houston', 'TX', '06472', 'USA', '29.606357289318236', '-95.00869593310846');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (120, '429 Zelkova Pine', '', 'Charlotte', 'NC', '67539', 'USA', '35.28866157711425', '-80.75144568924243');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (121, '2370 Maple Silk', '', 'Jacksonville', 'FL', '15525', 'USA', '30.193035121436864', '-81.44109912480441');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'admin', 'John', 'Doe', 'jdoe@gmail.com', 61, NULL, 'just a silly goofy', '2023-08-27 11:00:00', '34.733862', '-105.680433');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (2, 'Alice123', '$2a$10$KQgnO0rrm.hjSb5bm6eTOe3q3AeM6tx5MZWG1yxweIMXmGs6pgA6K', true, 'admin', 'Alice', 'Johnson', 'alice@example.com', 62, 'http://fakeurl.com/alice.jpg', 'Passionate about coding and coffee', '2023-08-27 10:15:00', '38.514364', '-110.765645');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (3, 'Bob456', '$2a$10$VH9aQBsEKf5cW4TjUdG2lOoVmXw0tS3b0lF6EGeqV9ZrVlty3RGWm', true, 'user', 'Bob', 'Smith', 'bob@example.com', 63, 'http://fakeurl.com/bob.jpg', 'Adventurer and book lover', '2023-08-26 14:30:00', '37.861189', '-121.984608');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (4, 'Charlie789', '$2a$10$FLCvj5HXphZS6EojK4FZIu1mN4UePmeOTiJl/EhEUCp5X8pB1zJXm', true, 'user', 'Charlie', 'Brown', 'charlie@example.com', 64, 'http://fakeurl.com/charlie.jpg', 'Foodie at heart', '2023-08-25 09:45:00', '44.694011', '-123.162729');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (5, 'David987', '$2a$10$X65NzNOeqoOHj4jp5jSxIuKQCMUbTmf9Eg5Fjx3aHIlrXcDV5uv9O', true, 'user', 'David', 'Miller', 'david@example.com', 65, 'http://fakeurl.com/david.jpg', 'Music is life', '2023-08-24 18:20:00', '38.854244', '-105.049779');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (6, 'William01', '$2a$10$Y7vRuTtVdc.I81C6ffD6mOxVT0v4Zw6iBCChLQabqz4hqFdjLsDD6', true, 'user', 'William', 'Johnson', 'william@example.com', 66, 'http://fakeurl.com/william.jpg', 'Explorer of nature and wildlife', '2023-08-18 19:25:00', '31.737163', '-98.739461');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (7, 'Maximus34', '$2a$10$Ur.PcAHusntaK08LB9y.KufAKU9Xa.Nb3YPmQg2hvBtJBJVlw6j5i', true, 'user', 'Maximus', 'Smith', 'maximus@example.com', 67, 'http://fakeurl.com/maximus.jpg', 'Adventurer with a love for the outdoors', '2023-08-26 09:45:00', '33.800536', '-83.946143');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (8, 'Olivia87', '$2a$10$EQLKcFGKpLO3b/jH0/W1..aXrJHroPsTqGwN1rCO0WEg7yTrQ3TDe', true, 'user', 'Olivia', 'Brown', 'olivia@example.com', 68, 'http://fakeurl.com/olivia.jpg', 'Bookworm and tea enthusiast', '2023-08-25 12:15:00', '35.841274', '-78.417964');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (9, 'Leo123', '$2a$10$qJTptnD2bwg.sq2bUCRuj.59m0dwwgrsI5N9z/9aSxOorWpOwv.kG', true, 'user', 'Leo', 'Miller', 'leo@example.com', 69, 'http://fakeurl.com/leo.jpg', 'Music lover and aspiring guitarist', '2023-08-24 14:20:00', '28.051661', '-81.484664');
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
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (1, 'jacobs seafood shack', NULL, NULL, NULL, 1, 1, 'seafood');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (2, 'athenas wonderland', NULL, NULL, NULL, 2, 1, 'is only cotton candy');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (3, 'Delicious Bites', 'http://deliciousbites.example', NULL, '(123) 456-7890', 3, 1, 'culinary adventure of flavors that tickle your taste buds.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (4, 'SunnySide Café', NULL, NULL, NULL, 4, 1, 'A place where every meal brings a touch of sunshine to your day.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (5, 'Urban Grill House', NULL, NULL, NULL, 5, 1, 'Savor the bold and smoky creations from the heart of the city.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (6, 'Green Oasis Eatery', NULL, NULL, NULL, 6, 1, 'A tranquil haven offering fresh and wholesome delights.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (7, 'SpiceFusion Bazaar', NULL, NULL, NULL, 7, 1, 'Embark on a journey through a vibrant marketplace of flavors.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (8, 'Sweet Serenity Café', NULL, NULL, NULL, 8, 1, 'Sweetness and serenity converge in every cup and bite.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (9, 'HarborView Grill', NULL, NULL, NULL, 9, 1, 'Captivating views meet delectable dishes at the water\'s edge.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (10, 'Artisan Bread Chronicles', NULL, NULL, NULL, 10, 1, 'Explore the saga of artisanal bread with every crust and crumb.');
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

