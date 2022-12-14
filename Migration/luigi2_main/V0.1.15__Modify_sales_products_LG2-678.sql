-- MySQL Script
-- 2021-10-05 12:33
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



ALTER TABLE `sales_products` 
ADD COLUMN `product_code` CHAR(10) NULL DEFAULT NULL COMMENT '保険商品コード' AFTER `tenant_id`,
ADD INDEX `FK_sales_products_products_idx` (`tenant_id` ASC, `product_code` ASC);

ALTER TABLE `sales_products` 
ADD CONSTRAINT `FK_sales_products_products`
  FOREIGN KEY (`tenant_id` , `product_code`)
  REFERENCES `products` (`tenant_id` , `product_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
