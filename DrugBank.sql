--drop database DrugBank;
create database DrugBank;
use DrugBank;

create table Company(
GCN nvarchar(20) primary key,
name nvarchar(300) not null,
address nvarchar(300) not null,
phone nvarchar(15),
imgURL varchar(1000));

create table Medicine(
regNumber varchar(12) primary key,
name nvarchar(50) not null,
Rx bit not null,
dosageForm nvarchar(50) not null,
EXPDate nvarchar(50),
GCN nvarchar(20) foreign key references Company(GCN),
imgURL varchar(1000),
);

create table Ingredent(
name nvarchar(50) primary key,
formula varchar(50),
description nvarchar(500)
);

create table Med_Ingre(
medReg  varchar(12) foreign key references Medicine(regNumber),
ingreName nvarchar(50) foreign key references Ingredent(name),
dosageAmount varchar(20),
primary key (medReg,ingreName)
);

create table Role(
id int IDENTITY(1,1) PRIMARY KEY,
name nvarchar(50)
);

create table Account(
UUID varchar(37) primary key,
username nvarchar(100) not null unique,
password nvarchar(100) not null,
email nvarchar(100) not null,
phone nvarchar(15),
roleid int foreign key references Role(id)
);

create table Prescription (
UUID varchar(37),
ID int IDENTITY(200,1),
patientName nvarchar(100),
doctorName nvarchar(100),
age int,
weight int not null,
height int not null,
[date] date not null,
diagnose nvarchar(500),
medicalHistory nvarchar(500),
Note nvarchar(500),
primary key (UUID, ID),
foreign key (UUID) references Account(UUID)
);

create table Pres_Med (
UUID varchar(37),
presID int,
medReg varchar(12),
note nvarchar(300),
primary key (UUID, presID, medReg),
foreign key (UUID, presID) references Prescription(UUID, ID),
foreign key (medReg) references Medicine(regNumber)
);


--Example Data
INSERT INTO Company (GCN, name, address, phone,imgURL)
VALUES
(N'29/DKKĐ-BYT', N'CÔNG TY CP DƯỢC HẬU GIANG', N'289 phố Nguyễn Văn Cừ, Ninh Kiều, Cần Thơ', '02923821010',N'https://kinhtechungkhoan.vn/stores/news_dataimages/2022/112022/11/09/in_article/a8c4504b24469ff61042f4ec339a428a.jpg?rt=20221111091817'),
(N'226/ĐKKDD-BYT', N'CÔNG TY TNHH B.BRAUN VIỆT NAM', N'Lô CN4, KCN Quang Minh, Hà Nội', '02433641010',N'https://www.bbraun.com.vn/content/dam/b-braun/vn/website/homepage/BBVN%20Hero-02.png.transform/1200/image.jpg'),
(N'348/ĐKKDD-BYT', N'CÔNG TY TNHH LIÊN DOANH STELLAPHARM', N'Lô G-5, Đường số 9, KCN Tân Tạo, TP.HCM', '02838720618',N'https://www.vietphat.net.vn/Upload/files/Untitled-96_1140.png'),
(N'70/ĐKKDD-BYT', N'CÔNG TY CP TRAPHACO', N'75 Yên Ninh, Ba Đình, Hà Nội', '02438245115',N'https://traphaco.com.vn/upload/images/Tin%20t%E1%BB%A9c/2021/photo1635143989487-16351439895941179873547%20(1).jpg'),
(N'217/ĐKKDD-BTY', N'CÔNG TY CP DƯỢC PHẨM HÀ TÂY', N'Khu CN Ngọc Hồi, Hoàng Mai, Hà Nội', '02462587777',N'https://vietnamcleanroom.com/vcr-media/23/1/3/ha-tay-pharmaceutical1.jpg'),
(N'149/ĐKKDD-BTY', N'CÔNG TY CP DƯỢC PHẨM IMEXPHARM', N'Lô 6-9 CN, KCN Tân Bình, TP.HCM', '02838154545','https://gmp.com.vn/upload_images/images/2021/08/13/13-IMEXPHARM-02.png'),
(N'489/ĐKKDD-BTY', N'CÔNG TY CP DƯỢC - TRANG THIẾT BỊ Y TẾ BÌNH ĐỊNH', N'Lô A14, KCN Quy Hòa, Bình Định', '02563822222',N'https://media.baodautu.vn/Images/chitin/2020/06/15/duoc--thiet-bi-y-te-binh-dinh-nha-may-thuoc-ung-thu-cham-tien-do-den-cuoi-20201592206498.jpg'),
(N'123/ĐKKDD-BTY', N'CÔNG TY CP DOU PHARMA', N'Số 1 Đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội', '02437920108',N'https://m-np.nipro-pharma.co.jp/english/img/production/vietnam_img_scroll_01.jpg'),
(N'45/ĐKKDD-BTY', N'CÔNG TY CP DƯỢC PHẨM HẢI PHÒNG', N'Lô CN4, KCN Đình Vũ, Hải Phòng', '02253858123',N'https://akme.com.vn/uploads/plugin/product_items/49/fda.jpg'),
(N'89/BYT-ĐKKDĐ', N'CÔNG TY CP DƯỢC PHẨM TRUNG ƯƠNG CODUPHA', N'Số 10 Nguyễn Trung Trực, Ba Đình, Hà Nội', '02438223727',N'https://gmp.com.vn/upload_images/images/2022/02/12/cong-ty-codupha-01.png'),
(N'715/ĐKKDD-BTY', N'CÔNG TY CP DƯỢC PHẨM VIỄN ĐÔNG', N'Số 8 Đường số 5, KCN Tân Tạo, TP.HCM', '02838122010',N'https://image.vietnamnews.vn/uploadvnnews/Article/2022/8/23/235791_pharmacity-drug-store-5041_(1).jpeg');



