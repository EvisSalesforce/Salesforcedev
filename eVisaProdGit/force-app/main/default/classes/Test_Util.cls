@isTest(SeeAllData=true)

public class Test_Util {

public static Contact newContactAssessment(Id acc, String fName, String lName, String email, Date dob){
	Contact co = new Contact();
	co.FirstName = fName;
	co.LastName = lName;
	co.AccountId = acc;
	co.Email = email;
	co.MobilePhone = '111114578';
	co.Relationship__c = 'Spouse';
	co.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Dependant').getRecordTypeId();
	co.Status__c = 'Worker';
	co.Status_expiration_date__c = Date.valueOf('2023-11-11');
	co.DOB__c = dob;   //Date.valueOf('1975-10-28');
	co.Previous_refusal__c = 'No';
	co.Preferred_Language__c = 'Portuguese';
	insert co;
	return co;
}

public static Account newAccountAssessment(String Name, String email, Date dob, Boolean relatives){
	Account account = new Account();
	account.Name = Name;
	account.Territory__c = 'Vancouver';
	account.e_mail__c = email;
	account.DOB__c = dob;//Date.valueOf('1965-11-11');
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
	insert account;
	return account;
}



public static Language_Test__c languageTestContact(Id id, Double listening, Double reading, Double speaking, Double writing, Boolean firstLanguage){
	Language_Test__c colt = new Language_Test__c();
	colt.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Spouse - Language Test').getRecordTypeId();
	colt.Name = 'Teste';
	colt.Contact__c = id;
	colt.Type_Language__c = 'English';
	colt.Test_Type__c = 'CELPIP';
	colt.Listening__c = listening;
	colt.Reading__c = reading;
	colt.Speaking__c = speaking;
	colt.Writing__c = writing;
	colt.First_Language__c = firstLanguage;
	colt.Already_Taken__c = true;
	colt.Expiration_Date__c = Date.valueOf('2023-11-11');
	colt.Academico_ou_General_a1__c = 'General';
	insert colt;
	return colt;
}

public static Language_Test__c languageTestAccount(Id id, Double listening, Double reading, Double speaking, Double writing, Boolean firstLanguage){
	Language_Test__c colt = new Language_Test__c();
	colt.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Spouse - Language Test').getRecordTypeId();
	colt.Name = 'Teste';
	colt.Account__c = id;
	colt.Type_Language__c = 'English';
	colt.Test_Type__c = 'CELPIP';
	colt.Listening__c = listening;
	colt.Reading__c = reading;
	colt.Speaking__c = speaking;
	colt.Writing__c = writing;
	colt.First_Language__c = firstLanguage;
	colt.Already_Taken__c = true;
	colt.Expiration_Date__c = Date.valueOf('2023-11-11');
	colt.Academico_ou_General_a1__c = 'General';
	insert colt;
	return colt;
}

public static Work_Experience_1__c newWorkExpContact(Id id, Boolean weCanada, String hours, String yoe, String noc){
	Work_Experience_1__c cowe = new Work_Experience_1__c();
	cowe.Name = 'Test';
	cowe.RecordTypeId = Schema.SObjectType.Work_Experience_1__c.getRecordTypeInfosByName().get('Spouse - Canadian Experience').getRecordTypeId();
	cowe.Contact__c = id;
	cowe.Employer__c = 'Test';
	cowe.Type_of_Employment__c = 'Employee';
	cowe.Employment_hours__c = hours;
	cowe.Years_of_Experience__c = yoe;
	cowe.NOC_Level__c = noc;
	cowe.Start_Date__c = Date.valueOf('2018-11-11');
	cowe.Number_of_Employees__c = 50;
	insert cowe;
	return cowe;

}
public static Work_Experience_1__c newWorkExpAccount(Id id, Boolean weCanada, String hours, String yoe, String noc){
	Work_Experience_1__c cowe = new Work_Experience_1__c();
	cowe.Name = 'Test';
	cowe.RecordTypeId = Schema.SObjectType.Work_Experience_1__c.getRecordTypeInfosByName().get('Spouse - Canadian Experience').getRecordTypeId();
	cowe.Account__c = id;
	cowe.Employer__c = 'Test';
	cowe.Type_of_Employment__c = 'Employee';
	cowe.Employment_hours__c = hours;
	cowe.Years_of_Experience__c = yoe;
	cowe.NOC_Level__c = noc;
	cowe.Start_Date__c = Date.valueOf('2018-11-11');
	cowe.Number_of_Employees__c = 50;
	//insert cowe;
	return cowe;

}

public static Education__c newEducationContact(Id id, String backGround, String type, String duration){
	Education__c coedu = new Education__c();
	coedu.Name = 'Teste';
	coedu.RecordTypeId = Schema.SObjectType.Education__c.getRecordTypeInfosByName().get('Spouse - Canadian Education').getRecordTypeId();
	coedu.Contact__c = id;
	coedu.Institution_name__c = 'Teste Inst';
	coedu.Education_Background__c = backGround;
	coedu.Institution_Type__c = 'Public';
	coedu.Type_of_education__c = type;
	coedu.Duration__c = duration;
	coedu.Completed__c = true;
	insert coedu;
	return coedu;
}

public static Education__c newEducationAccount(Id id, String backGround, String type, String duration){
	Education__c coedu = new Education__c();
	coedu.Name = 'Teste';
	coedu.RecordTypeId = Schema.SObjectType.Education__c.getRecordTypeInfosByName().get('Main Applicant - Canadian Education').getRecordTypeId();
	coedu.Account__c = id;
	coedu.Institution_name__c = 'Teste Inst';
	coedu.Education_Background__c = backGround;
	coedu.Institution_Type__c = 'Public';
	coedu.Type_of_education__c = type;
	coedu.Duration__c = duration;
	coedu.Completed__c = true;
	insert coedu;
	return coedu;


}

public static Account newAccount(){


	Account account = new Account();
	account.Name = 'John';
	account.Territory__c = 'Vancouver';
	account.e_mail__c = 'john.doe.test@test.com.zp';
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


	Language_Test__c lt = new Language_Test__c();
	lt.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Main Applicant - Language Test').getRecordTypeId();
	lt.Name = 'Teste';
	lt.Account__c = account.Id;
	lt.Type_Language__c = 'English';
	lt.Test_Type__c = 'CELPIP';
	lt.Listening__c = 5;
	lt.Reading__c = 5;
	lt.Speaking__c = 5;
	lt.Writing__c = 5;
	lt.First_Language__c = true;
	lt.Already_Taken__c = true;
	lt.Expiration_Date__c = Date.valueOf('2023-11-11');
	lt.Academico_ou_General_a1__c = 'General';

	insert lt;

	Language_Test__c lt2 = new Language_Test__c();
	lt2.RecordTypeId = Schema.SObjectType.Language_Test__c.getRecordTypeInfosByName().get('Main Applicant - Language Test').getRecordTypeId();
	lt2.Name = 'Teste';
	lt2.Account__c = account.Id;
	lt2.Type_Language__c = 'English';
	lt2.Test_Type__c = 'CELPIP';
	lt2.Listening__c = 5;
	lt2.Reading__c = 5;
	lt2.Speaking__c = 5;
	lt2.Writing__c = 5;
	lt2.First_Language__c = true;
	lt2.Already_Taken__c = true;
	lt2.Expiration_Date__c = Date.valueOf('2023-11-11');
	lt2.Academico_ou_General_a1__c = 'General';

	insert lt2;

	Education__c edu = new Education__c();
	edu.Name = 'Teste';
	edu.RecordTypeId = Schema.SObjectType.Education__c.getRecordTypeInfosByName().get('Main Applicant - Canadian Education').getRecordTypeId();
	edu.Account__c = account.Id;
	edu.Institution_name__c = 'Teste Inst';
	edu.Education_Background__c = 'Masters';
	edu.Institution_Type__c = 'Public';
	edu.Completed__c = true;

	insert edu;

	Work_Experience_1__c we = new Work_Experience_1__c();
	we.Name = 'Test';
	we.RecordTypeId = Schema.SObjectType.Work_Experience_1__c.getRecordTypeInfosByName().get('Main Applicant - Canadian Experience').getRecordTypeId();
	we.Account__c = account.Id;
	we.Employer__c = 'Test';
	we.Type_of_Employment__c = 'Employee';
	we.Employment_hours__c = 'Full-time';
	we.Years_of_Experience__c = '1 year';
	we.NOC_Level__c = 'A';
	we.Start_Date__c = Date.valueOf('2018-11-11');
	we.Number_of_Employees__c = 50;

	insert we;
	return account;
}



public static assessment__c newAssessment(Id account, Id acolt,Id acolt2,Id acowe,Id acoedu,Id contact,Id colt,Id colt2,Id cowe,Id coedu, Boolean lmia){


	assessment__c a = new assessment__c();
	a.Account__c = account;
	a.Select_Language_Test__c = acolt;
	a.Second_Language_Test__c = acolt2;
	a.Select_Education__c = acoedu;
	a.Work_Experience_1__c = acowe;
	a.Spouse_Partner__c = contact;
	a.Select_Language_Test_P__c = colt;
	a.Second_Language_Test_P__c = colt2;
	a.Select_Education_P__c = coedu;
	a.Select_the_Work_Experience_P__c = cowe;
	a.LMIA__c = lmia;
	a.RecordTypeId = Schema.SObjectType.assessment__c.getRecordTypeInfosByName().get('Assessment Calculation').getRecordTypeId();
	System.debug(a);
	//insert a;
	return a;


}

public static Opportunity newOpportunity(Id acc){

	Id pricebookId = Test.getStandardPricebookId();

	Opportunity opp = new Opportunity();
	opp.Name = 'Opp test';
	opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('e-Visa').getRecordTypeId();
	opp.Looking_for__c = 'Consultation';
	opp.AccountId = acc;
	opp.LeadSource = 'ACUITY SCHEDULING';
	opp.StageName = 'Closed Won';
	opp.CloseDate = Date.valueOf('2019-11-11');
	opp.Pricebook2Id = pricebookId;
	insert opp;


	Product2 prod = new Product2(
		Name = 'Product X',
		ProductCode = 'Pro-X',
		isActive = true
		);
	insert prod;

	PricebookEntry pbEntry = new PricebookEntry(
		Pricebook2Id = pricebookId,
		Product2Id = prod.Id,
		UnitPrice = 100.00,
		IsActive = true
		);
	insert pbEntry;

	OpportunityLineItem oli = new OpportunityLineItem(
		OpportunityId = opp.Id,
		Quantity = 5,
		PricebookEntryId = pbEntry.Id,
		TotalPrice = 5 * pbEntry.UnitPrice
		);
	insert oli;

	return opp;
}
}