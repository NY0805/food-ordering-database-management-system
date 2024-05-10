CREATE DATABASE APU_Cafe;
USE APU_Cafe;

CREATE TABLE Member (
	memberID nvarchar(50) NOT NULL PRIMARY KEY,
	name nvarchar(50),
	username nvarchar(50),
	password nvarchar(50),
	gender nvarchar(50),
	role nvarchar(50),
	contactNumber nvarchar(50)
);

CREATE TABLE Restaurant (
	restaurantID nvarchar(50) NOT NULL PRIMARY KEY,
	contactNumber nvarchar(50),
	location nvarchar(50),
	halalLicense nvarchar(50),
	cleanlinessLicense nvarchar(50),
);

CREATE TABLE Food_Menu (
	foodID nvarchar(50) NOT NULL PRIMARY KEY,
	fName nvarchar(50),
	price decimal,
	restaurantID nvarchar(50),
	FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID)
);

CREATE TABLE Feedback (
	feedbackID nvarchar(50) NOT NULL PRIMARY KEY,
	description nvarchar(50),
	rating decimal,
	memberID nvarchar(50),
	foodID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (foodID) REFERENCES Food_Menu(foodID)
);

CREATE TABLE Chef (
	chefID nvarchar(50) NOT NULL PRIMARY KEY,
	cName nvarchar(50),
	contactNumber nvarchar(50),
	restaurantID nvarchar(50),
	FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID)
);

CREATE TABLE Worker (
	workerID nvarchar(50) NOT NULL PRIMARY KEY,
	wName nvarchar(50),
	contactNumber nvarchar(50)
);

CREATE TABLE Orders (
	orderID nvarchar(50) NOT NULL PRIMARY KEY,
	orderDate date,
	orderTime time,
	deliveryStatus nvarchar(50),
	memberID nvarchar(50),
	foodID nvarchar(50),
	chefID nvarchar(50),
	workerID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (foodID) REFERENCES Food_Menu(foodID),
	FOREIGN KEY (chefID) REFERENCES Chef(chefID),
	FOREIGN KEY (workerID) REFERENCES Worker(workerID),
);

CREATE TABLE Shopping_Cart (
	cartID nvarchar(50) NOT NULL PRIMARY KEY,
	totalCost decimal,
	memberID nvarchar(50),
	restaurantID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID)
);

CREATE TABLE Manager (
	managerID nvarchar(50) NOT NULL PRIMARY KEY,
	mName nvarchar(50),
	mContactNumber nvarchar(50),
	orderID nvarchar(50),
	chefID nvarchar(50),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID),
	FOREIGN KEY (chefID) REFERENCES Chef(chefID)
);

