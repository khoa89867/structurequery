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

WITH sales_dow AS (
    SELECT
        *
        , TRIM(TO_CHAR(created_at, 'Day')) AS created_day_of_week
    FROM sales
)

, sales_weekday_weekend AS (
    SELECT 
        *
        , CASE 
            WHEN created_day_of_week = 'Monday' THEN 'Weekday'
            WHEN created_day_of_week = 'Tuesday' THEN 'Weekday'
            WHEN created_day_of_week = 'Wednesday' THEN 'Weekday'
            WHEN created_day_of_week = 'Thursday' THEN 'Weekday'
            WHEN created_day_of_week = 'Friday' THEN 'Weekday'
            WHEN created_day_of_week = 'Saturday' THEN 'Weekend'
            WHEN created_day_of_week = 'Sunday' THEN 'Weekend'
            ELSE 'Undefined' END
        AS is_weekday_or_weekend
    FROM sales_dow
)

SELECT 
    is_weekday_or_weekend
    , AVG(quantity) AS units_per_transaction
FROM sales_weekday_weekend
GROUP BY 1



