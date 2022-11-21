@isTest(SeeAllData=true)
public class CECAssessmentTest {
    static testMethod void shouldTestCECTrigger(){
    
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
	account.Relatives_in_Canada_List__c = 'Mother or father';
	//account.CurrentVisaStatus__c = 'Visitor';
	account.Previous_Refusal__c = 'No';
	account.Skype_ID__c = 'john.doe.test';
	account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer Profile').getRecordTypeId();
	account.Visa_Expiration_Date__c = Date.valueOf('2023-11-11');
    account.CurrentVisaStatus__c = 'WorkVisa';

    insert account;

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

    Language_Test__c colt4 = new Language_Test__c();
	colt4.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Main Applicant - Language Test').getRecordTypeId();
	colt4.Name = 'Teste';
	colt4.Account__c = account.id;
	colt4.Type_Language__c = 'English';
	colt4.Test_Type__c = 'CELPIP';
	colt4.Listening__c = 5;
	colt4.Reading__c = 5;
	colt4.Speaking__c = 5;
	colt4.Writing__c = 5;
	colt4.First_Language__c = true;
	colt4.Already_Taken__c = true;
	colt4.Expiration_Date__c = Date.valueOf('2023-11-11');
	colt4.Academico_ou_General_a1__c = 'General';
	insert colt4;


    assessment__c ao = new assessment__c();

	ao.Account__c = account.Id;
	ao.Select_Language_Test__c = colt.Id;
	ao.Work_Experience_1__c = cowe.Id;
	ao.RecordTypeId = Schema.SObjectType.assessment__c.getRecordTypeInfosByName().get('Assessment Calculation').getRecordTypeId();
	insert ao;

    assessment__c ao2 = new assessment__c();

	ao2.Account__c = account.Id;
	ao2.Select_Language_Test__c = colt2.Id;
	ao2.Work_Experience_1__c = cowe.Id;
	ao2.RecordTypeId = Schema.SObjectType.assessment__c.getRecordTypeInfosByName().get('Assessment Calculation').getRecordTypeId();
	insert ao2;

    cowe.NOC_Level__c = 'B';
    update cowe;
    
    assessment__c ao3 = new assessment__c();

	ao3.Account__c = account.Id;
	ao3.Select_Language_Test__c = colt2.Id;
	ao3.Work_Experience_1__c = cowe.Id;
	ao3.RecordTypeId = Schema.SObjectType.assessment__c.getRecordTypeInfosByName().get('Assessment Calculation').getRecordTypeId();
	insert ao3;
    
    assessment__c ao4 = new assessment__c();

	ao4.Account__c = account.Id;
	ao4.Select_Language_Test__c = colt3.Id;
	ao4.Work_Experience_1__c = cowe.Id;
	ao4.RecordTypeId = Schema.SObjectType.assessment__c.getRecordTypeInfosByName().get('Assessment Calculation').getRecordTypeId();
	insert ao4;


    assessment__c ao5 = new assessment__c();

	ao5.Account__c = account.Id;
	ao5.Select_Language_Test__c = colt4.Id;
	ao5.Work_Experience_1__c = cowe.Id;
	ao5.RecordTypeId = Schema.SObjectType.assessment__c.getRecordTypeInfosByName().get('Assessment Calculation').getRecordTypeId();
	insert ao5;
    }
}