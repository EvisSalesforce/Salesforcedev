@isTest
public class LeadZapierAccountTriggerTest {
    
    @isTest
    static void testLeadZapierTrigger(){
        Lead ld = new Lead();
        List<User> leadResponsible = [Select Id From User Where Name = 'Admin Team'];
        if(!leadResponsible.isEmpty()){
            ld.Responsible__c = leadResponsible.get(0).Id;
        }
        ld.LeadSource = 'FREE ASSESSMENT';
        ld.Territory__c = 'Vancouver';
        ld.Client_is_in_Canada__c = 'No';
        ld.Prefered_Language__c = 'English';
        ld.FirstName = 'Avi';
        ld.LastName = 'Test';
        ld.Email = 'Avi_test@test123.com';
        ld.DOB__c = Date.newInstance(1990, 12, 23);
        ld.Marital_Status__c = 'Married';
        ld.Spouse_First_Name__c = 'Wanda';
        ld.Spouse_Last_Name__c = 'Green';
        ld.Spouse_DOB__c = Date.newInstance(1993, 12, 11);
        ld.Email_Spouse__c = 'Wanda_test@test123.com';
        ld.Company = ld.First_Name__c + ' ' + ld.LastName;
        
        
        Lead ld2 = new Lead();
        if(!leadResponsible.isEmpty()){
            ld.Responsible__c = leadResponsible.get(0).Id;
        }
        ld2.LeadSource = 'FREE ASSESSMENT';
        ld2.Territory__c = 'Vancouver';
        ld2.Client_is_in_Canada__c = 'No';
        ld2.Prefered_Language__c = 'English';
        ld2.FirstName = 'Kevin';
        ld2.LastName = 'Test';
        ld2.Email = 'kevin_test@test123.com';
        ld2.DOB__c = Date.newInstance(1990, 12, 23);
        ld2.Marital_Status__c = 'Married';
        ld2.Spouse_First_Name__c = 'elly';
        ld2.Spouse_Last_Name__c = 'test';
        ld2.Spouse_DOB__c = Date.newInstance(1993, 12, 11);
        ld2.Email_Spouse__c = 'elly@test123.com';
        ld2.Company = ld.First_Name__c + ' ' + ld.LastName;
        ld2.IsPaid_Acuity__c = true;
        
        Account spouse = new Account();
        spouse.First_Name__c ='elly';
        spouse.Last_Name__c = 'test';
        spouse.Name = spouse.First_Name__c + spouse.Last_Name__c;
        spouse.e_mail__c = 'elly@test123.com';
        spouse.Territory__c = 'Vancouver';
        spouse.DOB__c = Date.newInstance(1993, 06, 25);
        spouse.Marital_Status__c = 'Married';
        
        System.Test.startTest();
        // Use case 1 - if no account present for spouse
        insert ld;
        assessment__c asmt = new assessment__c();
        asmt.Lead__c = ld.Id;
        insert asmt;
        ld.IsPaid_Acuity__c = true;
        update ld;
        
        // Use case 2 - if spouse already exists for 2nd lead
        insert spouse;
        insert ld2;
        System.Test.stopTest();
    }

    @isTest
    static void testAccountZapierTrigger(){
        Account acc = new Account();
        acc.First_Name__c ='Av';
        acc.Last_Name__c = 'Test';
        acc.Name = acc.First_Name__c + acc.Last_Name__c;
        acc.e_mail__c = 'test@xyz.com';
        acc.Territory__c = 'Vancouver';
        acc.DOB__c = Date.newInstance(1993, 06, 25);
        acc.Marital_Status__c = 'Married';
        acc.IsPaid_Acuity__c = true;
        
        System.Test.startTest();
        insert acc;
        System.Test.stopTest();
    }
    @isTest
    static void isIdleAccountTest()
    {
        Account acc = new Account();
        acc.Name = 'Sammy';
        acc.e_mail__c = 'sammytest@test123.com';
        insert acc;
        Account spouse = new Account();
        spouse.Name = 'Sarena';
        spouse.e_mail__c = 'sarenatest@test123.com';
        insert spouse;
        Test.startTest();
        LeadZapierTriggerHandler.isIdleAccount(spouse);
        Test.stopTest();
    }
}