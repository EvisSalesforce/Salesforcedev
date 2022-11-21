@isTest
public class AssessmentRestServiceTest {
    // test method for Assessment Rest Service
	@isTest
    static void asmtRestSvcTest(){
        // insert noc
        Eligible_Occupation__c noc = new Eligible_Occupation__c();
        noc.Name = '2173';
        noc.NOC_Details__c = 'cloud architect (NOC 2173)';
        insert noc;
        AssessmentParseJSON asp = TestDataFactory.createAssessmentParseJSON();
        String requestBodyJSON = JSON.serializePretty(asp);
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/services/apexrest/AssessmentRestService';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(requestBodyJSON);
        RestContext.request = req;
        RestContext.response= res;
        AssessmentRestService.createAssessment();
        
        AssessmentRestService.createAssessment();
        
        // Insert main appicant account for more coverage
        Account acc = new Account();
        acc.Name = 'Sammy';
        acc.e_mail__c = 'sammytest@test123.com';
        insert acc;
        Account spouse = new Account();
        spouse.Name = 'Sarena';
        spouse.e_mail__c = 'sarenatest@test123.com';
        insert spouse;
        AssessmentRestService.createAssessment();
        AssessmentRestService.createAssessment();
        delete[Select Id from Account Where e_mail__c = 'sarenatest@test123.com' LIMIT 1];
        AssessmentRestService.createAssessment();
    }
    
    // Test method for Consultation Rest Service
    @isTest
    static void consultationRestTest(){
        ConsultationJSONParse csp = new ConsultationJSONParse();
        csp.First_Name = 'Sammy';
        csp.Last_Name = 'J';
        csp.Phone = '45678907654';
        csp.Email = 'sammytest@test123.com';
        
        String requestBodyJSON = System.JSON.serialize(csp);
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/services/apexrest/ConsultationRestService';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(requestBodyJSON);
        RestContext.request = req;
        RestContext.response= res;
        System.Test.startTest();
        Lead ld = new Lead();
        ld.Company = 'Sammy J';
        ld.Status = 'New';
        ld.FirstName = 'Sammy';
        ld.LastName = 'j';
        ld.Email = 'sammytest@test123.com';
        ld.DOB__c = Date.newInstance(1984, 08, 23);
        ld.Spouse_First_Name__c ='sarena';
        ld.Spouse_Last_Name__c = 'J';
        ld.Spouse_DOB__c = Date.newInstance(1997, 08, 23);
        ld.Email_Spouse__c = 'sarenatest@test123.com';
        ld.LeadSource = 'FREE ASSESSMENT';
        insert ld;
        assessment__c asmt = new assessment__c();
        asmt.Lead__c = ld.Id;
        insert asmt;
        ConsultationRestService.createConsultation();
        account spouse = [Select Id From Account Where e_mail__c = 'sarenatest@test123.com' LIMIT 1];
        spouse.ParentId = null;
        update spouse;
        ConsultationRestService.createConsultation();
        ConsultationJSONParse csp2 = new ConsultationJSONParse();
        csp2.First_Name = 'Vinni';
        csp2.Last_Name = 'test';
        csp2.Phone = '78765789';
        csp2.Email = 'vinnytest@test123.com';
        req.requestBody = Blob.valueOf(System.JSON.serialize(csp2));
        ConsultationRestService.createConsultation();
        // Another case when lead is present & idle spouse account also present in SF
        Lead ld2 = new Lead();
        ld2.Company = 'Ramesh Test';
        ld2.Status = 'New';
        ld2.FirstName = 'Ramesh';
        ld2.LastName = 'Test';
        ld2.Email = 'rameshtestt@test123.com';
        ld2.DOB__c = Date.newInstance(1997, 08, 23);
        ld2.Spouse_First_Name__c ='Sheena';
        ld2.Spouse_Last_Name__c = 'test';
        ld2.Spouse_DOB__c = Date.newInstance(1997, 08, 23);
        ld2.Email_Spouse__c = 'sheenatest@test123.com';
        ld2.LeadSource = 'FREE ASSESSMENT';
        insert ld2;
		
		
		Account sp2 = new Account();
        sp2.Name = 'Sheena';
        sp2.e_mail__c = 'sheenatest@test123.com';
        insert sp2;
        
        csp2.First_Name = 'Ramesh';
        csp2.Last_Name = 'test';
        csp2.Phone = '23145342423';
        csp2.Email = 'rameshtestt@test123.com';
        req.requestBody = Blob.valueOf(System.JSON.serialize(csp2));
        ConsultationRestService.createConsultation();
        ConsultationRestService.isIdleAccount(null);
        System.Test.stopTest();
    }
    
