
CREATE TABLE public.Users(
	User_ID int NOT NULL,
	Full_name varChar(100) NOT NULL,
	Country varChar(15),
	Register_Date date NOT NULL,
	Field varchar(100),
	PRIMARY KEY(User_ID)
);

CREATE TABLE public.Coin(
	Coin_ID int NOT NULL,
	Coin_Name varchar(50) NOT NULL,
	Number_of_users int,
	Country varchar(15),
	Protocol varchar(20),
	PRIMARY KEY(Coin_ID)

);
CREATE TABLE public.Wallet(
	Wallet_ID int NOT NULL,
	Coin_Code int ,
	User_ID int NOT NULL,
	Coin_Amount decimal(8,2) ,
	Coin_Price decimal(8,2),
	Added_date date,
	PRIMARY KEY(Wallet_ID),
	CONSTRAINT wallet_fk
		FOREIGN KEY(User_ID)
			REFERENCES Users(User_ID),
	CONSTRAINT wallet_fk2 
		FOREIGN KEY(Coin_Code) 
			REFERENCES coin(Coin_ID)
);

	
	
CREATE TABLE public.Mining(
	Mining_Code int NULL,
	Coin_Name varChar(50) NOT NULL,
	Amount int,
	First_Mine date NOT NULL,
	User_ID int NOT NULL,
	PRIMARY KEY (Mining_Code),
	CONSTRAINT mining_fk
		FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
);
CREATE TABLE public.Market(
    Coin_ID int NOT NULL,
    Price_of_coin decimal(7,2) NOT NULL,
    DailyRate int NOT NULL,
    Curr_Date date NOT NULL,
    constraint market_fk FOREIGN KEY (Coin_ID) REFERENCES Coin(Coin_ID)
);


