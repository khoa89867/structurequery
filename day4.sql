/*

YÊU CẦU

Tính tổng doanh thu, AOV theo từng tháng.

Sắp xếp kết quả theo tháng để dễ theo dõi.

*/


select 
    date_trunc('month', created_at) as month,
    sum(net_sales) as net_sales
from sales
group by month
order by month asc

/*

YÊU CẦU

Team Marketing đang lên kế hoạch mở rộng tập khách hàng và cần hiểu sự thay đổi 
hành vi của khách hàng qua từng năm. 

Để làm được, bạn cần tổng hợp các chỉ số bên dưới theo từng khách qua từng năm:
- tổng chi tiêu
- tổng số đơn hàng đã mua
- tổng số lượng sản phẩm đã mua
- AOV
- giá trị đơn hàng lớn nhất từng mua

Sắp xếp theo từng khách, sau đó theo thời gian để team Marketing dễ theo dõi.

*/

select
    customer_id,
    customer_name,
    date_trunc('year', created_at) as year,
    sum(net_sales) as net_sales,
    sum(quantity) as quantity_of_product_bought,
    avg(net_sales) as aov,
    max(net_sales) as most_spent_amount
    
from sales
group by 1, 2, 3
order by 1, 2, 3 asc

/*

YÊU CẦU

Tìm hiểu về hàm EXTRACT và áp dụng làm thêm các cột sau để tiện cho việc 
tính toán các chỉ số theo thời gian:
- Năm bán hàng dạng số (ví dụ 2018, 2019) (created_year_no)
- Tháng bán hàng dạng số (ví dụ 1, 2, 3) (created_month_no)

*/

SELECT
    *
    , EXTRACT(YEAR FROM created_at) AS created_year_no
    , EXTRACT(MONTH FROM created_at) AS created_month_no
FROM sales 

/*

YÊU CẦU

Tìm hiểu về hàm TO_CHAR và áp dụng làm thêm các cột sau để tiện cho việc 
tính toán các chỉ số theo thời gian:
- Tháng bán hàng rút gọn (ví dụ Jan, Feb, Mar) (created_month_str_shorten)
- Thứ trong ngày (ví dụ Monday, Tuesday) (created_day_of_week)

*/
SELECT
    *
    , TO_CHAR(created_at, 'Mon') AS created_month_str_shorten
    , TO_CHAR(created_at, 'Day') AS created_day_of_week
FROM sales

/*

YÊU CẦU

Quản lý chi nhánh tại bang New York đang lên kế hoạch tuyển dụng thêm nhân viên 
kho part-time để giải quyết các đơn hàng tăng đột xuất. 

Tuy nhiên, để quyết định nhân viên part-time sẽ làm vào ngày nào trong tuần, 
quản lý chi nhánh cần biết ngày nào trong tuần sẽ có số lượng đơn cao hơn.

Dựa trên yêu cầu này, viết báo cáo hỗ trợ quản lý chi nhánh ra quyết định.

*/


SELECT
    TO_CHAR(created_at, 'Day') AS created_day_of_week
    , COUNT(sales_id) AS count_orders
FROM sales
WHERE 
    customer_state = 'NY'
    AND created_at >= '2019-04-01' 
    AND created_at < '2020-04-01'
GROUP BY 1

/*

YÊU CẦU

Team Marketing có một giả thiết là khách hàng sẽ mua số lượng nhiều hơn vào cuối tuần. 

Tính chỉ số Units per Transaction (UPT) theo ngày trong tuần và ngày cuối tuần 
(Weekday vs Weekend) để xem giả thiết của team Marketing có chính xác không.

*/

with sale_of_week_table as (
    select
        *,
        extract(dow from created_at) as day_of_week
    from sales
)
select
    case
        when day_of_week > 0 and day_of_week < 6 then 'Weekday'
        else 'Weekend'
    end as weekday_or_weekend,
    avg(quantity) as unit_per_transaction
from sale_of_week_table
group by 1

/*

YÊU CẦU

Financial Analyst cần báo cáo tổng doanh thu của từng bang trong khoảng 
từ tháng 04/2018 đến hết tháng 03/2019.

*/

select
    customer_state,
    sum(net_sales) as total_net_sales
from sales
where date_trunc('month', created_at) >= '2018-04-01' and date_trunc('month', created_at) < '2019-04-01'
group by 1

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
    





