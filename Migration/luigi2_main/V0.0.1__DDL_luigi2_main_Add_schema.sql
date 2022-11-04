-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema luigi2_main
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `tenants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tenants` ;

CREATE TABLE IF NOT EXISTS `tenants` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_name` VARCHAR(63) NOT NULL COMMENT 'テナント名',
  `site_url` VARCHAR(255) NULL DEFAULT NULL COMMENT 'サイトURL',
  `entry_redirect_url` VARCHAR(255) NULL DEFAULT NULL COMMENT '申込時リダクレクトURL',
  `batch_date` DATE NULL DEFAULT NULL COMMENT 'バッチ日付',
  `compensation_group_code` CHAR(1) NOT NULL COMMENT '補償グループ種別',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'テナントマスタ';


-- -----------------------------------------------------
-- Table `accident_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accident_rate` ;

CREATE TABLE IF NOT EXISTS `accident_rate` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `risk_code` CHAR(2) NULL DEFAULT NULL COMMENT 'リスク種類',
  `start_date` DATE NULL DEFAULT NULL COMMENT '適用開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '適用終了日',
  `factor_1` CHAR(3) NULL DEFAULT NULL COMMENT '要素1',
  `factor_2` CHAR(3) NULL DEFAULT NULL COMMENT '要素2',
  `age_from` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT '年齢 下限',
  `age_to` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT '年齢 上限',
  `accident_rate` DECIMAL(7,6) UNSIGNED NULL DEFAULT NULL COMMENT '予定発生率',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_accident_rate_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_accident_rate_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '予定発生率';


-- -----------------------------------------------------
-- Table `agencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agencies` ;

CREATE TABLE IF NOT EXISTS `agencies` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `agency_code` VARCHAR(5) NULL DEFAULT NULL COMMENT '代理店コード',
  `offcial_agency_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '財務局登録代理店コード',
  `corporate_individual_flag` CHAR(1) NULL DEFAULT '1' COMMENT '法人/個人区分',
  `corporation_type` CHAR(1) NULL DEFAULT NULL COMMENT '登録種別',
  `corporate_number` CHAR(13) NULL DEFAULT NULL,
  `withholding_tax` CHAR(1) NULL DEFAULT NULL COMMENT '源泉徴収区分',
  `agency_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '代理店名',
  `agency_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '代理店名（カナ）',
  `shop_name` VARCHAR(64) NULL DEFAULT NULL COMMENT '屋号',
  `zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号',
  `address` VARCHAR(64) NULL DEFAULT NULL COMMENT '住所',
  `rep_tel` VARCHAR(13) NULL DEFAULT NULL COMMENT '代表電話番号',
  `rep_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '代表者名',
  `rep_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '代表者名（カナ）',
  `rep_date_of_birth` DATE NULL DEFAULT NULL COMMENT '代表者生年月日',
  `person_in_charge_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名',
  `person_in_charge_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名（カナ）',
  `person_in_charge_tel` VARCHAR(13) NULL DEFAULT NULL COMMENT '担当者電話番号',
  `person_in_charge_email` VARCHAR(128) NULL DEFAULT NULL COMMENT '担当者メールアドレス',
  `person_in_charge_em_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '教育責任者　漢字',
  `person_in_charge_em_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '教育責任者　カナ',
  `person_in_charge_mg_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '管理責任者　漢字',
  `person_in_charge_mg_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '管理責任者　カナ',
  `start_date` DATE NULL DEFAULT NULL COMMENT '稼働開始日',
  `agency_flag` CHAR(1) NULL DEFAULT '1' COMMENT '代理店フラグ',
  `general_agent_flag` CHAR(1) NULL DEFAULT '0' COMMENT '総代理店フラグ',
  `commission_class` CHAR(1) NULL DEFAULT NULL COMMENT '手数料クラス',
  `commission_mode` VARCHAR(2) NULL DEFAULT NULL COMMENT '手数料モード',
  `registration_date` DATE NULL DEFAULT NULL COMMENT '登録日',
  `termination_date` DATE NULL DEFAULT NULL COMMENT '廃業日',
  `bank_code` TEXT NULL DEFAULT NULL,
  `bank_branch_code` TEXT NULL DEFAULT NULL,
  `type_of_account` TEXT NULL DEFAULT NULL,
  `bank_account_no` TEXT NULL DEFAULT NULL,
  `bank_account_holder` TEXT NULL DEFAULT NULL,
  `agency_status` INT(11) NULL DEFAULT NULL COMMENT '代理店ステータス',
  `memo` VARCHAR(1024) NULL DEFAULT NULL COMMENT 'memo',
  `rep_name_sei_knj` VARCHAR(64) NULL DEFAULT NULL,
  `rep_name_mei_knj` VARCHAR(64) NULL DEFAULT NULL,
  `rep_name_sei_kana` VARCHAR(64) NULL DEFAULT NULL,
  `rep_name_mei_kana` VARCHAR(64) NULL DEFAULT NULL,
  `person_in_charge_sei_knj` VARCHAR(64) NULL DEFAULT NULL,
  `person_in_charge_mei_knj` VARCHAR(64) NULL DEFAULT NULL,
  `person_in_charge_sei_kana` VARCHAR(64) NULL DEFAULT NULL,
  `person_in_charge_mei_kana` VARCHAR(64) NULL DEFAULT NULL,
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_agencies_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_agencies_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '代理店';


-- -----------------------------------------------------
-- Table `agency_branches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agency_branches` ;

CREATE TABLE IF NOT EXISTS `agency_branches` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `agency_code` VARCHAR(5) NULL DEFAULT NULL COMMENT '所属代理店コード',
  `agency_branch_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '支店コード',
  `agency_branch_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店名',
  `agency_branch_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店名（カナ）',
  `zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号',
  `address` VARCHAR(64) NULL DEFAULT NULL COMMENT '住所',
  `tel_no` VARCHAR(13) NULL DEFAULT NULL COMMENT '支店電話番号',
  `manager_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店管理者名',
  `manager_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '支店管理者名（カナ）',
  `person_in_charge_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名',
  `person_in_charge_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名（カナ）',
  `person_in_charge_tel` VARCHAR(13) NULL DEFAULT NULL COMMENT '担当者電話番号',
  `person_in_charge_email` VARCHAR(128) NULL DEFAULT NULL COMMENT '担当者メールアドレス',
  `start_date` DATE NULL DEFAULT NULL COMMENT '稼働開始日',
  `registration_date` DATE NULL DEFAULT NULL COMMENT '登録日',
  `termination_date` DATE NULL DEFAULT NULL COMMENT '廃業日',
  `agency_branch_type` CHAR(1) NULL DEFAULT NULL COMMENT '支店区分',
  `agency_branch_status` INT(11) NULL DEFAULT NULL COMMENT '支店ステータス',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_agency_branches_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_agency_branches_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '代理店支店';


-- -----------------------------------------------------
-- Table `agency_commissions_paid`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agency_commissions_paid` ;

CREATE TABLE IF NOT EXISTS `agency_commissions_paid` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `agency_code` VARCHAR(6) NOT NULL COMMENT '代理店コード',
  `record_date` VARCHAR(6) NOT NULL COMMENT '計上年月',
  `commission_amount_f` INT(8) NULL DEFAULT NULL COMMENT '支払手数料額合計_初年度',
  `commission_tax_f` INT(8) NULL DEFAULT NULL COMMENT '手数料消費税額合計_初年度',
  `commission_amount_s` INT(8) NULL DEFAULT NULL COMMENT '支払手数料額合計_2年目以降',
  `commission_tax_s` INT(8) NULL DEFAULT NULL COMMENT '手数料消費税額合計_2年目以降',
  `refund_amount` INT(8) NULL DEFAULT NULL COMMENT '戻入手数料額合計',
  `refund_tax` INT(8) NULL DEFAULT NULL COMMENT '戻入消費税額合計',
  `paid_amount` INT(8) NULL DEFAULT NULL COMMENT '手数料支払額',
  `paid_tax` INT(8) NULL DEFAULT NULL COMMENT '支払消費税額',
  `withhold_tax` INT(8) NULL DEFAULT NULL COMMENT '源泉徴収税額',
  `premium_amount_f` INT(8) NULL DEFAULT NULL COMMENT '手数料対象保険料合計_初年度',
  `premium_count_f` INT(5) NULL DEFAULT NULL COMMENT '手数料対象保険料件数_初年度',
  `premium_amount_s` INT(8) NULL DEFAULT NULL COMMENT '手数料対象保険料合計_2年目以降',
  `premium_count_s` INT(5) NULL DEFAULT NULL COMMENT '手数料対象保険料件数_2年目以降',
  `process_date` DATE NULL DEFAULT NULL COMMENT '処理日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_agency_commissions_paid_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_agency_commissions_paid_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '代理店手数料支払履歴';


-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roles` ;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `role_id` VARCHAR(8) NOT NULL COMMENT 'ロールID',
  `role_title` VARCHAR(12) NULL DEFAULT NULL COMMENT 'ロール名称',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_roles_tenants` (`tenant_id` ASC),
  INDEX `INDEX_role_id` (`tenant_id` ASC, `role_id` ASC),
  CONSTRAINT `FK_roles_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'アカウント種類';


-- -----------------------------------------------------
-- Table `authorities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `authorities` ;

CREATE TABLE IF NOT EXISTS `authorities` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `role_id` VARCHAR(8) NOT NULL COMMENT 'ロールID',
  `function_id` VARCHAR(12) NOT NULL COMMENT '機能ID',
  `api_yn` CHAR(1) NOT NULL DEFAULT '1' COMMENT 'API/画面制御',
  `allow_deny` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '実行可否',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_authorities_tenants` (`tenant_id` ASC),
  INDEX `FK_authorities_roles_idx` (`tenant_id` ASC, `role_id` ASC),
  INDEX `CAND_authorities` (`tenant_id` ASC, `role_id` ASC, `function_id` ASC),
  CONSTRAINT `FK_authorities_roles`
    FOREIGN KEY (`tenant_id` , `role_id`)
    REFERENCES `roles` (`tenant_id` , `role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_authorities_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '権限設定';


-- -----------------------------------------------------
-- Table `base_rider_mix`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `base_rider_mix` ;

CREATE TABLE IF NOT EXISTS `base_rider_mix` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `base_base_rider` CHAR(1) NULL DEFAULT NULL COMMENT '主契約　主契約／特約区分',
  `baser_product_type` VARCHAR(2) NULL DEFAULT NULL COMMENT '主契約　商品タイプ',
  `base_policy_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険種別コード',
  `base_version` VARCHAR(2) NULL DEFAULT NULL COMMENT '主契約　商品のバージョン',
  `rider_base_rider` CHAR(1) NULL DEFAULT NULL COMMENT '特約　主契約／特約区分',
  `rider_product_type` VARCHAR(2) NULL DEFAULT NULL COMMENT '特約　商品タイプ',
  `rider_policy_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '特約　保険種類コード',
  `rider_version` VARCHAR(2) NULL DEFAULT NULL COMMENT '特約　商品のバージョン',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_base_rider_mix_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_base_rider_mix_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '主契約/特約 MIXテーブル';


-- -----------------------------------------------------
-- Table `customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customers` ;

