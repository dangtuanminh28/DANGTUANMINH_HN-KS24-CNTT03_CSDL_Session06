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

insert into orders (customer_id, order_date, status)
values
(1, '2025-10-01', 'completed'),
(2, '2025-05-05', 'pending'),
(1, '2025-04-10', 'completed'),
(3, '2025-07-15', 'cancelled'),
(2, '2025-11-20', 'completed'),
(4, '2025-01-10', 'pending'),
(5, '2025-02-25', 'pending');
-- Hiển thị danh sách đơn hàng và tên khách hàng
select 
    o.order_id,
    o.order_date,
    o.status,
    c.full_name
from orders o
join customers c on o.customer_id = c.customer_id
order by o.order_date;
-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select 
    c.customer_id,
    c.full_name,
    count(o.order_id)
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;
-- Hiển thị các khách hàng có ít nhất 1 đơn
select 
    c.customer_id,
    c.full_name,
    count(o.order_id)
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;