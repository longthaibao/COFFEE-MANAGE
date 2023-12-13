USE CSDL_database;
INSERT INTO `job_role` (`JID`, `job_type`)
VALUES
    (1, 'Quản lý'),
    (2, 'Thu ngân'),
    (3, 'Pha chế'),
    (4, 'Bảo vệ'),
    (5, 'Tạp vụ');
    
INSERT INTO `store` (`SID`, `store_name`, `store_phone`, `store_des`, `store_add`)
VALUES
    (1, 'Cửa hàng Lý Thường Kiệt', '0902534178', 'Quán cà phê ấm cúng trên đường Lý Thường Kiệt, nơi hòa quyện hương vị đặc trưng và không khí ấm áp của thành phố.', '268 Lý Thường Kiệt, Phường 14, Quận 10, Thành phố Hồ Chí Minh'),
    (2, 'Cửa hàng Tạ Quang Bửu', '0281563428', 'Cà phê Tạ Quang Bửu, chỉ cách kí túc xá khu A 100m và luôn phục vụ 24/7, hứa hẹn mang lại trải nghiệm đầy tiện lợi và thoải mái cho khách hàng.', 'Hẻm chui, Đường Tạ Quang Bửu, Khu phố 6, Phường Linh Trung, Thành phố Thủ Đức, Thành phố Hồ Chí Minh.');

INSERT INTO `time_store` (`time_store_SID`, `open_time`, `close_time`, `date`)
VALUES
    (1, '09:00:00', '18:00:00', 2),
    (1, '10:30:00', '20:00:00', 3),
    (1, '09:00:00', '18:00:00', 4),
    (1, '10:30:00', '20:00:00', 5),
    (1, '09:00:00', '18:00:00', 6),
    (1, '10:30:00', '20:00:00', 7),
    (1, '10:30:00', '20:00:00', 8),
    (2, '07:00:00', '16:00:00', 2),
    (2, '07:30:00', '18:00:00', 3),
    (2, '07:00:00', '16:00:00', 4),
    (2, '07:30:00', '18:00:00', 5),
    (2, '07:00:00', '16:00:00', 6),
    (2, '07:30:00', '18:00:00', 7),
    (2, '07:30:00', '18:00:00', 8);

INSERT INTO `employee` (`ID`, `employee_name`, `employee_gender`, `employee_email`, `employee_SID`, `employee_MID`)
VALUES
    (1, 'Lìu Ngọc Yến', 'Nữ', 'yenliu@gmail.com', 2, NULL),
    (2, 'Lê Quốc An', 'Nam', 'anlequoc@gmail.com', 1, NULL),
    (3, 'Thái Bảo Long', 'Nam', 'longthaibao@gmail.com', 1, 2),
    (4, 'Nguyễn Ngọc Bảo Châu', 'Nữ', 'chaunguyen@gmail.com', 2, 1),
    (5, 'Đặng Phan Minh Phúc', 'Nam', 'phucminh@gmail.com', 2, 1);

INSERT INTO `employee_phone` (`employee_phone_ID`, `employee_phone_phone`)
VALUES
    (1, '0983546278'),
    (2, '0765231897'),
    (2, '0912436487'),
	(3, '0945261789'),
    (4, '0902351447'),
    (5, '0795462341');

INSERT INTO `employee_job` (`employee_job_ID`, `employee_job_JID`)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2),
    (3, 4),
    (4, 3),
    (5, 5);

INSERT INTO `account` (`AID`, `username`, `password`, `employee_ID`)
VALUES
    (1, 'lequocan', SHA2(CONCAT('1234567', 'fc45c92ac5ad37b42824ea724d2f8f32'), 256), 2),
    (2, 'liungocyen', SHA2(CONCAT('7654321', 'fc45c92ac5ad37b42824ea724d2f8f32'), 256), 1);

INSERT INTO `product` (`PID`, `product_name`, `product_price`, `product_size`)
VALUES
	(1, 'Espresso', 45000, 'M'),
    (2, 'Espresso', 55000, 'L'),
    (3, 'Cappuccino', 45000, 'M'),
    (4, 'Cappuccino', 55000, 'L'),
    (5, 'Latte', 48000, 'M'),
    (6, 'Latte', 57000, 'L'),
    (7, 'Mocha', 40000, 'M'),
    (8, 'Mocha', 48000, 'L'),
    (9, 'Americano', 45000, 'M'),
    (10, 'Americano', 55000, 'L');
    -- Xóa các sản phẩm từ 11-30 vì quá nhiều

