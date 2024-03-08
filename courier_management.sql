use courier_management;
insert into user values(101,'Balaji','balaji1@gmail.com','1234@456','9442323232','puducherry'),
                       (102,'Guna','guna2@gmail.com','123@456','1234567890','Tamilnadu'),
                       (103,'Subash','subash3@gmail.com','12@456','9191919191','Kerala'),
                       (104,'Naveen','naveen4@gmail.com','1@456','9494949494','Hyderbad'),
                       (105,'abishek','abishek5@gmail.com','1234@56','9090901212','Mumbai');

select * from user;
                       
insert into courier values
  (1, 'Balaji', 'puducherry',' Guna', 'Tamilnadu', 2.50, 'on-process', 'A12345', '2024-03-15'),
  (2, 'Guna','Tamilnadu','Subash','Kerala', 4.75, 'dispatched', 'B56789', '2024-03-20'),
  (3, 'Subash','Kerala','Naveen','Hyderabad', 1.25, 'out-for-delivery', 'C90123', '2024-03-25'),
  (4, 'Naveen','Hyderabad','abishek', 'Mumbai', 3.10, 'delivered', 'D23456', '2024-03-30'),
  (5, 'abishek','Mumbai','Balaji', 'puducherry', 6.80, 'packing', 'E56789', '2024-04-05');

  select * from courier;
 
 insert into orders values(1,101),
                           (2,102),
                           (3,103),
                           (4,104),
                           (5,105);
                           
select * from orders;
 
INSERT INTO location values
  (1,'Guna', 'Tamilnadu',1),
  (2, 'Subash','Kerala',2),
  (3, 'Naveen','Hyderabad',3),
  (4, 'abishek', 'Mumbai',4),
  (5, 'Balaji', 'puducherry',5);
  
insert into payment values
  (1,1,100.00, '2024-03-15'),
  (2,2,150.00, '2024-03-20'),
  (3,3,75.00, '2024-03-25'),
  (4,4,125.00, '2024-03-30'),
  (5,5,200.00, '2024-04-05');
  
select * from payment;

INSERT INTO employee values
  (1,'John Doe', 'john.doe@company.com', '+1234567890', 'Manager', 5000.00),
  (2,'Jane Smith', 'jane.smith@company.com', '+9876543210', 'Delivery Person', 4000.00),
  (3,'Alice Johnson', 'alice.johnson@company.com', '+0987654321', 'Customer Service Representative', 3500.00),
  (4,'Bob Jones', 'bob.jones@company.com', '+1234567890', 'Marketing Specialist', 4500.00),
  (5,'Charlie Brown', 'charlie.brown@company.com', '+9876543210', 'Accountant', 5200.00);
select * from employee;
                          
SELECT * FROM user;

select c.id,c.sender_name,c.sender_address,c.reciever_name,c.reciever_address,c.status from courier c  join orders o where c.id=o.courier_id and o.user_id=103;

SELECT * FROM courier;

/*4.*/

SELECT * FROM courier
WHERE sender_name = 'Balaji';


SELECT * FROM courier
WHERE status != 'delivered';


SELECT * FROM courier
WHERE delivery_date = CURDATE();


SELECT * FROM courier
WHERE status = 'dispatched';


SELECT sender_name, COUNT(*) AS total_packages
FROM courier
GROUP BY sender_name;

/*10.*/

SELECT * FROM courier
WHERE weight BETWEEN 3.0 AND 5.0;


SELECT * FROM employee
WHERE name LIKE '%john%';

SELECT c.*, p.amount
FROM courier c
INNER JOIN payment p ON c.id = p.courier_id
WHERE p.amount > 50;


SELECT e.name, COUNT(c.courier_id) AS total_couriers
FROM employee e
INNER JOIN courier c ON e.id = c.sender_id
GROUP BY e.name;


