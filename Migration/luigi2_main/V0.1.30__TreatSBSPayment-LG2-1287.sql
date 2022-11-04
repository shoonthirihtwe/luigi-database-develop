-- MySQL Script
-- 2022-08-24 17:24
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


ALTER TABLE `contracts` 
ADD COLUMN `billing_info` JSON NULL DEFAULT NULL COMMENT '請求識別情報' AFTER `payment_date_order`;

ALTER TABLE `policy_holders_pay_method` 
ADD COLUMN `bank_account_holder` TEXT NULL DEFAULT NULL COMMENT '口座名義人' AFTER `bank_account_no`;

ALTER TABLE `customers_corporate` 
ADD COLUMN `corp_number` VARCHAR(13) NULL DEFAULT NULL COMMENT '法人番号' AFTER `corp_addr_knj_2`;

ALTER TABLE `products` 
ADD COLUMN `payment_info` JSON NULL DEFAULT NULL COMMENT '決済識別情報' AFTER `sender_emails_to_clients`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
