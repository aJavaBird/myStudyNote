
-- mysql ����ο�: https://mp.weixin.qq.com/s?__biz=MzA5MTkxMDQ4MQ==&mid=2648933355&idx=1&sn=b426ad28dfc2a64bba813df5b7c341a4&chksm=88621bd5bf1592c3c08e441398f699d0a4c2303a51519aac169447f22765cc613dfc3d991f8b&mpshare=1&scene=23&srcid=&sharer_sharetime=1569506037620&sharer_shareid=c50c02749123cb7ef78b345044a4099b#rd
-- 2�ַ�ʽ�ֶ���������
-- ��ʽһ
set autocommit=0; -- ���ò��Զ��ύ����
-- ִ���������
commit;
rollback;
set autocommit=1; -- ��autocommit��ԭ��ȥ
-- ��ʽ��
start transaction; -- ��������
-- ִ���������
commit;
rollback;

-- ������������ִ����һ������������������ֻ��ع���������
-- ʹ�� savepoint
start transaction;
-- �˴�һ�Ѳ���
savepoint part1;-- ����һ�������
-- �˴���һ�Ѳ���
rollback to part1; -- ��savepint = part1����䵽��ǰ���֮�����еĲ����ع�
commit; -- �ύ����

-- ֻ������
start transaction read only;
-- ֻ�������У�insert��update��delete �޷�ִ��

/*���뼶���Ϊ4�֣�
��δ�ύ�������������READ-UNCOMMITTED
�����ύ���������������ڲ����ظ�������READ-COMMITTED
���ظ�������������ظ����������ڻö�����REPEATABLE-READ
���У�����ö�����SERIALIZABLE
����4�и��뼶��Խ��Խǿ���ᵼ�����ݿ�Ĳ�����ҲԽ��Խ�͡�

���ݿ���뼶������:
1���޸�my.init : 
# ���뼶������,READ-UNCOMMITTED ��δ�ύ,READ-COMMITTED �����ύ,REPEATABLE-READ ���ظ���,SERIALIZABLE ����
transaction-isolation=READ-UNCOMMITTED
2������mysql
*/

-- �鿴��ǰmysql�汾
select version();
-- ��ѯ��ǰ���ݿ�
select schema();
-- ��ѯ��mq_error_log�ķ������
select partition_name part,partition_expression expr,partition_description descr,table_rows from information_schema.partitions where table_schema = schema() and table_name='mq_error_log'; 

-- MySQL 5.6.5 ֮ǰ�汾��֧�ֶ���DEFAULT CURRENT_TIMESTAMP �� ON UPDATE CURRENT TIMESTAMP

-- �鿴ָ�����ݿ���������С
select sum(table_rows) as '��¼��',sum(truncate(data_length/1024/1024, 2)) as '��������(MB)',sum(truncate(index_length/1024/1024, 2)) as '��������(MB)' from information_schema.tables where table_schema='sms';
-- �鿴ָ�����ݿ�����С
select table_schema as '���ݿ�',table_name as '����',table_rows as '��¼��',truncate(data_length/1024/1024, 2) as '��������(MB)',truncate(index_length/1024/1024, 2) as '��������(MB)' from information_schema.tables where table_schema='sms' order by data_length desc, index_length desc;

-- mysql��ѯ����
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'zkbc' and table_name like '%act%'; 

-- ʱ���ѯ
select curdate(); -- ��ѯ��ǰ���ڣ��õ��磺2017-09-28��
select curtime(); -- ��ѯ��ǰʱ�䣨�õ��磺11:41:16��
select date_format(curdate(),'%Y%m'); -- ��ѯ���£��磺201704
select now(); -- ��ѯ��ǰʱ�䣨�õ��磺2017-09-28 11:42:17��

-- Mysql�кţ���Ҫ������ʱ��[ (select (@rowno:=0)) ]��
-- �к�Ϊ @rowno:=@rowno + 1 AS rowno
select * from (select @rowno:=@rowno + 1 AS rowno,a.* from ptn_activity a,(select (@rowno:=0)) b order by a.id desc) a where id=5;


-- ���ں���
select date_format(NOW(),'%Y-%m-%d');
select date_format(now(),'%Y-%m-%d %H:%i:%s');
select str_to_date('1992-08-24 12:15:05','%Y-%m-%d %H:%i:%s');

-- ����������sql
-- update msyd_act_medal_draw_times_history a,msyd_act_medal_draw_times b,msyd_medal_act_third_draw c set a.times=b.times where a.user_id=b.user_id and a.time_id=c.id and b.act_code=c.act_code and c.end_time>now() and a.user_id=1300014526 and b.act_code='MSYD_3YEARS_ACT';

-- �鿴push_server_loan_investor��ṹ������
desc push_server_loan_investor;
-- �鿴push_server_loan_investor��ṹ�����  
show create table push_server_loan_investor; 

