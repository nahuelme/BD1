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

//alta provedor
DELIMITER $$
CREATE PROCEDURE altaProvedor( IN  _idProvedor INT, IN  _Nombre_Provedor varchar(45))
BEGIN
INSERT INTO Provedor (idProvedor, Nombre_Provedor) VALUES (_idProvedor,_Nombre_Provedor);
END $$
DELIMITER ;


//Modificar provedor
DELIMITER $$
CREATE PROCEDURE modificarProvedor(IN _idProvedor INT, IN  _Nombre_Provedor varchar(45))
BEGIN
UPDATE Provedor SET Provedor.Nombre_Provedor = _Nombre_Provedor where(idProvedor=_idProvedor);
END$$
DELIMITER ;

//bajaProvedor
DELIMITER $$
CREATE PROCEDURE bajaProvedor(IN _idProvedor INT)
begin
    delete from Provedor where Provedor.idProvedor = _idProvedor;
end $$
DELIMITER ;

call altaProvedor(1,'GetulioCompany');
call modificarProvedor(1,'GetuliosCompany');

/* Alta Auto */
DELIMITER $$
CREATE PROCEDURE altaAuto (IN _Numero_Chasis int, IN _Modelo_idModelo int, IN _Terminado tinyint)
BEGIN
Call Generador_patente();
INSERT INTO Auto(Numero_Chasis,Modelo_idModelo,Terminado) VALUES (_Numero_Chasis,_Modelo_idModelo,_Terminado);
END $$
DELIMITER ;

/* Modificacion AUTO */
DELIMITER $$
CREATE procedure modificarAuto (IN _Numero_Chasis int, IN _Modelo_idModelo int, IN _Terminado tinyint)
BEGIN
UPDATE Auto SET Auto.Numero_Chasis = _Numero_Chasis WHERE (Numero_Chasis = _Numero_Chasis);
UPDATE Auto SET Auto.Modelo_idModelo = _Modelo_idModelo WHERE (Numero_Chasis = _Numero_Chasis);
UPDATE Auto SET Auto.Terminado = _Terminado WHERE (Numero_Chasis = _Numero_Chasis);
END $$
DELIMITER ;

/* Baja AUTO */
DELIMITER $$
CREATE procedure bajaAuto (IN _Numero_Chasis int)
BEGIN 
DELETE from Auto WHERE Auto.Numero_Chasis = _Numero_Chasis;
END $$
DELIMITER ;


-- AltaInsumo
DELIMITER $$
CREATE PROCEDURE altaInsumo( IN  _idInsumo INT, IN  _descripcion varchar(45), _precio INT)
BEGIN
INSERT INTO Insumo (idInsumo,descripcion,precio ) VALUES (_idInsumo,_descripcion,_precio);
END $$
DELIMITER ;


-- Modificar Insumo
DELIMITER $$
CREATE PROCEDURE modificarInsumo(IN _idInsumo INT, IN  _descripcion varchar(45),IN _precio INT)
BEGIN
UPDATE Insumo SET Insumo.precio = _precio where(idInsumo=_idInsumo);
UPDATE Insumo SET Insumo.descripcion = _descripcion where(idInsumo=_idInsumo);
END$$
DELIMITER ;

-- bajaInsumo
DELIMITER $$
CREATE PROCEDURE bajaInsumo(IN _idInsumo INT)
begin
    delete from Insumo where Insumo.idInsumo = _idInsumo;
end $$
DELIMITER ;
                                                                                    
                                                                                    -- ALTA Pedido
DELIMITER $$
CREATE PROCEDURE altaPedido(IN _idPedido INT, IN _FechaEstimada DATE, IN _Consecionaria_idConsecionaria INT)
begin
INSERT INTO PedidoAuto (idPedido, FechaEstimada, Consecionaria_idConsecionaria) VALUES (_idPedido, _FechaEstimada, _Consecionaria_idConsecionaria);
END $$
DELIMITER ;

-- BAJA Pedido
DELIMITER $$
CREATE PROCEDURE bajaPedido (IN _idPedido INT, IN _FechaEstimada DATE, IN _Consecionaria_idConsecionaria INT)
begin
    delete from Pedido where Pedido.idPedido = _idPedido;
end $$
delimiter;

-- MODIFICACION Pedido
DELIMITER $$
CREATE PROCEDURE modificarPedido (IN _idPedido INT, IN _FechaEstimada DATE, IN _Consecionaria_idConsecionaria INT)
begin
UPDATE Pedido SET FechaEstimada = _FechaEstimada WHERE (idPedido = _idPedido);
END$$
DELIMITER ;


call altaInsumo(1,'tornillos',30);
call modificarInsumo(1,'bujias',50);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