INSERT INTO `store_product` (`product_PID`, `store_SID`)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1),
    (1, 2),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 2),
    (8, 2),
    (9, 2),
    (10, 2);

INSERT INTO `material` (`MID`, `material_name`, `material_type`)
VALUES
    (1, 'Hạt cà phê', 'kilogram'),
    (2, 'Sữa tách béo', 'hộp 1.5l'),
    (3, 'Sữa tươi TH TrueMilk (không đường)', 'hộp 1.5l'),
    (4, 'Sữa tươi TH TrueMilk (ít đường)', 'hộp 1.5l'),
    (5, 'Sữa tươi DalatMilk (không đường)', 'hộp 1.5l'),
    (6, 'Sữa tươi DalatMilk (ít đường)', 'hộp 1.5l'),
    (7, 'Sốt socola', 'chai 500ml'),
    (8, 'Sốt Caramel', 'chai 500ml'),
    (9, 'Bánh cookies', 'hộp 500g'),
    (10, 'Siro Vanilla', 'chai 500ml'),
    (11, 'Hạt Cà Phê Giảm Caffeine', 'kilogram'),
    (12, 'Sữa Đặc', 'hộp 1.5l'),
    (13, 'Kem vanila', 'hộp 1l'),
    (14, 'Đường', 'kilogram');

INSERT INTO `supplier` (`supID`, `sup_name`, `sup_add`, `sup_phone`, `sup_email`)
VALUES
    (1, 'Siêu thị nguyên liệu', '681 Lê Thị Riêng, Phường Thới An, Quận 12, TPHCM', '1900099949', 'sieuthinguyenlieu@gmail.com'),
    (2, 'Nguyên liệu Nguyên An', '1166 Cách Mạng Tháng 8, Phường 4, Quận Tân Bình, TPHCM', '0916635038 ', 'nguyenlieuphachesi@gmail.com'),
    (3, 'Bartenders’ Mart Nhất Hương ', '61A Trần Quang Diệu, Phường 13, Quận 3, TPHCM', '0283812033', 'dungcubarcafe@gmail.com');

INSERT INTO `sup_material` (`material_MID`, `sup_supID`)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 2),
    (6, 2),
    (7, 2),
    (8, 2),
    (9, 3),
    (10, 3),
    (11, 3),
    (12, 3),
    (13, 3),
    (14, 3);

INSERT INTO `recipe` (`product_PID`, `RID`, `recipe_des`)
VALUES
    (1, 1, 'Công thức của Espresso size M'),
    (2, 2, 'Công thức của Cappuccino size M'),
    (3, 3, 'Công thức của Latte size M'),
    (4, 4, 'Công thức của Mocha size M'),
    (5, 5, 'Công thức của Americano size M'),
    (6, 1, 'Công thức của Espresso size L'),
    (7, 2, 'Công thức của Cappuccino size L'),
    (8, 3, 'Công thức của Latte size L'),
    (9, 4, 'Công thức của Mocha size L'),
    (10, 5, 'Công thức của Americano size L');

INSERT INTO `recipe_material` (`material_MID`, `product_PID`, `recipe_RID`, `quantity`)
VALUES
    (1, 1, 1, 100),
    (1, 2, 2, 200),
    (1, 3, 3, 100),
    (1, 4, 4, 200),
    (1, 5, 5, 100),
    (1, 6, 1, 200),
    (1, 7, 2, 100),
    (1, 8, 3, 200),
    (1, 9, 4, 100),
    (1, 10, 5, 200);

