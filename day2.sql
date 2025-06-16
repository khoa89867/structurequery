/*

YÊU CẦU

Công ty đang cần phân tích hành vi khách hàng để tăng doanh thu. Kế hoạch sơ 
khởi bao gồm: 
- Phân nhóm đơn hàng dựa trên doanh thu
- Giao kết quả cho team Marketing để chạy promotion
    - Đối với khách mua giá trị cao: Chương trình giảm x% khi mua từ $xxx, 
      với $xxx là mức cao hơn giá trị đơn trung bình (AOV) của tệp khách này.
    - Còn lại: Chương trình giảm $xx khi mua đơn hàng kế tiếp có giá trị 
      trên $xxx, với $xxx là mức cao hơn AOV của tệp khách này.

Dựa trên kế hoạch đó, đầu tiên bạn cần phân nhóm đơn hàng thành các loại sau:
+ >= $500: High value
+ Từ $100 đến $500: Normal value
+ Từ $0 đến $100: Low value

*/

SELECT
    sales_id,
    net_sales,
    CASE
        WHEN net_sales >= 500 THEN 'high_value'
        WHEN net_sales < 500 AND net_sales >= 100 THEN 'normal_value'
        WHEN net_sales > 0 AND net_sales <= 100 THEN 'low_value'
    END AS modify_order
FROM sales


/*

YÊU CẦU

Công ty đang cần phân nhóm sản phẩm để thực hiện một số phân tích về sản phẩm. 

Bạn cần phân nhóm sản phẩm theo vật liệu như yêu cầu bên dưới: 
- Metal: tên sản phẩm chứa các từ Aluminum, Copper, Steel, Bronze, Iron
- Cloth: tên sản phẩm chứa các từ Wool, Leather, Silk, Linen, Cotton
- Others: còn lại

*/

SELECT
    product_id, product_name,
    CASE
        WHEN product_name LIKE '%Aluminum%' OR product_name LIKE '%Copper%' OR product_name LIKE '%Steel%' OR product_name LIKE '%Bronze%' OR product_name LIKE '%Iron%' THEN 'Metal'
        WHEN product_name LIKE '%Wool%' OR product_name LIKE '%Leather%' OR product_name LIKE '%Silk%' OR product_name LIKE '%Linen%' OR product_name LIKE '%Cotton%' THEN 'Cloth'
        ELSE 'Others'
    END AS modify_type_of_product
FROM sales

/*

YÊU CẦU

Công ty đang muốn tăng doanh thu tại các thị trường mới. Để làm việc đó, công ty 
muốn hiểu được hành vi mua hàng của các bang có doanh thu tốt, và sự khác biệt 
với các bang còn lại.

Dựa theo kế hoạch đó, đầu tiên bạn cần phân nhóm bang dựa trên doanh thu: 
- Big 10: TX, MT, MN, NY, CO, CA, MI, NC, ND, MO
- Others: Các bang còn lại

*/

SELECT
    sales_id,
    customer_state,
    CASE
        WHEN customer_state IN('TX', 'MT', 'MN', 'NY', 'CO', 'CA', 'MI', 'NC', 'ND', 'MO') THEN 'Big10'
        ELSE 'others'
    END AS modify_state_group
FROM sales
        
/*

YÊU CẦU

Công ty đang cần phân tích hành vi khách hàng để tăng doanh thu. Kế hoạch 
sơ khởi bao gồm: 
- Phân nhóm đơn hàng dựa trên doanh số
- Giao kết quả cho team Marketing để chạy promotion
    - Đối với khách mua nhiều: Chương trình mua X tặng x cho sản phẩm A, 
      với A là sản phẩm cần đẩy mạnh doanh số.
    - Còn lại: Chương trình mua x sản phẩm B tặng x sản phẩm C, với B là 
      sản phẩm cần đẩy doanh số, C là sản phẩm tồn kho nhiều.

Theo kế hoạch đó, đầu tiên bạn cần phân nhóm đơn hàng thành các loại sau 
dựa trên doanh số: 
+ >= 10: High volume
+ Từ 2 đến 10: Normal volume
+ Từ 0 đến 2: Low volume
a
*/
SELECT
    sales_id,
    quantity,
    CASE 
        WHEN quantity >= 10 THEN 'High volume'
        WHEN quantity >= 2 THEN 'Normal volume'
        WHEN quantity >= 0 THEN 'Low volume'
    END AS modify_as_quantity
