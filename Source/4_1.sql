create or replace procedure createContract
	(contractId in Contract.contractId%type, startDate in Contract.startDate%type, endDate in Contract.endDate%type)
as
begin
	insert into mealorder values(contractId, startDate, endDate);
end;
/
show errors;
