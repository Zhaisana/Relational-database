ALTER SESSION SET NLS_TIMESTAMP_FORMAT='YYYY-MM-DD HH24:MI:SS';

BEGIN
FOR c IN ( SELECT table_name FROM user_tables)
LOOP
EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS' ;
END LOOP;
END;
/
DROP SEQUENCE employees_seq;
DROP SEQUENCE clients_seq;
DROP SEQUENCE clean_serv_seq;
DROP SEQUENCE feedback_seq;
DROP SEQUENCE work_hour_seq;
DROP SEQUENCE emp_serv_seq;
DROP SEQUENCE serv_client_seq;
-- tables
-- Table: cleaning_services
CREATE TABLE cleaning_services (
    ID_services integer  NOT NULL,
    name_of_service varchar2(20)  NOT NULL,
    price number(6,2)  NOT NULL,
    CONSTRAINT cleaning_services_pk PRIMARY KEY (ID_services)
) ;

-- Table: clients
CREATE TABLE clients (
    ID_clients integer  NOT NULL,
    client_name varchar2(20)  NOT NULL,
    client_surname varchar2(30)  NOT NULL,
    phone_number number(30)  NOT NULL,
    CONSTRAINT clients_pk PRIMARY KEY (ID_clients)
) ;

-- Table: employee
CREATE TABLE employee (
    ID_employee integer  NOT NULL,
    name varchar2(20)  NOT NULL,
    surname varchar2(20)  NOT NULL,
    number_card number(30)  NOT NULL,
    ID_supervisor integer  NULL,
    salary number Not null,
    CONSTRAINT employee_pk PRIMARY KEY (ID_employee)
) ;

-- Table: employees_in_service
CREATE TABLE employee_in_service (
    ID_employee_in_service integer  NOT NULL,
    ID_cleaning_services integer  NOT NULL,
    ID_employee integer  NOT NULL,
    CONSTRAINT employees_in_service_pk PRIMARY KEY (ID_employee_in_service)
) ;

-- Table: feedbacks
CREATE TABLE feedbacks (
    ID_feedbacks integer  NOT NULL,
    date_of_sent timestamp  NOT NULL,
    "comment" varchar2(200)  NOT NULL,
    ID_type integer  NOT NULL,
    ID_clients integer  NOT NULL,
    CONSTRAINT feedbacks_pk PRIMARY KEY (ID_feedbacks)
) ;

-- Table: service_assigned_to_clients
CREATE TABLE service_assigned_to_clients (
    ID_service_client integer  NOT NULL,
    ID_clients integer  NOT NULL,
    ID_cleaning_services integer  NOT NULL,
    CONSTRAINT service_assigned_to_clients_pk PRIMARY KEY (ID_service_client)
) ;

-- Table: type
CREATE TABLE type (
    ID_type integer  NOT NULL,
    type_name varchar2(20)  NOT NULL,
    CONSTRAINT type_pk PRIMARY KEY (ID_type)
) ;

-- Table: working_days
CREATE TABLE working_days (
    ID_working_days integer  NOT NULL,
    days varchar2(200)  NOT NULL,
    CONSTRAINT working_days_pk PRIMARY KEY (ID_working_days)
) ;

-- Table: working_hours
CREATE TABLE working_hours (
    ID_working_hours integer  NOT NULL,
    startTime timestamp  NOT NULL,
    endTime timestamp  NOT NULL,
    ID_employees integer  NOT NULL,
    ID_working_days integer  NOT NULL,
    CONSTRAINT working_hours_pk PRIMARY KEY (ID_working_hours)
) ;


-- foreign keys
-- Reference: clients_cleaning_services (table: service_assigned_to_clients)
ALTER TABLE service_assigned_to_clients ADD CONSTRAINT clients_cleaning_services
    FOREIGN KEY (ID_cleaning_services)
    REFERENCES cleaning_services (ID_services);

-- Reference: employees_cleaning_services (table: employees_in_service)
ALTER TABLE employees_in_service ADD CONSTRAINT employees_cleaning_services
    FOREIGN KEY (ID_cleaning_services)
    REFERENCES cleaning_services (ID_services);