INSERT INTO `coupoun` (`KID`, `coupoun_name`, `coupoun_des`, `coupoun_quantity_limit`, `coupoun_start_date`, `coupoun_end_date`, `conditions`)
VALUES
    (1, 'Chương trình khuyến mãi Tết Nguyên Đán 2021', 'Nhận ngay ưu đãi hấp dẫn cho năm mới: Mua 3 tặng 1 với một số sản phẩm nhất định', 30, '2021-01-15', '2021-02-14', 3),
    (2, 'Chương trình khuyến mãi Hè Sôi Động 2021', 'Giảm giá cho các sản phẩm mùa hè', 40, '2021-06-01', '2021-06-30', 35000),
    (3, 'Chương trình khuyến mãi Back-to-School 2021', 'Đặc quyền cho học sinh, sinh viên: Mua 4 tặng 1 với một số sản phẩm nhất định', 25, '2021-09-01', '2021-09-30', 4),
    (4, 'Chương trình khuyến mãi Black Friday 2021', 'Mua sắm với giá siêu ưu đãi vào Black Friday', 15, '2021-11-15', '2021-11-30', 50000),
    (5, 'Chương trình khuyến mãi Mua Sắm Cuối Năm 2021', 'Hấp dẫn khi mua sắm cuối năm', 35, '2021-12-10', '2021-12-15', 50000),
    (6, 'Chương trình khuyến mãi Tết Nguyên Đán 2022', 'Nhận ngay ưu đãi hấp dẫn cho năm mới: Mua 5 tặng 2 với một số sản phẩm nhất định', 30, '2022-01-15', '2022-02-14', 5),
    (7, 'Chương trình khuyến mãi Hè Sôi Động 2022', 'Giảm giá cho các sản phẩm mùa hè: Mua 5 tặng 1 với một số sản phẩm nhất định', 40, '2022-06-01', '2022-06-30', 5),
    (8, 'Chương trình khuyến mãi Back-to-School 2022', 'Đặc quyền cho học sinh, sinh viên: Mua 4 tặng 1 với một số sản phẩm nhất định', 25, '2022-09-01', '2022-09-30', 4),
    (9, 'Chương trình khuyến mãi Black Friday 2022', 'Mua sắm với giá siêu ưu đãi vào Black Friday', 15, '2022-11-15', '2022-11-30', 40000),
    (10, 'Chương trình khuyến mãi Mua Sắm Cuối Năm 2022', 'Hấp dẫn khi mua sắm cuối năm', 35, '2022-12-01', '2022-12-15', 70000),
    (11, 'Chương trình khuyến mãi Tết Nguyên Đán 2023', 'Nhận ngay ưu đãi hấp dẫn cho năm mới: Mua 2 tặng 1 với một số sản phẩm nhất định', 30, '2023-01-15', '2023-02-14', 2),
    (12, 'Chương trình khuyến mãi Hè Sôi Động 2023', 'Giảm giá cho các sản phẩm mùa hè', 40, '2023-06-01', '2023-06-30', 130000),
    (13, 'Chương trình khuyến mãi Back-to-School 2023', 'Đặc quyền cho học sinh, sinh viên: Mua 4 tặng 1 với một số sản phẩm nhất định', 25, '2023-09-01', '2023-09-30', 4),
    (14, 'Chương trình khuyến mãi Black Friday 2023', 'Mua sắm với giá siêu ưu đãi vào Black Friday', 15, '2023-11-15', '2023-11-30', 150000),
    (15, 'Chương trình khuyến mãi Mua Sắm Cuối Năm 2023', 'Hấp dẫn khi mua sắm cuối năm', 35, '2023-12-01', '2023-12-15', 40000);

INSERT INTO `coupoun_product` (`KID`, `coupoun_product_quantity`)
VALUES
    (1, 1), -- mua 3 tặng 1
    (3, 1), -- mua 4 tặng 1
    (6, 2), -- mua 5 tặng 2
    (7, 1), -- mua 5 tặng 1
    (8, 1), -- mua 4 tặng 1
    (11, 1), -- mua 2 tặng 1
    (13, 1); -- mua 4 tặng 1

INSERT INTO `product_coupoun_product` (`product_PID`, `coupoun_KID`)
VALUES
    (1, 1),
    (3, 1),
    (6, 1),
    (7, 1), --
    (2, 3),
    (3, 3),
    (9, 3), --
    (5, 6),
    (6, 6), --
    (4, 7), --
    (4, 8),
    (9, 8),
    (10, 8), --
    (3, 11),
    (7, 11), --
    (1, 13),
    (8, 13),
    (10, 13); --

