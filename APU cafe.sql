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
);

CREATE TABLE


INSERT INTO Member VALUES ('M01','Harry','harry123','23h483ej','Male','Student','012-3345637'),
('M02','Matthew','5_matt_5','dj37dj9d','Male','Student','017-8051823'),
('M03','Evelyn','evelynnn','4372hd82','Female','Staff','012-4441016'),
