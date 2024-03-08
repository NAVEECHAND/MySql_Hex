use SISDB;
 
 insert into student  values(1,'balaji','ramasamy',2002-11-18,'balaji1@gmail.com',9361949755),
							(2,'abishek','balakrishna',2002-9-10,'abishek2@gmail.com',9442327833),
							(3,'naveen','chander',2002-6-15,'naveen3@gmail.com',9487710134),
							(4,'sasi','ravi',2002-4-13,'sasi4@gmail.com',9488494284),
							(5,'suriya','shivakumar',2002-2-1,'suriya5@gmail.com',9150329273);
	select * from student;
    
                            
                            
  insert into teacher values(1,'dass','arumugam','dass1@gmail.com'),
							(2,'mohan','raj','mohan2@gmail.com'),
                            (3,'harold','dass','harold3@gmail.com'),
                            (4,'antony','dass','antony4@gmail.com'),
                            (5,'chitti','babu','chitti5@gmail.com');
   select * from teacher;   
   
                            
 insert into  payments values(1,499.0,'2022-12-15',1),
                             (2,359.0,'2023-9-16',3),
							 (3,250.0,'2023-9-10',5),
                             (4,365.0,'2024-2-12',4),
                             (5,740.0,'2021-6-15',2);
	select * from payments;
     
                             
insert into courses values(1,'Mysql',12,1),
                          (2,'core java',10,5),
                          (3,'hibernate',15,2),
                          (4,'spring boot',9,4),
                          (5,'selenium',20,3);
	select * from courses;     
    
 
insert into enrollments values(101, '2022-11-18', 2, 5),  
							  (102, '2023-10-14', 1, 3),  
                              (103, '2023-09-09', 4, 2),  
                              (104, '2024-04-07', 5, 1),     
                              (105, '2021-07-03', 3, 4);   
	select * from enrollments;	


/*------------------------task2----------------------*/

/*1.*/   
insert into student values(6,'john','doe','1995-08-15','john.doe@example.com',1234567890);
select * from student;

/*2.*/
insert into enrollments values(106,'2024-03-07',6,2);
select * from enrollments;	

/*3.*/
update teacher set email='hdass3@gmail.com' where teacher_id=3;
select * from teacher;    

/*4.*/  
delete from enrollments where student_id=6 and courses_id=2;
select * from enrollments;    

/*5.*/
update courses set  course_name='basic java' where teacher_id=5;     
select * from courses; 

/*6.*/
delete from student where student_id=6;
select * from student;

/*7.*/
update payments set amount=300 where payment_id=3;
select * from payments;


/*-----------task3---------*/
/*Write an SQL query to calculate the total payments made by a specific student. 
You will need to join the "Payments" table with the "Students" table based on the student's ID.*/
   
select s.student_id,p.payment_id,sum(p.amount) as total_payment from payments p join student s on s.student_id=p.payment_id where s.student_id=1;

/*Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. 
Use a JOIN operation between the "Courses" table and the "Enrollments" table.*/

select c.course_name,count(e.student_id) as count_of_students from courses c join enrollments e on e.courses_id=c.course_id group by c.course_name; 

/*Write an SQL query to find the names of students who have not enrolled in any course. 
Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.*/
insert into student values(6,'john','doe','1995-08-15','john.doe6@example.com',1234567890);
select s.first_name, s.last_name
from student s
left join enrollments e on s.student_id = e.student_id
where e.student_id is null;

/*Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. 
Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.
*/
select concat(s.first_name,' ',s.last_name) as full_name,c.course_name from  student s inner join enrollments e on s.student_id=e.student_id
join courses c on e.courses_id=c.course_id;

/*Create a query to list the names of teachers and the courses they are assigned to. 
Join the "Teacher" table with the "Courses" table.*/
select concat(t.first_name,' ',t.last_name) as full_name,c.course_name from teacher t join courses c on c.teacher_id=t.teacher_id group by t.first_name;

/*Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the
"Students" table with the "Enrollments" and "Courses" tables.*/ 
select concat(s.first_name,' ',s.last_name) as full_name ,c.course_name,e.enrollment_date from student s inner join enrollments e on s.student_id=e.student_id join courses c on e.courses_id=c.course_id;

