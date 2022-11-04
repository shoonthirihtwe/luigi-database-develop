-- MySQL Script
-- 2021-09-10 00:23
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `agencies` 
DROP COLUMN `person_in_charge_kana`,
DROP COLUMN `person_in_charge_knj`,
DROP COLUMN `rep_name_kana`,
DROP COLUMN `rep_name_knj`,
ADD COLUMN `em_knj_mei` TEXT NULL DEFAULT NULL COMMENT '教育責任者名(漢字)' AFTER `em_knj_sei`,
ADD COLUMN `em_kana_mei` TEXT NULL DEFAULT NULL COMMENT '教育責任者名(カナ)' AFTER `em_kana_sei`,
ADD COLUMN `mg_knj_mei` TEXT NULL DEFAULT NULL COMMENT '管理責任者名(漢字)' AFTER `mg_knj_sei`,
ADD COLUMN `mg_kana_mei` TEXT NULL DEFAULT NULL COMMENT '管理責任者名(カナ)' AFTER `mg_kana_sei`,
ADD COLUMN `suspended_date` DATE NULL DEFAULT NULL COMMENT '募集停止日' AFTER `registration_date`,
CHANGE COLUMN `rep_name_sei_knj` `rep_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '代表者姓(漢字)' AFTER `rep_tel`,
CHANGE COLUMN `rep_name_mei_knj` `rep_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '代表者名(漢字)' AFTER `rep_name_knj_sei`,
CHANGE COLUMN `rep_name_sei_kana` `rep_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '代表者姓(カナ)' AFTER `rep_name_knj_mei`,
CHANGE COLUMN `rep_name_mei_kana` `rep_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '代表者名(カナ)' AFTER `rep_name_kana_sei`,
CHANGE COLUMN `person_in_charge_sei_knj` `person_in_charge_knj_sei` TEXT NULL DEFAULT NULL COMMENT '担当者姓(漢字)' AFTER `rep_date_of_birth`,
CHANGE COLUMN `person_in_charge_mei_knj` `person_in_charge_knj_mei` TEXT NULL DEFAULT NULL COMMENT '担当者名(漢字)' AFTER `person_in_charge_knj_sei`,
CHANGE COLUMN `person_in_charge_sei_kana` `person_in_charge_kana_sei` TEXT NULL DEFAULT NULL COMMENT '担当者姓(カナ)' AFTER `person_in_charge_knj_mei`,
CHANGE COLUMN `person_in_charge_mei_kana` `person_in_charge_kana_mei` TEXT NULL DEFAULT NULL COMMENT '担当者名(カナ)' AFTER `person_in_charge_kana_sei`,
CHANGE COLUMN `corporate_number` `corporate_number` CHAR(13) NULL DEFAULT NULL COMMENT '法人番号' ,
CHANGE COLUMN `agency_name_knj` `agency_name_official` TEXT NULL DEFAULT NULL COMMENT '代理店名(正式)' ,
CHANGE COLUMN `agency_name_kana` `agency_name_kana` TEXT NULL DEFAULT NULL COMMENT '代理店名（カナ）' ,
CHANGE COLUMN `shop_name` `agency_shop_name` VARCHAR(64) NULL DEFAULT NULL COMMENT '屋号' ,
CHANGE COLUMN `zip_code` `agency_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' ,
CHANGE COLUMN `address` `agency_address` TEXT NULL DEFAULT NULL COMMENT '住所' ,
CHANGE COLUMN `person_in_charge_em_knj` `em_knj_sei` TEXT NULL DEFAULT NULL COMMENT '教育責任者姓(漢字)' ,
CHANGE COLUMN `person_in_charge_em_kana` `em_kana_sei` TEXT NULL DEFAULT NULL COMMENT '教育責任者姓(カナ)' ,
CHANGE COLUMN `person_in_charge_mg_knj` `mg_knj_sei` TEXT NULL DEFAULT NULL COMMENT '管理責任者姓(漢字)' ,
CHANGE COLUMN `person_in_charge_mg_kana` `mg_kana_sei` TEXT NULL DEFAULT NULL COMMENT '管理責任者姓(カナ)' ,
CHANGE COLUMN `termination_date` `end_date` DATE NULL DEFAULT NULL COMMENT '廃業日' ,
CHANGE COLUMN `bank_code` `bank_code` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関コード' ,
CHANGE COLUMN `bank_branch_code` `bank_branch_code` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関支店コード' ,
CHANGE COLUMN `type_of_account` `type_of_account` TEXT NULL DEFAULT NULL COMMENT '口座種別' ,
CHANGE COLUMN `bank_account_no` `bank_account_no` TEXT NULL DEFAULT NULL COMMENT '口座番号' ,
CHANGE COLUMN `bank_account_holder` `bank_account_holder` TEXT NULL DEFAULT NULL COMMENT '口座名義人' ,
CHANGE COLUMN `offcial_agency_code` `official_agency_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '財務局登録代理店コード'  ;

