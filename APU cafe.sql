CREATE DATABASE APU_Cafe;
USE APU_Cafe;

CREATE TABLE Member (
	memberID nvarchar(50) NOT NULL PRIMARY KEY,
	mName nvarchar(50),
	mUsername nvarchar(50),
	mPassword nvarchar(50),
	mGender nvarchar(10),
	mRole nvarchar(50),
	mContactNumber nvarchar(50)
);

CREATE TABLE Restaurant (
	restaurantID nvarchar(50) NOT NULL PRIMARY KEY,
	rName nvarchar(50),
	rContactNumber nvarchar(50),
	rLocation nvarchar(50),
	halalLicense nvarchar(50),
	cleanlinessLicense nvarchar(50)
);

CREATE TABLE Food_Menu (
	foodID nvarchar(50) NOT NULL PRIMARY KEY,
	fName nvarchar(50),
	fPrice_RM decimal(10,2),
	restaurantID nvarchar(50),
	FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID)
);

CREATE TABLE Feedback (
	feedbackID nvarchar(50) NOT NULL PRIMARY KEY,
	description nvarchar(200),
	rating decimal(2,1),
	memberID nvarchar(50),
	foodID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (foodID) REFERENCES Food_Menu(foodID)
);

CREATE TABLE Manager (
	managerID nvarchar(50) NOT NULL PRIMARY KEY,
	mName nvarchar(50),
	mContactNumber nvarchar(50)
);

CREATE TABLE Chef (
	chefID nvarchar(50) NOT NULL PRIMARY KEY,
	cName nvarchar(50),
	cContactNumber nvarchar(50),
	restaurantID nvarchar(50),
	managerID nvarchar(50),
	FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID),
	FOREIGN KEY (managerID) REFERENCES Manager(managerID)
);

CREATE TABLE Worker (
	workerID nvarchar(50) NOT NULL PRIMARY KEY,
	wName nvarchar(50),
	wContactNumber nvarchar(50)
);

CREATE TABLE Orders (
	orderID nvarchar(50) NOT NULL PRIMARY KEY,
	orderDate date,
	orderTime time,
	memberID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID)
);

