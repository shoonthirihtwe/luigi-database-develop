-- MySQL Script
-- 2021-08-24 13:16
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `renewal_info` 
ADD COLUMN `renewal_notification_date_1` DATETIME NULL DEFAULT NULL COMMENT '更新案内送信日時_1' AFTER `renewal_rejection`,
ADD COLUMN `renewal_notification_date_2` DATETIME NULL DEFAULT NULL COMMENT '更新案内送信日時_2' AFTER `renewal_notification_date_1`,
ADD COLUMN `renewal_notification_date_3` DATETIME NULL DEFAULT NULL COMMENT '更新案内送信日時_3（最終）' AFTER `renewal_notification_date_2`,
ADD COLUMN `apply_info_datetime` DATETIME NULL DEFAULT NULL COMMENT '更新通知送信日時' AFTER `renewal_notification_date_3`,
ADD COLUMN `apply_date` DATE NULL DEFAULT NULL COMMENT '更新適用日' AFTER `apply_info_datetime`,
ADD COLUMN `complete_info_datetime` DATETIME NULL DEFAULT NULL COMMENT '適用完了通知送信日時' AFTER `apply_date`;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
