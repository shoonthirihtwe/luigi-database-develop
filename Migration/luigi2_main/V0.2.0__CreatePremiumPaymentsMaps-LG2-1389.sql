-- MySQL Script
-- 2022-09-30 12:02
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



CREATE TABLE IF NOT EXISTS `premium_payments_maps` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NOT NULL COMMENT '販売プラン種別コード',
  `start_date` DATE NOT NULL COMMENT '開始日',
  `end_date` DATE NOT NULL COMMENT '終了日',
  `frequency` VARCHAR(2) NOT NULL COMMENT '保険料払込回数',
  `payment_method` CHAR(1) NOT NULL COMMENT '払込方法',
  `payment_pattern` CHAR(2) NOT NULL COMMENT '決済周期',
  `payment_date_order` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '決済日序数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_premium_payments_maps_tenants` (`tenant_id` ASC),
  INDEX `FK_premium_payments_maps_sales_products_idx` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC),
  INDEX `CAND_premium_payments_maps` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC, `start_date` ASC, `end_date` ASC, `frequency` ASC, `payment_method` ASC),
  CONSTRAINT `FK_premium_payments_maps_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`),
  CONSTRAINT `FK_premium_payments_maps_sales_products`
    FOREIGN KEY (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    REFERENCES `sales_products` (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険料払込規則マップ';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
