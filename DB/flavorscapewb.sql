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
  `item_name` VARCHAR(100) NULL,
  `item_url` VARCHAR(2000) NULL,
  `menu_id` INT NOT NULL,
  `price` DOUBLE NULL,
  `description` VARCHAR(1500) NULL,
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
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (1, '1234 Grimwald way', '', 'Denver', 'CO', '12345', 'USA', '39.7462', '-104.9253');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (2, '3445 Turducken St.', '', 'Denver', 'CO', '45678', 'USA', '39.7135', '-104.9128');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (3, '123 Main St', '', 'Denver', 'CO', '12345', 'USA', '39.7839', '-104.8557');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (4, '456 Oak Ave', '', 'Denver', 'CO', '54321', 'USA', '39.7765', '-104.9301');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (5, '789 Elm Rd', 'Unit 204', 'Denver', 'CO', '98765', 'USA', '39.7281', '-104.9543');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (6, '234 Pine St', '', 'Denver', 'CO', '34567', 'USA', '39.7822', '-104.8231');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (7, '567 Maple Ln', '', 'Denver', 'CO', '67890', 'USA', '39.7978', '-104.7915');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (8, '890 Cedar Ave', '', 'Denver', 'CO', '45678', 'USA', '39.7204', '-104.8745');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (9, '123 Pineapple St', 'Apartment 101', 'Denver', 'CO', '23456', 'USA', '39.7991', '-104.9652');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (10, '456 Cherry Blvd', '', 'Denver', 'CO', '76543', 'USA', '39.7790', '-104.9582');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (11, '9645 Hickory Birch', '', 'Chicago', 'IL', '36219', 'USA', '45.197667235618134', '-95.11539013804146');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (12, '2364 Teak Basswood', '', 'Houston', 'TX', '50752', 'USA', '32.92768091966538', '-99.13928907543688');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (13, '3086 Spruce Cedar', '', 'San Jose', 'CA', '42452', 'USA', '46.69771520003171', '-95.09413054055953');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (14, '6540 Olive Poplar', '', 'Houston', 'TX', '32841', 'USA', '27.261130811091988', '-99.09874396019327');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (15, '9618 Juniper Larch', '', 'Dallas', 'TX', '09380', 'USA', '39.96892692355899', '-99.21710722429425');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (16, '7057 Pine Ironwood', '', 'Charlotte', 'NC', '69065', 'USA', '37.23337167270596', '-72.10905927805547');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (17, '8977 Poplar Blackwood', '', 'Houston', 'TX', '90349', 'USA', '42.30148980794611', '-99.76331779528856');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (18, '7053 Olive Yew', '', 'Las Vegas', 'NV', '82057', 'USA', '32.403114643832396', '-96.55416097794645');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (19, '5431 Walnut Dogwood', '', 'San Jose', 'CA', '75124', 'USA', '31.216842568610673', '-93.41688841917288');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (20, '712 Pewter Birch', '', 'Boston', 'MA', '87735', 'USA', '39.99657114608985', '-107.27569709155183');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (21, '7767 Juniper Silk', '', 'Philadelphia', 'PA', '68147', 'USA', '41.84151514171158', '-105.51081601475138');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (22, '4633 Hickory Spruce', '', 'Los Angeles', 'CA', '05221', 'USA', '39.48561800070627', '-102.7388101591901');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (23, '4933 Fir Larch', '', 'Fort Worth', 'TX', '03846', 'USA', '37.25245821217068', '-98.08454575773686');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (24, '5973 Sequoia Maple', '', 'Phoenix', 'AZ', '30943', 'USA', '30.81000628856068', '-80.072855538671');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (25, '2204 Spruce Yew', '', 'Chicago', 'IL', '29854', 'USA', '26.535981506251765', '-122.76266049531316');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (26, '8474 Ironwood Pewter', '', 'Charlotte', 'NC', '24574', 'USA', '27.25966657195466', '-106.4144208955493');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (27, '2810 Ironwood Redwood', '', 'San Jose', 'CA', '67172', 'USA', '33.56600274010129', '-70.75875446462558');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (28, '7525 Pear Pewter', '', 'Philadelphia', 'PA', '29432', 'USA', '38.56164146209875', '-90.95836565785592');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (29, '7771 Willow Magnolia', '', 'Phoenix', 'AZ', '67190', 'USA', '37.08120586002421', '-116.82291857462779');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (30, '5720 Balsam Pear', '', 'Austin', 'TX', '53555', 'USA', '48.35476229435848', '-100.01999803561193');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (31, '5615 Zelkova Aspen', '', 'Las Vegas', 'NV', '32901', 'USA', '47.0768929178829', '-114.43943622298596');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (32, '3308 Laurel Cypress', '', 'Austin', 'TX', '84068', 'USA', '28.811149356571647', '-99.57828201083038');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (33, '7235 Dogwood Cottonwood', '', 'Chicago', 'IL', '94113', 'USA', '26.05093285147582', '-87.89377008602557');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (34, '5502 Juniper Cedar', '', 'Chicago', 'IL', '48219', 'USA', '47.81870378559579', '-110.45005546137332');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (35, '1475 Chestnut Magnolia', '', 'Columbus', 'OH', '27573', 'USA', '39.66543441587789', '-70.29417859350738');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (36, '8159 Cottonwood Cypress', '', 'Los Angeles', 'CA', '50764', 'USA', '38.093596342822394', '-111.13539957048101');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (37, '2785 Poplar Basswood', '', 'Chicago', 'IL', '66181', 'USA', '39.125574186506476', '-123.5690943043447');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (38, '6385 Dogwood Sycamore', '', 'Jacksonville', 'FL', '62816', 'USA', '27.4807104298759', '-81.16031414767774');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (39, '5875 Magnolia Juniper', '', 'Jacksonville', 'FL', '14042', 'USA', '27.465120029911205', '-81.16281985653103');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (40, '4625 Balsam Spruce', '', 'Austin', 'TX', '82025', 'USA', '31.20610184067593', '-99.33232333371771');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (41, '2264 Laurel Yew', '', 'El Paso', 'TX', '30530', 'USA', '32.431441187788458', '-98.3705863905214');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (42, '610 Dogwood Blackwood', '', 'San Jose', 'CA', '92387', 'USA', '33.67146530580736', '-74.16145128627026');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (43, '6229 Pear Willow', '', 'Jacksonville', 'FL', '76408', 'USA', '27.73949545488745', '-82.74392103378588');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (44, '4296 Spruce Fir', '', 'San Francisco', 'CA', '86103', 'USA', '48.45257345157115', '-95.58685293396925');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (45, '6001 Aspen Cedar', '', 'Los Angeles', 'CA', '30665', 'USA', '30.73856598709478', '-73.70056311618613');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (46, '7860 Tamarack Cherry', '', 'Jacksonville', 'FL', '76884', 'USA', '27.656612835440257', '-81.74701735273356');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (47, '4935 Cottonwood Sequoia', '', 'El Paso', 'TX', '10600', 'USA', '33.6153524027146', '-100.20561807388596');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (48, '5409 Oak Cypress', '', 'Indianapolis', 'IN', '33812', 'USA', '44.65782886569191', '-90.05400112170796');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (49, '8335 Oak Willow', '', 'New York', 'NY', '75730', 'USA', '45.32271985604982', '-109.43913056932367');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (50, '3103 Chestnut Linden', '', 'Houston', 'TX', '99324', 'USA', '29.483795826081078', '-99.46963469910924');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (51, '8691 Cottonwood Maple', '', 'Columbus', 'OH', '37394', 'USA', '41.41130646021918', '-76.81220982054758');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (52, '7992 Chestnut Palm', '', 'Los Angeles', 'CA', '88261', 'USA', '42.262010916941485', '-81.41684072286799');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (53, '8025 Blackwood Ash', '', 'Boston', 'MA', '78255', 'USA', '27.258112961379844', '-123.1616082751675');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (54, '8131 Hemlock Aspen', '', 'Portland', 'OR', '85858', 'USA', '27.466235811739192', '-81.58123663985961');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (55, '2636 Alder Chestnut', '', 'Fort Worth', 'TX', '01669', 'USA', '31.73144246514407', '-97.85926522937744');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (56, '559 Laurel Elm', '', 'Dallas', 'TX', '92819', 'USA', '30.60402580758865', '-98.73245650976882');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (57, '5163 Hickory Aspen', '', 'Seattle', 'WA', '02488', 'USA', '27.528700901687767', '-116.88029575971224');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (58, '3403 Hickory Balsam', '', 'El Paso', 'TX', '86902', 'USA', '30.20427050383436', '-100.28546818902758');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (59, '9353 Hemlock Tamarack', '', 'Boston', 'MA', '04024', 'USA', '25.170305925284563', '-109.26521785395327');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (60, '5170 Cedar Beech', '', 'Charlotte', 'NC', '36319', 'USA', '46.31944341573107', '-83.93549476706684');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (61, '7881 Magnolia Hickory', '', 'Jacksonville', 'FL', '12792', 'USA', '27.36832896265514', '-81.40398644621267');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (62, '8486 Teak Holly', '', 'Indianapolis', 'IN', '87800', 'USA', '25.74382266694268', '-79.28152519443536');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (63, '9561 Larch Zelkova', '', 'Denver', 'CO', '64637', 'USA', '39.753174', '-104.94177');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (64, '2215 Ash Pewter', '', 'New York', 'NY', '95247', 'USA', '33.38449431644417', '-107.5907124129787');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (65, '9265 Beech Plum', '', 'Nashville', 'TN', '15133', 'USA', '41.52744266803727', '-94.17662308458364');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (66, '8844 Willow Birch', '', 'Nashville', 'TN', '31994', 'USA', '41.3691711840747', '-83.30552205068122');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (67, '2350 Dogwood Magnolia', '', 'Nashville', 'TN', '19483', 'USA', '30.512815002510628', '-72.7605901370456');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (68, '5789 Elm Alder', '', 'Jacksonville', 'FL', '37789', 'USA', '26.11619558083305', '-81.50277308390703');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (69, '4044 Pecan Olive', '', 'Houston', 'TX', '20747', 'USA', '31.99367803011782', '-100.68402863356569');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (70, '7245 Sequoia Willow', '', 'Seattle', 'WA', '69816', 'USA', '34.70762346434963', '-90.48786191637349');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (71, '9979 Pear Mahogany', '', 'Dallas', 'TX', '66807', 'USA', '33.33404769190296', '-99.7588885712044');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (72, '189 Basswood Ironwood', '', 'Denver', 'CO', '29614', 'USA', '39.7227149', '-104.83662');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (73, '1911 Basswood Pewter', '', 'Las Vegas', 'NV', '04807', 'USA', '42.73610596802107', '-114.381422804492');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (74, '968 Plum Basswood', '', 'Denver', 'CO', '93449', 'USA', '39.7068480', '-104.98265');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (75, '7804 Blackwood Ironwood', '', 'Seattle', 'WA', '38212', 'USA', '41.16813279341608', '-81.33116477902271');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (76, '5104 Beech Aspen', '', 'New York', 'NY', '58192', 'USA', '46.68211138070109', '-71.16769882281076');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (77, '6467 Elm Alder', '', 'Chicago', 'IL', '65013', 'USA', '44.546201959163454', '-104.64639806593568');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (78, '4501 Sequoia Ash', '', 'San Antonio', 'TX', '94537', 'USA', '31.23382249327986', '-98.01535689791493');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (79, '6770 Olive Cedar', '', 'Denver', 'CO', '71783', 'USA', '39.74150783', '-104.84991');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (80, '6357 Spruce Walnut', '', 'Portland', 'OR', '96286', 'USA', '48.267714495512955', '-89.72417792331527');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (81, '8394 Spruce Redwood', '', 'Phoenix', 'AZ', '50763', 'USA', '24.671442147651195', '-113.36089744816022');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (82, '1043 Cedar Hickory', '', 'Philadelphia', 'PA', '27931', 'USA', '26.033692816530685', '-106.02667615224424');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (83, '8288 Oak Ironwood', '', 'Fort Worth', 'TX', '17276', 'USA', '29.67608199786659', '-98.24781472666972');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (84, '9174 Holly Ironwood', '', 'Chicago', 'IL', '09484', 'USA', '44.83308273820861', '-116.46289668293619');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (85, '432 Chestnut Blackwood', '', 'Denver', 'CO', '50171', 'USA', '39.7967979', '-104.806835');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (86, '2296 Poplar Blackwood', '', 'Jacksonville', 'FL', '51563', 'USA', '27.749907424732335', '-81.5349517148025');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (87, '2902 Sycamore Cherry', '', 'Phoenix', 'AZ', '83882', 'USA', '27.360658248233108', '-98.83393159540094');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (88, '3669 Palm Maple', '', 'Los Angeles', 'CA', '17035', 'USA', '44.00050566958322', '-109.60888228919295');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (89, '4016 Zelkova Oak', '', 'Seattle', 'WA', '49719', 'USA', '33.8025804853804', '-101.58097457536252');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (90, '3282 Willow Pecan', '', 'Washington', 'DC', '72587', 'USA', '48.0985197519757', '-69.15158383310423');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (91, '164 Sycamore Oak', '', 'San Francisco', 'CA', '02150', 'USA', '35.23122736632339', '-102.14709447190603');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (92, '2821 Laurel Birch', '', 'Columbus', 'OH', '30984', 'USA', '37.46107975358366', '-84.74727113311914');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (93, '2605 Dogwood Larch', '', 'Las Vegas', 'NV', '82367', 'USA', '38.47875873635789', '-118.94405700980403');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (94, '9229 Olive Hemlock', '', 'Denver', 'CO', '54932', 'USA', '39.7071327', '-104.82470342356841');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (95, '760 Cottonwood Willow', '', 'Boston', 'MA', '75631', 'USA', '29.39089267804996', '-79.0776559284126');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (96, '5207 Redwood Alder', '', 'Philadelphia', 'PA', '72573', 'USA', '27.288779938691036', '-104.95563524663314');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (97, '3338 Larch Cedar', '', 'Indianapolis', 'IN', '54806', 'USA', '32.791713938214116', '-98.52199523887954');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (98, '712 Aspen Larch', '', 'San Antonio', 'TX', '04340', 'USA', '32.92628108183358', '-98.12154771720286');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (99, '1984 Juniper Birch', '', 'Washington', 'DC', '28589', 'USA', '43.463853547357694', '-96.60347528371128');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (100, '6295 Juniper Basswood', '', 'Phoenix', 'AZ', '13156', 'USA', '25.4171066131364', '-110.73091664931255');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (101, '9067 Pine Teak', '', 'Washington', 'DC', '09765', 'USA', '26.165877460694276', '-95.36359316449293');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (102, '1562 Balsam Walnut', '', 'Boston', 'MA', '10804', 'USA', '39.73682500721587', '-97.19161706539865');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (103, '7150 Tamarack Ironwood', '', 'Portland', 'OR', '31010', 'USA', '42.47133542493821', '-89.84528592576115');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (104, '2331 Pine Alder', '', 'El Paso', 'TX', '05176', 'USA', '30.64060222456922', '-98.26849200480352');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (105, '6751 Pine Plum', '', 'San Jose', 'CA', '54322', 'USA', '41.12767738495679', '-83.54605313287628');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (106, '5095 Poplar Laurel', '', 'Dallas', 'TX', '38356', 'USA', '30.904678556208417', '-99.73285495773953');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (107, '7162 Holly Teak', '', 'Charlotte', 'NC', '00335', 'USA', '39.557877927081854', '-106.22944659885931');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (108, '8502 Silk Spruce', '', 'Nashville', 'TN', '98116', 'USA', '28.27818852628687', '-109.20980112249168');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (109, '5957 Ironwood Chestnut', '', 'Portland', 'OR', '31839', 'USA', '34.88502873455575', '-93.39177536002126');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (110, '9103 Pecan Alder', '', 'Columbus', 'OH', '26350', 'USA', '48.96628311554596', '-77.76217741863017');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (111, '7034 Fir Pewter', '', 'Indianapolis', 'IN', '33959', 'USA', '46.40630442747975', '-110.70618886251191');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (112, '4459 Aspen Palm', '', 'El Paso', 'TX', '07522', 'USA', '31.2677098581549', '-100.79325274818794');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (113, '3897 Hickory Holly', '', 'San Antonio', 'TX', '36936', 'USA', '31.503336511524093', '-100.53120515478388');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (114, '1062 Palm Chestnut', '', 'Portland', 'OR', '80770', 'USA', '25.154285533842188', '-87.50161122593411');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (115, '9273 Spruce Plum', '', 'New York', 'NY', '24602', 'USA', '42.84858513959652', '-70.85258699763989');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (116, '9444 Linden Willow', '', 'Dallas', 'TX', '67264', 'USA', '31.22618291994763', '-98.43638018151867');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (117, '9710 Willow Sequoia', '', 'San Diego', 'CA', '26659', 'USA', '31.249103800187566', '-72.98692877222135');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (118, '9679 Pear Tamarack', '', 'Washington', 'DC', '73767', 'USA', '31.736430424283007', '-111.57738705712154');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (119, '6203 Tamarack Alder', '', 'Portland', 'OR', '56263', 'USA', '25.013926860176205', '-95.79370326478264');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`, `latitude`, `longitude`) VALUES (120, '4505 Silk Elm', '', 'Houston', 'TX', '55120', 'USA', '31.36620240974131', '-98.99245476558723');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'admin', 'John', 'Doe', 'jdoe@gmail.com', 61, 'NULL', 'just a silly goofy', '2023-08-27 11:00:00', '34.733862', '-105.680433');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (2, 'Alice123', '$2a$10$KQgnO0rrm.hjSb5bm6eTOe3q3AeM6tx5MZWG1yxweIMXmGs6pgA6K', 1, 'admin', 'Alice', 'Johnson', 'alice@example.com', 62, 'http://fakeurl.com/alice.jpg', 'Passionate about coding and coffee', '2023-08-27 10:15:00', '38.514364', '-110.765645');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (3, 'Bob456', '$2a$10$VH9aQBsEKf5cW4TjUdG2lOoVmXw0tS3b0lF6EGeqV9ZrVlty3RGWm', 1, 'user', 'Bob', 'Smith', 'bob@example.com', 63, 'http://fakeurl.com/bob.jpg', 'Adventurer and book lover', '2023-08-26 14:30:00', '37.861189', '-121.984608');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (4, 'Charlie789', '$2a$10$FLCvj5HXphZS6EojK4FZIu1mN4UePmeOTiJl/EhEUCp5X8pB1zJXm', 1, 'user', 'Charlie', 'Brown', 'charlie@example.com', 64, 'http://fakeurl.com/charlie.jpg', 'Foodie at heart', '2023-08-25 09:45:00', '44.694011', '-123.162729');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (5, 'David987', '$2a$10$X65NzNOeqoOHj4jp5jSxIuKQCMUbTmf9Eg5Fjx3aHIlrXcDV5uv9O', 1, 'user', 'David', 'Miller', 'david@example.com', 65, 'http://fakeurl.com/david.jpg', 'Music is life', '2023-08-24 18:20:00', '38.854244', '-105.049779');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (6, 'William01', '$2a$10$Y7vRuTtVdc.I81C6ffD6mOxVT0v4Zw6iBCChLQabqz4hqFdjLsDD6', 1, 'user', 'William', 'Johnson', 'william@example.com', 66, 'http://fakeurl.com/william.jpg', 'Explorer of nature and wildlife', '2023-08-18 19:25:00', '31.737163', '-98.739461');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (7, 'Maximus34', '$2a$10$Ur.PcAHusntaK08LB9y.KufAKU9Xa.Nb3YPmQg2hvBtJBJVlw6j5i', 1, 'user', 'Maximus', 'Smith', 'maximus@example.com', 67, 'http://fakeurl.com/maximus.jpg', 'Adventurer with a love for the outdoors', '2023-08-26 09:45:00', '33.800536', '-83.946143');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (8, 'Olivia87', '$2a$10$EQLKcFGKpLO3b/jH0/W1..aXrJHroPsTqGwN1rCO0WEg7yTrQ3TDe', 1, 'user', 'Olivia', 'Brown', 'olivia@example.com', 68, 'http://fakeurl.com/olivia.jpg', 'Bookworm and tea enthusiast', '2023-08-25 12:15:00', '35.841274', '-78.417964');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (9, 'Leo123', '$2a$10$qJTptnD2bwg.sq2bUCRuj.59m0dwwgrsI5N9z/9aSxOorWpOwv.kG', 1, 'user', 'Leo', 'Miller', 'leo@example.com', 69, 'http://fakeurl.com/leo.jpg', 'Music lover and aspiring guitarist', '2023-08-24 14:20:00', '28.051661', '-81.484664');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (10, 'Ava456', '$2a$10$az4pIK7qPVq7b/cnPG2Zr.Z9Zi7p9DZ4Pqr7gEmO5uSfZ7FfUn0nW', 1, 'user', 'Ava', 'Johnson', 'ava@example.com', 10, 'http://fakeurl.com/ava.jpg', 'Foodie exploring flavors from around the world', '2023-08-23 17:10:00', '32.640416', '-86.396264');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (11, 'alyssa45', 'hNMeS', 1, 'user', 'Alyssa', 'Alex', 'alyssa.alex@yahoo.com', 11, 'http://fakeimages.com/alyssa_alex.jpg', 'creative honest professional knowledgeable.', '2023-08-28 17:58:16', '24.585979704375077', '-100.15655903667111');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (12, 'nicholas50', 'NDKMd', 1, 'user', 'Nicholas', 'Sarah', 'nicholas.sarah@yahoo.com', 12, 'http://fakeimages.com/nicholas_sarah.jpg', 'patient smart passionate foodie open-minded.', '2023-08-28 17:58:16', '35.06372658773288', '-99.74720718499823');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (13, 'samuel10', 'cck3b', 1, 'user', 'Samuel', 'Kayla', 'samuel.kayla@yahoo.com', 13, 'http://fakeimages.com/samuel_kayla.jpg', 'patient ambitious supportive passionate trustworthy.', '2023-08-28 17:58:16', '40.211269024899316', '-75.53629977600164');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (14, 'jacob24', 'N7ods', 1, 'user', 'Jacob', 'Megan', 'jacob.megan@yahoo.com', 14, 'http://fakeimages.com/jacob_megan.jpg', 'genuine athletic dog-lover.', '2023-08-28 17:58:16', '37.29905382637888', '-74.65583624489031');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (15, 'sarah16', 'avgFs', 1, 'user', 'Sarah', 'John', 'sarah.john@gmail.com', 15, 'http://fakeimages.com/sarah_john.jpg', 'committed passionate meticulous foodie easy-going.', '2023-08-28 17:58:16', '39.45593306494423', '-108.69328727289509');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (16, 'jonathan58', 'NEW9k', 1, 'user', 'Jonathan', 'Samuel', 'jonathan.samuel@yahoo.com', 16, 'http://fakeimages.com/jonathan_samuel.jpg', 'musician meticulous nature-lover passionate motivated open-minded.', '2023-08-28 17:58:16', '37.59323652618055', '-67.35261422312993');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (17, 'nathan20', '8NnGQ', 1, 'user', 'Nathan', 'Justin', 'nathan.justin@yahoo.com', 17, 'http://fakeimages.com/nathan_justin.jpg', 'innovative musician funny intelligent nature-lover.', '2023-08-28 17:58:16', '44.917612029604', '-86.68644207422211');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (18, 'john27', 'PjMTf', 1, 'user', 'John', 'Brianna', 'john.brianna@hotmail.com', 18, 'http://fakeimages.com/john_brianna.jpg', 'sincere supportive patient.', '2023-08-28 17:58:16', '44.641692411628505', '-116.49627358049503');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (19, 'ryan96', '2lccz', 1, 'user', 'Ryan', 'Heather', 'ryan.heather@hotmail.com', 19, 'http://fakeimages.com/ryan_heather.jpg', 'foodie adventurous supportive outgoing genuine intelligent.', '2023-08-28 17:58:16', '32.11559352747053', '-106.8012995704721');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (20, 'lauren73', 'Gmpfo', 1, 'user', 'Lauren', 'Nathan', 'lauren.nathan@hotmail.com', 20, 'http://fakeimages.com/lauren_nathan.jpg', 'tech-savvy ambitious dedicated supportive.', '2023-08-28 17:58:16', '38.321095988441506', '-75.67726045118232');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (21, 'tyler45', 'hT37n', 1, 'user', 'Tyler', 'Nathan', 'tyler.nathan@hotmail.com', 21, 'http://fakeimages.com/tyler_nathan.jpg', 'thoughtful passionate friendly loyal.', '2023-08-28 17:58:16', '36.14937885275977', '-102.01683919889949');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (22, 'hannah49', 'QRUwq', 1, 'user', 'Hannah', 'Megan', 'hannah.megan@gmail.com', 22, 'http://fakeimages.com/hannah_megan.jpg', 'talented honest determined professional tech-savvy dog-lover.', '2023-08-28 17:58:16', '38.67763879537266', '-118.95423864533149');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (23, 'victoria44', 'lk5GJ', 1, 'user', 'Victoria', 'Amanda', 'victoria.amanda@yahoo.com', 23, 'http://fakeimages.com/victoria_amanda.jpg', 'responsible tech-savvy easy-going genuine.', '2023-08-28 17:58:16', '48.998374825287456', '-74.52042429647392');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (24, 'dylan45', '8hGBW', 1, 'user', 'Dylan', 'Daniel', 'dylan.daniel@yahoo.com', 24, 'http://fakeimages.com/dylan_daniel.jpg', 'down-to-earth caring supportive.', '2023-08-28 17:58:16', '42.587541220951934', '-67.03111155959846');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (25, 'jessica96', 'izIGH', 1, 'user', 'Jessica', 'Megan', 'jessica.megan@yahoo.com', 25, 'http://fakeimages.com/jessica_megan.jpg', 'confident innovative loyal.', '2023-08-28 17:58:16', '33.860732395938186', '-117.507940818589');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (26, 'taylor62', 'fvgIC', 1, 'user', 'Taylor', 'Jessica', 'taylor.jessica@hotmail.com', 26, 'http://fakeimages.com/taylor_jessica.jpg', 'dedicated caring funny professional outgoing.', '2023-08-28 17:58:16', '40.4251383402481', '-109.07371277667337');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (27, 'samuel27', 'w16My', 1, 'user', 'Samuel', 'James', 'samuel.james@yahoo.com', 27, 'http://fakeimages.com/samuel_james.jpg', 'sincere supportive smart thoughtful enthusiastic open-minded.', '2023-08-28 17:58:16', '46.64695878046611', '-116.66897126544774');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (28, 'rachel94', 'UHucR', 1, 'user', 'Rachel', 'Joseph', 'rachel.joseph@hotmail.com', 28, 'http://fakeimages.com/rachel_joseph.jpg', 'tech-savvy enthusiastic dedicated hard-working professional.', '2023-08-28 17:58:16', '48.48410199054622', '-82.0446076839628');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (29, 'daniel13', 'eg6px', 1, 'user', 'Daniel', 'Amanda', 'daniel.amanda@yahoo.com', 29, 'http://fakeimages.com/daniel_amanda.jpg', 'hard-working reliable determined.', '2023-08-28 17:58:16', '37.18701965675181', '-101.1276350725719');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (30, 'jonathan71', 'dyPV2', 1, 'user', 'Jonathan', 'Jacob', 'jonathan.jacob@yahoo.com', 30, 'http://fakeimages.com/jonathan_jacob.jpg', 'innovative talented ambitious committed.', '2023-08-28 17:58:16', '40.94867922398609', '-116.16466892946771');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (31, 'amanda37', 'w2aHB', 1, 'user', 'Amanda', 'Courtney', 'amanda.courtney@gmail.com', 31, 'http://fakeimages.com/amanda_courtney.jpg', 'supportive musician motivated creative down-to-earth determined.', '2023-08-28 17:58:16', '47.26074752722392', '-98.4518666582745');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (32, 'hannah33', 'Fywh2', 1, 'user', 'Hannah', 'James', 'hannah.james@hotmail.com', 32, 'http://fakeimages.com/hannah_james.jpg', 'respectful responsible curious nature-lover determined genuine.', '2023-08-28 17:58:16', '26.97932093311346', '-87.4074893962345');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (33, 'brandon20', 'eReUg', 1, 'user', 'Brandon', 'Elizabeth', 'brandon.elizabeth@hotmail.com', 33, 'http://fakeimages.com/brandon_elizabeth.jpg', 'adventurous honest innovative easy-going smart.', '2023-08-28 17:58:16', '28.628652313000135', '-79.4191484822449');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (34, 'kayla76', 'GSnEn', 1, 'user', 'Kayla', 'Andrew', 'kayla.andrew@yahoo.com', 34, 'http://fakeimages.com/kayla_andrew.jpg', 'motivated outgoing supportive.', '2023-08-28 17:58:16', '30.615060547636638', '-81.37731520280789');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (35, 'ashley25', 'T6W7s', 1, 'user', 'Ashley', 'Courtney', 'ashley.courtney@hotmail.com', 35, 'http://fakeimages.com/ashley_courtney.jpg', 'ambitious optimistic patient honest adventurous.', '2023-08-28 17:58:16', '34.91847786167214', '-108.08155073875058');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (36, 'megan18', 'G7E35', 1, 'user', 'Megan', 'Zachary', 'megan.zachary@yahoo.com', 36, 'http://fakeimages.com/megan_zachary.jpg', 'adventurous responsible hard-working talented open-minded passionate.', '2023-08-28 17:58:16', '32.234896673056475', '-110.53755238496905');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (37, 'brandon55', 'QZqVj', 1, 'user', 'Brandon', 'Joseph', 'brandon.joseph@yahoo.com', 37, 'http://fakeimages.com/brandon_joseph.jpg', 'dynamic honest energetic talented ambitious.', '2023-08-28 17:58:16', '47.88929369959718', '-80.03180807845581');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (38, 'matthew24', 'u1GHE', 1, 'user', 'Matthew', 'Rachel', 'matthew.rachel@gmail.com', 38, 'http://fakeimages.com/matthew_rachel.jpg', 'confident supportive innovative musician loyal.', '2023-08-28 17:58:16', '29.268473415157715', '-80.1021439600507');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (39, 'emily50', 'XRDlP', 1, 'user', 'Emily', 'Lauren', 'emily.lauren@gmail.com', 39, 'http://fakeimages.com/emily_lauren.jpg', 'hard-working easy-going dynamic determined trustworthy.', '2023-08-28 17:58:16', '45.35056934246141', '-90.89743842398137');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (40, 'joseph44', 'uP4Gb', 1, 'user', 'Joseph', 'Jasmine', 'joseph.jasmine@yahoo.com', 40, 'http://fakeimages.com/joseph_jasmine.jpg', 'respectful committed tech-savvy patient genuine.', '2023-08-28 17:58:16', '37.95084641884082', '-105.90281477735022');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (41, 'taylor12', 'a903l', 1, 'user', 'Taylor', 'Christopher', 'taylor.christopher@gmail.com', 41, 'http://fakeimages.com/taylor_christopher.jpg', 'intelligent easy-going athletic friendly tech-savvy.', '2023-08-28 17:58:16', '39.9392459285367', '-91.56640934560423');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (42, 'taylor21', 'nOYKe', 1, 'user', 'Taylor', 'Zachary', 'taylor.zachary@gmail.com', 42, 'http://fakeimages.com/taylor_zachary.jpg', 'generous dedicated kind innovative outgoing thoughtful.', '2023-08-28 17:58:16', '39.97496612051397', '-72.19960784221072');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (43, 'brandon62', 'nsypW', 1, 'user', 'Brandon', 'Hannah', 'brandon.hannah@hotmail.com', 43, 'http://fakeimages.com/brandon_hannah.jpg', 'foodie down-to-earth innovative genuine respectful loyal.', '2023-08-28 17:58:16', '38.436290174093585', '-102.80276172791955');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (44, 'tyler13', 'tm3Y0', 1, 'user', 'Tyler', 'Kayla', 'tyler.kayla@gmail.com', 44, 'http://fakeimages.com/tyler_kayla.jpg', 'talented honest traveler dynamic dog-lover.', '2023-08-28 17:58:16', '37.16026362415869', '-88.32897237611257');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (45, 'tyler50', '471Am', 1, 'user', 'Tyler', 'Danielle', 'tyler.danielle@hotmail.com', 45, 'http://fakeimages.com/tyler_danielle.jpg', 'responsible confident enthusiastic dynamic foodie.', '2023-08-28 17:58:16', '43.046765330374384', '-100.02659142952533');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (46, 'hannah40', 'Iez1i', 1, 'user', 'Hannah', 'Ashley', 'hannah.ashley@hotmail.com', 46, 'http://fakeimages.com/hannah_ashley.jpg', 'loyal determined enthusiastic.', '2023-08-28 17:58:16', '45.37293489907617', '-120.25790550578148');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (47, 'ryan87', 'dGxqG', 1, 'user', 'Ryan', 'Heather', 'ryan.heather@yahoo.com', 47, 'http://fakeimages.com/ryan_heather.jpg', 'easy-going traveler funny.', '2023-08-28 17:58:16', '43.86999054079965', '-108.42549791412073');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (48, 'alyssa10', 'AsJhJ', 1, 'user', 'Alyssa', 'Heather', 'alyssa.heather@hotmail.com', 48, 'http://fakeimages.com/alyssa_heather.jpg', 'dedicated reliable trustworthy smart easy-going.', '2023-08-28 17:58:16', '37.81786433567063', '-93.53674034186767');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (49, 'james88', 'lH4D9', 1, 'user', 'James', 'Samuel', 'james.samuel@gmail.com', 49, 'http://fakeimages.com/james_samuel.jpg', 'knowledgeable dynamic motivated.', '2023-08-28 17:58:16', '48.4695032782262', '-119.1965446426177');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (50, 'elizabeth19', 'HsjyO', 1, 'user', 'Elizabeth', 'Sarah', 'elizabeth.sarah@gmail.com', 50, 'http://fakeimages.com/elizabeth_sarah.jpg', 'tech-savvy knowledgeable funny friendly.', '2023-08-28 17:58:16', '40.00990559391465', '-113.99770723808454');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (51, 'elizabeth87', 'UFHiW', 1, 'user', 'Elizabeth', 'Courtney', 'elizabeth.courtney@gmail.com', 51, 'http://fakeimages.com/elizabeth_courtney.jpg', 'passionate innovative patient genuine sincere.', '2023-08-28 17:58:16', '26.49051393706425', '-101.15858444277592');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (52, 'robert58', 'd4iZL', 1, 'user', 'Robert', 'Alex', 'robert.alex@gmail.com', 52, 'http://fakeimages.com/robert_alex.jpg', 'open-minded dedicated sincere.', '2023-08-28 17:58:16', '43.7506744533347', '-90.4844880373769');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (53, 'alexis56', 'pJQOm', 1, 'user', 'Alexis', 'Courtney', 'alexis.courtney@yahoo.com', 53, 'http://fakeimages.com/alexis_courtney.jpg', 'thoughtful sincere reliable.', '2023-08-28 17:58:16', '29.681949003655753', '-110.26035132516432');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (54, 'samuel87', 'Fs9YI', 1, 'user', 'Samuel', 'Emily', 'samuel.emily@gmail.com', 54, 'http://fakeimages.com/samuel_emily.jpg', 'responsible innovative passionate patient funny dog-lover.', '2023-08-28 17:58:16', '39.17610998016751', '-120.89638086276663');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (55, 'alex18', 'eH3Kp', 1, 'user', 'Alex', 'Emily', 'alex.emily@hotmail.com', 55, 'http://fakeimages.com/alex_emily.jpg', 'reliable hard-working enthusiastic professional intelligent.', '2023-08-28 17:58:16', '40.82466074043121', '-82.01142138230585');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (56, 'robert70', 'Extxy', 1, 'user', 'Robert', 'Benjamin', 'robert.benjamin@gmail.com', 56, 'http://fakeimages.com/robert_benjamin.jpg', 'generous thoughtful sincere easy-going ambitious open-minded.', '2023-08-28 17:58:16', '35.544939039413364', '-71.73646878586653');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (57, 'rachel27', 'iKGB4', 1, 'user', 'Rachel', 'Nicholas', 'rachel.nicholas@yahoo.com', 57, 'http://fakeimages.com/rachel_nicholas.jpg', 'committed friendly loyal dog-lover adventurous.', '2023-08-28 17:58:16', '46.590451011896924', '-114.33396197043496');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (58, 'john87', 'p2MUw', 1, 'user', 'John', 'Brandon', 'john.brandon@hotmail.com', 58, 'http://fakeimages.com/john_brandon.jpg', 'friendly determined sincere innovative funny traveler.', '2023-08-28 17:58:16', '40.903463207125', '-101.765351758618');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (59, 'tyler32', 'OZTFJ', 1, 'user', 'Tyler', 'Dylan', 'tyler.dylan@hotmail.com', 59, 'http://fakeimages.com/tyler_dylan.jpg', 'intelligent hard-working athletic professional.', '2023-08-28 17:58:16', '46.101024692313246', '-81.34185722264405');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`, `latitude`, `longitude`) VALUES (60, 'daniel24', 'vVJAq', 1, 'user', 'Daniel', 'Joseph', 'daniel.joseph@yahoo.com', 60, 'http://fakeimages.com/daniel_joseph.jpg', 'dedicated honest outgoing sincere committed athletic.', '2023-08-28 17:58:16', '33.55900004777726', '-75.79209083369764');