CREATE TABLE Shopping_Cart (
	cartID nvarchar(50) NOT NULL PRIMARY KEY,
	totalCost_RM decimal(10,2),
	memberID nvarchar(50),
	orderID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

CREATE TABLE Order_Details (
	orderID nvarchar(50),
	deliveryStatus nvarchar(50),
	orderQuantity int,
	foodID nvarchar(50),
	chefID nvarchar(50),
	workerID nvarchar(50),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID),
	FOREIGN KEY (foodID) REFERENCES Food_Menu(foodID),
	FOREIGN KEY (chefID) REFERENCES Chef(chefID),
	FOREIGN KEY (workerID) REFERENCES Worker(workerID)
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
	subtotal_RM decimal(10,2),
	orderID nvarchar(50),
	FOREIGN KEY (memberID) REFERENCES Member(memberID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

CREATE TABLE APfood_Wallet (
	walletID nvarchar(50) NOT NULL PRIMARY KEY,
	balance_RM decimal(10,2),
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

INSERT INTO Food_Menu VALUES
('F01','Cheeseburger',4.50,'RT01'),
('F02','Molten lava cake',7.20,'RT03'),
('F03','Spaghetti',8.50,'RT01'),
('F04','Veggle wrap',6.00,'RT01'),
('F05','Iced lemon tea',3.50,'RT02'),
('F06','Green tea latte',6.90,'RT02'),
('F07','Fruit tart',4.30,'RT03'),
('F08','Americano',6.90,'RT02'),
('F09','Brownies',6.50,'RT03'),
('F10','Fried rice',7.00,'RT01'),
('F11','Pepperoni Pizza',10.00,'RT01'),
('F12','Sushi Combo',8.00,'RT01'),
('F13','Classic Mojito',3.00,'RT02'),
('F14','Strawberry Milkshake',3.00,'RT02'),
('F15','Tiramisu',4.50,'RT03');

INSERT INTO Feedback VALUES
('E01','The taste is niceeee.',4.5,'M01','F05'),
('E02','The meat is undercooked!!!!!',2.0,'M01','F01'),
('E03','I wont be ordering this again.',1.5,'M02','F15'),
('E04','Definitely a must-try for pizza lovers!',4.9,'M02','F11'),
('E05','It is too sweet for me.',3.5,'M03','F02'),
('E06','The Sushi Combo was an absolute delight!',4.5,'M03','F12'),
('E07','The dish lacked flavor and had an unappealing texture,making it a disappointing choice.',2.0,'M03','F03'),
('E08','I hate cheese.',1.7,'M04','F03'),
('E09','The Americano was bold and invigorating,with a satisfyingly rich flavor profile.',4.5,'M04','F08'),
('E10','Highly recommended!',5.0,'M05','F04'),
('E11','It looks so cute and of course yummy.',4.0,'M05','F07'),
('E12','The food had a delightful medley of flavors and a pleasing texture that left a lasting impression.',5.0,'M06','F09'),
('E13','Delicious fried rice,well-seasoned and perfectly cooked.',4.8,'M07','F10'),
('E14','It is a perfect thirst-quencher on a warm summer day!',4.7,'M08','F13');

INSERT INTO Manager VALUES
('MGR01','Cyrus','016-2858219');

INSERT INTO Chef VALUES
('C01','Marcus','018-4628293','RT01','MGR01'),
('C02','Nicholas','016-9106290','RT02','MGR01'),
('C03','Ryan','012-0385200','RT03','MGR01');

INSERT INTO Worker VALUES
('W01','Jolin','012-3456789'),
('W02','Olivia','011-4752956'),
('W03','Jothan','014-9563850');

INSERT INTO Orders VALUES
('OR-01','2023-01-05','13:08:45','M01'),
('OR-02','2023-02-16','16:28:52','M02'),
('OR-03','2023-03-08','10:51:38','M03'),
('OR-04','2023-03-11','14:13:25','M04'),
('OR-05','2023-05-17','09:49:01','M05'),
('OR-06','2023-05-29','15:07:43','M06'),
('OR-07','2023-06-02','12:01:44','M07'),
('OR-08','2023-06-02','12:33:41','M08'),
('OR-09','2023-06-13','11:27:31','M09'); 

INSERT INTO Shopping_Cart VALUES
('S01',8.00,'M01','OR-01'),
('S02',15.00,'M02','OR-02'),
('S03',36.70,'M03','OR-03'),
('S04',15.40,'M04','OR-04'),
('S05',14.80,'M05','OR-05'),
('S06',6.50,'M06','OR-06'),
('S07',7.00,'M07','OR-07'),
('S08',3.00,'M08','OR-08'),
('S09',10.00,'M09','OR-09'),
('S10',NULL,'M10',NULL);

INSERT INTO Order_Details VALUES
('OR-01','Out for delivery',1,'F05','C02','W01'),
('OR-01','In kitchen',2,'F01','C01','W02'),
('OR-02','Delivered',1,'F05','C02','W03'),
('OR-02','In kitchen',2,'F10','C01','W02'),
('OR-02','Unsuccessful',1,'F15','C03','W03'),
('OR-03','In kitchen',3,'F02','C03','W01'),
('OR-03','In kitchen',1,'F03','C01','W01'),
('OR-03','Out for delivery',1,'F12','C01','W03'),
('OR-03','Delivered',1,'F14','C02','W02'),
('OR-03','Unsuccessful',1,'F11','C01','W02'),
('OR-04','Delivered',2,'F03','C01','W01'),
('OR-04','Out for delivery',1,'F08','C02','W01'),
('OR-05','In kitchen',4,'F04','C01','W02'),
('OR-05','Unsuccessful',1,'F07','C03','W03'),
('OR-05','Out for delivery',1,'F15','C03','W03'),
('OR-06','Delivered',1,'F09','C03','W01'),
('OR-07','In kitchen',2,'F10','C01','W02'),
('OR-08','Out for delivery',1,'F13','C02','W03'),
('OR-09','Delivered',3,'F11','C01','W01');

INSERT INTO Payment_Details VALUES 
('PD01', 'TNG', 'M01', 'success', '2023-01-05', '13:14:30', '6%', 100, 7.48, 'OR-01'),
('PD02', 'Apfood wallet', 'M02', 'success', '2023-02-16', '16:50:11', '6%', 100, 14.90, 'OR-02'),
('PD03', 'Online banking', 'M03', 'success', '2023-03-08', '10:53:57', '6%', NULL, 38.90, 'OR-03'),
('PD04', 'Apfood wallet', 'M04', 'success', '2023-03-11', '17:30:39', '6%', 200, 14.32, 'OR-04'),
('PD05', 'Online banking', 'M05', 'success', '2023-03-30', '9:55:22', '6%', 500, 10.69, 'OR-05'),
('PD06', 'Apfood wallet', 'M06', 'success', '2023-03-30', '10:00:08', '6%', 100, 5.89, 'OR-06'),
('PD07', 'TNG', 'M07', 'success', '2023-05-29', '15:11:44', '6%', NULL, 7.42, 'OR-07'),
('PD08', 'Apfood wallet', 'M08', 'success', '2023-06-02', '12:22:54', '6%', NULL, 3.18, 'OR-08'),
('PD09', 'TNG', 'M09', 'success', '2023-06-02', '12:38:42', '6%', NULL, 10.60, 'OR-09');

INSERT INTO APfood_Wallet VALUES 
('WA01', 76.00, 'M01', NULL),
('WA02', 23.90, 'M02', 'PD02'),
('WA03', 18.30, 'M03', NULL),
('WA04', 50.00, 'M04', 'PD04'),
('WA05', 160.00, 'M05', NULL),
('WA06', 35.50, 'M06', 'PD06'),
('WA07', 78.00, 'M07', NULL),
('WA08', 67.00, 'M08', 'PD08'),
('WA09', 20.00, 'M09', NULL),
('WA10', 5.50, 'M10', NULL);

INSERT INTO Reward_Details VALUES 
('R01', 50, '2025-01-05', 'WA01', 'M01'),
('R02', 200, '2025-02-16', 'WA02', 'M02'),
('R03', 42, '2025-03-08', 'WA03', 'M03'),
('R04', 35, '2025-03-11', 'WA04', 'M04'),
('R05', 120, '2025-05-17', 'WA05', 'M05'),
('R06', 351, '2025-05-29', 'WA06', 'M06'),
('R07', 224, '2025-06-02', 'WA07', 'M07'),
('R08', 78, '2025-06-02', 'WA08', 'M08'),
('R09', 90, '2025-06-13', 'WA09', 'M09'),
('R10', NULL, NULL, 'WA10', 'M10');

INSERT INTO Purchase_History VALUES 
('PH01', 'PD01', 'OR-01', 'M01'),
('PH02', 'PD02', 'OR-02', 'M02'),
('PH03', 'PD03', 'OR-03', 'M03'),
('PH04', 'PD04', 'OR-04', 'M04'),
('PH05', 'PD05', 'OR-05', 'M05'),
('PH06', 'PD06', 'OR-06', 'M06'),
('PH07', 'PD07', 'OR-07', 'M07'),
('PH08', 'PD08', 'OR-08', 'M08'),
('PH09', 'PD09', 'OR-09', 'M09');

INSERT INTO Reload_History VALUES 
('RH01', '2022-12-29', '10:09:04', 'WA01'),
('RH02', '2023-02-10', '15:55:47', 'WA02'),
('RH03', '2023-03-13', '8:39:17', 'WA03'),
('RH04', '2023-03-20', '11:25:18', 'WA04'),
('RH05', '2023-04-27', '12:36:04', 'WA05'),
('RH06', '2023-05-10', '9:43:31', 'WA06'),
('RH07', '2023-05-18', '17:04:37', 'WA07'),
('RH08', '2023-06-29', '16:23:19', 'WA08'),
('RH09', '2023-07-01', '13:09:18', 'WA09'),
('RH10', NULL, NULL, 'WA10');

INSERT INTO TNG_Receipt VALUES 
('TNG01', 'M01', 'PD01'),
('TNG02', 'M06', 'PD07'),
('TNG03', 'M08', 'PD09');

INSERT INTO Online_Banking_Receipt VALUES 
('OB01', 'M03', 'HongLeong Bank', 'PD03'),
('OB02', 'M05', 'CIMB Bank', 'PD05');

INSERT INTO Apfood_Wallet_Receipt VALUES 
('AW01', 'M02', 'PD02'),
('AW02', 'M04', 'PD04'),
('AW03', 'M06', 'PD06'),
('AW04', 'M08', 'PD08');

--i. List the food(s) which has the highest rating. Show food id, food name and the rating.
SELECT Food_Menu.FoodID, Food_Menu.fName, Feedback.rating
FROM Food_Menu
FULL OUTER JOIN Feedback
ON Food_Menu.FoodID = Feedback.FoodID
WHERE rating = (SELECT MAX(rating) FROM Feedback);

--ii.Find the total number of feedback per member. Show member id, member name and total number of feedbacks per member.
SELECT Member.memberID, Member.mName AS mName, COUNT(Feedback.feedbackID) AS total_feedback
FROM Member
JOIN Feedback ON Member.memberID = Feedback.memberID
GROUP BY Member.memberID, Member.mName;

--iii. Find members who have not made any orders. Show member id, member name and the total order.
SELECT Member.memberID, Member.mName, COUNT(Orders.orderID) AS total_orders
FROM Member
LEFT JOIN Orders ON Member.memberID = Orders.memberID
GROUP BY Member.memberID, Member.mName
HAVING COUNT(Orders.orderID) = 0;

--iv. Find the total number of food(meal) ordered by manager from each chef.
SELECT Manager.managerID, Manager.mName AS Manager_Name, Chef.chefID, Chef.cName AS Chef_Name, COUNT(Order_Details.foodID) AS Total_Meals_Ordered
FROM Orders
JOIN Order_Details ON Orders.orderID = Order_Details.orderID
JOIN Chef ON Order_Details.chefID = Chef.chefID
JOIN Manager ON Chef.managerID = Manager.managerID
GROUP BY Manager.managerID, Manager.mName, Chef.chefID, Chef.cName
ORDER BY Manager.managerID, Chef.chefID;

--v.Find the total number of food(meal) cooked by each chef. Show chef id, chef name, and number of meals cooked.
SELECT Chef.chefID, Chef.cName AS cName, COUNT(Order_Details.orderID) AS total_meals
FROM Chef
JOIN Order_Details ON Chef.chefID = Order_Details.chefID
GROUP BY Chef.chefID, Chef.cName;

--vi. List all the food where its average rating is more than the average rating of all food.
SELECT Food_Menu.FoodID, Food_Menu.fname, Feedback.rating
FROM Food_Menu
FULL OUTER JOIN Feedback
ON Food_Menu.FoodID = Feedback.FoodID
WHERE rating > (SELECT AVG(rating) FROM Feedback);

--vii. Find the top 3 bestselling food(s). The list should include id, name, price and quantity sold.
SELECT Food_Menu.FoodID, Food_Menu.fname, Food_Menu.fprice_RM, Order_Details.orderQuantity
FROM Food_Menu
FULL OUTER JOIN Order_Details
ON Food_Menu.FoodID = Order_Details.FoodID
WHERE Order_Details.orderQuantity IN(
	SELECT orderQuantity
	FROM(
		SELECT orderQuantity, DENSE_RANK() OVER (ORDER BY orderquantity DESC) AS orderQuantityrank
		FROM Order_Details
	) AS subquery
	WHERE orderQuantityrank <= 3)
	ORDER BY orderquantity DESC;

--viii. Show the top 3 members who spent most on ordering food. List should include id and name and whether they student or staff.
SELECT Member.memberid, Member.mName, Member.mRole, SUM(Payment_Details.subtotal_RM)
FROM Member
FULL OUTER JOIN Payment_Details
ON Member.memberID = Payment_Details.memberID
WHERE Payment_Details.subtotal_RM IN (SELECT TOP 3 SUM(Payment_Details.subtotal_RM) FROM Payment_Details)
GROUP BY Member.memberid, Member.mName, Member.mRole
ORDER BY SUM(Payment_Details.subtotal_RM) DESC;

--ix. Show the total members based on gender who are registered as members. List should include id, name, role(student/staff) and gender. 
SELECT COUNT(memberID) as Total_Gender, mGender FROM Member 
GROUP BY mGender;

--x. Show a list of ordered food which has not been delivered to members. The list should show member id, role(student/staff), contact number, food id, food name, quantity, date, and status of delivery. 
SELECT M.memberID, M.mRole, M.mContactNumber, F.foodID, F.fName, O.orderID, O.orderQuantity, O.deliveryStatus FROM Member M 
INNER JOIN Orders ON Orders.memberID = M.memberID 
INNER JOIN Order_Details O ON O.orderID = Orders.orderID
INNER JOIN Food_Menu F ON F.foodID = O.FoodID
WHERE deliveryStatus IN (SELECT deliveryStatus FROM Order_Details WHERE deliveryStatus != 'Delivered');

--xi. Show a list of members who made more than 2 orders. The list should show their member id, name, and role(student/staff) and total orders.
SELECT Member.memberID, Member.mName, Member.mRole, SUM(Order_Details.orderQuantity) AS total_orders
FROM Member
INNER JOIN Orders ON Member.memberID = Orders.memberID
JOIN Order_Details ON Orders.orderID = Order_Details.orderID
GROUP BY Member.memberID, Member.mName, Member.mRole
HAVING SUM(Order_Details.orderQuantity) > 2;

--xii. Find the monthly sales totals for the past year. The list should show order year, order month and total cost for that month.
SELECT YEAR(Orders.orderDate) AS order_year, MONTH(Orders.orderDate) AS order_month, SUM(Shopping_Cart.totalCost_RM) AS total_monthly_sales_RM
FROM Shopping_Cart
INNER JOIN Orders ON Shopping_Cart.orderID = Orders.orderID
GROUP BY YEAR(Orders.orderDate), MONTH(Orders.orderDate)
ORDER BY YEAR(Orders.orderDate), MONTH(Orders.orderDate);
