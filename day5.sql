/*

YÊU CẦU

Team Purchasing đang lên kế hoạch tìm nguồn hàng mới và cần hiểu sự thay đổi thị hiếu 
mua hàng qua từng năm. 

Để làm được, bạn cần làm tổng hợp các chỉ số bên dưới theo từng sản phẩm qua từng năm:
- tổng doanh thu
- tổng doanh số
- tổng số đơn hàng đã bán
- AOV

Sắp xếp theo từng sản phẩm, sau đó theo thời gian để team Purchasing dễ theo dõi.

*/
select
    product_id,
    product_name,
    extract(year from created_at) as year,
    sum(net_sales) as sum_of_net_sales,
    sum(quantity) as sum_of_quantity,
    count(sales_id) as no_of_order,
    avg(net_sales) as aov
from sales
group by 1, 2, 3
order by 1, 3 asc

/*

YÊU CẦU

Team Sales có một target bán hàng theo nửa năm. 

Bạn hãy giúp team sales làm một báo cáo doanh thu, doanh số theo 
nửa năm (haft year). Ví dụ: 2018-H1, 2018-H2, 2019-H1,...

*/

select
    case
        when extract(month from created_at) <= 6 then to_char(created_at, 'YYYY-H1')
        else to_char(created_at, 'YYYY-H2')
    end,
    sum(net_sales) as net_sales,
    sum(quantity) as quantity
from sales
group by 1
    
/*

YÊU CẦU

Sales Admin cần xem lịch sử mua hàng của khách tên Laverne Stanton.

*/


select
    sales.*,
    customer.customer_name
from Sales
left join customer on sales.customer_id = customer.customer_id
where customer.customer_name = 'Laverne Stanton'

/*

YÊU CẦU

Xem đơn hàng của những sản phẩm có tên kết thúc bằng chữ Table hoặc Bench.
Ví dụ: Plastic Bench, Wood Table.

*/
select 
    sales.*,
    product.product_name
from sales
left join product on sales.product_id = product.product_id
where product_name like '%Table' or product_name like '%Bench'


/*

YÊU CẦU

Xem những sản phẩm có tên kết thúc bằng chữ Clock hoặc Watch.
Ví dụ: Aluminum Clock, Iron Watch.

*/

select 
    *
from product
where product_name like '%Clock' or product_name = 'Watch'

/*

YÊU CẦU

Xem top 20 đơn hàng có doanh thu cao nhất được giao đến thành phố Creston.

*/

select 
    sales.*,
    customer.customer_city
from sales
left join customer on sales.customer_id = customer.customer_id
where customer.customer_city = 'Creston'
order by sales.net_sales desc
limit 20


/*

YÊU CẦU

Marketing Executive tại bang Missouri cần báo cáo AOV của từng 
ngành hàng trong Q1 2020.

*/
select
    product.category,
    avg(sales.net_sales)
from sales
left join customer on sales.customer_id = customer.customer_id
left join product on sales.product_id = product.product_id
where customer_state = 'MO' and date_trunc('quarter', sales.created_at) = '2020-01-01'
group by 1

/*

YÊU CẦU

Để tặng voucher, team Customer Service ở bang Montana cần báo cáo 
top 20 khách hàng tiêu nhiều tiền nhất trong năm 2019.

*/
select
    customer.customer_id,
    customer.customer_name,
    sum(net_sales) as spent_amount
from sales
left join customer using(customer_id)
where customer.customer_state = 'MT' and date_trunc('year', sales.created_at) = '2019-01-01'
group by 1, 2
order by spent_amount desc
limit 20
/*

YÊU CẦU

Công ty đang cần phân nhóm sản phẩm để thực hiện một số phân tích về sản phẩm. 

Bạn cần phân nhóm sản phẩm theo vật liệu như yêu cầu bên dưới: 
- Metal: tên sản phẩm chứa các từ Aluminum, Copper, Steel, Bronze, Iron
- Cloth: tên sản phẩm chứa các từ Wool, Leather, Silk, Linen, Cotton
- Others: còn lại

*/

select
    *,
    case 
        when product.product_name like '%Aluminum%' 
        or product.product_name like '%Copper%' 
        or product.product_name like '%Steel%' 
        or product.product_name like '%Bronze%' 
        or product.product_name like '%Iron%'
        then 'Metal'
        when product.product_name like '%Wool%' 
        or product.product_name like '%Leather%' 
        or product.product_name like '%Silk%' 
        or product.product_name like '%Linen%' 
        or product.product_name like '%Cotton%'
        then 'Cloth'
        else 'Others'
    end as modify_goods
