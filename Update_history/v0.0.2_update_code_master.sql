ALTER TABLE `luigi2_test`.`code_master` 
DROP FOREIGN KEY `FK_code_master_tenants`;

ALTER TABLE `luigi2_test`.`code_master` 
DROP COLUMN `tenant_id`,
ADD INDEX `CAND_code_master` (`field` ASC, `tbl` ASC, `code_value` ASC),
DROP INDEX `FK_code_master_tenants`;