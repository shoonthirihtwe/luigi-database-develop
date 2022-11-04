-- MySQL Script
-- 2022-10-12 16:06
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `billing_details` 
DROP INDEX `CAND_billing_details` ,
ADD UNIQUE INDEX `CAND_billing_details` (`tenant_id` ASC, `billing_period` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC),
DROP INDEX `factoring_transaction_id_idx` ,
ADD INDEX `factoring_transaction_id_idx` (`tenant_id` ASC, `factoring_transaction_id` ASC);

ALTER TABLE `deposit_details` 
DROP INDEX `CAND_deposit_details` ,
ADD INDEX `CAND_deposit_details` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `due_date` ASC, `batch_no` ASC, `cash_detail_no` ASC),
DROP INDEX `factoring_transaction_id_idx` ,
ADD INDEX `factoring_transaction_id_idx` (`tenant_id` ASC, `factoring_transaction_id` ASC);

ALTER TABLE `agencies` 
ADD UNIQUE INDEX `CAND_agencies` (`tenant_id` ASC, `agency_code` ASC);

ALTER TABLE `agency_branches` 
ADD UNIQUE INDEX `CAND_agency_branches` (`tenant_id` ASC, `agency_code` ASC, `agency_branch_code` ASC);

ALTER TABLE `sales_agents` 
DROP INDEX `CAND_sales_agents` ,
ADD UNIQUE INDEX `CAND_sales_agents` (`tenant_id` ASC, `agent_code` ASC);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