    // Test method for LeadConvertViewController(VF page LeadConvertView)
    @isTest
    static void LeadConvertViewController(){
        Lead ld = new Lead();
        ld.Company = 'Sammy J';
        ld.Status = 'New';
        ld.FirstName = 'Sammy';
        ld.LastName = 'j';
        ld.Email = 'sammytest@test123.com';
        ld.DOB__c = Date.newInstance(1997, 08, 23);
        ld.Spouse_First_Name__c ='sarena';
        ld.Spouse_Last_Name__c = 'J';
        ld.Spouse_DOB__c = Date.newInstance(1997, 08, 23);
        ld.Email_Spouse__c = 'sarenatest@test123.com';
        ld.LeadSource = 'FREE ASSESSMENT';
        insert ld;
        assessment__c asmt = new assessment__c();
        asmt.Lead__c = ld.Id;
        insert asmt;
        System.Test.startTest();
        PageReference pageRef = Page.LeadConvertView;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController ctlr = new ApexPages.StandardController(ld);
        LeadConvertViewController lvc = new LeadConvertViewController(ctlr);
        lvc.convertLead();
        
        // Another case when lead is present & idle spouse account also present in SF
        Lead ld2 = new Lead();
        ld2.Company = 'Ramesh Test';
        ld2.Status = 'New';
        ld2.FirstName = 'Ramesh';
        ld2.LastName = 'Test';
        ld2.Email = 'rameshtestt@test123.com';
        ld2.DOB__c = Date.newInstance(1997, 08, 23);
        ld2.Spouse_First_Name__c ='Sheena';
        ld2.Spouse_Last_Name__c = 'test';
        ld2.Spouse_DOB__c = Date.newInstance(1997, 08, 23);
        ld2.Email_Spouse__c = 'sheenatest@test123.com';
        ld2.LeadSource = 'FREE ASSESSMENT';
        insert ld2;
		
		
		Account sp2 = new Account();
        sp2.Name = 'Sheena';
        sp2.e_mail__c = 'sheenatest@test123.com';
        insert sp2;
        ctlr = new ApexPages.StandardController(ld2);
        lvc = new LeadConvertViewController(ctlr);
        lvc.convertLead();
        System.Test.stopTest();
    }
    
