INSERT INTO `job_role` (`JID`, `job_type`)
VALUES
    (1, 'Quản lý'),
    (2, 'Thu nhân'),
    (3, 'Pha chế'),
    (4, 'Bảo vệ'),
    (5, 'Tạp vụ');

INSERT INTO `store` (`SID`, `store_name`, `store_phone`, `store_des`, `store_add`)
VALUES
    (1, 'Cửa hàng Lý Thường Kiệt', '0902534178', 'Quán cà phê ấm cúng trên đường Lý Thường Kiệt, nơi hòa quyện hương vị đặc trưng và không khí ấm áp của thành phố.', '268 Lý Thường Kiệt, Phường 14, Quận 10, Thành phố Hồ Chí Minh'),
    (2, 'Cửa hàng Tạ Quang Bửu', '0281563428', 'Cà phê Tạ Quang Bửu, chỉ cách kí túc xá khu A 100m và luôn phục vụ 24/7, hứa hẹn mang lại trải nghiệm đầy tiện lợi và thoải mái cho khách hàng.', 'Hẻm chui, Đường Tạ Quang Bửu, Khu phố 6, Phường Linh Trung, Thành phố Thủ Đức, Thành phố Hồ Chí Minh.');

INSERT INTO `employee` (`ID`, `employee_name`, `employee_gender`, `employee_email`, `employee_SID`, `employee_MID`)
VALUES
    (1, 'Lìu Ngọc Yến', 'Nữ', 'yenliu@gmail.com', 2, 1),
    (2, 'Lê Quốc An', 'Nam', 'anlequoc@gmail.com', 1, 2),
    (3, 'Thái Bảo Long', 'Nam', 'longthaibao@gmail.com', 1, 2),
    (4, 'Nguyễn Ngọc Bảo Châu', 'Nữ', 'chaunguyen@gmail.com', 2, 1),
    (5, 'Nguyễn Phan Minh Phúc', 'Nma', 'phucminh@gmail.com',2,1);

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
    (5, 4);

INSERT INTO `account` (`AID`, `username`, `password`, `employee_ID`)
VALUES
    (1, 'lequocan', '1234567', 2),
    (2, 'liungocyen', '7654321', 1);

INSERT INTO `product` (`PID`, `product_name`, `product_price`, `product_size`, `product_image`)
VALUES
	(1, 'Espresso', 45000, 'M', 'espresso_image.jpg'),
    (2, 'Espresso', 55000, 'L', 'espresso_image.jpg'),
    (3, 'Cappuccino', 45000, 'M', 'cappuccino_image.jpg'),
    (4, 'Cappuccino', 55000, 'L', 'cappuccino_image.jpg'),
    (5, 'Latte', 48000, 'M', 'latte_image.jpg'),
    (6, 'Latte', 57000, 'L', 'latte_image.jpg'),
    (7, 'Mocha', 40000, 'M', 'mocha_image.jpg'),
    (8, 'Mocha', 48000, 'L', 'mocha_image.jpg'),
    (9, 'Americano', 45000, 'M', 'americano_image.jpg'),
    (10, 'Americano', 55000, 'L', 'americano_image.jpg'),
    (11, 'Flat White', 50000, 'M', 'flat_white_image.jpg'),
    (12, 'Flat White', 51000, 'L', 'flat_white_image.jpg'),
    (13, 'Caramel Macchiato', 50000, 'M', 'caramel_macchiato_image.jpg'),
    (14, 'Caramel Macchiato', 58000, 'L', 'caramel_macchiato_image.jpg'),
    (15, 'Iced Coffee', 30000, 'M', 'iced_coffee_image.jpg'),
    (16, 'Iced Coffee', 35000, 'L', 'iced_coffee_image.jpg'),
    (17, 'Affogato', 40000, 'M', 'affogato_image.jpg'),
    (18, 'Affogato', 50000, 'L', 'affogato_image.jpg'),
    (19, 'Vietnamese Coffee', 30000, 'M', 'vietnamese_coffee_image.jpg'),
    (20, 'Vietnamese Coffee', 35000, 'L', 'vietnamese_coffee_image.jpg'),
    (21, 'Cappuccino Light', 45000, 'M', 'cappuccino_light_image.jpg'),
    (22, 'Cappuccino Light', 50000, 'L', 'cappuccino_light_image.jpg'),
    (23, 'Hazelnut Latte', 45000, 'M', 'hazelnut_latte_image.jpg'),
    (24, 'Hazelnut Latte', 56000, 'L', 'hazelnut_latte_image.jpg'),
    (25, 'Decaf Espresso', 45000, 'M', 'decaf_espresso_image.jpg'),
    (26, 'Decaf Espresso', 54000, 'L', 'decaf_espresso_image.jpg'),
    (27, 'Iced Mocha', 50000, 'M', 'iced_mocha_image.jpg'),
    (28, 'Iced Mocha', 60000, 'L', 'iced_mocha_image.jpg'),
    (29, 'Caramel Iced Latte', 30000, 'M', 'caramel_iced_latte_image.jpg'),
    (30, 'Caramel Iced Latte', 40000, 'L', 'caramel_iced_latte_image.jpg');

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

