
drop database if exists carrierdb;
create database carrierdb;
use carrierdb;

drop table if exists 고객;
create table 고객
(
고객번호 int not null,
성명 varchar(30) not null,
주민번호 varchar(15) not null,
생년월일 date ,
성별 varchar(10),
주소 varchar(50),
연락처 varchar(11) not null,
이메일 varchar(30),
가입일 date,
primary key(고객번호)
);
desc 고객;
select* from 고객;

drop table if exists 납부자;
create table 납부자
(
성명 varchar(30) not null,
은행명 varchar(10),
계좌번호 varchar(10),
관계 varchar(10),
주소 varchar(50),
고객번호 int not null,
 foreign key(고객번호) references 고객(고객번호)
);
desc 납부자;


drop table if exists 결합관계;
create table 결합관계
(
결합고객번호 int not null,

관계 varchar(10), 
할인율 int not null,
고객번호 int not null,
primary key (결합고객번호),
foreign key (고객번호) references 고객(고객번호)
);
desc 결합관계;

drop table if exists 단말기;
create table 단말기
(
단말기번호 int not null,
결제일 date,
합계요금 int,
적용요금 int,
고객번호 int,

primary key(단말기번호),
foreign key(고객번호) references 고객(고객번호)
);
desc 단말기;

drop table if exists 서비스;
create table 서비스
(
서비스명 varchar(30) not null, 
요금 int not null,
제공기간 int not null,
서비스종류 varchar(30),
primary key(서비스명)
);
desc 서비스;

drop table if exists 구매서비스;
create table 구매서비스
(
서비스명 varchar(30) not null,
제공시작일 date,
남은서비스기간 int,
종료일 date,
단말기번호 int not null,
foreign key(서비스명) references 서비스(서비스명),
foreign key(단말기번호) references 단말기(단말기번호)
);
desc 구매서비스;

drop table if exists 기기;
create table 기기
(
기기번호 int not null,
기기종류 varchar(20),
가격 int,
primary key(기기번호)
);
desc 기기;

drop table if exists 스펙;
create table 스펙
(
기기번호 int not null,
중앙처리장치 varchar(20),
메모리 varchar(20),
배터리 varchar(20),
색상 varchar(15),
무게 float,
foreign key(기기번호) references 기기(기기번호)
);
desc 스펙;
drop table if exists 구매기기;
create table 구매기기
(
주문번호 int not null,
구매일자 date,
기기번호 int not null,
단말기번호 int not null,
primary key(주문번호),
foreign key(기기번호) references 기기(기기번호),
foreign key(단말기번호) references 단말기(단말기번호)
);
desc 구매기기;