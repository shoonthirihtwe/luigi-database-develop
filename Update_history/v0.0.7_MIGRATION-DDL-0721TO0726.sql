-- MySQL Script
-- 2021-07-26 15:23
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;


-- >>LG2-178
ALTER TABLE `luigi2_test`.`benefti_limits` 
CHANGE COLUMN `eachtime_limit_amount` `payg_limit_amount` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額' ;

ALTER TABLE `luigi2_test`.`benefits` 
CHANGE COLUMN `eachtime_limit_amount` `payg_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額' ;

ALTER TABLE `luigi2_test`.`claim_details` 
CHANGE COLUMN `eachtime_limit_amount` `payg_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額' ;
-- <<LG2-178

-- >>LG2-64
ALTER TABLE `luigi2_test`.`customers` 
DROP COLUMN `guardian_type`;

--
-- Recreate `customers_individual` table:
--  c.f. https://stackoverflow.com/questions/60506428/multiple-mysql-workbench-synchronizing-issues
--

DROP TABLE IF EXISTS `luigi2_test`.`customers_individual` 
CREATE TABLE IF NOT EXISTS `luigi2_test`.`customers_individual` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
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
  INDEX `FK_customers_individual_tenants` (`tenant_id` ASC),
  INDEX `CAND_customers_individual` (`tenant_id` ASC, `customer_id` ASC),
  INDEX `FK_customers_individual_guardian_idx` (`tenant_id` ASC, `guardian_id` ASC),
  CONSTRAINT `FK_customers_individual_customers`
    FOREIGN KEY (`tenant_id` , `customer_id`)
    REFERENCES `luigi2_test`.`customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_customers_individual_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `luigi2_test`.`tenants` (`id`),
  CONSTRAINT `FK_customers_individual_guardian`
    FOREIGN KEY (`tenant_id` , `guardian_id`)
    REFERENCES `luigi2_test`.`customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '個人顧客マスタ';

-- <<LG2-64

-- >>LG2-259
ALTER TABLE `luigi2_test`.`notifications` 
CHANGE COLUMN `template_nunber` `template_number` VARCHAR(6) NULL DEFAULT NULL COMMENT 'テンプレートナンバー' ,
CHANGE COLUMN `coment` `comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '通信欄コメント' ;
-- <<LG2-259


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

