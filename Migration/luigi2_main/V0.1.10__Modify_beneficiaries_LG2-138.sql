-- MySQL Script
-- 2021-09-03 21:04
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `beneficiaries` 
ADD COLUMN `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別' AFTER `rel_ship_to_insured`,
ADD COLUMN `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日' AFTER `sex`,
ADD COLUMN `addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' AFTER `date_of_birth`,
ADD COLUMN `addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '住所漢字　県' AFTER `addr_zip_code`,
ADD COLUMN `addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '住所漢字 1' AFTER `addr_knj_pref`,
ADD COLUMN `addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '住所漢字 2' AFTER `addr_knj_1` ;

ALTER TABLE `maintenance_requests_beneficiaries` 
ADD COLUMN `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別' AFTER `rel_ship_to_insured`,
ADD COLUMN `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日' AFTER `sex`,
ADD COLUMN `addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' AFTER `date_of_birth`,
ADD COLUMN `addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '住所漢字　県' AFTER `addr_zip_code`,
ADD COLUMN `addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '住所漢字 1' AFTER `addr_knj_pref`,
ADD COLUMN `addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '住所漢字 2' AFTER `addr_knj_1` ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;