    // Test Method to test AssessmentScoreTrigger & its handler class LeadAssessmentCalculator
    @isTest
    static void AssessmentScoreTriggerTest(){
        Lead ld = new Lead();
        ld.Company = 'Sammy J';
        ld.Status = 'New';
        ld.FirstName = 'Sammy';
        ld.LastName = 'j';
        ld.Email = 'sammytest@test123.com';
        ld.DOB__c = Date.newInstance(1970, 08, 23);
        ld.Spouse_First_Name__c ='sarena';
        ld.Spouse_Last_Name__c = 'J';
        ld.Spouse_DOB__c = Date.newInstance(1974, 08, 23);
        ld.Email_Spouse__c = 'sarenatest@test123.com';
        ld.LeadSource = 'FREE ASSESSMENT';
        
        insert ld;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(1, null, null, nocList.get(0).Id);
        asmtList.get(0).Lead__c = ld.Id;
        insert asmtList;
        
        ld.Marital_Status__c = 'Married';
        update ld;
        LeadAssessmentCalculator.calcPoints(asmtList);
        assessment__c asmt = asmtList.get(0);
        asmt.Level_of_education__c = 'Masters Degree or Professional Degree';
        asmt.Level_of_education_Spouse__c = 'Masters Degree or Professional Degree';
        asmt.Location_1__c = 'Outside Canada';
        asmt.Location_2__c = 'Outside Canada';
        asmt.Location_3__c = 'Outside Canada';
        asmt.English_Listening__c = '9';
        asmt.English_reading__c = '7.5';
        asmt.English_Writing__c = '7';
        asmt.English_speaking__c = '6';
        LeadAssessmentCalculator.calcPoints(new List<assessment__c>{asmt});
        
        asmt.English_reading__c = '8';
        asmt.French_first_language__c = false;
        asmt.French_first_language_Spouse__c = false;
        asmt.Do_you_speak_English_Spouse__c = 'Yes';
        asmt.Duration_1__c = '3 months or more, but less than 6 months';
        asmt.Duration_2__c = '6 months or more, but less than 9 months';
        asmt.Duration_3__c = '6 months or more, but less than 9 months';
        asmt.Post_secondary_studies__c = 'Ph.D.';
        asmt.NOC_received__c = '0,A,B';
        LeadAssessmentCalculator.calcPoints(new List<assessment__c>{asmt});
        
        Eligible_Occupation__c nocA = new Eligible_Occupation__c();
        nocA.Name = '0013';
        insert nocA;
        
        Eligible_Occupation__c nocB = new Eligible_Occupation__c();
        nocB.Name = '1212';
        insert nocB;
        
        asmt.Please_type_a_occupation_1__c = nocA.Id;
        asmt.Please_type_a_occupation_2__c = nocA.Id;
        asmt.Please_type_a_occupation_3__c = nocA.Id;
        asmt.Location_1__c = 'In Canada';
        asmt.Location_2__c = 'In Canada';
        asmt.Location_3__c = 'In Canada';
        LeadAssessmentCalculator.calcPoints(new List<assessment__c>{asmt});
        
        asmt.Please_type_a_occupation_1__c = nocB.Id;
        asmt.Please_type_a_occupation_2__c = nocB.Id;
        asmt.Please_type_a_occupation_3__c = nocB.Id;
        LeadAssessmentCalculator.calcPoints(new List<assessment__c>{asmt});
        
        asmt.Duration_3__c = '6 years or more';
        asmt.Duration_2__c = '6 years or more';
        asmt.Location_3__c = 'Outside Canada';
        asmt.Level_of_education__c = 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)';
        asmt.Please_type_a_occupation_3__c = nocA.Id;
        LeadAssessmentCalculator.calcPoints(new List<assessment__c>{asmt});
        
