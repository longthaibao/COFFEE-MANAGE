const { thutuc2 } = require('../../PersistenceLayer/Thutuc2');

const formatDate = (date) => {
    const localDate = new Date(date);
    const day = localDate.getDate();
    const month = localDate.getMonth() + 1; // Tháng bắt đầu từ 0
    const year = localDate.getFullYear();
    return `${day}/${month}/${year}`;
};

const Thutuc2 = async (req, res) => {
    let data = await thutuc2(req.body.revenue, req.body.year);

    data = data.map(entry => ({
        ...entry,
        'Ngày bắt đầu (ngày/tháng/năm)': formatDate(entry['Ngày bắt đầu (ngày/tháng/năm)']),
        'Ngày kết thúc (ngày/tháng/năm)': formatDate(entry['Ngày kết thúc (ngày/tháng/năm)']),
    }));
    return res.status(200).json(data);
};

module.exports = { Thutuc2 };


    // (1, 1),
    // (2, 1),
    // (3, 1),
    // (6, 1),
    // (8, 1),

    // (2, 2),
    // (3, 2),
    // (4, 2),

    // (3, 3),
    // (4, 3),
    // (7, 3),

    // (3, 4),

    // (3, 5),

    // (4, 6),
    // (6, 6),

    // (7, 7),
    // (9, 7),
    // (10, 7),

    // (8, 8),
    // (9, 8),

    // (9, 9),
    // (10, 9),

    // (10, 10),

    // (3, 11),
    // (4, 11),

    // (3, 12),
    // (6, 12),
    // (7, 12),

    // (4, 13),
    // (5, 13),
    // (7, 13),
    // (9, 13),

    // (1, 14),
    // (10, 14),

    // (2, 15),

    // (1, 16),
    // (2, 16),

    // (1, 17),
    // (3, 17),

    // (5, 18),
    // (6, 18),
    // (7, 18),

    // (1, 19),
    // (5, 19),

    // (2, 20),

	// (5, 21),
    // (6, 21),

	// (2, 22),
    // (10, 22),

	// (3, 23),
    // (4, 23),
    
	// (2, 24),
    // (4, 24),
    // (5, 24),

	// (5, 25),

	// (6, 26),
    // (7, 26),
    // (10, 26),

	// (1, 27),

	// (3, 28),

	// (1, 29),
    // (3, 29),
    // (4, 29),

	// (4, 30),
    // (6, 30),

	// (3, 31),
    // (4, 31),

	// (2, 32),
    // (7, 32),
    // (8, 32),
    // (9, 32),

	// (1, 33),
    // (3, 33),
    // (7, 33),
    // (10, 33),

	// (1, 34),
    // (2, 34),
    // (3, 34),
    // (5, 34),

	// (5, 35),

	// (5, 36),
    // (6, 36),

	// (3, 37),

	// (4, 38),
    // (5, 38),
    // (7, 38),

	// (2, 39),

	// (5, 40),
    // (6, 40),
    // (7, 40),

	// (1, 41),
    // (2, 41),

	// (4, 42),

	// (3, 43),

	// (3, 44),

	// (3, 45),
    // (4, 45),
    // (6, 45),

	// (10, 46),

	// (8, 47),
    // (9, 47),
    // (10, 47),

	// (4, 48),
    // (5, 48),
    
	// (8, 49),
    // (10, 49),
	// (1, 50);

    // (1, 1, 1, 10000),
	// (2, 1, 2, 10000),
	// (3, 1, 3, 10000),
	// (6, 1, 4, 10000),
	// (8, 1, 5, 10000),

	// (2, 2, 1, 10000),
	// (3, 2, 1, 10000),
	// (4, 2, 1, 10000), -- NONE BILL

	// (3, 3, 3, 10000),
	// (4, 3, 2, 10000),
	// (7, 3, 1, 10000),
	// -- end bill 2
    // -- start product 3
	// (3, 4, 5, 10000),
    // (3, 4, 1, 0),

	// (3, 5, 1, 10000), -- NONE PRODUCT
	// -- end product 3
	// (4, 6, 10, 10000), -- NONE
	// (6, 6, 1, 10000), 

	// (7, 7, 1, 10000), -- NONE
	// (9, 7, 1, 10000),
	// (10, 7, 1, 10000),

	// (8, 8, 1, 10000), -- NONE
	// (9, 8, 9, 10000),
    // -- start bill 4
	// (9, 9, 2, 10000),
	// (10, 9, 3, 10000),

	// (10, 10, 1, 10000), -- NON BILL

	// (3, 11, 4, 10000),
	// (4, 11, 5, 10000),

	// (3, 12, 1, 10000),
	// (6, 12, 1, 10000),
	// (7, 12, 1, 10000), -- NON BILL

	// (4, 13, 1, 10000),
	// (5, 13, 2, 10000),
	// (7, 13, 3, 10000),
	// (9, 13, 4, 10000), 
	// -- end bill 4
	// (1, 14, 1, 10000),
	// (10, 14, 1, 10000), -- NONE
	// -- start bill 5
	// (2, 15, 10, 10000), 

	// (1, 16, 1, 10000),
	// (2, 16, 1, 10000), -- NONE BILL

	// (1, 17, 2, 10000),
	// (3, 17, 5, 10000), 

	// (5, 18, 1, 10000),
	// (6, 18, 1, 10000),
	// (7, 18, 1, 10000), -- NONE BILL

	// (1, 19, 5, 10000),
	// (5, 19, 5, 10000), 

	// (3, 20, 5, 10000), 

	// (5, 21, 5, 10000), 
	// (6, 21, 1, 10000),

	// (2, 22, 1, 10000),
	// (10, 22, 1, 10000), -- NONE BILL

	// (3, 23, 3, 10000),
	// (4, 23, 3, 10000),
	// -- end bill 5
	// (2, 24, 5, 10000),
	// (4, 24, 2, 10000),
	// (5, 24, 10, 10000), -- NONE

	// (6, 25, 3, 10000), -- NONE
    // -- start product 6
	// (6, 26, 6, 10000),
    // (6, 26, 2, 0),
	// (7, 26, 1, 10000),
	// (10, 26, 1, 10000),
	// -- end product 6
	// (1, 27, 2, 10000), -- NONE
	// -- start product 7
	// (3, 28, 1, 10000), -- NONE PRODUCT
    
	// (1, 29, 2, 10000), -- NONE PRODUCT 
	// (3, 29, 2, 10000),
	// (4, 29, 1, 10000),

	// (4, 30, 12, 10000),
    // (4, 30, 2, 0),
	// (6, 30, 1, 10000), 
	// -- end product 7
    // -- start product 8
	// (3, 31, 3, 10000),
	// (4, 31, 2, 10000), -- NONE PRODUCT
	// -- end product 8
    // -- start bill 9
	// (2, 32, 1, 10000),
	// (7, 32, 1, 10000),
	// (8, 32, 1, 10000),
	// (9, 32, 1, 10000), -- NONE BILL
    // -- end bill 9
    // -- start bill 10
	// (1, 33, 3, 10000),
	// (3, 33, 3, 10000),
	// (7, 33, 2, 10000),
	// (10, 33, 3, 10000),
	// -- end bill 10
    // -- start product 11
	// (1, 34, 1, 10000),
	// (2, 34, 1, 10000),
	// (3, 34, 2, 10000),
    // (3, 34, 1, 0),
	// (5, 34, 1, 10000),
	// -- end product 11
	// (5, 35, 5, 10000), -- NONE

	// (5, 36, 1, 10000),
	// (6, 36, 1, 10000), -- NONE
	// -- start bill 12
	// (3, 37, 20, 10000),

	// (4, 38, 1, 10000),
	// (5, 38, 1, 10000),
	// (7, 38, 1, 10000), -- NONE BILL

	// (2, 39, 7, 10000), -- NONE BILL
	// -- end bill 12
    // -- start product 13
	// (5, 40, 1, 10000), -- NONE PRODUCT
	// (6, 40, 1, 10000),
	// (7, 40, 1, 10000),
    // -- end product 13
    // -- start bill 14
	// (1, 41, 10, 10000),
	// (2, 41, 20, 10000),

	// (4, 42, 1, 10000), -- NONE BILL
	
	// (3, 43, 4, 10000), -- NONE BILL

	// (3, 44, 1, 10000), -- NONE BILL

	// (3, 45, 10, 100000), 
	// (4, 45, 3, 10000),
	// (6, 45, 6, 10000),
	// -- end bill 14
    // -- start 15
	// (10, 46, 1, 10000), -- NONE BILL

	// (8, 47, 3, 10000), 
	// (9, 47, 1, 10000),
	// (10, 47, 2, 10000),

	// (4, 48, 1, 10000),
	// (5, 48, 1, 10000), -- NONE BILL

	// (8, 49, 2, 10000),
	// (10, 49, 4, 10000),

	// (1, 50, 1, 10000); -- NONE BILL
    // -- end bill 15

    // (1, 1, 243000, 1, '111-222-3333'),
    // (2, 1, 56000, 2, '222-333-4444'),
    // (3, 1, 128000, 1, '333-444-5555'),
    // (4, 1, 155000, 2, '444-555-6666'),
    // (5, 1, 178000, 1, '555-666-7777'),
    // (6, 1, 102000, 2, '666-777-8888'),
    // (7, 1, 225000, 1, '777-888-9999'),
    // (8, 1, 207000, 2, '888-999-0000'),
    // (9, 1, 152000, 1, '999-000-1111'),
    // (10, 1, 181000, 2, '111-000-9999'),
    // (11, 1, 157000, 1, '222-111-8888'),
    // (12, 1, 225000, 2, '333-222-7777'),
    // (13, 1, 193000, 1, '444-333-6666'),
    // (14, 1, 78000, 2, '555-444-5555'),
    // (15, 1, 217000, 1, '666-555-4444'),
    // (16, 1, 223000, 2, '777-666-3333'),
    // (17, 1, 111000, 1, '888-777-2222'),
    // (18, 1, 110000, 2, '999-888-1111'),
    // (19, 1, 239000, 1, '111-999-0000'),
    // (20, 1, 94000, 2, '222-000-9999'),
    // (21, 1, 164000, 1, '333-111-8888'),
    // (22, 1, 57000, 2, '444-222-7777'),
    // (23, 1, 249000, 1, '555-333-6666'),
    // (24, 1, 202000, 2, '666-444-5555'),
    // (25, 1, 192000, 1, '777-555-4444'),
    // (26, 1, 107000, 2, '888-666-3333'),
    // (27, 1, 71000, 1, '999-777-2222'),
    // (28, 1, 213000, 2, '111-888-1111'),
    // (29, 1, 89000, 1, '222-999-0000'),
    // (30, 1, 157000, 2, '333-000-9999'),
    // (31, 1, 177000, 1, '444-111-8888'),
    // (32, 1, 127000, 2, '555-222-7777'),
    // (33, 1, 246000, 1, '666-333-6666'),
    // (34, 1, 178000, 2, '777-444-5555'),
    // (35, 1, 59000, 1, '888-555-4444'),
    // (36, 1, 183000, 2, '999-666-3333'),
    // (37, 1, 114000, 1, '111-777-2222'),
    // (38, 1, 104000, 2, '222-888-1111'),
    // (39, 1, 114000, 1, '333-999-0000'),
    // (40, 1, 199000, 2, '444-000-9999'),
    // (41, 1, 195000, 1, '555-111-8888'),
    // (42, 1, 219000, 2, '666-222-7777'),
    // (43, 1, 135000, 1, '777-333-6666'),
    // (44, 1, 181000, 2, '888-444-5555'),
    // (45, 1, 144000, 1, '999-555-4444'),
    // (46, 1, 224000, 2, '111-666-3333'),
    // (47, 1, 194000, 1, '222-777-2222'),
    // (48, 1, 179000, 2, '333-888-1111'),
    // (49, 1, 192000, 1, '444-999-0000'),
    // (50, 1, 72000, 2, '555-000-9999');