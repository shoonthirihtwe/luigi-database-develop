-- MySQL Script
-- 2022-08-14 06:01
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `maintenance_requests_service_objects` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `data` JSON NULL DEFAULT NULL COMMENT '固有データ',
  `sequence_no` TINYINT(3) NOT NULL COMMENT '保全申請サービスオブジェクト連番',
  `tx_type` CHAR(1) NOT NULL COMMENT 'トランザクション種別',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_so_maintenance_requests_idx` (`tenant_id` ASC, `request_no` ASC),
  UNIQUE INDEX `CAND_maintenance_requests_so` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC),
  CONSTRAINT `FK_maintenance_requests_so_maintenance_requests`
    FOREIGN KEY (`tenant_id` , `request_no`)
    REFERENCES `maintenance_requests` (`tenant_id` , `request_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_so_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請サービスオブジェクト';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
