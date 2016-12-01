create or replace function showJobs
return string is
	
	retval varchar(100);
	
begin
  declare
    rep MachineUnderRepair.repairId%type;
    cursor jcursor is
	select repairId
	from MachineUnderRepair
	where status = '1' or status = '2';
	jrow jcursor%rowtype;

  begin

	if not jcursor%isopen then
	  open jcursor;
	end if;
	retval:= 'Jobs currently inprocess: ';
	loop
	  fetch jcursor into rep;
	  exit when jcursor%notfound;

	  retval:= retval || rep ||', ';
	end loop;
	
  end;
  return retval;
end;
/
show errors;

--select repairId
--from machineunderrepair
--where status = '1' or status = '2';