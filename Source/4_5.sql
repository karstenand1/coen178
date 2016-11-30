create or replace function generateBill
  (repair_param in MachineUnderRepair.repairId%type)
return string is
  retval char(150);
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
    billtotal int;
    endDate_var Contract.endDate%type;

    cursor pcursor is
      select problemId
      from Problem
      where machineId = machineId_var
    cursorrow pcursor%rowtype;
	
  begin
    select custId, machineId, timein, timeout, coverage, model, hours
    into custId_var, machineId_var, timein_var, timeout_var, coverage_var, model_var, hours_var
    from MachineUnderRepair
    where repairId = repair_param;

    select custname, custphone
    into custname_var, custphone_var
    from Customer
    where custId = custId_var;
    
    if not pcursor%isopen then
      open pcursor;
    endif;
    loop
      fetch pcursor into cursorrow;
      exit when pcursor%notfound;

      select cost, description
      into cost_var, description_var
      from ProblemList
      where problemrow.problemId=problemId;
      billtotal := (billtotal + cost_var);

    if coverage_var = 1 then
      select endDate
      into endDate_var
      from Contract
      where contractId = (select contractId from ServiceItem where machineId = machineId_var);

      if timein_var < endDate_var then
	billtotal := 0;
      else
	billtotal := billtotal + 50 + (25 * hors_var);
      end if
    else
      billtotal_var := billtotal + 50 + (25 * hors_var);
    end if;
    retval := 'Total amount due is: ' || billtotal;
  end;
  dbms_output.put_line(retval);
  return retval;
end;
/
show errors;