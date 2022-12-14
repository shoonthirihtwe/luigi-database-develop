-- MySQL Script
-- 2021-11-15 11:56
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `benefti_limits` 
CHANGE COLUMN `benefit_code` `benefit_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険金タイプ' ;

ALTER TABLE `benefits` 
CHANGE COLUMN `benefit_code` `benefit_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険金タイプ' ;

ALTER TABLE `risk_headers` 
CHANGE COLUMN `benefit_code` `benefit_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険金タイプ' ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