COMMIT;


-- -----------------------------------------------------
-- Data for table `restaurant`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (1, 'Izakaya Den', 'https://izakayaden.net/our-menu/', 'assets/izakayaDen.png', '303-777-0691', 1, 1, 'Welcome to Denvers popular Japanese gastro pub serving global cuisine The menu is tapas style serving traditional Japanese plates along with dishes infused with international flavors');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (2, 'Fruition Restaurant', 'https://www.fruitionrestaurant.com/', 'assets/fruition.png', '303-831-1962', 2, 1, 'Special anytime  always an occasion');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (3, 'The Capital Grille', 'https://www.thecapitalgrille.com/locations/co/denver/denver/8018', 'assets/capitalGrille.png', '(303) 539-2500', 3, 1, 'Nationally renowned dry aged steaks  fresh seafood  and acclaimed world class wines With service as gracious as it is attentive  we look forward to impressing you ');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (4, 'D Bar', 'https://www.dbardenver.com/', 'assets/DBar.png', '303-777-0826', 4, 1, 'D Bar is the home of Denvers favorite desserts  Grab a treat out of the pastry case order a custom cake for that special occasion or cozy up to the dessert bar where its prime seating as you watch talented pastry chefs create imaginative plated desserts right before your very eyes  Dessert   its kind of our thing ya know');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (5, 'Guard and Grace ', 'https://www.guardandgrace.com/', 'assets/guardAndGrace.png', '303-293-8500', 5, 1, 'Named after the chefs daughter Guard and Grace is a take on the big fancy modern steakhouse  miles and miles of fiery grills and charcuterie oyster bar and bar tops private rooms and a posh walkin floor to high ceiling glassed wine cellar   yet still  with more of a bright  airy playfulness than the usual dark stiff mano a mano atmosphere');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (6, 'Barolo Grille', 'https://www.barologrilldenver.com/our-story-1', 'assets/BaroloGrille.png', '303.393.1040', 6, 1, 'Barolo Grill prides itself on serving authentic northern Italian food while maintaining a comfortable elegant ambiance Annual staff trips to Italy keep the Barolo Grill dining experience inspired and genuine Hand crafted modern Piemontese cuisine  a spectacular wine cellar  and knowledgeable  attentive staff make Barolo Grill the perfect choice for special occasions or just a great night out');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (7, 'Rioja', 'https://www.riojadenver.com/', 'assets/rioja.png', '303-820-2282', 7, 1, 'a menu inspired by Mediterranean ingredients and influenced by local and seasonal products');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (8, 'Cho Lon Modern Asian', 'http://www.cholon.com/downtown/dinnermenu/', 'assets/choLonModernAsian.png', '303 353 5223', 8, 1, 'ChoLons menu plays on interpretations of traditional dishes found across the Far East combined with slight nods to Lons classical European training');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (9, 'Edge Restaurant & Bar', 'http://www.edgerestaurantdenver.com/', 'assets/Edge.png', '303-389-3050', 9, 1, 'EDGE Restaurant and Bar is a premier American steakhouse influenced by cuisine and culture from around the world  EDGE Restaurant is led by Four Seasons Hotel Denvers Craig Dryhurst and Alec Bruno who infuses passion and creativity into every dining experience EDGE Restaurant utilizes top quality cuts locally sourced Colorado game fresh seafood and produce from nearby farms to cultivate dishes full of seasonal flavors The knowledgeable talented culinary team at EDGE graciously provide intuitive service throughout the contemporary restaurant');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (10, 'Lucile\'s Creole Cafe', 'https://www.luciles.com/denver-location-menu/', 'assets/luciles.png', '303-282-6258', 10, 1, 'Luciles Creole Cafe serves an array of gourmet and delectable breakfast and lunch items. Our mouth-watering menu is simple but varied and our large portions are guaranteed to leave you satisfied.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (70, 'Flavor', 'http://flavor.com', 'http://flavor.com/images/flavor.jpg', '555276716', 70, 1, 'tender artisanal exquisite sumptuous roasted tasty.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (71, 'Kraken', 'http://kraken.com', 'http://kraken.com/images/kraken.jpg', '086403052', 71, 1, 'modern delectable baked fluffy satisfying melted.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (72, 'Yours Truly Cupcake', 'https://yourstrulycupcake.com/', 'assets/cupcake.png', '303.638.3528', 72, 1, 'At Yours Truly Cupcake, we can’t wait to sweeten your celebration. We are a full service dessert catering company & bakery located in the RiNo Arts District of Denver.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (73, 'Taste', 'http://taste.com', 'http://taste.com/images/taste.jpg', '611830967', 73, 1, 'creative timeless spicy tender.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (74, 'Chef Zorbas', 'http://www.chefzorbas.com/', 'assets/greek', ' 303.321.0091', 74, 1, 'Deleicious traditional greek delicacies to enlighten your taste buds.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (75, 'Feast', 'http://feast.com', 'assets/cupcake', '000806976', 75, 1, 'creamy signature distinctive marinated.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (76, 'Galaxy', 'http://galaxy.com', 'http://galaxy.com/images/galaxy.jpg', '053134501', 76, 1, 'refined smoky nutritious elegant roasted hearty zesty.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (77, 'Relish', 'http://relish.com', 'http://relish.com/images/relish.jpg', '772703318', 77, 1, 'sweet creamy distinctive bright creative.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (78, 'Blues', 'http://blues.com', 'http://blues.com/images/blues.jpg', '805215914', 78, 1, 'tangy roasted scrumptious timeless hearty exceptional crunchy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (79, 'Zest', 'http://zest.com', 'assets/cupcake', '660396227', 79, 1, 'gourmet creative artisanal distinctive braised zesty scrumptious seasoned.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (80, 'Bliss', 'http://bliss.com', 'http://bliss.com/images/bliss.jpg', '618834679', 80, 1, 'satisfying elegant fluffy unique.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (81, 'Starlight', 'http://starlight.com', 'http://starlight.com/images/starlight.jpg', '039645238', 81, 1, 'exceptional melted fresh sumptuous.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (82, 'Tavern', 'http://tavern.com', 'http://tavern.com/images/tavern.jpg', '359235395', 82, 1, 'magnificent sumptuous exquisite authentic memorable.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (83, 'Tavern', 'http://tavern.com', 'http://tavern.com/images/tavern.jpg', '676450610', 83, 1, 'scrumptious outstanding satisfying exceptional.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (84, 'Savory', 'http://savory.com', 'http://savory.com/images/savory.jpg', '932608841', 84, 1, 'smoky steamed toasted scrumptious magnificent bright rich exquisite.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (85, 'Lavender', 'http://lavender.com', 'http://lavender.com/images/lavender.jpg', '392371935', 85, 1, 'signature spicy tangy nutritious exquisite seasoned.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (86, 'Sunrise', 'http://sunrise.com', 'http://sunrise.com/images/sunrise.jpg', '248064843', 86, 1, 'spicy marinated seasoned braised smoky.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (87, 'Phoenix', 'http://phoenix.com', 'http://phoenix.com/images/phoenix.jpg', '801020737', 87, 1, 'delicious modern braised crunchy steamed satisfying fresh.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (88, 'Harvest', 'http://harvest.com', 'http://harvest.com/images/harvest.jpg', '385492229', 88, 1, 'nutritious creamy steamed artisanal signature.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (89, 'Midnight', 'http://midnight.com', 'http://midnight.com/images/midnight.jpg', '923286822', 89, 1, 'distinctive seasoned wholesome crisp marinated.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (90, 'Symphony', 'http://symphony.com', 'http://symphony.com/images/symphony.jpg', '631609060', 90, 1, 'artisanal seasoned sweet crunchy creative rich innovative melted.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (91, 'Harbor', 'http://harbor.com', 'http://harbor.com/images/harbor.jpg', '989649631', 91, 1, 'fresh filling fluffy zesty tender.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (92, 'Saffron', 'http://saffron.com', 'http://saffron.com/images/saffron.jpg', '638677012', 92, 1, 'rich magnificent sumptuous delectable bright.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (93, 'Galaxy', 'http://galaxy.com', 'http://galaxy.com/images/galaxy.jpg', '731914746', 93, 1, 'scrumptious sweet juicy gourmet innovative braised hearty satisfying.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (94, 'Joy', 'http://joy.com', 'http://joy.com/images/joy.jpg', '127277501', 94, 1, 'rich bright roasted spicy timeless delectable juicy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (95, 'Blues', 'http://blues.com', 'http://blues.com/images/blues.jpg', '025006073', 95, 1, 'roasted smoky modern exceptional spicy outstanding timeless.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (96, 'Relish', 'http://relish.com', 'http://relish.com/images/relish.jpg', '261597912', 96, 1, 'outstanding exceptional traditional grilled zesty wholesome delicious.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (97, 'Rhapsody', 'http://rhapsody.com', 'http://rhapsody.com/images/rhapsody.jpg', '280392234', 97, 1, 'nutritious spicy filling creative.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (98, 'Harvest', 'http://harvest.com', 'http://harvest.com/images/harvest.jpg', '967458242', 98, 1, 'fried fluffy refined satisfying.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (99, 'Rhapsody', 'http://rhapsody.com', 'http://rhapsody.com/images/rhapsody.jpg', '967556306', 99, 1, 'seasoned nutritious memorable grilled.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (100, 'Marina', 'http://marina.com', 'http://marina.com/images/marina.jpg', '869733719', 100, 1, 'magnificent grilled braised wholesome.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (101, 'Flavor', 'http://flavor.com', 'http://flavor.com/images/flavor.jpg', '446936206', 101, 1, 'signature modern scrumptious nutritious marinated unique.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (102, 'Harvest', 'http://harvest.com', 'http://harvest.com/images/harvest.jpg', '831126599', 102, 1, 'juicy creative hearty roasted sweet rich.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (103, 'Breeze', 'http://breeze.com', 'http://breeze.com/images/breeze.jpg', '644268402', 103, 1, 'refined baked signature memorable filling.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (104, 'Taste', 'http://taste.com', 'http://taste.com/images/taste.jpg', '502286010', 104, 1, 'toasted fried memorable timeless.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (105, 'Orchid', 'http://orchid.com', 'http://orchid.com/images/orchid.jpg', '021606865', 105, 1, 'steamed nutritious hearty grilled.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (106, 'Harbor', 'http://harbor.com', 'http://harbor.com/images/harbor.jpg', '103439651', 106, 1, 'juicy signature sumptuous sweet tasty crisp tender artisanal.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (107, 'Midnight', 'http://midnight.com', 'http://midnight.com/images/midnight.jpg', '680120871', 107, 1, 'nutritious authentic filling tasty.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (108, 'Twilight', 'http://twilight.com', 'http://twilight.com/images/twilight.jpg', '702079916', 108, 1, 'toasted creamy crisp fluffy roasted.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (109, 'Rhythm', 'http://rhythm.com', 'http://rhythm.com/images/rhythm.jpg', '077274490', 109, 1, 'steamed distinctive melted crunchy smoky fresh.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (110, 'Melody', 'http://melody.com', 'http://melody.com/images/melody.jpg', '044663208', 110, 1, 'marinated satisfying exquisite hearty delectable modern exceptional tasty.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (111, 'Galaxy', 'http://galaxy.com', 'http://galaxy.com/images/galaxy.jpg', '449309994', 111, 1, 'artisanal sumptuous fluffy elegant tender exquisite traditional crunchy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (112, 'Titan', 'http://titan.com', 'http://titan.com/images/titan.jpg', '137388111', 112, 1, 'filling melted bright satisfying steamed.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (113, 'Orchid', 'http://orchid.com', 'http://orchid.com/images/orchid.jpg', '559185136', 113, 1, 'seasoned memorable elegant delectable crunchy magnificent creative.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (114, 'Flavor', 'http://flavor.com', 'http://flavor.com/images/flavor.jpg', '072506723', 114, 1, 'baked melted marinated traditional nutritious delicious braised sumptuous.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (115, 'Galaxy', 'http://galaxy.com', 'http://galaxy.com/images/galaxy.jpg', '890385814', 115, 1, 'braised savory tender sumptuous bright magnificent fluffy innovative.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (116, 'Melody', 'http://melody.com', 'http://melody.com/images/melody.jpg', '390670600', 116, 1, 'marinated sweet crunchy fried exquisite hearty creative innovative.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (117, 'Midnight', 'http://midnight.com', 'http://midnight.com/images/midnight.jpg', '603116771', 117, 1, 'zesty exquisite sumptuous juicy roasted scrumptious magnificent unique.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (118, 'Harvest', 'http://harvest.com', 'http://harvest.com/images/harvest.jpg', '327664497', 118, 1, 'delicious rich sumptuous gourmet juicy.');
INSERT INTO `restaurant` (`id`, `name`, `restaurant_url`, `image_url`, `phone_number`, `address_id`, `enabled`, `description`) VALUES (119, 'Harvest', 'http://harvest.com', 'http://harvest.com/images/harvest.jpg', '680944276', 119, 1, 'fluffy spicy seasoned braised.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (1, 1, 'Izakaya Den Dinner lunch', 1, 'sushi sashimi and udon and more');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (2, 1, 'Izakaya Den Dinner ', 1, 'Sashimi and rolls');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (3, 2, 'Fruition Dinner ', 1, 'dinner');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (4, 3, 'Capital Grille Dinner', 1, 'Dinner');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (5, 4, 'D Bar Desserts', 1, 'desserts');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (6, 72, 'YoursTrulyCupcakes Desserts', 1, 'cupcakes');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (7, 74, 'Zorbas Lunch', 1, 'Greek');
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (8, 5, 'Guard and Grace Dinner', 1, NULL);
INSERT INTO `menu` (`id`, `restaurant_id`, `type`, `enabled`, `description`) VALUES (9, 6, 'Barolo Grille Dinner', 1, 'Italian and steakhouse');

COMMIT;


-- -----------------------------------------------------
-- Data for table `menu_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (1, 'Wagyu Beef Kushiyaki', NULL, 2, 22, 'shimeji mushrooms truffle infused mashed potatoes with a teriyaki sauce', 150, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (2, 'Sriracha Garlic Shrimp', '', 2, 36, 'Grilled spicy jumbo tiger shrimp drizzled with a roasted red pepper chili sauce atop whipped potatoes plus mango salsa', 200, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (3, 'Sashimi Dinner', '', 2, 38, 'Tuna Yellowtail Salmon White Fish Scallop Shrimp and Octopus nigiri', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (4, 'Wagyu Beef Roll', '', 1, 38, 'Wagyu beef lettuce scallions shichimi asparagus sesame seeds and mayo', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (5, 'Tuna Firecracker Roll', '', 1, 25, 'Spicy Tuna mayo mix avocado cucumber tempura flakes and amadare on the inside topped with diced red and yellow peppers red onion wasabi tobiko jalapeno and cilantro', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (6, 'Crispy Bincho Roll', '', 1, 42, 'Tempura fried albacore tuna cream cheese masago burdock root asparagus avocado tempura flakes sesame seeds and sriracha mayo wrapped with soy paper', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (7, 'Grilled Wellfleet Oysters', '', 3, 25.25, 'with calabrian chili lardo and herbed bread crumb', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (8, 'White Shrimp Agnolotti', '', 3, 23.23, 'with preserved fennel and spicy shrimp bisque', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (9, 'Sauteed Barramundi', '', 3, 48.48, 'with buttered spinach baby artichokes and smoked trout roe emulsion ', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (10, 'Steak Tartare', '', 4, 18, 'Served with capers chives sweet onion hard boiled egg and brioche toasts', 1, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (11, 'Grand Plateau', NULL, 4, 108, 'Jumbo lump crab North Atlantic lobster  shrimp cocktail oysters on the half shell', NULL, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (12, 'Bone In Kona Crusted Dry Aged NY Strip with Shallot Butter', NULL, 4, 58, 'Our acclaimed coffee rubbed boldly flavored New York strip', NULL, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (13, 'Delicious Chocolate Cake', '', 5, 15.5, 'Indulge in the richness of our Delicious Chocolate Cake', 760, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (14, 'Caramel Pecan Pie', '', 5, 7.2, 'Enjoy the sweet and nutty flavors of our Caramel Pecan Pie', 421, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (15, 'Raspberry Cheesecake', '', 5, 12.8, 'Experience the perfect balance of tangy raspberries and creamy cheesecake', 283, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (16, 'Decadent Tiramisu', '', 5, 9.9, 'Treat yourself to the elegance of our Decadent Tiramisu dessert', 619, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (17, 'Strawberry Shortcake', '', 5, 18.3, 'Savor the freshness of ripe strawberries and fluffy shortcake', 874, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (18, 'Chocolate Cupcake', '', 6, 9.75, 'Indulge in the rich chocolate flavor of our Chocolate Cupcake.', 425, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (19, 'Strawberry Vanilla Cupcake', '', 6, 6.25, 'Experience the delightful combination of strawberries and vanilla in our Strawberry Vanilla Cupcake.', 280, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (20, 'Caramel Swirl Cupcake', '', 6, 8.50, 'Enjoy the sweet and gooey goodness of our Caramel Swirl Cupcake.', 360, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (21, 'Raspberry Lemon Cupcake', '', 6, 7.80, 'Savor the tangy freshness of raspberries paired with the zesty kick of lemon in our Raspberry Lemon Cupcake.', 315, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (22, 'Red Velvet Cupcake', '', 6, 10.20, 'Indulge in the classic elegance of our Red Velvet Cupcake  a velvety delight for your taste buds.', 450, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (23, 'Moussaka', '', 7, 18.50, 'Indulge in the layers of flavors in our delicious Moussaka  a traditional Greek dish with eggplant', 259, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (24, 'Gyro Platter', '', 7, 12.75, 'Experience the savory delight of our Gyro Platter  featuring thinly sliced lamb or chicken', 569, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (25, 'Spanakopita', '', 7, 9.25, 'Savor the flaky layers of phyllo dough filled with spinach and feta cheese in our delightful Spanakopita a Greek classic.', 458, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (26, 'Souvlaki Skewers', '', 7, 14.80, 'Enjoy the succulent marinated meat on skewers in our Souvlaki Skewers served with pita', 698, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (27, 'Greek Salad', '', 7, 45.50, 'Refresh your palate with our fresh and vibrant Greek Salad featuring crisp vegetables', 250, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (28, 'Filet Mignon', '', 8, 45.75, 'Indulge in the tenderness of our Filet Mignon  a prime cut of beef cooked to perfection and served with your choice of sides.', 750, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (29, 'Ribeye Steak', '', 8, 58.50, 'Savor the rich flavor and marbling of our Ribeye Steak a classic favorite for steak enthusiasts.', 480, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (30, 'New York Strip', '', 8, 52.25, 'Enjoy the bold taste of our New York Strip a well-marbled steak with a juicy and robust flavor profile.', 420, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (31, 'Porterhouse Steak', '', 8, 70.80, 'Experience the best of both worlds with our Porterhouse Steak featuring a tender filet and a flavorful strip steak.', 550, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (32, 'T-Bone Steak', '', 8, 62.90, 'Delight in the hearty flavor of our T Bone Steak a combination of tenderloin and strip steak on the bone.', 490, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (33, 'Bruschetta', '', 9, 9.25, 'Enjoy the classic flavors of our Bruschetta featuring toasted bread topped with fresh tomatoes garlic basil and olive oil.', 180, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (34, 'Osso Buco', '', 9, 42.75, 'Indulge in the richness of our Osso Buco a traditional Italian dish of braised veal shanks served with gremolata.', 560, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (35, 'Fettuccine Alfredo with Steak', '', 9, 28.50, 'Savor the creamy goodness of our Fettuccine Alfredo paired with tender slices of steak for a luxurious Italian steakhouse experience.', 420, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (36, 'Chicken Marsala', '', 9, 24.80, 'Delight in the savory and sweet flavors of our Chicken Marsala featuring tender chicken cooked in a rich Marsala wine sauce.', 320, 1);
INSERT INTO `menu_item` (`id`, `item_name`, `item_url`, `menu_id`, `price`, `description`, `calories`, `enabled`) VALUES (37, 'Italian Ribeye', '', 9, 62.90, 'Experience the Italian twist on a classic Ribeye Steak served with a fragrant herb and garlic marinade for an extra burst of flavor.', 480, 1);

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
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (1, 'Dessert', 'yum', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (2, 'Italian', 'Indulge in the rich flavors of Italian cuisine, from pasta to pizza.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (3, 'japanese', 'Experience the art of sushi, sashimi, and delicate Japanese flavors.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (4, 'sushi', 'Spice up your palate with vibrant Mexican dishes and bold spices.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (5, 'steakhouse', 'Embark on a journey through aromatic curries, naan, and Indian spices.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (6, 'Greek', 'Savor the variety of Chinese dishes, from stir-fries to dim sum.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (7, 'french', 'Elevate your dining with elegant French classics and refined flavors.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (8, 'thai', 'Delight in the balance of sweet, sour, salty, and spicy Thai cuisine.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (9, 'american', 'Indulge in American comfort food, from burgers to mac and cheese.', NULL);
INSERT INTO `cuisine` (`id`, `type`, `description`, `icon_url`) VALUES (10, 'seafood', 'seafood', NULL);

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
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (2, 5, 8, 'A hidden gem with a cozy ambiance and delectable menu.', ' 2023-08-27 14:30:00', ' 2023-08-27 14:30:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (3, 3, 4, 'A bustling spot known for its lively atmosphere and diverse cuisine.', ' 2023-08-26 12:45:00', ' 2023-08-26 12:45:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (4, 8, 6, 'An upscale dining experience with an extensive wine selection.', ' 2023-08-25 10:20:00', ' 2023-08-25 10:20:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (5, 2, 2, 'A family-friendly restaurant famous for its hearty comfort food.', ' 2023-08-24 18:15:00', ' 2023-08-24 18:15:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (6, 7, 9, 'A beachfront paradise offering fresh seafood and stunning views.', ' 2023-08-23 16:30:00', ' 2023-08-23 16:30:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (7, 6, 7, 'A vibrant establishment serving global cuisine in a lively setting.', ' 2023-08-22 13:10:00', ' 2023-08-22 13:10:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (8, 4, 5, 'A charming cafe perfect for a quick bite or a leisurely brunch.', ' 2023-08-21 11:45:00', ' 2023-08-21 11:45:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (9, 9, 1, 'A trendy spot known for its innovative dishes and chic decor.', ' 2023-08-20 09:30:00', ' 2023-08-20 09:30:00', 1);
INSERT INTO `comment` (`id`, `restaurant_id`, `user_id`, `content`, `create_date`, `update_date`, `enabled`) VALUES (10, 10, 3, 'An authentic eatery where traditional recipes shine.', ' 2023-08-19 07:55:00', ' 2023-08-19 07:55:00', 1);

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
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (1, 3);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (2, 3);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (3, 3);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (4, 4);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (5, 4);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (6, 4);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (7, 5);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (8, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (9, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (10, 5);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (13, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (14, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (15, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (16, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (17, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (18, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (19, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (20, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (21, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (22, 1);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (23, 6);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (24, 6);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (25, 6);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (26, 6);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (27, 6);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (28, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (29, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (30, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (31, 2);
INSERT INTO `menu_item_has_cuisine` (`menu_item_id`, `cuisine_id`) VALUES (32, 2);

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

