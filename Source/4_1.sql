create or replace procedure createContract
	(contractId in Contract.contractId%type, machineId in Contract.machineId%type, startDate in Contract.startDate%type, endDate in Contract.endDate%type)
as
begin
	insert into Contract values(contractId, machineId, startDate, endDate);
end;
/
show errors;
