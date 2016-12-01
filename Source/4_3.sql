create or replace procedure updateStatus
	(repair_param in MachineUnderRepair.repairId%type, status_param in MachineUnderRepair.status%type, hours_param in MachineUnderRepair.hours%type)
as
begin
	update MachineUnderRepair
	set status = status_param
	where repairId = repair_param;

	update MachineUnderRepair
	set hours = hours_param
	where repairId = repair_param;
end;
/
show errors;
