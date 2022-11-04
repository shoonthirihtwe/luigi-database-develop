-- MySQL Script
-- 2021-07-27 13:38
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;


-- >>LG2-107
ALTER TABLE `luigi2_test`.`agencies` 
CHANGE COLUMN `corporation_individual_flag` `corporate_individual_flag` CHAR(1) NULL DEFAULT '1' COMMENT '法人/個人区分' ;

ALTER TABLE `luigi2_test`.`beneficiaries` 
CHANGE COLUMN `person_type` `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分' ,
CHANGE COLUMN `rel_ship_to_insured` `rel_ship_to_insured` VARCHAR(2) NULL DEFAULT NULL COMMENT '被保険者からみた続柄' ;

ALTER TABLE `luigi2_test`.`customers` 
CHANGE COLUMN `customer_type` `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分' ;

ALTER TABLE `luigi2_test`.`maintenance_requests` 
DROP INDEX `FK_maintenance_requests_request_no_idx` ,
ADD INDEX `CAND_maintenance_requests` (`tenant_id` ASC, `request_no` ASC);

ALTER TABLE `luigi2_test`.`maintenance_requests_customer` 
ADD COLUMN `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ' AFTER `request_no`,
ADD COLUMN `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分' AFTER `customer_id`,
CHANGE COLUMN `customer_id` `customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '顧客ID' AFTER `before_after`,
ADD INDEX `CAND_maintenance_requests_customer` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC);

CREATE TABLE IF NOT EXISTS `luigi2_test`.`maintenance_requests_customer_individual` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `customer_id` VARCHAR(12) NOT NULL COMMENT '顧客ID',
  `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 姓',
  `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 名',
  `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 姓',
  `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 名',
  `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別',
  `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日',
  `addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号',
  `addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '住所カナ 県',
  `addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '住所カナ１',
  `addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '住所カナ２',
  `addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '住所漢字　県',
  `addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '住所漢字 1',
  `addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '住所漢字 2',
  `addr_tel1` TEXT NULL DEFAULT NULL COMMENT '電話番号1',
  `addr_tel2` TEXT NULL DEFAULT NULL COMMENT '電話番号2',
  `company_name_kana` TEXT NULL DEFAULT NULL COMMENT '勤務先名カナ',
  `company_name_kanji` TEXT NULL DEFAULT NULL COMMENT '勤務先名',
  `place_of_work_kana` VARCHAR(25) NULL DEFAULT NULL COMMENT '勤務先所属名カナ',
  `place_of_work_kanji` VARCHAR(25) NULL DEFAULT NULL COMMENT '勤務先所属名漢字',
  `place_of_work_code` VARCHAR(15) NULL DEFAULT NULL COMMENT '勤務先所属コード',
  `group_column` VARCHAR(30) NULL DEFAULT NULL COMMENT '団体使用欄',
  `email` TEXT NULL DEFAULT NULL COMMENT 'メールアドレス',
  `occupation` VARCHAR(32) NULL DEFAULT NULL COMMENT '職業',
  `occupation_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '職業コード',
  `enguarded_type` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等の区分',
  `guardian_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '成年後見人ID',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_customer_individual_mrc_idx` (`tenant_id` ASC),
  INDEX `CAND_maintenance_requests_customer_individual` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC),
  CONSTRAINT `FK_maintenance_requests_customer_individual_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `luigi2_test`.`tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_customer_individual_mrc`
    FOREIGN KEY (`tenant_id` , `request_no` , `before_after`)
    REFERENCES `luigi2_test`.`maintenance_requests_customer` (`tenant_id` , `request_no` , `before_after`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請個人顧客';


CREATE TABLE IF NOT EXISTS `luigi2_test`.`maintenance_requests_customer_corporate` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `customer_id` VARCHAR(12) NOT NULL COMMENT '顧客ID',
  `corp_name_kana` TEXT NULL DEFAULT NULL COMMENT '法人名(カナ)',
  `corp_name_official` TEXT NULL DEFAULT NULL COMMENT '法人名(公式)',
  `corp_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '法人・郵便番号',
  `corp_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ 県',
  `corp_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ１',
  `corp_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ２',
  `corp_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字　県',
  `corp_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 1',
  `corp_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 2',
  `rep10e_sex` CHAR(1) NULL DEFAULT NULL COMMENT '代表者・性別',
  `rep10e_date_of_birth` DATE NULL DEFAULT NULL COMMENT '代表者・生年月日',
  `rep10e_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名カナ 姓',
  `rep10e_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名カナ 名',
  `rep10e_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名漢字 姓',
  `rep10e_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名漢字 名',
  `rep10e_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '代表者・郵便番号',
  `rep10e_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ 県',
  `rep10e_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ１',
  `rep10e_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ２',
  `rep10e_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字　県',
  `rep10e_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 1',
  `rep10e_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 2',
  `rep10e_addr_tel1` TEXT NULL DEFAULT NULL COMMENT '代表者・電話番号1',
  `rep10e_addr_tel2` TEXT NULL DEFAULT NULL COMMENT '代表者・電話番号2',
  `contact_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名カナ 姓',
  `contact_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名カナ 名',
  `contact_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名漢字 姓',
  `contact_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名漢字 名',
  `contact_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '通信先・郵便番号',
  `contact_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ 県',
  `contact_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ１',
  `contact_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ２',
  `contact_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字　県',
  `contact_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 1',
  `contact_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 2',
  `contact_addr_tel1` TEXT NULL DEFAULT NULL COMMENT '通信先・電話番号1',
  `contact_addr_tel2` TEXT NULL DEFAULT NULL COMMENT '通信先・電話番号2',
  `contact_email` TEXT NULL DEFAULT NULL COMMENT '通信先・Eメールアドレス',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_customer_corporate_mrc_idx` (`tenant_id` ASC),
  INDEX `CAND_maintenance_requests_customer_corporate` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC),
  CONSTRAINT `FK_maintenance_requests_customer_corporate_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `luigi2_test`.`tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_customer_corporate_mrc`
    FOREIGN KEY (`tenant_id` , `request_no` , `before_after`)
    REFERENCES `luigi2_test`.`maintenance_requests_customer` (`tenant_id` , `request_no` , `before_after`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請法人顧客';


CREATE TABLE IF NOT EXISTS `luigi2_test`.`maintenance_requests_beneficiaries` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `role_type` VARCHAR(2) NOT NULL COMMENT 'ロールタイプ',
  `role_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT 'ロール連番',
  `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分',
  `name_sei` TEXT NULL DEFAULT NULL COMMENT '氏名　姓（会社名）',
  `name_mei` TEXT NULL DEFAULT NULL COMMENT '氏名　名',
  `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名　姓　カナ(会社名)',
  `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名　名　カナ',
  `share` INT(3) UNSIGNED NULL DEFAULT NULL COMMENT '受取の割合',
  `rel_ship_to_insured` VARCHAR(2) NULL DEFAULT NULL COMMENT '被保険者からみた続柄',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_beneficiaries_tenants_idx` (`tenant_id` ASC),
  INDEX `CAND_maintenance_requests_beneficiaries` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC, `role_type` ASC, `role_sequence_no` ASC),
  CONSTRAINT `FK_maintenance_requests_beneficiaries_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `luigi2_test`.`tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_beneficiaries_mr`
    FOREIGN KEY (`tenant_id` , `request_no`)
    REFERENCES `luigi2_test`.`maintenance_requests` (`tenant_id` , `request_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請受取人';
-- <<LG2-107

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
