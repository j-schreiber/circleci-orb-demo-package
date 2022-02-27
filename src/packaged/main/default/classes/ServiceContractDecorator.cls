public class ServiceContractDecorator {
    private ServiceContract record;
    private List<ContractSchedule__c> schedules;

    public ServiceContractDecorator(ServiceContract record) {
        this(record, new List<ContractSchedule__c>());
    }

    public ServiceContractDecorator(ServiceContract record, List<ContractSchedule__c> schedules) {
        this.record = record;
        this.schedules = schedules == null ? new List<ContractSchedule__c>() : schedules;
    }

    public ContractScheduleResult makeSchedules() {
        ContractScheduleResult result = new ContractScheduleResult();
        result.obsoleteSchedules.addAll(this.schedules);
        for (Integer i = 0; i < this.record.Schedules__c; i++) {
            result.newSchedules.add(new ContractSchedule__c(ServiceContract__c = this.record.Id));
        }
        return result;
    }

    public class ContractScheduleResult {
        public List<ContractSchedule__c> obsoleteSchedules = new List<ContractSchedule__c>();
        public List<ContractSchedule__c> newSchedules = new List<ContractSchedule__c>();
    }
}
