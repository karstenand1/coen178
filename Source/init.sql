drop table ServiceItem;
drop table MachineUnderRepair;
drop table Contract;
drop table Customer;
drop table ItemGroup;
drop table Problem;
drop table Employee;
drop table ProblemList;

create table Customer (
	custId char(5) PRIMARY KEY,
	custname char(20),
	custphone int
);

create table Contract (
	contractId char(5) PRIMARY KEY,
	machineId char(5),
	startDate Date,
	endDate Date
);

create table ItemGroup (
	groupId char(5) PRIMARY KEY,
	numMachines int
);

create table ServiceItem (
	machineId char(5) PRIMARY KEY,
	contractId char(5),
	custId char(5),
	groupId char(5),
	FOREIGN KEY (contractId) REFERENCES Contract(contractId),
	FOREIGN KEY (custId) REFERENCES Customer(custId),
	FOREIGN KEY (GroupId) REFERENCES ItemGroup (groupId)
);

create table Employee (
	employeeId char(5) PRIMARY KEY,
	empname char(20),
	phone int
);

create table ProblemList(
	problemId char(10) PRIMARY KEY,
	description char(50),
	cost number(10,2)
);

create table Problem(
	problemId char(10),
	machineId char(5),
	FOREIGN KEY (problemId) REFERENCES ProblemList(problemId)
);

create table MachineUnderRepair (
	repairId char(5) PRIMARY KEY,
	custId char(5),
	machineId char(5),
	timeIn date,
	timeOut date,
	status char(5),
	coverage char(1),
	employeeId char(5),
	problemId char(10),
	hours int,
	model char(20),
	FOREIGN KEY (custId) REFERENCES Customer(custId),
	FOREIGN KEY (employeeId) REFERENCES Employee(employeeId),
	FOREIGN KEY (problemId) REFERENCES ProblemList(problemId)
);


insert into Customer values('c1', 'Francis', 1234567890);
insert into Customer values('c2', 'Jeremiah', 8884560780);

insert into Contract values('ct1', 'm1', date '2016-01-15', date '2016-07-15');

insert into ItemGroup values('g1', 1);

insert into ServiceItem values('m1', 'ct1', 'c2', 'g1');

insert into ProblemList values('p1', 'Broken Monitor', 50.00);
insert into ProblemList values('p2', 'Crashed HardDrive', 35.00);

insert into Problem values('p2', 'm2');

insert into Employee values('e1', 'Arnold', 3035255222);
--4_1 execute createContract('ct2', 'm2', date '2016-02-12', date '2016-08-12');
--4_2  if procedure: execute createRepairJob('ct2', 'r2', 'c2', 'm2', date '2016-04-15', '1', 'e1', 'p2', 'Dell Precision');
--4_2 select createRepairJob('ct2', 'r2', 'c2', 'm2', date '2016-04-15', '1', 'e1', 'p2', 'Dell Precision') from dual;
--4_2 if procedure: execute createRepairJob('ct1', 'r1', 'c1', 'm1', date '2016-03-15', '1', 'e1', 'p2', 'Macbook Pro');
--4_3 execute updateStatus('r2', '3', 15);
--4_4 execute showStatus('m2');
--4_5 select generateBill('r2') from dual;
--4_6 select showJobs() from dual;
--4_7 select generateRevenue(date '2015-1-1', date '2017-12-30') from dual;