CREATE TABLE IF NOT EXISTS `customers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `customer_id` VARCHAR(12) NOT NULL COMMENT '顧客ID',
  `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分',
  `index_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '名寄せ名',
  `notification_flag` CHAR(1) NULL DEFAULT NULL COMMENT '定期通知受取の可否',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_customers_tenants` (`tenant_id` ASC),
  INDEX `CAND_customers` (`tenant_id` ASC, `customer_id` ASC),
  CONSTRAINT `FK_customers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '顧客マスタ';


-- -----------------------------------------------------
-- Table `sales_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sales_products` ;

CREATE TABLE IF NOT EXISTS `sales_products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NOT NULL COMMENT '販売プラン種別コード',
  `start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `sales_plan_name` VARCHAR(32) NULL DEFAULT NULL COMMENT '販売プラン名',
  `sale_plan_name_display` VARCHAR(64) NULL DEFAULT NULL COMMENT '画面表示名',
  `issue_age_upper` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT '販売加入年齢　上限',
  `issue_age_lower` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT '販売加入年齢　下限',
  `premium` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '保険料',
  `active_inactive` CHAR(1) NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `special_requirement` CHAR(1) NULL DEFAULT NULL COMMENT '特別条件',
  `sort_no` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT 'ソート番号',
  `termination_date_pattern` CHAR(2) NULL DEFAULT NULL COMMENT '消滅日算出パターン',
  `termination_date_order` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '消滅日序数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_sales_products_tenants` (`tenant_id` ASC),
  INDEX `CAND_sales_products` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC),
  INDEX `sales_products_sales_plan_idx` (`sales_plan_code` ASC, `sales_plan_type_code` ASC),
  CONSTRAINT `FK_sales_products_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '販売プラン：保険種類';


-- -----------------------------------------------------
-- Table `contracts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contracts` ;

CREATE TABLE IF NOT EXISTS `contracts` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `contract_status` VARCHAR(2) NULL DEFAULT NULL COMMENT '契約ステータス',
  `update_cnt` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '更新回数',
  `last_contract_id` VARCHAR(10) NULL DEFAULT NULL COMMENT '更新前証券番号',
  `new_contract_id` VARCHAR(20) NULL DEFAULT NULL COMMENT '新契約申込ID',
  `application_date` DATE NULL DEFAULT NULL COMMENT '申込日',
  `received_date` DATE NULL DEFAULT NULL COMMENT '受付日',
  `entry_date` DATE NULL DEFAULT NULL COMMENT '入力日',
  `inception_date` DATE NULL DEFAULT NULL COMMENT '契約開始日',
  `complete_date` DATE NULL DEFAULT NULL COMMENT '成立日',
  `first_premium_date` DATE NULL DEFAULT NULL COMMENT '初回保険料領収日',
  `effective_date` DATE NULL DEFAULT NULL COMMENT '責任開始日',
  `issue_date` DATE NULL DEFAULT NULL COMMENT '現契約日',
  `expiration_date` DATE NULL DEFAULT NULL COMMENT '満期日',
  `termination_base_date` DATE NULL DEFAULT NULL COMMENT '契約消滅基準日',
  `termination_date` DATE NULL DEFAULT NULL COMMENT '契約消滅日',
  `termination_title` VARCHAR(255) NULL DEFAULT NULL COMMENT '契約消滅事由',
  `free_lock_date` DATE NULL DEFAULT NULL COMMENT 'クーリングオフ日',
  `insurance_start_date` DATE NULL DEFAULT NULL COMMENT '保険期間（始）',
  `insurance_end_date` DATE NULL DEFAULT NULL COMMENT '保険期間（終）',
  `premium_start_date` DATE NULL DEFAULT NULL COMMENT '保険料払込期間（始）',
  `premium_end_date` DATE NULL DEFAULT NULL COMMENT '保険料払込期間（終）',
  `number_of_insured` TINYINT(2) NULL DEFAULT NULL COMMENT '契約者・被保険者数',
  `coverage_year` TINYINT(2) NULL DEFAULT NULL COMMENT '保険期間',
  `card_cust_number` VARCHAR(10) NULL DEFAULT NULL COMMENT 'カード登録顧客番号　※証券番号または親証券番号',
  `card_unavailable_flag` DATE NULL DEFAULT NULL COMMENT '決済不可フラグ',
  `frequency` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険料払込回数',
  `payment_method` CHAR(1) NULL DEFAULT NULL COMMENT '払込経路',
  `product` VARCHAR(2) NULL DEFAULT NULL COMMENT '主契約区分',
  `sales_plan_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '販売プランコード',
  `basic_policy_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '主契約ID',
  `hii_other_insurance` CHAR(1) NULL DEFAULT NULL COMMENT '他保険有無',
  `contractor_customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '契約者ID',
  `total_premium` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '合計保険料',
  `insured_customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '被保険者ID',
  `relationship` VARCHAR(2) NULL DEFAULT NULL COMMENT '契約者からみた続柄',
  `premium` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '保険料',
  `sales_method` VARCHAR(2) NULL DEFAULT NULL COMMENT '販売タイプ',
  `reinsurance_comp_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '再保険会社コード',
  `research_comp_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '調査会社コード',
  `suspend_status` CHAR(1) NULL DEFAULT NULL COMMENT '異動制限ステータス',
  `agency_code_1` VARCHAR(5) NULL DEFAULT NULL COMMENT '代理店コード1',
  `agent_code_1` VARCHAR(6) NULL DEFAULT NULL COMMENT '募集人コード1',
  `agent_share_1` TINYINT(3) NULL DEFAULT NULL COMMENT '募集割合1',
  `agency_code_2` VARCHAR(5) NULL DEFAULT NULL COMMENT '代理店コード2',
  `agent_code_2` VARCHAR(6) NULL DEFAULT NULL COMMENT '募集人コード2',
  `agent_share_2` TINYINT(3) NULL DEFAULT NULL COMMENT '募集割合2',
  `mypage_link_date` DATE NULL DEFAULT NULL COMMENT 'マイページ連携フラグ',
  `payment_pattern` CHAR(2) NULL DEFAULT NULL COMMENT '決済周期',
  `payment_date_order` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '決済日序数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_contracts_tenants` (`tenant_id` ASC),
  INDEX `CAND_contracts` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  INDEX `FK_contracts_sales_products_idx` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC),
  INDEX `FK_contracts_contractor_idx` (`tenant_id` ASC, `contractor_customer_id` ASC),
  INDEX `FK_contracts_insured_idx` (`tenant_id` ASC, `insured_customer_id` ASC),
  CONSTRAINT `FK_contracts_contractor`
    FOREIGN KEY (`tenant_id` , `contractor_customer_id`)
    REFERENCES `customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_contracts_insured`
    FOREIGN KEY (`tenant_id` , `insured_customer_id`)
    REFERENCES `customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_contracts_sales_products`
    FOREIGN KEY (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    REFERENCES `sales_products` (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_contracts_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '契約マスタ';


-- -----------------------------------------------------
-- Table `beneficiaries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beneficiaries` ;

CREATE TABLE IF NOT EXISTS `beneficiaries` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `beneficiary_code` VARCHAR(12) NULL DEFAULT NULL COMMENT '受取人ID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `role_type` VARCHAR(2) NOT NULL COMMENT 'ロールタイプ',
  `role_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT 'ロール連番',
  `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分',
  `start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `status` CHAR(1) NULL DEFAULT 'A' COMMENT 'ステータス',
  `name_knj_sei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名　姓（会社名）',
  `name_knj_mei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名　名',
  `name_kana_sei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名　姓　カナ(会社名)',
  `name_kana_mei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名　名　カナ',
  `share` INT(3) UNSIGNED NULL DEFAULT NULL COMMENT '受取の割合',
  `rel_ship_to_insured` VARCHAR(2) NULL DEFAULT NULL COMMENT '被保険者からみた続柄',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_beneficialies_tenants` (`tenant_id` ASC),
  INDEX `FK_beneficialies_contracts_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  CONSTRAINT `FK_beneficialies_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_beneficialies_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '受取人情報';


-- -----------------------------------------------------
-- Table `benefits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `benefits` ;

CREATE TABLE IF NOT EXISTS `benefits` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '保険プラン',
  `sales_plan_type_code` VARCHAR(2) NOT NULL COMMENT '販売プラン種別コード',
  `benefit_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険金タイプ',
  `benefit_text` VARCHAR(20) NULL DEFAULT NULL COMMENT '保険金名称',
  `payment_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '支払タイプ',
  `payment_text` VARCHAR(20) NULL DEFAULT NULL COMMENT '支払タイプ名称',
  `benefit_note` VARCHAR(140) NULL DEFAULT NULL COMMENT '保険金注記',
  `calc_base` CHAR(1) NULL DEFAULT NULL COMMENT '支払金額ベース',
  `compense_rate` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '保障割合',
  `benefit_base_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '基本給付額',
  `benefit_base_unit` CHAR(1) NULL DEFAULT NULL COMMENT '基本給付額単位',
  `disclaim_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '免責額・自己負担額',
  `disclaim_unit` CHAR(1) NULL DEFAULT NULL COMMENT '免責額・自己負担額単位',
  `payg_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額',
  `total_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算支払限度額',
  `after_over_limit` CHAR(1) NULL DEFAULT NULL COMMENT '支払限度超過後の契約状態',
  `disclaim_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '免責日数',
  `total_limit_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '通算限度日数・回数',
  `waiting_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '待機日数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_beneftis_tenants` (`tenant_id` ASC),
  INDEX `FK_benefits_sales_products_idx` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC),
  INDEX `benefits_sales_plan_idx` (`sales_plan_code` ASC, `sales_plan_type_code` ASC),
  CONSTRAINT `FK_benefits_sales_products`
    FOREIGN KEY (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    REFERENCES `sales_products` (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_beneftis_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金計算';


-- -----------------------------------------------------
-- Table `benefti_limits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `benefti_limits` ;

CREATE TABLE IF NOT EXISTS `benefti_limits` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '保険プラン',
  `sales_plan_type_code` VARCHAR(2) NOT NULL COMMENT '販売プラン種別コード',
  `benefit_group_code` CHAR(1) NULL DEFAULT NULL COMMENT '集約グループコード',
  `benefit_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険金タイプ',
  `payg_limit_amount` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額',
  `total_limit_amount` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '通算支払限度額',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_benefti_limits_tenants` (`tenant_id` ASC),
  INDEX `FK_benefti_limits_benefits_idx` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC),
  CONSTRAINT `FK_benefti_limits_benefits`
    FOREIGN KEY (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    REFERENCES `benefits` (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_benefti_limits_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金制限';


-- -----------------------------------------------------
-- Table `billing_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_details` ;

CREATE TABLE IF NOT EXISTS `billing_details` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `billing_period` VARCHAR(6) NULL DEFAULT NULL COMMENT '請求月',
  `payment_method_code` CHAR(1) NULL DEFAULT NULL COMMENT '払込方法コード',
  `billng_header_no` INT(7) UNSIGNED NULL DEFAULT NULL COMMENT '連番',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `premium_due_date` DATE NULL DEFAULT NULL COMMENT '保険料充当日',
  `premium_sequence_no` SMALLINT(3) UNSIGNED NOT NULL COMMENT '保険料連番',
  `due_date` VARCHAR(6) NULL DEFAULT NULL COMMENT '充当月',
  `bank_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '銀行コード',
  `bank_branch_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '支店コード',
  `bank_account_type` VARCHAR(1) NULL DEFAULT NULL COMMENT '口座種別',
  `bank_account_no` VARCHAR(7) NULL DEFAULT NULL COMMENT '口座番号',
  `token_no` VARCHAR(32) NULL DEFAULT NULL COMMENT 'カード番号(トークン)',
  `bank_result_code` CHAR(1) NULL DEFAULT NULL COMMENT '引き去り結果コード　銀行',
  `card_result_code` CHAR(1) NULL DEFAULT NULL COMMENT '引き去り結果コード　カード',
  `other_result_code` CHAR(1) NULL DEFAULT NULL COMMENT '引き去り結果コード　その他',
  `name_knj_sei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名（漢字）の姓/会社',
  `name_knj_mei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名（漢字）の名',
  `name_kana_sei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名（カナ）の姓/会社',
  `name_kana_mei` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名（カナ）の名',
  `premium_due_amount` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '保険料請求額',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_billing_details_tenants` (`tenant_id` ASC),
  INDEX `CAND_billing_details` (`tenant_id` ASC, `billng_header_no` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC),
  CONSTRAINT `FK_billing_details_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '請求詳細';


-- -----------------------------------------------------
-- Table `billing_headers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing_headers` ;

CREATE TABLE IF NOT EXISTS `billing_headers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `billing_period` VARCHAR(6) NULL DEFAULT NULL COMMENT '請求月',
  `payment_method_code` CHAR(1) NULL DEFAULT NULL COMMENT '払込方法コード',
  `billng_header_no` INT(7) UNSIGNED NULL DEFAULT NULL COMMENT '連番',
  `billing_header_status` CHAR(1) NULL DEFAULT NULL COMMENT '請求ヘッダー状態コード',
  `group_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '団体コード',
  `factoring_company_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '収納代行会社コード',
  `create_date` DATE NULL DEFAULT NULL COMMENT '作成日',
  `received_date` DATE NULL DEFAULT NULL COMMENT '受付日',
  `totall_billerd_amount` INT(15) UNSIGNED NULL DEFAULT NULL COMMENT '請求額',
  `total_received_amount` INT(15) UNSIGNED NULL DEFAULT NULL COMMENT '入金額',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_billing_headers_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_billing_headers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '請求';


-- -----------------------------------------------------
-- Table `calendars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendars` ;

CREATE TABLE IF NOT EXISTS `calendars` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `date` DATE NULL DEFAULT NULL COMMENT '日付',
  `holiday_flag` TINYINT(1) UNSIGNED NOT NULL COMMENT '休日フラグ',
  `description` VARCHAR(32) NULL DEFAULT NULL COMMENT 'メモ',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_calendars_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_calendars_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'カレンダー';


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `name` VARCHAR(32) NOT NULL COMMENT 'ユーザ名',
  `email` VARCHAR(128) NOT NULL COMMENT 'メールアドレス',
  `last_login_at` DATETIME NULL DEFAULT NULL COMMENT '最終ログイン日時',
  `active` CHAR(1) NULL DEFAULT '1' COMMENT 'Active/Inactive',
  `sub` VARCHAR(128) NULL DEFAULT NULL COMMENT 'UUID',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_users_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_users_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'ユーザ';


-- -----------------------------------------------------
-- Table `claim_headers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `claim_headers` ;

CREATE TABLE IF NOT EXISTS `claim_headers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `claim_trxs_id` INT(9) UNSIGNED NOT NULL COMMENT '保険金・給付金情報ID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `active_inactive` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `claim_date` DATE NOT NULL COMMENT '請求日',
  `received_date` DATE NOT NULL COMMENT '受付日',
  `claimant_category` VARCHAR(2) NULL DEFAULT NULL COMMENT '請求者区分',
  `claimant_sei_knj` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者） 姓',
  `claimant_mei_knj` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者） 名',
  `claimant_sei_kana` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者）セイ',
  `claimant_mei_kana` TEXT NULL DEFAULT NULL COMMENT '請求者（被保険者）メイ',
  `claimant_date_of_birth` DATE NULL DEFAULT NULL COMMENT '請求者生年月日',
  `claimant_address` TEXT NULL DEFAULT NULL COMMENT '請求者住所',
  `relationship` VARCHAR(2) NULL DEFAULT NULL COMMENT '請求者（被保険者）との続柄',
  `result_code` CHAR(1) NULL DEFAULT NULL COMMENT '請求者反社チェック結果コード',
  `parental_kanji` VARCHAR(64) NULL DEFAULT NULL COMMENT '親権者（被保険者）',
  `parental_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '親権者（被保険者）　カナ',
  `parental_relationship` VARCHAR(2) NULL DEFAULT NULL COMMENT '親権者（被保険者）との続柄',
  `tel_no` TEXT NULL DEFAULT NULL COMMENT '請求者電話番号',
  `contact_tel_no` TEXT NULL DEFAULT NULL COMMENT '請求者電話番号日中連絡先',
  `email` TEXT NULL DEFAULT NULL COMMENT '請求者メールアドレス',
  `accident_date` DATE NOT NULL COMMENT '請求事由発生日',
  `accident_place` VARCHAR(32) NULL DEFAULT NULL COMMENT '請求事由発生場所',
  `accident_info` VARCHAR(1024) NULL DEFAULT NULL COMMENT '請求事由内容',
  `bank_name` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関名',
  `bank_code` TEXT NOT NULL COMMENT '支払先金融機関コード',
  `bank_branch_name` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関支店名',
  `bank_branch_code` TEXT NOT NULL COMMENT '支払先金融機関支店コード',
  `bank_account_type` TEXT NOT NULL COMMENT '口座種別',
  `bank_account_no` TEXT NOT NULL COMMENT '口座番号',
  `bank_account_holder` TEXT NOT NULL COMMENT '口座名義人',
  `claim_total_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '請求総額',
  `benefit_total_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '支払対象総額',
  `number_of_paid` TINYINT(2) UNSIGNED NULL DEFAULT NULL COMMENT '既払回数',
  `paid_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '既払通算額',
  `over_total_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算限度超過総額',
  `amount_to_pay` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '支払決定額',
  `claim_status` CHAR(1) NULL DEFAULT '1' COMMENT '申請ステータス',
  `underwriting_status` CHAR(1) NULL DEFAULT '1' COMMENT '査定ステータス',
  `claim_status_date` DATE NULL DEFAULT NULL COMMENT '申請ステータス更新日',
  `underwriting_date` DATE NULL DEFAULT NULL COMMENT '査定ステータス更新日',
  `reception_comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '受付者コメント',
  `first_underwriter_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '1次査定者ID',
  `first_underwriting_date` DATE NULL DEFAULT NULL COMMENT '1次査定日',
  `first_underwriting_comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '1次査定コメント',
  `second_underwriter_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '2次査定者ID',
  `second_underwriting_date` DATE NULL DEFAULT NULL COMMENT '2次査定日',
  `second_underwriting_comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '2次査定コメント',
  `information` VARCHAR(1024) NULL DEFAULT NULL COMMENT '通信欄コメント',
  `unrated_reason` CHAR(1) NULL DEFAULT NULL COMMENT '自動判定不可理由 [0]-[9]',
  `inspection` CHAR(1) NULL DEFAULT NULL COMMENT '調査要否',
  `due_date` DATE NULL DEFAULT NULL COMMENT '支払予定日',
  `payment_date` DATE NULL DEFAULT NULL COMMENT '支払処理日',
  `setback_date` DATE NULL DEFAULT NULL COMMENT '組戻し処理日',
  `refund_premium` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未経過保険料',
  `receivable_premium` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未収保険料',
  `refund_premium_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未経過保険料調整額',
  `refund_premium_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT '未経過保険料調整額題目',
  `receivable_premium_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '未収保険料調整額',
  `receivable_premium_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT '未収保険料調整額題目',
  `custom_premium_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT 'その他保険料調整額',
  `custom_premium_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT 'その他保険料調整額題目',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_claim_headers_tenants` (`tenant_id` ASC),
  INDEX `FK_claim_headers_contracts_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  INDEX `CAND_claim_headers` (`tenant_id` ASC, `claim_trxs_id` ASC),
  INDEX `FK_claim_headers_1st_underwriter_idx` (`tenant_id` ASC, `first_underwriter_id` ASC),
  INDEX `FK_claim_headers_2nd_underwriter_idx` (`tenant_id` ASC, `second_underwriter_id` ASC),
  CONSTRAINT `FK_claim_headers_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_claim_headers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`),
  CONSTRAINT `FK_claim_headers_1st_underwriter`
    FOREIGN KEY (`tenant_id` , `first_underwriter_id`)
    REFERENCES `users` (`tenant_id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_claim_headers_2nd_underwriter`
    FOREIGN KEY (`tenant_id` , `second_underwriter_id`)
    REFERENCES `users` (`tenant_id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金・給付金請求情報';


-- -----------------------------------------------------
-- Table `claim_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `claim_details` ;

CREATE TABLE IF NOT EXISTS `claim_details` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'テナントID',
  `claim_trxs_id` INT(9) UNSIGNED NOT NULL COMMENT '保険金・給付金情報ID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障連番',
  `active_inactive` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `benefit_code` VARCHAR(2) NOT NULL COMMENT '保険金タイプ',
  `benefit_text` VARCHAR(20) NULL DEFAULT NULL COMMENT '保険金名称',
  `payment_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '支払タイプ',
  `payment_text` VARCHAR(20) NULL DEFAULT NULL COMMENT '支払タイプ名称',
  `daily_benefit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '給付日額',
  `claim_detail_info` VARCHAR(140) NULL DEFAULT NULL COMMENT '請求内容',
  `treatment_date_from` DATE NULL DEFAULT NULL COMMENT '請求対象期間(from)',
  `treatment_date_to` DATE NULL DEFAULT NULL COMMENT '請求対象期間(to)',
  `treatment_times` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '請求対象回数',
  `claim_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '請求日数',
  `claim_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '請求額',
  `noncoverage_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '保険対象外金額',
  `coverage_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '保険対象金額',
  `compense_rate` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '保障割合',
  `disclaim_amount` INT(9) NULL DEFAULT NULL COMMENT '免責額・自己負担額',
  `payg_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額',
  `total_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算支払限度額',
  `benefit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '支払対象額',
  `over_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算超過額',
  `others_paid_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '他社支払額',
  `amount_to_pay` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '支払決定額',
  `other_insuerer` JSON NULL DEFAULT NULL COMMENT '他保険',
  `custom_product_adjustment` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT 'その他商品調整額',
  `custom_product_adjustment_title` VARCHAR(63) NULL DEFAULT NULL COMMENT 'その他商品調整額題目',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_claim_details_tenants` (`tenant_id` ASC),
  INDEX `CAND_claim_details` (`tenant_id` ASC, `claim_trxs_id` ASC, `risk_sequence_no` ASC),
  CONSTRAINT `FK_claim_details_claim_header`
    FOREIGN KEY (`tenant_id` , `claim_trxs_id`)
    REFERENCES `claim_headers` (`tenant_id` , `claim_trxs_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_claim_details_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金・給付金請求詳細';


-- -----------------------------------------------------
-- Table `claim_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `claim_documents` ;

CREATE TABLE IF NOT EXISTS `claim_documents` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `claim_trxs_id` INT(9) UNSIGNED NOT NULL COMMENT '保険金・給付金情報ID',
  `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番',
  `document_title` VARCHAR(64) NULL DEFAULT NULL COMMENT 'タイトル',
  `document_url` VARCHAR(256) NULL DEFAULT NULL COMMENT 'URL',
  `upload_date` DATE NULL DEFAULT NULL COMMENT '登録日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_claim_documents_tenants` (`tenant_id` ASC),
  INDEX `FK_claim_documents_claim_header_idx` (`tenant_id` ASC, `claim_trxs_id` ASC),
  INDEX `CAND_claim_documents` (`tenant_id` ASC, `claim_trxs_id` ASC, `sequence_no` ASC),
  CONSTRAINT `FK_claim_documents_claim_header`
    FOREIGN KEY (`tenant_id` , `claim_trxs_id`)
    REFERENCES `claim_headers` (`tenant_id` , `claim_trxs_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_claim_documents_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金・給付金請求資料';


-- -----------------------------------------------------
-- Table `claim_trxs_id`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `claim_trxs_id` ;

CREATE TABLE IF NOT EXISTS `claim_trxs_id` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `claim_trxs_id` INT(9) NOT NULL DEFAULT '1' COMMENT '保険金・給付金情報ID',
  `update_count` INT(11) NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_claim_trxs_id_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_claim_trxs_id_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険金・給付金情報ID';


-- -----------------------------------------------------
-- Table `code_master`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `code_master` ;

CREATE TABLE IF NOT EXISTS `code_master` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `field` VARCHAR(50) NOT NULL COMMENT '区分Field',
  `tbl` VARCHAR(50) NOT NULL COMMENT '区分table',
  `code_value` VARCHAR(6) NOT NULL COMMENT '区分コード',
  `code_name` VARCHAR(255) NULL DEFAULT NULL COMMENT '区分名',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `code_master_field_tbl_index` (`field` ASC, `tbl` ASC),
  UNIQUE INDEX `CAND_code_master` (`field` ASC, `tbl` ASC, `code_value` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '区分マスタ';


-- -----------------------------------------------------
-- Table `commission_rates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commission_rates` ;

CREATE TABLE IF NOT EXISTS `commission_rates` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `sales_plan_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '販売プラン種別コード',
  `commission_class` CHAR(1) NULL DEFAULT NULL COMMENT '手数料クラス',
  `commission_mode` VARCHAR(2) NULL DEFAULT NULL COMMENT '手数料モード',
  `apply_date_from` DATE NULL DEFAULT NULL COMMENT '適用開始日',
  `apply_date_to` DATE NULL DEFAULT NULL COMMENT '適用終了日',
  `commission_rate_f` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '初年度手数料率',
  `commission_rate_s` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '次年度以降手数料率',
  `commission_term` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '手数料支払月数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_commission_rates_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_commission_rates_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '手数料率';


-- -----------------------------------------------------
-- Table `contract_commission_rates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contract_commission_rates` ;

CREATE TABLE IF NOT EXISTS `contract_commission_rates` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `sales_plan_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '販売プラン種別コード',
  `base_date` DATE NULL DEFAULT NULL COMMENT '手数料率基準日',
  `second_year_start` DATE NULL DEFAULT NULL COMMENT '次年度適用開始日',
  `agent_share_1` TINYINT(3) NULL DEFAULT NULL COMMENT '共同募集割合_主',
  `agency_code_1` VARCHAR(5) NULL DEFAULT NULL COMMENT '代理店コード_主',
  `commission_class_1` CHAR(1) NULL DEFAULT NULL COMMENT '手数料クラス_主',
  `commission_mode_1` VARCHAR(2) NULL DEFAULT NULL COMMENT '手数料モード_主',
  `commission_rate_f_1` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '初年度手数料率_主',
  `commission_rate_s_1` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '次年度以降手数料率_主',
  `commission_term_1` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '手数料支払月数_主',
  `agent_share_2` TINYINT(3) NULL DEFAULT NULL COMMENT '共同募集割合_従',
  `agency_code_2` VARCHAR(5) NULL DEFAULT NULL COMMENT '代理店コード_従',
  `commission_class_2` CHAR(1) NULL DEFAULT NULL COMMENT '手数料クラス_従',
  `commission_mode_2` VARCHAR(2) NULL DEFAULT NULL COMMENT '手数料モード_従',
  `commission_rate_f_2` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '初年度手数料率_従',
  `commission_rate_s_2` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '次年度以降手数料率_従',
  `commission_term_2` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '手数料支払月数_従',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_contract_commission_rates_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_contract_commission_rates_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '契約手数料率';


-- -----------------------------------------------------
-- Table `contract_commissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contract_commissions` ;

CREATE TABLE IF NOT EXISTS `contract_commissions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `process_date` DATE NOT NULL COMMENT '処理日',
  `commission_reason` CHAR(1) NOT NULL COMMENT '発生事由',
  `premium_due_date` DATE NOT NULL COMMENT '保険料充当日',
  `transaction_date` DATE NOT NULL COMMENT '取引日',
  `record_date` VARCHAR(6) NULL DEFAULT NULL COMMENT '手数料計上年月',
  `sales_plan_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '販売プラン種別コード',
  `frequency` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険料払込回数',
  `premium_amount` INT(8) NULL DEFAULT NULL COMMENT '保険料額',
  `shared_type` CHAR(1) NULL DEFAULT NULL COMMENT '共同募集区分',
  `agent_share` TINYINT(3) NULL DEFAULT NULL COMMENT '共同募集割合',
  `commission_rate` DECIMAL(3,3) NULL DEFAULT NULL COMMENT '手数料率',
  `commission_amount` INT(8) NULL DEFAULT NULL COMMENT '手数料額',
  `commission_tax` INT(8) NULL DEFAULT NULL COMMENT '手数料消費税額',
  `agency_code` VARCHAR(5) NOT NULL COMMENT '代理店コード',
  `agency_branch_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '代理店支店コード',
  `agent_code` VARCHAR(6) NOT NULL COMMENT '募集人コード',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_contract_commissions_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_contract_commissions_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '契約手数料履歴';


-- -----------------------------------------------------
-- Table `contract_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contract_log` ;

CREATE TABLE IF NOT EXISTS `contract_log` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '契約管理番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `sequence_no` SMALLINT(4) UNSIGNED NOT NULL COMMENT '連番',
  `log_type` CHAR(1) NULL DEFAULT '0' COMMENT 'ログタイプ',
  `message_code` VARCHAR(4) NULL DEFAULT NULL COMMENT 'エラーコード',
  `message_group` VARCHAR(5) NULL DEFAULT NULL COMMENT 'エラーグループ',
  `reason_group_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '事由種別（大分類）',
  `reason_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '事由ID',
  `contact_transaction_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '異動コード',
  `description` VARCHAR(1024) NULL DEFAULT NULL COMMENT '摘要',
  `program_name` VARCHAR(32) NULL DEFAULT NULL COMMENT '処理プログラム',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_contract_log_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_contract_log_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '契約ログ';


-- -----------------------------------------------------
-- Table `contract_no`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contract_no` ;

CREATE TABLE IF NOT EXISTS `contract_no` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NULL DEFAULT NULL COMMENT '証券番号',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_contract_no_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_contract_no_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '証券番号採番REC';


-- -----------------------------------------------------
-- Table `deposit_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deposit_details` ;

CREATE TABLE IF NOT EXISTS `deposit_details` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `entry_date` DATE NULL DEFAULT NULL COMMENT '入力日',
  `batch_no` INT(4) UNSIGNED NULL DEFAULT NULL COMMENT 'バッチナンバー',
  `cash_detail_no` INT(4) UNSIGNED NULL DEFAULT NULL COMMENT '明細番号',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `application_no` VARCHAR(20) NULL DEFAULT NULL COMMENT '申込番号',
  `due_date` VARCHAR(6) NULL DEFAULT NULL COMMENT '充当月',
  `total_premium_amount` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '合計保険料金額',
  `deposit_amount` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '入金金額',
  `commission_withheld` INT(4) UNSIGNED NULL DEFAULT NULL COMMENT '振込手数料',
  `compensation_tax` INT(4) UNSIGNED NULL DEFAULT NULL COMMENT '振込手数料 消費税',
  `clearing_date` DATE NULL DEFAULT NULL COMMENT '消し込み日',
  `suspence_date` DATE NULL DEFAULT NULL COMMENT 'サスペンス日',
  `delete_date` DATE NULL DEFAULT NULL COMMENT '削除日',
  `cash_matching_date` DATE NULL DEFAULT NULL COMMENT 'マッチング日',
  `cash_detail_status` CHAR(1) NULL DEFAULT NULL COMMENT '明細のステータス',
  `payment_result_code` CHAR(3) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT '引き去り結果コード',
  `comment` VARCHAR(40) NULL DEFAULT NULL COMMENT '備考',
  `premium_due_date` DATE NULL DEFAULT NULL COMMENT '保険料充当日',
  `premium_sequence_no` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '保険料連番',
  `access_id` VARCHAR(64) NULL DEFAULT NULL COMMENT '取引ID',
  `access_pass` VARCHAR(64) NULL DEFAULT NULL COMMENT '取引パスワード',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_deposit_details_tenants` (`tenant_id` ASC),
  INDEX `CAND_deposit_details` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `due_date` ASC),
  CONSTRAINT `FK_deposit_details_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '入金詳細';


-- -----------------------------------------------------
-- Table `deposit_headers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deposit_headers` ;

CREATE TABLE IF NOT EXISTS `deposit_headers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `entry_date` DATE NULL DEFAULT NULL COMMENT '入力日',
  `batch_no` INT(4) UNSIGNED NULL DEFAULT NULL COMMENT 'バッチナンバー',
  `payment_method_code` CHAR(1) NULL DEFAULT NULL COMMENT '払込方法コード',
  `deposit_date` DATE NULL DEFAULT NULL COMMENT '入金日',
  `received_amount` VARCHAR(10) NULL DEFAULT NULL COMMENT '入金金額',
  `batch_total_amount` VARCHAR(10) NULL DEFAULT NULL COMMENT 'バッチ合計金額',
  `batch_status` CHAR(1) NULL DEFAULT NULL COMMENT 'ステータス',
  `comment` VARCHAR(40) NULL DEFAULT NULL COMMENT '備考',
  `usere_id` VARCHAR(8) NULL DEFAULT NULL COMMENT '処理ユーザーID',
  `collection_route` CHAR(1) NULL DEFAULT NULL COMMENT '収集ルート',
  `group_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '団体コード',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_deposit_headers_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_deposit_headers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '入金';


-- -----------------------------------------------------
-- Table `error_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `error_message` ;

CREATE TABLE IF NOT EXISTS `error_message` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `message_code` VARCHAR(4) NULL DEFAULT NULL COMMENT 'エラーコード',
  `message_group` VARCHAR(5) NULL DEFAULT NULL COMMENT 'エラーグループ',
  `message_group_desc` VARCHAR(6) NULL DEFAULT NULL COMMENT 'エラーグループ名(団体保持者)',
  `message_severity` VARCHAR(3) NULL DEFAULT NULL COMMENT '重大度',
  `message_outine` VARCHAR(30) NULL DEFAULT NULL COMMENT '適用(概要）',
  `message_desplption` VARCHAR(128) NULL DEFAULT NULL COMMENT '摘要(日本語）',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_error_message_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_error_message_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'Error Message';


-- -----------------------------------------------------
-- Table `factoring_companies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `factoring_companies` ;

CREATE TABLE IF NOT EXISTS `factoring_companies` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `factoring_company_code` VARCHAR(6) NOT NULL COMMENT '収納代行会社コード',
  `factoring_company_name` VARCHAR(64) NULL DEFAULT NULL COMMENT '収納代行会社名',
  `payment_method` CHAR(1) NULL DEFAULT NULL COMMENT '払込経路',
  `factoring_company_start_date` DATE NOT NULL COMMENT '開始日',
  `factoring_company_end_date` DATE NOT NULL COMMENT '終了日',
  `billing_month` INT(2) NOT NULL COMMENT '請求月',
  `billing_day_unit` VARCHAR(2) NOT NULL COMMENT '請求日単位',
  `billing_day` VARCHAR(2) NOT NULL COMMENT '請求日',
  `direct_debit_day` VARCHAR(2) NULL DEFAULT NULL COMMENT '振替日',
  `site_id` VARCHAR(13) NULL DEFAULT NULL COMMENT 'サイトID',
  `site_pass` VARCHAR(10) NULL DEFAULT NULL COMMENT 'サイトパスワード',
  `shop_id` VARCHAR(13) NULL DEFAULT NULL COMMENT 'ショップID',
  `shop_pass` VARCHAR(8) NULL DEFAULT NULL COMMENT 'ショップパスワード',
  `td_tenant_name` VARCHAR(25) NULL DEFAULT NULL COMMENT '3Dセキュア表示店舗名',
  `passbook_entry` VARCHAR(15) NULL DEFAULT NULL COMMENT '通帳記載内容',
  `bank_count` VARCHAR(2) NULL DEFAULT NULL COMMENT '口振請求データ連番',
  `bucket_name` VARCHAR(256) NULL DEFAULT NULL COMMENT '口振売上結果データ格納先',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_factoring_companies_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_factoring_companies_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '収納代行会社マスタ';


-- -----------------------------------------------------
-- Table `frequencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frequencies` ;

CREATE TABLE IF NOT EXISTS `frequencies` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番',
  `start_date` DATE NULL DEFAULT NULL COMMENT '保険料払込開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '保険料払込終了日',
  `frequency` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険料払込回数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_frequencies_tenants` (`tenant_id` ASC),
  INDEX `CAND_frequencies` (`tenant_id` ASC, `contract_no` ASC, `sequence_no` ASC),
  CONSTRAINT `FK_frequencies_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '払込回数';


-- -----------------------------------------------------
-- Table `grace_period_infomation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grace_period_infomation` ;

CREATE TABLE IF NOT EXISTS `grace_period_infomation` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `grace_period_code` CHAR(1) NOT NULL COMMENT '猶予期間区分',
  `grace_period_term` TINYINT(2) UNSIGNED NOT NULL COMMENT '猶予期間',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_grace_period_infomation_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_grace_period_infomation_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '猶予期間満了日情報';


-- -----------------------------------------------------
-- Table `insurance_company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `insurance_company` ;

CREATE TABLE IF NOT EXISTS `insurance_company` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `insurer_code_seq` VARCHAR(12) NULL DEFAULT NULL COMMENT '保険会社情報コード連番',
  `insurer_inception_date` DATE NULL DEFAULT NULL COMMENT '保険会社情報コード開始日',
  `insurer_termination_date` DATE NULL DEFAULT NULL COMMENT '保険会社情報コード終了日',
  `transfer_requester_code` VARCHAR(10) NOT NULL COMMENT '保険金支払用 振込依頼人コード',
  `transfer_requester_name` VARCHAR(40) NULL DEFAULT NULL COMMENT '保険金支払用 振込依頼人',
  `bank_code` VARCHAR(4) NOT NULL COMMENT '保険金支払用 金融機関コード',
  `bank_name` VARCHAR(15) NULL DEFAULT NULL COMMENT '保険金支払用 金融機関名',
  `bank_branch_code` VARCHAR(3) NOT NULL COMMENT '保険金支払用 支店コード',
  `bank_branch_name` VARCHAR(15) NULL DEFAULT NULL COMMENT '保険金支払用 支店名',
  `bank_account_type` CHAR(1) NOT NULL COMMENT '保険金支払用 預金種目',
  `bank_account_no` VARCHAR(7) NOT NULL COMMENT '保険金支払用 口座番号',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_insurance_company_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_insurance_company_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険会社情報';


-- -----------------------------------------------------
-- Table `maintenance_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_requests` ;

CREATE TABLE IF NOT EXISTS `maintenance_requests` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `active_inactive` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `transaction_code` VARCHAR(2) NOT NULL COMMENT '保全申請分類',
  `request_status` CHAR(1) NOT NULL COMMENT '保全申請ステータス',
  `application_date` DATE NULL DEFAULT NULL COMMENT '申込日',
  `application_time` TIME NULL DEFAULT NULL COMMENT '申込時刻',
  `application_method` CHAR(1) NULL DEFAULT NULL COMMENT '申込経路',
  `received_date` DATE NULL DEFAULT NULL COMMENT '受付日',
  `received_at` CHAR(1) NULL DEFAULT NULL COMMENT '受付場所',
  `comment_underweiter1` VARCHAR(1024) NULL DEFAULT NULL COMMENT '一次査定コメント',
  `first_assessment_results` CHAR(2) NULL DEFAULT NULL COMMENT '一次査定結果',
  `comment_underweiter2` VARCHAR(1024) NULL DEFAULT NULL COMMENT '二次査定コメント',
  `second_assessment_results` CHAR(2) NULL DEFAULT NULL COMMENT '二次査定結果',
  `communication_column` VARCHAR(1024) NULL DEFAULT NULL COMMENT '通信欄',
  `apply_date` DATE NULL DEFAULT NULL COMMENT '適用日',
  `notification_datetime` DATETIME NULL DEFAULT NULL COMMENT '完了通知送信日時',
  `entry_type` CHAR(1) NOT NULL COMMENT '処理起票区分',
  `payment_method_code` CHAR(1) NULL DEFAULT NULL COMMENT '払込方法コード',
  `factoring_company_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '収納代行会社コード',
  `bank_code` TEXT NULL DEFAULT NULL COMMENT '銀行コード',
  `bank_branch_code` TEXT NULL DEFAULT NULL COMMENT '支店コード',
  `bank_account_type` TEXT NULL DEFAULT NULL COMMENT '口座種別',
  `bank_account_no` TEXT NULL DEFAULT NULL COMMENT '口座番号',
  `bank_account_name` TEXT NULL DEFAULT NULL COMMENT '口座名義人',
  `token_no` VARCHAR(32) NULL DEFAULT NULL COMMENT 'カード番号(トークン)',
  `email_for_notification` VARCHAR(128) NULL DEFAULT NULL COMMENT '通知用メールアドレス',
  `termination_base_date` DATE NULL DEFAULT NULL COMMENT '消滅基準日',
  `termination_title` VARCHAR(255) NULL DEFAULT NULL COMMENT '消滅事由',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_contracts_idx` (`tenant_id` ASC, `contract_branch_no` ASC, `contract_no` ASC),
  INDEX `CAND_maintenance_requests` (`tenant_id` ASC, `request_no` ASC),
  INDEX `FK_maintenance_requests_contracts` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  CONSTRAINT `FK_maintenance_requests_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請';


-- -----------------------------------------------------
-- Table `maintenance_requests_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_requests_customer` ;

CREATE TABLE IF NOT EXISTS `maintenance_requests_customer` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `sequence_no` TINYINT(2) NOT NULL COMMENT '保全申請顧客連番',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '顧客ID',
  `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分',
  `role` VARCHAR(2) NOT NULL COMMENT 'ロール',
  `beneficiary_code` VARCHAR(12) NULL DEFAULT NULL COMMENT '受取人ID',
  `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '氏名（漢字）_姓　(※会社名）',
  `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '氏名（漢字）_名',
  `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名（カナ）_姓　（※会社名）',
  `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名（カナ）_名',
  `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別',
  `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日',
  `postal_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号',
  `address_pref` TEXT NULL DEFAULT NULL COMMENT '住所（都道府県）',
  `address_1` TEXT NULL DEFAULT NULL COMMENT '住所（番地まで）',
  `address_2` TEXT NULL DEFAULT NULL COMMENT '住所（ビル名　部屋番号）',
  `address_pref_kana` TEXT NULL DEFAULT NULL COMMENT '住所（都道府県）カナ',
  `address_1_kana` TEXT NULL DEFAULT NULL COMMENT '住所（番地まで）カナ',
  `address_2_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '住所（ビル名　部屋番号）カナ',
  `tel_fix` TEXT NULL DEFAULT NULL COMMENT '電話番号（固定）',
  `tel_mobile` TEXT NULL DEFAULT NULL COMMENT '電話番号（携帯）',
  `email` VARCHAR(128) NULL DEFAULT NULL COMMENT 'メールアドレス',
  `occupation` VARCHAR(32) NULL DEFAULT NULL COMMENT '職業',
  `occupation_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '職業コード',
  `antisocial_forces_check` CHAR(1) NULL DEFAULT NULL COMMENT '反社チェック',
  `guardian_flag` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等の有無',
  `guardian_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の氏名（漢字）_姓',
  `guardian_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の氏名（漢字）_名',
  `guardian_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の名前（カナ）_姓',
  `guardian_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の名前（カナ）_名',
  `guardian_sex` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等　性別',
  `guardian_date_of_birth` DATE NULL DEFAULT NULL COMMENT '成年後見人等　生年月日',
  `guardian_type` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等との区分',
  `guardian_postal_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '成年後見人等の郵便番号',
  `guardian_address_pref` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の住所（都道府県）',
  `guardian_address_1` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の住所（番地まで）',
  `guardian_address_2` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の住所（ビル名　部屋番号まで）',
  `guardian_tel_fix` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の電話番号（固定）',
  `guardian_tel_mobile` TEXT NULL DEFAULT NULL COMMENT '成年後見人等の電話番号（携帯）',
  `notification_flag` CHAR(1) NULL DEFAULT NULL COMMENT '定期通知受取の可否',
  `relationship` VARCHAR(2) NULL DEFAULT NULL COMMENT '契約者からみた続柄',
  `share` INT(3) UNSIGNED NULL DEFAULT NULL COMMENT '受取の割合',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_customer_maintenance_requests_idx` (`tenant_id` ASC, `request_no` ASC),
  UNIQUE INDEX `CAND_maintenance_requests_customer` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC),
  UNIQUE INDEX `UNIQ_maintenance_requests_customer_role` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC, `role` ASC),
  CONSTRAINT `FK_maintenance_requests_customer_maintenance_requests`
    FOREIGN KEY (`tenant_id` , `request_no`)
    REFERENCES `maintenance_requests` (`tenant_id` , `request_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_customer_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請顧客';


-- -----------------------------------------------------
-- Table `new_business_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new_business_documents` ;

CREATE TABLE IF NOT EXISTS `new_business_documents` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番',
  `document_title` VARCHAR(64) NOT NULL COMMENT 'タイトル',
  `document_url` VARCHAR(256) NOT NULL COMMENT 'URL',
  `upload_date` DATE NOT NULL COMMENT '登録日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_new_business_documents_tenants` (`tenant_id` ASC),
  INDEX `CAND_new_business_documents` (`tenant_id` ASC, `contract_no` ASC, `sequence_no` ASC),
  CONSTRAINT `FK_new_business_documents_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`),
  CONSTRAINT `FK_new_business_documents_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '新契約ドキュメント';


-- -----------------------------------------------------
-- Table `notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `notifications` ;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `notification_date` DATE NULL DEFAULT NULL COMMENT '通知予定日',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `template_number` VARCHAR(6) NULL DEFAULT NULL COMMENT 'テンプレートナンバー',
  `notification_implementation` CHAR(1) NULL DEFAULT '0' COMMENT '通知実施',
  `comment` VARCHAR(1024) NULL DEFAULT NULL COMMENT '通信欄コメント',
  `sendee` TEXT NULL DEFAULT NULL COMMENT '通知対象者',
  `notification_method` VARCHAR(2) NULL DEFAULT NULL COMMENT '通知方法',
  `email` TEXT NULL DEFAULT NULL COMMENT '通知対象・Eメールアドレス',
  `error_flag` CHAR(1) NULL DEFAULT NULL COMMENT 'エラーフラグ',
  `data` JSON NULL DEFAULT NULL COMMENT '埋込変数データ',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_notifications_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_notifications_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '通知内容';


-- -----------------------------------------------------
-- Table `policy_holders_pay_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `policy_holders_pay_method` ;

CREATE TABLE IF NOT EXISTS `policy_holders_pay_method` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `payment_method` CHAR(1) NULL DEFAULT NULL COMMENT '支払方法',
  `status` CHAR(1) NULL DEFAULT NULL COMMENT 'ステータス',
  `department_code` VARCHAR(10) NULL DEFAULT NULL COMMENT '部署コード',
  `customer_no` VARCHAR(20) NULL DEFAULT NULL COMMENT '社員番号',
  `factoring_company_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '収納代行会社コード',
  `bank_code` TEXT NULL DEFAULT NULL COMMENT '銀行コード',
  `bank_branch_code` TEXT NULL DEFAULT NULL COMMENT '支店コード',
  `bank_account_type` TEXT NULL DEFAULT NULL COMMENT '口座種別',
  `bank_account_no` TEXT NULL DEFAULT NULL COMMENT '口座番号',
  `token_no` VARCHAR(32) NULL DEFAULT NULL COMMENT 'カード番号(トークン)',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_policy_holders_pay_method_tenants` (`tenant_id` ASC),
  INDEX `FK_policy_holders_pay_method_contracts_idx` (`tenant_id` ASC, `contract_no` ASC),
  CONSTRAINT `FK_policy_holders_pay_method_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_policy_holders_pay_method_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '契約者払込方法';


-- -----------------------------------------------------
-- Table `premium_for_billing_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premium_for_billing_history` ;

CREATE TABLE IF NOT EXISTS `premium_for_billing_history` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) CHARACTER SET 'utf8' NOT NULL COMMENT '証券番号枝番',
  `start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `premium_for_billing` INT(8) NULL DEFAULT NULL COMMENT '請求用保険料',
  `sales_plan_code` VARCHAR(3) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT '販売プラン種別コード',
  `status` CHAR(1) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'ステータス',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_premium_for_billing_history_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_premium_for_billing_history_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '請求用保険料テーブル';


-- -----------------------------------------------------
-- Table `premium_headers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premium_headers` ;

CREATE TABLE IF NOT EXISTS `premium_headers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `premium_due_date` DATE NULL DEFAULT NULL COMMENT '保険料充当日',
  `first_premium` CHAR(1) NULL DEFAULT '0' COMMENT '初回保険料',
  `premium_sequence_no` SMALLINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '保険料連番',
  `premium_billing_period` VARCHAR(6) NULL DEFAULT NULL COMMENT '保険料収納月',
  `effective_date` DATE NULL DEFAULT NULL COMMENT '異動日',
  `total_gross_premium` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'グロス保険料',
  `premium_status` CHAR(1) NULL DEFAULT NULL COMMENT 'ステータス',
  `frequency` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険料払込回数',
  `refunded_date` DATE NULL DEFAULT NULL COMMENT '返金日',
  `canceled_date` DATE NULL DEFAULT NULL COMMENT '取消日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_premium_headers_tenants_idx` (`tenant_id` ASC),
  INDEX `CAND_premium_headers` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `premium_sequence_no` ASC),
  CONSTRAINT `FK_premium_headers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保険料';


-- -----------------------------------------------------
-- Table `refund_amount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refund_amount` ;

CREATE TABLE IF NOT EXISTS `refund_amount` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `active_inactive` CHAR(1) NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `pay_reason` CHAR(1) NULL DEFAULT NULL COMMENT '支払事由',
  `pay_method` CHAR(1) NULL DEFAULT NULL COMMENT '支払先',
  `bank_name` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関名',
  `bank_code` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関コード',
  `bank_branch_name` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関支店名',
  `bank_branch_code` TEXT NULL DEFAULT NULL COMMENT '支払先金融機関支店コード',
  `bank_account_type` TEXT NULL DEFAULT NULL COMMENT '口座種別',
  `bank_account_no` TEXT NULL DEFAULT NULL COMMENT '口座番号',
  `bank_account_holder` TEXT NULL DEFAULT NULL COMMENT '口座名義人',
  `partner_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '提携先コード',
  `pay_customer_code` VARCHAR(20) NULL DEFAULT NULL COMMENT 'お客様番号',
  `confirm_no` VARCHAR(4) NULL DEFAULT NULL COMMENT '確認番号',
  `inquiry_no` VARCHAR(32) NULL DEFAULT NULL COMMENT '問い合わせ番号',
  `other_code` INT(32) NULL DEFAULT NULL COMMENT 'その他番号',
  `cash_value` INT(9) NULL DEFAULT NULL COMMENT '解約払戻金額',
  `refund_amount` INT(9) NULL DEFAULT NULL COMMENT '保険料返金額',
  `surrender_charge` INT(9) NULL DEFAULT NULL COMMENT '解約手数料',
  `tax_amount` INT(9) NULL DEFAULT NULL COMMENT '税額',
  `total_refund_amount` INT(11) NULL DEFAULT NULL COMMENT '支払対象総額',
  `due_date` DATE NULL DEFAULT NULL COMMENT '支払予定日',
  `payment_date` DATE NULL DEFAULT NULL COMMENT '支払処理日',
  `setback_date` DATE NULL DEFAULT NULL COMMENT '組戻し処理日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_refund_amount_tenants` (`tenant_id` ASC),
  INDEX `CAND_refund_amount` (`tenant_id` ASC, `request_no` ASC),
  UNIQUE INDEX `UNIQ_refund_amount` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `request_no` ASC),
  CONSTRAINT `FK_refund_amount_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '払戻金';


-- -----------------------------------------------------
-- Table `renewal_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `renewal_info` ;

