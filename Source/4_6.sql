create or replace function showJobs
return string is
	
	retval char(200);
	rep MachineUnderRepair.repairId%type;
	
begin
	select repairId into retval
	from MachineUnderRepair
	where status = '1' or status = '2';

	retval:= 'Jobs currently inprocess: ' || rep;
	return retval;
end;
/
show errors;