ALTER TABLE `agency_branches` 
DROP COLUMN `agency_branch_status`,
ADD COLUMN `manager_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '管理者名(漢字)' AFTER `manager_name_knj_sei`,
ADD COLUMN `manager_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '管理者名（カナ）' AFTER `manager_name_kana_sei`,
ADD COLUMN `person_in_charge_knj_mei` TEXT NULL DEFAULT NULL COMMENT '担当者名(漢字)' AFTER `person_in_charge_knj_sei`,
ADD COLUMN `person_in_charge_kana_mei` TEXT NULL DEFAULT NULL COMMENT '担当者名（カナ)' AFTER `person_in_charge_kana_sei`,
CHANGE COLUMN `agency_branch_name_knj` `agency_branch_name_official` TEXT NULL DEFAULT NULL COMMENT '支店名(正式)' ,
CHANGE COLUMN `agency_branch_name_kana` `agency_branch_name_kana` TEXT NULL DEFAULT NULL COMMENT '支店名（カナ）' ,
CHANGE COLUMN `zip_code` `agency_branch_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' ,
CHANGE COLUMN `address` `agency_branch_address` TEXT NULL DEFAULT NULL COMMENT '住所' ,
CHANGE COLUMN `tel_no` `agency_branch_tel_no` VARCHAR(13) NULL DEFAULT NULL COMMENT '支店電話番号' ,
CHANGE COLUMN `manager_name_knj` `manager_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '管理者姓(漢字)' ,
CHANGE COLUMN `manager_name_kana` `manager_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '管理者姓（カナ）' ,
CHANGE COLUMN `person_in_charge_knj` `person_in_charge_knj_sei` TEXT NULL DEFAULT NULL COMMENT '担当者姓(漢字)' ,
CHANGE COLUMN `person_in_charge_kana` `person_in_charge_kana_sei` TEXT NULL DEFAULT NULL COMMENT '担当者姓（カナ)' ,
CHANGE COLUMN `termination_date` `end_date` DATE NULL DEFAULT NULL COMMENT '廃業日' ;

ALTER TABLE `sales_agents` 
DROP COLUMN `agent_status`,
DROP COLUMN `officiial_agency_code`,
ADD COLUMN `agent_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '募集人名(漢字)' AFTER `agent_name_knj_sei`,
ADD COLUMN `agent_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '募集人名(カナ)' AFTER `agent_name_kana_sei`,
ADD COLUMN `suspended_date` DATE NULL DEFAULT NULL COMMENT '募集停止日' AFTER `registration_date`,
CHANGE COLUMN `agent_name_knj` `agent_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '募集人姓(漢字)' ,
CHANGE COLUMN `agent_name_kana` `agent_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '募集人姓(カナ)' ,
CHANGE COLUMN `termination_date` `end_date` DATE NULL DEFAULT NULL COMMENT '廃業日' ,
CHANGE COLUMN `offcial_agent_code` `official_agent_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '協会登録募集人コード' ,
ADD INDEX `CAND_sales_agents` (`tenant_id` ASC, `agent_code` ASC);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
