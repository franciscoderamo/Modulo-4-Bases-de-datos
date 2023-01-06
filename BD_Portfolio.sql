-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`person` (
  `DNI` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `resume` VARCHAR(60) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `about` VARCHAR(150) NOT NULL,
  `image` VARCHAR(100) NOT NULL,
  `whatsapp` INT NOT NULL,
  `github` VARCHAR(100) NOT NULL,
  `linkedin` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `ubication` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`DNI` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`services` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `person_DNI`),
  INDEX `fk_services_person1_idx` (`person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_services_person1`
    FOREIGN KEY (`person_DNI`)
    REFERENCES `portfolio`.`person` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`skilll_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`skilll_group` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  `ages` INT NOT NULL,
  `icon` VARCHAR(45) NOT NULL,
  `person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_skilll_group_person1_idx` (`person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_skilll_group_person1`
    FOREIGN KEY (`person_DNI`)
    REFERENCES `portfolio`.`person` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`skill` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `porcentage` INT NOT NULL,
  `skilll_group_ID` INT NOT NULL,
  `skilll_group_person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `skilll_group_ID`, `skilll_group_person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_skill_skilll_group1_idx` (`skilll_group_ID` ASC, `skilll_group_person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_skill_skilll_group1`
    FOREIGN KEY (`skilll_group_ID` , `skilll_group_person_DNI`)
    REFERENCES `portfolio`.`skilll_group` (`ID` , `person_DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`portfolio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`portfolio` (
  `ID` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `image` VARCHAR(100) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `link` VARCHAR(100) NOT NULL,
  `services_ID` INT NOT NULL,
  `services_person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `services_ID`, `services_person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_portfolio_services1_idx` (`services_ID` ASC, `services_person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_portfolio_services1`
    FOREIGN KEY (`services_ID` , `services_person_DNI`)
    REFERENCES `portfolio`.`services` (`ID` , `person_DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`studies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`studies` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(60) NOT NULL,
  `institution` VARCHAR(45) NOT NULL,
  `start` YEAR(4) NOT NULL,
  `end` YEAR(4) NULL,
  `person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_studies_person_idx` (`person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_studies_person`
    FOREIGN KEY (`person_DNI`)
    REFERENCES `portfolio`.`person` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`worked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`worked` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `job` VARCHAR(45) NOT NULL,
  `bussines` VARCHAR(45) NOT NULL,
  `start` YEAR(4) NOT NULL,
  `end` YEAR(4) NOT NULL,
  `person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_worked_person1_idx` (`person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_worked_person1`
    FOREIGN KEY (`person_DNI`)
    REFERENCES `portfolio`.`person` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experience` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(45) NOT NULL,
  `ages` INT NOT NULL,
  `person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_experience_person1_idx` (`person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_experience_person1`
    FOREIGN KEY (`person_DNI`)
    REFERENCES `portfolio`.`person` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`users` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nicename` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`task` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(60) NOT NULL,
  `services_ID` INT NOT NULL,
  `services_person_DNI` INT NOT NULL,
  PRIMARY KEY (`ID`, `services_ID`, `services_person_DNI`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_task_services1_idx` (`services_ID` ASC, `services_person_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_task_services1`
    FOREIGN KEY (`services_ID` , `services_person_DNI`)
    REFERENCES `portfolio`.`services` (`ID` , `person_DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
