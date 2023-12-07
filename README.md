# FRONTEND
- Sửa trong client/src:
- Trang thủ tục themxoasua, thủ tục 1,2 đã thêm sẵn rồi, mn sửa trong client/src/pages/admin/ nha (thiếu trang nào thì thêm vào)
- Do mỗi trang là một nút trên SIDEBAR nên khi thêm trang nhớ thêm vào client/src/layout/admin/Sidebar.js với src\App.js luôn
- Mn tự viết API phần mình phía backend rồi thêm vào đây util/API.js

# BACKEND
- Code trong server:
- PersistenceLayer: kết nối database, xử lý query, trả về data cho BusinessLayer
- BusinessLayer: xử lí data trả về từ PersistenceLayer (data sau khi được xử lý sẽ trả về cho phía Client)
- routes: xác định API nào sẽ gọi hàm nào trong BusinessLayer
- server.js: import route ứng với API tương ứng
- .env: sửa password theo máy mỗi người
- btl_csdl_sql: sửa code sql

# Để chạy cần tải dependencies
### Client
```bash
cd client
npm install
```
### Server
```bash
cd server
npm i dotenv
```

# Lệnh Chạy
### Server
- cd folder server chạy lệnh **npm start** chạy trên port 3001
### Client
- cd folder client chạy lệnh **npm start** chạy trên port 3000
***

# Đăng Nhập
### Các TK/MK để đăng nhập (lấy từ bảng account)
- 'john_doe', 'password123'
- 'jane_smith', 'securepass'