INSERT INTO `coupoun_bill` (`KID`, `coupoun_bill_max_discount`, `flag_cash`, `cash_value`, `flag_percent`, `percent_value`)
VALUES
    --                         min
    (2, 5000, 0, 0, 1, 5), -- 35000
    (4, 0, 1, 8000, 0, 0), -- 50000
    (5, 0, 1, 8000, 0, 0), -- 50000
    (9, 5500, 0, 0, 1, 3), -- 40000
    (10, 10000, 0, 0, 1, 4), -- 70000
    (12, 0, 1, 18000, 0, 0), -- 130000
    (14, 20500, 0, 0, 1, 8), -- 150000
    (15, 0, 1, 5500, 0, 0); -- 40000


INSERT INTO `customer` (`phone`, `name`)
VALUES
    ('0962154875', 'Hương Giang'),
    ('0987653425', 'Nam Anh'),
    ('0953427162', 'Thái Học'),
    ('0762345617', 'Khánh'),
    ('0796473829', 'Đạt'),
    ('0912435674', 'Sỹ'),
    ('0905342671', 'Nhật'),
    ('0934256738', 'Ngọc Ánh');

INSERT INTO `bill` (`BID`, `bill_phone_cus`, `bill_date`)
VALUES
    (1, '0962154875','2021-06-15'),
    (2, '0987653425','2021-06-16'),
    (3, '0953427162', '2021-06-29'),
    (4, '0762345617', '2021-09-02'),
    (5, '0796473829', '2021-09-15'),
    (6, '0912435674', '2021-10-02'),
	(7, '0905342671','2021-10-03'),
	(8, '0934256738','2021-10-5'),
	(9, '0987653425', '2021-11-17'),
	(10, '0987653425', '2021-11-20'),
	(11, '0953427162', '2021-11-25'),
	(12, '0762345617', '2021-11-26'),
	(13, '0796473829', '2021-11-29'),
	(14, '0912435674', '2021-12-05'),
	(15, '0905342671', '2021-12-11'),
	(16, '0934256738','2021-12-11'),
	(17, '0953427162', '2021-12-12'),
	(18, '0987653425','2021-12-13'),
	(19, '0953427162','2021-12-13'),
	(20, '0762345617','2021-12-14'),
	(21, '0796473829','2021-12-14'),
	(22, '0912435674', '2021-12-15'),
	(23, '0905342671', '2021-12-15'),
	(24, '0934256738', '2021-12-30'),
	(25, '0762345617', '2021-12-31');

INSERT INTO `bill` (`BID`, `bill_phone_cus`, `bill_date`, `bill_store`, `bill_AID`)
VALUES
	(26, '0987653425', '2022-02-01', 2, 2),
	(27, '0953427162', '2022-04-30', 2, 2),
	(28, '0762345617','2022-06-01', 2, 2),
	(29, '0796473829', '2022-06-02', 2, 2),
	(30, '0912435674', '2022-06-15', 2, 2),
	(31, '0905342671','2022-09-29', 2, 2),
	(32, '0934256738', '2022-11-22', 2, 2),
	(33, '0796473829', '2022-12-14', 2, 2),
	(34, '0987653425', '2023-01-16', 2, 2),
	(35, '0953427162', '2023-02-28', 2, 2),
	(36, '0762345617', '2023-03-30', 2, 2),
	(37, '0796473829', '2023-06-25', 2, 2),
	(38, '0912435674', '2023-06-29', 2, 2),
	(39, '0905342671', '2023-06-30', 2, 2),
	(40, '0934256738', '2023-09-25', 2, 2),
	(41, '0912435674', '2023-11-16', 2, 2),
	(42, '0987653425', '2023-11-27', 2, 2),
	(43, '0953427162', '2023-11-28', 2, 2),
	(44, '0762345617', '2023-11-29', 2, 2),
	(45, '0796473829', '2023-11-30', 2, 2),
	(46, '0912435674', '2023-12-02', 2, 2),
	(47, '0905342671', '2023-12-02', 2, 2),
	(48, '0934256738', '2023-12-03', 2, 2),
	(49, '0934256738', '2023-12-10', 2, 2),
	(50, '0987653425', '2023-12-14', 2, 2);


