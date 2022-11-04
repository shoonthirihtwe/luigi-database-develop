-- MySQL Script
-- 2021-08-24 11:19
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `agency_commissions_paid` 
CHANGE COLUMN `agency_code` `agency_code` VARCHAR(6) NOT NULL COMMENT '代理店コード' ,
CHANGE COLUMN `process_date` `process_date` DATE NULL DEFAULT NULL COMMENT '処理日' ;

ALTER TABLE `benefti_limits` 
CHANGE COLUMN `sales_plan_code` `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '保険プラン' ;

ALTER TABLE `benefits` 
CHANGE COLUMN `sales_plan_code` `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '保険プラン' ;

ALTER TABLE `contract_commissions` 
DROP COLUMN `sales_tax_rate`,
DROP COLUMN `premium_billing_period`,
DROP INDEX `CAND_contract_commissions` ;

ALTER TABLE `sales_products` 
DROP COLUMN `sales_plan_name_display`,
ADD COLUMN `sale_plan_name_display` VARCHAR(64) NULL DEFAULT NULL COMMENT '画面表示名' AFTER `sales_plan_name`;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;