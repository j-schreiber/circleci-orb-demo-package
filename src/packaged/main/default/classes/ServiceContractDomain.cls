public class ServiceContractDomain {
    public static void alignSchedules(List<ServiceContract> triggerNew) {
        List<ContractSchedule__c> obsoleteSchedules = new List<ContractSchedule__c>();
        List<ContractSchedule__c> newSchedules = new List<ContractSchedule__c>();
        List<ServiceContractDecorator> contracts = ServiceContractFactory.make(triggerNew);
        for (ServiceContractDecorator dec : contracts) {
            ServiceContractDecorator.ContractScheduleResult result = dec.makeSchedules();
            obsoleteSchedules.addAll(result.obsoleteSchedules);
            newSchedules.addAll(result.newSchedules);
        }
        delete obsoleteSchedules;
        insert newSchedules;
    }

    public static void cleanFields(List<ServiceContract> triggerNew) {
        for (ServiceContract sc : triggerNew) {
            ServiceContractDecorator dec = new ServiceContractDecorator(sc);
            if (sc.Schedules__c == null) {
                sc.Schedules__c = 0;
            }
        }
    }
}