-- Reference: employees_employees (table: employees)
ALTER TABLE employees ADD CONSTRAINT employees_employees
    FOREIGN KEY (ID_supervisor)
    REFERENCES employees (ID_employees);

-- Reference: employees_in_service_employees (table: employees_in_service)
ALTER TABLE employees_in_service ADD CONSTRAINT employees_in_service_employees
    FOREIGN KEY (ID_employees)
    REFERENCES employees (ID_employees);

-- Reference: feedbacks_clients (table: feedbacks)
ALTER TABLE feedbacks ADD CONSTRAINT feedbacks_clients
    FOREIGN KEY (ID_clients)
    REFERENCES clients (ID_clients);

-- Reference: feedbacks_type (table: feedbacks)
ALTER TABLE feedbacks ADD CONSTRAINT feedbacks_type
    FOREIGN KEY (ID_type)
    REFERENCES type (ID_type);

-- Reference: service_to_clients (table: service_assigned_to_clients)
ALTER TABLE service_assigned_to_clients ADD CONSTRAINT service_to_clients
    FOREIGN KEY (ID_clients)
    REFERENCES clients (ID_clients);

-- Reference: working_hours_days (table: working_hours)
ALTER TABLE working_hours ADD CONSTRAINT working_hours_days
    FOREIGN KEY (ID_working_days)
    REFERENCES working_days (ID_working_days);

-- Reference: working_hours_employees (table: working_hours)
ALTER TABLE working_hours ADD CONSTRAINT working_hours_employees
    FOREIGN KEY (ID_employees)
    REFERENCES employees (ID_employees);

-- End of file.
--employees
select * from employee;
create sequence employees_seq
start with 1
increment by 1;

insert into employee(ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Zhaisana','Ismanova', '123',200); 
insert into employee (ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Aibek','Sabitbekov', '4567',250); 
insert into employee (ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Daniel','Bekmuratov', '789',240); 
insert into employee (ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Yurii','Zhirkov', '101',220); 
insert into employee (ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Mateusz','Nowak', '1102',270); 
insert into employee (ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Azamat','Medetov', '131',150); 
insert into employee (ID_employee,name,surname,number_card,salary)
values (employees_seq.nextval, 'Nurdoolot','Nurseiitov', '415',170);
--clients
select * from clients;

create sequence clients_seq
start with 1
increment by 1;

insert into clients (ID_clients,client_name,client_surname,phone_number)
 values(clients_seq.nextval,'Christos','Voskres','455891');
insert into clients (ID_clients,client_name,client_surname,phone_number)
values(clients_seq.nextval,'Roman','Svetly','3790675');
insert into clients (ID_clients,client_name,client_surname,phone_number)
values (clients_seq.nextval,'Isabek','Mamaev','74355023');
insert into clients (ID_clients,client_name,client_surname,phone_number)
values(clients_seq.nextval,'Ali','Mcgregor','82074321');
--cleaning services

select * from cleaning_services;
create sequence clean_serv_seq
start with 1
increment by 1;

 insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'washing car', 50);
insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'cleaning dishes','35');
insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'cleaning house' ,'100');
 insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'laundry' ,'150');
insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'all inclusive', '485');
 --emp in services
 select * from employee_in_service;
 create sequence emp_serv_seq
start with 1
increment by 1;
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,3,21);
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,3,22);
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,2,21);
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,5,21);
--type 
select * from type;
insert into type(ID_type,type_name)
 values(1,'gratitude');
 insert into type(ID_type,type_name)
 values(2,'complaints');
 insert into type(ID_type,type_name)
 values(3,'suggestions');
 --feedbacks 

 select * from feedbacks;
 create sequence feedback_seq
start with 1
increment by 1;
select * from clients

