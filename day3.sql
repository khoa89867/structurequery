/*

YÊU CẦU

Xem các đơn hàng được bán kể từ ngày 2020-03-01 trở đi.

*/


select 
    *
from sales
where created_at >= '2020-03-01'

/*

YÊU CẦU

Để cross check với sổ sách kế toán, Financial Analyst cần báo cáo 
tổng chi tiêu của từng khách hàng trong năm 2019.

*/


select 
    customer_id,
    customer_name,
    sum(net_sales)
from sales
where date_trunc('year', created_at) = '2019-01-01'
group by 1, 2
order by customer_name asc

    
/*

YÊU CẦU

Để tiện cho việc tính toán các chỉ số theo thời gian, dùng DATE_TRUNC 
và làm thêm các cột sau:
- Ngày bán hàng (created_date)
- Tháng bán hàng (created_month)
- Quý bán hàng (created_quarter)
- Năm bán hàng (created_year)

*/
with spent_by_time as (
    select
        *,
        DATE_TRUNC('day', created_at) as day,
        DATE_TRUNC('month', created_at) as month,
        DATE_TRUNC('quarter', created_at) as quarter,
        DATE_TRUNC('year', created_at) as year
    from sales
)

select 
    day,
    month,
    quarter,
    year
from spent_by_time
group by 1, 2, 3, 4
order by day asc 

    




    


