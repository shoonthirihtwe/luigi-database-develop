-- MySQL Script
-- 2021-08-27 14:13
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `maintenance_requests` 
DROP COLUMN `notification_datetime`;

ALTER TABLE `maintenance_requests_customer` 
DROP COLUMN `share`,
DROP COLUMN `guardian_tel_mobile`,
DROP COLUMN `guardian_tel_fix`,
DROP COLUMN `guardian_address_2`,
DROP COLUMN `guardian_address_1`,
DROP COLUMN `guardian_address_pref`,
DROP COLUMN `guardian_postal_code`,
DROP COLUMN `guardian_type`,
DROP COLUMN `guardian_date_of_birth`,
DROP COLUMN `guardian_sex`,
DROP COLUMN `guardian_name_kana_mei`,
DROP COLUMN `guardian_name_kana_sei`,
DROP COLUMN `guardian_name_knj_mei`,
DROP COLUMN `guardian_name_knj_sei`,
DROP COLUMN `guardian_flag`,
DROP COLUMN `antisocial_forces_check`,
DROP COLUMN `occupation_code`,
DROP COLUMN `occupation`,
DROP COLUMN `email`,
DROP COLUMN `tel_mobile`,
DROP COLUMN `tel_fix`,
DROP COLUMN `address_2_kana`,
DROP COLUMN `address_1_kana`,
DROP COLUMN `address_pref_kana`,
DROP COLUMN `address_2`,
DROP COLUMN `address_1`,
DROP COLUMN `address_pref`,
DROP COLUMN `postal_code`,
DROP COLUMN `date_of_birth`,
DROP COLUMN `sex`,
DROP COLUMN `name_kana_mei`,
DROP COLUMN `name_kana_sei`,
DROP COLUMN `name_knj_mei`,
DROP COLUMN `name_knj_sei`,
DROP COLUMN `customer_id`;

ALTER TABLE `maintenance_requests_customer_individual` 
ADD COLUMN `antisocial_forces_check` CHAR(1) NULL DEFAULT NULL COMMENT '反社チェック' AFTER `guardian_id`,
CHANGE COLUMN `name_kana_sei` `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '個人姓(カナ)' ,
CHANGE COLUMN `name_kana_mei` `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '個人名(カナ)' ,
CHANGE COLUMN `name_knj_sei` `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '個人姓(漢字)' ,
CHANGE COLUMN `name_knj_mei` `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '個人名(漢字)' ;

ALTER TABLE `maintenance_requests_customer_corporate` 
ADD COLUMN `antisocial_forces_check` CHAR(1) NULL DEFAULT NULL COMMENT '反社チェック' AFTER `contact_email`,
CHANGE COLUMN `corp_name_official` `corp_name_official` TEXT NULL DEFAULT NULL COMMENT '法人名(正式)' ;

ALTER TABLE `maintenance_requests_beneficiaries` 
CHANGE COLUMN `name_sei` `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '個人姓(漢字)/法人名(正式)' ,
CHANGE COLUMN `name_mei` `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '個人名(漢字)' ,
CHANGE COLUMN `name_kana_sei` `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '個人姓(カナ)/法人名(カナ)' ,
CHANGE COLUMN `name_kana_mei` `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '個人名(カナ)' ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