INSERT INTO  into feedbacks(ID_feedbacks,date_of_sent, "comment", ID_type,ID_clients)
values(feedback_seq.nextval,To_Date('2020-03-15', 'yyyy-mm-dd'), 'Thanks a lot',1,21);
insert into feedbacks(ID_feedbacks,date_of_sent, "comment", ID_type,ID_clients)
values(feedback_seq.nextval,To_date('2021-09-07','yyyy-mm-dd'), 'Didnt like at all',2,23);
insert into feedbacks(ID_feedbacks,date_of_sent, "comment", ID_type,ID_clients)
values(feedback_seq.nextval,To_date('2020-12-25','yyyy-mm-dd'), 'Needs improvements in washing a car',3,24);
--working days
select * from working_days;
insert into working_days(ID_working_days, days)
values(1,'Monday');
insert into working_days(ID_working_days, days)
values(2,'Wednesday');
insert into working_days(ID_working_days, days)
values(3,'Friday');
insert into working_days(ID_working_days, days)
values(4,'Saturday');
--working hours 
select * from working_hours;
create sequence work_hour_seq
start with 1
increment by 1;
select * from working_hours;
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='YYYY-MM-DD HH24:MI:SS';
insert into working_hours(ID_working_hours,startTime,endTime,ID_employees,ID_working_days)
values(work_hour_seq.nextval,'2022-01-01 00:01:01','2022-01-01 03:02:01',1,1);
insert into working_hours(ID_working_hours,startTime,endTime,ID_employees,ID_working_days)
values(work_hour_seq.nextval,'2022-01-03 12:00:00','2022-01-03 15:02:01',4,3);
insert into working_hours(ID_working_hours,startTime,endTime,ID_employees,ID_working_days)
values(work_hour_seq.nextval,'2022-01-05 16:01:01','2022-01-05 20:02:01',1,3);
insert into working_hours(ID_working_hours,startTime,endTime,ID_employees,ID_working_days)
values(work_hour_seq.nextval,'2022-01-06 10:01:01','2022-01-06 12:02:01',7,4);

--service_assign
select * from service_assigned_to_clients;
create sequence serv_client_seq
start with 1
increment by 1;

insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,1,1);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,3,2);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,4,3);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,1,4);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,2,1);

--

--triggers 
set serveroutput on;
--trigger before with row to prevent insert any data
create or replace trigger InsertPrevent 
before insert
on clients
for each row 
begin 
Raise_application_error(-20000, 'You are not allowed to insert records from this table');
end;
select * from clients;

--check
insert into clients(ID_clients) values(5);
--
create or replace trigger salary_check
before insert or update
on employee
for each row
declare 
    tmp_val employee.salary%type;
begin
    tmp_val := :new.salary;
    If INSERTING then
        if tmp_val <= 100 then
            raise_application_error(-20100, 'salary is too low');
        end if;
    elsif UPDATING then
        if tmp_val < 1000 then
            :new.salary := :old.salary;
            dbms_output.put_line('Salary is too low');
        end if;
    end if;
end;

update employee
set salary = 100
where ID_employee = 48;
select * from employee

--
create or replace trigger emp_insert
after insert on employee
for each row
begin
dbms_output.put_line('Record inserted ');
end;
/
select * from employee
insert into employee
values(48,'Sam','Simonov','144567',1,150);
--procedures

create or replace procedure ADD_client(
v_ID_clients in clients.ID_clients%type,
v_client_name in clients.client_name%type,
v_client_surname in clients.client_surname%type,
v_phone_number in clients.phone_number%type)
is
begin 
insert into clients("ID_CLIENTS","CLIENT_NAME","CLIENT_SURNAME","PHONE_NUMBER")
values(v_ID_clients,v_client_name,v_client_surname,v_phone_number);
commit;
end;
begin add_client(5,'Sasha','Repeinikov',123456);
end;
select * from clients;
drop trigger InsertPrevent 
--
CREATE OR REPLACE PROCEDURE delclient (v_client_name IN clients.client_name%TYPE)
IS
BEGIN

  DELETE clients where client_name = v_client_name;
  
  COMMIT;

END;

BEGIN
   delclient('Sasha');
END;

select * from clients;

CREATE PROCEDURE p_clients_all
-- procedure returns all rows from the clients table
AS BEGIN
  SELECT *
  FROM clients;
END;

exec p_clients_all;


select * from employee
