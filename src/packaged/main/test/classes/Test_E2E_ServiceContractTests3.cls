@isTest
public class Test_E2E_ServiceContractTests3 {
    @TestSetup
    static void makeData() {
        List<Account> accs = TestFixtures.InsertFullServiceContractStructure(null, 20);
    }

    @isTest
    static void insertContract_NullSchedules_ValueInitialised_1() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];
        delete [SELECT Id FROM ServiceContract];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = new List<ServiceContract>();
        for (Account a : accs) {
            scs.add(new ServiceContract(AccountId = a.Id, Name = 'Test Contract ' + accs.indexOf(a)));
        }
        insert scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(0, sc.Schedules__c);
            System.assertEquals(0, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void insertContract_HasScheduleOnInsert_ValueInitialised_2() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];
        delete [SELECT Id FROM ServiceContract];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = new List<ServiceContract>();
        for (Account a : accs) {
            scs.add(new ServiceContract(AccountId = a.Id, Name = 'Test Contract ' + accs.indexOf(a), Schedules__c = 2));
        }
        insert scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(2, sc.Schedules__c);
            System.assertEquals(2, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void insertContract_HasScheduleOnInsert_ValueInitialised_3() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];
        delete [SELECT Id FROM ServiceContract];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = new List<ServiceContract>();
        for (Account a : accs) {
            scs.add(new ServiceContract(AccountId = a.Id, Name = 'Test Contract ' + accs.indexOf(a), Schedules__c = 3));
        }
        insert scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(3, sc.Schedules__c);
            System.assertEquals(3, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void insertContract_HasScheduleOnInsert_ValueInitialised_4() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];
        delete [SELECT Id FROM ServiceContract];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = new List<ServiceContract>();
        for (Account a : accs) {
            scs.add(new ServiceContract(AccountId = a.Id, Name = 'Test Contract ' + accs.indexOf(a), Schedules__c = 4));
        }
        insert scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(4, sc.Schedules__c);
            System.assertEquals(4, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void updateContract_SetSchedule_ValueInitialised_5() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];
        delete [SELECT Id FROM ServiceContract];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = new List<ServiceContract>();
        for (Account a : accs) {
            scs.add(new ServiceContract(AccountId = a.Id, Name = 'Test Contract ' + accs.indexOf(a), Schedules__c = 5));
        }
        insert scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(5, sc.Schedules__c);
            System.assertEquals(5, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void updateContract_SetSchedule_ValueInitialised_6() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = [SELECT Id FROM ServiceContract];
        for (ServiceContract sc : scs) {
            sc.Schedules__c = 6;
        }
        update scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(6, sc.Schedules__c);
            System.assertEquals(6, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void updateContract_SetSchedule_ValueInitialised_7() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = [SELECT Id FROM ServiceContract];
        for (ServiceContract sc : scs) {
            sc.Schedules__c = 7;
        }
        update scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(7, sc.Schedules__c);
            System.assertEquals(7, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void updateContract_SetSchedule_ValueInitialised_8() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = [SELECT Id FROM ServiceContract];
        for (ServiceContract sc : scs) {
            sc.Schedules__c = 8;
        }
        update scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(8, sc.Schedules__c);
            System.assertEquals(8, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void updateContract_SetSchedule_ValueInitialised_9() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = [SELECT Id FROM ServiceContract];
        for (ServiceContract sc : scs) {
            sc.Schedules__c = 9;
        }
        update scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(9, sc.Schedules__c);
            System.assertEquals(9, sc.ContractSchedules__r.size());
        }
    }

    @isTest
    static void updateContract_SetSchedule_ValueInitialised_10() {
        // ARRANGE
        List<Account> accs = [SELECT Id FROM Account];

        // ACT
        Test.startTest();
        List<ServiceContract> scs = [SELECT Id FROM ServiceContract];
        for (ServiceContract sc : scs) {
            sc.Schedules__c = 10;
        }
        update scs;
        Test.stopTest();

        // ASSERT
        for (ServiceContract sc : [SELECT Id, Schedules__c, (SELECT Id FROM ContractSchedules__r) FROM ServiceContract]) {
            System.assertEquals(10, sc.Schedules__c);
            System.assertEquals(10, sc.ContractSchedules__r.size());
        }
    }
}
