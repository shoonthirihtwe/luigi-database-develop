-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `billing_details` 
DROP COLUMN `factoring_transaction_id`,
DROP INDEX `CAND_billing_details` ,
ADD INDEX `CAND_billing_details` (`tenant_id` ASC, `billng_header_no` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC),
DROP INDEX `factoring_transaction_id_idx` ;

ALTER TABLE `deposit_details` 
DROP COLUMN `factoring_transaction_id`,
DROP INDEX `CAND_deposit_details` ,
ADD INDEX `CAND_deposit_details` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `due_date` ASC),
DROP INDEX `factoring_transaction_id_idx` ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
