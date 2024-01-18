CREATE DATABASE org;

SHOW DATABASES;

USE org;

CREATE TABLE worker(
	worker_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name CHAR(25),
    last_name CHAR(25),
    salary NUMERIC(15),
    joining_date DATETIME,
    department CHAR(25)
);

INSERT INTO worker
	(first_name, last_name, salary, joining_date, department) VALUES
		('Monika','Arora', 100000, '21-02-20 09:00:00','HR'),
        ('Niharika','Verma', 80000, '21-06-11 09:00:00','Admin'),
        ('Vishal','Singhal', 300000, '21-02-20 09:00:00','HR'),
        ('Mohan','Sarah', 300000, '12-03-19 09:00:00','Admin'),
        ('Amitabh','Singh', 500000, '21-02-20 09:00:00','Admin'),
        ('Vivek','Bhati', 490000, '21-06-11 09:00:00','Admin'),
        ('Vipul','Diwan', 200000, '21-06-11 09:00:00','Account'),
        ('Satish','Kumar', 75000, '21-01-20 09:00:00','Account'),
        ('Geetika','Chauhan', 90000, '21-04-11 09:00:00','Account');

CREATE TABLE bonus(
	worker_ref_id INTEGER,
    bonus_amount NUMERIC(10),
    bonus_date DATETIME,
    FOREIGN KEY (worker_ref_id) REFERENCES worker(worker_id)
);

# Task 1: Insert data into table bonus
INSERT INTO bonus
	(worker_ref_id, bonus_amount, bonus_date) VALUES
		(6, 32000, '21-11-02'),
        (6, 20000, '22-11-02'),
        (5, 21000, '21-11-02'),
        (9, 30000, '21-11-02'),
        (8, 4500, '22-11-02');

# Task 2: Write an SQL query to show the second highest salary among all workers.
SELECT IFNULL(
	(SELECT DISTINCT salary
	FROM worker
    ORDER BY salary DESC
    LIMIT 1,1), NULL) AS second_highest_sal;

# Task 3: 
/* Write an SQL query to print the name of employees having the highest salary 
	in each department.*/
SELECT worker.department, first_name, last_name, worker.salary
	FROM worker, (
		SELECT department, max(salary) AS max_salary
        FROM worker
        GROUP BY department
	)temp
    WHERE worker.department = temp. department AND worker.salary >= temp.max_salary;
    
# Task 4:
# Write and SQL query to fetch the list of employees with the same salary.
SELECT first_name, last_name, worker.salary
	FROM worker,(
		SELECT worker_id ,salary
		FROM worker
	)temp
	WHERE worker.salary = temp.salary AND worker.worker_id != temp.worker_id;

#Task 5:
# Write and SQL query to find the worker names with salaries + bonus in 2021
SELECT first_name, last_name,salary,bonus_amount,bonus_date
	FROM worker,bonus
    WHERE worker_id = worker_ref_id AND  bonus_amount != 0 AND  year(bonus_date) = 2021;

#Task 6
#Try to delete all the records in table WORKER
ALTER TABLE bonus 
	DROP worker_ref_id;
    
DELETE FROM worker;

#Task 7
#Try to drop table worker
DROP TABLE worker;

SELECT * FROM worker;
SELECT * FROM bonus;




















