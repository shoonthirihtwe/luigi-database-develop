-- -----------------------------------------------------
-- function shouldtDate
-- -----------------------------------------------------
DROP function IF EXISTS `shouldtDate`;

DELIMITER $$
CREATE DEFINER=`app`@`%` FUNCTION `shouldtDate`(issue_date date, batchDate date, frequency varchar(2), billing_month int) RETURNS varchar(8) CHARSET utf8
BEGIN
    declare cnt int;
    declare diff int;
    declare result date;

	
    
    
    
    

	IF frequency = '01' then
        set cnt = 12;
    ELSEIF frequency = '02' then
	    set cnt = 6;
    ELSEIF frequency = '12' then
        set cnt = 1;
	end if;

    set issue_date = DATE_FORMAT(issue_date, '%Y-%m-01');
    set batchDate = LAST_DAY(batchDate);
    
    set diff = ceil((TIMESTAMPDIFF(MONTH,issue_date,batchDate) / cnt));

    set result = DATE_ADD(issue_date,interval diff * cnt MONTH);
    

    
    
    

	if frequency <> '12' then
		if billing_month = -1 then
			
			set result = DATE_SUB(result,interval 1 MONTH);
		ELSEIF billing_month = 1 then
			
			set result = DATE_ADD(result,interval 1 MONTH);
		end if;
	end if;

    return DATE_FORMAT(result,'%Y%m%d');
END$$

DELIMITER ;