CREATE TABLE Payment_Details (
	paymentID nvarchar(50) NOT NULL PRIMARY KEY,
	payMethod nvarchar(50),
	memberID nvarchar(50),
	payStatus nvarchar(50),
	payDate date,
	payTime time,
	tax nvarchar(50),
	pointDiscount int,
	subtotal decimal,
	orderID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

CREATE TABLE APfood_Wallet (
	walletID nvarchar(50) NOT NULL PRIMARY KEY,
	balance decimal,
	memberID nvarchar(50),
	paymentID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (paymentID) REFERENCES Payment_Details(paymentID)
);

CREATE TABLE Reward_Details (
	rewardID nvarchar(50) NOT NULL PRIMARY KEY,
	totalPoints int,
	rewardExpiryDate date,
	walletID nvarchar(50),
	memberID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (walletID) REFERENCES APfood_Wallet(walletID)
);

CREATE TABLE Purchase_History (
	purchaseID nvarchar(50) NOT NULL PRIMARY KEY,
	paymentID nvarchar(50),
	orderID nvarchar(50),
	memberID nvarchar(50),
	FOREIGN KEY (paymentID) REFERENCES Payment_Details(paymentID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID),
	FOREIGN KEY (memberID) REFERENCES Member(memberID)
);

CREATE TABLE Reload_History (
	historyID nvarchar(50) NOT NULL PRIMARY KEY,
	reloadDate date,
	reloadTime time,
	walletID nvarchar(50),
	FOREIGN KEY (walletID) REFERENCES APfood_Wallet(walletID)
);

CREATE TABLE TNG_Receipt (
	tngReceiptID nvarchar(50) NOT NULL PRIMARY KEY,
	memberID nvarchar(50),
	paymentID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (paymentID) REFERENCES Payment_Details(paymentID)
);

CREATE TABLE Online_Banking_Receipt (
	bankReceiptID nvarchar(50) NOT NULL PRIMARY KEY,
	memberID nvarchar(50),
	bankName nvarchar(50),
	paymentID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (paymentID) REFERENCES Payment_Details(paymentID)
);

CREATE TABLE APfood_Wallet_Receipt (
	apReceiptID nvarchar(50) NOT NULL PRIMARY KEY,
	memberID nvarchar(50),
	paymentID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (paymentID) REFERENCES Payment_Details(paymentID)
);

INSERT INTO Member VALUES 
('M01','Harry','harry123','23h483ej','Male','Student','012-3345637'),
('M02','Matthew','5_matt_5','dj37dj9d','Male','Student','017-8051823'),
('M03','Evelyn','evelynnn','4372hd82','Female','Staff','012-4441016'),
('M04','Malfoy','888malfoy888','dihd8999','Male','Staff','018-8451584'),
('M05','Hermione','hErMiOnE','wdhd6dd','Female','Staff','011-8827320'),
('M06','Aurora','~aurora~','27dg7329','Female','Student','016-9207902'),
('M07','Johnson','john23','P@ssw0rd','Male','Lecturer','012-4835769'),
('M08','David','dave89','Sm1thP@ss','Male','Lecturer','018-5937042'),
('M09','Sarah','sarahlee7','L33s@rah','Female','Student','012-3289463'),
('M10','Turner','alex_turn','Turn3r!Pass','Male','Student','019-3785652');

INSERT INTO Restaurant VALUES
('RT01','Savor Junction','03-2341722','south','HC28439','A'),
('RT02','Fizz and Sip Lounge','03-5930274','east','HC63826','A-'),
('RT03','Sweet Bliss Delight','03-2374920','west','HC90631','A+');

INSERT INTO Food menu VALUES
('F01','Cheeseburger','RM4.50','RT01'),
('F02','Molten lava cake','RM7.20','RT03'),
('F03','Spaghetti','RM8.50','RT01'),
('F04','Veggle wrap','RM6.00','RT01'),
('F05','Iced lemon tea','RM3.50','RT02'),
('F06','Green tea latte','RM6.90','RT02'),
('F07','Fruit tart','RM4.30','RT03'),
('F08','Americano','RM6.90','RT02'),
('F09','Brownies','RM6.50','RT03'),
('F10','Fried rice','RM7.00','RT01'),
('F11','Pepperoni Pizza','RM10.00','RT01'),
('F12','Sushi Combo','RM8.00','RT01'),
('F13','Classic Mojito','RM3.00','RT02'),
('F14','Strawberry Milkshake','RM3.00','RT02'),
('F15','Tiramisu','RM4.50','RT03');

INSERT INTO Feedback VALUES
('E01','The taste is niceeee.','4.5','M01','F05'),
('E02','The meat is undercooked!!!!!','2.0','M01','F01'),
('E03','I wont be ordering this again.','1.5','M02','F15'),
('E04','Definitely a must-try for pizza lovers!','4.9','M02','F11'),
('E05','It is too sweet for me.','3.5','M03','F02'),
('E06','The Sushi Combo was an absolute delight!','4.5','M03','F12'),
('E07','The dish lacked flavor and had an unappealing texture,making it a disappointing choice.','2.0','M03','F03'),
('E08','I hate cheese.','1.7','M04','F03'),
('E09','The Americano was bold and invigorating,with a satisfyingly rich flavor profile.','4.5','M04','F08'),
('E10','Highly recommended!','5.0','M05','F04'),
('E11','It looks so cute and of course yummy.','4.0','M05','F07'),
('E12','The food had a delightful medley of flavors and a pleasing texture that left a lasting impression.','5.0','M06','F09'),
('E13','Delicious fried rice,well-seasoned and perfectly cooked.','4.8','M07','F10'),
('E14','It is a perfect thirst-quencher on a warm summer day!','4.7','M08','F13');

INSERT INTO Chef VALUES
('C01','Marcus','018-462 8293','RT01'),
('C02','Nicholas','016-910 6290','RT02'),
('C03','Ryan','012-038 5200','RT03');

INSERT INTO Worker VALUES
('W01','Jolin','012-3456789'),
('W02','Olivia','011-4752956'),
('W03','Jothan','014-9563850');

INSERT INTO Orders VALUES
('OR-01','2023-01-05','1:08:45PM','Out for delivery','1','M01','F05','C02','W01'),
('OR-01','2023-01-05','1:08:45PM','In kitchen','2','M01','F01','C01','W02'),
('OR-02','2023-02-16','4:28:52PM','Delivered','1','M02','F05','C02','W03'),
('OR-02','2023-02-16','4:28:52PM','In kitchen','2','M02','F10','C01','W02'),
('OR-02','2023-02-16','4:28:52PM','Unsuccessful','1','M02','F15','C03','W03'),
('OR-03','2023-03-08','10:51:38AM','In kitchen','3','M03','F02','C03','W01'),
('OR-03','2023-03-08','10:51:38AM','In kitchen','1','M03','F03','C01','W01'),
('OR-03','2023-03-08','10:51:38AM','Out for delivery','1','M03','F12','C01','W03'),
('OR-03','2023-03-08','10:51:38AM','Delivered','1','M03','F14','C02','W02'),
('OR-03','2023-03-08','10:51:38AM','Unsuccessful','M03','F11','C01','W02'),
('OR-04','2023-03-11','2:13:25PM','Delivered','2','M04','F03','C01','W01'),
('OR-04','2023-03-11','2:13:25PM','Out for delivery','1','M04','F08','C02','W01'),
('OR-06','2023-05-17','9:49:01AM','In kitchen','4','M05','F04','C01','W02'),
('OR-06','2023-05-17','9:49:01AM','Unsuccessful','1','M05','F07','C03','W03'),
('OR-06','2023-05-17','9:49:01AM','Out for delivery','1','M05','F15','C03','W03'),
('OR-07','2023-05-29','3:07:43PM','Delivered','1','M06','F09','C03','W01'),
('OR-08','2023-06-02','12:01:44PM','In kitchen','2','M07','F10','C01','W02'),
('OR-09','2023-06-02','12:33:41PM','Out for delivery','1','M08','F13','C02','W03'),
('OR-10','2023-06-13','11:27:31AM','Delivered','3','M09','F11','C01','W01');
	
