-- MySQL Script
-- 2021-07-14 20:04
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;


-- >>LG2-178

--- beneficiaries

ALTER TABLE `luigi2_test`.`beneficiaries` 
CHANGE COLUMN `role_type` `role_type` VARCHAR(2) NULL DEFAULT NULL COMMENT 'ロールタイプ' ,
CHANGE COLUMN `role_sequence_no` `role_sequence_no` TINYINT(2) UNSIGNED NULL DEFAULT NULL COMMENT 'ロール連番' ;

--- billing_details

ALTER TABLE `luigi2_test`.`billing_details` 
CHANGE COLUMN `premium_sequence_no` `premium_sequence_no` SMALLINT(3) UNSIGNED NOT NULL COMMENT '保険料連番' ,
ADD INDEX `CAND_billing_details` (`tenant_id` ASC, `billng_header_no` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC);

--- claim_details

ALTER TABLE `luigi2_test`.`claim_details` 
DROP COLUMN `version`,
DROP COLUMN `policy_code`,
DROP COLUMN `product_type`,
DROP COLUMN `base_rider`,
CHANGE COLUMN `sequence_no` `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障連番' ;

--- claim_documents

ALTER TABLE `luigi2_test`.`claim_documents` 
CHANGE COLUMN `sequence_no` `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番' ;

--- claim_headers

