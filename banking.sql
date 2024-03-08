use bank_hex_feb_24;
show tables;
#insertions in customer tables
insert into customer(first_name,last_name,dob) values
('harry','potter','2002-03-21'),
('ronald','weasley','2001-02-10'),
('hermione','granger','2002-11-15');
#insertion into account table
insert into account(account_type,balance,customer_id) values
('savings',50000,1) ,
('current',120000,2) ,
('zero_balance',100000,3),
('current',150000,1) ,
('savings',30000,3);
#insertion into transaction table

insert into transaction(transaction_type,amount,transaction_date,account_id)
values
('deposit', 10000, '2024-02-01',1),
('withdrawal', 5000, '2024-02-02',1),
('deposit', 20000, '2024-02-02',2),
('withdrawal', 8000, '2024-02-02',3),
('transfer', 20000, '2024-02-01',4),
('transfer', 7000, '2024-02-05',5);

select * from transaction;
/* Write a SQL query to retrieve the name, account type and email of all customers. */
select DISTINCT c.first_name,a.account_type from customer c JOIN account a ON c.id=a.customer_id group by c.first_name; 

/*Write a SQL query to list all transaction corresponding customer.*/
SELECT distinct
    c.first_name,
    c.last_name,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM transaction t
JOIN account a ON t.account_id = a.customer_id
JOIN customer c ON a.customer_id = c.id;

/* Write a SQL query to increase the balance of a specific account by a certain amount*/
UPDATE account
SET balance = balance + 10000
WHERE id=1;
select * from account;

/*Write a SQL query to Combine first and last names of customers as a full_name.*/
SELECT distinct CONCAT(c.first_name, ' ', c.last_name) as full_name
FROM customer c;

/*Write a SQL query to Get the account balance for a specific account.*/
select distinct balance from account where account_type='savings';

/*Write a SQL query to List all current accounts with a balance greater than $1,000.*/
select distinct account_type,balance from account where account_type='current'and balance>82846;

/* Write a SQL query to Retrieve all transactions for a specific account.*/
select  distinct t.account_id, t.transaction_type, t.amount, t.transaction_date
from transaction t
where t.account_id =1;

/* Write a SQL query to Calculate the interest accrued on savings accounts based on a 
given interest rate.*/
select CONCAT(c.first_name,' ' ,c.last_name) as customer_name,
       a.balance,(a.balance * 0.05) as estimated_interest 
from customer c
inner join account a on c.id = a.customer_id
where a.account_type = 'savings';

/*Write a SQL query to Identify accounts where the balance is less than a specified 
overdraft limit.*/
select CONCAT(c.first_name,' ',c.last_name) as customer_name, a.account_type, a.balance
from customer c
inner join account a on c.id = a.customer_id
where a.balance < -50000;  

/*Write a SQL query to Find customers not living in a specific city*/





/* 1. Write a SQL query to Find the average account balance for all customers.  */

select customer_id, AVG(balance)
from account 
group by customer_id; 

/* 
O/P:
+-------------+--------------+
| customer_id | AVG(balance) |
+-------------+--------------+
|           1 |       100000 |
|           2 |       120000 |
|           3 |        65000 |
+-------------+--------------+
*/

/* 
2. Write a SQL query to Retrieve the top 10 highest account balances.
*/
select balance 
from account
order by balance DESC
limit 0,3; 

/* 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date. Also display name of the customer  */

select c.first_name,c.last_name,t.transaction_type, t.amount, t.transaction_date
from transaction t JOIN account a ON a.id = t.account_id JOIN customer c ON c.id = a.customer_id
where t.transaction_date = '2024-02-02' AND t.transaction_type='withdrawal';

/* 4. Write a SQL query to Find the Oldest and Newest Customers. */

(select first_name,dob,'oldest' as status from customer order by dob limit 0,1)
UNION
(select first_name,dob,'youngest' as status from customer order by dob DESC limit 0,1);

