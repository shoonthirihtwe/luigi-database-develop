LOCK TABLES `service_instances` WRITE;
/*!40000 ALTER TABLE `service_instances` DISABLE KEYS */;
INSERT INTO `service_instances` (`tenant_id`, `template_id`, `source_key`, `source_type`, `inherent_json`, `inherent_text`, `description`, `status`, `version`, `update_count`, `created_at`, `updated_at`) VALUES (12,NULL,'enum_construction_type','1','{"enum_name":"construction_type","enum_title":"建造種別","items":[{"id":1,"value":1,"title":"マンション"},{"id":2,"value":2,"title":"戸建て"},{"id":3,"value":3,"title":"併用住宅"}]}',NULL,NULL,'1',1,1,'2022-04-15 14:54:39','2022-09-27 20:11:46');
INSERT INTO `service_instances` (`tenant_id`, `template_id`, `source_key`, `source_type`, `inherent_json`, `inherent_text`, `description`, `status`, `version`, `update_count`, `created_at`, `updated_at`) VALUES (12,NULL,'enum_structure','1','{\"items\": [{\"id\": 1, \"title\": \"M構造\", \"value\": 1}, {\"id\": 2, \"title\": \"T構造\", \"value\": 2}, {\"id\": 3, \"title\": \"H構造\", \"value\": 3}, {\"id\": 4, \"title\": \"1級\", \"value\": 4}, {\"id\": 5, \"title\": \"2級\", \"value\": 5}, {\"id\": 6, \"title\": \"3級\", \"value\": 6}], \"enum_name\": \"structure\", \"enum_title\": \"構造\"}',NULL,NULL,'1',1,1,'2022-04-15 15:03:49','2022-09-28 13:34:46');
INSERT INTO `service_instances` (`tenant_id`, `template_id`, `source_key`, `source_type`, `inherent_json`, `inherent_text`, `description`, `status`, `version`, `update_count`, `created_at`, `updated_at`) VALUES (12,NULL,'enum_other_insurance_exists','1','{\"items\": [{\"id\": 1, \"title\": \"あり\", \"value\": 1}, {\"id\": 2, \"title\": \"なし\", \"value\": 2}], \"enum_name\": \"other_insurance_exists\", \"enum_title\": \"他社保険加入の有無\"}',NULL,NULL,'1',1,1,'2022-04-19 04:22:55','2022-09-27 20:11:46');
INSERT INTO `service_instances` (`tenant_id`, `template_id`, `source_key`, `source_type`, `inherent_json`, `inherent_text`, `description`, `status`, `version`, `update_count`, `created_at`, `updated_at`) VALUES (12,NULL,'schema','1','{"floors":{"id":3,"type":"uint","title":"総階層","length":2,"required":true,"description":null},"structure":{"id":4,"type":"enum","title":"構造","length":null,"required":true,"description":null},"replacement_cost":{"id":5,"type":"uint","title":"被保険物件の再調達価額","length":10,"required":true,"description":null},"construction_date":{"id":1,"type":"date","title":"建築年月日または完成予定日","length":null,"required":true,"description":null},"construction_type":{"id":2,"type":"enum","title":"被保険物件の種別","length":null,"required":true,"description":null},"other_insurance_exists":{"id":6,"type":"enum","title":"他社保険加入の有無","length":null,"required":true,"description":null},"other_insurance_company":{"id":7,"type":"string","title":"他社保険加入・火災保険","length":null,"required":false,"description":null},"other_insurance_product":{"id":8,"type":"string","title":"他社保険加入・地震保険","length":null,"required":false,"description":null}}',NULL,NULL,'1',1,1,'2022-04-21 15:19:55','2022-09-22 09:11:46');
INSERT INTO `service_instances` (`tenant_id`, `template_id`, `source_key`, `source_type`, `inherent_json`, `inherent_text`, `description`, `status`, `version`, `update_count`, `created_at`, `updated_at`) VALUES (12,NULL,'ui_template','1','{\"floors\":{\"order\":1,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"InputNumber\",\"attributes\":{\"title\":\"総階層\",\"placeholder\":\"総階層を入力してください。\"}},\"structure\":{\"order\":2,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"SelectBox\",\"attributes\":{\"title\":\"構造\"}},\"replacement_cost\":{\"order\":3,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"InputNumber\",\"attributes\":{\"title\":\"被保険物件の再調達価額\",\"placeholder\":\"被保険物件の再調達価額を入力してください。\"}},\"construction_date\":{\"order\":4,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"DatePicker\",\"attributes\":{\"title\":\"建築年月日または完成予定日\"}},\"construction_type\":{\"order\":5,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"SelectBox\",\"attributes\":{\"title\":\"被保険物件の種別\"}},\"other_insurance_exists\":{\"order\":6,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"SelectBox\",\"attributes\":{\"title\":\"他社保険加入の有無\"}},\"other_insurance_company\":{\"order\":7,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"InputText\",\"attributes\":{\"title\":\"他社保険加入・火災保険\",\"placeholder\":\"他社保険加入・火災保険を入力してください。\"}},\"other_insurance_product\":{\"order\":8,\"screen_region_ids\":[\"INHR_ITM\"],\"template\":\"InputText\",\"attributes\":{\"title\":\"他社保険加入・地震保険\",\"placeholder\":\"他社保険加入・地震保険を入力してください。\"}}}',NULL,NULL,'1',1,1,'2022-06-07 03:28:03','2022-09-27 20:30:52');
/*!40000 ALTER TABLE `service_instances` ENABLE KEYS */;
UNLOCK TABLES;