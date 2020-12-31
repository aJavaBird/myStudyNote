
-- mysql 事务参考: https://mp.weixin.qq.com/s?__biz=MzA5MTkxMDQ4MQ==&mid=2648933355&idx=1&sn=b426ad28dfc2a64bba813df5b7c341a4&chksm=88621bd5bf1592c3c08e441398f699d0a4c2303a51519aac169447f22765cc613dfc3d991f8b&mpshare=1&scene=23&srcid=&sharer_sharetime=1569506037620&sharer_shareid=c50c02749123cb7ef78b345044a4099b#rd
-- 2种方式手动控制事务：
-- 方式一
set autocommit=0; -- 设置不自动提交事务
-- 执行事务操作
commit;
rollback;
set autocommit=1; -- 把autocommit还原回去
-- 方式二
start transaction; -- 开启事务
-- 执行事务操作
commit;
rollback;

-- 在事务中我们执行了一大批操作，可能我们只想回滚部分数据
-- 使用 savepoint
start transaction;
-- 此处一堆操作
savepoint part1;-- 设置一个保存点
-- 此处另一堆操作
rollback to part1; -- 将savepint = part1的语句到当前语句之间所有的操作回滚
commit; -- 提交事务

-- 只读事务
start transaction read only;
-- 只读事务中，insert、update、delete 无法执行

/*隔离级别分为4种：
读未提交（存在脏读）：READ-UNCOMMITTED
读已提交（解决脏读，但存在不可重复读）：READ-COMMITTED
可重复读（解决不可重复读，但存在幻读）：REPEATABLE-READ
串行（解决幻读）：SERIALIZABLE
上面4中隔离级别越来越强，会导致数据库的并发性也越来越低。

数据库隔离级别设置:
1、修改my.init : 
# 隔离级别设置,READ-UNCOMMITTED 读未提交,READ-COMMITTED 读已提交,REPEATABLE-READ 可重复读,SERIALIZABLE 串行
transaction-isolation=READ-UNCOMMITTED
2、重启mysql
*/

-- 查看当前mysql版本
select version();
-- 查询当前数据库
select schema();
-- 查询表mq_error_log的分区情况
select partition_name part,partition_expression expr,partition_description descr,table_rows from information_schema.partitions where table_schema = schema() and table_name='mq_error_log'; 

-- MySQL 5.6.5 之前版本不支持多条DEFAULT CURRENT_TIMESTAMP 和 ON UPDATE CURRENT TIMESTAMP

-- 查看指定数据库数据量大小
select sum(table_rows) as '记录数',sum(truncate(data_length/1024/1024, 2)) as '数据容量(MB)',sum(truncate(index_length/1024/1024, 2)) as '索引容量(MB)' from information_schema.tables where table_schema='sms';
-- 查看指定数据库各表大小
select table_schema as '数据库',table_name as '表名',table_rows as '记录数',truncate(data_length/1024/1024, 2) as '数据容量(MB)',truncate(index_length/1024/1024, 2) as '索引容量(MB)' from information_schema.tables where table_schema='sms' order by data_length desc, index_length desc;

-- mysql查询表名
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'zkbc' and table_name like '%act%'; 

-- 时间查询
select curdate(); -- 查询当前日期（得到如：2017-09-28）
select curtime(); -- 查询当前时间（得到如：11:41:16）
select date_format(curdate(),'%Y%m'); -- 查询年月，如：201704
select now(); -- 查询当前时间（得到如：2017-09-28 11:42:17）

-- Mysql行号，需要构建临时表[ (select (@rowno:=0)) ]，
-- 行号为 @rowno:=@rowno + 1 AS rowno
select * from (select @rowno:=@rowno + 1 AS rowno,a.* from ptn_activity a,(select (@rowno:=0)) b order by a.id desc) a where id=5;


-- 日期函数
select date_format(NOW(),'%Y-%m-%d');
select date_format(now(),'%Y-%m-%d %H:%i:%s');
select str_to_date('1992-08-24 12:15:05','%Y-%m-%d %H:%i:%s');

-- 多表更新联合sql
-- update msyd_act_medal_draw_times_history a,msyd_act_medal_draw_times b,msyd_medal_act_third_draw c set a.times=b.times where a.user_id=b.user_id and a.time_id=c.id and b.act_code=c.act_code and c.end_time>now() and a.user_id=1300014526 and b.act_code='MSYD_3YEARS_ACT';

