@isTest(SeeAllData=true)
public with sharing class EEAssessmentTest {
    public static testMethod void shouldTestEEAssessmentTest() {

        Account account = new Account();
	account.Name = 'Jeohn';
	account.Territory__c = 'Vancouver';
	account.e_mail__c = 'john.doee.test@test.com.zp';
	account.DOB__c = Date.valueOf('1965-11-11');
	account.Type = 'Customer';
	account.Looking_for__c = 'Consultation';
	account.AccountSource = 'GOOGLE';
	account.Phone = '11111111';
	account.Marital_Status__c = 'Single';
	account.Preferred_Language__c = 'English';
	account.Country_of_Citizenship__c = 'Brazil';
	account.Relatives_In_Canada__c = true;
	//account.CurrentVisaStatus__c = 'Visitor';
	account.Previous_Refusal__c = 'No';
	account.Skype_ID__c = 'john.doe.test';
	account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer Profile').getRecordTypeId();
	account.Visa_Expiration_Date__c = Date.valueOf('2023-11-11');
    account.CurrentVisaStatus__c = 'WorkVisa';

    insert account;


Education__c coedu = new Education__c();
	coedu.Name = 'Teste';
	coedu.RecordTypeId = Schema.SObjectType.Education__c.getRecordTypeInfosByName().get('Main Applicant - Canadian Education').getRecordTypeId();
	coedu.Account__c = account.Id;
	coedu.Institution_name__c = 'Teste Inst';
	coedu.Education_Background__c = 'Two or more Bachelors or Diploma';
	coedu.Institution_Type__c = 'Public';
	coedu.Duration__c = '2 years';
	coedu.Completed__c = true;
	insert coedu;

    Work_Experience_1__c cowe = new Work_Experience_1__c();
	cowe.Name = 'Test';
	cowe.RecordTypeId = Schema.SObjectType.Work_Experience_1__c.getRecordTypeInfosByName().get('Main Applicant - Canadian Experience').getRecordTypeId();
	cowe.Account__c = account.id;
	cowe.Employer__c = 'Test';
	cowe.Type_of_Employment__c = 'Employee';
	cowe.Employment_hours__c = 'Full-time';
	cowe.NOC_Level__c = '0';
    cowe.Years_of_Experience__c = '1 year';
	cowe.Start_Date__c = Date.valueOf('2018-11-11');
	cowe.Number_of_Employees__c = 50;
    cowe.End_Date__c = Date.valueOf('2018-11-11');

    insert cowe;

    Work_Experience_1__c cowe2 = new Work_Experience_1__c();
	cowe2.Name = 'Test';
	cowe2.RecordTypeId = Schema.SObjectType.Work_Experience_1__c.getRecordTypeInfosByName().get('Main Applicant - Foreign Experience').getRecordTypeId();
	cowe2.Account__c = account.id;
	cowe2.Employer__c = 'Test';
	cowe2.Type_of_Employment__c = 'Employee';
	cowe2.Employment_hours__c = 'Full-time';
	cowe2.NOC_Level__c = '0';
    cowe2.Years_of_Experience__c = '1 year';
	cowe2.Start_Date__c = Date.valueOf('2018-11-11');
	cowe2.Number_of_Employees__c = 50;
    cowe2.End_Date__c = Date.valueOf('2018-11-11');

    insert cowe2;

    Language_Test__c colt = new Language_Test__c();
	colt.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Main Applicant - Language Test').getRecordTypeId();
	colt.Name = 'Teste';
	colt.Account__c = account.id;
	colt.Type_Language__c = 'English';
	colt.Test_Type__c = 'CELPIP';
	colt.Listening__c = 7;
	colt.Reading__c = 7;
	colt.Speaking__c = 7;
	colt.Writing__c = 7;
	colt.First_Language__c = true;
	colt.Already_Taken__c = true;
	colt.Expiration_Date__c = Date.valueOf('2023-11-11');
	colt.Academico_ou_General_a1__c = 'General';
	insert colt;

    Language_Test__c colt2 = new Language_Test__c();
	colt2.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Main Applicant - Language Test').getRecordTypeId();
	colt2.Name = 'Teste';
	colt2.Account__c = account.id;
	colt2.Type_Language__c = 'English';
	colt2.Test_Type__c = 'IELTS';
	colt2.Listening__c = 7;
	colt2.Reading__c = 7;
	colt2.Speaking__c = 7;
	colt2.Writing__c = 7;
	colt2.First_Language__c = true;
	colt2.Already_Taken__c = true;
	colt2.Expiration_Date__c = Date.valueOf('2023-11-11');
	colt2.Academico_ou_General_a1__c = 'General';
	insert colt2;




    Language_Test__c colt3 = new Language_Test__c();
	colt3.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Main Applicant - Language Test').getRecordTypeId();
	colt3.Name = 'Teste';
	colt3.Account__c = account.id;
	colt3.Type_Language__c = 'English';
	colt3.Test_Type__c = 'IELTS';
	colt3.Listening__c = 5;
	colt3.Reading__c = 4;
	colt3.Speaking__c = 5;
	colt3.Writing__c = 5;
	colt3.First_Language__c = true;
	colt3.Already_Taken__c = true;
	colt3.Expiration_Date__c = Date.valueOf('2023-11-11');
	colt3.Academico_ou_General_a1__c = 'General';
	insert colt3;

Education__c coedu3 = new Education__c();
	coedu3.Name = 'Teste';
	coedu3.RecordTypeId = Schema.SObjectType.Education__c.getRecordTypeInfosByName().get('Spouse - Canadian Education').getRecordTypeId();
	coedu3.Account__c = account.id;
	coedu3.Institution_name__c = 'Teste Inst';
	coedu3.Education_Background__c = 'PHD';
	coedu3.Institution_Type__c = 'Public';
	coedu3.Type_of_education__c = 'Full-time';
	coedu3.Duration__c = '2 years';
	coedu3.Completed__c = true;
	insert coedu3;




    assessment__c ao = new assessment__c();
    ao.Account__c = account.Id;
	ao.Select_Language_Test__c = colt.Id;
    ao.Second_Language_Test__c = colt3.Id;
    ao.Select_Education__c = coedu.Id;
	ao.Work_Experience_1__c = cowe.Id;
    ao.Spouse_Partner__c = null;
    ao.Select_Language_Test_P__c = null;
    ao.Second_Language_Test_P__c = null;
    ao.Select_Education_P__c = null;
    ao.Select_the_Work_Experience_P__c = null;

	insert ao;

    }
}