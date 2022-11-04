-- MySQL Workbench Forward Engineering



-- Change the value of `source_type` default to '2:Repository' from '0:undefined'.

ALTER TABLE `service_instances` 
CHANGE COLUMN `source_type` `source_type` CHAR(1) NOT NULL DEFAULT '2' COMMENT 'サービスソース種別' ;
ALTER TABLE `service_templates` 
CHANGE COLUMN `source_type` `source_type` CHAR(1) NOT NULL DEFAULT '2' COMMENT 'サービスソース種別' ;

-- Add `sequence_no` to `service_objects` in the place of `level`.

ALTER TABLE `service_objects` 
DROP COLUMN `level`,
ADD COLUMN `sequence_no` TINYINT(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '連番' AFTER `contract_branch_no`;

-- Add FK on `business_group_type`

ALTER TABLE `service_routines` 
ADD CONSTRAINT `FK_service_routines_business_group_type`
  FOREIGN KEY (`business_group_type`)
  REFERENCES `business_group_type_master` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `service_routine_interfaces` 
ADD CONSTRAINT `FK_service_routine_interfaces_business_group_type`
  FOREIGN KEY (`business_group_type`)
  REFERENCES `business_group_type_master` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `screen_master` 
DROP FOREIGN KEY `screen_master_business_group_type`;

ALTER TABLE `screen_master` 
ADD INDEX `FK_screen_master_business_group_type_idx` (`business_group_type` ASC),
DROP INDEX `screen_master_business_group_type_idx` ;

ALTER TABLE `screen_master` 
ADD CONSTRAINT `FK_screen_master_business_group_type`
  FOREIGN KEY (`business_group_type`)
  REFERENCES `business_group_type_master` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
