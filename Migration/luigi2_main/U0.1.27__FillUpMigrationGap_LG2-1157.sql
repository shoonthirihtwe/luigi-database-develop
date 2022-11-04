-- MySQL Workbench Forward Engineering



ALTER TABLE `service_instances` 
CHANGE COLUMN `source_type` `source_type` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ソース種別' ;

ALTER TABLE `service_objects` 
DROP COLUMN `sequence_no`,
ADD COLUMN `level` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '階層' AFTER `description`;

ALTER TABLE `service_templates` 
CHANGE COLUMN `source_type` `source_type` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ソース種別' ;

ALTER TABLE `service_routines` 
DROP FOREIGN KEY `FK_service_routines_business_group_type`;

ALTER TABLE `service_routine_interfaces` 
DROP FOREIGN KEY `FK_service_routine_interfaces_business_group_type`;

ALTER TABLE `screen_master` 
DROP FOREIGN KEY `FK_screen_master_business_group_type`;

ALTER TABLE `screen_master` 
ADD INDEX `screen_master_business_group_type_idx` (`business_group_type` ASC),
DROP INDEX `FK_screen_master_business_group_type_idx` ;

ALTER TABLE `screen_master` 
ADD CONSTRAINT `screen_master_business_group_type`
  FOREIGN KEY (`business_group_type`)
  REFERENCES `business_group_type_master` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

