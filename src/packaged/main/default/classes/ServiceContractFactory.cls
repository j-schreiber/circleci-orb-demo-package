public class ServiceContractFactory {
    public static List<ServiceContractDecorator> make(List<ServiceContract> triggerNew) {
        Set<Id> contractIds = new Set<Id>();
        for (ServiceContract sc : triggerNew) {
            contractIds.add(sc.Id);
        }
        contractIds.remove(null);
        Map<Id, List<ContractSchedule__c>> schedules = getSchedules(contractIds);
        List<ServiceContractDecorator> decs = new List<ServiceContractDecorator>();
        for (ServiceContract sc : triggerNew) {
            decs.add(new ServiceContractDecorator(sc, schedules.get(sc.Id)));
        }
        return decs;
    }

    private static Map<Id, List<ContractSchedule__c>> getSchedules(Set<Id> contractIds) {
        Map<Id, List<ContractSchedule__c>> schedules = new Map<Id, List<ContractSchedule__c>>();
        for (ContractSchedule__c sc : [
            SELECT Id, ServiceContract__c
            FROM ContractSchedule__c
            WHERE ServiceContract__c IN :contractIds
            FOR UPDATE
        ]) {
            if (!schedules.containsKey(sc.ServiceContract__c)) {
                schedules.put(sc.ServiceContract__c, new List<ContractSchedule__c>());
            }
            schedules.get(sc.ServiceContract__c).add(sc);
        }
        return schedules;
    }
}