INSERT INTO `product_bill` (`product_PID`, `bill_BID`)
VALUES
	(1, 1),(2, 1),(3, 1),(6, 1),(8, 1),
	(2, 2),(3, 2),(4, 2),
	(3, 3),(4, 3),(7, 3),
	(3, 4),
	(3, 5),
	(4, 6),(6, 6),
	(7, 7),(9, 7),(10, 7),
	(8, 8),(9, 8),
	(9, 9),(10, 9),
	(10, 10),
	(3, 11),(4, 11),
	(3, 12),(6, 12),(7, 12),
	(4, 13),(5, 13),(7, 13),(9, 13),
    (1, 14),(10, 14),
    (2, 15),
    (1, 16),(2, 16),
    (1, 17),(3, 17),
    (5, 18),(6, 18),(7, 18),
    (1, 19),(5, 19),
	(3, 20),
	(5, 21),(6, 21),
	(2, 22),(10, 22),
	(3, 23),(4, 23),
	(2, 24),(4, 24),(5, 24),
	(6, 25),
    (6, 26),(7, 26),(10, 26),
	(1, 27),
	(3, 28),
	(1, 29),(3, 29),(4, 29),
	(4, 30),(6, 30),
	(3, 31),(4, 31),
	(2, 32),(7, 32),(8, 32),(9, 32),
	(1, 33),(3, 33),(7, 33),(10, 33),
	(1, 34),(2, 34),(3, 34),(5, 34),
	(5, 35),
	(5, 36),(6, 36),
    (3, 37),
	(4, 38),(5, 38),(7, 38),
	(2, 39),
	(5, 40),(6, 40),(7, 40),
	(1, 41),(2, 41),
	(4, 42),
	(3, 43),
	(3, 44),
	(3, 45),(4, 45),(6, 45),
	(10, 46),
    (8, 47),(9, 47),(10, 47),
    (4, 48),(5, 48),
    (8, 49),(10, 49),
    (1, 50);

INSERT INTO `product_bill_info` (`product_bill_info_PID`, `product_bill_info_BID`, `product_bill_info_quantity`, `product_bill_info_price`)
VALUES
	(1, 1, 1, 45000),(2, 1, 2, 55000),(3, 1, 3, 45000),(6, 1, 4, 57000),(8, 1, 5, 48000),
	(2, 2, 1, 55000),(3, 2, 1, 45000),(4, 2, 1, 55000), 
	(3, 3, 3, 45000),(4, 3, 2, 55000),(7, 3, 1, 40000),
	(3, 4, 5, 45000),
	(3, 5, 1, 45000), 
	(4, 6, 10, 55000),(6, 6, 1, 57000), 
	(7, 7, 1, 40000),(9, 7, 1, 45000),(10, 7, 1, 55000), 
	(8, 8, 1, 48000),(9, 8, 9, 45000), 
	(9, 9, 2, 45000),(10, 9, 3, 55000),
	(10, 10, 1, 55000), 
	(3, 11, 4, 45000),(4, 11, 5, 55000),
	(3, 12, 1, 45000),(6, 12, 1, 57000),(7, 12, 1, 40000), 
	(4, 13, 1, 55000),(5, 13, 2, 48000),(7, 13, 3, 40000),(9, 13, 4, 45000),
    (1, 14, 1, 45000),(10, 14, 1, 55000), 
	(2, 15, 10, 55000),
	(1, 16, 1, 45000),(2, 16, 1, 55000), 
	(1, 17, 2, 45000),(3, 17, 5, 45000),
	(5, 18, 1, 48000),(6, 18, 1, 57000),(7, 18, 1, 40000), 
	(1, 19, 5, 45000),(5, 19, 5, 48000),
	(3, 20, 5, 45000),
	(5, 21, 5, 48000),(6, 21, 1, 57000),
	(2, 22, 1, 55000),(10, 22, 1, 55000), 
	(3, 23, 3, 45000),(4, 23, 3, 55000),
	(2, 24, 5, 55000),(4, 24, 2, 55000),(5, 24, 10, 48000), 
	(6, 25, 3, 57000), 
	(6, 26, 6, 57000),(7, 26, 1, 40000),(10, 26, 1, 55000),
	(1, 27, 2, 45000), 
	(3, 28, 1, 45000), 
	(1, 29, 2, 45000),(3, 29, 2, 45000),(4, 29, 1, 55000),  
	(4, 30, 12, 55000),(6, 30, 1, 57000),
	(3, 31, 3, 45000),(4, 31, 2, 55000), 
	(2, 32, 1, 55000),(7, 32, 1, 40000),(8, 32, 1, 48000),(9, 32, 1, 45000),
	(1, 33, 3, 45000),(3, 33, 3, 45000),(7, 33, 2, 40000),(10, 33, 3, 55000),
	(1, 34, 1, 45000),(2, 34, 1, 55000),(3, 34, 2, 45000),(5, 34, 1, 48000),
	(5, 35, 5, 48000), 
	(5, 36, 1, 48000),(6, 36, 1, 57000), 
	(3, 37, 20, 45000),
	(4, 38, 1, 55000),(5, 38, 1, 48000),(7, 38, 1, 40000), 
	(2, 39, 7, 55000), 
	(5, 40, 1, 48000),(6, 40, 1, 57000),(7, 40, 1, 40000), 
	(1, 41, 10, 45000),(2, 41, 20, 55000),
	(4, 42, 1, 55000), 
    (3, 43, 4, 45000), 
    (3, 44, 1, 45000), 
    (3, 45, 10, 45000),(4, 45, 3, 55000),(6, 45, 6, 57000),
	(10, 46, 1, 55000), 
    (8, 47, 3, 48000),(9, 47, 1, 45000),(10, 47, 2, 55000),
    (4, 48, 1, 55000),(5, 48, 1, 48000), 
    (8, 49, 2, 48000),(10, 49, 4, 55000),
    (1, 50, 1, 45000); 

