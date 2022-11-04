-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `billing_details` 
ADD COLUMN `factoring_transaction_id` VARCHAR(225) NULL DEFAULT NULL COMMENT '取引用ID' AFTER `premium_due_amount`,
DROP INDEX `CAND_billing_details` ,
ADD UNIQUE INDEX `CAND_billing_details` (`tenant_id` ASC, `billng_header_no` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC),
ADD INDEX `factoring_transaction_id_idx` (`factoring_transaction_id` ASC);

ALTER TABLE `deposit_details` 
ADD COLUMN `factoring_transaction_id` VARCHAR(225) NULL DEFAULT NULL COMMENT '取引用ID' AFTER `access_pass`,
DROP INDEX `CAND_deposit_details` ,
ADD UNIQUE INDEX `CAND_deposit_details` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `due_date` ASC),
ADD INDEX `factoring_transaction_id_idx` (`factoring_transaction_id` ASC);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
