-- MySQL Workbench Forward Engineering



ALTER TABLE `deposit_details`
DROP INDEX `CAND_deposit_details` ,
ADD UNIQUE INDEX `CAND_deposit_details` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `due_date` ASC, `batch_no` ASC, `cash_detail_no` ASC);
