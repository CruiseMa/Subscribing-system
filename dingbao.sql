create database dingbao_pro;
use dingbao_pro;
#创建用户表
CREATE TABLE customer (
    gno INT(10) primary key not NULL,#客户编号
    gna VARCHAR(20) NOT NULL,#客户姓名
    gte INT(10),#电话
	gad VARCHAR(50),#地址
    gpo INT(10),#邮政编码
    gmo INT(4)#余额
)  ENGINE=INNODB;
#创建报纸表
CREATE TABLE paper (
    pno INT(3) NOT NULL PRIMARY KEY,#报纸编号
    pna VARCHAR(20),#报纸名称
    ppr INT(3),#报纸单价
    pdw VARCHAR(40)#出版单位
)  ENGINE=INNODB;

#创建购买记录表
CREATE TABLE buy (
    gno INT(10) NOT NULL,#用户编号
    pno INT(10) NOT NULL,#报纸编号
    num INT(3) NOT NULL,#购买数量
    primary key (gno,pno),
    FOREIGN KEY (gno)
        REFERENCES customer (gno)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pno)
        REFERENCES paper (pno)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;


#插入一些报纸数据
insert into paper     values(1,'人民日报',12,'人民日报社'),           
							(2,'解放军报',14,'解放军报社'), 
							(3,'光明日报',10,'光明日报社'),       
							(4,'青年报'  ,11,'青年报社'), 
							(5,'扬子日报',18,'扬子日报社');

 
                            