-- 查看push_server_loan_investor表结构的命令
desc push_server_loan_investor;
-- 查看push_server_loan_investor表结构的命令：  
show create table push_server_loan_investor; 

-- 查看一个小时前的时间
select date_sub(now(), interval 1 hour);
select date_sub(now(), interval 60 minute);

-- 查看一天后的日期
select date_add(convert(now(),date), interval 1 day);

-- 查询今天星期几
select date_format(curdate(),'%w');
-- 查询上周的周五
select date_sub(curdate(),interval date_format(curdate(),'%w')+2 day);
-- 查询上个周五（已经过了的最近的一个周五）
select date_sub(curdate(),interval if(date_format(curdate(),'%w')>=5,date_format(curdate(),'%w')-5,date_format(curdate(),'%w')+2) day);

-- 时间差函数，比较的类型，可以比较FRAC_SECOND、SECOND、 MINUTE、 HOUR、 DAY、 WEEK、 MONTH、 QUARTER或 YEAR几种类型
SELECT TIMESTAMPDIFF(DAY,'2012-10-01','2013-01-13'); -- 104
SELECT TIMESTAMPDIFF(MONTH,'2012-10-01','2013-01-13'); -- 3
-- 注意时间差为天的时候，有两个函数可以用，TIMESTAMPDIFF 与 DATEDIFF 是略有不同的，对于两天之间的天数差，TIMESTAMPDIFF是比较较真的（可能两个值），DATEDIFF是比较传统的（只有一个值）
select TIMESTAMPDIFF(day,str_to_date('2017-12-17 07:25','%Y-%m-%d %H:%i'),str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i')),DATEDIFF(str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i'),str_to_date('2017-12-17 07:25','%Y-%m-%d %H:%i')),TIMESTAMPDIFF(day,str_to_date('2017-12-17 05:55','%Y-%m-%d %H:%i'),str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i')),DATEDIFF(str_to_date('2017-12-19 06:25','%Y-%m-%d %H:%i'),str_to_date('2017-12-17 05:55','%Y-%m-%d %H:%i'));


-- 插入到指定字段后面
-- alter table investor_group_info add subchannel int comment '渠道号' after channel;

-- 数字格式化，保留2为小数
select convert(4545.1366,decimal(11,2));
-- 字符串转数字
select convert('123',signed);

-- 一个有启示的sql
-- 使用临时表变量实现的排名（统计用户此次投资是他的第几次）
SELECT *,IF(@inv_pa=ff.userid,@inv_rank:=@inv_rank+1,@inv_rank:=1) AS rank,@inv_pa:=ff.userid pa2 FROM (SELECT id,userid FROM push_server_loan_investor WHERE right(userid,1)=1 and msydChannel=1 and loanIsHandled =1 ORDER BY userid ASC, investTime) ff, (SELECT @inv_rank:=0,@inv_pa:=NULL) tt;

-- 查看当前运行的的事务语句
select * from information_schema.innodb_trx;
-- 查看当前的进程的语句（show full processlist; ）
select * from information_schema.processlist where db='zkbc' and info like 'insert%zd2_hkmx%' and info not like '%information_schema.processlist%'; -- show processlist;
-- 解决锁定问题，生成kill进程的sql
select concat('kill ',id,';') from information_schema.processlist where db='zkbc' and info like 'insert%zd2_hkmx%' and info not like '%information_schema.processlist%';
-- 当前出现的锁
select * from information_schema.innodb_locks;
-- 锁等待的对应关系
select * from information_schema.innodb_lock_waits;

-- MySQL经常出现sleep进程的解决办法 
show global variables like '%timeout%';
-- 关键参数是 wait_timeout、interactive_timeout，单位是秒
-- 默认超时时长 wait_timeout 为28800秒，还有一个相关的 interactive_timeout 配置
-- 默认是8小时，设置为1小时（或者半小时）可减少sleep进程的影响。同时检查代码，看程序是否在退出前没有调用mysql_close()
set global wait_timeout=3600;
set global interactive_timeout=3600;
/* 以上只是线上临时解决，需要永久解决，需要修改 /etc/my.cnf，同时修改上面两个参数，修改完后重启mysql
【mysqld】
wait_timeout=3600
interactive_timeout=3600
*/
-- 中查询当前的连接数
show status like '%Threads_connected%';
-- 查询最大连接数
show global variables like '%max_connections%';


-- 导出部分数据sql
-- cd C:\Program Files\MySQL\MySQL Server 5.7\bin
mysqldump -h 172.30.1.49 -uroot -pmsds007 zkbc zd2_fkmx --where=" updateTime>'2017-11-20'" > D:\myWork\项目备份录\sql\dumpSql\zd2_fkmx.sql
mysqldump -h 172.30.1.49 -uroot -pmsds007 zkbc zd_loan_rule --where=" updateTime>'2017-11-25'" > D:\myWork\项目备份录\sql\dumpSql\zd_loan_rule.sql

-- 字符串裁切  locate函数为字符串位置函数，substr为字符串截取
select dayStr,locate('天',dayStr) numIndex,substr(dayStr,1,locate('天',dayStr)-1) num from (select '12天' dayStr union all select '31天' dayStr union all select '9天' dayStr union all select '123天' dayStr) a;

-- 取某字段最大值的行：取zd2_fkmx表中，取出每天放款金额最大的一行（有可能多行并列）
select a.* from zd2_fkmx a left join zd2_fkmx b on a.loanDate=b.loanDate and a.factRmb<b.factRmb where b.factRmb is null order by a.loanDate desc limit 100;

-- 循环一例
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


-- 查看项目依赖展示：mvn dependency:tree -Doutput=*.txt   （如：mvn dependency:tree -Doutput=depen.txt）

-- 事务
set autocommit=0;
begin; 
-- 我的update sql
commit;


-- 查看数据库有哪些
show databases;
-- 查看表有哪些
show tables;
select table_name from information_schema.tables where table_schema='当前数据库';
-- 查看数据存储路径
show global variables like '%datadir%';
-- 查看数据库各个配置
show global variables;


-- 保留小数
select round(10.28) 四舍五入整数,round(10.28,1) 四舍五入1位小数,floor(10.28) 向下取整,ceiling(10.28) 向上取整 from dual;

-- 数据量过大时，建议使用limit删，删多次
delete from zkbc.couponmodel_user where id>82232527 and id<93373183 order by id limit 10000;
-- delete zkbc.couponmodel_user from zkbc.couponmodel_user,(select id from zkbc.couponmodel_user where id>82232527 and id<93373183) t2 where zkbc.couponmodel_user.id=t2.id;
-- truncate table push_server.push_server_coupon;

-- 查看当前的mysql数据库中， 有哪些客户端保持了连接
SELECT substring_index(host, ':',1) AS host_name,state,count(*) FROM information_schema.processlist GROUP BY state,host_name;
SELECT substring_index(host, ':',1) AS host_name,state,count(*) FROM information_schema.processlist where DB='push_server' GROUP BY state,host_name;

-- FIND_IN_SET 函数 （channel_ids 数据格式如: 1,12,3,2,56）
SELECT count(*) FROM sms_main_send_rule  where 1=1  and FIND_IN_SET(2,channel_ids);

-- 查看sql允许大小
show VARIABLES like '%max_allowed_packet%';

-- 1045 - Access denied for user 解决
grant all privileges on *.* to 'root'@'%' identified by 'yidai@123!';
-- 查询当前用户
select current_user();
-- 查询当前用户被赋的权限
show grants for 'sloan_user'@'172.16.%';

-- 使用 group_concat 聚合查询，把字段内容拼接在一起
select count(u.userId) inviteNum,group_concat(u.userId) inviteUserIds from qmtk_user_info u where FIND_IN_SET(u.inviteUserId,'11943,24770,30691,32296,37368,42931,48023,52160,66615,162031,228704')>0;
-- GROUP_CONCAT 有个最大长度的限制（默认 1024），超过最大长度就会被截断掉，你可以通过下面的语句获得：
SELECT @@global.group_concat_max_len;
show variables like "group_concat_max_len";
/*
修改 GROUP_CONCAT 最大长度限制
1.在MySQL配置文件中my.conf或my.ini中添加:
　　#[mysqld]
　　group_concat_max_len=1024000
2.重启MySQL服务
（暂时性修改: 
	SET GLOBAL group_concat_max_len = 1024000;
	该语句在执行后，mysql重启前一直有作用，但mysql一旦重启，则会恢复默认的设置值
）
*/

/*
查看 class 的编译版本: javap -verbose classname
如: javap -verbose Constants.class
javap -verbose ActConfigService.class
版本对照
Java 4 uses major version 48
Java 5 uses major version 49
Java 6 uses major version 50
Java 7 uses major version 51
Java 8 uses major version 52
Java 9 uses major version 53
*/



