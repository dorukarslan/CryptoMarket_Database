

//List name and TL values ​​of currencies that have not experienced any decline in the last three days */

select distinct c.coin_name ,m.Price_of_coin from coin as c, market as m
            where c.coin_id  = m.Coin_ID and m.curr_date  = '2021-05-16' and m.coin_id in ((select coin_id from market where DailyRate >0 and Curr_Date ='2021-05-16'
                                                           INTERSECT
                                                            select coin_id from market where DailyRate >0 and Curr_Date ='2021-05-15')
                                                            intersect 
                                                            select coin_id from market where DailyRate >0 and Curr_Date ='2021-05-14');








//List the information of users who have doubled their starting money in the past year and in what currency did they get it   */

select u.full_name , p.asset from users as u, Personal_Savings as p
                           where u.User_ID = p.User_ID and p.cur_date = '2021-05-16' and p.Asset > 2* 
                            (select Asset from Personal_Savings where User_ID = u.User_ID and cur_date = '2021-04-16')
            order by(p.asset);







/*  -----------------------------------------------------------------------
	
 The user name which he/she have order, and the order between 10 april 2021 and 30 april 2021. */
	
select u.Full_name, o.until_date, o.coin_name from Users as u, Orders as o 
        where u.User_ID = o.User_ID and o.Until_Date between '2021-04-10' and '2021-04-30'  ;
	

/*--------------------------------------------------------------------------------------------------

 The Name of the first user and number of coin that he/she has.  */

select u.Full_name, count(w.coin_code) from Users as u , Wallet as w 
    where u.User_ID=w.User_ID and u.register_date IN
            (select min(u1.register_date) from Users as u1)
     group by(u.Full_name);
	

/*------------------------------------------------------------
// Fields which has total asset more than 1000   */
	
select  u.Field, sum(p.Asset) as total from Users as u , Personal_Savings as p
        where u.User_ID=p.User_ID and p.Asset>=1000 
        group by(u.Field) 
        order by( sum(p.Asset));
		

/* -----------------------------------------------------------------------------
// The user name starts with "d" and avegare amount that he/she mined.   */

select u.Full_name, avg(m.Amount) from Users as u, Mining as m
    where u.User_ID=m.User_ID and u.Full_name like 'D%'
    group by(u.full_name);



/*----------------------------------------------------------------------
//Name of user who have highest Asset amoung users at 16 may 2021 */

SELECT U.Full_name, P.Asset from users as U, Personal_Savings as P 
        where U.User_ID = P.User_ID and P.Cur_Date = '2021-05-16' 
            and P.Asset IN
            (SELECT max(Asset) from Personal_Savings);


/*-----------------------------------------------------------------
// Name and country of the user who has max teducoin Amount amoung all users  */

SELECT U.Full_name, U.Country,W.coin_amount from Users as U, Wallet as W
        Where W.User_ID = U.User_ID 
            and W.coin_amount IN
                (SELECT max(w1.coin_amount) 
                from  Wallet as w1 where w1.coin_code = 1);


/* ------------------------------------------------------------------------
//  minning count performed by diverse countries   */

select U.Country,  COUNT(M.Mining_Code) as Total_Mining  from Users as U ,Mining as M
where U.User_ID = M.User_ID 
group by (U.Country);


/*---------------------------------------------------------------------------


// Order codes of users who has avaliable orders until 20.Apr.2021 with buy operation  */ 

select  U.full_name ,u.user_id ,o.order_code from Users as U, Orders as O
    Where O.User_ID = U.User_ID and 
    O.Until_Date < '2021-04-20' 
    and O.Op_Type = 'buy'
    order by(o.order_code);



/*----------------------------------------------------------------------------
// names of users who has coins with positive daily rate in market at 16 may 2021 */

select distinct U.full_name from  Users as U , Wallet as W
    where U.User_ID = w.user_id and w.Coin_Code IN
                            (SELECT M1.Coin_ID from Market as M1
                                where M1.Curr_Date ='2021-05-16' and M1.DailyRate>0 )
     order by(u.full_name);


/*----------------------------------------------------------------------------
// Country names that end with letter A where a mining operation is opearated  */
select u.country from users as u where EXISTS
    (select * from mining as m where m.user_id = u.user_id)
    GROUP by (u.country)
      having ( u.country like '%a' or u.country like'%A');


/*----------------------------------------------------------------------------
// Names and average coin amount of users whose country information is not null.  */

select u.full_name,avg(w.coin_amount) from users as u, wallet as w 
        where u.user_id  = w.user_id and u.country is not null
        group by(u.full_name)
        order by(u.full_name)asc;


/*----------------------------------------------------------------------------
// Name of users who had operations after 15 april 2021  */
select u.full_name from users as u 
    where u.user_id  = 
    some (select distinct user_id from Operations 
            where Op_Date > '2021-04-15');




/*----------------------------------------------------------------------------
//Name  country and register date  of users who registered after all turkish users */
select u.full_name, u.register_date , u.country from users as u
        where u.register_date > ALL(select register_date from users where country = 'Turkey')
       order by(u.register_date)desc;


/*----------------------------------------------------------------------------

// Ids of users who mined TEDUcoin an also have it on their wallets.  */
 select user_id from mining where Coin_Name = 'TEDUcoin'
    INTERSECT
    select user_id from wallet where coin_code = 1;



/*----------------------------------------------------------------------------
// names of Engineer  or Actor  users who  had operations after 15 may 2021 */
select u1.full_name from users as u1 where u1.user_id in
                    (select u.user_id from users as u 
                    where u.Field = 'Engineer' or u.field  = 'Actor'
                    EXCEPT
                    select p.User_ID from operations as p
                     where p.op_date < '2021-04-15');


