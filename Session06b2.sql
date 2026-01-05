drop database session06;
create database session06;
use session06;

create table customers (
	customer_id int primary key auto_increment,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
	order_id int primary key auto_increment,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled'),
    total_amount decimal(10.2),
	foreign key (customer_id) references customers(customer_id)
);

insert into customers (full_name, city) 
values
('Đặng Tuấn Minh', 'Hà Nội'),
('Phạm Duy Anh', 'TP.HCM'),
('Nguyễn Khoa Nam', 'Đà Nẵng'),
('Phạm Thị Thu Trang', 'Hải Phòng'),
('Nguyễn Văn An', 'Cần Thơ'),
('Đặng Khánh An', 'Nha Trang');

insert into orders (customer_id, order_date, status, total_amount)
values
(1, '2025-10-01', 'completed', 1500000.00),
(2, '2025-05-05', 'pending', 800500.00),
(1, '2025-04-10', 'completed', 3900800.00),
(3, '2025-07-15', 'cancelled', 2200000.00),
(2, '2025-11-20', 'completed', 7100000.00),
(4, '2025-01-10', 'pending', null),
(5, '2025-02-25', 'completed', null);
-- Hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu
select c.customer_id,
	   c.full_name,
       o.status,
       sum(o.total_amount)
from customers c
join orders o on c.customer_id = o.customer_id 
where o.status like 'completed'
group by c.customer_id, c.full_name, o.status;
-- Hiển thị giá trị đơn hàng cao nhất của từng khách
select c.customer_id,
	   c.full_name,
       max(o.total_amount)
from customers c
join orders o on c.customer_id = o.customer_id 
where o.status like 'completed'
group by c.customer_id, c.full_name;
-- Sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.customer_id,
	   c.full_name,
       min(o.total_amount)
from customers c
join orders o on c.customer_id = o.customer_id 
where o.status like 'completed'
group by c.customer_id, c.full_name
order by min(o.total_amount) desc;