/* 
O/P: 
+------------+------------+----------+
| first_name | dob        | status   |
+------------+------------+----------+
| ronald     | 2001-02-10 | oldest   |
| hermione   | 2002-11-15 | youngest |
+------------+------------+----------+
*/

/* 
5. Write a SQL query to Retrieve transaction details along with the account type.
*/
select t.id,t.transaction_type,t.amount,t.transaction_date from transaction t join account a on t.account_id=a.id;

/* 
6. Write a SQL query to Get a list of customers along with their account details.
*/
select concat(c.first_name,' ',c.last_name) as full_name ,a.id,a.account_type,a.balance from  customer c join account a on c.id=a.customer_id; 


/* 
7. Write a SQL query to Retrieve transaction details along with customer information for a 
specific account.
*/
select distinct c.id,concat(c.first_name,' ',c.last_name) as full_name,c.dob,t.id as transction_id,t.transaction_type,t.amount,t.transaction_date from transaction t join account a on t.account_id=a.id 
join customer c on c.id=a.customer_id where a.id=2;


/* 
8. Write a SQL query to Identify customers who have more than one account.
*/

select c.first_name,count(c.id) as Number_of_accounts
from customer c JOIN account a ON c.id = a.customer_id
-- where count(c.id) > 1 - 0	Invalid use of group function 
group by a.customer_id
having Number_of_accounts>1;

/* 
a.customer_id=1 (2)
	1	harry	potter	2002-03-21	1	savings	50000	1
	1	harry	potter	2002-03-21	4	current	150000	1
a.customer_id=2 (1)
	2	ronald	weasley	2001-02-10	2	current	120000	2
a.customer_id=3 (2)
	3	hermione	granger	2002-11-15	3	zero_balance	100000	3
	3	hermione	granger	2002-11-15	5	savings	30000	3
*/

/* 
9. Write a SQL query to Calculate the difference in transaction amounts between deposits and 
withdrawals.

*/
select MAX(amount) - MIN(amount) as difference
from
((select transaction_type ,SUM(amount) as amount, 'deposit' as op
from transaction
where transaction_type ='deposit' ) 
union
(select transaction_type , SUM(amount) as amount, 'withdrawal' as op
from transaction
where transaction_type ='withdrawal')) AS T;

/* 
We find deposit amount using 1 query 
and withdrawal amount using another query. 

then we bring the result togather in a Derived table called as T. 

T
--
30K
13K 

from this T(which is a table in itself) we compute MAX and MIN and do the arithmetic and get the result 
*/

-- alternatively 
select 
((select SUM(amount) 
from transaction
where transaction_type ='deposit' ) -  (select  SUM(amount) 
from transaction
where transaction_type ='withdrawal')) as diff;


/*----------------------------------------task2--------------------------------*/
/* Write SQL queries for the following tasks*/

/*1. Write a SQL query to retrieve the name, account type and email of all customers. */
select distinct concat(c.first_name,'',c.last_name) as full_name,a.account_type  from customer c join account a where c.id=a.customer_id;


/*2. Write a SQL query to list all transaction corresponding customer.*/
select distinct concat(first_name,' ',last_name) as full_name,t.transaction_type from transaction t join account a on t.account_id=a.id 
join customer c on a.customer_id=c.id; 


/*3. Write a SQL query to increase the balance of a specific account by a certain amount.*/
update account set balance=balance+81000 where account_type='savings';
select * from account where account_type='savings';


/*4. Write a SQL query to Combine first and last names of customers as a full_name.*/
select distinct concat(first_name,' ',last_name) as full_name from customer;


/*5. Write a SQL query to remove accounts with a balance of zero where the account 
type is savings.*/
delete from account where balance=0 and account_type='savings';
select * from account;

/*6. Write a SQL query to Find customers living in a specific city.*/



/*7. Write a SQL query to Get the account balance for a specific account.*/
select a.id ,a.balance from account a where a.id=2;