        ld.Marital_Status__c = 'Single/Never married';
        update ld;
        asmt.French_first_language__c = true;
        asmt.French_first_language_Spouse__c = true;
        LeadAssessmentCalculator.calcPoints(new List<assessment__c>{asmt});
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
        LeadConvertViewController.isIdleAccount(spouse);
        Test.stopTest();
    }
    // test method for Assessment Rest Service
	@isTest
    static void asmtRestSvcTestBCPNP(){
        // insert noc
        Eligible_Occupation__c noc = new Eligible_Occupation__c();
        noc.Name = '2173';
        noc.NOC_Details__c = 'cloud architect (NOC 2173)';
        insert noc;
        String json = '{\"first_name\":\"Iman\",\"last_name\":\"Test\",\"email\":\"ijam10@gmail.com\",\"email_confirmation\":\"ijam10@gmail.com\",\"how_hear_about_us\":\"CONTACT SITE\",\"preferred_language\":\"French\",\"user_note\":\"asdasd\",\"job_offer\":[{\"job_title_noc\":{\"id\":\"51\",\"title\":\"cloud architect \",\"noc\":\"2173\"},\"years_of_experience\":\"No\",\"type_of_salary\":\"Hourly\",\"salary_amount\":10,\"hours_per_week\":40,\"years_of_related_work_experience\":\"Less than 1 year\",\"a_year_experience_canada\":\"Yes\",\"are_you_in_canada\":\"Yes\",\"company_location_in_bc\":\"Greater Vancouver\",\"employer_full_time_employees\":\"Yes\"}],\"languages\":{\"ENGLISH\":{\"english_test\":\"CELPIP\",\"skills\":{\"listening\":\"Level 12\",\"reading\":\"Level 11\",\"writing\":\"Level 11\",\"speaking\":\"Level 12\"}},\"FRENCH\":{\"french_test\":\"TEF\",\"skills\":{\"listening\":\"298-315\",\"reading\":\"207-232\",\"writing\":\"349-370\",\"speaking\":\"349-370\"}}},\"educations\":[{\"education_level\":\"Doctor Degree (PhD)\",\"name_of_credential\":\"asd\",\"country_of_education\":{\"id\":4,\"title\":\"Canada\",\"code\":\"DS\"},\"obtained_credential_assessment\":\"Yes\",\"obtained_trade_certification_in_canada\":\"No\",\"canadian_education_institution_type\":null,\"canadian_education_institution_location\":null}]}';
        //BCPNPParser asp = BCPNPParser.parse(json);
        //String requestBodyJSON = json;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/services/apexrest/AssessmentRestService/type/BCPNP';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(json);
        RestContext.request = req;
        RestContext.response= res;
        AssessmentRestService.createAssessment();
        
        AssessmentRestService.createAssessment();
        
        // Insert main appicant account for more coverage
        Account acc = new Account();
        acc.Name = 'Sammy';
        acc.e_mail__c = 'ijam10@gmail.com';
        insert acc;
        AssessmentRestService.createAssessment();
        AssessmentRestService.createAssessment();
        delete[Select Id from Account Where e_mail__c = 'ijam10@gmail.com' LIMIT 1];
        AssessmentRestService.createAssessment();
    }
    
    //Test Method For Assessment Rest Service OINP
    @isTest
    static void asmtRestSvcTestOINP(){
        // insert noc
        Eligible_Occupation__c noc = new Eligible_Occupation__c();
        noc.Name = '2173';
        noc.NOC_Details__c = 'cloud architect (NOC 2173)';
        insert noc;
        String json = '{\"first_name\":\"Ar\",\"last_name\":\"Uj\",\"email\":\"aryan.ujlayan@algoworks.com\",\"email_confirmation\":\"aryan.ujlayan@algoworks.com\",\"preferred_language\":\"English\",\"user_note\":null,\"job_offer\":[{\"job_title_noc\":{\"id\":\"4865\",\"title\":\"shelving clerk - library \",\"noc\":\"1451\"},\"currently_working\":\"Yes\",\"experience_over_year\":\"None or Less than 12 months of cumulative, full-time or part-time equivalent\",\"salary_amount\":\"$40 per hour or higher\",\"in_demand_occupation\":\"Yes\",\"earnings_history\":\"$40k or more earnings in a year\",\"years_of_related_work_experience\":\"1 to 2 years\",\"part_of_strategic_priorities\":\"No\",\"company_location_in_on\":\"Greater Toronto Area (GTA)\",\"are_you_in_canada\":\"Yes\",\"cec_noc\":{\"id\":\"2304\",\"title\":\"cold-storage manager \",\"noc\":\"0651\"}}],\"languages\":{\"ENGLISH\":{\"english_test\":\"CELPIP\",\"skills\":{\"listening\":\"Level 11\",\"reading\":\"Level 10\",\"writing\":\"Level 9\",\"speaking\":\"Level 8\"}},\"FRENCH\":{\"french_test\":\"No\",\"skills\":{\"listening\":\"Upper Intermediate (CLB 8)\",\"reading\":\"Advanced\\/Native Proficiency (CLB 9+)\",\"writing\":\"Intermediate II (CLB 7)\",\"speaking\":\"Intermediate I (CLB 6)\"}}},\"educations\":[{\"education_level\":\"Masters\",\"name_of_credential\":\"Cred10\",\"field_of_study\":\"Health care\",\"country_of_education\":{\"id\":38,\"title\":\"Canada\",\"code\":\"CA\"},\"canadian_education_institution_type\":\"Public\",\"canadian_education_institution_location\":\"Greater Toronto Area (GTA)\",\"canadian_education_experience\":\"One Canadian credential\"}]}';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/services/apexrest/AssessmentRestService/type/OINP';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(json);
        RestContext.request = req;
        RestContext.response= res;
        AssessmentRestService.createAssessment();
        
        AssessmentRestService.createAssessment();
        
        // Insert main appicant account for more coverage
        Account acc = new Account();
        acc.Name = 'Sammy';
        acc.e_mail__c = 'ijam10@gmail.com';
        insert acc;
        AssessmentRestService.createAssessment();
        AssessmentRestService.createAssessment();
        delete[Select Id from Account Where e_mail__c = 'ijam10@gmail.com' LIMIT 1];
        AssessmentRestService.createAssessment();
    }
}