CREATE TABLE IF NOT EXISTS `renewal_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '更新前証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '更新前証券番号枝番',
  `renewal_contract_no` VARCHAR(10) NULL DEFAULT NULL COMMENT '更新後証券番号',
  `renewal_contract_branch_no` VARCHAR(2) NULL DEFAULT NULL COMMENT '更新後証券番号枝番',
  `renewal_judge_date` DATE NULL DEFAULT NULL COMMENT '更新判定日',
  `renewal_status` VARCHAR(2) NULL DEFAULT NULL COMMENT '更新ステータス',
  `renewal_antisocial_forces_check` CHAR(1) NULL DEFAULT NULL COMMENT '反社チェック',
  `renewal_date` DATE NULL DEFAULT NULL COMMENT '更新日',
  `renewal_expiration_date` DATE NULL DEFAULT NULL COMMENT '更新後満期日',
  `sales_plan_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '販売プラン種別コード',
  `number_of_sales_plan` TINYINT(2) NULL DEFAULT NULL COMMENT '販売プラン口数',
  `coverage_year` TINYINT(2) NULL DEFAULT NULL COMMENT '保険期間',
  `renewal_age` TINYINT(2) NULL DEFAULT NULL COMMENT '更新後年齢',
  `premium_amount` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '１回分保険料(現行)',
  `renewal_premium_amount` INT(8) UNSIGNED NULL DEFAULT NULL COMMENT '１回分保険料(更新後)',
  `renewal_type` CHAR(1) NULL DEFAULT NULL COMMENT '更新タイプ',
  `application_datetime` DATETIME NULL DEFAULT NULL COMMENT '申込日時',
  `application_method` CHAR(1) NULL DEFAULT NULL COMMENT '申込経路',
  `renewal_rejection` CHAR(1) NULL DEFAULT NULL COMMENT '更新有無',
  `renewal_notification_date_1` DATETIME NULL DEFAULT NULL COMMENT '更新案内送信日時_1',
  `renewal_notification_date_2` DATETIME NULL DEFAULT NULL COMMENT '更新案内送信日時_2',
  `renewal_notification_date_3` DATETIME NULL DEFAULT NULL COMMENT '更新案内送信日時_3（最終）',
  `apply_info_datetime` DATETIME NULL DEFAULT NULL COMMENT '更新通知送信日時',
  `apply_date` DATE NULL DEFAULT NULL COMMENT '更新適用日',
  `complete_info_datetime` DATETIME NULL DEFAULT NULL COMMENT '適用完了通知送信日時',
  `change_payment_method_yn` CHAR(1) NULL DEFAULT NULL COMMENT '払込経路変更',
  `renewal_payment_method_code` CHAR(1) NULL DEFAULT NULL COMMENT '更新後払込経路コード',
  `renewal_factoring_company_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '更新後収納代行会社コード',
  `renewal_change_frequency_yn` CHAR(1) NULL DEFAULT NULL COMMENT '払込回数変更',
  `renewal_frequency` VARCHAR(2) NULL DEFAULT NULL COMMENT '更新後保険料払込回数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_renewal_info_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_renewal_info_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '更新用トランザクション';


-- -----------------------------------------------------
-- Table `insured_objects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `insured_objects` ;

