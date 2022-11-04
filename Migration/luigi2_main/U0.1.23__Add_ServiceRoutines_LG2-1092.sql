ALTER TABLE `service_instances` 
ADD COLUMN `business_group_type` CHAR(2) NULL DEFAULT NULL COMMENT '業務グループ種別' AFTER `template_id`;

ALTER TABLE `service_templates` 
ADD COLUMN `business_group_type` CHAR(2) NULL DEFAULT NULL COMMENT '業務グループ種別' AFTER `id`;

DROP TABLE IF EXISTS `service_routines` ;
DROP TABLE IF EXISTS `service_routine_interfaces` ;
DROP TABLE IF EXISTS `service_instances_mt_routine_interfaces` ;
