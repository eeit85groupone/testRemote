﻿CREATE DATABASE LE01 
ON
( NAME = LifeEditor,
  FILENAME = 'D:\LifeEditorDB\LifeEditor.MDF',
  SIZE = 10MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 5)

LOG ON 
( NAME = LifeEditorLog,
  FILENAME = 'D:\LifeEditorDB\LifeEditorLog.LDF',
  SIZE = 5MB,
  MAXSIZE = 20MB,
  FILEGROWTH = 2);

USE LE01;

DROP TABLE friend;
DROP TABLE invite_list;
DROP TABLE message;
DROP TABLE ach_list;
DROP TABLE target_list;
DROP TABLE target_spec;
DROP TABLE misbehave;
DROP TABLE user_spec;
DROP TABLE target;
DROP TABLE achievement;
DROP TABLE event;
DROP TABLE sec_list;
DROP TABLE type_list;

 CREATE TABLE user_spec(
    userID int  identity PRIMARY KEY,
	account varchar(30)  NOT NULL,
	pswd varchar(30)  NOT NULL,
	lastName nvarchar(30)  NOT NULL,
	firstName nvarchar(30)  NOT NULL,
	gender char(1)  NOT NULL,
	birthdate date,
	email varchar(50)  NOT NULL,
	address nvarchar(100),
	phone varchar(20),
	genkiBarTol int,
	level int,
	picture varbinary(max),
	regTime datetime2  NOT NULL,
	hotMan bit,
	suspendType int
);

CREATE TABLE friend(
	userID int FOREIGN KEY REFERENCES user_spec(userID),
	friendID int FOREIGN KEY REFERENCES user_spec(userID),
	frdSince datetime2 NOT NULL,
	PRIMARY KEY(userID,friendID)
);

CREATE TABLE invite_list(
	inviter int FOREIGN KEY REFERENCES user_spec(userID),
	receiver int FOREIGN KEY REFERENCES user_spec(userID),
	accepted bit NOT NULL,
	PRIMARY KEY(inviter,receiver)
);

CREATE TABLE message(
	messageID int IDENTITY PRIMARY KEY,
	msgSender int NOT NULL FOREIGN KEY REFERENCES user_spec(userID),
	msgReceiver int NOT NULL FOREIGN KEY REFERENCES user_spec(userID),
	msgTime datetime2 NOT NULL,
	content nvarchar(200)
);

CREATE TABLE type_list(
	typeID int IDENTITY PRIMARY KEY,
	typeName nvarchar(50),
	typePic varbinary(max)
);

CREATE TABLE sec_list(
	secID int IDENTITY PRIMARY KEY,
	typeID int FOREIGN KEY REFERENCES type_list(typeID) NOT NULL,
	secName nvarchar(50),
	secPic varbinary(max)
);

CREATE TABLE event(
	eventID int IDENTITY PRIMARY KEY,
	typeID int FOREIGN KEY REFERENCES type_list(typeID) NOT NULL,
	secID int FOREIGN KEY REFERENCES sec_list(secID) NOT NULL,
	eventName nvarchar(50) NOT NULL,
	eventPic varbinary(max),
	orgName nvarchar(30),
	orgAddr nvarchar(100),
	eventTime datetime2 NOT NULL,
	eventDesc nvarchar(200)
);

CREATE TABLE achievement(
	achID int IDENTITY PRIMARY KEY,
	achName nvarchar(50) NOT NULL,
	achDesc nvarchar(500),
	rewardPic varbinary(max)
);

CREATE TABLE ach_list(
	userID int FOREIGN KEY REFERENCES user_spec(userID) NOT NULL,
	achID int FOREIGN KEY REFERENCES achievement(achID) NOT NULL,
	PRIMARY KEY (userID,achID)
);

CREATE TABLE target(
	targetID int IDENTITY PRIMARY KEY,
	trgName nvarchar(50) NOT NULL,
	typeID int FOREIGN KEY REFERENCES type_list(typeID) NOT NULL,
	sectionID int FOREIGN KEY REFERENCES sec_list(secID) NOT NULL,
	difficulty int,
	intention nvarchar(500) NOT NULL,
	privacy int,
	genkiBar int,
	achID int FOREIGN KEY REFERENCES achievement(achID),
	priority int,
	remindTimes int,
	challenge bit,
	punishment int,
	status int,
	timeStart datetime2 NOT NULL,
	timeFinish datetime2 NOT NULL,
	doneTime datetime2
);


CREATE TABLE misbehave(
	behaveID int IDENTITY PRIMARY KEY,
	reporter int FOREIGN KEY REFERENCES user_spec(userID) NOT NULL,
	defendant int  FOREIGN KEY REFERENCES user_spec(userID) NOT NULL,
	targetID int FOREIGN KEY REFERENCES target(targetID) NOT NULL,
	reason nvarchar(200) NOT NULL,
	reportTime datetime2 NOT NULL,
	result int
);

CREATE TABLE target_list(
	userID int FOREIGN KEY REFERENCES user_spec(userID),
	targetID int FOREIGN KEY REFERENCES target(targetID),
	PRIMARY KEY (userID,targetID)
);

CREATE TABLE target_spec(
	trgSpecID int IDENTITY PRIMARY KEY,
	userID int FOREIGN KEY REFERENCES user_spec(userID),
	targetID int FOREIGN KEY REFERENCES target(targetID),
	trgNote nvarchar(max),
	trgPic varbinary(max),
);

