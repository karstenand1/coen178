drop table ServiceItem;
drop table MachineUnderRepair;
drop table Contract;
drop table Customer;
drop table ItemGroup;
drop table Problem;
drop table Employee;
drop table ProblemList;

create table Customer (
	custId varchar(5) PRIMARY KEY,
	custname varchar(20),
	custphone int
);

create table Contract (
	contractId varchar(5) PRIMARY KEY,
	machineId varchar(5),
	startDate Date,
	endDate Date
);

create table ItemGroup (
	groupId varchar(5) PRIMARY KEY,
	numMachines int
);

create table ServiceItem (
	machineId varchar(5) PRIMARY KEY,
	contractId varchar(5),
	custId varchar(5),
	groupId varchar(5),
	FOREIGN KEY (contractId) REFERENCES Contract(contractId),
	FOREIGN KEY (custId) REFERENCES Customer(custId),
	FOREIGN KEY (GroupId) REFERENCES ItemGroup (groupId)
);

create table Employee (
	employeeId varchar(5) PRIMARY KEY,
	empname varchar(20),
	phone int
);

create table ProblemList(
	problemId varchar(10) PRIMARY KEY,
	description varchar(50),
	cost number(10,2)
);

create table Problem(
	problemId varchar(10),
	machineId varchar(5),
	FOREIGN KEY (problemId) REFERENCES ProblemList(problemId)
);

create table MachineUnderRepair (
	repairId varchar(5) PRIMARY KEY,
	custId varchar(5),
	machineId varchar(5),
	timeIn date,
	timeOut date,
	status varchar(5),
	coverage varchar(1),
	employeeId varchar(5),
	problemId varchar(10),
	hours int,
	model varchar(20),
	FOREIGN KEY (custId) REFERENCES Customer(custId),
	FOREIGN KEY (employeeId) REFERENCES Employee(employeeId),
	FOREIGN KEY (problemId) REFERENCES ProblemList(problemId)
);


insert into Customer values('c1', 'Francis', 1234567890);
insert into Customer values('c2', 'Jeremiah', 8884560780);
insert into Customer values('c3', 'John', 8004560780);
insert into Customer values('c4', 'Smith', 8882510780);
insert into Customer values('c5', 'Johann', 8881234567);

insert into Contract values('ct1', 'm1', date '2016-01-15', date '2016-07-15');
insert into Contract values('ct4', 'm4', date '2016-02-03', date '2016-08-03');

insert into ItemGroup values('g1', 1);

insert into ServiceItem values('m1', 'ct1', 'c2', 'g1');

insert into ProblemList values('p1', 'Broken Monitor', 100.00);
insert into ProblemList values('p2', 'Crashed HardDrive', 60.00);
insert into ProblemList values('p3', 'Spontaneous Combustion', 150.00);
insert into ProblemList values('p4', 'Keyboard Malfunction', 45.00);

insert into Problem values('p2', 'm2');
insert into Problem values('p2', 'm3');
insert into Problem values('p3', 'm3');
insert into Problem values('p1', 'm1');

insert into Employee values('e1', 'Arnold', 3035255222);
insert into Employee values('e2', 'Earn', 3035251452);
insert into Employee values('e3', 'Billy', 3035258087);

insert into MachineUnderRepair values('r3', 'c3', 'm3', date '2016-06-12', date '2016-08-12', '1', 'N', 'e2', 'p3', 12, 'Asus Q12341');
--4_1 execute createContract('ct2', 'm2', date '2016-02-12', date '2016-08-12');
--4_2  if procedure: execute createRepairJob('ct2', 'r2', 'c2', 'm2', date '2016-04-15', '1', 'e1', 'p2', 'Dell Precision');
--4_2 select createRepairJob('ct2', 'r2', 'c2', 'm2', date '2016-04-15', '1', 'e1', 'p2', 'Dell Precision') from dual;
--4_2 if procedure: execute createRepairJob('ct1', 'r1', 'c1', 'm1', date '2016-03-15', '1', 'e1', 'p2', 'Macbook Pro');
--4_3 execute updateStatus('r2', '3', 15);
--4_4 select showStatus('m2') from dual;
--4_5 select generateBill('r3') from dual;
--4_6 select showJobs() from dual;
--4_7 select generateRevenue(date '2015-1-1', date '2017-12-30') from dual;