-- �鿴һ��Сʱǰ��ʱ��
select date_sub(now(), interval 1 hour);
select date_sub(now(), interval 60 minute);

-- �鿴һ��������
select date_add(convert(now(),date), interval 1 day);

-- ��ѯ�������ڼ�
select date_format(curdate(),'%w');
-- ��ѯ���ܵ�����
select date_sub(curdate(),interval date_format(curdate(),'%w')+2 day);
-- ��ѯ�ϸ����壨�Ѿ����˵������һ�����壩
select date_sub(curdate(),interval if(date_format(curdate(),'%w')>=5,date_format(curdate(),'%w')-5,date_format(curdate(),'%w')+2) day);

-- ʱ�������Ƚϵ����ͣ����ԱȽ�FRAC_SECOND��SECOND�� MINUTE�� HOUR�� DAY�� WEEK�� MONTH�� QUARTER�� YEAR��������
SELECT TIMESTAMPDIFF(DAY,'2012-10-01','2013-01-13'); -- 104
SELECT TIMESTAMPDIFF(MONTH,'2012-10-01','2013-01-13'); -- 3
-- ע��ʱ���Ϊ���ʱ�����������������ã�TIMESTAMPDIFF �� DATEDIFF �����в�ͬ�ģ���������֮��������TIMESTAMPDIFF�ǱȽϽ���ģ���������ֵ����DATEDIFF�ǱȽϴ�ͳ�ģ�ֻ��һ��ֵ��
select TIMESTAMPDIFF(day,str_to_date('2017-12-17 07:25','%Y-%m-%d %H:%i'),str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i')),DATEDIFF(str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i'),str_to_date('2017-12-17 07:25','%Y-%m-%d %H:%i')),TIMESTAMPDIFF(day,str_to_date('2017-12-17 05:55','%Y-%m-%d %H:%i'),str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i')),DATEDIFF(str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i'),str_to_date('2017-12-17 05:55','%Y-%m-%d %H:%i'));


-- ���뵽ָ���ֶκ���
-- alter table investor_group_info add subchannel int comment '������' after channel;

-- ���ָ�ʽ��������2ΪС��
select convert(4545.1366,decimal(11,2));
-- �ַ���ת����
select convert('123',signed);

-- һ������ʾ��sql
-- ʹ����ʱ�����ʵ�ֵ�������ͳ���û��˴�Ͷ�������ĵڼ��Σ�
SELECT *,IF(@inv_pa=ff.userid,@inv_rank:=@inv_rank+1,@inv_rank:=1) AS rank,@inv_pa:=ff.userid pa2 FROM (SELECT id,userid FROM push_server_loan_investor WHERE right(userid,1)=1 and msydChannel=1 and loanIsHandled =1 ORDER BY userid ASC, investTime) ff, (SELECT @inv_rank:=0,@inv_pa:=NULL) tt;

-- �鿴��ǰ���еĵ��������
select * from information_schema.innodb_trx;
-- �鿴��ǰ�Ľ��̵���䣨show full processlist; ��
select * from information_schema.processlist where db='zkbc' and info like 'insert%zd2_hkmx%' and info not like '%information_schema.processlist%'; -- show processlist;
-- ����������⣬����kill���̵�sql
select concat('kill ',id,';') from information_schema.processlist where db='zkbc' and info like 'insert%zd2_hkmx%' and info not like '%information_schema.processlist%';
-- ��ǰ���ֵ���
select * from information_schema.innodb_locks;
-- ���ȴ��Ķ�Ӧ��ϵ
select * from information_schema.innodb_lock_waits;

-- MySQL��������sleep���̵Ľ���취 
show global variables like '%timeout%';
-- �ؼ������� wait_timeout��interactive_timeout����λ����
-- Ĭ�ϳ�ʱʱ�� wait_timeout Ϊ28800�룬����һ����ص� interactive_timeout ����
-- Ĭ����8Сʱ������Ϊ1Сʱ�����߰�Сʱ���ɼ���sleep���̵�Ӱ�졣ͬʱ�����룬�������Ƿ����˳�ǰû�е���mysql_close()
set global wait_timeout=3600;
set global interactive_timeout=3600;
/* ����ֻ��������ʱ�������Ҫ���ý������Ҫ�޸� /etc/my.cnf��ͬʱ�޸����������������޸��������mysql
��mysqld��
wait_timeout=3600
interactive_timeout=3600
*/
-- �в�ѯ��ǰ��������
show status like '%Threads_connected%';
-- ��ѯ���������
show global variables like '%max_connections%';


-- ������������sql
-- cd C:\Program Files\MySQL\MySQL Server 5.7\bin
mysqldump -h 172.30.1.49 -uroot -pmsds007 zkbc zd2_fkmx --where=" updateTime>'2017-11-20'" > D:\myWork\��Ŀ����¼\sql\dumpSql\zd2_fkmx.sql
mysqldump -h 172.30.1.49 -uroot -pmsds007 zkbc zd_loan_rule --where=" updateTime>'2017-11-25'" > D:\myWork\��Ŀ����¼\sql\dumpSql\zd_loan_rule.sql

