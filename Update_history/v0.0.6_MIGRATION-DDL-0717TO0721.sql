-- MySQL Script
-- 2021-07-21 20:03
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;


-- >>LG2-178

--- claim_details

ALTER TABLE `luigi2_test`.`claim_details` 
DROP COLUMN `cancer_onset_date`,
DROP COLUMN `sales_plan_type_code`,
DROP COLUMN `sales_plan_code`,
ADD COLUMN `claim_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '請求日数' AFTER `treatment_times`,
CHANGE COLUMN `treatment_date_from` `treatment_date_from` DATE NULL DEFAULT NULL COMMENT '請求対象期間(from)' ,
CHANGE COLUMN `treatment_date_to` `treatment_date_to` DATE NULL DEFAULT NULL COMMENT '請求対象期間(to)' ,
CHANGE COLUMN `treatment_times` `treatment_times` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '請求対象回数' ;

--- risk_headers

ALTER TABLE `luigi2_test`.`risk_headers` 
DROP COLUMN `expration_date`,
ADD COLUMN `termination_base_date` DATE NULL DEFAULT NULL COMMENT '保障消滅基準日' AFTER `other_insurance_yn`,
ADD COLUMN `termination_date` DATE NULL DEFAULT NULL COMMENT '保障消滅日' AFTER `termination_base_date`,
ADD COLUMN `termination_title` VARCHAR(255) NULL DEFAULT NULL COMMENT '保障消滅事由' AFTER `termination_date`,
ADD COLUMN `calc_base` CHAR(1) NULL DEFAULT NULL COMMENT '支払金額ベース' AFTER `termination_title`,
ADD COLUMN `compense_rate` TINYINT(3) UNSIGNED NULL DEFAULT NULL AFTER `calc_base`,
ADD COLUMN `benefit_base_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '基本給付額' AFTER `compense_rate`,
ADD COLUMN `benefit_base_unit` CHAR(1) NULL DEFAULT NULL COMMENT '基本給付額単位' AFTER `benefit_base_amount`,
ADD COLUMN `disclaim_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '免責額・自己負担額' AFTER `benefit_base_unit`,
ADD COLUMN `disclaim_unit` CHAR(1) NULL DEFAULT NULL COMMENT '免責額・自己負担額単位' AFTER `disclaim_amount`,
ADD COLUMN `payg_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額' AFTER `disclaim_unit`,
ADD COLUMN `total_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算支払限度額' AFTER `payg_limit_amount`,
ADD COLUMN `after_over_limit` CHAR(1) NULL DEFAULT NULL COMMENT '支払限度超過後の契約状態	' AFTER `total_limit_amount`,
ADD COLUMN `disclaim_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '免責日数' AFTER `after_over_limit`,
ADD COLUMN `total_limit_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '通算限度日数・回数' AFTER `disclaim_days`,
ADD COLUMN `waiting_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '待機日数' AFTER `total_limit_days`;

-- <<LG2-178

-- >>LG2-116

--- contracts

ALTER TABLE `luigi2_test`.`contracts` 
ADD COLUMN `termination_base_date` DATE NULL DEFAULT NULL COMMENT '契約消滅基準日' AFTER `expiration_date`,
ADD COLUMN `termination_title` VARCHAR(255) NULL DEFAULT NULL COMMENT '契約消滅事由' AFTER `termination_date`,
CHANGE COLUMN `termination_date` `termination_date` DATE NULL DEFAULT NULL COMMENT '契約消滅日' ;

--- maintenance_requests

ALTER TABLE `luigi2_test`.`maintenance_requests` 
DROP COLUMN `occurred_date`,
ADD COLUMN `termination_base_date` DATE NULL DEFAULT NULL COMMENT '消滅基準日' AFTER `email_for_notification`,
ADD COLUMN `termination_title` VARCHAR(255) NULL DEFAULT NULL COMMENT '消滅事由' AFTER `termination_base_date`;

--- sales_products

ALTER TABLE `luigi2_test`.`sales_products` 
ADD COLUMN `termination_date_pattern` CHAR(2) NULL DEFAULT NULL COMMENT '消滅日算出パターン' AFTER `sort_no`,
ADD COLUMN `termination_date_order` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '消滅日序数' AFTER `termination_date_pattern`;

-- <<LG2-116


-- >>LG2-43

--- underwrintings

ALTER TABLE `luigi2_test`.`underwritings` 
DROP COLUMN `insured_customer_id`,
DROP COLUMN `contractor_customer_id`,
DROP COLUMN `sales_plan_type_code`,
DROP COLUMN `sales_plan_code`,
DROP COLUMN `card_anavailable_flag`,
DROP COLUMN `card_cust_number`,
DROP COLUMN `effective_date`,
DROP COLUMN `received_date`,
DROP COLUMN `application_date`;
-- <<LG2-43

-- customers_indivisual: fix typo

ALTER TABLE `luigi2_test`.`customers_indivisual` RENAME TO  `luigi2_test`.`customers_individual` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

