/*

YÊU CẦU

Giám đốc Bán hàng đang lên chiến lược phân phối và cần một báo cáo chi tiết theo từng bang.

Lập báo cáo doanh thu của các bang, cần thể hiện các chỉ số sau:
- tổng doanh thu
- tổng doanh số
- tổng số đơn hàng đã bán
- tổng số lượng khách hàng
- AOV
- Doanh thu trung bình mỗi khách hàng (= tổng doanh thu / tổng số lượng khách hàng)
- Số đơn trung bình mỗi khách hàng (= tổng số đơn hàng / tổng số lượng khách hàng)

*/
select
    customer.customer_state,
    sum(sales.net_sales) as net_sales,
    sum(sales.quantity) as quantity,
    count(sales.sales_id) as no_of_order,
    count(distinct customer.customer_id) as no_of_customer,
    avg(sales.net_sales) as aov,
    sum(sales.net_sales) / count(distinct customer.customer_id) as average_spent_amount_per_customer,
    count(sales.sales_id) / count(distinct customer.customer_id) as average_order_per_customer
from sales
left join customer using (customer_id
)
group by customer.customer_state



/*

YÊU CẦU

Xem tổng chi tiêu của từng khách hàng trong năm 2017. 
Yêu cầu dùng BETWEEN AND.

*/

select
    sales.customer_id,
    customer.customer_name,
    sum(net_sales)
from sales
left join customer using (customer_id)
where sales.created_at between '2017-01-01' and '2017-12-31' 
group by 1, 2


/*

YÊU CẦU

Xem đơn hàng của các thành phố Aurora, Dillon, Oxford.

*/

select
    sales.*
from sales
left join customer using (customer_id)
where customer.customer_city in ('Aurora', 'Dillon', 'Oxford')

