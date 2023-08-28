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
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (1, '123', 'street', 'colorado springs', 'CO', '12345', NULL);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (2, '345', 'way', 'turkeyville', 'CA', '45678', NULL);
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (3, '123 Main St', '', 'Springfield', 'IL', '12345', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (4, '456 Oak Ave', '', 'Maplewood', 'NJ', '54321', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (5, '789 Elm Rd', 'Unit 204', 'Riverside', 'CA', '98765', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (6, '234 Pine St', '', 'Greenwood', 'SC', '34567', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (7, '567 Maple Ln', '', 'Boulder', 'CO', '67890', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (8, '890 Cedar Ave', '', 'Portland', 'OR', '45678', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (9, '123 Pineapple St', 'Apartment 101', 'Honolulu', 'HI', '23456', '');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zipcode`, `country`) VALUES (10, '456 Cherry Blvd', '', 'Cherry Hill', 'NJ', '76543', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `flavorscapedb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'admin', 'John', 'Doe', 'jdoe@gmail.com', 1, NULL, 'just a silly goofy', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (2, 'Alice123', '$2a$10$KQgnO0rrm.hjSb5bm6eTOe3q3AeM6tx5MZWG1yxweIMXmGs6pgA6K', true, 'admin', 'Alice', 'Johnson', 'alice@example.com', 2, 'http://fakeurl.com/alice.jpg', 'Passionate about coding and coffee', '2023-08-27 10:15:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (3, 'Bob456', '$2a$10$VH9aQBsEKf5cW4TjUdG2lOoVmXw0tS3b0lF6EGeqV9ZrVlty3RGWm', true, 'user', 'Bob', 'Smith', 'bob@example.com', 3, 'http://fakeurl.com/bob.jpg', 'Adventurer and book lover', '2023-08-26 14:30:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (4, 'Charlie789', '$2a$10$FLCvj5HXphZS6EojK4FZIu1mN4UePmeOTiJl/EhEUCp5X8pB1zJXm', true, 'user', 'Charlie', 'Brown', 'charlie@example.com', 4, 'http://fakeurl.com/charlie.jpg', 'Foodie at heart', '2023-08-25 09:45:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (5, 'David987', '$2a$10$X65NzNOeqoOHj4jp5jSxIuKQCMUbTmf9Eg5Fjx3aHIlrXcDV5uv9O', true, 'user', 'David', 'Miller', 'david@example.com', 5, 'http://fakeurl.com/david.jpg', 'Music is life', '2023-08-24 18:20:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (6, 'William01', '$2a$10$Y7vRuTtVdc.I81C6ffD6mOxVT0v4Zw6iBCChLQabqz4hqFdjLsDD6', true, 'user', 'William', 'Johnson', 'william@example.com', 6, 'http://fakeurl.com/william.jpg', 'Explorer of nature and wildlife', '2023-08-18 19:25:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (7, 'Maximus34', '$2a$10$Ur.PcAHusntaK08LB9y.KufAKU9Xa.Nb3YPmQg2hvBtJBJVlw6j5i', true, 'user', 'Maximus', 'Smith', 'maximus@example.com', 7, 'http://fakeurl.com/maximus.jpg', 'Adventurer with a love for the outdoors', '2023-08-26 09:45:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (8, 'Olivia87', '$2a$10$EQLKcFGKpLO3b/jH0/W1..aXrJHroPsTqGwN1rCO0WEg7yTrQ3TDe', true, 'user', 'Olivia', 'Brown', 'olivia@example.com', 8, 'http://fakeurl.com/olivia.jpg', 'Bookworm and tea enthusiast', '2023-08-25 12:15:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (9, 'Leo123', '$2a$10$qJTptnD2bwg.sq2bUCRuj.59m0dwwgrsI5N9z/9aSxOorWpOwv.kG', true, 'user', 'Leo', 'Miller', 'leo@example.com', 9, 'http://fakeurl.com/leo.jpg', 'Music lover and aspiring guitarist', '2023-08-24 14:20:00');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `email`, `address_id`, `image_url`, `about_me`, `create_date`) VALUES (10, 'Ava456', '$2a$10$az4pIK7qPVq7b/cnPG2Zr.Z9Zi7p9DZ4Pqr7gEmO5uSfZ7FfUn0nW', true, 'user', 'Ava', 'Johnson', 'ava@example.com', 10, 'http://fakeurl.com/ava.jpg', 'Foodie exploring flavors from around the world', '2023-08-23 17:10:00');

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

