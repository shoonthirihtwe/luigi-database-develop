-- -----------------------------------------------------
-- function getShouldtDate
-- -----------------------------------------------------
DROP function IF EXISTS `getShouldtDate`;

DELIMITER $$
CREATE DEFINER=`app`@`%` FUNCTION `getShouldtDate`(inceptionDate VARCHAR(8), kbn int, monthNum int) RETURNS varchar(8) CHARSET utf8
BEGIN
	
    
    
    
    
	IF kbn = 0 then
		RETURN DATE_FORMAT(DATE_ADD(inceptionDate, INTERVAL 1 YEAR),'%Y%m%d');
    ELSEIF kbn = 1 then 
        RETURN DATE_FORMAT(DATE_ADD(inceptionDate, INTERVAL monthNum MONTH),'%Y%m%d');
    END IF;
END$$

DELIMITER ;