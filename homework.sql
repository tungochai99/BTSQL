use LOGISTIC;

# 1 Viết câu truy vấn trả về tên nước, tên cảng, mã cảng
		select c.NAME, p.NAME, p.PORT_ID
        from COUNTRY c left join PORT p on c.ID = p.COUNTRY
        order by c.NAME,p.NAME;
        
# 2 Viết câu truy vấn trả về thông tin người dùng gồm first name, last name, email, phone, tên nước
		SELECT u.FIRST_NAME,
			u.LAST_NAME,
            u.EMAIl,
            u.PHONE,
            c.NAME AS `COUNTRY`
        FROM USER u LEFT JOIN COUNTRY c ON u.COUNTRY = c.ID
        ORDER BY c.NAME, u.FIRST_NAME;
# 3 Viết câu truy vấn trả về thông tin của hành trình (voyage) gồm ID hành trình, tên tuyến (route), 
#	tên tàu, ngày bắt đầun, ngày kết thúc
		SELECT v.VOYAGE_ID,
			r.NAME ROUTE_NAME,
            s.NAME SHIP_NAME,
            v.START_DATE,
            v.END_DATE
        FROM VOYAGE v LEFT JOIN ROUTE r ON v.ROUTE_ID = r.ROUTE_ID
					  LEFT JOIN SHIP s ON v.SHIP_ID = s.SHIP_ID
		ORDER BY r.NAME, s.NAME;
# 4 Viết câu truy vấn trả về thông tin tất cả shipment của tuyến có tên là 'prado'
		SELECT sh.SHIPMENT_ID,
			sh.CARGO_CONTENT,
			sh.TEQ_QUANTITY,
			sh.TOTAL_COST,
			sh.STATUS,
			vr.NAME
		FROM SHIPMENT sh
				LEFT JOIN (SELECT v.VOYAGE_ID, r.NAME, vs.SHIPMENT_ID FROM VOYAGE v, ROUTE r, VOYAGE_SHIPMENT vs
				    WHERE v.ROUTE_ID = r.ROUTE_ID
						AND v.VOYAGE_ID = vs.VOYAGE_ID
						AND r.NAME = 'Prado' ) vr
								ON sh.SHIPMENT_ID = vr.SHIPMENT_ID;
			SELECT * FROM ROUTE;
# 5 Viết câu truy vấn để lấy thông tin của tất cả khách hàng đã có ít nhất 1 đơn hàng
		select us.USER_ID, u.LOGIN_NAME, u.FIRST_NAME, u.LAST_NAME, u.PHONE, u.EMAIL, u.ADDRESS, u.CITY, u.STATE, u.POSTAL_CODE, u.COUNTRY, u.ROLE, u.PASSWORD, u.IS_DELETED
        from USER u inner join (USER_SHIPMENT us inner join SHIPMENT s on us.SHIPMENT_ID = s.SHIPMENT_ID) 
								on u.USER_ID = us.USER_ID
		group by u.USER_ID, us.USER_ID
        having count(u.USER_ID) >= 1
        order by u.USER_ID;
        
##	5.1	Viết câu truy vấn để lấy thông tin của tất cả khách hàng đã có ít nhất 2 đơn hàng
		select us.USER_ID, u.LOGIN_NAME, u.FIRST_NAME, u.LAST_NAME, u.PHONE, u.EMAIL, u.ADDRESS, u.CITY, u.STATE, u.POSTAL_CODE, u.COUNTRY, u.ROLE, u.PASSWORD, u.IS_DELETED
        from USER u inner join (USER_SHIPMENT us inner join SHIPMENT s on us.SHIPMENT_ID = s.SHIPMENT_ID) 
								on u.USER_ID = us.USER_ID
		group by u.USER_ID, us.USER_ID
        having count(u.USER_ID) >= 2
        order by u.USER_ID;


##	6.	Viết câu truy vấn trả về thông tin của hành trình gồm ID, ngày bắt đầu, ngày kết thúc, tên tuyến, tên tàu,
##		thông tin các shipment của hành trình gồm ID, cargo content, số lượng teq, tổng giá trị, tình trạng
##		nâng cao: lấy thêm thông tin: cảng khởi hàng và cảng đến
		select v.VOYAGE_ID, v.START_DATE, v.END_DATE, r.NAME, s.NAME, sm.SHIPMENT_ID, sm.CARGO_CONTENT, sm.TEQ_QUANTITY, sm.TOTAL_COST
        from ((VOYAGE v inner join SHIP s on v.SHIP_ID = s.SHIP_ID) inner join ROUTE r on v.ROUTE_ID = r.ROUTE_ID) 
						inner join (VOYAGE_SHIPMENT vs inner join SHIPMENT sm on vs.SHIPMENT_ID = sm.SHIPMENT_ID) on v.VOYAGE_ID = vs.VOYAGE_ID;
		
        

##	Viết câu truy vấn trả về thông tin khách hàng gồm: Full name, 
##	địa chỉ (gồm tên đường, thành phố, bang), phone, email,  tên quốc gia

		select u.FIRST_NAME, u.LAST_NAME, u.PHONE, u.EMAIL, u.ADDRESS, u.CITY, u.STATE, u.COUNTRY
        from USER u