INSERT INTO user_spec values ('b0001' , '12345' , '王' , '小明' , 'M' , '1999-09-09' , 'b0001@yahoo.com.tw' , '台北市' , '0919255444' , 0 , 0 , null , SYSDATETIME() , 'false' , null);
INSERT INTO user_spec values ('batman' , '54321' , '蝙' , '蝠俠' , 'F' , '1922-07-09' , 'batman@gmail.com' , '南極洲' , '0919247944' , 0 , 0 , null , SYSDATETIME() , 'false' , null);
INSERT INTO user_spec values ('superman' , '123faefe5' , '超' , '人' , 'M' , '1966-06-06' , 'superman@gmail.com' , '電話亭' , '+886944255888' , 0 , 0 , null , SYSDATETIME() , 'false' , null);
INSERT INTO user_spec values ('curry' , '3333333' , 'Curry' , 'Stephen' , 'M' , '1988-3-14' , 'curry@gmail.com.tw' , '美國' , '347-555-5555' , 0 , 0 , null , '2015-6-12' , 'true' , null);
INSERT INTO user_spec values ('kevin' , '543f1321' , '陳' , '肥宅' , 'F' , '1992-08-09' , 'otaku@gmail.com' , '家' , '(02)2744-0876' , 0 , 0 , null , SYSDATETIME() , 'false' , null);
INSERT INTO user_spec values ('kai' , 'efnlla' , 'カシワ' , 'カイ' , 'M' , '1991-09-11' , 'justdoyouwant@gmail.com' , '北海道文京台' , null, 0 , 0 , null , SYSDATETIME() , 'false' , null);
INSERT INTO user_spec values ('longbi' , '123f45' , '吴' , '小陆' , 'M' , '1999-09-09' , 'b0001@yahoo.com.tw' , '台北市' , '+8613711122233' , 0 , 0 , null , SYSDATETIME() , 'false' , null);
insert into user_spec values ('akyo01','123456','Apple','Yang','F','1992-04-14','akyo01@gmail.com','台北市大安區復興南路120號','0988032290',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo02','123456','Banana','Yang','F','1992-04-14','akyo02@gmail.com','台北市大安區復興南路121號','0988032291',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo03','123456','Cat','Yang','F','1992-04-14','akyo03@gmail.com','台北市大安區復興南路122號','0988032292',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo04','123456','Dog','Yang','M','1992-04-14','akyo04@gmail.com','台北市大安區復興南路123號','0988032293',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo05','123456','Ezreal','Yang','M','1992-04-14','akyo05@gmail.com','台北市大安區復興南路124號','0988032294',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo06','123456','Fox','Yang','M','1992-04-14','akyo06@gmail.com','台北市大安區復興南路125號','0988032295',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo07','123456','Green','Yang','M','1992-04-14','akyo07@gmail.com','台北市大安區復興南路126號','0988032296',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo08','123456','Handsome','Yang','M','1992-04-14','akyo08@gmail.com','台北市大安區復興南路127號','0988032297',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo09','123456','Image','Yang','F','1992-04-14','akyo09@gmail.com','台北市大安區復興南路128號','0988032298',0,0,NULL,getdate(),0,0)
insert into user_spec values ('akyo10','123456','Joker','Yang','M','1992-04-14','akyo10@gmail.com','台北市大安區復興南路129號','0988032299',0,0,NULL,getdate(),0,0)

