create or replace function showStatus
	(machine_param in MachineUnderRepair.machineId%type)
return string is
    retval varchar(100);
begin
    declare
	stat_var char(5);

	begin
	select status into stat_var
	from MachineUnderRepair
	where machineId = machine_param;

	retval:='Status: ' || stat_var;
	return retval;
	end;
end;
/
show errors;