FROM sales
        

/*

YÊU CẦU

Công ty đang cần phân nhóm sản phẩm để thực hiện một số phân tích về 
sản phẩm. Bạn cần phân nhóm sản phẩm như yêu cầu bên dưới:
- Fashion: tên sản phẩm kết thúc bằng Watch, Hat, Wallet, Coat, Shoes, 
  Gloves, Bag, Shirt, Pants
- Home & Living: tên sản phẩm kết thúc bằng Bench, Table, Clock, Chair, 
  Lamp, Knife, Plate
- Others: còn lại

*/


SELECT
    product_id,
    product_name,
    CASE
        WHEN product_name LIKE '%Watch' THEN 'Fashion'
        WHEN  product_name LIKE '%Hat' THEN 'Fashion'
        WHEN  product_name LIKE '%Wallet' THEN 'Fashion'
        WHEN  product_name LIKE '%Coat' THEN 'Fashion'
        WHEN  product_name LIKE '%Shoes' THEN 'Fashion'
        WHEN  product_name LIKE '%Gloves' THEN 'Fashion'
        WHEN  product_name LIKE '%Bag' THEN 'Fashion'
        WHEN  product_name LIKE '%Shirt' THEN 'Fashion'
        WHEN  product_name LIKE '%Pants' THEN 'Fashion'
        WHEN product_name LIKE '%Bench'THEN 'Home & Living'
        WHEN product_name LIKE '%Table' THEN 'Home & Living'
        WHEN product_name LIKE '%Clock' THEN 'Home & Living'
        WHEN product_name LIKE '%Chair' THEN 'Home & Living'
        WHEN product_name LIKE '%Lamp' THEN 'Home & Living'
        WHEN product_name LIKE '%Knife' THEN 'Home & Living'
        WHEN product_name LIKE '%Plate' THEN 'Home & Living'
        ELSE 'Others'
    END AS modify_type_of_product
FROM sales

/*

YÊU CẦU

Công ty đang muốn phân tích xem khu vực nào trong cả nước có sự sụt giảm 
doanh số hoặc tăng trưởng thấp. Tuy nhiên, dữ liệu hiện tại không có 
trường thông tin khu vực của từng bang.

Để đáp ứng yêu cầu đó, bạn cần phân nhóm bang theo khu vực như trong link 
bên dưới:
https://education.nationalgeographic.org/resource/united-states-regions/

*/
SELECT 
    sales_id,
    customer_state,
    CASE
        WHEN customer_state IN('WA', 'OR', 'ID', 'MT', 'WY', 'CA', 'NV', 'UT', 'CO', 'AK', 'HI') THEN 'West'
        WHEN customer_state IN('AZ', 'NM', 'OK', 'TX') THEN 'SouthWest'
        WHEN customer_state IN('ND', 'SD', 'NE', 'KS', 'IA', 'MN', 'MO', 'WI', 'IL', 'IN', 'OH', 'MI') THEN 'MidWest'
        WHEN customer_state IN('AR', 'LA', 'MS', 'AL', 'GA', 'FL', 'TN', 'KY', 'SC', 'NC', 'VA', 'DC', 'WV', 'MD', 'DE') THEN 'SouthEast'
        WHEN customer_state IN('PA', 'NY', 'NJ', 'CT', 'RI', 'MA', 'NH', 'ME', 'VT') THEN 'NorthEast'
    END
FROM sales