CREATE TABLE public.Operations(
    Op_code int NOT NULL,
    User_ID int NOT NULL,
    USDT_Value int NOT NULL,
    Op_Date date NOT NULL,
    Coin_Name varChar(50) NOT NULL,
    Amount_of_Coin int NOT NULL,
    PRIMARY KEY(Op_code),
    constraint op_fk FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE public.Personal_Savings(
    Account_ID int NOT NULL,
    Asset int NOT NULL,
    User_ID int NOT NULL,
    All_Time_Rate int,
    Cur_Date date NOT NULL,
    PRIMARY KEY (Account_ID),
    CONSTRAINT personal_saving_fk FOREIGN KEY(User_ID) REFERENCES Users(User_ID)

);

CREATE TABLE Orders(
    Order_Code int NOT NULL,
    Coin_Name varChar(50) NOT NULL,
    Coin_Amount numeric(6,2) NOT NULL,
    Until_Date date NOT null,
    Op_Type varChar(4) NOT NULL,
    Limit_Price numeric(6,2) NOT NULL,
    User_ID int NOT NULL,
    PRIMARY KEY (Order_Code),
    CONSTRAINT order_fk FOREIGN KEY(User_ID) REFERENCES Users(User_ID)


);




INSERT INTO users (User_ID,Full_name,Country,Register_Date,Field)
values(1,'Doruk Arslan', 'Turkey', '2021-04-20' , 'Engineer'),
(2,'Lebron James', 'USA', '2021-05-01' , 'Basketball Player'),
(3,'Elton John','UK','2021-05-10','Singer'),
(4,'Doğuhan Cumaoğlu','Turkey','2021-03-12','Engineer'),
(5,'Zlatan Ibrahimovic','Sweeden','2021-01-04','Football Player'),
(6,'Kate Winslet','UK','2021-01-05','Actor'),
(7,'Burak Sağlam','Turkey','2021-01-5','Engineer'),
(8,'Jackie Chan','China','2021-02-13','Actor'),
(9,'Karl Marx','Germany','2021-04-20','Philosopher'),
(10,'Acun Ilıcalı','Turkey','2021-04-20','Entrepreneur'); 


INSERT INTO users (User_ID,Full_name,Register_Date,Field)
values(11, 'David Gilmour', '2021-05-13','Musician'),
(12,'David Fincher','2021-02-20','Director');


INSERT INTO Coin (Coin_ID,Coin_Name,Number_of_users,Country,Protocol)
values(1,'TEDUcoin', 5, 'Turkey' , 'Quorum'),
(2,'ALGOcoin', 2, 'Japan' , 'Corda') ,
(3, 'PYTHONcoin', 4, 'USA' , 'Multichain'),
(4,'Object-Oriented-coin', 3, 'Canada' , 'HyperLedger'),
(5,'BOOLcoin',1, 'Belgium' , 'Quorum'),
(6,'PARSEINTcoin',2, 'Italy' , 'Corda'),
(7, 'JAVAcoin', 3, 'France' , 'Multichain'),
(8,'APPLEcoin', 2, 'USA' , 'HyperLedger'),
(9,'BESTcoin', 2, 'Cuba' , 'Multichain'),
(10,'ENCAPSULATIONcoin', 2, 'Japan' , 'Corda'),
(11,'DODIcoin', 31, 'Turkey' , 'Quorum');






INSERT INTO Market (Coin_ID,Price_of_coin,DailyRate,Curr_Date)
values(1, 246,-8,'2021-05-16'),
 (2,1.24,15,'2021-05-16'),
 (3,0.31,14,'2021-05-16'),
 (4,125,2,'2021-05-16'),
 (5,51,-4 ,'2021-05-16'),
 (6,21,51,'2021-05-16'),
 (7,65,1,'2021-05-16'),
 (8,0.23,50,'2021-05-16'),
 (9,62,25,'2021-05-16'),
 (10,1023,-12,'2021-05-16'),
 (4,110,-4,'2021-05-15'),
 (5,70,13,'2021-05-15'),
 (6,52,100,'2021-05-15'),
 (7,20,-12,'2021-05-15'),
 (8,0.27,60,'2021-05-15'),
 (9,70,30,'2021-05-15'),
 (10,1300,140,'2021-05-15'),
 (1,250,5,'2021-05-15'),
 (1,222,7,'2021-05-14'),
 (1,223,-2,'2021-05-13'),
 (2,0.5,5,'2021-05-15'),
 (2,0.7,7,'2021-05-14'),
 (2,0.9,2,'2021-05-13'),
 (3,250,-2,'2021-05-15'),
 (3,222,-4,'2021-05-14'),
 (3,223,5,'2021-05-13');

INSERT INTO Orders (Order_Code,Until_Date,Coin_Name,Coin_Amount,Op_Type,Limit_Price,user_id)
 values(10,'2021-04-26','TEDUcoin',12,'buy',500,1),
 (11,'2021-04-22','JAVAcoin',1,'sell',12,1),
 (12,'2021-04-20','ALGOcoin',12,'sell',1.10,1),
 (20,'2021-04-22','Object-Oriented-coin',12,'buy',500,2),
 (30,'2021-04-25','ENCAPSULATIONcoin',1,'sell',12,3),
 (31,'2021-04-24','PARSEINTcoin',31,'sell',1.10,3),
 (40,'2021-04-20','BOOLcoin',12,'sell',21,4),
 (41,'2021-04-17','PARSEINTcoin',1,'buy',42,4),
 (42,'2021-04-21','BESTcoin',10,'buy',23,4),
 (50,'2021-04-20','BOOLcoin',12,'sell',21,5),
 (51,'2021-04-10','PARSEINTcoin',1,'buy',2,5),
 (52,'2021-04-22','PYTHONcoin',50,'buy',12,5),
 (53,'2021-04-30','PYTHONcoin',25,'sell',3,5),
 (70,'2021-04-5','JAVAcoin',5,'sell',9,7),
 (71,'2021-04-2','Object-Oriented-coin',12,'sell',7,7),
 (80,'2021-04-16','ALGOcoin',5,'sell',16,8),
 (81,'2021-04-29','APPLEcoin',2000,'sell',22,8),
 (82,'2021-04-25','Object-Oriented-coin',2,'sell',9,8),
 (60,'2021-04-16','ALGOcoin',5,'sell',16,6),
 (61,'2021-04-29','APPLEcoin',2000,'sell',22,6),
 (62,'2021-04-25','Object-Oriented-coin',2,'sell',9,6),
 (90,'2021-04-16','ALGOcoin',5,'sell',16,9),
 (91,'2021-04-29','APPLEcoin',2000,'sell',22,9),
 (92,'2021-04-15','Object-Oriented-coin',2,'sell',9,9),
 (100,'2021-04-1','ALGOcoin',5,'buy',34,10),
(101,'2021-04-9','APPLEcoin',2000,'buy',16,10),
 (102,'2021-04-5','Object-Oriented-coin',1,'buy',952,10);




INSERT INTO Wallet (Wallet_ID ,Coin_Code,User_ID,Coin_Amount,Coin_Price,Added_date)
VALUES (10,1,1,1,20,'2021-05-16'),
(11,2,1,2,40,'2021-05-16'),
(12,4,1,10,1,'2021-05-15'),
(13,8,1,40,1,'2021-05-15'),
(20,6,2,25,4,'2021-05-16'),
(21,7,2,15,1,'2021-05-15'),
(22,8,2,40,3,'2021-05-16'),
(30,8,3,2,1,'2021-05-16'),
(40,10,4,4,12,'2021-05-15'),
(41,1,4,1,20,'2021-05-15'),
(50,7,5,2,11,'2021-05-15'),
(51,1,5,5,33,'2021-05-15'),
(60,6,6,3,13,'2021-05-16'),
(70,9,7,1,20,'2021-05-16'),
(71,3,7,1 ,20,'2021-05-15'),
(80,1,8,1,20,'2021-05-16'),
(90,6,9,12,11,'2021-05-15'),
(100,1,10,4,9,'2021-05-16'),
(110,1,11,25,4,'2021-05-16'),
(111,3,11,40,3,'2021-05-16'),
(112,5,11,4,9,'2021-05-16');

INSERT INTO Mining(Mining_Code,First_Mine,Coin_Name,Amount,User_ID)
VALUES 
(10,'2021-04-13','TEDUcoin',10,1),
(11,'2021-04-05','APPLEcoin',500,1),
(20,'2021-04-06','TEDUcoin',22,2),
(30,'2021-04-12','Object-Oriented-coin',31,3),
(40,'2021-04-14','ALGOcoin',52,4),
(50,'2021-04-30','TEDUcoin',252,5),
(51,'2021-04-02','PARSEINTcoin',10,5),
(60,'2021-04-01','PARSEINTcoin',2,6),
(70,'2021-04-02','BOOLcoin',1,7),
(71,'2021-04-15','TEDUcoin',156,7),
(72,'2021-04-02','TEDUcoin',17,7),
(73,'2021-04-26','TEDUcoin',62,7),
(80,'2021-04-26','PYTHONcoin',54,8),
(90,'2021-04-22','PYTHONcoin',61,9),
(100,'2021-04-21','BOOLcoin',99,10);



INSERT INTO Personal_Savings(Account_ID,Asset,All_Time_Rate,Cur_Date,User_ID)
VALUES 
(10,5783,40,'2021-05-16',1),
(20,100,-100,'2021-05-16',2),
(30,2325,31,'2021-05-16',3),
(40,16721,52,'2021-05-16',4),
(50,1102,20,'2021-05-16',5),
(60,900,-40,'2021-05-16',6),
(70,10,-200,'2021-05-16',7),
(80,250000,600,'2021-05-16',8),
(90,31320,-18,'2021-05-16',9),
(100,622,24,'2021-05-16',10),
(11,2123,-5,'2021-04-16',1),
(21,245,20,'2021-04-16',2),
(31,1215,0,'2021-04-16',3),
(41,16751,50,'2021-04-16',4),
(51,435,-50,'2021-04-16',5),
(61,971,-40,'2021-04-16',6),
(71,4,-300,'2021-04-16',7),
(81,105125,100,'2021-04-16',8),
(91,31522,-15,'2021-04-16',9),
(101,504,19,'2021-04-16',10);



INSERT INTO Operations(Op_code,Op_Date,Coin_Name,Amount_of_Coin,USDT_Value,User_ID)
VALUES (10,'2021-04-22','TEDUcoin',10,50,1),
(11,'2021-04-02','JAVAcoin',1,31,1),
(12,'2021-04-10','ALGOcoin',156,1.10,1),
(20,'2021-04-30','Object-Oriented-coin',12,500,2),
(30,'2021-04-25','ENCAPSULATIONcoin',26,26,3),
(31,'2021-04-24','PARSEINTcoin',31,1.10,3),
(40,'2021-04-20','BOOLcoin',12,21,4),
(41,'2021-04-17','PARSEINTcoin',114,42,4),
(42,'2021-04-21','BESTcoin',10,20,4),
(50,'2021-04-20','BOOLcoin',12,21,5),
(51,'2021-04-10','PARSEINTcoin',1,2,5),
(52,'2021-04-22','PYTHONcoin',50,12,5),
(53,'2021-04-30','PYTHONcoin',25,3,5),
(70,'2021-04-05','JAVAcoin',5,9,7),
(71,'2021-04-02','Object-Oriented-coin',12,7,7),
(80,'2021-04-16','ALGOcoin',5,16,8),
(81,'2021-04-29','APPLEcoin',2000,22,8),
(82,'2021-04-25','Object-Oriented-coin',2,9,8),
(60,'2021-04-16','ALGOcoin',15,56,6),
(61,'2021-04-29','APPLEcoin',2000,22,6),
(62,'2021-04-25','Object-Oriented-coin',2,9,6),
(90,'2021-04-16','ALGOcoin',5,16,9),
(91,'2021-04-29','APPLEcoin',2,222,9),
(92,'2021-04-13','Object-Oriented-coin',51,72,9),
(100,'2021-04-01','ALGOcoin',13,51,10),
(101,'2021-04-09','APPLEcoin',2,16,10),
(102,'2021-04-05','Object-Oriented-coin',12,900,10);

CREATE VIEW usersInfo AS
SELECT Full_name, Country, Field, Register_Date
FROM users u ;

update users 
set country = 'USA'
where user_id = 11;



UPDATE usersInfo
SET register_date= '2020-12-30'
where country = 'China';

delete from usersInfo where country is null;

ALTER TABLE coin
DROP COLUMN country;

/*-----------Wallet----------------------
// DELETE the Marx wallet.*/
delete from wallet where User_ID=9;

/* UPTADE the TEDUcoin amount of Doruk.*/
UPDATE wallet set coin_amount =2 where User_ID=1 and coin_code=1;

/*-----------Market------------------------
// DELETE DODİCoin from market*/
delete from market where coin_ID=9;

/* UPTADE price of TEDUcoin*/ 
update market set price_of_coin=248 where coin_id =1 and curr_date='2021-05-16';

/*-----------Coin-----------------------
// DELETE DODIcoin from coin table.*/
delete from coin where coin_id=11;  

/*UPTADE TEDUcoins number of users.*/
update coin set Number_of_users=6 where coin_id=1;  

/*-----------mining----------------------
//Delete the mining data of KARL MARX*/

delete from mining where user_id =9;

/*//UPTADE the date of first mine of Doruk  */
update mining set first_mine ='2021-5-16' where user_id=1;

/*-----------operations----------------------
// Delete KARL MARX opertions.*/
delete from operations where user_id =9;


/*//UPTADE the Doruks opertions TEDUcoins usdt_value;  */
update operations set usdt_value=48 where user_id=1 and coin_name='TEDUcoin' and op_date ='2021-04-22';

/*-----------orders----------------------
//Delete the KARL MARX orders;*/
delete from orders where user_id =9;

/*//UPTADE the Doruks TEDUcoin orders to sell; */ 
update orders set op_type ='sell' where user_id=1 and coin_name='TEDUcoin' and until_date = '2021-04-26';

/*-----------personal_savings----------------------
//Delete the KARL MARX personal_savings.*/
delete from personal_savings where user_id =9;

/*//uptade the Doruks asset;*/
update personal_savings set asset=5700 where user_id=1;

/*-----------USER------------------------
//Delete the KARL MARX users data*/
delete from users where user_id =9;
/*// Uptade Elton John country to 'USA'*/
update users set country = 'USA' where user_id = 3;
