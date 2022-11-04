-- MySQL Script
-- 2022-09-02 15:30
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



CREATE TABLE IF NOT EXISTS `service_instances_base_data` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `business_group_type` CHAR(2) NULL DEFAULT NULL COMMENT '業務グループ種別',
  `source_key` VARCHAR(63) NOT NULL COMMENT 'ソースキー',
  `source_type` CHAR(1) NOT NULL DEFAULT '2' COMMENT 'サービスソース種別',
  `inherent_json` JSON NULL DEFAULT NULL COMMENT '固有JSONデータ',
  `inherent_text` TEXT NULL DEFAULT NULL COMMENT '固有TEXTデータ',
  `description` TEXT NULL DEFAULT NULL COMMENT '概要',
  `status` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ステータス',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  INDEX `FK_service_instances_base_data_tenants_idx` (`tenant_id` ASC),
  INDEX `FK_service_instances_base_data_bgt_idx` (`business_group_type` ASC),
  CONSTRAINT `FK_service_instances_base_data_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_instances_base_data_bgt`
    FOREIGN KEY (`business_group_type`)
    REFERENCES `business_group_type_master` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '基盤サービスインスタンス';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