insert into  user_spec(account,pswd,lastName,firstName,gender,email,regTime)
values('ChenWuKing','sa123456','金','城武',1,'chenwuking@gmail.com', '2016-4-27 11:43:30')
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email,regTime)
values('sunny0601','sunny0601','劉','小菁',1,'1979-06-01','sunny0601@gmail.com', '2016-4-27 11:46:30')
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, regTime)
values('js1','22222333','王','小明',1,'1999-01-01','john0101@yahoo.com.tw', '台北市中山北路七段3號2樓','0970295335', '2016-4-27 11:47:30')
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, regTime)
values('jasonpain','pan0147','潘','王子',1,'1978-05-17','pan0517@yahoo.com.tw', '台南市中興路37號1樓','0985953512', 5 ,'2016-4-27 11:47:30')
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, level, regTime)
values('marry01','m5566','馬','小莉',1,'1988-12-7','marryship@yahoo.com.tw', '221-04 58th Ave, Bayside NY11364','718-631-8881', 5 , 1, '2016-4-27 11:53:30')
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, level, picture, regTime)
values('ferry0678','m5566','法','拉瑞',1,'1998-1-5','ferrycar@yahoo.com.tw', '143-75 Ave, Flushing NY11364','718-631-8881', 5 , 1, 0xFFD8FFE000104A46494600010100000100010000FFFE003B43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D2037350AFFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC00011080050004003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28AE57C49A86A37DABDB785F459DADAE678BED17D7AA993696D9DA3693C798E410BD71B58E381401ADA8F89741D1E7106A7ADE9B65311B847737491B11EB8620D528FC75E169A32F0EBB6736390913EF76FA28E4FE03D3D455AD17C31A3F87D58E9F631A4F264CD74FF3CF3124926491B2CE4924F26AE6A235036BFF0012C6B55B8C8FF8F9562847A7CA4107DE8039586FBC59AD4D750592DA47A7CD90B797FA5CB0184631B042F26F98F4F99844A39237E76834DF0A78B34CB65853C72F2A4402C31CBA5C4635503A1C10C467A7CDC0C0F7ADF64F10C7A402936973EA6AFB883149142EB9FBBF79994E3F8BE6FF0076A4D2AF352B9F363D4F49FB0CB191878EE1668A5CE7EE370DC639DC8BD4633CE0029DBEAD7F617B0586BB0C20CEDB20BFB5522095FB232924C4E7B02594E386C90B5BD55752B08754D3A7B19CB88E64DBBA33B5D0F6653D994E083D4100F6AA9E1CD426D4F43827B9DBF6A4692DEE4A8C299A2768A42BFECEF46C7B6280356B90F0462E6FFC55A84CA9F6C97599609080372C712AA44A4E3A6D1B80FF006CFA9AEBEB8EBC9DFC21E28BDD4E78E77D07555596EA68D77AD8DC22052EE00C88DD15016E4298F2701B200287C55B2F1C6A1A5D841E0D675065637BE45CAC1395E36EC762001F7B3CE7EEF6CD4FF0BAC3C67A77876587C6771E6DC79B9B7124C2595131821DC641E464724F2735D9DB5D5BDEDB47736B3C53DBCAA1A396270C8E0F4208E08ACD4F105A4DADC3A7C3246EB25ACB71E6EEE3F7722C657EA0939F42293692BB03628AE5ED7C696125B5B5C4D3C4BF6E7125AC59C32DBB1DB1BB7524BE32AB804960B8F958D696B3A94907866F2FAC81173E4B0B559A3642D31F96352AC33CB9518C77A134D5D0195E25F881A378717C82ED79A9CAEB0DAD841CC9712B3150ABDB018105BA0231D78AE6FE1DF8BE3D7F5E92F20B65B2835A8A59E5B466CB457501895981C0C8786580FF00C009C7249F03D7EEE5D5BC7FA9B59EA314304466B5B595E4247D9A35287963D4C7B989272CC4E3E66AF56F843697136A1A0DDBDDC6E1D753BA4D88232D00FB2DBA651785198CE3FDDF6A607BA330452CC405032493C0151C17115CC7E642C593380DB480DEE09EA3DC71597697116BF3CF22B87B0B59DEDFCB23FD64D1B6D72C0F6560401D0904F3F29A6DBEA7F6EF175F69AA5D134C821918671E63CBBF07DC284C0EC4B1E32A0D0053D5BC35A258D95F6A7696A34FB88E3927792CAE24B3591802D993CAFBDCF7657FA1E95C9681E1F122DF2EA7AB7DBDC35C136C8FFBD852E7E79A290854FBCE0381E5C6CA47A1C5749E37D463B4B9D1ACF51BBBAB1D1EFA768AE2E6D6428ED2801A284B29DEAAF87C94E728172031CDB6F0C47A6691A45AE911A6349CEC47037CE9E5B295DFC6092C1C9C72579C6723CECCF0D571141C694ACD6BEBE57E8541A4F539EB95FB35D6937DA4E94D0DC47758DB716C55263E4989448EA19E33B588590A903695380C336EEF55D43C4B05DDB4100B4BCD3A6B7BB3A4CC07DA2711CA928224DDB36B946504646704B29DCA1D16B9A9CCF3A2783BC43981B6B175B6407BFCA5A71B87D3353F86A3B8D6F58B4F149B236565FD9CF0DB09991A69D6668A4DE76160AA046303249DED90B8E7CCC9DE3A94951AB4ED0D757D0A9F2BD4F05B0F86570FE20B8B56D4EE6E74D62237B7B4B498DE491060CB1BA320585BE54C990AA8E08DC2BE82F05F8727D1E096F2FADEDADAEE78E3822B4B625A3B2B68F3E5C21CF2E4167667E32CC7B015B777AB5BD8EA36B6772B2462EB2B14E47EE8BF188CB678639E01EB838E78ABF5F48664515B4103CCF14491B4CFE64A54637B600C9F5380067D8520B4816F1AF044A2E1E311348382C8092A0FAE0B3633D371C75352D1401C37885A39F58B9B5D59751B22F736634BD4A080CB121F3232A09C30563370C1800CBB3AE3875E5FEBBE1ABBBCD445DB788B4F8533A8D9C6123B8B36037878946032942328C41E03024920DEF88D04537826EA4B98649AD6DA6B7BAB98E36219A18A647971823A22B1EBDAADD9F85BC3C6E23D520B65B892548DBED0F70F379C14EE8D98B31F30AF0559B247182302802BA78DA09D105AE83E2296E5FEEC0FA54B0F3E85E50B18FA96C71597E05D596DB5BD73C1F2109FD993B496285B2CB6CCC709F44CAE3D1248C57755E5BE32369E16F8A7E1AF10A5C5CB497ED35B4DA6DB45BDEE098B6871CF5CAC0A474F954F183900ED25D124B8D33C416D326E4BF9647862321F9331AA820FF0E5D4BF1D0B67AD6EA0608A18E5B1C9F535916FE2AD0E7992DCEA315BDCC8DB52DAF01B6998E70311C8158E7B1C73DAB62800A5A2B9BF1A3CE34BB48FECD7F3D84B7891EA02C159A658086E5427CE46F1186DB93B0B605004F378BB488EF25B481EEAF6785CC72AD8D9CB70B1B83828EE8A51587756208E3D45739A6DA7F60EB5A77F6441ACE99A4DCDC39BAD3EE515AD218CC533EF43F3793FBDF2C6D0CA3E6FBBE95351F187D9A0D334CB05B8F0F69B2DDB4736A126912DBC3636CA0EC50664118690800120850C7824026DD81F87D751CB72D1E97AA4D1DC0823B9BA9A3BDB99D89080EE72CC016C819214019185A00E9975E8A7F13D96996B2DB4F04F657170F2472066568DE1503838C112B7E42A8BE9767A87C40BF96EAD22796DF4CB436F70176CD11692E43EC9061D72000403D0FB9CD8FF008A43C3D73F6EFF00891E993C9198FED1FB985990104AEEE091C038F61599AAEBFE01D6658D2E2E74ED5EE94158858C66F2E23CF529E486743D0E46304039E2803A13A159313BDAEE452412925ECCEAD8EC54BE08F50460F7AD2ACAF0E4D7971A0DB497E93ACDF3806E1024AF187223775006D7640AC57030588C0C606AD007FFD9, '2016-4-27 11:53:30')
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, level, picture, regTime, hotMan)
values('parry','999p','Maxwell','Parry',0,'1958-2-17','parryman@yahoo.com', '1st Ave, Bayside NY11364','718-631-8881', 5 , 1, 0xFFD8FFE000104A46494600010100000100010000FFFE003B43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D2037350AFFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC00011080050004003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28AE57C49A86A37DABDB785F459DADAE678BED17D7AA993696D9DA3693C798E410BD71B58E381401ADA8F89741D1E7106A7ADE9B65311B847737491B11EB8620D528FC75E169A32F0EBB6736390913EF76FA28E4FE03D3D455AD17C31A3F87D58E9F631A4F264CD74FF3CF3124926491B2CE4924F26AE6A235036BFF0012C6B55B8C8FF8F9562847A7CA4107DE8039586FBC59AD4D750592DA47A7CD90B797FA5CB0184631B042F26F98F4F99844A39237E76834DF0A78B34CB65853C72F2A4402C31CBA5C4635503A1C10C467A7CDC0C0F7ADF64F10C7A402936973EA6AFB883149142EB9FBBF79994E3F8BE6FF0076A4D2AF352B9F363D4F49FB0CB191878EE1668A5CE7EE370DC639DC8BD4633CE0029DBEAD7F617B0586BB0C20CEDB20BFB5522095FB232924C4E7B02594E386C90B5BD55752B08754D3A7B19CB88E64DBBA33B5D0F6653D994E083D4100F6AA9E1CD426D4F43827B9DBF6A4692DEE4A8C299A2768A42BFECEF46C7B6280356B90F0462E6FFC55A84CA9F6C97599609080372C712AA44A4E3A6D1B80FF006CFA9AEBEB8EBC9DFC21E28BDD4E78E77D07555596EA68D77AD8DC22052EE00C88DD15016E4298F2701B200287C55B2F1C6A1A5D841E0D675065637BE45CAC1395E36EC762001F7B3CE7EEF6CD4FF0BAC3C67A77876587C6771E6DC79B9B7124C2595131821DC641E464724F2735D9DB5D5BDEDB47736B3C53DBCAA1A396270C8E0F4208E08ACD4F105A4DADC3A7C3246EB25ACB71E6EEE3F7722C657EA0939F42293692BB03628AE5ED7C696125B5B5C4D3C4BF6E7125AC59C32DBB1DB1BB7524BE32AB804960B8F958D696B3A94907866F2FAC81173E4B0B559A3642D31F96352AC33CB9518C77A134D5D0195E25F881A378717C82ED79A9CAEB0DAD841CC9712B3150ABDB018105BA0231D78AE6FE1DF8BE3D7F5E92F20B65B2835A8A59E5B466CB457501895981C0C8786580FF00C009C7249F03D7EEE5D5BC7FA9B59EA314304466B5B595E4247D9A35287963D4C7B989272CC4E3E66AF56F843697136A1A0DDBDDC6E1D753BA4D88232D00FB2DBA651785198CE3FDDF6A607BA330452CC405032493C0151C17115CC7E642C593380DB480DEE09EA3DC71597697116BF3CF22B87B0B59DEDFCB23FD64D1B6D72C0F6560401D0904F3F29A6DBEA7F6EF175F69AA5D134C821918671E63CBBF07DC284C0EC4B1E32A0D0053D5BC35A258D95F6A7696A34FB88E3927792CAE24B3591802D993CAFBDCF7657FA1E95C9681E1F122DF2EA7AB7DBDC35C136C8FFBD852E7E79A290854FBCE0381E5C6CA47A1C5749E37D463B4B9D1ACF51BBBAB1D1EFA768AE2E6D6428ED2801A284B29DEAAF87C94E728172031CDB6F0C47A6691A45AE911A6349CEC47037CE9E5B295DFC6092C1C9C72579C6723CECCF0D571141C694ACD6BEBE57E8541A4F539EB95FB35D6937DA4E94D0DC47758DB716C55263E4989448EA19E33B588590A903695380C336EEF55D43C4B05DDB4100B4BCD3A6B7BB3A4CC07DA2711CA928224DDB36B946504646704B29DCA1D16B9A9CCF3A2783BC43981B6B175B6407BFCA5A71B87D3353F86A3B8D6F58B4F149B236565FD9CF0DB09991A69D6668A4DE76160AA046303249DED90B8E7CCC9DE3A94951AB4ED0D757D0A9F2BD4F05B0F86570FE20B8B56D4EE6E74D62237B7B4B498DE491060CB1BA320585BE54C990AA8E08DC2BE82F05F8727D1E096F2FADEDADAEE78E3822B4B625A3B2B68F3E5C21CF2E4167667E32CC7B015B777AB5BD8EA36B6772B2462EB2B14E47EE8BF188CB678639E01EB838E78ABF5F48664515B4103CCF14491B4CFE64A54637B600C9F5380067D8520B4816F1AF044A2E1E311348382C8092A0FAE0B3633D371C75352D1401C37885A39F58B9B5D59751B22F736634BD4A080CB121F3232A09C30563370C1800CBB3AE3875E5FEBBE1ABBBCD445DB788B4F8533A8D9C6123B8B36037878946032942328C41E03024920DEF88D04537826EA4B98649AD6DA6B7BAB98E36219A18A647971823A22B1EBDAADD9F85BC3C6E23D520B65B892548DBED0F70F379C14EE8D98B31F30AF0559B247182302802BA78DA09D105AE83E2296E5FEEC0FA54B0F3E85E50B18FA96C71597E05D596DB5BD73C1F2109FD993B496285B2CB6CCC709F44CAE3D1248C57755E5BE32369E16F8A7E1AF10A5C5CB497ED35B4DA6DB45BDEE098B6871CF5CAC0A474F954F183900ED25D124B8D33C416D326E4BF9647862321F9331AA820FF0E5D4BF1D0B67AD6EA0608A18E5B1C9F535916FE2AD0E7992DCEA315BDCC8DB52DAF01B6998E70311C8158E7B1C73DAB62800A5A2B9BF1A3CE34BB48FECD7F3D84B7891EA02C159A658086E5427CE46F1186DB93B0B605004F378BB488EF25B481EEAF6785CC72AD8D9CB70B1B83828EE8A51587756208E3D45739A6DA7F60EB5A77F6441ACE99A4DCDC39BAD3EE515AD218CC533EF43F3793FBDF2C6D0CA3E6FBBE95351F187D9A0D334CB05B8F0F69B2DDB4736A126912DBC3636CA0EC50664118690800120850C7824026DD81F87D751CB72D1E97AA4D1DC0823B9BA9A3BDB99D89080EE72CC016C819214019185A00E9975E8A7F13D96996B2DB4F04F657170F2472066568DE1503838C112B7E42A8BE9767A87C40BF96EAD22796DF4CB436F70176CD11692E43EC9061D72000403D0FB9CD8FF008A43C3D73F6EFF00891E993C9198FED1FB985990104AEEE091C038F61599AAEBFE01D6658D2E2E74ED5EE94158858C66F2E23CF529E486743D0E46304039E2803A13A159313BDAEE452412925ECCEAD8EC54BE08F50460F7AD2ACAF0E4D7971A0DB497E93ACDF3806E1024AF187223775006D7640AC57030588C0C606AD007FFD9, '2016-4-27 11:53:30' , 0)
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, level, picture, regTime, hotMan, suspendType)
values('badhuy','fxckLifeEditor','壞','人',0,'1970-1-1','badguy@yahoo.com', '綠島海邊路1號','0978978978', 5 , 1, 0xFFD8FFE000104A46494600010100000100010000FFFE003B43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D2037350AFFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC00011080050004003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28AE57C49A86A37DABDB785F459DADAE678BED17D7AA993696D9DA3693C798E410BD71B58E381401ADA8F89741D1E7106A7ADE9B65311B847737491B11EB8620D528FC75E169A32F0EBB6736390913EF76FA28E4FE03D3D455AD17C31A3F87D58E9F631A4F264CD74FF3CF3124926491B2CE4924F26AE6A235036BFF0012C6B55B8C8FF8F9562847A7CA4107DE8039586FBC59AD4D750592DA47A7CD90B797FA5CB0184631B042F26F98F4F99844A39237E76834DF0A78B34CB65853C72F2A4402C31CBA5C4635503A1C10C467A7CDC0C0F7ADF64F10C7A402936973EA6AFB883149142EB9FBBF79994E3F8BE6FF0076A4D2AF352B9F363D4F49FB0CB191878EE1668A5CE7EE370DC639DC8BD4633CE0029DBEAD7F617B0586BB0C20CEDB20BFB5522095FB232924C4E7B02594E386C90B5BD55752B08754D3A7B19CB88E64DBBA33B5D0F6653D994E083D4100F6AA9E1CD426D4F43827B9DBF6A4692DEE4A8C299A2768A42BFECEF46C7B6280356B90F0462E6FFC55A84CA9F6C97599609080372C712AA44A4E3A6D1B80FF006CFA9AEBEB8EBC9DFC21E28BDD4E78E77D07555596EA68D77AD8DC22052EE00C88DD15016E4298F2701B200287C55B2F1C6A1A5D841E0D675065637BE45CAC1395E36EC762001F7B3CE7EEF6CD4FF0BAC3C67A77876587C6771E6DC79B9B7124C2595131821DC641E464724F2735D9DB5D5BDEDB47736B3C53DBCAA1A396270C8E0F4208E08ACD4F105A4DADC3A7C3246EB25ACB71E6EEE3F7722C657EA0939F42293692BB03628AE5ED7C696125B5B5C4D3C4BF6E7125AC59C32DBB1DB1BB7524BE32AB804960B8F958D696B3A94907866F2FAC81173E4B0B559A3642D31F96352AC33CB9518C77A134D5D0195E25F881A378717C82ED79A9CAEB0DAD841CC9712B3150ABDB018105BA0231D78AE6FE1DF8BE3D7F5E92F20B65B2835A8A59E5B466CB457501895981C0C8786580FF00C009C7249F03D7EEE5D5BC7FA9B59EA314304466B5B595E4247D9A35287963D4C7B989272CC4E3E66AF56F843697136A1A0DDBDDC6E1D753BA4D88232D00FB2DBA651785198CE3FDDF6A607BA330452CC405032493C0151C17115CC7E642C593380DB480DEE09EA3DC71597697116BF3CF22B87B0B59DEDFCB23FD64D1B6D72C0F6560401D0904F3F29A6DBEA7F6EF175F69AA5D134C821918671E63CBBF07DC284C0EC4B1E32A0D0053D5BC35A258D95F6A7696A34FB88E3927792CAE24B3591802D993CAFBDCF7657FA1E95C9681E1F122DF2EA7AB7DBDC35C136C8FFBD852E7E79A290854FBCE0381E5C6CA47A1C5749E37D463B4B9D1ACF51BBBAB1D1EFA768AE2E6D6428ED2801A284B29DEAAF87C94E728172031CDB6F0C47A6691A45AE911A6349CEC47037CE9E5B295DFC6092C1C9C72579C6723CECCF0D571141C694ACD6BEBE57E8541A4F539EB95FB35D6937DA4E94D0DC47758DB716C55263E4989448EA19E33B588590A903695380C336EEF55D43C4B05DDB4100B4BCD3A6B7BB3A4CC07DA2711CA928224DDB36B946504646704B29DCA1D16B9A9CCF3A2783BC43981B6B175B6407BFCA5A71B87D3353F86A3B8D6F58B4F149B236565FD9CF0DB09991A69D6668A4DE76160AA046303249DED90B8E7CCC9DE3A94951AB4ED0D757D0A9F2BD4F05B0F86570FE20B8B56D4EE6E74D62237B7B4B498DE491060CB1BA320585BE54C990AA8E08DC2BE82F05F8727D1E096F2FADEDADAEE78E3822B4B625A3B2B68F3E5C21CF2E4167667E32CC7B015B777AB5BD8EA36B6772B2462EB2B14E47EE8BF188CB678639E01EB838E78ABF5F48664515B4103CCF14491B4CFE64A54637B600C9F5380067D8520B4816F1AF044A2E1E311348382C8092A0FAE0B3633D371C75352D1401C37885A39F58B9B5D59751B22F736634BD4A080CB121F3232A09C30563370C1800CBB3AE3875E5FEBBE1ABBBCD445DB788B4F8533A8D9C6123B8B36037878946032942328C41E03024920DEF88D04537826EA4B98649AD6DA6B7BAB98E36219A18A647971823A22B1EBDAADD9F85BC3C6E23D520B65B892548DBED0F70F379C14EE8D98B31F30AF0559B247182302802BA78DA09D105AE83E2296E5FEEC0FA54B0F3E85E50B18FA96C71597E05D596DB5BD73C1F2109FD993B496285B2CB6CCC709F44CAE3D1248C57755E5BE32369E16F8A7E1AF10A5C5CB497ED35B4DA6DB45BDEE098B6871CF5CAC0A474F954F183900ED25D124B8D33C416D326E4BF9647862321F9331AA820FF0E5D4BF1D0B67AD6EA0608A18E5B1C9F535916FE2AD0E7992DCEA315BDCC8DB52DAF01B6998E70311C8158E7B1C73DAB62800A5A2B9BF1A3CE34BB48FECD7F3D84B7891EA02C159A658086E5427CE46F1186DB93B0B605004F378BB488EF25B481EEAF6785CC72AD8D9CB70B1B83828EE8A51587756208E3D45739A6DA7F60EB5A77F6441ACE99A4DCDC39BAD3EE515AD218CC533EF43F3793FBDF2C6D0CA3E6FBBE95351F187D9A0D334CB05B8F0F69B2DDB4736A126912DBC3636CA0EC50664118690800120850C7824026DD81F87D751CB72D1E97AA4D1DC0823B9BA9A3BDB99D89080EE72CC016C819214019185A00E9975E8A7F13D96996B2DB4F04F657170F2472066568DE1503838C112B7E42A8BE9767A87C40BF96EAD22796DF4CB436F70176CD11692E43EC9061D72000403D0FB9CD8FF008A43C3D73F6EFF00891E993C9198FED1FB985990104AEEE091C038F61599AAEBFE01D6658D2E2E74ED5EE94158858C66F2E23CF529E486743D0E46304039E2803A13A159313BDAEE452412925ECCEAD8EC54BE08F50460F7AD2ACAF0E4D7971A0DB497E93ACDF3806E1024AF187223775006D7640AC57030588C0C606AD007FFD9, '2016-4-26 23:53:30' , 0, 3)
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, level, picture, regTime, hotMan, suspendType)
values('帳號可以大中文嗎?','wowitcould','好奇','寶寶',0,'1999-09-19','test@yahoo.com', '我地址不照格是寫會怎麼樣?','99999999999', 5 , 1, 0xFFD8FFE000104A46494600010100000100010000FFFE003B43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D2037350AFFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC00011080050004003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28AE57C49A86A37DABDB785F459DADAE678BED17D7AA993696D9DA3693C798E410BD71B58E381401ADA8F89741D1E7106A7ADE9B65311B847737491B11EB8620D528FC75E169A32F0EBB6736390913EF76FA28E4FE03D3D455AD17C31A3F87D58E9F631A4F264CD74FF3CF3124926491B2CE4924F26AE6A235036BFF0012C6B55B8C8FF8F9562847A7CA4107DE8039586FBC59AD4D750592DA47A7CD90B797FA5CB0184631B042F26F98F4F99844A39237E76834DF0A78B34CB65853C72F2A4402C31CBA5C4635503A1C10C467A7CDC0C0F7ADF64F10C7A402936973EA6AFB883149142EB9FBBF79994E3F8BE6FF0076A4D2AF352B9F363D4F49FB0CB191878EE1668A5CE7EE370DC639DC8BD4633CE0029DBEAD7F617B0586BB0C20CEDB20BFB5522095FB232924C4E7B02594E386C90B5BD55752B08754D3A7B19CB88E64DBBA33B5D0F6653D994E083D4100F6AA9E1CD426D4F43827B9DBF6A4692DEE4A8C299A2768A42BFECEF46C7B6280356B90F0462E6FFC55A84CA9F6C97599609080372C712AA44A4E3A6D1B80FF006CFA9AEBEB8EBC9DFC21E28BDD4E78E77D07555596EA68D77AD8DC22052EE00C88DD15016E4298F2701B200287C55B2F1C6A1A5D841E0D675065637BE45CAC1395E36EC762001F7B3CE7EEF6CD4FF0BAC3C67A77876587C6771E6DC79B9B7124C2595131821DC641E464724F2735D9DB5D5BDEDB47736B3C53DBCAA1A396270C8E0F4208E08ACD4F105A4DADC3A7C3246EB25ACB71E6EEE3F7722C657EA0939F42293692BB03628AE5ED7C696125B5B5C4D3C4BF6E7125AC59C32DBB1DB1BB7524BE32AB804960B8F958D696B3A94907866F2FAC81173E4B0B559A3642D31F96352AC33CB9518C77A134D5D0195E25F881A378717C82ED79A9CAEB0DAD841CC9712B3150ABDB018105BA0231D78AE6FE1DF8BE3D7F5E92F20B65B2835A8A59E5B466CB457501895981C0C8786580FF00C009C7249F03D7EEE5D5BC7FA9B59EA314304466B5B595E4247D9A35287963D4C7B989272CC4E3E66AF56F843697136A1A0DDBDDC6E1D753BA4D88232D00FB2DBA651785198CE3FDDF6A607BA330452CC405032493C0151C17115CC7E642C593380DB480DEE09EA3DC71597697116BF3CF22B87B0B59DEDFCB23FD64D1B6D72C0F6560401D0904F3F29A6DBEA7F6EF175F69AA5D134C821918671E63CBBF07DC284C0EC4B1E32A0D0053D5BC35A258D95F6A7696A34FB88E3927792CAE24B3591802D993CAFBDCF7657FA1E95C9681E1F122DF2EA7AB7DBDC35C136C8FFBD852E7E79A290854FBCE0381E5C6CA47A1C5749E37D463B4B9D1ACF51BBBAB1D1EFA768AE2E6D6428ED2801A284B29DEAAF87C94E728172031CDB6F0C47A6691A45AE911A6349CEC47037CE9E5B295DFC6092C1C9C72579C6723CECCF0D571141C694ACD6BEBE57E8541A4F539EB95FB35D6937DA4E94D0DC47758DB716C55263E4989448EA19E33B588590A903695380C336EEF55D43C4B05DDB4100B4BCD3A6B7BB3A4CC07DA2711CA928224DDB36B946504646704B29DCA1D16B9A9CCF3A2783BC43981B6B175B6407BFCA5A71B87D3353F86A3B8D6F58B4F149B236565FD9CF0DB09991A69D6668A4DE76160AA046303249DED90B8E7CCC9DE3A94951AB4ED0D757D0A9F2BD4F05B0F86570FE20B8B56D4EE6E74D62237B7B4B498DE491060CB1BA320585BE54C990AA8E08DC2BE82F05F8727D1E096F2FADEDADAEE78E3822B4B625A3B2B68F3E5C21CF2E4167667E32CC7B015B777AB5BD8EA36B6772B2462EB2B14E47EE8BF188CB678639E01EB838E78ABF5F48664515B4103CCF14491B4CFE64A54637B600C9F5380067D8520B4816F1AF044A2E1E311348382C8092A0FAE0B3633D371C75352D1401C37885A39F58B9B5D59751B22F736634BD4A080CB121F3232A09C30563370C1800CBB3AE3875E5FEBBE1ABBBCD445DB788B4F8533A8D9C6123B8B36037878946032942328C41E03024920DEF88D04537826EA4B98649AD6DA6B7BAB98E36219A18A647971823A22B1EBDAADD9F85BC3C6E23D520B65B892548DBED0F70F379C14EE8D98B31F30AF0559B247182302802BA78DA09D105AE83E2296E5FEEC0FA54B0F3E85E50B18FA96C71597E05D596DB5BD73C1F2109FD993B496285B2CB6CCC709F44CAE3D1248C57755E5BE32369E16F8A7E1AF10A5C5CB497ED35B4DA6DB45BDEE098B6871CF5CAC0A474F954F183900ED25D124B8D33C416D326E4BF9647862321F9331AA820FF0E5D4BF1D0B67AD6EA0608A18E5B1C9F535916FE2AD0E7992DCEA315BDCC8DB52DAF01B6998E70311C8158E7B1C73DAB62800A5A2B9BF1A3CE34BB48FECD7F3D84B7891EA02C159A658086E5427CE46F1186DB93B0B605004F378BB488EF25B481EEAF6785CC72AD8D9CB70B1B83828EE8A51587756208E3D45739A6DA7F60EB5A77F6441ACE99A4DCDC39BAD3EE515AD218CC533EF43F3793FBDF2C6D0CA3E6FBBE95351F187D9A0D334CB05B8F0F69B2DDB4736A126912DBC3636CA0EC50664118690800120850C7824026DD81F87D751CB72D1E97AA4D1DC0823B9BA9A3BDB99D89080EE72CC016C819214019185A00E9975E8A7F13D96996B2DB4F04F657170F2472066568DE1503838C112B7E42A8BE9767A87C40BF96EAD22796DF4CB436F70176CD11692E43EC9061D72000403D0FB9CD8FF008A43C3D73F6EFF00891E993C9198FED1FB985990104AEEE091C038F61599AAEBFE01D6658D2E2E74ED5EE94158858C66F2E23CF529E486743D0E46304039E2803A13A159313BDAEE452412925ECCEAD8EC54BE08F50460F7AD2ACAF0E4D7971A0DB497E93ACDF3806E1024AF187223775006D7640AC57030588C0C606AD007FFD9, '2006-4-26 23:59:59' , 0, 2)
insert into  user_spec(account,pswd,lastName,firstName,gender, birthdate,  email, address, phone, genkiBarTol, level, picture, regTime, hotMan, suspendType)
values('happy','abcdefgh123','郝','快樂',0,'1985-8-9','happy@yahoo.com', '高雄市前鎮區福興路1段九號18樓','09976138756', 5 , 1, 0xFFD8FFE000104A46494600010100000100010000FFFE003B43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D2037350AFFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC00011080050004003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28AE57C49A86A37DABDB785F459DADAE678BED17D7AA993696D9DA3693C798E410BD71B58E381401ADA8F89741D1E7106A7ADE9B65311B847737491B11EB8620D528FC75E169A32F0EBB6736390913EF76FA28E4FE03D3D455AD17C31A3F87D58E9F631A4F264CD74FF3CF3124926491B2CE4924F26AE6A235036BFF0012C6B55B8C8FF8F9562847A7CA4107DE8039586FBC59AD4D750592DA47A7CD90B797FA5CB0184631B042F26F98F4F99844A39237E76834DF0A78B34CB65853C72F2A4402C31CBA5C4635503A1C10C467A7CDC0C0F7ADF64F10C7A402936973EA6AFB883149142EB9FBBF79994E3F8BE6FF0076A4D2AF352B9F363D4F49FB0CB191878EE1668A5CE7EE370DC639DC8BD4633CE0029DBEAD7F617B0586BB0C20CEDB20BFB5522095FB232924C4E7B02594E386C90B5BD55752B08754D3A7B19CB88E64DBBA33B5D0F6653D994E083D4100F6AA9E1CD426D4F43827B9DBF6A4692DEE4A8C299A2768A42BFECEF46C7B6280356B90F0462E6FFC55A84CA9F6C97599609080372C712AA44A4E3A6D1B80FF006CFA9AEBEB8EBC9DFC21E28BDD4E78E77D07555596EA68D77AD8DC22052EE00C88DD15016E4298F2701B200287C55B2F1C6A1A5D841E0D675065637BE45CAC1395E36EC762001F7B3CE7EEF6CD4FF0BAC3C67A77876587C6771E6DC79B9B7124C2595131821DC641E464724F2735D9DB5D5BDEDB47736B3C53DBCAA1A396270C8E0F4208E08ACD4F105A4DADC3A7C3246EB25ACB71E6EEE3F7722C657EA0939F42293692BB03628AE5ED7C696125B5B5C4D3C4BF6E7125AC59C32DBB1DB1BB7524BE32AB804960B8F958D696B3A94907866F2FAC81173E4B0B559A3642D31F96352AC33CB9518C77A134D5D0195E25F881A378717C82ED79A9CAEB0DAD841CC9712B3150ABDB018105BA0231D78AE6FE1DF8BE3D7F5E92F20B65B2835A8A59E5B466CB457501895981C0C8786580FF00C009C7249F03D7EEE5D5BC7FA9B59EA314304466B5B595E4247D9A35287963D4C7B989272CC4E3E66AF56F843697136A1A0DDBDDC6E1D753BA4D88232D00FB2DBA651785198CE3FDDF6A607BA330452CC405032493C0151C17115CC7E642C593380DB480DEE09EA3DC71597697116BF3CF22B87B0B59DEDFCB23FD64D1B6D72C0F6560401D0904F3F29A6DBEA7F6EF175F69AA5D134C821918671E63CBBF07DC284C0EC4B1E32A0D0053D5BC35A258D95F6A7696A34FB88E3927792CAE24B3591802D993CAFBDCF7657FA1E95C9681E1F122DF2EA7AB7DBDC35C136C8FFBD852E7E79A290854FBCE0381E5C6CA47A1C5749E37D463B4B9D1ACF51BBBAB1D1EFA768AE2E6D6428ED2801A284B29DEAAF87C94E728172031CDB6F0C47A6691A45AE911A6349CEC47037CE9E5B295DFC6092C1C9C72579C6723CECCF0D571141C694ACD6BEBE57E8541A4F539EB95FB35D6937DA4E94D0DC47758DB716C55263E4989448EA19E33B588590A903695380C336EEF55D43C4B05DDB4100B4BCD3A6B7BB3A4CC07DA2711CA928224DDB36B946504646704B29DCA1D16B9A9CCF3A2783BC43981B6B175B6407BFCA5A71B87D3353F86A3B8D6F58B4F149B236565FD9CF0DB09991A69D6668A4DE76160AA046303249DED90B8E7CCC9DE3A94951AB4ED0D757D0A9F2BD4F05B0F86570FE20B8B56D4EE6E74D62237B7B4B498DE491060CB1BA320585BE54C990AA8E08DC2BE82F05F8727D1E096F2FADEDADAEE78E3822B4B625A3B2B68F3E5C21CF2E4167667E32CC7B015B777AB5BD8EA36B6772B2462EB2B14E47EE8BF188CB678639E01EB838E78ABF5F48664515B4103CCF14491B4CFE64A54637B600C9F5380067D8520B4816F1AF044A2E1E311348382C8092A0FAE0B3633D371C75352D1401C37885A39F58B9B5D59751B22F736634BD4A080CB121F3232A09C30563370C1800CBB3AE3875E5FEBBE1ABBBCD445DB788B4F8533A8D9C6123B8B36037878946032942328C41E03024920DEF88D04537826EA4B98649AD6DA6B7BAB98E36219A18A647971823A22B1EBDAADD9F85BC3C6E23D520B65B892548DBED0F70F379C14EE8D98B31F30AF0559B247182302802BA78DA09D105AE83E2296E5FEEC0FA54B0F3E85E50B18FA96C71597E05D596DB5BD73C1F2109FD993B496285B2CB6CCC709F44CAE3D1248C57755E5BE32369E16F8A7E1AF10A5C5CB497ED35B4DA6DB45BDEE098B6871CF5CAC0A474F954F183900ED25D124B8D33C416D326E4BF9647862321F9331AA820FF0E5D4BF1D0B67AD6EA0608A18E5B1C9F535916FE2AD0E7992DCEA315BDCC8DB52DAF01B6998E70311C8158E7B1C73DAB62800A5A2B9BF1A3CE34BB48FECD7F3D84B7891EA02C159A658086E5427CE46F1186DB93B0B605004F378BB488EF25B481EEAF6785CC72AD8D9CB70B1B83828EE8A51587756208E3D45739A6DA7F60EB5A77F6441ACE99A4DCDC39BAD3EE515AD218CC533EF43F3793FBDF2C6D0CA3E6FBBE95351F187D9A0D334CB05B8F0F69B2DDB4736A126912DBC3636CA0EC50664118690800120850C7824026DD81F87D751CB72D1E97AA4D1DC0823B9BA9A3BDB99D89080EE72CC016C819214019185A00E9975E8A7F13D96996B2DB4F04F657170F2472066568DE1503838C112B7E42A8BE9767A87C40BF96EAD22796DF4CB436F70176CD11692E43EC9061D72000403D0FB9CD8FF008A43C3D73F6EFF00891E993C9198FED1FB985990104AEEE091C038F61599AAEBFE01D6658D2E2E74ED5EE94158858C66F2E23CF529E486743D0E46304039E2803A13A159313BDAEE452412925ECCEAD8EC54BE08F50460F7AD2ACAF0E4D7971A0DB497E93ACDF3806E1024AF187223775006D7640AC57030588C0C606AD007FFD9, '2016-4-26 12:03:30' , 0, 0)


