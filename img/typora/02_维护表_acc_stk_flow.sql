/* ******************************************
 * 版本          日期           修改人              备注 
 * 7.0.2.1       20220106       yuyang             创建脚本
 * 7.0.3.2       20220414       fanxueping      CMPS-6245	南国宝宝：销售明细增加会员等级等字段
 * ******************************************/

CREATE OR REPLACE FUNCTION "temp_create_table"()
  RETURNS void AS $BODY$
	DECLARE
	v_db_type    int2;
	v_base       varchar;
	v_dist       varchar;
	v_part       varchar;
	v_part_def   varchar;
	v_result     int2;
	BEGIN
	
	-- 创建表SQL语句-字段定义
	v_base := '
		CREATE TABLE IF NOT EXISTS acc_stk_flow (
			acc_stk_flow_id int8 NOT NULL,
			acc_type varchar(10) NOT NULL,
			data_type varchar(10) NOT NULL,
			bill_no varchar(50) NOT NULL,
			biz_type varchar(10) NOT NULL,
			gen_date timestamp(6) NOT NULL,
			acc_date timestamp(6) NOT NULL,
			biz_date varchar(10) NOT NULL,
			org_id int8 NOT NULL,
			wh_id int8 NOT NULL,
			stk_count numeric(18, 4) NOT NULL,
			in_pur_total numeric(27, 8) NOT NULL,
			ex_pur_total numeric(27, 8) NOT NULL,
			in_inv_total numeric(27, 8) NOT NULL,
			ex_inv_total numeric(27, 8) NOT NULL,
			in_dis_total numeric(27, 8) NOT NULL,
			ex_dis_total numeric(27, 8) NOT NULL,
			in_sal_total numeric(27, 8) NOT NULL,
			ex_sal_total numeric(27, 8) NOT NULL,
			ref_bill_no varchar(50) NULL,
			ref_bill_type varchar(10) NULL,
			to_org_id int8 NULL,
			to_wh_id int8 NULL,
			cnt_id int8 NULL,
			opr_mode varchar(10) NULL,
			pur_sal_rlt varchar(10) NULL,
			acc_trade_id int8 NOT NULL,
			add_time timestamp(6) NOT NULL,
			dep_code varchar(50) NULL,
			udp1 varchar(100) NULL,
			udp2 varchar(100) NULL,
			udp3 varchar(100) NULL,
			ord_bill_no varchar(10) NULL,
			ord_biz_type varchar(50) NULL,
			pre_bill_no varchar(10) NULL,
			pre_biz_type varchar(50) NULL,
			CONSTRAINT pk__acc_stk_flow__acc_stk_flow_id PRIMARY KEY (org_id,biz_date,acc_stk_flow_id)
		)
		';
	
	
	-- 创建表SQL脚本-分布定义
	v_dist := 'DISTRIBUTED BY (org_id)';
	
	-- 创建表SQL语句-分区定义
	v_part := '';
	
	-- 创建表SQL语句-ADBPG默认分区
	v_part_def := '';
	
	-- 直接调用创建表函数即可
	SELECT sysdb_create_table INTO v_result FROM sysdb_create_table(v_base, v_dist, v_part, v_part_def);
	
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
-- 触发执行建表
SELECT * FROM temp_create_table();

 SELECT * FROM sysdb_add_column('acc_stk_flow', 'udp4', 'varchar(100)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'udp5', 'varchar(100)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'card_type', 'varchar(10)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'vip_card_no', 'varchar(100)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'vip_card_face_no', 'varchar(100)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'vip_name', 'varchar(100)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'vip_mobile', 'varchar(100)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'ord_bill_no', 'varchar(10)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'ord_biz_type', 'varchar(50)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'pre_bill_no', 'varchar(10)');
 SELECT * FROM sysdb_add_column('acc_stk_flow', 'pre_biz_type', 'varchar(50)');


