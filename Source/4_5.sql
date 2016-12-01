create or replace function generateBill
  (repair_param in MachineUnderRepair.repairId%type)
return string is
  retval varchar(300);
begin
  declare
    custname_var Customer.custname%type;
    custphone_var Customer.custphone%type;
    custId_var Customer.custId%type;
    machineId_var MachineUnderRepair.machineId%type;
    timein_var MachineUnderRepair.timein%type;
    timeout_var MachineUnderRepair.timeout%type;
    coverage_var MachineUnderRepair.coverage%type;
    model_var MachineUnderRepair.model%type;
    hours_var MachineUnderRepair.hours%type;
    cost_var ProblemList.cost%type;
    description_var ProblemList.description%type;
    billtotal int :=0;
    endDate_var Contract.endDate%type;

    cursor pcursor is
      select problemId
      from Problem
      where machineId = machineId_var;
    prow pcursor%rowtype;
	
  begin
    
    select custId, machineId, timein, timeout, coverage, model, hours
    into custId_var, machineId_var, timein_var, timeout_var, coverage_var, model_var, hours_var
    from MachineUnderRepair
    where repairId = repair_param;

    --dbms_output.put_line('First test print');

    select custname, custphone
    into custname_var, custphone_var
    from Customer
    where custId = custId_var;
    
    retval := 'Customer info: ' || custId_var || ', ' || custname_var || ', ' || custphone_var || ', ' || model_var || ', Hours ' || hours_var || ' ';
    --dbms_output.put_line('Second test print');
    if not pcursor%isopen then
      open pcursor;
    end if;
    loop
      fetch pcursor into prow;
      exit when pcursor%notfound;

      select cost, description
      into cost_var, description_var
      from ProblemList
      where prow.problemId=problemId;
      billtotal := (billtotal + cost_var);
      retval := retval || 'Problem: ' ||prow.problemId || ', Description ' || description_var || ', Cost ' || cost_var || ' ';
      --dbms_output.put_line('Third test print' || billtotal);
    end loop;

    --dbms_output.put_line('Fourth test print' || coverage_var);
    if coverage_var = 'Y' then

      --dbms_output.put_line('Test print please ignore');
      select endDate
      into endDate_var
      from Contract
      where contractId = (select contractId from Contract where machineId = machineId_var);

      --dbms_output.put_line('Fifth test print');
      if timein_var < endDate_var then
	billtotal := 0;
      else
	billtotal := billtotal + 50 + (25 * hours_var);
      end if;
    else
      billtotal := billtotal + 50 + (25 * hours_var);
    end if;
    --dbms_output.put_line('Sixth test print');
    retval := retval || 'Total amount due is: ' || billtotal;
  end;
  return retval;
end;
/
show errors;