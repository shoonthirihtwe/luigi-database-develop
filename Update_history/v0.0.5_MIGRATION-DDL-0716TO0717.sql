-- MySQL Script
-- 2021-07-17 02:27
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `luigi2_test` ;

-- >>LG2-156#comment-88638600
ALTER TABLE `luigi2_test`.`code_master` 
DROP INDEX `CAND_code_master` ,
ADD UNIQUE INDEX `CAND_code_master` (`field` ASC, `tbl` ASC, `code_value` ASC);
-- <<LG2-156#comment-88638600

-- >>LG2-89#comment-88589509
ALTER TABLE `luigi2_test`.`billing_details` 
CHANGE COLUMN `due_date` `due_date` VARCHAR(6) NULL DEFAULT NULL COMMENT '充当月' ;

ALTER TABLE `luigi2_test`.`deposit_details` 
CHANGE COLUMN `due_date` `due_date` VARCHAR(6) NULL DEFAULT NULL COMMENT '充当月' ;
-- <<LG2-89#comment-88589509

-- >>LG2-232
ALTER TABLE `luigi2_test`.`notifications` 
CHANGE COLUMN `nitification_method` `notification_method` VARCHAR(2) NULL DEFAULT NULL COMMENT '通知方法' ;

ALTER TABLE `luigi2_test`.`refund_amount` 
CHANGE COLUMN `request_no` `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号' ;

ALTER TABLE `luigi2_test`.`maintenance_requests` 
DROP COLUMN `attached_10_url`,
DROP COLUMN `attached_10_title`,
DROP COLUMN `attached_9_url`,
DROP COLUMN `attached_9_title`,
DROP COLUMN `attached_8_url`,
DROP COLUMN `attached_8_title`,
DROP COLUMN `attached_7_url`,
DROP COLUMN `attached_7_title`,
DROP COLUMN `attached_6_url`,
DROP COLUMN `attached_6_title`,
DROP COLUMN `attached_5_url`,
DROP COLUMN `attached_5_title`,
DROP COLUMN `attached_4_url`,
DROP COLUMN `attached_4_title`,
DROP COLUMN `attached_3_url`,
DROP COLUMN `attached_3_title`,
DROP COLUMN `attached_2_url`,
DROP COLUMN `attached_2_title`,
DROP COLUMN `attached_1_url`,
DROP COLUMN `attached_1_title`;
-- <<LG2-232


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