CREATE TABLE IF NOT EXISTS `insured_objects` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '連番',
  `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番',
  `diseas_history_yn` CHAR(1) NULL DEFAULT NULL COMMENT '罹患歴',
  `cancer_history_yn` CHAR(1) NULL DEFAULT NULL COMMENT 'がん罹患歴',
  `specified_disease` CHAR(1) NULL DEFAULT NULL COMMENT '特定疾病不担保同意区分',
  `substandard_type` CHAR(1) NULL DEFAULT NULL COMMENT '特別条件タイプ',
  `risk_target_url` VARCHAR(255) NULL DEFAULT NULL COMMENT '保障対象の画像URL',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_insured_objects_tenants` (`tenant_id` ASC),
  INDEX `FK_insured_objects_contracts_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  INDEX `CAND_insured_objects` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `sequence_no` ASC),
  CONSTRAINT `FK_insured_objects_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_insured_objects_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保障内容詳細';


-- -----------------------------------------------------
-- Table `risk_headers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `risk_headers` ;

CREATE TABLE IF NOT EXISTS `risk_headers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番',
  `active_inactive` CHAR(1) NULL DEFAULT 'A' COMMENT '有効/無効フラグ',
  `risk_start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `risk_end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `coverage_type` CHAR(1) NULL DEFAULT '1' COMMENT '保険期間のタイプ',
  `coverage_term` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険期間（年数・歳）',
  `product_status` VARCHAR(2) NULL DEFAULT NULL COMMENT '契約のステータス',
  `rider_attached_date` DATE NULL DEFAULT NULL COMMENT '特約付加日',
  `rider_inforce_date` DATE NULL DEFAULT NULL COMMENT '特約有効日',
  `substandard_type` CHAR(1) NULL DEFAULT NULL COMMENT '特別条件タイプ',
  `substandard_agreement_date` VARCHAR(16) NULL DEFAULT NULL COMMENT '特別条件了承日',
  `coverage_end_date` DATE NULL DEFAULT NULL COMMENT '保証期間終了日',
  `issue_age` TINYINT(2) NULL DEFAULT NULL COMMENT '被保険者　契約年齢',
  `reinsurance_type` CHAR(1) NULL DEFAULT NULL COMMENT '再保険タイプ',
  `reinsurance_company_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '再保険会社コード',
  `benefit_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険金タイプ',
  `benefit_text` VARCHAR(20) NULL DEFAULT NULL COMMENT '保険金名称',
  `payment_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '支払タイプ',
  `payment_text` VARCHAR(20) NULL DEFAULT NULL COMMENT '支払タイプ名称',
  `other_insurance_yn` CHAR(1) NULL DEFAULT NULL COMMENT '他保険有無',
  `termination_base_date` DATE NULL DEFAULT NULL COMMENT '保障消滅基準日',
  `termination_date` DATE NULL DEFAULT NULL COMMENT '保障消滅日',
  `termination_title` VARCHAR(255) NULL DEFAULT NULL COMMENT '保障消滅事由',
  `calc_base` CHAR(1) NULL DEFAULT NULL COMMENT '支払金額ベース',
  `compense_rate` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `benefit_base_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '基本給付額',
  `benefit_base_unit` CHAR(1) NULL DEFAULT NULL COMMENT '基本給付額単位',
  `disclaim_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '免責額・自己負担額',
  `disclaim_unit` CHAR(1) NULL DEFAULT NULL COMMENT '免責額・自己負担額単位',
  `payg_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '都度支払限度額',
  `total_limit_amount` INT(9) UNSIGNED NULL DEFAULT NULL COMMENT '通算支払限度額',
  `after_over_limit` CHAR(1) NULL DEFAULT NULL COMMENT '支払限度超過後の契約状態	',
  `disclaim_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '免責日数',
  `total_limit_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '通算限度日数・回数',
  `waiting_days` TINYINT(3) UNSIGNED NULL DEFAULT NULL COMMENT '待機日数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_risk_headers_tenants` (`tenant_id` ASC),
  INDEX `FK_risk_headers_contracts_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  INDEX `CAND_risk_headers` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `risk_sequence_no` ASC),
  CONSTRAINT `FK_risk_headers_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_risk_headers_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保障内容';


