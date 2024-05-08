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

CREATE TBALE APfood_Wallet_Receipt (
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
('M10','Turner','alex_turn','Turn3r!Pass','Male','Student','019-3785652')
