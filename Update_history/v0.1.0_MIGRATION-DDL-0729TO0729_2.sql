-- MySQL Script
-- 2021-07-29 14:42
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;

-- >>LG2-149#comment-90488573
ALTER TABLE `luigi2_test`.`refund_amount`
ADD INDEX `CAND_refund_amount` (`tenant_id` ASC, `request_no` ASC),
ADD CONSTRAINT `UNIQ_refund_amount` UNIQUE (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `request_no` ASC),
COMMENT = '払戻金' ;
-- <<LG2-149#comment-90488573


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
