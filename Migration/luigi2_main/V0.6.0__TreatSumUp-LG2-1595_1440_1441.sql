-- MySQL Script
-- 2022-10-07 15:10
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `benefits` 
ADD COLUMN `sum_up_value` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '通算使用値' AFTER `waiting_days`;

ALTER TABLE `risk_headers` 
ADD COLUMN `sum_up_value` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '通算使用値' AFTER `waiting_days`;

CREATE TABLE IF NOT EXISTS `risk_headers_mt_benefit_group_types` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障連番',
  `benefit_group_type` VARCHAR(2) NOT NULL COMMENT '保険金・給付金グループ種別',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `risk_headers_mt_benefit_group_types_tenants_idx` (`tenant_id` ASC),
  INDEX `risk_headers_mt_benefit_group_types_risk_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `risk_sequence_no` ASC),
  INDEX `risk_headers_mt_benefit_group_types_bgt_idx` (`tenant_id` ASC, `benefit_group_type` ASC),
  INDEX `CAND_risk_headers_mt_benefit_group_types` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `risk_sequence_no` ASC, `benefit_group_type` ASC),
  CONSTRAINT `risk_headers_mt_benefit_group_types_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `risk_headers_mt_benefit_group_types_risk`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no` , `risk_sequence_no`)
    REFERENCES `risk_headers` (`tenant_id` , `contract_no` , `contract_branch_no` , `risk_sequence_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `risk_headers_mt_benefit_group_types_bgt`
    FOREIGN KEY (`tenant_id` , `benefit_group_type`)
    REFERENCES `benefit_group_types` (`tenant_id` , `type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `risk_headers_mt_benefit_group_types_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保障 * 保険金・給付金グループ種別中間テーブル';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
