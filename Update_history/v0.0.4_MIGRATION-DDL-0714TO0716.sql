-- MySQL Script
-- 2021-07-16 10:43
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;


-- >>LG2-178

--- notifications

ALTER TABLE `luigi2_test`.`notifications` 
ADD COLUMN `data` JSON NULL DEFAULT NULL COMMENT '埋込変数データ' AFTER `error_flag`;

--- maintenance_requests_no

CREATE TABLE IF NOT EXISTS `luigi2_test`.`maintenance_requests_no` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `update_count` INT(11) NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_no_tenants_idx` (`tenant_id` ASC),
  INDEX `CAND_maintenance_requests_no` (`tenant_id` ASC, `request_no` ASC),
  CONSTRAINT `FK_maintenance_requests_no_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `luigi2_test`.`tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請番号';


-- <<LG2-178


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