INSERT INTO Medicine (regNumber, name, Rx, dosageForm, EXPDate, GCN, imgURL) VALUES

A'VN-35678-24', 'Metronidazole', 0, N'Viên nén', N'48 tháng', N'715/ĐKKDD-BTY', 'https://online-pharmacy4u.co.uk/cdn/shop/products/metronidazole-tablets-576661_480x480@2x.jpg?v=1667573755');


INSERT INTO Ingredent (name, formula, description) VALUES
(N'Glucose', 'C6H12O6', N'Glucose (đường) được tạo ra từ các thực phẩm mà chúng ta ăn vào hàng ngày để trở thành nguồn năng lượng đi nuôi cơ thể. Sự thiếu hụt hay dư thừa glucose đều gây ra nhiều vấn đề lớn cho sức khỏe: tăng đường huyết, hạ đường huyết, biến chứng lên thận, mắt, tim, mạch máu… Đây là nguồn năng lượng chính cho các tế bào trong cơ thể.'),
(N'Sodium chloride', 'NaCl', N'Khi tiêm tĩnh mạch, dung dịch sodium chloride là nguồn cung cấp bổ sung nước và chất điện giải. Dung dịch sodium chloride 0,9% (đẳng trương) có áp suất thẩm thấu xấp xỉ với dịch trong cơ thể. Sodium chloride cũng được sử dụng trong các dung dịch làm sạch và bảo quản.'),
(N'Ethanol', 'C2H6O', N'Ethanol được chỉ định dùng trong các trường hợp: Đối với điều trị tê liệt dây thần kinh hoặc hạch để giảm đau mãn tính khó chữa trong các tình trạng như ung thư không thể chữa khỏi và đau dây thần kinh sinh ba (tic douloureux), ở những bệnh nhân chống chỉ định các thủ thuật phẫu thuật thần kinh. Ethanol cũng được tiêm tĩnh mạch trong điều trị ngộ độc cấp tính từ methanol và ethylene glycol.'),
(N'Caffeine', 'C8H10N4O2', N'Caffeine hoạt động chính như một chất kích thích thần kinh trung ương. Đây là cơ sở tác dụng của caffeine trong chứng ngưng thở ở trẻ sinh non, một số cơ chế tác động được đề xuất bao gồm: (1) kích thích trung tâm hô hấp, (2) tăng thông khí phút, (3) giảm ngưỡng tăng CO2, (4) tăng đáp ứng với tăng CO2, (5) tăng trương lực cơ xương, (6) giảm mệt mỏi cơ hoành, (7) tăng tỷ lệ trao đổi chất, và (8) tăng tiêu thụ oxy. Caffeine cũng giúp tăng sự tỉnh táo và cải thiện hiệu suất thể chất.'),
(N'Vitamin C (ascorbic acid)', 'C6H8O6', N'Vitamin C có nhiều trong các thực phẩm tự nhiên, cơ thể người cũng chủ yếu hấp thu và sử dụng dưỡng chất này từ đây. Vitamin C tham gia vào rất nhiều hoạt động của cơ thể, có vai trò và chức năng quan trọng với hệ miễn dịch, phòng ngừa lão hóa, tăng cường sức khỏe chung. Ngoài ra, vitamin C còn giúp tăng cường hấp thu sắt từ thực phẩm và bảo vệ tế bào khỏi sự hủy hoại do các gốc tự do.'),
(N'Calcium carbonate', 'CaCO3', N'Calcium carbonate là thuốc thuộc nhóm khoáng chất và vitamin được bào chế ở dạng viên nén giúp cung cấp thành phần calcium carbonate cho cơ thể. Hoạt chất này được sử dụng nhằm cải thiện tình trạng của người bệnh bằng cơ chế trung hòa để làm giảm acid trào ngược. Ngoài ra, thuốc còn có thể sử dụng để phòng ngừa hoặc điều trị tình trạng giảm nồng độ canxi huyết. Calcium carbonate cũng được dùng trong sản xuất công nghiệp như là một chất độn trong sản xuất giấy, nhựa, và sơn.'),
(N'Citric acid', 'C6H8O7', N'Axit citric là một loại axit hữu cơ yếu có trong các loại trái cây chanh. Axit citric thường được sử dụng làm chất bảo quản tự nhiên và chất tạo hương vị trong thực phẩm và đồ uống. Nó cũng có vai trò trong quá trình sinh hóa của cơ thể, đặc biệt trong chu trình axit citric hoặc chu trình Krebs.'),
(N'Sucrose (table sugar)', 'C12H22O11', N'Sucrose là một loại đường thông thường được sử dụng hàng ngày. Sucrose được tách từ mía hoặc củ cải đường và thường được sử dụng để tạo độ ngọt cho thực phẩm và đồ uống. Sucrose cung cấp năng lượng nhanh chóng cho cơ thể nhưng tiêu thụ quá mức có thể dẫn đến các vấn đề về sức khỏe như sâu răng, béo phì và tiểu đường.'),
(N'Sodium bicarbonate', 'NaHCO3', N'Sodium bicarbonate, thông thường được biết đến là baking soda. Sodium bicarbonate có nhiều ứng dụng trong nấu ăn, làm sạch, và trong y tế. Trong y tế, nó được sử dụng để điều trị tình trạng dư acid, giảm triệu chứng ợ nóng và khó tiêu.'),
(N'Magnesium sulfate', 'MgSO4', N'Magie sunfat là một muối vô cơ có công thức hóa học MgSO4. Nó thường được gọi là muối Epsom khi ở dạng tinh thể ngậm nước. Magnesium sulfate được sử dụng trong y học để điều trị và ngăn ngừa co giật ở phụ nữ mang thai, cũng như để giảm đau và viêm. Nó cũng được dùng như một loại phân bón cung cấp magiê cho cây trồng.'),
(N'Lactic acid', 'C3H6O3', N'Axit lactic là một axit hữu cơ được sản xuất từ quá trình lên men tự nhiên trong thực phẩm như sữa chua và dưa cải. Nó cũng được sản xuất trong cơ bắp của con người trong quá trình tập luyện cường độ cao khi thiếu oxy. Axit lactic có nhiều ứng dụng trong công nghiệp thực phẩm, dược phẩm và mỹ phẩm.'),
(N'Copper sulfate', 'CuSO4', N'Đồng sunfat là một hợp chất hóa học được sử dụng rộng rãi trong nông nghiệp và công nghiệp. Trong nông nghiệp, nó được sử dụng như một chất diệt nấm và diệt cỏ. Trong công nghiệp, đồng sunfat được sử dụng trong quá trình mạ điện và sản xuất các hợp chất đồng khác.'),
(N'Glycerol', 'C3H8O3', N'Glycerol là một hợp chất polyol đơn giản. Nó có vị ngọt và không độc hại, thường được sử dụng trong thực phẩm, dược phẩm và mỹ phẩm như một chất làm ẩm, chất bôi trơn và dung môi. Glycerol cũng được sử dụng trong sản xuất thuốc nổ và chất chống đông.'),
(N'Riboflavin (vitamin B2)', 'C17H20N4O6', N'Riboflavin là một loại vitamin thuộc nhóm vitamin B, cần thiết cho sự tăng trưởng và tổng hợp tế bào. Nó đóng vai trò quan trọng trong quá trình chuyển hóa năng lượng và duy trì sức khỏe của da, mắt, và hệ thần kinh. Thiếu riboflavin có thể dẫn đến các vấn đề sức khỏe như viêm miệng, viêm lưỡi và các vấn đề về da.'),
(N'Ibuprofen', 'C13H18O2', N'Ibuprofen là một loại thuốc dùng để giảm sốt và điều trị đau. Nó thuộc nhóm thuốc chống viêm không steroid (NSAID) và thường được sử dụng để giảm đau do viêm khớp, đau đầu, đau răng, và đau bụng kinh. Ibuprofen hoạt động bằng cách ức chế enzyme COX, từ đó giảm sản xuất các chất gây viêm trong cơ thể.'),
(N'Acetic acid (vinegar)', 'CH3COOH', N'Axit axetic, thành phần chính của giấm, được sử dụng trong nấu ăn và bảo quản thực phẩm. Axit axetic cũng có nhiều ứng dụng công nghiệp như sản xuất chất dẻo, vải và thuốc nhuộm. Ngoài ra, axit axetic còn được sử dụng trong y tế như một chất khử trùng.'),
(N'Titanium dioxide', 'TiO2', N'Titanium dioxide là một chất màu trắng được sử dụng trong các sản phẩm khác nhau như sơn, nhựa, giấy, và thực phẩm. Nó cũng được sử dụng trong mỹ phẩm như một chất chống nắng do khả năng ngăn chặn tia UV. Titanium dioxide còn có ứng dụng trong công nghiệp như một chất xúc tác và trong sản xuất gốm sứ.'),
(N'Maltose', 'C12H22O11', N'Maltose là một loại đường hai phân tử được tạo thành từ hai đơn vị glucose. Nó được tìm thấy trong mạch nha và các sản phẩm chứa tinh bột sau khi thủy phân. Maltose được sử dụng trong sản xuất bia và một số loại thực phẩm để tạo vị ngọt.'),
(N'Monosodium glutamate (MSG)', 'C5H8NNaO4', N'Monosodium glutamate là một chất làm tăng vị, thường được sử dụng trong ẩm thực để cải thiện hương vị của thực phẩm. MSG được tìm thấy tự nhiên trong một số thực phẩm như cà chua và phô mai, và cũng được sản xuất công nghiệp để sử dụng trong nấu ăn. Mặc dù MSG được coi là an toàn cho hầu hết mọi người, nhưng một số người có thể nhạy cảm với nó và trải qua các triệu chứng như đau đầu và buồn nôn.'),
(N'Pyridoxine (vitamin B6)', 'C8H11NO3', N'Pyridoxine là một dạng của vitamin B6, cần thiết cho sự chuyển hóa protein, carbohydrate và chất béo. Vitamin B6 cũng đóng vai trò quan trọng trong việc sản xuất các chất dẫn truyền thần kinh và hồng cầu. Thiếu hụt vitamin B6 có thể dẫn đến các vấn đề về sức khỏe như trầm cảm, nhầm lẫn, và viêm da.'),
(N'Arginine', 'C6H14N4O2', N'Arginine là một axit amin quan trọng trong nhiều quá trình sinh học, bao gồm sản xuất oxit nitric, một chất quan trọng trong việc điều hòa huyết áp và chức năng miễn dịch. Arginine cũng được sử dụng trong y học để điều trị các vấn đề về tim mạch, rối loạn cương dương, và cải thiện hiệu suất thể thao.'),
('Polysorbate 80', 'C64H124O26', N'Polysorbate 80 là một chất hoạt động bề mặt và chất làm dịu không cực, thường được sử dụng trong ngành công nghiệp thực phẩm và dược phẩm. Nó có khả năng hòa tan trong nước và dầu, giúp cải thiện tính đồng nhất và ổn định của sản phẩm. Polysorbate 80 cũng được sử dụng để làm mềm và làm dịu da trong các sản phẩm mỹ phẩm.'),
('Agar', 'C12H18O9', N'Agar là một chất đông gel được chiết xuất từ tảo biển và thường được sử dụng như một chất đông gel và chất làm dày trong thực phẩm và công nghiệp sinh học. Đặc tính không tan trong nước lạnh và tan hoàn toàn trong nước nóng khiến cho Agar được ưa chuộng trong các ứng dụng thí nghiệm và sản xuất thực phẩm.'),
('Oleic acid', 'C18H34O2', N'Axit oleic là một loại axit béo không no, thường được tìm thấy trong các loại dầu thực vật như dầu olive. Axit oleic có tính chất làm mềm và dưỡng ẩm da, là thành phần chính trong nhiều sản phẩm chăm sóc da và tóc.'),
('Benzene', 'C6H6', N'Benzene là một chất lỏng không màu, có mùi hắc ít thường được sử dụng như một dung môi quan trọng trong công nghiệp hóa chất. Đây là một hydrocarbon đơn giản nhất và là thành phần chính của nhiều sản phẩm hóa học và xăng dầu.'),
('Ammonia', 'NH3', N'Ammonia là một hợp chất của nitơ và hydrogen, thường được sản xuất trong quá trình phân hủy các chất hữu cơ và sử dụng rộng rãi trong các ngành công nghiệp. Đây là một trong những hợp chất hóa học quan trọng, có ứng dụng từ phân bón đến sản xuất thuốc nhuộm và chất tẩy rửa.'),
('Hydrogen peroxide', 'H2O2', N'Hydrogen peroxide là một chất tẩy trắng và chất oxy hóa mạnh, được sử dụng rộng rãi trong y tế, công nghiệp và hộ gia đình. Với khả năng tạo oxy tự do, hydrogen peroxide có tác dụng kháng khuẩn và làm sạch mạnh mẽ.'),
('Propylene glycol', 'C3H8O2', N'Propylene glycol là một hợp chất hữu cơ tổng hợp, thường được sử dụng như chất làm ẩm và dung môi trong các sản phẩm mỹ phẩm, thực phẩm và thuốc. Với tính chất không gây kích ứng da và khả năng hút ẩm tốt, propylene glycol là một thành phần quan trọng trong nhiều ứng dụng công nghiệp và y tế.'),
('Potassium chloride', 'KCl', N'Kali clorua là một muối halide kim loại, có tính chất tan trong nước và có mặt tự nhiên trong các khoáng vật và hệ thống sinh vật. Với vai trò cung cấp kali quan trọng cho sức khỏe con người và thực vật, kali clorua được sử dụng rộng rãi trong sản xuất phân bón và các sản phẩm y tế.'),
('Lecithin', 'C42H84NO7P', N'Lecithin là một hợp chất tự nhiên của các phospholipid, thường được chiết xuất từ đậu nành và trứng. Được biết đến với khả năng làm mềm da và tóc, lecithin còn có vai trò quan trọng trong việc duy trì cấu trúc tế bào và là thành phần chính trong nhiều sản phẩm thực phẩm và mỹ phẩm.'),
('Sorbic acid', 'C6H8O2', N'Sorbic acid là một hợp chất hữu cơ tự nhiên được sử dụng như chất bảo quản trong thực phẩm và mỹ phẩm. Với khả năng ức chế sự phát triển của vi khuẩn và nấm mốc, sorbic acid giúp kéo dài tuổi thọ và duy trì chất lượng của các sản phẩm.'),
('Menthol', 'C10H20O', N'Menthol là một hợp chất hữu cơ có mùi thơm của bạc hà, thường được sử dụng trong sản xuất mỹ phẩm, thuốc lá và các sản phẩm dược phẩm khác. Với tính năng làm mát và làm dịu da, menthol là một thành phần phổ biến trong các sản phẩm chăm sóc cá nhân.'),
('Xanthan gum', '(C35H49O29)n', N'Xanthan gum là một polysaccharide có nguồn gốc từ vi khuẩn và được sử dụng làm chất phụ gia thực phẩm và chất điều hòa độ nhớt. Với khả năng tạo thành gel và ổn định độ nhớt, xanthan gum thường được dùng để cải thiện độ nhớt và độ dính trong các sản phẩm thực phẩm và mỹ phẩm.'),
('Ascorbyl palmitate', 'C22H38O7', N'Ascorbyl palmitate là một dạng ester tan trong mỡ của vitamin C, thường được sử dụng trong các sản phẩm chống oxy hóa và dưỡng da. Với khả năng bảo vệ tế bào da khỏi tổn thương oxy hóa, ascorbyl palmitate giúp duy trì làn da khỏe mạnh và tươi trẻ.'),
('Sodium lauryl sulfate', 'CH3(CH2)11OSO3Na', N'Sodium lauryl sulfate là một chất hoạt động bề mặt có khả năng tạo bọt mạnh, thường được sử dụng trong các sản phẩm làm sạch và chăm sóc cá nhân. Đây là một chất hóa học quan trọng trong ngành công nghiệp mỹ phẩm và hóa chất.'),
('Triclosan', 'C12H7Cl3O2', N'Triclosan là một chất chống khuẩn có hiệu quả cao, thường được sử dụng trong các sản phẩm chăm sóc cá nhân và y tế. Với khả năng ngăn ngừa sự phát triển của vi khuẩn và nấm mốc, triclosan giúp duy trì vệ sinh và bảo vệ sức khỏe cá nhân.'),
('Butylated hydroxyanisole (BHA)', 'C11H16O2', N'Butylated hydroxyanisole là một chất chống oxy hóa phổ biến, thường được sử dụng để bảo quản thực phẩm và dược phẩm. Với khả năng ngăn ngừa sự oxy hóa và duy trì độ tươi mới của sản phẩm, BHA giúp kéo dài tuổi thọ và duy trì chất lượng của thực phẩm.'),
('Dextrose', 'C6H12O6', N'Dextrose là một loại đường đơn được chiết xuất từ ngô và thường được sử dụng như một nguồn năng lượng nhanh cho cơ thể. Với khả năng hấp thụ nhanh chóng vào cơ thể, dextrose là một thành phần quan trọng trong các sản phẩm thể thao và năng lượng.'),
('Maltodextrin', '(C6H10O5)n', N'Maltodextrin là một polysaccharide phổ biến trong thực phẩm, thường được sử dụng như một chất phụ gia để cải thiện độ nhớt và độ ngọt của sản phẩm. Với khả năng hòa tan dễ dàng trong nước và tạo cảm giác dẻo dai, maltodextrin thường được sử dụng trong sản xuất đồ uống và thực phẩm công nghiệp.'),
('Glucosamine', 'C6H13NO5', N'Glucosamine là một hợp chất được biết đến với vai trò hỗ trợ sức khỏe khớp xương và dịch khớp. Thường được sử dụng như một thành phần trong các bổ sung dinh dưỡng cho người có vấn đề về xương khớp.'),
('Coenzyme Q10', 'C59H90O4', N'Coenzyme Q10 là một chất chống oxy hóa quan trọng cho sức khỏe tim mạch và làn da. Nó có vai trò quan trọng trong quá trình sản xuất năng lượng tế bào và bảo vệ tế bào da khỏi tổn thương oxy hóa.'),
('Sodium hydroxide', 'NaOH', N'Natri hydroxit, thông thường được biết đến là xút, là một hợp chất kiềm mạnh, thường được sử dụng trong công nghiệp và làm sạch. Với tính chất ăn mòn mạnh, sodium hydroxide là một thành phần quan trọng trong sản xuất xà phòng và hóa chất.'),
('Acetylsalicylic acid (aspirin)', 'C9H8O4', N'Acetylsalicylic acid là một loại thuốc giảm đau và chống viêm, thường được sử dụng trong y tế. Với khả năng làm giảm đau và hạ sốt, aspirin cũng có tác dụng phòng ngừa bệnh tim mạch và đột quỵ.'),
('Allantoin', 'C4H6N4O3', N'Allantoin là một hợp chất có tính làm dịu da và kích thích tái tạo tế bào da, thường được sử dụng trong các sản phẩm chăm sóc da và mỹ phẩm. Với khả năng làm dịu kích ứng và giúp da hồi phục nhanh chóng, allantoin là một thành phần phổ biến trong sản phẩm chăm sóc cá nhân.'),
('Retinol (vitamin A)', 'C20H30O', N'Retinol là một dạng của vitamin A, có vai trò quan trọng trong việc duy trì sức khỏe mắt và làn da. Với khả năng kích thích tái tạo tế bào da và giảm sự xuất hiện của nếp nhăn, retinol là một thành phần chính trong nhiều sản phẩm chống lão hóa.'),
('Tocopherol (vitamin E)', 'C29H50O2', N'Tocopherol là một dạng của vitamin E, có tính chất chống oxy hóa mạnh mẽ, bảo vệ tế bào da khỏi tổn thương. Với khả năng duy trì độ ẩm và làm dịu da, tocopherol là một thành phần quan trọng trong các sản phẩm chăm sóc da và mỹ phẩm.'),
('Lycopene', 'C40H56', N'Lycopene là một chất sắc tố carotenoid màu đỏ tươi, có lợi cho sức khỏe tim mạch và làn da. Với khả năng chống oxy hóa và bảo vệ tế bào da khỏi tổn thương, lycopene là một thành phần quan trọng trong chế độ ăn uống và sản phẩm chăm sóc sức khỏe.'),
('Quercetin', 'C15H10O7', N'Quercetin là một loại flavonoid có tính chất chống oxy hóa và chống viêm, thường được tìm thấy trong trái cây, rau quả và ngũ cốc. Với khả năng bảo vệ tế bào da và hỗ trợ hệ miễn dịch, quercetin là một thành phần quan trọng trong chế độ dinh dưỡng và chăm sóc sức khỏe.'),
('Resveratrol', 'C14H12O3', N'Resveratrol là một loại phenol tự nhiên được tìm thấy trong nho và các loại thực phẩm khác, có tác dụng bảo vệ sức khỏe tim mạch và làn da. Với khả năng chống oxy hóa mạnh mẽ và giảm sự viêm, resveratrol đóng vai trò quan trọng trong chế độ dinh dưỡng và chăm sóc sức khỏe.'),
('Melatonin', 'C13H16N2O2', N'Melatonin là một hormone có vai trò quan trọng trong điều tiết giấc ngủ và thúc đẩy quá trình thư giãn. Thường được sử dụng như một chất bổ sung để hỗ trợ giấc ngủ và làm dịu hệ thần kinh.');


