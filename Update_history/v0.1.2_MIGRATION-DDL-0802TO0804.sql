-- MySQL Script
-- 2021-08-04 17:49
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


ALTER TABLE `claim_headers` 
DROP COLUMN `risk_sequence_no`;

-- >>LG2-296

--- maintenance_requests_customer

ALTER TABLE `maintenance_requests_customer` 
DROP COLUMN `role_sequence_no`,
ADD COLUMN `sequence_no` TINYINT(2) NOT NULL COMMENT '保全申請顧客連番' AFTER `request_no`,
DROP INDEX `CAND_maintenance_requests_customer` ,
ADD UNIQUE INDEX `CAND_maintenance_requests_customer` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC),
ADD UNIQUE INDEX `UNIQ_maintenance_requests_customer_role` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC, `role` ASC);

--- maintenance_requests_customer_individual

ALTER TABLE `maintenance_requests_customer_individual` 
DROP FOREIGN KEY `FK_maintenance_requests_customer_individual_mrc`;

ALTER TABLE `maintenance_requests_customer_individual` 
ADD COLUMN `sequence_no` TINYINT(2) NOT NULL COMMENT '保全申請顧客連番' AFTER `request_no`,
DROP INDEX `CAND_maintenance_requests_customer_individual` ,
ADD INDEX `CAND_maintenance_requests_customer_individual` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC);

ALTER TABLE `maintenance_requests_customer_individual` 
ADD CONSTRAINT `FK_maintenance_requests_customer_individual_mrc`
  FOREIGN KEY (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
  REFERENCES `maintenance_requests_customer` (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

--- maintenance_requests_customer_corporate

ALTER TABLE `maintenance_requests_customer_corporate` 
DROP FOREIGN KEY `FK_maintenance_requests_customer_corporate_mrc`;

ALTER TABLE `maintenance_requests_customer_corporate` 
ADD COLUMN `sequence_no` TINYINT(2) NOT NULL COMMENT '保全申請顧客連番' AFTER `request_no`,
DROP INDEX `CAND_maintenance_requests_customer_corporate` ,
ADD INDEX `CAND_maintenance_requests_customer_corporate` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC);

ALTER TABLE `maintenance_requests_customer_corporate` 
ADD CONSTRAINT `FK_maintenance_requests_customer_corporate_mrc`
  FOREIGN KEY (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
  REFERENCES `maintenance_requests_customer` (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- <<LG2-296


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
