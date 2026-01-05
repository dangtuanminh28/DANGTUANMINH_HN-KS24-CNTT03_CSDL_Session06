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
    status enum('pending','completed','cancelled'),
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);

create table products (
    product_id int primary key auto_increment,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_item_id int primary key auto_increment,
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into customers (full_name, city) values
('đặng tuấn minh', 'hà nội'),
('phạm duy anh', 'tp.hcm'),
('nguyễn khoa nam', 'đà nẵng'),
('phạm thị thu trang', 'hải phòng'),
('nguyễn văn an', 'cần thơ'),
('đặng khánh an', 'nha trang');

insert into orders (customer_id, order_date, status, total_amount) values
(1, '2025-10-01', 'completed', 1500000.00),
(2, '2025-05-05', 'pending', 800500.00),
(1, '2025-04-10', 'completed', 3900800.00),
(3, '2025-07-15', 'cancelled', 2200000.00),
(2, '2025-11-20', 'completed', 7100000.00),
(4, '2025-01-10', 'pending', 4800000.00),
(5, '2025-02-25', 'completed', 3500000.00);

insert into products (product_name, price) values
('laptop', 20000000),
('chuột ko dây', 500000),
('bàn phím cơ', 1500000),
('tai nghe dây', 3000000),
('màn hình lg', 7000000);

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 2, 2),
(3, 3, 1),
(5, 5, 1),
(7, 4, 2);
-- Hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select
    p.product_id,
    p.product_name,
    sum(oi.quantity)
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.status = 'completed'
group by p.product_id, p.product_name;
-- Tính doanh thu của từng sản phẩm
select
    p.product_id,
    p.product_name,
    sum(oi.quantity * p.price)
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.status = 'completed'
group by p.product_id, p.product_name;
-- Chỉ hiển thị các sản phẩm có doanh thu > 5.000.000
select
    p.product_id,
    p.product_name,
    sum(oi.quantity * p.price)
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.status = 'completed'
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;