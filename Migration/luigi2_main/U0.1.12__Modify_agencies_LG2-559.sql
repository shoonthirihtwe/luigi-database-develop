-- MySQL Script
-- 2021-09-13 14:55
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `agencies` 
DROP COLUMN `rep10e_name_kana_mei`,
DROP COLUMN `rep10e_name_kana_sei`,
DROP COLUMN `rep10e_name_knj_mei`,
DROP COLUMN `rep10e_name_knj_sei`,
DROP COLUMN `rep10e_tel`,
ADD COLUMN `rep_tel` VARCHAR(13) NULL DEFAULT NULL COMMENT '代表電話番号' AFTER `agency_address`,
ADD COLUMN `rep_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '代表者姓(漢字)' AFTER `rep_tel`,
ADD COLUMN `rep_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '代表者名(漢字)' AFTER `rep_name_knj_sei`,
ADD COLUMN `rep_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '代表者姓(カナ)' AFTER `rep_name_knj_mei`,
ADD COLUMN `rep_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '代表者名(カナ)' AFTER `rep_name_kana_sei`,
ADD COLUMN `rep_date_of_birth` DATE NULL DEFAULT NULL COMMENT '代表者生年月日' AFTER `rep_name_kana_mei`,
ADD COLUMN `em_knj_sei` TEXT NULL DEFAULT NULL COMMENT '教育責任者姓(漢字)' AFTER `person_in_charge_email`,
ADD COLUMN `em_knj_mei` TEXT NULL DEFAULT NULL COMMENT '教育責任者名(漢字)' AFTER `em_knj_sei`,
ADD COLUMN `em_kana_sei` TEXT NULL DEFAULT NULL COMMENT '教育責任者姓(カナ)' AFTER `em_knj_mei`,
ADD COLUMN `em_kana_mei` TEXT NULL DEFAULT NULL COMMENT '教育責任者名(カナ)' AFTER `em_kana_sei`,
ADD COLUMN `mg_knj_sei` TEXT NULL DEFAULT NULL COMMENT '管理責任者姓(漢字)' AFTER `em_kana_mei`,
ADD COLUMN `mg_knj_mei` TEXT NULL DEFAULT NULL COMMENT '管理責任者名(漢字)' AFTER `mg_knj_sei`,
ADD COLUMN `mg_kana_sei` TEXT NULL DEFAULT NULL COMMENT '管理責任者姓(カナ)' AFTER `mg_knj_mei`,
ADD COLUMN `mg_kana_mei` TEXT NULL DEFAULT NULL COMMENT '管理責任者名(カナ)' AFTER `mg_kana_sei`,
ADD COLUMN `agency_status` INT(11) NULL DEFAULT NULL COMMENT '代理店ステータス' AFTER `bank_account_holder`;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