/*8. Write a SQL query to List all current accounts with a balance greater than $1,000.*/
select a.id,a.account_type,a.balance from account a where a.balance>82768 and a.account_type='current';

/*9. Write a SQL query to Retrieve all transactions for a specific account.*/
select t.id,t.transaction_type from transaction t join account a on t.account_id=a.id where a.id=1;


/*10. Write a SQL query to Calculate the interest accrued on savings accounts based on a 
given interest rate.


11. Write a SQL query to Identify accounts where the balance is less than a specified 
overdraft limit.*/
select a.id,a.account_type,a.balance  from account a where a.balance < 180000; 


/*12. Write a SQL query to Find customers not living in a specific city.*/



/*---Task 3---*/

/* 1. Write a SQL query to Find the average account balance for all customers.  */
select customer_id, AVG(balance)
from account 
group by customer_id; 

/* 
O/P:
+-------------+--------------+
| customer_id | AVG(balance) |
+-------------+--------------+
|           1 |       100000 |
|           2 |       120000 |
|           3 |        65000 |
+-------------+--------------+
*/

/* 
2. Write a SQL query to Retrieve the top 10 highest account balances.
*/
select balance 
from account
order by balance DESC
limit 0,3; 

/* 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date. Also display name of the customer  */

select c.first_name,c.last_name,t.transaction_type, t.amount, t.transaction_date
from transaction t JOIN account a ON a.id = t.account_id JOIN customer c ON c.id = a.customer_id
where t.transaction_date = '2024-02-02' AND t.transaction_type='withdrawal';

/* 4. Write a SQL query to Find the Oldest and Newest Customers. */

(select first_name,dob,'oldest' as status from customer order by dob limit 0,1)
UNION
(select first_name,dob,'youngest' as status from customer order by dob DESC limit 0,1);

/* 
O/P: 
+------------+------------+----------+
| first_name | dob        | status   |
+------------+------------+----------+
| ronald     | 2001-02-10 | oldest   |
| hermione   | 2002-11-15 | youngest |
+------------+------------+----------+
*/

/* 
5. Write a SQL query to Retrieve transaction details along with the account type.
*/
select t.id as transaction_id,t.transaction_type,a.account_type,t.amount,t.transaction_date from transaction t join account a on t.account_id=a.id;
/* 

6. Write a SQL query to Get a list of customers along with their account details.
*/
select concat(c.first_name,' ',c.last_name)as full_name,a.id as account_id,a.account_type,a.balance from customer c join account a on c.id=a.customer_id;
/* 

7. Write a SQL query to Retrieve transaction details along with customer information for a 
specific account.
*/
select distinct c.id,concat(c.first_name,' ',c.last_name) as full_name,c.dob,t.id as transction_id,t.transaction_type,t.amount,t.transaction_date from transaction t join account a on t.account_id=a.id 
join customer c on c.id=a.customer_id where a.id=2;
/* 
8. Write a SQL query to Identify customers who have more than one account.
*/

select c.first_name,count(c.id) as Number_of_accounts
from customer c JOIN account a ON c.id = a.customer_id
-- where count(c.id) > 1 - 0	Invalid use of group function 
group by a.customer_id
having Number_of_accounts>1;

/* 
a.customer_id=1 (2)
	1	harry	potter	2002-03-21	1	savings	50000	1
	1	harry	potter	2002-03-21	4	current	150000	1
a.customer_id=2 (1)
	2	ronald	weasley	2001-02-10	2	current	120000	2
a.customer_id=3 (2)
	3	hermione	granger	2002-11-15	3	zero_balance	100000	3
	3	hermione	granger	2002-11-15	5	savings	30000	3
*/

/* 
9. Write a SQL query to Calculate the difference in transaction amounts between deposits and 
withdrawals.

*/
select MAX(amount) - MIN(amount) as difference
from
((select transaction_type ,SUM(amount) as amount, 'deposit' as op
from transaction
where transaction_type ='deposit' ) 
union
(select transaction_type , SUM(amount) as amount, 'withdrawal' as op
from transaction
where transaction_type ='withdrawal')) AS T;