INSERT INTO Med_Ingre (medReg, ingreName, dosageAmount) VALUES
('VN-17422-13', 'Acetic acid (vinegar)', '10 mg'),
('VN-17422-13', 'Acetylsalicylic acid (aspirin)', '20 mg'),
('VN-18216-14', 'Agar', '15 mg'),
('VN-18216-14', 'Allantoin', '25 mg'),
('VN-18416-13', 'Ammonia', '30 mg'),
('VN-18416-13', 'Arginine', '10 mg'),
('VN-19115-15', 'Ascorbyl palmitate', '12 mg'),
('VN-19115-15', 'Benzene', '18 mg'),
('VN-21038-18', 'Butylated hydroxyanisole (BHA)', '22 mg'),
('VN-21038-18', 'Caffeine', '28 mg'),
('VN-21165-14', 'Calcium carbonate', '15 mg'),
('VN-21165-14', 'Citric acid', '20 mg'),
('VN-21789-17', 'Coenzyme Q10', '25 mg'),
('VN-21789-17', 'Copper sulfate', '10 mg'),
('VN-22578-19', 'Dextrose', '30 mg'),
('VN-22578-19', 'Ethanol', '35 mg'),
('VN-23456-15', 'Glucosamine', '18 mg'),
('VN-23456-15', 'Glucose', '22 mg'),
('VN-24071-16', 'Glycerol', '25 mg'),
('VN-24071-16', 'Hydrogen peroxide', '30 mg'),
('VN-24086-16', 'Ibuprofen', '10 mg'),
('VN-24086-16', 'Lactic acid', '15 mg'),
('VN-25348-16', 'Lecithin', '20 mg'),
('VN-25348-16', 'Lycopene', '25 mg'),
('VN-26789-18', 'Magnesium sulfate', '30 mg'),
('VN-26789-18', 'Maltodextrin', '35 mg'),
('VN-27890-16', 'Maltose', '18 mg'),
('VN-27890-16', 'Melatonin', '22 mg'),
('VN-28901-17', 'Menthol', '25 mg'),
('VN-28901-17', 'Monosodium glutamate (MSG)', '10 mg'),
('VN-29012-19', 'Oleic acid', '30 mg'),
('VN-29012-19', 'Polysorbate 80', '35 mg'),
('VN-30123-18', 'Potassium chloride', '18 mg'),
('VN-30123-18', 'Propylene glycol', '22 mg'),
('VN-31234-20', 'Pyridoxine (vitamin B6)', '25 mg'),
('VN-31234-20', 'Quercetin', '10 mg'),
('VN-32345-21', 'Resveratrol', '30 mg'),
('VN-32345-21', 'Retinol (vitamin A)', '35 mg'),
('VN-33456-22', 'Riboflavin (vitamin B2)', '18 mg'),
('VN-33456-22', 'Sodium bicarbonate', '22 mg'),
('VN-34567-23', 'Sodium chloride', '25 mg'),
('VN-34567-23', 'Sodium hydroxide', '10 mg'),
('VN-34567-23', 'Sodium lauryl sulfate', '30 mg'),
('VN-31234-20', 'Sorbic acid', '35 mg'),
('VN-30123-18', 'Sucrose (table sugar)', '18 mg'),
('VN-25348-16', 'Titanium dioxide', '22 mg'),
('VN-28901-17', 'Tocopherol (vitamin E)', '25 mg'),
('VN-35678-24', 'Triclosan', '10 mg'),
('VN-35678-24', 'Vitamin C (ascorbic acid)', '30 mg'),
('VN-35678-24', 'Xanthan gum', '35 mg');


INSERT INTO Role (name) VALUES('Admin'),('Doctor'),('Student');

INSERT INTO Account (UUID,username,password,email,roleid) VALUES ('Admin','sa','123','d@d',1)

--select * from Account
--select * from Role
--select * from Medicine
--select * from Company