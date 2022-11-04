-- MySQL Script
-- 2022-09-30 12:20
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



CREATE TABLE IF NOT EXISTS `benefit_group_types` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `type_code` VARCHAR(2) NOT NULL COMMENT '種別コード',
  `type_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '種別名',
  `ib_flag` CHAR(1) NOT NULL DEFAULT 'I' COMMENT '業法/内規フラグ',
  `memo` TEXT NULL DEFAULT NULL COMMENT 'メモ',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_benefit_group_types_tenants_idx` (`tenant_id` ASC),
  INDEX `CAND_benefit_group_types` (`tenant_id` ASC, `type_code` ASC),
  CONSTRAINT `FK_benefit_group_types_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金・給付金グループ種別マスタ';

CREATE TABLE IF NOT EXISTS `sum_up_check_maps` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `benefit_group_type` VARCHAR(2) NOT NULL COMMENT '保険金・給付金グループ種別コード',
  `sum_up_amount` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '通算上限額',
  `target_type` VARCHAR(2) NOT NULL COMMENT '通算対象者',
  `start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_sum_up_check_maps_tenants_idx` (`tenant_id` ASC),
  INDEX `FK_sum_up_check_maps_benefit_group_types_idx` (`tenant_id` ASC, `benefit_group_type` ASC),
  INDEX `CAND_sum_up_check_maps` (`tenant_id` ASC, `benefit_group_type` ASC, `target_type` ASC),
  CONSTRAINT `FK_sum_up_check_maps_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_sum_up_check_maps_benefit_group_types`
    FOREIGN KEY (`tenant_id` , `benefit_group_type`)
    REFERENCES `benefit_group_types` (`tenant_id` , `type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '通算チェックマップ';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
