create or replace procedure showStatus
	(machine_param in MachineUnderRepair.machineId%type)
as
	stat_var char(1);
begin
	select status into stat_var
	from MachineUnderRepair
	where machineId = machine_param;

	dbms_output.putline('Status: ' || stat_var);
end;
/
show errors;