DROP TABLE IF EXISTS `luigi2_test`.`claim_headers` ;
CREATE TABLE IF NOT EXISTS `luigi2_test`.`claim_headers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `claim_trxs_id` INT(9) UNSIGNED NOT NULL COMMENT '保険金・給付金情報ID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障連番',
  `active_inactive` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `claim_date` DATE NOT NULL COMMENT '請求日',
  `received_date` DATE NOT NULL COMMENT '受付日',
  `claimant_category` VARCHAR(2) NULL DEFAULT NULL COMMENT '請求者区分',
  `claimant_sei_knj` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者） 姓',
  `claimant_mei_knj` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者） 名',
  `claimant_sei_kana` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者）セイ',
  `claimant_mei_kana` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者）メイ',
  `claimant_date_of_birth` DATE NULL DEFAULT NULL COMMENT '請求者生年月日',
  `claimant_address` TEXT NULL DEFAULT NULL COMMENT '請求者住所',
  `relationship` VARCHAR(2) NULL DEFAULT NULL COMMENT '請求者（被保険者）との続柄',
  `result_code` CHAR(1) NULL DEFAULT NULL COMMENT '請求者反社チェック結果コード',
  `parental_kanji` VARCHAR(64) NULL DEFAULT NULL COMMENT '親権者（被保険者）',
  `parental_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '親権者（被保険者）　カナ',
  `parental_relationship` VARCHAR(2) NULL DEFAULT NULL COMMENT '親権者（被保険者）との続柄',
  `tel_no` TEXT NULL DEFAULT NULL COMMENT '請求者電話番号',
  `contact_tel_no` TEXT NULL DEFAULT NULL COMMENT '請求者電話番号日中連絡先',
  `email` TEXT NULL DEFAULT NULL COMMENT '請求者メールアドレス',
  `type_of_accident` VARCHAR(2) NOT NULL COMMENT '請求事由',
  `accident_date` DATE NOT NULL COMMENT '請求事由発生日',
  `accident_place` VARCHAR(32) NULL DEFAULT NULL COMMENT '請求事由発生場所',
  `accident_info` VARCHAR(1024) NULL DEFAULT NULL COMMENT '請求事由内容',
  `bank_name` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関名',
  `bank_code` TEXT NOT NULL COMMENT '支払先金融機関コード',
  `bank_branch_name` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関支店名',
  `bank_branch_code` TEXT NOT NULL COMMENT '支払先金融機関支店コード',
  `bank_account_type` TEXT NOT NULL COMMENT '口座種別',
  `bank_account_no` TEXT NOT NULL COMMENT '口座番号',
  `bank_account_holder` TEXT NOT NULL COMMENT '口座名義人',
  `claim_total_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '請求総額',
  `benefit_total_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '支払対象総額',
  `number_of_paid` TINYINT(2) UNSIGNED NULL DEFAULT NULL COMMENT '既払回数',
  `paid_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '既払通算額',
  `over_total_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算限度超過総額',
  `amount_to_pay` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '支払決定額',
  `claim_status` CHAR(1) NULL DEFAULT '1' COMMENT '申請ステータス',
  `underwriting_status` CHAR(1) NULL DEFAULT '1' COMMENT '査定ステータス',
  `claim_status_date` DATE NULL DEFAULT NULL COMMENT '申請ステータス更新日',
  `underwriting_date` DATE NULL DEFAULT NULL COMMENT '査定ステータス更新日',
  `reception_comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '受付者コメント',
  `first_underwriter_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '1次査定者ID',
  `first_underwriting_date` DATE NULL DEFAULT NULL COMMENT '1次査定日',
  `first_underwriting_comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '1次査定コメント',
  `second_underwriter_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '2次査定者ID',
  `second_underwriting_date` DATE NULL DEFAULT NULL COMMENT '2次査定日',
  `second_underwriting_comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '2次査定コメント',
  `information` VARCHAR(1024) NULL DEFAULT NULL COMMENT '通信欄コメント',
  `unrated_reason` CHAR(1) NULL DEFAULT NULL COMMENT '自動判定不可理由 [0]-[9]',
  `inspection` CHAR(1) NULL DEFAULT NULL COMMENT '調査要否',
  `due_date` DATE NULL DEFAULT NULL COMMENT '支払予定日',
  `payment_date` DATE NULL DEFAULT NULL COMMENT '支払処理日',
  `setback_date` DATE NULL DEFAULT NULL COMMENT '組戻し処理日',
  `refund_premium` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未経過保険料',
  `receivable_premium` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未収保険料',
  `refund_premium_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未経過保険料調整額',
  `refund_premium_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT '未経過保険料調整額題目',
  `receivable_premium_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未収保険料調整額',
  `receivable_premium_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT '未収保険料調整額題目',
  `custom_premium_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT 'その他保険料調整額',
  `custom_premium_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT 'その他保険料調整額題目',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_claim_headers_tenants` (`tenant_id` ASC),
  INDEX `FK_claim_headers_contracts_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  INDEX `CAND_claim_headers` (`tenant_id` ASC, `claim_trxs_id` ASC),
  INDEX `FK_claim_headers_1st_underwriter_idx` (`tenant_id` ASC, `first_underwriter_id` ASC),
  INDEX `FK_claim_headers_2nd_underwriter_idx` (`tenant_id` ASC, `second_underwriter_id` ASC),
  CONSTRAINT `FK_claim_headers_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `luigi2_test`.`contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_claim_headers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `luigi2_test`.`tenants` (`id`),
  CONSTRAINT `FK_claim_headers_1st_underwriter`
    FOREIGN KEY (`tenant_id` , `first_underwriter_id`)
    REFERENCES `luigi2_test`.`users` (`tenant_id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_claim_headers_2nd_underwriter`
    FOREIGN KEY (`tenant_id` , `second_underwriter_id`)
    REFERENCES `luigi2_test`.`users` (`tenant_id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金・給付金請求情報';

--- commission_rates

ALTER TABLE `luigi2_test`.`commission_rates` 
DROP COLUMN `version`,
DROP COLUMN `policy_code`,
DROP COLUMN `product_type`,
DROP COLUMN `base_rider`;

--- contract_commission_rates

ALTER TABLE `luigi2_test`.`contract_commission_rates` 
DROP COLUMN `version`,
DROP COLUMN `policy_code`,
DROP COLUMN `product_type`,
DROP COLUMN `base_rider`;

--- contract_commissions

ALTER TABLE `luigi2_test`.`contract_commissions` 
DROP COLUMN `version`,
DROP COLUMN `policy_code`,
DROP COLUMN `product_type`,
DROP COLUMN `base_rider`;

--- contract_log

ALTER TABLE `luigi2_test`.`contract_log` 
CHANGE COLUMN `sequence_no` `sequence_no` SMALLINT(4) UNSIGNED NOT NULL COMMENT '連番' ;