INSERT INTO `customer` (`phone`, `name`, `score`,`deleted`)
VALUES
    ('0962154875', 'Hương Giang', 100,false),
    ('0987653425', 'Nam Anh', 10,false),
    ('0953427162', 'Thái Học', 0,false),
    ('0762345617', 'Khánh', 30,false),
    ('0796473829', 'Đạt', 50,false),
    ('0912435674', 'Sỹ', 120,false),
    ('0905342671', 'Nhật', 170,false),
    ('0934256738', 'Ngọc Ánh', 150,false);

INSERT INTO `bill` (`BID`, `bill_sum`, `bill_store`, `bill_phone_cus`)
VALUES
    (1, 60000, 1, '0962154875'),
    (2, 40000, 2, '0987653425'),
	(3, 25, 1, '0987653425'),
    (4, 50, 2, '0987653425'),
    (5, 35, 1, '0962154875'),
    (6, 60, 2, '0934256738'),
    (7, 28, 1, '0987653425'),
    (8, 45, 2, '0962154875'),
    (9, 32, 1, '0934256738'),
    (10, 55, 2, '0962154875'),
    (11, 40, 1, '0934256738'),
    (12, 48, 2, '0934256738'),
    (13, 33, 1, '0934256738'),
    (14, 62, 2, '0934256738'),
    (15, 38, 1, '0762345617'),
    (16, 53, 2, '0905342671'),
    (17, 42, 1, '0912435674'),
    (18, 57, 2, '0912435674'),
    (19, 36, 1, '0912435674'),
    (20, 48, 2, '0762345617');
    