Call checkIfDiscount(1);
Call checkIfDiscount(2);
Call checkIfDiscount(3);
Call checkIfDiscount(4);
Call checkIfDiscount(5);
Call checkIfDiscount(6);
Call checkIfDiscount(7);
Call checkIfDiscount(8);
Call checkIfDiscount(9);
Call checkIfDiscount(10);
Call checkIfDiscount(11);
Call checkIfDiscount(12);
Call checkIfDiscount(13);
Call checkIfDiscount(14);
Call checkIfDiscount(15);
Call checkIfDiscount(16);
Call checkIfDiscount(17);
Call checkIfDiscount(18);
Call checkIfDiscount(19);
Call checkIfDiscount(20);
Call checkIfDiscount(21);
Call checkIfDiscount(22);
Call checkIfDiscount(23);
Call checkIfDiscount(24);
Call checkIfDiscount(25);
Call checkIfDiscount(26);
Call checkIfDiscount(27);
Call checkIfDiscount(28);
Call checkIfDiscount(29);
Call checkIfDiscount(30);
Call checkIfDiscount(31);
Call checkIfDiscount(32);
Call checkIfDiscount(33);
Call checkIfDiscount(34);
Call checkIfDiscount(35);
Call checkIfDiscount(36);
Call checkIfDiscount(37);
Call checkIfDiscount(38);
Call checkIfDiscount(39);
Call checkIfDiscount(40);
Call checkIfDiscount(41);
Call checkIfDiscount(42);
Call checkIfDiscount(43);
Call checkIfDiscount(44);
Call checkIfDiscount(45);
Call checkIfDiscount(46);
Call checkIfDiscount(47);
Call checkIfDiscount(48);
Call checkIfDiscount(49);
Call checkIfDiscount(50);
    
UPDATE bill
SET state = 2
;

INSERT INTO `gift` (`GID`, `gift_name`, `gift_score`)
VALUES
    (1, '1 Gấu bông', 3000),
    (2, '1 Ly giữ nhiệt', 1500),
    (3, '1 Móc chìa khóa', 500),
    (4, '1 Giá đỡ điện thoại', 700),
    (5, '1 Cục sạc dự phòng', 5000);

INSERT INTO `customer_gift` (`customer_phone`, `gift_GID`, `quantity`, `date`)
VALUES
    ('0796473829', 2, 2, '2023-12-01'),
    ('0953427162', 2, 1, '2023-12-02'),
    ('0962154875', 3, 1, '2023-12-04'),
    ('0912435674', 1, 1, '2023-12-04'),
    ('0934256738', 2, 1, '2023-12-05'),
    ('0934256738', 3, 1, '2023-12-06'),
    ('0987653425', 3, 1, '2023-12-06'),
    ('0987653425', 4, 1, '2023-12-06'),
    ('0905342671', 2, 1, '2023-12-07');
