create or replace procedure createRepairJob
	(contractId in Contract.contractId%type, repairId in MachineUnderRepair.repairId%type, custId in MachineUnderRepair.custId%type, machineId_param in MachineUnderRepair.machineId%type, timeIn in MachineUnderRepair.timeIn%type, status in MachineUnderRepair.status%type, employeeId in MachineUnderRepair.employeeId%type, problemId in MachineUnderRepair.problemId%type, model in MachineUnderRepair.model%type)
as
begin
    declare
	coverage MachineUnderRepair.coverage%type;
	date_param Contract.endDate%type;
	begin
	if contractId != '0' then
	  select endDate into date_param from Contract where machineId = machineId_param;
	  if timein <= date_param then
	    coverage := 'Y';
	  else
	    coverage := 'N';
	    dbms_output.put_line('This warranty is not valid. This repair job will not be covered');
	  end if;

	else
	  coverage := 'N';

	end if;

	insert into MachineUnderRepair values(repairId, custId, machineId_param, timeIn, timein, status, coverage, employeeId, problemId, 0, model);
	end;
end;
/
show errors;