/* 
We find deposit amount using 1 query 
and withdrawal amount using another query. 

then we bring the result togather in a Derived table called as T. 

T
--
30K
13K 

from this T(which is a table in itself) we compute MAX and MIN and do the arithmetic and get the result 
*/

-- alternatively 
select 
((select SUM(amount) 
from transaction
where transaction_type ='deposit' ) -  (select  SUM(amount) 
from transaction
where transaction_type ='withdrawal')) as diff;

/* 
10. Write a SQL query to Calculate the average daily balance for each account over a specified 
period.*/

/*11. Calculate the total balance for each account type.*/
select  distinct a.account_type,a.balance from account a where a.account_type='zero_balance';
select distinct a.account_type ,sum(a.balance) as total_balance from account a group by account_type;


/*12. Identify accounts with the highest number of transactions order by descending order.*/
SELECT c.first_name, c.last_name,  a.account_type, COUNT(t.id) AS transaction_count
FROM customer c
INNER JOIN account a ON c.id = a.customer_id
INNER JOIN transaction t ON a.id = t.account_id
GROUP BY c.first_name, c.last_name, a.account_type
ORDER BY transaction_count DESC;


/*13. List customers with high aggregate account balances, along with their account types.*/
select c.first_name, c.last_name, a.account_type, SUM(a.balance) as total_balance
from customer c
inner join account a on c.id = a.customer_id
inner join transaction t on a.id = t.account_id
group by c.first_name, c.last_name, a.account_type
order by total_balance DESC;


/*14. Identify and list duplicate transactions based on transaction amount, date, and account
*/


/*----------------------task4-----------------------*/
/* 
/*Tasks 4: Subquery and its type:*/
/*1. Retrieve the customer(s) with the highest account balance.*/

-- highest account balance

select c.first_name, c.last_name
from customer c
where c.id in (
  select a.customer_id
  from account a
  where a.balance = (
    select MAX(balance)
    from account
  )
);





/*2. Calculate the average account balance for customers who have more than one account.*/

-- find customers having more than 1 account 

select customer_id    
from account
group by customer_id
having count(id) > 1; -- (1,3) 

-- find avg account balance for all customers 
select avg(balance)
from account; 

-- for specific customer from above query
select avg(balance)
from account
where customer_id IN (select customer_id    
					  from account
					  group by customer_id
					  having count(id) > 1);

/*3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.*/

select c.id, c.first_name, c.last_name
from customer c
where c.id in (
  select t.account_id
  from transaction t
  where t.amount > (
    select AVG(amount)
    from transaction
  )
);

/*4. Identify customers who have no recorded transactions.*/
select c.first_name, c.last_name
from customer c
where c.id not in (
    select t.customer_id
    from transaction t);

/*5. Calculate the total balance of accounts with no recorded transactions.*/


/*6. Retrieve transactions for accounts with the lowest balance.*/

select t.*
from transaction t
where t.account_id in (
  select  a.id
  from account a
  order by a.balance ASC);


/*7. Identify customers who have accounts of multiple types.*/
select c.first_name, c.last_name
from customer c
where c.id in (
  select distinct a.customer_id
  from account a
  group by a.customer_id
  having COUNT(distinct a.account_type) > 1
);

/*8. Calculate the percentage of each account type out of the total number of accounts.*/


/*9. Retrieve all transactions for a customer with a given customer_id.*/
select distinct t.transaction_type,t.amount,t.transaction_date
from transaction t
where t.account_id in (
  select a.id
  from account a
  where a.customer_id = 2
)order by t.transaction_type;



/*10. Calculate the total balance for each account type, including a subquery within the SELECT
clause.
*/
select a.account_type, SUM(t.amount) as total_balance
from account a
inner join transaction t on a.id = t.account_id
group by a.account_type;