-- �ַ�������  locate����Ϊ�ַ���λ�ú�����substrΪ�ַ�����ȡ
select dayStr,locate('��',dayStr) numIndex,substr(dayStr,1,locate('��',dayStr)-1) num from (select '12��' dayStr union all select '31��' dayStr union all select '9��' dayStr union all select '123��' dayStr) a;

-- ȡĳ�ֶ����ֵ���У�ȡzd2_fkmx���У�ȡ��ÿ��ſ�������һ�У��п��ܶ��в��У�
select a.* from zd2_fkmx a left join zd2_fkmx b on a.loanDate=b.loanDate and a.factRmb<b.factRmb where b.factRmb is null order by a.loanDate desc limit 100;

-- ѭ��һ��
delimiter $$
create procedure insertData20180615()
begin
declare i int default 1;
while i<41 do
insert into employee(emp_name,sex,dept,title,date_hired,birthday,salary) select emp_name,sex,dept,title,date_hired,birthday,salary-i from employee where emp_no=1;
set i=i+1;
end while;
select i;
end $$
delimiter ;
call insertData20180615();
drop procedure insertData20180615;


-- �鿴��Ŀ����չʾ��mvn dependency:tree -Doutput=*.txt   ���磺mvn dependency:tree -Doutput=depen.txt��

-- ����
set autocommit=0;
begin; 
-- �ҵ�update sql
commit;


-- �鿴���ݿ�����Щ
show databases;
-- �鿴������Щ
show tables;
select table_name from information_schema.tables where table_schema='��ǰ���ݿ�';
-- �鿴���ݴ洢·��
show global variables like '%datadir%';
-- �鿴���ݿ��������
show global variables;


-- ����С��
select round(10.28) ������������,round(10.28,1) ��������1λС��,floor(10.28) ����ȡ��,ceiling(10.28) ����ȡ�� from dual;

-- ����������ʱ������ʹ��limitɾ��ɾ���
delete from zkbc.couponmodel_user where id>82232527 and id<93373183 order by id limit 10000;
-- delete zkbc.couponmodel_user from zkbc.couponmodel_user,(select id from zkbc.couponmodel_user where id>82232527 and id<93373183) t2 where zkbc.couponmodel_user.id=t2.id;
-- truncate table push_server.push_server_coupon;

-- �鿴��ǰ��mysql���ݿ��У� ����Щ�ͻ��˱���������
SELECT substring_index(host, ':',1) AS host_name,state,count(*) FROM information_schema.processlist GROUP BY state,host_name;
SELECT substring_index(host, ':',1) AS host_name,state,count(*) FROM information_schema.processlist where DB='push_server' GROUP BY state,host_name;

-- FIND_IN_SET ���� ��channel_ids ���ݸ�ʽ��: 1,12,3,2,56��
SELECT count(*) FROM sms_main_send_rule  where 1=1  and FIND_IN_SET(2,channel_ids);

-- �鿴sql�����С
show VARIABLES like '%max_allowed_packet%';

-- 1045 - Access denied for user ���
grant all privileges on *.* to 'root'@'%' identified by 'yidai@123!';
-- ��ѯ��ǰ�û�
select current_user();
-- ��ѯ��ǰ�û�������Ȩ��
show grants for 'sloan_user'@'172.16.%';

-- ʹ�� group_concat �ۺϲ�ѯ�����ֶ�����ƴ����һ��
select count(u.userId) inviteNum,group_concat(u.userId) inviteUserIds from qmtk_user_info u where FIND_IN_SET(u.inviteUserId,'11943,24770,30691,32296,37368,42931,48023,52160,66615,162031,228704')>0;
-- GROUP_CONCAT �и���󳤶ȵ����ƣ�Ĭ�� 1024����������󳤶Ⱦͻᱻ�ضϵ��������ͨ�����������ã�
SELECT @@global.group_concat_max_len;
show variables like "group_concat_max_len";
/*
�޸� GROUP_CONCAT ��󳤶�����
1.��MySQL�����ļ���my.conf��my.ini�����:
����#[mysqld]
����group_concat_max_len=1024000
2.����MySQL����
����ʱ���޸�: 
	SET GLOBAL group_concat_max_len = 1024000;
	�������ִ�к�mysql����ǰһֱ�����ã���mysqlһ�����������ָ�Ĭ�ϵ�����ֵ
��
*/

/*
�鿴 class �ı���汾: javap -verbose classname
��: javap -verbose Constants.class
javap -verbose ActConfigService.class
�汾����
Java 4 uses major version 48
Java 5 uses major version 49
Java 6 uses major version 50
Java 7 uses major version 51
Java 8 uses major version 52
Java 9 uses major version 53
*/