INSERT INTO `product_bill` (`product_PID`, `bill_BID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `product_bill_info` (`product_bill_info_PID`, `product_bill_info_BID`, `product_bill_info_quantity`, `product_bill_info_price`)
VALUES
    (1, 1, 2, 20),
    (2, 2, 3, 30);

INSERT INTO `gift` (`GID`, `gift_name`, `gift_score`)
VALUES
    (1, 'Gấu bông', 50),
    (2, 'Ly giữ nhiệt', 30);

INSERT INTO `customer_gift` (`customer_phone`, `gift_GID`, `quantity`, `date`)
VALUES
    ('0762345617', 1, 1, '2023-12-01'),
    ('0912435674', 2, 2, '2023-12-02');

INSERT INTO `store_product` (`product_PID`, `store_SID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `sup_material` (`material_MID`, `sup_supID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `recipe` (`product_PID`, `RID`, `recipe_des`)
VALUES
    (1, 1, 'Recipe for Product A'),
    (2, 2, 'Recipe for Product B');

INSERT INTO `recipe_material` (`material_MID`, `product_PID`, `recipe_RID`, `quantity`)
VALUES
    (1, 1, 1, 3),
    (2, 2, 2, 4);

INSERT INTO `time_store` (`time_store_SID`, `open_time`, `close_time`, `date`)
VALUES
    (1, '09:00:00', '18:00:00', '2023-12-05'),
    (2, '10:30:00', '20:00:00', '2023-12-06');

INSERT INTO `coupoun` (`KID`, `coupoun_name`, `coupoun_des`, `coupoun_quantity_limit`, `coupoun_used_quantity`, `coupoun_start_date`, `coupoun_end_date`, `conditions`)
VALUES
    (1, 'Coupon X', 'Description X', 50, 10, '2023-12-01', '2023-12-10', 1),
    (2, 'Coupon Y', 'Description Y', 30, 5, '2023-12-05', '2023-12-15', 2),
    (3, 'Coupon Z', 'Description Z', 40, 8, '2023-12-10', '2023-12-20', 1),
    (4, 'Coupon W', 'Description W', 25, 3, '2023-12-15', '2023-12-25', 2),
    (5, 'Coupon A', 'Description A', 30, 7, '2023-12-05', '2023-12-15', 1),
    (6, 'Coupon B', 'Description B', 20, 5, '2023-12-12', '2023-12-22', 2),
    (7, 'Coupon C', 'Description C', 35, 6, '2023-12-08', '2023-12-18', 1),
    (8, 'Coupon D', 'Description D', 22, 4, '2023-12-18', '2023-12-28', 2),
    (9, 'Coupon E', 'Description E', 28, 9, '2023-12-03', '2023-12-13', 1),
    (10, 'Coupon F', 'Description F', 18, 2, '2023-12-22', '2023-12-30', 2),
    (11, 'Coupon G', 'Description G', 33, 5, '2023-12-14', '2023-12-24', 1),
    (12, 'Coupon H', 'Description H', 15, 1, '2023-12-20', '2023-12-30', 2),
    (13, 'Coupon I', 'Description I', 25, 6, '2023-12-07', '2023-12-17', 1),
    (14, 'Coupon J', 'Description J', 12, 3, '2023-12-23', '2023-12-31', 2),
    (15, 'Coupon K', 'Description K', 20, 4, '2023-12-09', '2023-12-19', 1),
    (16, 'Coupon L', 'Description L', 10, 1, '2023-12-28', '2023-12-31', 2),
    (17, 'Coupon M', 'Description M', 30, 8, '2023-12-11', '2023-12-21', 1),
    (18, 'Coupon N', 'Description N', 18, 3, '2023-12-16', '2023-12-26', 2),
    (19, 'Coupon O', 'Description O', 25, 7, '2023-12-06', '2023-12-16', 1),
    (20, 'Coupon P', 'Description P', 15, 2, '2023-12-27', '2023-12-31', 2);

INSERT INTO `coupoun_product` (`KID`, `coupoun_product_quantity`)
VALUES
    (1, 2),
    (2, 3);

INSERT INTO `coupoun_bill` (`KID`, `coupoun_bill_max_discount`, `flag_cash`, `cash_value`, `flag_percent`, `percent_value`)
VALUES
    (1, 10, 1, 5, 0, 0),
    (2, 15, 0, 0, 1, 20),
    (3, 12, 1, 6, 0, 0),
    (4, 18, 0, 0, 1, 25),
    (5, 10, 1, 5, 0, 0),
    (6, 15, 0, 0, 1, 20),
    (7, 12, 1, 6, 0, 0),
    (8, 18, 0, 0, 1, 25),
    (9, 10, 1, 5, 0, 0),
    (10, 15, 0, 0, 1, 20),
    (11, 12, 1, 6, 0, 0),
    (12, 18, 0, 0, 1, 25),
    (13, 10, 1, 5, 0, 0),
    (14, 15, 0, 0, 1, 20),
    (15, 12, 1, 6, 0, 0),
    (16, 18, 0, 0, 1, 25),
    (17, 10, 1, 5, 0, 0),
    (18, 15, 0, 0, 1, 20),
    (19, 12, 1, 6, 0, 0),
    (20, 18, 0, 0, 1, 25);

INSERT INTO `product_coupoun_product` (`product_PID`, `coupoun_KID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `bill_coupoun_bill` (`bill_BID`, `coupoun_KID`, `discount_value`)
VALUES
    (1, 1, 8),
    (2, 2, 12),
    (3, 1, 10),
    (4, 2, 15),
    (5, 1, 8),
    (6, 2, 12),
    (7, 1, 10),
    (8, 2, 15),
    (9, 1, 8),
    (10, 2, 12),
    (11, 1, 10),
    (12, 2, 15),
    (13, 1, 8),
    (14, 2, 12),
    (15, 1, 10),
    (16, 2, 15),
    (17, 1, 8),
    (18, 2, 12),
    (19, 1, 10),
    (20, 2, 15);