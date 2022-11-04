-- MySQL Script
-- 2022-10-12 16:06
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `customers_corporate` 
ADD COLUMN `corp_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 3' AFTER `corp_addr_knj_2`,
ADD COLUMN `rep10e_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 3' AFTER `rep10e_addr_knj_2`,
ADD COLUMN `contact_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 3' AFTER `contact_addr_knj_2`;

ALTER TABLE `maintenance_requests_customer_corporate` 
ADD COLUMN `corp_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 3' AFTER `corp_addr_knj_2`,
ADD COLUMN `rep10e_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 3' AFTER `rep10e_addr_knj_2`,
ADD COLUMN `contact_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 3' AFTER `contact_addr_knj_2`;

ALTER TABLE `customers_individual` 
ADD COLUMN `addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '住所漢字 3' AFTER `addr_knj_2`;

ALTER TABLE `maintenance_requests_customer_individual` 
ADD COLUMN `addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '住所漢字 3' AFTER `addr_knj_2`;

ALTER TABLE `claim_headers` 
ADD COLUMN `claimant_addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '請求者住所3(漢字)' AFTER `claimant_addr_knj_2`;

ALTER TABLE `beneficiaries` 
ADD COLUMN `addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '住所漢字 3' AFTER `addr_knj_2`;

ALTER TABLE `maintenance_requests_beneficiaries` 
ADD COLUMN `addr_knj_3` TEXT NULL DEFAULT NULL COMMENT '住所漢字 3' AFTER `addr_knj_2`;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
