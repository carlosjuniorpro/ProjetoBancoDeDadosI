-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb_supermercado
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb_supermercado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb_supermercado` ;
USE `mydb_supermercado` ;

-- -----------------------------------------------------
-- Table `mydb_supermercado`.`funcionario_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`funcionario_telefone` (
  `idfuncionario_telefone` INT NOT NULL,
  `funcionario_telefone` VARCHAR(30) NULL,
  PRIMARY KEY (`idfuncionario_telefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`supermercado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`supermercado` (
  `cnpj_supermercado` INT NOT NULL,
  `cep_supermercado` INT NULL,
  `cidade_supermercado` VARCHAR(45) NULL,
  `rua_supermercado` VARCHAR(45) NULL,
  `numero_supermercado` INT NULL,
  `bairro_supermercado` VARCHAR(45) NULL,
  PRIMARY KEY (`cnpj_supermercado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`funcionario` (
  `cpf_funcionario` INT NOT NULL,
  `cargo` VARCHAR(45) NULL,
  `nome_funcionario` VARCHAR(45) NULL,
  `supervisiona` INT NULL,
  `supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`cpf_funcionario`, `supermercado_cnpj_supermercado`),
  INDEX `fk_gerencia_idx` (`supervisiona` ASC),
  INDEX `fk_funcionario_supermercado1_idx` (`supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_gerencia`
    FOREIGN KEY (`supervisiona`)
    REFERENCES `mydb_supermercado`.`funcionario` (`cpf_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_supermercado`
    FOREIGN KEY (`supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`supermercado` (`cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`associacao_funcionario_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`associacao_funcionario_telefone` (
  `funcionario_telefone_idfuncionario_telefone` INT NOT NULL,
  `funcionario_cpf_funcionario` INT NOT NULL,
  PRIMARY KEY (`funcionario_telefone_idfuncionario_telefone`, `funcionario_cpf_funcionario`),
  INDEX `fk_associacao_funcionario_telefone_funcionario_idx` (`funcionario_cpf_funcionario` ASC),
  CONSTRAINT `fk_associacao_funcionario_telefone_funcionario_telefone`
    FOREIGN KEY (`funcionario_telefone_idfuncionario_telefone`)
    REFERENCES `mydb_supermercado`.`funcionario_telefone` (`idfuncionario_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_associacao_funcionario_telefone_funcionario`
    FOREIGN KEY (`funcionario_cpf_funcionario`)
    REFERENCES `mydb_supermercado`.`funcionario` (`cpf_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`relatorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`relatorio` (
  `idrelatorio` INT NOT NULL,
  `data_emissao` DATE NULL,
  `descricao_relatorio` VARCHAR(300) NULL,
  `supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`idrelatorio`, `supermercado_cnpj_supermercado`),
  INDEX `fk_relatorio_supermercado1_idx` (`supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_relatorio_supermercado1`
    FOREIGN KEY (`supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`supermercado` (`cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`supermercado_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`supermercado_telefone` (
  `idsupermercado_telefone` INT NOT NULL,
  `telefone_supermercado` VARCHAR(45) NULL,
  `supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`idsupermercado_telefone`, `supermercado_cnpj_supermercado`),
  INDEX `fk_supermercado_telefone_supermercado1_idx` (`supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_supermercado_telefone_supermercado1`
    FOREIGN KEY (`supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`supermercado` (`cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`venda` (
  `idvenda` INT NOT NULL,
  `data_venda` DATE NULL,
  `valor_total` FLOAT NULL,
  `supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`idvenda`, `supermercado_cnpj_supermercado`),
  INDEX `fk_venda_supermercado1_idx` (`supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_venda_supermercado1`
    FOREIGN KEY (`supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`supermercado` (`cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`cliente` (
  `idcliente` INT NOT NULL,
  `cpf_cliente` INT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`venda_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`venda_cliente` (
  `cliente_idcliente` INT NOT NULL,
  `venda_idvenda` INT NOT NULL,
  `venda_supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`cliente_idcliente`, `venda_idvenda`, `venda_supermercado_cnpj_supermercado`),
  INDEX `fk_venda_cliente_venda1_idx` (`venda_idvenda` ASC, `venda_supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_venda_cliente_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb_supermercado`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_cliente_venda1`
    FOREIGN KEY (`venda_idvenda` , `venda_supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`venda` (`idvenda` , `supermercado_cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`devolucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`devolucao` (
  `iddevolucao` INT NOT NULL,
  `descricao_devolucao` VARCHAR(300) NULL,
  `data_devolucao` DATE NULL,
  `venda_idvenda` INT NOT NULL,
  `venda_supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`iddevolucao`, `venda_idvenda`, `venda_supermercado_cnpj_supermercado`),
  INDEX `fk_devolucao_venda1_idx` (`venda_idvenda` ASC, `venda_supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_devolucao_venda1`
    FOREIGN KEY (`venda_idvenda` , `venda_supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`venda` (`idvenda` , `supermercado_cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`produto_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`produto_venda` (
  `idproduto_venda` INT NOT NULL,
  `preco_venda` FLOAT NULL,
  PRIMARY KEY (`idproduto_venda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`produto_contem_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`produto_contem_venda` (
  `venda_idvenda` INT NOT NULL,
  `venda_supermercado_cnpj_supermercado` INT NOT NULL,
  `produto_venda_idproduto_venda` INT NOT NULL,
  PRIMARY KEY (`venda_idvenda`, `venda_supermercado_cnpj_supermercado`, `produto_venda_idproduto_venda`),
  INDEX `fk_produto_contem_venda_produto_venda1_idx` (`produto_venda_idproduto_venda` ASC),
  CONSTRAINT `fk_produto_contem_venda_venda1`
    FOREIGN KEY (`venda_idvenda` , `venda_supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`venda` (`idvenda` , `supermercado_cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_contem_venda_produto_venda1`
    FOREIGN KEY (`produto_venda_idproduto_venda`)
    REFERENCES `mydb_supermercado`.`produto_venda` (`idproduto_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`estoque_produto_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`estoque_produto_fornecedor` (
  `idproduto_forncedor` INT NOT NULL,
  `nome_produto` VARCHAR(45) NULL,
  `marca_produto` VARCHAR(45) NULL,
  `descricao_produto` VARCHAR(100) NULL,
  `preco_compra_fornecedor` FLOAT NULL,
  `prazo_validade` DATE NULL,
  `quantidade` INT NULL,
  `supermercado_cnpj_supermercado` INT NOT NULL,
  PRIMARY KEY (`idproduto_forncedor`, `supermercado_cnpj_supermercado`),
  INDEX `fk_estoque_produto_fornecedor_supermercado1_idx` (`supermercado_cnpj_supermercado` ASC),
  CONSTRAINT `fk_estoque_produto_fornecedor_supermercado1`
    FOREIGN KEY (`supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`supermercado` (`cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`venda_produto_estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`venda_produto_estoque` (
  `estoque_produto_fornecedor_idproduto_forncedor` INT NOT NULL,
  `estoque_produto_fornecedor_supermercado_cnpj_supermercado` INT NOT NULL,
  `produto_venda_idproduto_venda` INT NOT NULL,
  PRIMARY KEY (`estoque_produto_fornecedor_idproduto_forncedor`, `estoque_produto_fornecedor_supermercado_cnpj_supermercado`, `produto_venda_idproduto_venda`),
  INDEX `fk_venda_produto_estoque_produto_venda1_idx` (`produto_venda_idproduto_venda` ASC),
  CONSTRAINT `fk_venda_produto_estoque_estoque_produto_fornecedor1`
    FOREIGN KEY (`estoque_produto_fornecedor_idproduto_forncedor` , `estoque_produto_fornecedor_supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`estoque_produto_fornecedor` (`idproduto_forncedor` , `supermercado_cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_produto_estoque_produto_venda1`
    FOREIGN KEY (`produto_venda_idproduto_venda`)
    REFERENCES `mydb_supermercado`.`produto_venda` (`idproduto_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`fornecedor` (
  `cnpj_fornecedor` INT NOT NULL,
  `nome_fornecedor` VARCHAR(45) NULL,
  `cep_forcencedor` INT NULL,
  `cidade_fornecedor` VARCHAR(45) NULL,
  `bairro_fornecedor` VARCHAR(45) NULL,
  `rua_fornecedor` VARCHAR(45) NULL,
  PRIMARY KEY (`cnpj_fornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`compra_forncedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`compra_forncedor` (
  `estoque_produto_fornecedor_idproduto_forncedor` INT NOT NULL,
  `estoque_produto_fornecedor_supermercado_cnpj_supermercado` INT NOT NULL,
  `fornecedor_cnpj_fornecedor` INT NOT NULL,
  PRIMARY KEY (`estoque_produto_fornecedor_idproduto_forncedor`, `estoque_produto_fornecedor_supermercado_cnpj_supermercado`, `fornecedor_cnpj_fornecedor`),
  INDEX `fk_compra_forncedor_fornecedor1_idx` (`fornecedor_cnpj_fornecedor` ASC),
  CONSTRAINT `fk_compra_forncedor_estoque_produto_fornecedor1`
    FOREIGN KEY (`estoque_produto_fornecedor_idproduto_forncedor` , `estoque_produto_fornecedor_supermercado_cnpj_supermercado`)
    REFERENCES `mydb_supermercado`.`estoque_produto_fornecedor` (`idproduto_forncedor` , `supermercado_cnpj_supermercado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_forncedor_fornecedor1`
    FOREIGN KEY (`fornecedor_cnpj_fornecedor`)
    REFERENCES `mydb_supermercado`.`fornecedor` (`cnpj_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_supermercado`.`telefone_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_supermercado`.`telefone_fornecedor` (
  `idtelefone_fornecedor` INT NOT NULL,
  `telefone_fornecedor` VARCHAR(45) NULL,
  `fornecedor_cnpj_fornecedor` INT NOT NULL,
  PRIMARY KEY (`idtelefone_fornecedor`, `fornecedor_cnpj_fornecedor`),
  INDEX `fk_telefone_fornecedor_fornecedor1_idx` (`fornecedor_cnpj_fornecedor` ASC),
  CONSTRAINT `fk_telefone_fornecedor_fornecedor1`
    FOREIGN KEY (`fornecedor_cnpj_fornecedor`)
    REFERENCES `mydb_supermercado`.`fornecedor` (`cnpj_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