-- -----------------------------------------------------
-- Table `role_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role_users` ;

CREATE TABLE IF NOT EXISTS `role_users` (
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `role_id` VARCHAR(8) NOT NULL COMMENT 'ロールID',
  `user_id` INT(10) UNSIGNED NOT NULL COMMENT 'ユーザID',
  `avaliable_date` DATE NULL DEFAULT NULL COMMENT '利用可能開始',
  `unavaliable_date` DATE NULL DEFAULT NULL COMMENT '利用可能期限',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`tenant_id`, `role_id`, `user_id`),
  INDEX `FK_role_users_tenants` (`tenant_id` ASC),
  INDEX `FK_role_users_users_idx` (`tenant_id` ASC, `user_id` ASC),
  CONSTRAINT `FK_role_users_roles`
    FOREIGN KEY (`tenant_id` , `role_id`)
    REFERENCES `roles` (`tenant_id` , `role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_role_users_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`),
  CONSTRAINT `FK_role_users_users`
    FOREIGN KEY (`tenant_id` , `user_id`)
    REFERENCES `users` (`tenant_id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'ロール、ユーザー、紐付けテーブル';


-- -----------------------------------------------------
-- Table `sales_agents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sales_agents` ;

CREATE TABLE IF NOT EXISTS `sales_agents` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `agent_code` VARCHAR(6) NULL DEFAULT NULL COMMENT '募集人コード',
  `agency_code` VARCHAR(5) NULL DEFAULT NULL COMMENT '所属代理店コード',
  `offcial_agent_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '協会登録募集人コード',
  `agency_branch_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '所属支店コード',
  `agent_name_knj` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名',
  `agent_name_kana` VARCHAR(64) NULL DEFAULT NULL COMMENT '氏名（カナ）',
  `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日',
  `officiial_agency_code` VARCHAR(20) NULL DEFAULT NULL,
  `licensey_expire_date` DATE NULL DEFAULT NULL COMMENT '資格有効期限',
  `start_date` DATE NULL DEFAULT NULL COMMENT '募集開始日',
  `training_date` DATE NULL DEFAULT NULL COMMENT '研修受講日',
  `registration_date` DATE NULL DEFAULT NULL COMMENT '募集人登録日',
  `termination_date` DATE NULL DEFAULT NULL COMMENT '廃業日',
  `agent_status` INT(11) NULL DEFAULT NULL COMMENT '募集人ステータス',
  `memo` TEXT NULL DEFAULT NULL COMMENT 'メモ',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_sales_agents_tenants` (`tenant_id` ASC),
  CONSTRAINT `FK_sales_agents_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '募集人';


-- -----------------------------------------------------
-- Table `sales_premiums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sales_premiums` ;

CREATE TABLE IF NOT EXISTS `sales_premiums` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `sales_plan_code` VARCHAR(3) NOT NULL COMMENT '販売プランコード',
  `sales_plan_type_code` VARCHAR(2) NULL COMMENT '販売プラン種別コード',
  `start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `end_date` DATE NULL DEFAULT NULL COMMENT '終了日',
  `age_from` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT '年齢下限',
  `age_to` INT(2) UNSIGNED NULL DEFAULT NULL COMMENT '年齢上限',
  `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別',
  `premium` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '保険料',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_sales_premiums_tenants` (`tenant_id` ASC),
  INDEX `CAND_sales_premiums` (`tenant_id` ASC, `sales_plan_code` ASC, `sales_plan_type_code` ASC),
  CONSTRAINT `FK_sales_premiums_sales_products`
    FOREIGN KEY (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    REFERENCES `sales_products` (`tenant_id` , `sales_plan_code` , `sales_plan_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_sales_premiums_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '販売保険料';


-- -----------------------------------------------------
-- Table `service_templates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `service_templates` ;

CREATE TABLE IF NOT EXISTS `service_templates` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_group_type` CHAR(2) NULL DEFAULT NULL COMMENT '業務グループ種別',
  `source_key` VARCHAR(63) NOT NULL COMMENT 'ソースキー',
  `source_type` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ソース種別',
  `inherent_json` JSON NULL DEFAULT NULL COMMENT '固有JSONデータ',
  `inherent_text` TEXT NULL DEFAULT NULL COMMENT '固有TEXTデータ',
  `description` TEXT NULL DEFAULT NULL COMMENT '概要',
  `status` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ステータス',
  `version` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'バージョン',
  `priority` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '優先順位',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  INDEX `CAND_service_templates` (`source_key` ASC, `source_type` ASC, `version` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'サービステンプレート';


-- -----------------------------------------------------
-- Table `service_instances`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `service_instances` ;

CREATE TABLE IF NOT EXISTS `service_instances` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `template_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'テンプレートID',
  `business_group_type` CHAR(2) NULL DEFAULT NULL COMMENT '業務グループ種別',
  `source_key` VARCHAR(63) NOT NULL COMMENT 'ソースキー',
  `source_type` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ソース種別',
  `inherent_json` JSON NULL DEFAULT NULL COMMENT '固有JSONデータ',
  `inherent_text` TEXT NULL DEFAULT NULL COMMENT '固有TEXTデータ',
  `description` TEXT NULL DEFAULT NULL COMMENT '概要',
  `status` CHAR(1) NOT NULL DEFAULT '0' COMMENT 'ステータス',
  `version` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'バージョン',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  INDEX `FK_service_instances_tenants` (`tenant_id` ASC),
  INDEX `FK_service_instances_service_templates_idx` (`template_id` ASC),
  CONSTRAINT `FK_service_instances_service_templates`
    FOREIGN KEY (`template_id`)
    REFERENCES `service_templates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_instances_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'サービスインスタンス';


-- -----------------------------------------------------
-- Table `service_objects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `service_objects` ;

CREATE TABLE IF NOT EXISTS `service_objects` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '証券番号枝番',
  `data` JSON NULL DEFAULT NULL COMMENT '固有データ',
  `description` TEXT NULL DEFAULT NULL COMMENT '概要',
  `level` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '階層',
  `version` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'バージョン',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  PRIMARY KEY (`id`),
  INDEX `FK_service_objects_tenants` (`tenant_id` ASC),
  INDEX `FK_service_objects_contracts_idx` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC),
  CONSTRAINT `FK_service_objects_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_objects_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = 'サービスオブジェクト';


-- -----------------------------------------------------
-- Table `substandards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `substandards` ;

CREATE TABLE IF NOT EXISTS `substandards` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` VARCHAR(2) NOT NULL COMMENT '連番',
  `insured_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障対象連番',
  `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '特別条件連番',
  `product_type` VARCHAR(2) NULL DEFAULT NULL COMMENT '商品タイプ',
  `policy_code` VARCHAR(2) NULL DEFAULT NULL COMMENT '保険種別コード',
  `substandard_type` CHAR(1) NULL DEFAULT NULL COMMENT '特別条件タイプ',
  `disease_code` VARCHAR(3) NULL DEFAULT NULL COMMENT '不担保部位/特定疾病不担保コード',
  `exclusion_start_date` DATE NULL DEFAULT NULL COMMENT '開始日',
  `exculusion_term` TINYINT(2) NULL DEFAULT NULL COMMENT '不担保期間',
  `exclusion_expire_date` DATE NULL DEFAULT NULL COMMENT '不担保満了日',
  `active_inactive` CHAR(1) NULL DEFAULT NULL COMMENT '活動フラグ',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_substandard_tenants` (`tenant_id` ASC),
  INDEX `CAND_substandard` (`tenant_id` ASC, `contract_no` ASC, `contract_branch_no` ASC, `insured_sequence_no` ASC, `sequence_no` ASC),
  CONSTRAINT `FK_substandard_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no` , `contract_branch_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no` , `contract_branch_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_substandard_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '特別条件';


-- -----------------------------------------------------
-- Table `third_party_org`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `third_party_org` ;

CREATE TABLE IF NOT EXISTS `third_party_org` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `claim_trxs_id` INT(9) UNSIGNED NOT NULL COMMENT '保険金・給付金情報ID',
  `type` CHAR(1) NOT NULL COMMENT '区分',
  `contract_no` CHAR(10) NOT NULL COMMENT '証券番号',
  `contract_branch_no` CHAR(2) NOT NULL COMMENT '証券番号枝番',
  `risk_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '保障連番',
  `org_sequence_no` TINYINT(1) UNSIGNED NOT NULL COMMENT '第三者機関連番',
  `org_name` VARCHAR(64) NULL DEFAULT NULL COMMENT '第三者機関名',
  `org_tel` VARCHAR(15) NULL DEFAULT NULL COMMENT '第三者機関連絡先電話番号',
  `org_person_name` VARCHAR(64) NULL DEFAULT NULL COMMENT '担当者名',
  `target_name` VARCHAR(32) NULL DEFAULT NULL COMMENT '補償対象名',
  `operation_contents` VARCHAR(1024) NULL DEFAULT NULL COMMENT '対処内容',
  `visit_date` DATE NULL DEFAULT NULL COMMENT '往訪日',
  `fee_amount` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '対処費用(税込)',
  `retension_date` DATE NULL DEFAULT NULL COMMENT '入日',
  `discharge_date` DATE NULL DEFAULT NULL COMMENT '退出日',
  `days_of_retension` INT(3) UNSIGNED NULL DEFAULT NULL COMMENT '入日数',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_third_party_org_tenants` (`tenant_id` ASC),
  INDEX `FK_third_party_org_claim_details_idx` (`tenant_id` ASC, `claim_trxs_id` ASC, `risk_sequence_no` ASC),
  INDEX `CAND_third_party_org` (`tenant_id` ASC, `claim_trxs_id` ASC, `risk_sequence_no` ASC, `org_sequence_no` ASC),
  CONSTRAINT `FK_third_party_org_claim_details`
    FOREIGN KEY (`tenant_id` , `claim_trxs_id` , `risk_sequence_no`)
    REFERENCES `claim_details` (`tenant_id` , `claim_trxs_id` , `risk_sequence_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_third_party_org_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '第三者機関';


-- -----------------------------------------------------
-- Table `underwritings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `underwritings` ;

CREATE TABLE IF NOT EXISTS `underwritings` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `contract_no` VARCHAR(10) NOT NULL COMMENT '証券番号',
  `contract_status` VARCHAR(2) NULL DEFAULT NULL COMMENT '契約ステータス',
  `reject_flag` CHAR(1) NULL DEFAULT NULL COMMENT '謝絶ステータス',
  `suming_up_check` CHAR(1) NULL DEFAULT NULL COMMENT '通算チェック',
  `antisocial_forces_check` CHAR(1) NULL DEFAULT NULL COMMENT '反社会的勢力チェック',
  `question_check` CHAR(1) NULL DEFAULT NULL COMMENT '告知チェック',
  `other_check` CHAR(1) NULL DEFAULT NULL COMMENT 'その他自動査定項目',
  `first_assessment_results` VARCHAR(2) NULL DEFAULT NULL COMMENT '1次査定結果',
  `second_assessment_results` VARCHAR(2) NULL DEFAULT NULL COMMENT '2次査定結果',
  `commnt_1st_uw` VARCHAR(1024) NULL DEFAULT NULL COMMENT '1次査定者コメント',
  `commnt_2nd_uw` VARCHAR(1024) NULL DEFAULT NULL COMMENT '2次査定者コメント',
  `communication_column` VARCHAR(1024) NULL DEFAULT NULL COMMENT '通信欄',
  `notification_to_applicant_date` DATE NULL DEFAULT NULL COMMENT '申込者通知予定日',
  `material_representation` CHAR(1) NULL DEFAULT NULL COMMENT '契約者・重要事項確認区分',
  `understanding_intent` CHAR(1) NULL DEFAULT NULL COMMENT '契約者・意向確認区分',
  `confirm_application` CHAR(1) NULL DEFAULT NULL COMMENT '契約者・申込内容確認区分',
  `question_1` CHAR(1) NULL DEFAULT NULL COMMENT '質問1',
  `question_2` CHAR(1) NULL DEFAULT NULL COMMENT '質問2',
  `question_3` CHAR(1) NULL DEFAULT NULL COMMENT '質問3',
  `question_4` CHAR(1) NULL DEFAULT NULL COMMENT '質問4',
  `question_5` CHAR(1) NULL DEFAULT NULL COMMENT '質問5',
  `question_6` CHAR(1) NULL DEFAULT NULL COMMENT '質問6',
  `question_7` CHAR(1) NULL DEFAULT NULL COMMENT '質問7',
  `question_8` CHAR(1) NULL DEFAULT NULL COMMENT '質問8',
  `question_1_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問1テキスト',
  `question_2_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問2テキスト',
  `question_3_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問3テキスト',
  `question_4_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問4テキスト',
  `question_5_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問5テキスト',
  `question_6_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問6テキスト',
  `question_7_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問7テキスト',
  `question_8_text` CHAR(1) NULL DEFAULT NULL COMMENT '質問8テキスト',
  `substandard_reply` CHAR(1) NULL DEFAULT NULL COMMENT '特別条件回答',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_underwritings_tenants` (`tenant_id` ASC),
  INDEX `FK_underwritings_contracts_idx` (`tenant_id` ASC, `contract_no` ASC),
  CONSTRAINT `FK_underwritings_contracts`
    FOREIGN KEY (`tenant_id` , `contract_no`)
    REFERENCES `contracts` (`tenant_id` , `contract_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_underwritings_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '申込査定情報';


-- -----------------------------------------------------
-- Table `customers_corporate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customers_corporate` ;

CREATE TABLE IF NOT EXISTS `customers_corporate` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `customer_id` VARCHAR(12) NOT NULL COMMENT '顧客ID',
  `corp_name_kana` TEXT NULL DEFAULT NULL COMMENT '法人名(カナ)',
  `corp_name_official` TEXT NULL DEFAULT NULL COMMENT '法人名(公式)',
  `corp_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '法人・郵便番号',
  `corp_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ 県',
  `corp_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ１',
  `corp_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ２',
  `corp_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字　県',
  `corp_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 1',
  `corp_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 2',
  `rep10e_sex` CHAR(1) NULL DEFAULT NULL COMMENT '代表者・性別',
  `rep10e_date_of_birth` DATE NULL DEFAULT NULL COMMENT '代表者・生年月日',
  `rep10e_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名カナ 姓',
  `rep10e_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名カナ 名',
  `rep10e_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名漢字 姓',
  `rep10e_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名漢字 名',
  `rep10e_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '代表者・郵便番号',
  `rep10e_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ 県',
  `rep10e_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ１',
  `rep10e_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ２',
  `rep10e_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字　県',
  `rep10e_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 1',
  `rep10e_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 2',
  `rep10e_addr_tel1` TEXT NULL DEFAULT NULL COMMENT '代表者・電話番号1',
  `rep10e_addr_tel2` TEXT NULL DEFAULT NULL COMMENT '代表者・電話番号2',
  `contact_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名カナ 姓',
  `contact_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名カナ 名',
  `contact_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名漢字 姓',
  `contact_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名漢字 名',
  `contact_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '通信先・郵便番号',
  `contact_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ 県',
  `contact_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ１',
  `contact_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ２',
  `contact_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字　県',
  `contact_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 1',
  `contact_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 2',
  `contact_addr_tel1` TEXT NULL DEFAULT NULL COMMENT '通信先・電話番号1',
  `contact_addr_tel2` TEXT NULL DEFAULT NULL COMMENT '通信先・電話番号2',
  `contact_email` TEXT NULL DEFAULT NULL COMMENT '通信先・Eメールアドレス',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_customers_corporate_tenants` (`tenant_id` ASC),
  INDEX `CAND_customers_corporate` (`tenant_id` ASC, `customer_id` ASC),
  CONSTRAINT `FK_customers_corporate_customers`
    FOREIGN KEY (`tenant_id` , `customer_id`)
    REFERENCES `customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_customers_corporate_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '法人顧客マスタ';


-- -----------------------------------------------------
-- Table `customers_individual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customers_individual` ;

CREATE TABLE IF NOT EXISTS `customers_individual` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `customer_id` VARCHAR(12) NOT NULL COMMENT '顧客ID',
  `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 姓',
  `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 名',
  `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 姓',
  `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 名',
  `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別',
  `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日',
  `addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号',
  `addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '住所カナ 県',
  `addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '住所カナ１',
  `addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '住所カナ２',
  `addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '住所漢字　県',
  `addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '住所漢字 1',
  `addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '住所漢字 2',
  `addr_tel1` TEXT NULL DEFAULT NULL COMMENT '電話番号1',
  `addr_tel2` TEXT NULL DEFAULT NULL COMMENT '電話番号2',
  `company_name_kana` TEXT NULL DEFAULT NULL COMMENT '勤務先名カナ',
  `company_name_kanji` TEXT NULL DEFAULT NULL COMMENT '勤務先名',
  `place_of_work_kana` VARCHAR(25) NULL DEFAULT NULL COMMENT '勤務先所属名カナ',
  `place_of_work_kanji` VARCHAR(25) NULL DEFAULT NULL COMMENT '勤務先所属名漢字',
  `place_of_work_code` VARCHAR(15) NULL DEFAULT NULL COMMENT '勤務先所属コード',
  `group_column` VARCHAR(30) NULL DEFAULT NULL COMMENT '団体使用欄',
  `email` TEXT NULL DEFAULT NULL COMMENT 'メールアドレス',
  `occupation` VARCHAR(32) NULL DEFAULT NULL COMMENT '職業',
  `occupation_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '職業コード',
  `enguarded_type` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等の区分',
  `guardian_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '成年後見人ID',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_customers_individual_tenants` (`tenant_id` ASC),
  INDEX `CAND_customers_individual` (`tenant_id` ASC, `customer_id` ASC),
  INDEX `FK_customers_individual_guardian_idx` (`tenant_id` ASC, `guardian_id` ASC),
  CONSTRAINT `FK_customers_individual_customers`
    FOREIGN KEY (`tenant_id` , `customer_id`)
    REFERENCES `customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_customers_individual_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`),
  CONSTRAINT `FK_customers_individual_guardian`
    FOREIGN KEY (`tenant_id` , `guardian_id`)
    REFERENCES `customers` (`tenant_id` , `customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '個人顧客マスタ';


-- -----------------------------------------------------
-- Table `maintenance_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_documents` ;

CREATE TABLE IF NOT EXISTS `maintenance_documents` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT '連番',
  `document_title` VARCHAR(64) NULL DEFAULT NULL COMMENT 'タイトル',
  `document_url` VARCHAR(256) NULL DEFAULT NULL COMMENT 'URL',
  `upload_date` DATE NULL DEFAULT NULL COMMENT '登録日',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_documents_tenants_idx` (`tenant_id` ASC),
  INDEX `FK_maintenance_documents_maintenance_requests_idx` (`tenant_id` ASC, `request_no` ASC),
  INDEX `CAND_maintenance_documents` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC),
  CONSTRAINT `FK_maintenance_documents_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_documents_maintenance_requests`
    FOREIGN KEY (`tenant_id` , `request_no`)
    REFERENCES `maintenance_requests` (`tenant_id` , `request_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請資料';


-- -----------------------------------------------------
-- Table `maintenance_requests_no`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_requests_no` ;

CREATE TABLE IF NOT EXISTS `maintenance_requests_no` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `update_count` INT(11) NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_no_tenants_idx` (`tenant_id` ASC),
  INDEX `CAND_maintenance_requests_no` (`tenant_id` ASC, `request_no` ASC),
  CONSTRAINT `FK_maintenance_requests_no_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請番号';


-- -----------------------------------------------------
-- Table `maintenance_requests_customer_individual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_requests_customer_individual` ;

CREATE TABLE IF NOT EXISTS `maintenance_requests_customer_individual` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `sequence_no` TINYINT(2) NOT NULL COMMENT '保全申請顧客連番',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '顧客ID',
  `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 姓',
  `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名カナ 名',
  `name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 姓',
  `name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '氏名漢字 名',
  `sex` CHAR(1) NULL DEFAULT NULL COMMENT '性別',
  `date_of_birth` DATE NULL DEFAULT NULL COMMENT '生年月日',
  `addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '郵便番号',
  `addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '住所カナ 県',
  `addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '住所カナ１',
  `addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '住所カナ２',
  `addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '住所漢字　県',
  `addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '住所漢字 1',
  `addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '住所漢字 2',
  `addr_tel1` TEXT NULL DEFAULT NULL COMMENT '電話番号1',
  `addr_tel2` TEXT NULL DEFAULT NULL COMMENT '電話番号2',
  `company_name_kana` TEXT NULL DEFAULT NULL COMMENT '勤務先名カナ',
  `company_name_kanji` TEXT NULL DEFAULT NULL COMMENT '勤務先名',
  `place_of_work_kana` VARCHAR(25) NULL DEFAULT NULL COMMENT '勤務先所属名カナ',
  `place_of_work_kanji` VARCHAR(25) NULL DEFAULT NULL COMMENT '勤務先所属名漢字',
  `place_of_work_code` VARCHAR(15) NULL DEFAULT NULL COMMENT '勤務先所属コード',
  `group_column` VARCHAR(30) NULL DEFAULT NULL COMMENT '団体使用欄',
  `email` TEXT NULL DEFAULT NULL COMMENT 'メールアドレス',
  `occupation` VARCHAR(32) NULL DEFAULT NULL COMMENT '職業',
  `occupation_code` VARCHAR(4) NULL DEFAULT NULL COMMENT '職業コード',
  `enguarded_type` CHAR(1) NULL DEFAULT NULL COMMENT '成年後見人等の区分',
  `guardian_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '成年後見人ID',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_customer_individual_mrc_idx` (`tenant_id` ASC),
  UNIQUE INDEX `CAND_maintenance_requests_customer_individual` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC),
  CONSTRAINT `FK_maintenance_requests_customer_individual_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_customer_individual_mrc`
    FOREIGN KEY (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
    REFERENCES `maintenance_requests_customer` (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請個人顧客';


-- -----------------------------------------------------
-- Table `maintenance_requests_customer_corporate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_requests_customer_corporate` ;

CREATE TABLE IF NOT EXISTS `maintenance_requests_customer_corporate` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `sequence_no` TINYINT(2) NOT NULL COMMENT '保全申請顧客連番',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `customer_id` VARCHAR(12) NULL DEFAULT NULL COMMENT '顧客ID',
  `corp_name_kana` TEXT NULL DEFAULT NULL COMMENT '法人名(カナ)',
  `corp_name_official` TEXT NULL DEFAULT NULL COMMENT '法人名(公式)',
  `corp_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '法人・郵便番号',
  `corp_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ 県',
  `corp_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ１',
  `corp_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '法人・住所カナ２',
  `corp_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字　県',
  `corp_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 1',
  `corp_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '法人・住所漢字 2',
  `rep10e_sex` CHAR(1) NULL DEFAULT NULL COMMENT '代表者・性別',
  `rep10e_date_of_birth` DATE NULL DEFAULT NULL COMMENT '代表者・生年月日',
  `rep10e_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名カナ 姓',
  `rep10e_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名カナ 名',
  `rep10e_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名漢字 姓',
  `rep10e_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '代表者・氏名漢字 名',
  `rep10e_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '代表者・郵便番号',
  `rep10e_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ 県',
  `rep10e_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ１',
  `rep10e_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '代表者・住所カナ２',
  `rep10e_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字　県',
  `rep10e_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 1',
  `rep10e_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '代表者・住所漢字 2',
  `rep10e_addr_tel1` TEXT NULL DEFAULT NULL COMMENT '代表者・電話番号1',
  `rep10e_addr_tel2` TEXT NULL DEFAULT NULL COMMENT '代表者・電話番号2',
  `contact_name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名カナ 姓',
  `contact_name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名カナ 名',
  `contact_name_knj_sei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名漢字 姓',
  `contact_name_knj_mei` TEXT NULL DEFAULT NULL COMMENT '通信先・氏名漢字 名',
  `contact_addr_zip_code` VARCHAR(8) NULL DEFAULT NULL COMMENT '通信先・郵便番号',
  `contact_addr_kana_pref` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ 県',
  `contact_addr_kana_1` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ１',
  `contact_addr_kana_2` TEXT NULL DEFAULT NULL COMMENT '通信先・住所カナ２',
  `contact_addr_knj_pref` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字　県',
  `contact_addr_knj_1` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 1',
  `contact_addr_knj_2` TEXT NULL DEFAULT NULL COMMENT '通信先・住所漢字 2',
  `contact_addr_tel1` TEXT NULL DEFAULT NULL COMMENT '通信先・電話番号1',
  `contact_addr_tel2` TEXT NULL DEFAULT NULL COMMENT '通信先・電話番号2',
  `contact_email` TEXT NULL DEFAULT NULL COMMENT '通信先・Eメールアドレス',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_customer_corporate_mrc_idx` (`tenant_id` ASC),
  UNIQUE INDEX `CAND_maintenance_requests_customer_corporate` (`tenant_id` ASC, `request_no` ASC, `sequence_no` ASC, `before_after` ASC),
  CONSTRAINT `FK_maintenance_requests_customer_corporate_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_customer_corporate_mrc`
    FOREIGN KEY (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
    REFERENCES `maintenance_requests_customer` (`tenant_id` , `request_no` , `sequence_no` , `before_after`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請法人顧客';


-- -----------------------------------------------------
-- Table `maintenance_requests_beneficiaries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maintenance_requests_beneficiaries` ;

CREATE TABLE IF NOT EXISTS `maintenance_requests_beneficiaries` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` INT(10) UNSIGNED NOT NULL COMMENT 'テナントID',
  `request_no` VARCHAR(22) NOT NULL COMMENT '保全申請番号',
  `before_after` CHAR(1) NOT NULL DEFAULT 'A' COMMENT '申請適用前後フラグ',
  `role_type` VARCHAR(2) NOT NULL COMMENT 'ロールタイプ',
  `role_sequence_no` TINYINT(2) UNSIGNED NOT NULL COMMENT 'ロール連番',
  `corporate_individual_flag` CHAR(1) NOT NULL COMMENT '法人/個人区分',
  `name_sei` TEXT NULL DEFAULT NULL COMMENT '氏名　姓（会社名）',
  `name_mei` TEXT NULL DEFAULT NULL COMMENT '氏名　名',
  `name_kana_sei` TEXT NULL DEFAULT NULL COMMENT '氏名　姓　カナ(会社名)',
  `name_kana_mei` TEXT NULL DEFAULT NULL COMMENT '氏名　名　カナ',
  `share` INT(3) UNSIGNED NULL DEFAULT NULL COMMENT '受取の割合',
  `rel_ship_to_insured` VARCHAR(2) NULL DEFAULT NULL COMMENT '被保険者からみた続柄',
  `update_count` INT(11) UNSIGNED NULL DEFAULT 1 COMMENT 'ロック用',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `created_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '作成者',
  `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `updated_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '最終更新者',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '論理削除',
  `deleted_by` VARCHAR(64) NULL DEFAULT NULL COMMENT '論理削除者',
  PRIMARY KEY (`id`),
  INDEX `FK_maintenance_requests_beneficiaries_tenants_idx` (`tenant_id` ASC),
  INDEX `CAND_maintenance_requests_beneficiaries` (`tenant_id` ASC, `request_no` ASC, `before_after` ASC, `role_type` ASC, `role_sequence_no` ASC),
  CONSTRAINT `FK_maintenance_requests_beneficiaries_tenants`
    FOREIGN KEY (`tenant_id`)
    REFERENCES `tenants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_maintenance_requests_beneficiaries_mr`
    FOREIGN KEY (`tenant_id` , `request_no`)
    REFERENCES `maintenance_requests` (`tenant_id` , `request_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_bin
COMMENT = '保全申請受取人';