from product

 /*

YÊU CẦU

Sales Supervisor cần xem data thô đơn hàng của các thành phố South Fulton, East Prairie.

*/

select
    *,
    customer.customer_city
from sales
left join customer using (customer_id)
where customer.customer_city = 'South Fulton' or customer_city = 'East Prairie'
/*

YÊU CẦU

Team Customer Service cần danh sách các khách hàng đến từ các thành phố 
Mayville, Plattsmouth.

*/

select
    *
from customer
where customer_city in ('Mayville', 'Plattsmouth')

/*

YÊU CẦU

Xem top 50 đơn hàng có doanh thu cao nhất của ngàng hàng Gadget được giao 
đến bang Colorado.

*/
select
    sales.*,
    product.category,
    customer.customer_state
from sales
left join customer using (customer_id)
left join product using (product_id)
where product.category = 'Gadget' and customer.customer_state = 'CO'
order by net_sales desc
limit 50

/*

YÊU CẦU

Purchasing Specialist tại chi nhánh bang Alabama cần báo cáo tổng doanh thu, 
tổng doanh số của từng sản phẩm được bán tại bang.

*/
select
    sales.product_id,
    product.product_name,
    sum(sales.net_sales) as sum_of_net_sales,
    sum(sales.quantity) as sum_of_quantity
from sales
left join customer using (customer_id)
left join product using (product_id)
where customer.customer_state = 'AL'
group by 1,2 


/*

YÊU CẦU

Để làm banner cho chương trình marketing sắp tới, team Designer cần danh sách 
top 20 sản phẩm mang lại nhiều doanh thu nhất tại bang Montana. 

*/

select
    sales.product_id,
    product.product_name,
    customer.customer_state,
    sum(sales.net_sales) as sum_of_net_sales
from sales
left join customer using (customer_id)
left join product using (product_id)
where customer.customer_state = 'MT'
group by 1, 2, 3
order by 4 desc
limit 20

/*

YÊU CẦU

Công ty đang muốn tăng doanh thu tại các thị trường mới. Để làm việc đó, công ty 
muốn hiểu được hành vi mua hàng của các bang có doanh thu tốt, và sự khác biệt 
với các bang còn lại.

Dựa theo kế hoạch đó, đầu tiên bạn cần phân nhóm bang dựa trên doanh thu: 
- Big 10: TX, MT, MN, NY, CO, CA, MI, NC, ND, MO
- Others: Các bang còn lại

*/

select
    case
        when customer.customer_state in ('TX', 'MT', 'MN', 'NY', 'CO', 'CA', 'MI', 'NC', 'ND', 'MO') then 'Big10'
        else 'Others'
    end as modify_state,
    sum(sales.net_sales) as sum_of_net_sales
from sales
left join customer using (customer_id)
group by 1


/*

YÊU CẦU

Có bao nhiêu đơn có doanh thu trong khoảng từ $200 đến $600?

*/

select 
    *
from sales
where net_sales between 200 and 600

/*

YÊU CẦU

Xem tổng doanh thu của từng bang trong khoảng từ tháng 04/2019 đến tháng 03/2020.

*/


select
    customer.customer_state,
    sum(sales.net_sales)
from sales
left join customer using (customer_id)
where date_trunc('day', created_at) between '2019-04-01' and '2020-03-31'
group by customer.customer_state

/*

YÊU CẦU

Xem đơn hàng của các khách hàng có tên là John Aufderhar, Madalyn Roob.

*/

select
    sales.*,
    customer.customer_name
from sales
left join customer using (customer_id)
where customer.customer_name in('John Aufderhar', 'Madalyn Roob')

/*

YÊU CẦU

Công ty đang muốn tăng doanh thu tại các thị trường mới. Để làm việc đó, 
công ty muốn hiểu được hành vi mua hàng của các bang có doanh thu tốt, và 
sự khác biệt với các bang còn lại.

Dựa theo kế hoạch đó, đầu tiên bạn cần phân nhóm bang dựa trên doanh thu: 
- Big 10: TX, MT, MN, NY, CO, CA, MI, NC, ND, MO
- Others: Các bang còn lại

*/
select 
    customer.customer_state,
    case
        when customer.customer_state in('TX', 'MT', 'MN', 'NY', 'CO', 'CA', 'MI', 'NC', 'ND', 'MO') then 'Big10'
        else 'Others'
    end
from sales
left join customer using (customer_id)











