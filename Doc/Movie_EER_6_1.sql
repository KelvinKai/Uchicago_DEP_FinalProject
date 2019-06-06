
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE= 'ALLOW_INVALID_DATES';

<<<<<<< HEAD
# SET FOREIGN_KEY_CHECKS = 0;
=======

>>>>>>> cf02e5cbe0a6675efb60aeb5a88b2c8bf9ae96d4
-- -----------------------------------------------------
-- Schema movie
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `movie` DEFAULT CHARACTER SET latin1;
USE `movie` ;

-- -----------------------------------------------------
-- Table `movie`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`movie` (
    `movie_id` INT NOT NULL,
    `title` LONGTEXT NULL,
    `original_language` TEXT NULL,
    `status` TEXT NULL,
    `revenue` INT NULL,
    `budget` INT NULL,
    `release_date` TEXT NULL,
    `runtime` INT NULL,
    `popularity` FLOAT NULL,
    `vote_average` FLOAT NULL,
    `vote_count` INT NULL,
    `major_production_country` VARCHAR(45) NULL,
    `major_genre` INT(11) NULL,
    PRIMARY KEY (`major_production_country`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`production_country` (`production_country_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`major_genre`)
        REFERENCES `movie`.`genre` (`genre_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;

-- -----------------------------------------------------
-- Table `movie`.`Movie_Links_Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`imdb` (
    `imdb_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    PRIMARY KEY (`imdb_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`rating` (
    `rating_id` INT NOT NULL,
    `imdb_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `rating` FLOAT NOT NULL,
    PRIMARY KEY (`rating_id`),
    FOREIGN KEY (`imdb_id`)
        REFERENCES `movie`.`imdb` (`imdb_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`genre` (
    `genre_id` INT NOT NULL,
    `genre_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`genre_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Movie_Genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`movie_genre` (
    `movie_genre_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    `genre_id` INT NOT NULL,
    PRIMARY KEY (`movie_genre_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`genre_id`)
        REFERENCES `movie`.`genre` (`genre_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`production_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`production_company` (
    `production_co_id` INT NOT NULL,
    `production_co_name` LONGTEXT NULL,
    PRIMARY KEY (`production_co_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Movie_Production_Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`movie_production_company` (
    `movie_production_co_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    `production_co_id` INT NOT NULL,
    PRIMARY KEY (`movie_production_co_id`),
    FOREIGN KEY (`production_co_id`)
        REFERENCES `movie`.`production_company` (`production_co_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;




-- -----------------------------------------------------
-- Table `movie`.`Production_Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`production_country` (
  `production_country_code` VARCHAR(10) NOT NULL,
  `production_country_name` VARCHAR(245) NULL,
  PRIMARY KEY (`production_country_code`))
ENGINE = InnoDB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Movie_Production_Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`movie_production_country` (
    `movie_production_country_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    `production_country_code` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`movie_production_country_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`production_country_code`)
        REFERENCES `movie`.`production_country` (`production_country_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Spoken_Language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`spoken_language` (
    `language_code` VARCHAR(45) NOT NULL,
    `language_name` VARCHAR(245) NOT NULL,
    PRIMARY KEY (`language_code`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Movie_Spoken_Language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`movie_spoken_language` (
    `movie_language_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    `language_code` VARCHAR(245) NULL,
    PRIMARY KEY (`movie_language_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`language_code`)
        REFERENCES `movie`.`spoken_language` (`language_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie`.`Cast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`cast` (
    `cast_id` INT NOT NULL,
    `gender` SET('M', 'F') NOT NULL,
    `cast_name` VARCHAR(245) NOT NULL,
    PRIMARY KEY (`cast_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;

-- -----------------------------------------------------
-- Table `movie`.`Movie_Cast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie`.`movie_cast` (
    `movie_cast_id` INT NOT NULL,
    `cast_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    `cast_character` LONGTEXT NOT NULL,
    PRIMARY KEY (`movie_cast_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`cast_id`)
        REFERENCES `movie`.`cast` (`cast_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


