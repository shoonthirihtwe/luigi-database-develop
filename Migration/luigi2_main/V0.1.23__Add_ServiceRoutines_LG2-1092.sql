ALTER TABLE `service_instances` 
DROP COLUMN `business_group_type`;

ALTER TABLE `service_templates` 
DROP COLUMN `business_group_type`;

CREATE TABLE IF NOT EXISTS `service_routines` (
  `business_group_type` CHAR(2) NOT NULL COMMENT '業務グループ種別',
  `label` VARCHAR(63) NOT NULL COMMENT 'ルーチン名称',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`business_group_type`, `label`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '固有ルーチンマスタ';

CREATE TABLE IF NOT EXISTS `service_routine_interfaces` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ルーチンインターフェイスID',
  `business_group_type` CHAR(2) NOT NULL COMMENT '業務グループ種別',
  `routine_label` VARCHAR(63) NOT NULL COMMENT 'ルーチン名称',
  `interface_sequence_no` TINYINT(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'ルーチンインターフェイス連番',
  `label` TEXT NULL DEFAULT NULL COMMENT 'ルーチンインターフェイス名称',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  INDEX `service_routine_interfaces_service_routines_idx` (`business_group_type` ASC, `routine_label` ASC),
  INDEX `CAND_service_routine_interfaces` (`business_group_type` ASC, `routine_label` ASC, `interface_sequence_no` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `service_routine_interfaces_service_routines`
    FOREIGN KEY (`business_group_type` , `routine_label`)
    REFERENCES `service_routines` (`business_group_type` , `label`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '固有ルーチンインターフェイスマスタ' ;

CREATE TABLE IF NOT EXISTS `service_instances_mt_routine_interfaces` (
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `routine_interface_id` INT(10) UNSIGNED NOT NULL COMMENT 'ルーチンインターフェイスID',
  `instance_id` INT(10) UNSIGNED NOT NULL COMMENT 'サービスインスタンスID',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`tenant_id`, `routine_interface_id`, `instance_id`),
  INDEX `FK_service_instances_mt_ri_tenants` (`tenant_id` ASC),
  INDEX `FK_service_instances_mt_ri_instances_idx` (`instance_id` ASC),
  INDEX `FK_service_instances_mt_ri_interfaces_idx` (`routine_interface_id` ASC),
  CONSTRAINT `FK_service_instances_mt_ri_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`),
  CONSTRAINT `FK_service_instances_mt_ri_instances`
    FOREIGN KEY (`instance_id`)
    REFERENCES `service_instances` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_instances_mt_ri_interfaces`
    FOREIGN KEY (`routine_interface_id`)
    REFERENCES `service_routine_interfaces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'インスタンス * ルーチンインターフェイス中間テーブル' ;
