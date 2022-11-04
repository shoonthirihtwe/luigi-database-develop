ALTER TABLE `luigi2_test`.`agency_commissions_paid` 
ADD COLUMN `process_date` DATE NULL DEFAULT NULL COMMENT '処理日' AFTER `premium_count_s`;