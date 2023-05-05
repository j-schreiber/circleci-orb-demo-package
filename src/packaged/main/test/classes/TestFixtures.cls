@isTest
public class TestFixtures {
    /**
     * Creates and inserts a default regular user with named permissions
     *
     * @param alias         Unique alias; used to identify the user
     * @param permSets      List of permission sets to assign
     * @return `User`      Created regular user
     */
    public static User CreateStandardUser(String alias, List<String> permSets) {
        Profile standardProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User testUser = new User(
            Email = 'benchmarker-test-user@example.com',
            Username = String.valueOf(System.now().getTime()) + 'benchmarker-test-user@example.com',
            Alias = alias,
            LastName = 'Tester',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LocaleSidKey = 'en_US',
            ProfileId = standardProfile.Id,
            TimeZoneSidKey = String.valueOf(UserInfo.getTimeZone())
        );
        System.runAs(new User(Id = UserInfo.getUserId())) {
            insert testUser;
            AssignPermissionSetsToUser(testUser.Id, permSets);
        }
        return testUser;
    }

    /**
     * @description
     * This method assigns a list of permission sets by name to a given user id. It is idempotent and only assigns those
     * permission sets, that are not yet assigned to the user
     *
     * @param   userId              The id of the user that will get the permission set assigned
     * @param   permissionSetNames  The names of the permission sets to assign
     */
    public static void AssignPermissionSetsToUser(String userId, List<String> permissionSetNames) {
        List<PermissionSet> nonAssignedPermSets = [
            SELECT Id
            FROM PermissionSet
            WHERE
                Id NOT IN (
                    SELECT PermissionSetId
                    FROM PermissionSetAssignment
                    WHERE AssigneeId = :userId AND PermissionSet.Name IN :permissionSetNames
                )
                AND Name IN :permissionSetNames
        ];
        List<PermissionSetAssignment> newAssignments = new List<PermissionSetAssignment>();
        for (PermissionSet permSet : nonAssignedPermSets) {
            newAssignments.add(new PermissionSetAssignment(AssigneeId = userId, PermissionSetId = permSet.Id));
        }
        Database.insert(newAssignments);
    }

    public static List<Account> InsertDefaultAccounts() {
        List<Account> accs = new List<Account>();
        accs.add(CreateAccount('Test GmbH 1', '1000'));
        accs.add(CreateAccount('Lieferanten Test GmbH 1', '1001'));
        accs.add(CreateAccount('Kunden Test AG 1', '1002'));
        insert accs;
        return accs;
    }

    public static List<Account> InsertFullServiceContractStructure(Id pricebookId) {
        return InsertFullServiceContractStructure(pricebookId, 3);
    }

    public static List<Account> InsertFullServiceContractStructure(Id pricebookId, Integer contractCount) {
        List<Account> customers = InsertDefaultAccounts();
        List<ServiceContract> contracts = new List<ServiceContract>();
        for (Integer i = 0; i < contractCount; i++) {
            contracts.add(CreateServiceContract('Test Contract ' + i, customers[0].Id, pricebookId));
        }
        insert contracts;
        if (pricebookId != null) {
            List<ContractLineItem> items = new List<ContractLineItem>();
            for (ServiceContract sc : contracts) {
                items.addAll(createContractLineItems(sc.Id, [SELECT Id, UnitPrice FROM PricebookEntry WHERE Pricebook2Id = :pricebookId]));
            }
            insert items;
        }
        return customers;
    }

    public static Pricebook2 InsertProductsWithCustomPrices(String pricebookName) {
        List<Product2> prods = InsertProductsWithStandardPrices();
        Pricebook2 standardPricebook = new Pricebook2(Id = Test.getStandardPricebookId());
        update standardPricebook;
        return AddProductsToCustomPricebook(pricebookName, 120, prods);
        // return pb;
    }

    public static Pricebook2 AddProductsToCustomPricebook(String pricebookName, Decimal unitPrice, List<Product2> products) {
        Pricebook2 customPricebook = CreatePricebook(pricebookName);
        insert customPricebook;
        List<PricebookEntry> prices = new List<PricebookEntry>();
        for (Product2 prod : products) {
            prices.add(new PricebookEntry(Pricebook2Id = customPricebook.Id, Product2Id = prod.Id, UnitPrice = unitPrice, IsActive = true));
        }
        insert prices;
        return customPricebook;
    }

    public static List<Product2> InsertProductsWithStandardPrices() {
        List<Product2> prods = InsertDefaultProducts(5);
        InsertStandardPrices(prods);
        return prods;
    }

    public static Pricebook2 InsertProductsWithStandardPrices(Integer productCount) {
        List<Product2> prods = InsertDefaultProducts(productCount);
        InsertStandardPrices(prods);
        Pricebook2 standardPricebook = new Pricebook2(Id = Test.getStandardPricebookId());
        update standardPricebook;
        return standardPricebook;
    }

    public static List<Product2> InsertDefaultProducts(Integer productCount) {
        List<Product2> prods = CreateDefaultProducts(productCount);
        insert prods;
        return prods;
    }

    public static List<Product2> CreateDefaultProducts(Integer productCount) {
        List<Product2> prods = new List<Product2>();
        for (Integer i = 1; i <= productCount; i++) {
            String prodName = 'Test Base Product {0}';
            String prodCode = 'A-{0}';
            prods.add(
                CreateProduct(
                    String.format(prodName, new List<Object>{ i }),
                    String.format(prodCode, new List<Object>{ i }),
                    'Base Product',
                    'Each'
                )
            );
        }
        return prods;
    }

    public static Account CreateAccount(String accountName, String accountNumber) {
        return new Account(
            Name = accountName,
            AccountNumber = accountNumber,
            BillingStreet = 'Karlstraße 1',
            BillingPostalCode = '86152',
            BillingCity = 'Augsburg'
        );
    }

    public static ServiceContract CreateServiceContract(String contractName, Id accountId, Id pricebookId) {
        return new ServiceContract(
            Name = contractName,
            StartDate = System.today(),
            Pricebook2Id = pricebookId,
            AccountId = accountId,
            BillingStreet = 'Straße 1',
            BillingPostalCode = '12345',
            BillingCity = 'Berlin',
            ShippingStreet = 'Straße 1',
            ShippingPostalCode = '12345',
            ShippingCity = 'Berlin'
        );
    }

    public static Pricebook2 CreatePricebook(String pricebookName) {
        return new Pricebook2(Name = pricebookName, IsActive = true);
    }

    public static Product2 CreateProduct(String productName, String productCode, String productType, String unit) {
        return new Product2(
            Name = productName,
            ExternalId = productCode,
            ProductCode = productCode,
            Family = productType,
            QuantityUnitOfMeasure = unit,
            IsActive = true
        );
    }

    private static List<ContractLineItem> createContractLineItems(Id contractId, List<PricebookEntry> pricebookEntries) {
        List<ContractLineItem> clis = new List<ContractLineItem>();
        for (PricebookEntry pbe : pricebookEntries) {
            clis.add(
                new ContractLineItem(ServiceContractId = contractId, PricebookEntryId = pbe.Id, Quantity = 5, UnitPrice = pbe.UnitPrice)
            );
        }
        return clis;
    }

    private static List<PricebookEntry> InsertStandardPrices(List<Product2> products) {
        List<PricebookEntry> prices = new List<PricebookEntry>();
        for (Product2 prod : products) {
            prices.add(
                new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prod.Id, UnitPrice = 100, IsActive = true)
            );
        }
        insert prices;
        return prices;
    }
}
