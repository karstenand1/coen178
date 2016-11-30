create or replace procedure updateStatus
	(status_param in MachineUnderRepair.status%type)
as
begin
	update MachineUnderRepair
	set status = status_param;
end;
/
