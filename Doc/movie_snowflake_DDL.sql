
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE= 'ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema movie_snowflake
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `movie_snowflake` DEFAULT CHARACTER SET latin1;
USE `movie_snowflake` ;


-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_movie`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `movie_snowflake`.`dim_movie` (
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
	`count_production_company` INT NULL,
    `count_production_country` INT NULL,
    `count_genre` INT NULL,
    `count_cast` INT NULL,
	`count_spoken_language` INT NULL,
    PRIMARY KEY (`movie_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;



-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_imdb`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `movie_snowflake`.`dim_imdb` (
    `imdb_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    PRIMARY KEY (`imdb_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `movie_snowflake`.`dim_movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;



-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_snowflake`.`dim_genre` (
    `genre_id` INT NOT NULL,
    `genre_name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`genre_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_production_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_snowflake`.`dim_production_country` (
    `production_country_code` VARCHAR(10) NOT NULL,
    `production_country_name` VARCHAR(245) NULL,
    PRIMARY KEY (`production_country_code`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;

CREATE TABLE IF NOT EXISTS `movie_snowflake`.`dim_time` (
  `date_id` varchar(45) NOT NULL,
  `year` varchar(10) NULL DEFAULT NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = LATIN1;

-- -----------------------------------------------------
-- Table `movie_snowflake`.`fact`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `movie_snowflake`.`fact` (
    `rating_id` INT NOT NULL,
    `imdb_id` INT NULL,
    `production_country_code` VARCHAR(45) NULL,
    `genre_id` INT NULL,
	`release_date` varchar(45),
    `rating` FLOAT NULL,
    `user_id` INT NULL,
    PRIMARY KEY (`rating_id`),
	FOREIGN KEY (`release_date`)
	REFERENCES `movie_snowflake`.`dim_time` (`date_id`)
	ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`imdb_id`)
        REFERENCES `movie_snowflake`.`dim_imdb` (`imdb_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`genre_id`)
        REFERENCES `movie_snowflake`.`dim_genre` (`genre_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`production_country_code`)
        REFERENCES `movie_snowflake`.`dim_production_country` (`production_country_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
	
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;