/*Find the names of students who have not made any payments. 
Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.*/
select concat(s.first_name,' ',s.last_name) as full_name from student s inner join payments p on s.student_id=p.student_id where p.student_id is null;

/*identify the course name that have no enrollment*/
select c.course_name from courses c inner join enrollments e on e.courses_id=c.course_id where e.courses_id is null;

/*Identify students who are enrolled in more than one course. 
Use a self-join on the "Enrollments" table to find students with multiple enrollment records.*/
select e1.student_id, s.first_name, s.last_name from enrollments e1 inner join student s on e1.student_id = s.student_id
inner join enrollments e2 on e1.student_id = e2.student_id where e1.courses_id <> e2.courses_id
group by e1.student_id, s.first_name, s.last_name
having COUNT(distinct e1.courses_id) > 1;

/*Find teachers who are not assigned to any courses. 
Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.*/
select concat(t.first_name,' ',t.last_name) as full_name from teacher t inner join courses c on c.teacher_id=t.teacher_id where c.teacher_id is null;

/*--------------task4--------------*/
/*Write an SQL query to calculate the average number of students enrolled in each course.
 Use aggregate functions and subqueries to achieve this.*/


/*Identify the student(s) who made the highest payment. 
Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.*/
select s.first_name, s.last_name, p.amount
from student s
inner join payments p on s.student_id = p.student_id
where p.amount = (select MAX(amount) from payments);

/* Retrieve a list of courses with the highest number of enrollments. 
Use subqueries to find the course(s) with the maximum enrollment count.*/

select c.course_name, COUNT(e.enrollment_id) as enrollment_count from courses c
left join enrollments e on c.course_id = e.courses_id group by c.course_name
having enrollment_count = (select MAX(enrollment_count) from (select c.course_name, COUNT(e.enrollment_id) as enrollment_count
from courses c left join enrollments e on c.course_id = e.courses_id group by c.course_name) as course_enrollments);

/*Calculate the total payments made to courses taught by each teacher. 
Use subqueries to sum payments for each teacher's courses.*/



/* Identify students who are enrolled in all available courses.
 Use subqueries to compare a student's enrollments with the total number of courses.*/
 
select s.first_name, s.last_name
from student s where (select COUNT(*) from courses c
join enrollments e on c.course_id = e.courses_id join student s on e.student_id = s.student_id where e.courses_id IS NULL)=0;

 /*Retrieve the names of teachers who have not been assigned to any courses.
 Use subqueries to find teachers with no course assignments.*/
select concat(t.first_name,' ',t.last_name) as full_name from teacher t where t.teacher_id in (select c.teacher_id from courses c where c.teacher_id is null);

 /*Calculate the average age of all students. 
 Use subqueries to calculate the age of each student based on their date of birth.*/
SELECT AVG(DATEDIFF(CURDATE(), s.date_of_birth) / 365.25) AS avg_student_age FROM student s;


 /*Identify courses with no enrollments. 
 Use subqueries to find courses without enrollment records.*/
 select c.course_name from courses c where c.course_id in(select e.courses_id from enrollments e where e.courses_id is null);
 
 
 /*Calculate the total payments made by each student for each course they are enrolled in. 
 Use subqueries and aggregate functions to sum payments.*/
select e.student_id, c.course_name, SUM(p.amount) as total_payment
from enrollments e
inner join courses c on e.courses_id = c.course_id
inner join student s on e.student_id = s.student_id
inner join payments p on s.student_id = p.student_id
group by e.student_id, c.course_name;


/*Identify students who have made more than one payment. 
Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.*/
select student_id, first_name, last_name from student s
where (
  select COUNT(*)
  from payments p
  where p.student_id = s.student_id
) > 1;


/*Retrieve a list of course names along with the count of students enrolled in each course. 
Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.*/
select c.course_name, COUNT(e.student_id) AS student_count
from courses c
left join enrollments e on c.course_id = e.courses_id
group by c.course_name;

/*Calculate the average payment amount made by students. 
Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.*/
select avg(p.amount) as avg_payment_amount
from student s
inner join payments p on s.student_id = p.student_id;



 