/*

YÊU CẦU

Team Marketing đang cần chạy một chương trình promotion cho những khách hàng có 
tổng chi tiêu từ trước đến nay lớn hơn $3000. 

Lập danh sách khách hàng theo như yêu cầu của team Marketing.

*/

WITH cumstomer_netsale_sum AS (
    SELECT customer_id, customer_name, SUM(net_sales) AS sum_sales FROM sales GROUP BY 1, 2
)

SELECT * FROM cumstomer_netsale_sum WHERE sum_sales > 3000

/*

YÊU CẦU

Team Marketing đang cần phân nhóm khách hàng để thực hiện các chương trình 
marketing theo từng nhóm khách hàng.

Bạn cần phân nhóm khách hàng theo tổng chi tiêu theo như yêu cầu bên dưới: 
- High value: >= $3000
- Normal value: $1000 - $3000
- Low value: < $1000

*/
WITH sum_customer_spent AS (
    SELECT customer_id, customer_name, SUM(net_sales) AS spent_amount FROM sales GROUP BY 1, 2
)
SELECT 
    *,
    CASE    
        WHEN spent_amount >= 3000 THEN 'High value'
        WHEN spent_amount >=1000 THEN 'Normal value'
        WHEN spent_amount > 0 THEN 'Low value'
    END AS value
FROM sum_customer_spent 


/*

YÊU CẦU

Công ty đang cần phân tích hành vi khách hàng để tăng doanh thu. Kế hoạch sơ 
khởi bao gồm: 
- Phân nhóm đơn hàng dựa trên doanh thu
- Giao kết quả cho team Marketing để chạy promotion
    - Đối với khách mua giá trị cao: Chương trình giảm x% khi mua từ $xxx, 
      với $xxx là mức cao hơn giá trị đơn trung bình (AOV) của tệp khách này.
    - Còn lại: Chương trình giảm $xx khi mua đơn hàng kế tiếp có giá trị 
      trên $xxx, với $xxx là mức cao hơn AOV của tệp khách này.

Cách phân nhóm đơn hàng, đã làm ở M03 - T01:
+ >= $500: High value
+ Từ $100 đến $500: Normal value
+ Từ $0 đến $100: Low value

Dựa trên kết quả đó, tính số lượng đơn, số lượng khách hàng và AOV của từng 
nhóm (High/Normal/Low value), làm cơ sở cho điều kiện áp dụng promotion.

*/

WITH modify_order AS (
    SELECT 
    *,
    CASE    
        WHEN net_sales >= 500 THEN 'High value'
        WHEN net_sales >= 100 THEN 'Normal value'
        WHEN net_sales >= 0 THEN 'Low value'
        ELSE 'Undefined'
    END AS value
    FROM sales
    GROUP BY 1, 2, 3
)

SELECT
    value, COUNT(sales_id) AS number_of_order, COUNT(DISTINCT customer_id) AS number_of_customer, AVG(net_sales) AS aov
FROM modify_order
GROUP BY 1

/*

YÊU CẦU

Team Marketing đang cần phân nhóm khách hàng để thực hiện các chương trình 
marketing theo từng nhóm khách hàng.

Cách phân nhóm khách hàng theo tổng chi tiêu, đã làm ở M04 - T02: 
- High value: > $3000
- Normal value: $1000 - $3000
- Low value: < $1000

Dựa trên kết quả đó, lấy danh sách các khách hàng thuộc nhóm High value.

*/
WITH spent_amount AS (
    SELECT 
    customer_id,
    customer_name,
    CASE
        WHEN SUM(net_sales) > 3000 THEN 'High value'
        WHEN SUM(net_sales) >= 1000 THEN 'Normal value'
        WHEN SUM(net_sales) >= 0 THEN 'Low value'
        ELSE 'Undefined'
    END AS value
    FROM sales
    GROUP BY 1, 2
)

SELECT * FROM spent_amount WHERE value = 'High value'


