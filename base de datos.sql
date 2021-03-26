-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema colab_cafeteria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema colab_cafeteria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `colab_cafeteria` DEFAULT CHARACTER SET latin1 ;
USE `colab_cafeteria` ;

-- -----------------------------------------------------
-- Table `colab_cafeteria`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`puesto` (
  `id_puesto` INT(11) NOT NULL COMMENT 'id que define a nuestro puesto creado',
  `nombre_puesto` VARCHAR(45) NOT NULL COMMENT 'nombre del puesto',
  `puede_consultar` ENUM('S', 'N') NOT NULL DEFAULT 'S' COMMENT 'Estado en el que se encuentra el puesto\nS=Si\nN= No',
  `puede_eliminar` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Estado en el que se encuentra el puesto\nS=Si\nN= No',
  `puede_insertar` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Estado en el que se encuentra el puesto\nS=Si\nN= No',
  `puede_modificar` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Estado en el que se encuentra el puesto\nS=Si\nN= No',
  `fecha_creacion` DATE NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'fecha en que se crea el puesto',
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nI= Inactivo',
  `id_creador` INT(11) NOT NULL,
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que actualizamos nuestra informacion \n',
  PRIMARY KEY (`id_puesto`),
  CONSTRAINT `FK_puesto_usuario`
    FOREIGN KEY (`id_creador`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'definimos los puestos que tienen en la cafeteria	';

CREATE INDEX `FK_puesto_usuario_idx` ON `colab_cafeteria`.`puesto` (`id_creador` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`usuario` (
  `id_usuario` INT(11) NOT NULL COMMENT 'id del usuario que creamos',
  `usuario` VARCHAR(45) NOT NULL COMMENT 'nombre del usuario que creamos',
  `password` VARCHAR(45) NOT NULL,
  `id_puesto` INT(11) NOT NULL COMMENT 'id del puesto al que pertenecera el usuario',
  `estado` ENUM('A', 'I') NOT NULL COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Fecha en que creamos a nuestro usuario',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en la que actualizamos el dato',
  `id_usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'id del usuario que creo',
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'id del usuario que modifico',
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `FK_USUARIO_PUESTO_CORRESPONDIENTE`
    FOREIGN KEY (`id_puesto`)
    REFERENCES `colab_cafeteria`.`puesto` (`id_puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_U_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_U_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'aqui definimos a los usuarios que tendran acceso a nuestra base de datos';

CREATE INDEX `FK_USUARIO_PUESTO_CORRESPONDIENTE_idx` ON `colab_cafeteria`.`usuario` (`id_puesto` ASC);

CREATE INDEX `FK_U_USUARIO_CRE_idx` ON `colab_cafeteria`.`usuario` (`id_usuario_creo` ASC);

CREATE INDEX `FK_U_USUARIO_MOD_idx` ON `colab_cafeteria`.`usuario` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`cliente` (
  `id_cliente` INT(11) NOT NULL COMMENT 'numero de identificacion del cliente',
  `nombres` VARCHAR(255) NOT NULL COMMENT 'nombre del cliente\n',
  `apellidos` VARCHAR(255) NOT NULL COMMENT 'apellidos del cliente',
  `celular` INT(11) NULL DEFAULT NULL COMMENT 'numero de telefono del cliente para que sea notificado de futuras ofertas o promociones\n',
  `nit` VARCHAR(8) NULL DEFAULT 'C/F' COMMENT 'numero de NIT del cliente y si no tiene C/F es para consumidor final',
  `fecha_creacion` DATE NOT NULL COMMENT 'fecha para cuando creamos al cliente',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha para cuando modificacion al cliente',
  `usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'id usuario que creo al cliente',
  `usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'el usuario que modifico al cliente',
  PRIMARY KEY (`id_cliente`),
  CONSTRAINT `FK_C_USUARIO_CRE`
    FOREIGN KEY (`usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_C_USUARIO_MOD`
    FOREIGN KEY (`usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Contenido de la informacion del cliente, este es uno de los encabezados';

CREATE INDEX `FK_C_USUARIO_CRE_idx` ON `colab_cafeteria`.`cliente` (`usuario_creo` ASC);

CREATE INDEX `FK_C_USUARIO_MOD_idx` ON `colab_cafeteria`.`cliente` (`usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`vendedor` (
  `id_vendedor` INT(11) NOT NULL COMMENT 'id del vendedor ',
  `nombres_vendedor` VARCHAR(150) NOT NULL COMMENT 'nombre vendedor',
  `apellidos_vendedor` VARCHAR(45) NOT NULL COMMENT 'apellidos vendedor',
  `correo_electronico` VARCHAR(45) NOT NULL COMMENT 'correo electronico a contactar',
  `celular` INT(11) NOT NULL COMMENT 'numero de telefono a contactar',
  `id_usuario` INT(11) NULL DEFAULT NULL COMMENT 'id_de usuario para evaluar accesos',
  `estado` ENUM('A', 'I') NULL DEFAULT NULL COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que creamos al vendedor',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'para cuando actualicemos nuestro dato',
  `id_usuario_creo` INT(11) NULL DEFAULT NULL,
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_vendedor`),
  CONSTRAINT `FK_VENDEDOR_USUARIO`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_V_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_V_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'encabezado de la informacion del vendedor';

CREATE INDEX `FK_VENDEDOR_USUARIO_idx` ON `colab_cafeteria`.`vendedor` (`id_usuario` ASC);

CREATE INDEX `FK_V_USUARIO_CRE_idx` ON `colab_cafeteria`.`vendedor` (`id_usuario_creo` ASC);

CREATE INDEX `FK_V_USUARIO_MOD_idx` ON `colab_cafeteria`.`vendedor` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`factura` (
  `id_factura` INT(11) NOT NULL COMMENT 'numero de correlativo de la factura\n',
  `id_vendedor` INT(11) NOT NULL COMMENT 'el vendedor que esta efectuando la factura',
  `id_cliente` INT(11) NOT NULL COMMENT 'cliente al que le estamos trabajando',
  `descripcion` VARCHAR(255) NOT NULL COMMENT 'breve descripcion de la transaccion',
  `total` DECIMAL(12,2) NOT NULL COMMENT 'total de la factura',
  `estado` ENUM('A', 'C') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nC=Cancelada',
  `fecha_creacion` DATE NOT NULL COMMENT 'fecha en que creamos la factura',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que modificamos la factura',
  `id_usuario_crea` INT(11) NULL DEFAULT NULL COMMENT 'id del usuario que crea la factura',
  `id_usuario_modifica` INT(11) NULL DEFAULT NULL COMMENT 'id de usuario que modifica la factura',
  PRIMARY KEY (`id_factura`),
  CONSTRAINT `FK_F_CLIENTE`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `colab_cafeteria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_F_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_crea`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_F_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifica`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_F_VENDEDOR`
    FOREIGN KEY (`id_vendedor`)
    REFERENCES `colab_cafeteria`.`vendedor` (`id_vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'factura con la que el vendedor trabajara';

CREATE INDEX `FK_F_VENDEDOR_idx` ON `colab_cafeteria`.`factura` (`id_vendedor` ASC);

CREATE INDEX `FK_F_CLIENTE_idx` ON `colab_cafeteria`.`factura` (`id_cliente` ASC);

CREATE INDEX `FK_F_USUARIO_CRE_idx` ON `colab_cafeteria`.`factura` (`id_usuario_crea` ASC);

CREATE INDEX `FK_F_USUARIO_MOD_idx` ON `colab_cafeteria`.`factura` (`id_usuario_modifica` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`producto` (
  `id_producto` INT(11) NOT NULL COMMENT 'id del producto que representa',
  `nombre_producto` VARCHAR(150) NOT NULL COMMENT 'nombre del producto a describir',
  `en_inventario` INT(11) NOT NULL COMMENT 'numero de existencias en bodega',
  `gramaje` VARCHAR(45) NULL DEFAULT NULL,
  `tamaño` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el producto\nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Fecha de cuando se creo este producto ',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que se modifica el producto',
  `id_usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'id de usuario que creo',
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'id usuario que modifica',
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `FK_P_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_P_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Listado de productos que tenemos en existencia';

CREATE INDEX `FK_P_USUARIO_CRE_idx` ON `colab_cafeteria`.`producto` (`id_usuario_creo` ASC);

CREATE INDEX `FK_P_USUARIO_MOD_idx` ON `colab_cafeteria`.`producto` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`detalle_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`detalle_factura` (
  `id_detalle_factura` INT(11) NOT NULL COMMENT 'id_detalle de la factura',
  `id_factura` INT(11) NOT NULL COMMENT 'id de la factura que se agregaran los productos\n',
  `id_producto` INT(11) NOT NULL COMMENT 'producto a trabajar',
  `cantidad` INT(11) NOT NULL COMMENT 'el numero de productos que vamos a quitar de inventario',
  `sub_total` DECIMAL(10,2) NOT NULL COMMENT 'sub total de precio de venta',
  `precio_venta` DECIMAL(10,2) NOT NULL COMMENT 'precio venta individual',
  `descuento` DECIMAL(10,2) NOT NULL COMMENT 'descuento individual',
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NOT NULL COMMENT 'fecha cuando creamos el campo',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que se modifica',
  `id_usuario_creo` INT(11) NOT NULL COMMENT 'usuario que crea ',
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifica',
  PRIMARY KEY (`id_detalle_factura`),
  CONSTRAINT `FK_DF_FACTURA`
    FOREIGN KEY (`id_factura`)
    REFERENCES `colab_cafeteria`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DF_PRODUCTO`
    FOREIGN KEY (`id_producto`)
    REFERENCES `colab_cafeteria`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DF_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DF_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'detallamos las compras que se efectuaron';

CREATE INDEX `FK_DF_FACTURA_idx` ON `colab_cafeteria`.`detalle_factura` (`id_factura` ASC);

CREATE INDEX `FK_DF_PRODUCTO_idx` ON `colab_cafeteria`.`detalle_factura` (`id_producto` ASC);

CREATE INDEX `FK_DF_USUARIO_CREA_idx` ON `colab_cafeteria`.`detalle_factura` (`id_usuario_creo` ASC);

CREATE INDEX `FK_DF_USUARIO_MOD_idx` ON `colab_cafeteria`.`detalle_factura` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`detalle_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`detalle_producto` (
  `id_detalle_producto` INT(11) NOT NULL,
  `precio_venta` DECIMAL(10,2) NOT NULL,
  `descuento` DECIMAL(2,2) NOT NULL DEFAULT 0.00,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL COMMENT 'una descripcion del motivo del precio o el decuento ',
  `id_producto` INT(11) NOT NULL COMMENT 'esta hace referencia al producto en que hacemos su detalle',
  `fecha_creacion` DATE NULL DEFAULT NULL COMMENT 'para cuando creamos el dato',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'para cuando mdificamos el dato',
  `usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'usuario que creo el producot',
  `usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifico el producot',
  PRIMARY KEY (`id_detalle_producto`),
  CONSTRAINT `FK_DP_USUARIO_CRE`
    FOREIGN KEY (`usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DP_USUARIO_MOD`
    FOREIGN KEY (`usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_producto_detalle`
    FOREIGN KEY (`id_producto`)
    REFERENCES `colab_cafeteria`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Esta tabla contiene el detalle de los productos\n';

CREATE INDEX `FK_id_producto_detalle_idx` ON `colab_cafeteria`.`detalle_producto` (`id_producto` ASC);

CREATE INDEX `FK_DP_USUARIO_CRE_idx` ON `colab_cafeteria`.`detalle_producto` (`usuario_creo` ASC);

CREATE INDEX `FK_DP_USUARIO_MOD_idx` ON `colab_cafeteria`.`detalle_producto` (`usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`grupo_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`grupo_productos` (
  `id_grupo_productos` INT(11) NOT NULL COMMENT 'id que define al campo y tabla de los grupos',
  `nombre_grupo_producto` VARCHAR(45) NOT NULL COMMENT 'nombre de los grupos creados',
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'fecha en que fue creada ',
  `fecha_ultima_modificacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que se modifica ',
  `id_usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifico el grupo de productos',
  `id_usuario_modifica` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifico el grupo de productos',
  PRIMARY KEY (`id_grupo_productos`),
  CONSTRAINT `FK_GP_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_GP_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifica`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'divisiones de los grupos a los que perteneceran los productos';

CREATE INDEX `FK_GP_USUARIO_CREA_idx` ON `colab_cafeteria`.`grupo_productos` (`id_usuario_creo` ASC);

CREATE INDEX `FK_GP_USUARIO_MOD_idx` ON `colab_cafeteria`.`grupo_productos` (`id_usuario_modifica` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`detalle_producto_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`detalle_producto_grupo` (
  `id_detalle_producto_grupo` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `id_grupo_productos` INT(11) NOT NULL,
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el producto en cualquier grupo \nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'fecha en que definimos a que grupo pertenece el producto',
  `fecha_ultoma_modificacion` DATE NULL DEFAULT NULL,
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL,
  `id_usuario_creo` INT(11) NOT NULL,
  PRIMARY KEY (`id_detalle_producto_grupo`),
  CONSTRAINT `FK_DPG_USU_CREO_USU`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DPG_USU_MOD_USU`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_grupo_producto_detalle_prodcuto`
    FOREIGN KEY (`id_grupo_productos`)
    REFERENCES `colab_cafeteria`.`grupo_productos` (`id_grupo_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_producto_detalle_grupo`
    FOREIGN KEY (`id_producto`)
    REFERENCES `colab_cafeteria`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'esta tabla nos indica a los sub grupos a los cuales el producto puede pertenecer\n';

CREATE INDEX `FK_id_producto_idx` ON `colab_cafeteria`.`detalle_producto_grupo` (`id_producto` ASC);

CREATE INDEX `FK_id_grupo_producto_detalle_idx` ON `colab_cafeteria`.`detalle_producto_grupo` (`id_grupo_productos` ASC);

CREATE INDEX `FK_DPG_USU_CREO_USU_idx` ON `colab_cafeteria`.`detalle_producto_grupo` (`id_usuario_creo` ASC);

CREATE INDEX `FK_DPG_USU_MOD_USU_idx` ON `colab_cafeteria`.`detalle_producto_grupo` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`detalle_producto_precio_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`detalle_producto_precio_compra` (
  `id_detalle_producto_precio_compra` INT(11) NOT NULL COMMENT 'id de la compra sobre el producto adquirido',
  `precio_compra` DECIMAL(10,2) NOT NULL COMMENT 'precio al que compramos dicho producto',
  `cantidad_compra` INT(11) NOT NULL COMMENT 'total de las unidades compradas',
  `fecha_compra` DATE NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'fecha en que se compraron los productos',
  `fecha_creacion` DATE NULL DEFAULT NULL COMMENT 'fecha de cuando modificamos el dato',
  `fecha_modifico` DATE NULL DEFAULT NULL COMMENT 'fecha de cuando se modifico el dato',
  `usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'usuario que creo el producto precio compra',
  `usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifico el producto precio compra',
  PRIMARY KEY (`id_detalle_producto_precio_compra`),
  CONSTRAINT `FK_DPPC_USUARIO_CRE`
    FOREIGN KEY (`usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DPPC_USUARIO_MOD`
    FOREIGN KEY (`usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = koi8r
COMMENT = 'esta tabla muestra nos indicara los diferentes precios a los que hemos comprado dicho producto';

CREATE INDEX `FK_DPPC_USUARIO_CRE_idx` ON `colab_cafeteria`.`detalle_producto_precio_compra` (`usuario_creo` ASC);

CREATE INDEX `FK_DPPC_USUARIO_MOD_idx` ON `colab_cafeteria`.`detalle_producto_precio_compra` (`usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`direccion_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`direccion_cliente` (
  `id_direccion_cliente` INT(11) NOT NULL COMMENT 'id de direccion del cliente',
  `id_departamento` INT(11) NULL DEFAULT NULL COMMENT 'id del departamento al que pertenece',
  `id_municipio` INT(11) NULL DEFAULT NULL COMMENT 'id del municipio al que pertenece',
  `direccion` VARCHAR(250) NULL DEFAULT NULL COMMENT '\'direccion completa del cliente\'',
  `calle` VARCHAR(45) NULL DEFAULT NULL COMMENT '\'Nombre del lugar de la calle\'',
  `casa` VARCHAR(45) NOT NULL COMMENT '\'Numero de casa o lote donde vive el cliente\'',
  `avenida` VARCHAR(45) NULL DEFAULT NULL COMMENT '\'nombre de la avenida donde vive\'',
  `colonia` VARCHAR(45) NULL DEFAULT NULL COMMENT '\'Nombre de la colonia donde vive, esta puede ser la aldea\'',
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra la direccion \nA= Activo\nI= Inactivo',
  `id_cliente` INT(11) NOT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que se crea',
  `fecha_ultima_modificacion` VARCHAR(45) NULL DEFAULT NULL COMMENT 'fecha en que se modifica',
  `usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'usuario que creo el direccion cliente',
  `usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifico el direccion cliente',
  PRIMARY KEY (`id_direccion_cliente`),
  CONSTRAINT `FK_DC_USUARIO_CRE`
    FOREIGN KEY (`usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DC_USUARIO_MOD`
    FOREIGN KEY (`usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_cliente_direccion`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `colab_cafeteria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Contiene la informacion detallada de las posibles direcciones del encabezado del cliente';

CREATE INDEX `FK_id_cliente_direccion_idx` ON `colab_cafeteria`.`direccion_cliente` (`id_cliente` ASC);

CREATE INDEX `FK_DC_USUARIO_CRE_idx` ON `colab_cafeteria`.`direccion_cliente` (`usuario_creo` ASC);

CREATE INDEX `FK_DC_USUARIO_MOD_idx` ON `colab_cafeteria`.`direccion_cliente` (`usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`inventario` (
  `id_inventario` INT(11) NOT NULL COMMENT 'id del ventrario ',
  `transaccion` VARCHAR(45) NOT NULL COMMENT 'descripcion de transaccion de compra venta\n',
  `id_producto` INT(11) NOT NULL COMMENT 'id del producto a efectuar\n',
  `total_productos` INT(11) NOT NULL COMMENT 'numero de productos que estamos efectuando\n',
  `descripcion_producto` VARCHAR(255) NULL DEFAULT NULL COMMENT 'breve descripcion de lo que hicimos con el producto',
  `cantidad_venta` INT(11) NULL DEFAULT NULL COMMENT 'el numero de productos que estamos efectuando\n',
  `cantidad_compra` INT(11) NULL DEFAULT NULL COMMENT 'el numero de compras que hicimos\n',
  `fecha_creacion` DATE NULL DEFAULT NULL COMMENT 'fecha de cuando creamos este dato en el inventario\n',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en la que modificamos este inventario',
  `id_usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'el usuario que creo el dato en inventario\n',
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'el usuario que modifico la informacion del inventario',
  PRIMARY KEY (`id_inventario`),
  CONSTRAINT `FK_I_ID_PROD`
    FOREIGN KEY (`id_producto`)
    REFERENCES `colab_cafeteria`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_I_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_I_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'aqui definimos nuestras transacciones a la existencia de nuestros productos';

CREATE INDEX `FK_I_USUARIO_CRE_idx` ON `colab_cafeteria`.`inventario` (`id_usuario_creo` ASC);

CREATE INDEX `FK_I_ID_PROD_idx` ON `colab_cafeteria`.`inventario` (`id_producto` ASC);

CREATE INDEX `FK_I_USUARIO_MOD_idx` ON `colab_cafeteria`.`inventario` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`tipo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`tipo_pago` (
  `id_tipo_pago` INT(11) NOT NULL COMMENT 'numero de la identificacon del tipo de pago \n',
  `nombre_tipo_pago` VARCHAR(45) NOT NULL COMMENT 'nombre del tipo de pago a utilizar',
  `descripcion` VARCHAR(45) NULL DEFAULT NULL COMMENT 'una pequeña descripcion que pueda definir mejor el tipo de pago',
  `estado` ENUM('A', 'I') NULL DEFAULT 'A' COMMENT 'Estado en el que se encuentra el tipo de pago\nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'para evaluar desde cuando tomamos en cuenta los tipos de pago',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que se modifica',
  `id_usuario_creo` INT(11) NULL DEFAULT NULL COMMENT 'id de usuario que crea',
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'id de usuario que modifica',
  PRIMARY KEY (`id_tipo_pago`),
  CONSTRAINT `FK_TP_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TP_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Esta define el tipo de pago que vamos a efectuar 	';

CREATE INDEX `FK_TP_USUARIO_CRE_idx` ON `colab_cafeteria`.`tipo_pago` (`id_usuario_creo` ASC);

CREATE INDEX `FK_TP_USUARIO_MOD_idx` ON `colab_cafeteria`.`tipo_pago` (`id_usuario_modifico` ASC);


-- -----------------------------------------------------
-- Table `colab_cafeteria`.`pago_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colab_cafeteria`.`pago_factura` (
  `id_pago_factura` INT(11) NOT NULL COMMENT 'el identificador del metodo de pago que efectuamos',
  `id_tipo_pago` INT(11) NOT NULL COMMENT 'id del tipo de pago qu vamos a efectuar',
  `monto` DECIMAL(10,2) NOT NULL COMMENT 'la cantidad que vamos a pagar y puede ser parcial',
  `estado` ENUM('A', 'I') NULL DEFAULT NULL COMMENT 'Estado en el que se encuentra el grupo \nA=Activo\nI= Inactivo',
  `fecha_creacion` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'fecha en que creamos el pago',
  `fecha_ultima_actualizacion` DATE NULL DEFAULT NULL COMMENT 'fecha en que se actualiza el pago',
  `id_usuario_creo` INT(11) NOT NULL COMMENT 'usuario que crea el pago',
  `id_usuario_modifico` INT(11) NULL DEFAULT NULL COMMENT 'usuario que modifica el pago',
  PRIMARY KEY (`id_pago_factura`),
  CONSTRAINT `FK_PF_TIPO_PAGO`
    FOREIGN KEY (`id_tipo_pago`)
    REFERENCES `colab_cafeteria`.`tipo_pago` (`id_tipo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PF_USUARIO_CRE`
    FOREIGN KEY (`id_usuario_creo`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PF_USUARIO_MOD`
    FOREIGN KEY (`id_usuario_modifico`)
    REFERENCES `colab_cafeteria`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'aqui evaluamos el metodo de pago parcial o completo de la factura';

CREATE INDEX `FK_PF_TIPO_PAGO_idx` ON `colab_cafeteria`.`pago_factura` (`id_tipo_pago` ASC);

CREATE INDEX `FK_PF_USUARIO_CRE_idx` ON `colab_cafeteria`.`pago_factura` (`id_usuario_creo` ASC);

CREATE INDEX `FK_PF_USUARIO_MOD_idx` ON `colab_cafeteria`.`pago_factura` (`id_usuario_modifico` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;