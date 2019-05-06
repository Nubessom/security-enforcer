@isTest
public with sharing class SecurityEnforcerTest {
    
    @isTest 
    public static void createTest_Success() {
        List<Account> dummyList = new List<Account>();
        dummyList.add(new Account(Name='test name'));
        SecurityEnforcer.validateCanCreate(dummyList);
        System.assert(true);
    }
    
    @isTest 
    public  static void deleteTest_Success() {
        List<Account> dummyList = new List<Account>();
        dummyList.add(new Account(Name='test name'));
        SecurityEnforcer.validateCanDelete(dummyList);
        System.assert(true);
    }
        
    @isTest 
    public  static void updateTest_Success() {
        List<Account> dummyList = new List<Account>();
        dummyList.add(new Account(Name='test name'));
        SecurityEnforcer.validateCanUpdate(dummyList);
        System.assert(true);
    }
    
    @isTest 
    public static void accessTest_Success() {
        List<Account> dummyList = new List<Account>();
        dummyList.add(new Account(Name='test name'));
        SecurityEnforcer.validateCanAccess(dummyList);
        System.assert(true);
    }
    
    @isTest 
    public static void validateCanAccessTest_Success() {
        Account dummyAccount =  new Account(Name='test name');
        SecurityEnforcer.validateCanAccess(dummyAccount);
        System.assert(true);    
    }
    
    @isTest 
    public static void validateCanUpdateTest_Success() {
        Account dummyAccount =  new Account(Name='test name');
        SecurityEnforcer.validateCanUpdate(dummyAccount);
        System.assert(true);    
    }
    
    @isTest 
    public static void validateCanDeleteTest_Success() {
        Account dummyAccount =  new Account(Name='test name');
        SecurityEnforcer.validateCanDelete(dummyAccount);
        System.assert(true);    
    }
    
    @isTest 
    public static void validateCanCreateTest_Success() {
        Account dummyAccount =  new Account(Name='test name');
        SecurityEnforcer.validateCanCreate(dummyAccount);
        System.assert(true);    
    }
    
    @isTest
    public static void validateNullSingleObjectAttribute() {
        Account dummyAccount;
        SecurityEnforcer.validateCanAccess(dummyAccount);
        System.assert(true);    
    }
    
    @isTest
    public static void validateNullListAttribute() {
        List<Account> dummyAccounts;
        SecurityEnforcer.validateCanAccess(dummyAccounts);
        System.assert(true);    
    }
    
    @isTest
    public static void validateCanCreateTest_ObjectAccess_Fail() {
        Boolean testPassed = false;
        AsyncApexJob dummyObj =  new AsyncApexJob();
        try {
            SecurityEnforcer.validateCanCreate(dummyObj);
        }
        catch (ObjectAccessException.NotCreateableException ex) {
            testPassed = true;
            System.assertEquals('AsyncApexJob', ex.getObjectName());
        }
        System.assert(testPassed);    
    }
    
    @isTest
    public static void validateCanUpdateTest_ObjectAccess_Fail() {
        Boolean testPassed = false;
        AsyncApexJob dummyObj =  new AsyncApexJob();
        try {
            SecurityEnforcer.validateCanUpdate(dummyObj);
        }
        catch (ObjectAccessException.NotUpdateableException ex) {
            testPassed = true;
            System.assertEquals('AsyncApexJob', ex.getObjectName());
        }
        System.assert(testPassed);    
    }
    
    @isTest
    public static void validateCanDeleteTest_ObjectAccess_Fail() {
        Boolean testPassed = false;
        AsyncApexJob dummyObj =  new AsyncApexJob();
        try {
            SecurityEnforcer.validateCanDelete(dummyObj);
        }
        catch (ObjectAccessException.NotDeletableException ex) {
            testPassed = true;
            System.assertEquals('AsyncApexJob', ex.getObjectName());
        }
        System.assert(testPassed);    
    }
}