create or replace function generateRevenue
  (starttime_param date, endtime_param date)
return string is
      retval varchar(150);
begin
  declare 
    cost_var ProblemList.cost%type;
    endDate_var Contract.endDate%type;
    hours_var MachineUnderRepair.hours%type;
    amountcovered int :=0;
    amountnotcovered int :=0;
    flag int;
    machinecost int;
    
    cursor mcursor is
      select machineId, coverage, status, hours
      from MachineUnderRepair
      where timeOut <= endtime_param and timeIn >= starttime_param;
      mrow mcursor%rowtype;

    cursor pcursor is
      select problemId
      from problem
      where machineId = mrow.machineId;
      prow pcursor%rowtype;

    begin
      --dbms_output.put_line('First test print');
      if not mcursor%isopen then
	open mcursor;
      end if;

      loop
	fetch mcursor into mrow;
	exit when mcursor%notfound;
	
	--dbms_output.put_line('MROW: '|| mrow.machineId || ' ' || mrow.coverage || ' ' || mrow.status || ' ' || mrow.hours);
	  
	open pcursor;
	loop
	  fetch pcursor into prow;
	  exit when pcursor%notfound;
	  
	  --dbms_output.put_line('PROW: '|| prow.problemId);
	  --dbms_output.put_line('Test Print Please Ignore'|| mrow.status);
	  if mrow.status = 4 then
	    
	    select cost 
	    into cost_var
	    from ProblemList
	    where prow.problemId = problemId;

	    --dbms_output.put_line('Repost' || mrow.coverage);
	    if mrow.coverage = 'Y' then
	      --dbms_output.put_line('Second test print');
	      select endDate
	      into endDate_var
	      from Contract
	      where contractId = (select contractId from Contract where machineId = mrow.machineId);
	      --dbms_output.put_line('Start time'|| starttime_param);
	      --dbms_output.put_line('End Date' || endDate_var);
	      if starttime_param <= endDate_var then
		amountcovered := amountcovered + cost_var;
		flag :=1;
	      else
		amountnotcovered := amountnotcovered + cost_var;
		flag :=0;
	      end if;
	    else
	      amountnotcovered := amountnotcovered + cost_var;
	      flag :=0;
	    end if;
	  end if;
	end loop;
	close pcursor;
	--dbms_output.put_line('Third test print');
	machinecost := (25 * mrow.hours) + 50;
	if flag = 1 and mrow.status = 4
	then
	  --dbms_output.put_line('Fourth test print');
	  amountcovered := amountcovered + machinecost;
	else
	  amountnotcovered := amountnotcovered + machinecost;
	end if;
      end loop;
      retval := 'Amount covered: ' || amountcovered || ', Amount not covered: ' || amountnotcovered;
    end;
    return retval;
end;
/
show errors;