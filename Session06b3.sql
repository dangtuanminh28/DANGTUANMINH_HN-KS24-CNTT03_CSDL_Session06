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
-- Tính tổng doanh thu theo từng ngày
select o.order_id,
	   o.order_date,
       sum(o.total_amount)
from orders o
where o.status like 'completed'
group by order_id, o.order_date;
-- Tính số lượng đơn hàng theo từng ngày
select o.order_date,
	   count(o.order_id)
from orders o
where o.status like 'completed'
group by o.order_date;
-- Chỉ hiển thị các ngày có doanh thu > 10.000.000
select o.order_id,
		o.order_date,
	   sum(o.total_amount)
from orders o
where o.status like 'completed'
group by o.order_date, o.order_id
having sum(o.total_amount) > 100000.00