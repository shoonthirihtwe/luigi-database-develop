-- MySQL Script
-- 2021-11-02 17:01
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `contracts` 
ADD COLUMN `coverage_type` CHAR(1) NULL DEFAULT '1' COMMENT '保険期間のタイプ' AFTER `number_of_insured`,
CHANGE COLUMN `coverage_year` `coverage_term` TINYINT(2) NULL DEFAULT NULL COMMENT '保険期間' ;

ALTER TABLE `risk_headers` 
CHANGE COLUMN `coverage_term` `coverage_term` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険期間' ,
CHANGE COLUMN `coverage_end_date` `coverage_end_date` DATE NULL DEFAULT NULL COMMENT '保険期間終了日' ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;