--- deposit_details

ALTER TABLE `luigi2_test`.`deposit_details` 
CHANGE COLUMN `premium_sequence_no` `premium_sequence_no` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '保険料連番' 
ADD INDEX `CAND_deposit_details` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `due_date` ASC);

--- frequencies

ALTER TABLE `luigi2_test`.`frequencies` 
CHANGE COLUMN `sequence_no` `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番' ;

--- maintenance_requests_customer

ALTER TABLE `luigi2_test`.`maintenance_requests_customer` 
CHANGE COLUMN `role_sequence_no` `role_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT 'ロール連番' ;

--- new_business_documents

ALTER TABLE `luigi2_test`.`new_business_documents` 
CHANGE COLUMN `sequence_no` `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番' ;

--- premium_headers

ALTER TABLE `luigi2_test`.`premium_headers` 
CHANGE COLUMN `premium_sequence_no` `premium_sequence_no` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '保険料連番' ,
ADD INDEX `CAND_premium_headers` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC);

--- insured_objects

ALTER TABLE `luigi2_test`.`insured_objects` 
CHANGE COLUMN `sequence_no` `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番' ;

--- risk_headers

ALTER TABLE `luigi2_test`.`risk_headers` 
CHANGE COLUMN `risk_sequence_no` `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番' ,
ADD INDEX `CAND_risk_headers` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `risk_sequence_no` ASC);

--- substandard

ALTER TABLE `luigi2_test`.`substandard` 
CHANGE COLUMN `insured_sequence_no` `insured_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障対象連番' ,
CHANGE COLUMN `exclusion_sequence_no` `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '特別条件連番' ,
RENAME TO  `luigi2_test`.`substandards` ;

--- third_party_org

ALTER TABLE `luigi2_test`.`third_party_org` 
DROP FOREIGN KEY `FK_third_party_org_claim_details`;

ALTER TABLE `luigi2_test`.`third_party_org` 
CHANGE COLUMN `sequence_no` `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障連番' ,
CHANGE COLUMN `org_sequence_no` `org_sequence_no` TINYINT(1) UNSIGNED NOT NULL COMMENT '第三者機関連番' ;

ALTER TABLE `luigi2_test`.`third_party_org` 
ADD CONSTRAINT `FK_third_party_org_claim_details`
  FOREIGN KEY (`tenant_id` , `claim_trxs_id` , `risk_sequence_no`)
  REFERENCES `luigi2_test`.`claim_details` (`tenant_id` , `claim_trxs_id` , `risk_sequence_no`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

--- maintenance_documents

ALTER TABLE `luigi2_test`.`maintenance_documents` 
DROP FOREIGN KEY `FK_maintenance_documents_maintenance_requests`;

ALTER TABLE `luigi2_test`.`maintenance_documents` 
DROP COLUMN `request_no`,
ADD COLUMN `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号' AFTER `tenant_id`,
CHANGE COLUMN `sequence_no` `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番' ,
DROP INDEX `FK_maintenance_documents_maintenance_requests_idx` ,
ADD INDEX `FK_maintenance_documents_maintenance_requests_idx` (`tenant_id` ASC, `request_no` ASC),
DROP INDEX `CAND_maintenance_documents` ,
ADD INDEX `CAND_maintenance_documents` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC);

ALTER TABLE `luigi2_test`.`maintenance_documents` 
ADD CONSTRAINT `FK_maintenance_documents_maintenance_requests`
  FOREIGN KEY (`tenant_id` , `request_no`)
  REFERENCES `luigi2_test`.`maintenance_requests` (`tenant_id` , `request_no`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

--- service_instances

ALTER TABLE `luigi2_test`.`service_instances` 
CHANGE COLUMN `inherent_text` `inherent_text` TEXT NULL DEFAULT NULL COMMENT '固有TEXTデータ' ;

--- service_templates

ALTER TABLE `luigi2_test`.`service_templates` 
CHANGE COLUMN `inherent_text` `inherent_text` TEXT NULL DEFAULT NULL COMMENT '固有TEXTデータ' ;


-- <<LG2-178


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

