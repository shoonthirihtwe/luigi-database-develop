-- MySQL Script
-- 2021-09-10 00:23
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `agencies` 
DROP COLUMN `end_date`,
DROP COLUMN `suspended_date`,
DROP COLUMN `mg_kana_mei`,
DROP COLUMN `mg_kana_sei`,
DROP COLUMN `mg_knj_mei`,
DROP COLUMN `mg_knj_sei`,
DROP COLUMN `em_kana_mei`,
DROP COLUMN `em_kana_sei`,
DROP COLUMN `em_knj_mei`,
DROP COLUMN `em_knj_sei`,
DROP COLUMN `person_in_charge_kana_mei`,
DROP COLUMN `person_in_charge_kana_sei`,
DROP COLUMN `person_in_charge_knj_mei`,
DROP COLUMN `person_in_charge_knj_sei`,
DROP COLUMN `rep_name_kana_mei`,
DROP COLUMN `rep_name_kana_sei`,
DROP COLUMN `rep_name_knj_mei`,
DROP COLUMN `rep_name_knj_sei`,
DROP COLUMN `agency_address`,
DROP COLUMN `agency_zip_code`,
DROP COLUMN `agency_shop_name`,
DROP COLUMN `agency_name_official`,
ADD COLUMN `agency_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '代理店名' AFTER `withholding_tax`,
ADD COLUMN `shop_name` VARCHAR(64) NULL DEFAULT NULL COMMENT '屋号' AFTER `agency_name_kana`,
ADD COLUMN `zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' AFTER `shop_name`,
ADD COLUMN `address` VARCHAR(64) NULL DEFAULT NULL COMMENT '住所' AFTER `zip_code`,
ADD COLUMN `rep_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '代表者名' AFTER `rep_tel`,
ADD COLUMN `rep_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '代表者名（カナ）' AFTER `rep_name_knj`,
ADD COLUMN `person_in_charge_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名' AFTER `rep_date_of_birth`,
ADD COLUMN `person_in_charge_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名（カナ）' AFTER `person_in_charge_knj`,
ADD COLUMN `person_in_charge_em_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '教育責任者　漢字' AFTER `person_in_charge_email`,
ADD COLUMN `person_in_charge_em_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '教育責任者　カナ' AFTER `person_in_charge_em_knj`,
ADD COLUMN `person_in_charge_mg_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '管理責任者　漢字' AFTER `person_in_charge_em_kana`,
ADD COLUMN `person_in_charge_mg_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '管理責任者　カナ' AFTER `person_in_charge_mg_knj`,
ADD COLUMN `termination_date` DATE NULL DEFAULT NULL COMMENT '廃業日' AFTER `registration_date`,
ADD COLUMN `rep_name_sei_knj` VARCHAR(64) NULL DEFAULT NULL AFTER `memo`,
ADD COLUMN `rep_name_mei_knj` VARCHAR(64) NULL DEFAULT NULL AFTER `rep_name_sei_knj`,
ADD COLUMN `rep_name_sei_kana` VARCHAR(64) NULL DEFAULT NULL AFTER `rep_name_mei_knj`,
ADD COLUMN `rep_name_mei_kana` VARCHAR(64) NULL DEFAULT NULL AFTER `rep_name_sei_kana`,
ADD COLUMN `person_in_charge_sei_knj` VARCHAR(64) NULL DEFAULT NULL AFTER `rep_name_mei_kana`,
ADD COLUMN `person_in_charge_mei_knj` VARCHAR(64) NULL DEFAULT NULL AFTER `person_in_charge_sei_knj`,
ADD COLUMN `person_in_charge_sei_kana` VARCHAR(64) NULL DEFAULT NULL AFTER `person_in_charge_mei_knj`,
ADD COLUMN `person_in_charge_mei_kana` VARCHAR(64) NULL DEFAULT NULL AFTER `person_in_charge_sei_kana`,
CHANGE COLUMN `corporate_number` `corporate_number` CHAR(13) NULL DEFAULT NULL ,
CHANGE COLUMN `agency_name_kana` `agency_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '代理店名（カナ）' ,
CHANGE COLUMN `bank_code` `bank_code` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `bank_branch_code` `bank_branch_code` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `type_of_account` `type_of_account` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `bank_account_no` `bank_account_no` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `bank_account_holder` `bank_account_holder` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `official_agency_code` `offcial_agency_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '財務局登録代理店コード'  ;

ALTER TABLE `agency_branches` 
DROP COLUMN `end_date`,
DROP COLUMN `person_in_charge_kana_mei`,
DROP COLUMN `person_in_charge_kana_sei`,
DROP COLUMN `person_in_charge_knj_mei`,
DROP COLUMN `person_in_charge_knj_sei`,
DROP COLUMN `manager_name_kana_mei`,
DROP COLUMN `manager_name_kana_sei`,
DROP COLUMN `manager_name_knj_mei`,
DROP COLUMN `manager_name_knj_sei`,
DROP COLUMN `agency_branch_tel_no`,
DROP COLUMN `agency_branch_address`,
DROP COLUMN `agency_branch_zip_code`,
DROP COLUMN `agency_branch_name_official`,
ADD COLUMN `agency_branch_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店名' AFTER `agency_branch_code`,
ADD COLUMN `zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' AFTER `agency_branch_name_kana`,
ADD COLUMN `address` VARCHAR(64) NULL DEFAULT NULL COMMENT '住所' AFTER `zip_code`,
ADD COLUMN `tel_no` VARCHAR(13) NULL DEFAULT NULL COMMENT '支店電話番号' AFTER `address`,
ADD COLUMN `manager_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店管理者名' AFTER `tel_no`,
ADD COLUMN `manager_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店管理者名（カナ）' AFTER `manager_name_knj`,
ADD COLUMN `person_in_charge_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名' AFTER `manager_name_kana`,
ADD COLUMN `person_in_charge_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名（カナ）' AFTER `person_in_charge_knj`,
ADD COLUMN `termination_date` DATE NULL DEFAULT NULL COMMENT '廃業日' AFTER `registration_date`,
ADD COLUMN `agency_branch_status` INT(11) NULL DEFAULT NULL COMMENT '支店ステータス' AFTER `agency_branch_type`,
CHANGE COLUMN `agency_branch_name_kana` `agency_branch_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店名（カナ）' ;

ALTER TABLE `sales_agents` 
DROP COLUMN `end_date`,
DROP COLUMN `suspended_date`,
DROP COLUMN `agent_name_kana_mei`,
DROP COLUMN `agent_name_kana_sei`,
DROP COLUMN `agent_name_knj_mei`,
DROP COLUMN `agent_name_knj_sei`,
ADD COLUMN `agent_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名' AFTER `agency_branch_code`,
ADD COLUMN `agent_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名（カナ）' AFTER `agent_name_knj`,
ADD COLUMN `officiial_agency_code` VARCHAR(20) NULL DEFAULT NULL AFTER `date_of_birth`,
ADD COLUMN `termination_date` DATE NULL DEFAULT NULL COMMENT '廃業日' AFTER `registration_date`,
ADD COLUMN `agent_status` INT(11) NULL DEFAULT NULL COMMENT '募集人ステータス' AFTER `termination_date`,
CHANGE COLUMN `official_agent_code` `offcial_agent_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '協会登録募集人コード' ,
DROP INDEX `CAND_sales_agents` ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
