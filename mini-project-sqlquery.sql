use mywork;
create table kopis_data (
     seq          	 		int NOT NULL AUTO_INCREMENT PRIMARY KEY,
     location        		varchar(10),
     start_date				varchar(10),
     end_date				varchar(10),
     perf_count      		int,
     perf_per    			float,
     opening_count    	 	int,
     opening_per        	float,
     play_count      		int,
     play_per    			float,
     ticket_sale_count      int,
     ticket_sale_per   		float,
     ticket_sale_amt     	int,
     ticket_sale_amt_per    float
); 

select * from kopis_data;    

-- 2019년07월 ~ 2019년 12월 집계    
select mid(start_date, 1, 6) as period, sum(ticket_sale_count) count, sum(ticket_sale_amt) sale_amt
	from kopis_data 
	where mid(start_date, 1, 6) like '2019%'
		and quarter(start_date) in(3, 4)
	group by period with rollup;
    
-- 2020년 01월 ~ 2020년 06월 집계
select mid(start_date, 1, 6) as period, sum(ticket_sale_count) count, sum(ticket_sale_amt) sale_amt
	from kopis_data 
	where mid(start_date, 1, 6) like '2020%'
		and quarter(start_date) in(1, 2)
	group by period with rollup;
    
-- 2019년 01월~ 2022년 12월 분기별 합계
select year(start_date) years, quarter(start_date) quarters, sum(ticket_sale_amt)*1000 sale_amt,
sum(ticket_sale_count) sum_count_amt
# round(sum(ticket_sale_amt) /sum(ticket_sale_count)*1000,0) perticket
from kopis_data
where  year(start_date)>=2019
group by 1,2 with rollup;
    
    