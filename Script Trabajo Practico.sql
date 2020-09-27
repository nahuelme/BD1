-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema terminalautomotriz
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provedor` (
  `idProvedor` INT NOT NULL,
  `Nombre_Provedor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Insumo` (
  `idInsumo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `precio` INT NULL,
  PRIMARY KEY (`idInsumo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InsumoXProvedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InsumoXProvedor` (
  `Insumo_idInsumo` INT NOT NULL,
  `Provedor_idProvedor` INT NOT NULL,
  INDEX `fk_InsumoXProvedor_Insumo1_idx` (`Insumo_idInsumo` ASC) VISIBLE,
  INDEX `fk_InsumoXProvedor_Provedor1_idx` (`Provedor_idProvedor` ASC) VISIBLE,
  CONSTRAINT `fk_InsumoXProvedor_Insumo1`
    FOREIGN KEY (`Insumo_idInsumo`)
    REFERENCES `mydb`.`Insumo` (`idInsumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InsumoXProvedor_Provedor1`
    FOREIGN KEY (`Provedor_idProvedor`)
    REFERENCES `mydb`.`Provedor` (`idProvedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modelo` (
  `idModelo` INT NOT NULL,
  `Nombre_Modelo` VARCHAR(45) NULL,
  PRIMARY KEY (`idModelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LineaMontaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LineaMontaje` (
  `idLineaMontaje` INT NOT NULL,
  `Modelo_idModelo` INT NOT NULL,
  `CapacidadProduccion` INT NULL,
  PRIMARY KEY (`idLineaMontaje`),
  INDEX `fk_LineaMontaje_Modelo1_idx` (`Modelo_idModelo` ASC) VISIBLE,
  CONSTRAINT `fk_LineaMontaje_Modelo1`
    FOREIGN KEY (`Modelo_idModelo`)
    REFERENCES `mydb`.`Modelo` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estacion` (
  `idEstacion` INT NOT NULL,
  `LineaMontaje_idLineaMontaje` INT NOT NULL,
  `Estacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstacion`),
  INDEX `fk_Estacion_LineaMontaje1_idx` (`LineaMontaje_idLineaMontaje` ASC) VISIBLE,
  CONSTRAINT `fk_Estacion_LineaMontaje1`
    FOREIGN KEY (`LineaMontaje_idLineaMontaje`)
    REFERENCES `mydb`.`LineaMontaje` (`idLineaMontaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InsumoxProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InsumoxProduccion` (
  `Estacion_idEstacion` INT NOT NULL,
  `Insumo_idInsumo` INT NOT NULL,
  `cantidad` INT NULL,
  INDEX `fk_InsumoxProduccion_Estacion_idx` (`Estacion_idEstacion` ASC) VISIBLE,
  INDEX `fk_InsumoxProduccion_Insumo1_idx` (`Insumo_idInsumo` ASC) VISIBLE,
  CONSTRAINT `fk_InsumoxProduccion_Estacion`
    FOREIGN KEY (`Estacion_idEstacion`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InsumoxProduccion_Insumo1`
    FOREIGN KEY (`Insumo_idInsumo`)
    REFERENCES `mydb`.`Insumo` (`idInsumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Auto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Auto` (
  `Numero_Chasis` INT NOT NULL,
  `Modelo_idModelo` INT NULL,
  `Terminado` TINYINT NULL,
  PRIMARY KEY (`Numero_Chasis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AutoXEstacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AutoXEstacion` (
  `Estacion_idEstacion` INT NOT NULL,
  `Auto_idChasis` INT NOT NULL,
  `Fecha_ingreso` DATE NULL,
  `Fecha_salida` DATE NULL,
  INDEX `fk_AutoXEstacion_Estacion1_idx` (`Estacion_idEstacion` ASC) VISIBLE,
  INDEX `fk_AutoXEstacion_Auto1_idx` (`Auto_idChasis` ASC) VISIBLE,
  CONSTRAINT `fk_AutoXEstacion_Estacion1`
    FOREIGN KEY (`Estacion_idEstacion`)
    REFERENCES `mydb`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AutoXEstacion_Auto1`
    FOREIGN KEY (`Auto_idChasis`)
    REFERENCES `mydb`.`Auto` (`Numero_Chasis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consecionaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consecionaria` (
  `idConsecionaria` INT NOT NULL,
  `nombreConsecionaria` VARCHAR(45) NULL,
  `numeroVentas` INT NULL,
  PRIMARY KEY (`idConsecionaria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `FechaEstimada` DATE NULL,
  `Consecionaria_idConsecionaria` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Consecionaria1_idx` (`Consecionaria_idConsecionaria` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Consecionaria1`
    FOREIGN KEY (`Consecionaria_idConsecionaria`)
    REFERENCES `mydb`.`Consecionaria` (`idConsecionaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DetallePedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DetallePedido` (
  `Cantidad` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Modelo_idModelo` INT NOT NULL,
  INDEX `fk_DetallePedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_DetallePedido_Modelo1_idx` (`Modelo_idModelo` ASC) VISIBLE,
  CONSTRAINT `fk_DetallePedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetallePedido_Modelo1`
    FOREIGN KEY (`Modelo_idModelo`)
    REFERENCES `mydb`.`Modelo` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
