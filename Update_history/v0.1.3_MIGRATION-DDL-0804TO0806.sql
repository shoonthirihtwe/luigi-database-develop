-- MySQL Script
-- 2021-08-06 10:41
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- >>LG2-341
ALTER TABLE `maintenance_requests_customer_individual`
DROP INDEX `CAND_maintenance_requests_customer_individual` ,
ADD UNIQUE INDEX `CAND_maintenance_requests_customer_individual` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC);

ALTER TABLE `maintenance_requests_customer_corporate`
DROP INDEX `CAND_maintenance_requests_customer_corporate` ,
ADD UNIQUE INDEX `CAND_maintenance_requests_customer_corporate` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC);
-- <<LG2-341


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
