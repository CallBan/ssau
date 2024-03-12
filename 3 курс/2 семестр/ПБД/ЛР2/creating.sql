-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema airport
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airport
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airport` DEFAULT CHARACTER SET utf8 ;
USE `airport` ;

-- -----------------------------------------------------
-- Table `airport`.`admissionGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`admissionGroup` (
  `idadmissionGroup` INT NOT NULL,
  PRIMARY KEY (`idadmissionGroup`),
  UNIQUE INDEX `idgroup_UNIQUE` (`idadmissionGroup` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`crewInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`crewInfo` (
  `idcrew` INT NOT NULL,
  `idadmissionGroup` INT NOT NULL,
  PRIMARY KEY (`idcrew`),
  UNIQUE INDEX `idcrew_UNIQUE` (`idcrew` ASC) VISIBLE,
  INDEX `fk_crew_group1_idx` (`idadmissionGroup` ASC) VISIBLE,
  CONSTRAINT `fk_crew_group1`
    FOREIGN KEY (`idadmissionGroup`)
    REFERENCES `airport`.`admissionGroup` (`idadmissionGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`mark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`mark` (
  `idmark` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `idadmissionGroup` INT NOT NULL,
  PRIMARY KEY (`idmark`),
  UNIQUE INDEX `idmark_UNIQUE` (`idmark` ASC) VISIBLE,
  UNIQUE INDEX `markcol_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_mark_group1_idx` (`idadmissionGroup` ASC) VISIBLE,
  CONSTRAINT `fk_mark_group1`
    FOREIGN KEY (`idadmissionGroup`)
    REFERENCES `airport`.`admissionGroup` (`idadmissionGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`airplane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`airplane` (
  `idairplane` INT NOT NULL,
  `speed` INT NOT NULL,
  `height` INT NOT NULL,
  `takeOffWeight` INT NOT NULL,
  `tailNumber` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `seats` INT NOT NULL,
  `fuel` VARCHAR(45) NOT NULL,
  `takeoffRun` INT NOT NULL,
  `idmark` INT NOT NULL,
  PRIMARY KEY (`idairplane`),
  UNIQUE INDEX `idairplane_UNIQUE` (`idairplane` ASC) VISIBLE,
  UNIQUE INDEX `airplanecol_UNIQUE` (`tailNumber` ASC) VISIBLE,
  INDEX `fk_airplane_mark1_idx` (`idmark` ASC) VISIBLE,
  CONSTRAINT `fk_airplane_mark1`
    FOREIGN KEY (`idmark`)
    REFERENCES `airport`.`mark` (`idmark`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`Country` (
  `idCountry` INT NOT NULL,
  `Countrycol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCountry`),
  UNIQUE INDEX `idCountry_UNIQUE` (`idCountry` ASC) VISIBLE,
  UNIQUE INDEX `Countrycol_UNIQUE` (`Countrycol` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`City` (
  `idCity` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `idCountry` INT NOT NULL,
  PRIMARY KEY (`idCity`),
  UNIQUE INDEX `idCity_UNIQUE` (`idCity` ASC) VISIBLE,
  INDEX `fk_City_Country1_idx` (`idCountry` ASC) VISIBLE,
  CONSTRAINT `fk_City_Country1`
    FOREIGN KEY (`idCountry`)
    REFERENCES `airport`.`Country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`route` (
  `idroute` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `whereTo` INT NOT NULL,
  `fromTo` INT NOT NULL,
  PRIMARY KEY (`idroute`),
  UNIQUE INDEX `idflight_UNIQUE` (`idroute` ASC) VISIBLE,
  INDEX `fk_flight_City1_idx` (`whereTo` ASC) VISIBLE,
  INDEX `fk_flight_City2_idx` (`fromTo` ASC) VISIBLE,
  CONSTRAINT `fk_flight_City1`
    FOREIGN KEY (`whereTo`)
    REFERENCES `airport`.`City` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_City2`
    FOREIGN KEY (`fromTo`)
    REFERENCES `airport`.`City` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`departures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`departures` (
  `iddepartures` INT NOT NULL,
  `idcrew` INT NOT NULL,
  `idairplane` INT NOT NULL,
  `date` DATE NOT NULL,
  `departureTime` TIME NOT NULL,
  `arrivalTime` TIME NOT NULL,
  `idroute` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddepartures`),
  UNIQUE INDEX `iddepartures_UNIQUE` (`iddepartures` ASC) VISIBLE,
  INDEX `fk_departures_crew_idx` (`idcrew` ASC) VISIBLE,
  INDEX `fk_departures_airplane1_idx` (`idairplane` ASC) VISIBLE,
  INDEX `fk_departures_flight1_idx` (`idroute` ASC) VISIBLE,
  CONSTRAINT `fk_departures_crew`
    FOREIGN KEY (`idcrew`)
    REFERENCES `airport`.`crewInfo` (`idcrew`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departures_airplane1`
    FOREIGN KEY (`idairplane`)
    REFERENCES `airport`.`airplane` (`idairplane`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departures_flight1`
    FOREIGN KEY (`idroute`)
    REFERENCES `airport`.`route` (`idroute`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`post` (
  `idpost` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idpost`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`employee` (
  `idemployee` INT NOT NULL,
  `full_name` VARCHAR(45) NOT NULL,
  `idpost` INT NOT NULL,
  PRIMARY KEY (`idemployee`),
  UNIQUE INDEX `idemployee_UNIQUE` (`idemployee` ASC) VISIBLE,
  INDEX `fk_employee_post1_idx` (`idpost` ASC) VISIBLE,
  CONSTRAINT `fk_employee_post1`
    FOREIGN KEY (`idpost`)
    REFERENCES `airport`.`post` (`idpost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`passenger` (
  `idpassenger` INT NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  PRIMARY KEY (`idpassenger`),
  UNIQUE INDEX `idpassenger_UNIQUE` (`idpassenger` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`ticket` (
  `idticket` INT NOT NULL,
  `iddepartures` INT NOT NULL,
  `idemployee` INT NOT NULL,
  `idpassenger` INT NOT NULL,
  PRIMARY KEY (`idticket`),
  UNIQUE INDEX `idticket_UNIQUE` (`idticket` ASC) VISIBLE,
  INDEX `fk_ticket_departures1_idx` (`iddepartures` ASC) VISIBLE,
  INDEX `fk_ticket_employee1_idx` (`idemployee` ASC) VISIBLE,
  INDEX `fk_ticket_passenger1_idx` (`idpassenger` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_departures1`
    FOREIGN KEY (`iddepartures`)
    REFERENCES `airport`.`departures` (`iddepartures`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_employee1`
    FOREIGN KEY (`idemployee`)
    REFERENCES `airport`.`employee` (`idemployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_passenger1`
    FOREIGN KEY (`idpassenger`)
    REFERENCES `airport`.`passenger` (`idpassenger`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airport`.`crew` (
  `idcrew` INT NOT NULL,
  `idemployee` INT NOT NULL,
  PRIMARY KEY (`idcrew`, `idemployee`),
  INDEX `fk_crew_employee1_idx` (`idemployee` ASC) VISIBLE,
  CONSTRAINT `fk_crew_crewInfo1`
    FOREIGN KEY (`idcrew`)
    REFERENCES `airport`.`crewInfo` (`idcrew`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crew_employee1`
    FOREIGN KEY (`idemployee`)
    REFERENCES `airport`.`employee` (`idemployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
