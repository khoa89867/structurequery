/*
YÊU CẦU
Xem các cột sau của bảng sales: mã đơn hàng, mã sản phẩm, tên sản phẩm, 
doanh số (quantity), doanh thu (net_sales).
*/
SELECT customer_city
FROM sales;

/*
YÊU CẦU
Xem các đơn hàng có doanh thu trên $800 nhưng có ít hơn 10 sản phẩm.
*/
SELECT *
FROM sales
WHERE net_sales > 800 AND quantity < 10;

/*
YÊU CẦU
Xem đơn hàng của những sản phẩm có tên kết thúc bằng chữ Shoes hoặc Coat.
Ví dụ: Marble Shoes, Rubber Shoes, Aluminum Coat.
*/
SELECT *
FROM sales
WHERE product_name LIKE '%Shoes' OR product_name LIKE '%Coat';

/*
YÊU CẦU
Xem đơn hàng của những khách có tên chứa chữ Davi.
Ví dụ: Connie Davis, Davin Stemm.
*/
SELECT *
FROM sales
WHERE customer_name LIKE '%Davi%';

/*
YÊU CẦU
Để lập kế hoạch kinh doanh, Sales Director muốn biết số lượng đơn hàng của từng bang.
*/
SELECT customer_state, COUNT(sales_id)
FROM sales
GROUP BY customer_state;

/*
YÊU CẦU
Để lập kế hoạch phân phối, Sales Director muốn biết doanh thu theo từng thành phố.
*/
SELECT customer_city, SUM(net_sales) AS net_sales
FROM sales
GROUP BY customer_city;

/*
YÊU CẦU
Để tính tiền bonus nhận từ nhà cung ứng, Purchasing cần báo cáo tổng 
doanh số (quantity), tổng doanh thu (net_sales) của từng sản phẩm. 
Kết quả cần hiện cả mã và tên sản phẩm.
*/
SELECT product_id, product_name, SUM(quantity), SUM(net_sales)
FROM sales
GROUP BY product_id, product_name;

/*
YÊU CẦU
Đơn hàng có doanh thu nhỏ nhất từ trước đến nay là bao nhiêu? 
(cần loại trừ các đơn có doanh thu nhỏ hơn hoặc bằng 0)
*/
SELECT MIN(net_sales) AS min_sale
FROM sales
WHERE net_sales > 0;

/*
YÊU CẦU
Purchasing Specialist tại chi nhánh NY cần báo cáo tổng doanh thu,
tổng doanh số của từng sản phẩm được bán tại bang New York.
*/
SELECT product_id, product_name, SUM(net_sales) AS net_sales, SUM(quantity) AS quantity
FROM sales
WHERE customer_state = 'NY'
GROUP BY product_id, product_name;

/*
YÊU CẦU
Để tặng voucher, team Customer Service cần báo cáo top 10 khách hàng mua nhiều đơn nhất.
*/
SELECT customer_id, customer_name, COUNT(sales_id)
FROM sales
GROUP BY customer_id, customer_name
ORDER BY COUNT(sales_id) DESC
LIMIT 10;

/*
YÊU CẦU
Để làm banner cho chương trình marketing sắp tới, team Designer cần danh sách top 20 sản phẩm mang lại nhiều doanh thu nhất tại bang Montana. 
*/
SELECT product_id, product_name, SUM(net_sales) AS net_sale
FROM sales
WHERE customer_state = 'MT'
GROUP BY product_id, product_name
ORDER BY SUM(net_sales) DESC
LIMIT 20;

/*
YÊU CẦU
Chi nhánh tại bang Colorado đang cần phần tích tệp khách hàng tại Colorado. 
Lập báo cáo theo từng khách hàng sống tại Colorado, cần thể hiện các chỉ số bên dưới. 
- tổng chi tiêu
- tổng số đơn hàng đã mua
- tổng số lượng sản phẩm đã mua
- AOV
- giá trị đơn hàng lớn nhất từng mua
Sắp xếp theo tổng chi tiêu giảm dần.
*/
SELECT customer_id, customer_name, 
    SUM(net_sales) AS net_sales, 
    COUNT(sales_id) AS number_of_order, 
    SUM(quantity) AS quantity, 
    AVG(net_sales) AS aov, 
    MAX(net_sales) AS max_of_order
FROM sales
WHERE customer_state = 'CO'
GROUP BY customer_id, customer_name
ORDER BY SUM(net_sales) DESC;

/*
YÊU CẦU
Giám đốc Bán hàng đang lên chiến lược phân phối và cần một báo cáo chi tiết theo từng bang.
Lập báo cáo doanh thu của các bang, cần thể hiện các chỉ số sau:
- tổng doanh thu
- tổng doanh số
- tổng số đơn hàng đã bán
- AOV
Sắp xếp theo tổng doanh thu giảm dần.
*/
SELECT customer_state, 
    SUM(net_sales) AS net_sales, 
    SUM(quantity) AS quantity, 
    COUNT(sales_id) AS number_of_order_sold, 
    AVG(net_sales) AS aov
FROM sales
GROUP BY customer_state
ORDER BY SUM(net_sales) DESC;

/*Commit*/
