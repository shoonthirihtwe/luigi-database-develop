-- MySQL Script
-- 2021-08-27 14:19
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `maintenance_requests` 
ADD COLUMN `notification_datetime` DATETIME NULL DEFAULT NULL COMMENT '完了通知送信日時' AFTER `apply_date`;

ALTER TABLE `maintenance_requests_customer` 
ADD COLUMN `customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '顧客ID' AFTER `before_after`,
ADD COLUMN `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '氏名（漢字）_姓　(※会社名）' AFTER `role`,
ADD COLUMN `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '氏名（漢字）_名' AFTER `name_knj_sei`,
ADD COLUMN `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名（カナ）_姓　（※会社名）' AFTER `name_knj_mei`,
ADD COLUMN `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名（カナ）_名' AFTER `name_kana_sei`,
ADD COLUMN `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別' AFTER `name_kana_mei`,
ADD COLUMN `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日' AFTER `sex`,
ADD COLUMN `postal_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号' AFTER `date_of_birth`,
ADD COLUMN `address_pref` TEXT NULL DEFAULT NULL COMMENT '住所（都道府県）' AFTER `postal_code`,
ADD COLUMN `address_1` TEXT NULL DEFAULT NULL COMMENT '住所（番地まで）' AFTER `address_pref`,
ADD COLUMN `address_2` TEXT NULL DEFAULT NULL COMMENT '住所（ビル名　部屋番号）' AFTER `address_1`,
ADD COLUMN `address_pref_kana` TEXT NULL DEFAULT NULL COMMENT '住所（都道府県）カナ' AFTER `address_2`,
ADD COLUMN `address_1_kana` TEXT NULL DEFAULT NULL COMMENT '住所（番地まで）カナ' AFTER `address_pref_kana`,
ADD COLUMN `address_2_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '住所（ビル名　部屋番号）カナ' AFTER `address_1_kana`,
ADD COLUMN `tel_fix` TEXT NULL DEFAULT NULL COMMENT '電話番号（固定）' AFTER `address_2_kana`,
ADD COLUMN `tel_mobile` TEXT NULL DEFAULT NULL COMMENT '電話番号（携帯）' AFTER `tel_fix`,
ADD COLUMN `email` VARCHAR(128) NULL DEFAULT NULL COMMENT 'メールアドレス' AFTER `tel_mobile`,
ADD COLUMN `occupation` VARCHAR(32) NULL DEFAULT NULL COMMENT '職業' AFTER `email`,
ADD COLUMN `occupation_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '職業コード' AFTER `occupation`,
ADD COLUMN `antisocial_forces_check` CHAR(1) NULL DEFAULT NULL COMMENT '反社チェック' AFTER `occupation_code`,
ADD COLUMN `guardian_flag` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等の有無' AFTER `antisocial_forces_check`,
ADD COLUMN `guardian_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の氏名（漢字）_姓' AFTER `guardian_flag`,
ADD COLUMN `guardian_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の氏名（漢字）_名' AFTER `guardian_name_knj_sei`,
ADD COLUMN `guardian_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の名前（カナ）_姓' AFTER `guardian_name_knj_mei`,
ADD COLUMN `guardian_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の名前（カナ）_名' AFTER `guardian_name_kana_sei`,
ADD COLUMN `guardian_sex` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等　性別' AFTER `guardian_name_kana_mei`,
ADD COLUMN `guardian_date_of_birth` DATE NULL DEFAULT NULL COMMENT '成年後見人等　生年月日' AFTER `guardian_sex`,
ADD COLUMN `guardian_type` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等との区分' AFTER `guardian_date_of_birth`,
ADD COLUMN `guardian_postal_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '成年後見人等の郵便番号' AFTER `guardian_type`,
ADD COLUMN `guardian_address_pref` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の住所（都道府県）' AFTER `guardian_postal_code`,
ADD COLUMN `guardian_address_1` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の住所（番地まで）' AFTER `guardian_address_pref`,
ADD COLUMN `guardian_address_2` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の住所（ビル名　部屋番号まで）' AFTER `guardian_address_1`,
ADD COLUMN `guardian_tel_fix` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の電話番号（固定）' AFTER `guardian_address_2`,
ADD COLUMN `guardian_tel_mobile` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の電話番号（携帯）' AFTER `guardian_tel_fix`,
ADD COLUMN `share` INT(3) UNSIGNED NULL DEFAULT NULL COMMENT '受取の割合' ;

ALTER TABLE `maintenance_requests_customer_individual` 
DROP COLUMN `antisocial_forces_check`,
CHANGE COLUMN `name_kana_sei` `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 姓' ,
CHANGE COLUMN `name_kana_mei` `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 名' ,
CHANGE COLUMN `name_knj_sei` `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 姓' ,
CHANGE COLUMN `name_knj_mei` `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 名' ;

ALTER TABLE `maintenance_requests_customer_corporate` 
DROP COLUMN `antisocial_forces_check`,
CHANGE COLUMN `corp_name_official` `corp_name_official` TEXT NULL DEFAULT NULL COMMENT '法人名(公式)' ;

ALTER TABLE `maintenance_requests_beneficiaries` 
DROP COLUMN `name_knj_mei`,
DROP COLUMN `name_knj_sei`,
ADD COLUMN `name_sei` TEXT NULL DEFAULT NULL COMMENT '氏名　姓（会社名）' AFTER `corporate_individual_flag`,
ADD COLUMN `name_mei` TEXT NULL DEFAULT NULL COMMENT '氏名　名' AFTER `name_sei`,
CHANGE COLUMN `name_kana_sei` `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名　姓　カナ(会社名)' ,
CHANGE COLUMN `name_kana_mei` `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名　名　カナ' ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
