use carrierdb;
-- 90년도 이후에 태어난 고객의 평균 요금을 구하라.
select avg(단말기.적용요금) as 평균요금 from 고객 inner join 단말기 on 고객.고객번호 = 단말기.고객번호 where year(생년월일)>1990;
-- 이연두 고객의 납부자를 '모'인 박경은으로 바꾸어라.
update 납부자 set 성명 = '박경은' , 관계 = '모' where 납부자.고객번호 =(select 고객번호 from 고객 where 성명 = '이연두');
select * from 납부자;
-- 이나희 고객이 태블리 PC를 구매하였다.
insert into 구매기기(주문번호, 구매일자, 기기번호, 단말기번호)
values(1116,"2021-12-12",1357,6006);

insert into 단말기(단말기번호, 결제일, 합계요금, 적용요금, 고객번호)
values(6006,"2021-11-11",null,null,0001);

update 단말기, 요금표
set 합계요금 = 요금표.sum
where 요금표.단말기번호 = 단말기.단말기번호;

update 단말기, 결합관계 
set 적용요금 =  if (isnull(결합관계.할인율),합계요금 * (1-결합관계.할인율*0.001),합계요금)
where 결합관계.결합고객번호 = 단말기.고객번호;

update 단말기
set 적용요금 =  if (적용요금 is null,합계요금,적용요금);
select * from 단말기;
select * from 구매기기;
-- 각 고객이 소유한 단말기의 이름과 서비스를 보여라
select 고객.성명, 기기.기기종류,기기.가격, 구매서비스.서비스명, 서비스.요금,단말기.적용요금
from 고객 left join 단말기 on 고객.고객번호 = 단말기.고객번호
left join 구매기기 on 구매기기.단말기번호 = 단말기.단말기번호
left join 기기 on 기기.기기번호 = 구매기기.기기번호
left join 구매서비스 on 구매서비스.단말기번호 = 단말기.단말기번호
left join 서비스 on 서비스. 서비스명 = 구매서비스.서비스명;