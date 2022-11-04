-- -----------------------------------------------------
-- function getTransferDate
-- -----------------------------------------------------
DROP function IF EXISTS `getTransferDate`;

DELIMITER $$
CREATE DEFINER=`app`@`%` FUNCTION `getTransferDate`(inceptionDate VARCHAR(8), dayNum VARCHAR(2)) RETURNS varchar(8) CHARSET utf8
BEGIN

	
    
    
    
    
	DECLARE date1 varchar(8);
    DECLARE date2 varchar(8);
    DECLARE date3 varchar(8);
    DECLARE flag  varchar(1);
    outer_label:  BEGIN
    
    set date1 = concat(DATE_FORMAT(inceptionDate,'%Y%m'), dayNum);
    
    select holiday_flag into flag from calendars where DATE_FORMAT(date,'%Y%m%d') = DATE_FORMAT(date(date1),'%Y%m%d');
    
    if flag is not null then
		if flag = '0' then
			set date2 = date1;
		else
			while flag <> '0' do
				set date1 = DATE_FORMAT(DATE_ADD(date1, INTERVAL 1 DAY),'%Y%m%d');
				select holiday_flag from calendars where DATE_FORMAT(date,'%Y%m%d') = DATE_FORMAT(date1,'%Y%m%d') into flag;
				if flag = '0' then
					set date2 = date1;
					 LEAVE  outer_label;
				end if;
			END WHILE;  
        end if;
	else
		return '00000000';
    end if;
    
    END outer_label;
    
    select date_format(last_day(DATE_FORMAT(date1,'%Y%m%d')),'%Y%m%d') into date3;
    
    if unix_timestamp(date(date2)) < unix_timestamp(date(date3)) then
		return DATE_FORMAT(date2,'%Y%m%d');
	else
		return DATE_FORMAT(date3,'%Y%m%d');
    end if;
END$$

DELIMITER ;