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
	timeIn char(10),
	timeOut char(10),
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