/*

YÊU CẦU

Team Marketing đang cần phân tích hành vi của những khách hàng có tổng 
chi tiêu trong khoảng $1000-$2000. 

Lập danh sách khách hàng theo như yêu cầu của team Marketing.

*/

WITH customer_spent_amount AS (
    SELECT 
        customer_id,
        customer_name,
        SUM(net_sales) AS spent_amount
    FROM sales
    GROUP BY 1, 2
)
SELECT 
    * 
FROM customer_spent_amount
WHERE spent_amount <= 2000 AND spent_amount >= 1000
        
/*

YÊU CẦU

Giám đốc bán hàng đang cần phân bổ lại cấu trúc quản lý của Regional Sales Manager. 

Theo yêu cầu từ giám đốc bán hàng, bạn cần phân nhóm bang theo tổng doanh thu: 
- High value: >= $100,000
- Normal value: $50,000 - $100,000
- Low value: < $50,000

*/
WITH spent_amount_of_state AS (
    SELECT customer_state, SUM(net_sales) AS state_spent FROM sales GROUP BY 1
)
SELECT customer_state,
    CASE 
        WHEN state_spent >= 100000 THEN 'High value'
        WHEN state_spent >= 50000 THEN 'Normal value'
        WHEN state_spent >= 0 THEN 'Low value'
        ELSE 'Undefined'
    END
FROM spent_amount_of_state

/*

YÊU CẦU

Công ty đang cần phân tích hành vi khách hàng để tăng doanh thu. Kế hoạch 
sơ khởi bao gồm: 
- Phân nhóm đơn hàng dựa trên doanh số
- Giao kết quả cho team Marketing để chạy promotion
    - Đối với khách mua nhiều: Chương trình mua X tặng x cho sản phẩm A, 
      với A là sản phẩm cần đẩy mạnh doanh số.
    - Còn lại: Chương trình mua x sản phẩm B tặng x sản phẩm C, với B là 
      sản phẩm cần đẩy doanh số, C là sản phẩm tồn kho nhiều.

Cách phân nhóm đơn hàng, đã làm ở M03 - K01: 
+ >= 10: High volume
+ Từ 2 đến 10: Normal volume
+ Từ 0 đến 2: Low volume

Dựa trên kết quả đó, tính số lượng khách hàng của từng nhóm để công ty 
có thể dự tính số lượng promo code cần tung ra.

*/
WITH modify_sales AS (
    SELECT 
        *,
        CASE
            WHEN quantity >= 10 THEN 'High volume'
            WHEN quantity >= 2 THEN 'Normal volume'
            WHEN quantity > 0 THEN 'Low volume'
            ELSE 'Undefined'
        END AS value
    FROM sales
)
SELECT 
    value,
    COUNT(DISTINCT customer_id)
FROM modify_sales
GROUP BY 1

/*

YÊU CẦU

Team Marketing đang cần phân nhóm khách hàng để thực hiện các chương trình 
marketing theo từng nhóm khách hàng.

Cách phân nhóm khách hàng theo tổng chi tiêu, đã làm ở M04 - T02: 
- High value: > $3000
- Normal value: $1000 - $3000
- Low value: < $1000

Dựa trên kết quả đó, tính số lượng khách hàng, tổng chi tiêu của từng nhóm 
khách hàng.

*/
WITH spent_amount_of_customer AS (
    SELECT 
        customer_id,
        customer_name,
        SUM(net_sales) AS spent_amount
    FROM sales
    GROUP BY 1, 2
),  value_of_customer AS (
    SELECT
        *,
        CASE
            WHEN spent_amount > 3000 THEN 'High value'
            WHEN spent_amount >= 1000 THEN 'Normal value'
            WHEN spent_amount > 0 THEN 'Low value'
            ELSE 'Undefined' 
        END AS modify_value
    FROM spent_amount_of_customer
)

SELECT
    modify_value,
    COUNT(DISTINCT customer_id) AS number_of_customer,
    SUM(spent_amount) AS spent_amount
    FROM value_of_customer
GROUP BY 1
