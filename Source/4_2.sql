create or replace procedure createRepairJob
	(contractId in Contract.contractId%type, repairId in MachineUnderRepair.repairId%type, custId in MachineUnderRepair.custId%type, machineId_param in MachineUnderRepair.machineId%type, timeIn in MachineUnderRepair.timeIn%type, timeOut in MachineUnderRepair.timeOut%type, status in MachineUnderRepair.status%type, employeeId in MachineUnderRepair.employeeId%type, problemId in MachineUnderRepair.problemId%type, hours in MachineUnderRepair.hours%type, model in MachineUnderRepair.model%type)
as
begin
	coverage MachineUnderRepair.coverage%type;

	if contractId != '0' then
	  --temporary
	  -- select dates from Contract where machineId = machineId_param if timein <= endDate ok else print not covered
	  coverage := 'Y';
	else
	  coverage := 'N';

	end if;

	insert into MachineUnderRepair values(repairId, custId, machineId_param, timeIn, timeOut, status, coverage, employeeId, billId, problemId, hours, model);
end;
/
show errors;
