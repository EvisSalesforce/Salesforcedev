@isTest
public class AssessmentPanelScreenControllerTest {

    @isTest 
    static void screenTest1(){
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        insert actList;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        insert asmtList;
        
        PageReference pageRef = Page.AssessmentPanelScreen;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        System.Test.startTest();
        // Cover the onCSheetClick, handleConsultationDetails method
        AssessmentPanelScreenController controller = new AssessmentPanelScreenController();
        // Cover the onAsmtClick()
        controller.selectedAsmtId = asmtList[0].Id;
        controller.onAsmtClick();
        account acc = new Account(name = 'test', parentId = actList[0].Id);
        acc.First_Name__c = 'test';
        acc.Last_Name__c = 'testlast';
        acc.e_mail__c = 'test@test.com';
        insert acc;
        controller.selectedAsmtId = null;
        controller.onAsmtClick();
        // Cover the backtoConsultationList
        controller.backtoConsultationList();
        // Cover onConsultationDetailsLeave
        controller.consTab = false;
        controller.onConsultationDetailsLeave();
        controller.cSheetDetail.Id = null;
        controller.onConsultationDetailsLeave();
        controller.cSheetDetail.Account__c = null;
        controller.onConsultationDetailsLeave();
        
		// Cover the setFieldValuesCDTab()
		controller.setFieldValuesCDTab();
        // Cover setrequiredFieldValuesCDTab()
        controller.setrequiredFieldValuesCDTab();
        controller.cSheetDetail.Account__c = actList[0].Id;
        controller.setrequiredFieldValuesCDTab();
        //Cover onEnTestChange()
        controller.selectedOptionEnLang = 'Main';
        controller.onEnTestChange();
        controller.selectedOptionEnLang = 'Spouse';
        controller.onEnTestChange();
        // Cover handleMaritalStatus()
        controller.handleMaritalStatus();
        
        // Cover the handleChildren()
        controller.assessment.Number_of_children__c = '';
        controller.handleChildren();
        controller.assessment.Number_of_children__c = '1';
        controller.handleChildren();
        controller.assessment.Number_of_children__c = '2';
        controller.handleChildren();
        controller.assessment.Number_of_children__c = '3';
        controller.handleChildren();
        controller.assessment.Number_of_children__c = '4';
        controller.handleChildren();
        controller.assessment.Number_of_children__c = '5';
        controller.handleChildren();
        // Cover handleLevelEdu()
        controller.handleLevelEdu();
        controller.assessment.Post_secondaries_in_canada__c = '';
        controller.handleLevelEdu();
        // Cover handleLevelEduSp()
        controller.handleLevelEduSp();
        controller.assessment.Post_secondaries_in_canada_Spouse__c = '';
        controller.handleLevelEduSp();
        // Cover handleLang()
        controller.handleLang();
        controller.assessment.Do_you_speak_English__c = '';
        controller.handleLang();
        // Cover handleLangFrench()
        controller.handleLangFrench();
        
        //Cover handleLangSpouse()
        controller.handleLangSpouse();
        controller.assessment.Do_you_speak_English_Spouse__c = 'Yes';
        controller.handleLangSpouse();
        
        // Cover handleLangFrenchSpouse
        controller.handleLangFrenchSpouse();
        
        // Cover handleWorkInCanada
        controller.handleWorkInCanada();
        controller.assessment.have_been_canada_as_temp_worker__c = '';
        controller.assessment.Have_you_received_an_LMIA__c = '';
        controller.handleWorkInCanada();
        // Cover handleFrenchTestType()
        controller.handleFrenchTestType();
        // Cover handleFrenchTestTypeSpouse()
        Controller.handleFrenchTestTypeSpouse();
        // Cover handleOnChangeProfile()
        controller.handleOnChangeProfile();
        // Cover handleOnChangeProfileRequired()
        controller.handleOnChangeProfileRequired();
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.mainApplicantAcc.e_mail__c = '';
        System.debug('controller.spouseAcc.Id: '+controller.spouseAcc.Id);
        controller.handleOnChangeProfileRequired();
        controller.mainApplicantAcc.Marital_Status__c = 'Legally separated';
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.e_mail__c = null;
        System.debug('main Applicant: '+controller.mainApplicantAcc);
        System.debug('Spouse :'+ controller.spouseAcc);
        controller.handleOnChangeProfileRequired();
        // Cover saveOrUpdateProfile
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = acc.Id;
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.mainApplicantAcc.e_mail__c = 'testmain@test.com';
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.Marital_Status__c = 'Legally separated';
        controller.saveOrUpdateProfile();
        controller.assessment.Id = null;
        controller.saveOrUpdateProfile();
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.spouseAcc.Id = null;
        controller.spouseAcc.DOB__c = date.newInstance(1990, 1, 23);
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = null;
        controller.assessment.Id = null;
        controller.saveOrUpdateProfile();
        controller.assessment.Consultation_Sheet__c = cSheets[0].Id;
        controller.saveOrUpdateProfile();
        controller.assessment.Id = null;
        //controller.saveOrUpdateProfile();
                
        System.Test.stopTest();
    }
    
    @isTest
    static void screenTest2(){
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        actList[0].Name = 'Test151';
        actList[0].e_mail__c = 'Test151@xyz.in';
        insert actList;
        List<Account> actSp = TestDataFactory.createAccounts(1, actList[0].Id);
        actSp[0].Name = 'testSp151';
        actSp[0].e_mail__c = 'testSp151@xyz.in';
        insert actSP;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        oppty[0].Name = 'testScreen2';
        oppty[0].Number_of_Applicants__c = 1;
        oppty[0].CloseDate = system.today()+60;
        insert oppty;

        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        insert asmtList;
        
        PageReference pageRef = Page.AssessmentPanelScreen;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        // Cover the onCSheetClick, handleConsultationDetails method
        AssessmentPanelScreenController controller = new AssessmentPanelScreenController();

        System.Test.startTest();
        controller.onProfileLeave();
        // Cover onOccuClick
        controller.onOccuClick();
        // Cover onCSTabClick
        controller.onCSTabClick();
        // Cover onProflieClick
        controller.onProflieClick();
        
        // Cover handleOnChangeWorkEx
        controller.handleOnChangeWorkEx();
        // Cover handleOnChangeRequiredWorkEx
        controller.handleOnChangeRequiredWorkEx();
        controller.assessment.Duration_1_Spouse__c = null;
        controller.handleOnChangeRequiredWorkEx();
        
        // Cover updateWorkex()
        controller.assessment.Duration_1_Spouse__c = '6 years or more';
        controller.updateWorkex();
        // Cover handleSpouseHaveAnyWorkEx()
        controller.handleSpouseHaveAnyWorkEx();
        // Cover updateWorkex()
        controller.updateWorkex();
        // Cover displayMoreWorkEx
        controller.displayMoreWorkEx();
        controller.removeWorkEx2();
        controller.displayMoreWorkEx();
        // Cover removeWorkEx3
        controller.removeWorkEx3();
        System.Test.stopTest();
        
        // Cover handleWorkEx1
        controller.handleWorkEx1();
        // cover handleWorkEx1CurrentJob()
        controller.handleWorkEx1CurrentJob();
        
        // cover handleWorkEx2()
        controller.handleWorkEx2();
        
        // Cover handleWorkEx2CurrentJob
        controller.handleWorkEx2CurrentJob();
        // Cover handleWorkEx3()
        controller.handleWorkEx3();
        // Cover handleWorkEx3CurrentJob
        controller.handleWorkEx3CurrentJob();
        // Cover handleWorkExSP1, handleWorkExSP2, handleWorkExSP3
        controller.handleWorkExSP1();
        controller.handleWorkExSP2();
        controller.handleWorkExSP3();
        // Cover displayMoreWorkExSP
        controller.displayMoreWorkExSP();
        controller.removeWorkExSP2();
        controller.displayMoreWorkExSP();
        // Cover removeWorkExSP3()
        controller.removeWorkExSP3();
        // Cover onOccuLeave
        controller.onOccuLeave();
        // Cover onBizClick
        controller.onBizClick();
        // Cover saveBiz
        controller.saveBiz();
        // Cover handleOnChangeBizAsmt
        controller.handleOnChangeBizAsmt();
        // Cover handleOnChangeBizCsheet
        controller.handleOnChangeBizCsheet();
        // Cover onBizLeave
        controller.onBizLeave();
        // Cover onasmtTabClick
        controller.onasmtTabClick();
        // Cover handleOnChangeasmtTab
        controller.handleOnChangeasmtTab();
        // Cover saveAsmtTab
        controller.saveAsmtTab();
        // Cover onasmtTabLeave()
        controller.onasmtTabLeave();
        // Cover createNewAssessment
        controller.createNewAssessment();
        // Cover backToSFhome
        controller.backToSFhome();
        // Cover handleNOC1()
        controller.handleNOC1();
        // Cover handleNOC2
        controller.handleNOC2();
        // Cover handleNOC3
        controller.handleNOC3();
        // Cover handleNOCSP1
        controller.handleNOCSP1();
        // Cover handleNOCSP2
        controller.handleNOCSP2();
        // Cover handleNOCSP3
        controller.handleNOCSP3();
        // Cover startNewAssessment
        controller.startNewAssessment();
        controller.cSheetDetail = cSheets[0];
        controller.startNewAssessment();
        controller.cSheetDetail.Id = null;
        controller.startNewAssessment();
    }
    
    @isTest
    static void screenUtilityTest(){
        String sObjectName = 'assessment__c';
        System.Test.startTest();
        List<SelectOption> sl = AssessmentPanelScreenUtility.getPicklistValues(sObjectName, 'English_Listening__c');
        AssessmentPanelScreenUtility.setPicklistValues(sl, 'No');
        AssessmentPanelScreenUtility.setPicklistValues(sl, 'CELPIP');
        AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_Listening__c', 'TCF');
        AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_Listening__c', 'No');
        AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(System.today()+1, System.today());
        AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(Date.newInstance(2020, 07, 21), Date.newInstance(2021, 01, 19));
        //AssessmentPanelScreenUtility.checkRequiredFields(new account(), null);
        //AssessmentPanelScreenUtility.checkRequiredFields(new account(), new account());
        AssessmentPanelScreenUtility.checkRequiredFields('Married', new assessment__c());
        System.Test.stopTest();
        
    }
    
    @isTest
    static void AssessmentScoreCalculatorTest(){
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        actList[0].DOB__c = date.newInstance(1998, 05, 21);
        actList[0].Name = 'Test300';
        insert actList;
        List<Account> spActList = TestDataFactory.createAccounts(1, actList[0].Id);
        spActList[0].Name = 'Test300Sp';
        insert spActList;
        List<Account> actSp = TestDataFactory.createAccounts(1, actList[0].Id);
        insert actSP;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        oppty[0].name = 'Test213';
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        assessment__c asmt  = asmtList[0];
        asmt.French_first_language__c = true;
        asmt.French_first_language_Spouse__c = true;
        asmt.Spouse_Partner__c = spActList[0].Id;
        System.Test.startTest();
        AssessmentScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        actList[0].DOB__c = date.newInstance(2005, 05, 21);
        update actList;
        asmt.Level_of_education__c = 'Masters Degree or Professional Degree';
        asmt.Level_of_education_Spouse__c = 'Masters Degree or Professional Degree';
        asmt.Location_1__c = 'Outside Canada';
        asmt.Location_2__c = 'Outside Canada';
        asmt.Location_3__c = 'Outside Canada';
        asmt.English_Listening__c = '9';
        asmt.English_reading__c = '7.5';
        asmt.English_Writing__c = '7';
        asmt.English_speaking__c = '6';
        AssessmentScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        asmt.English_reading__c = '8';
        asmt.French_first_language__c = false;
        asmt.French_first_language_Spouse__c = false;
        asmt.Do_you_speak_English_Spouse__c = 'Yes';
        asmt.Duration_1__c = '3 months or more, but less than 6 months';
        asmt.Duration_2__c = '6 months or more, but less than 9 months';
        asmt.Duration_3__c = '6 months or more, but less than 9 months';
        asmt.Post_secondary_studies__c = 'Ph.D.';
        asmt.NOC_received__c = '0,A,B';
        
        AssessmentScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        
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
        AssessmentScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        asmt.Please_type_a_occupation_1__c = nocB.Id;
        asmt.Please_type_a_occupation_2__c = nocB.Id;
        asmt.Please_type_a_occupation_3__c = nocB.Id;
        AssessmentScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        asmt.Duration_3__c = '6 years or more';
        asmt.Duration_2__c = '6 years or more';
        asmt.Location_3__c = 'Outside Canada';
        asmt.Level_of_education__c = 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)';
        asmt.Please_type_a_occupation_3__c = nocA.Id;
        AssessmentScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        System.Test.stopTest();

    }
    
    @isTest
    static void AssessmentScoreCalculatorUtilityTest(){
        System.Test.startTest();
        AssessmentScoreCalculatorUtility.getEnglishCLB('CELPIP', 'Reading', 'Level 5');
        AssessmentScoreCalculatorUtility.getEnglishCLB('CELPIP', 'Writing', 'Level 5');
        AssessmentScoreCalculatorUtility.getEnglishCLB('CELPIP', 'Speaking', 'Level 5');
        AssessmentScoreCalculatorUtility.getEnglishCLB('CELPIP', 'Listening', 'Level 5');
        
        AssessmentScoreCalculatorUtility.getEnglishCLB('No', 'Reading', 'Intermediate (CLB 7)');
        AssessmentScoreCalculatorUtility.getEnglishCLB('No', 'Writing', 'Intermediate (CLB 7)');
        AssessmentScoreCalculatorUtility.getEnglishCLB('No', 'Speaking', 'Intermediate (CLB 7)');
        AssessmentScoreCalculatorUtility.getEnglishCLB('No', 'Listening', 'Intermediate (CLB 7)');
        
        AssessmentScoreCalculatorUtility.getFrenchCLB('TCF', 'Reading', '342-374(TCF)');
        AssessmentScoreCalculatorUtility.getFrenchCLB('TCF', 'Writing', '4-5(TCF)');
        AssessmentScoreCalculatorUtility.getFrenchCLB('TCF', 'Speaking', '4-5(TCF)');
        AssessmentScoreCalculatorUtility.getFrenchCLB('TCF', 'Listening', '331-368(TCF)');
        
        AssessmentScoreCalculatorUtility.getFrenchCLB('No', 'Reading', 'Intermediate II (CLB 7)');
        AssessmentScoreCalculatorUtility.getFrenchCLB('No', 'Writing', 'Intermediate II (CLB 7)');
        AssessmentScoreCalculatorUtility.getFrenchCLB('No', 'Speaking', 'Intermediate II (CLB 7)');
        AssessmentScoreCalculatorUtility.getFrenchCLB('No', 'Listening', 'Intermediate II (CLB 7)');
        System.Test.stopTest();
    }
    @isTest
    static void BCPNPTest()
    {
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        insert actList;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        nocList[0].name= '1111';
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        asmtList[0].Salutation_Main_Applicant__c = 'Mr.';
        asmtList[0].Personal_Information_Notes__c = null;
        actList[0].Personal_Information_Notes__c = 'abc';
        actList[0].Phone = '1234567899';
        asmtList[0].Phone_Main_Applicant__c = null;
        asmtList[0].Education_Level__c = 'Doctor Degree (PhD)';
        asmtList[0].Type_of_Salary__c = 'Hourly';
        asmtList[0].At_least_1_year_of_experience_in_Canada__c = 'Yes';
        asmtList[0].Company_Location_in_BC__c = 'Thompson-Nicola';
        asmtList[0].employer_5_full_time_employees__c = 'Yes';
        asmtList[0].employer_3_full_time_employees__c = 'Yes';
        asmtList[0].Education_Credential_Assessment__c = 'Yes';
        asmtList[0].Trade_Certification_in_Canada__c = 'Yes';
        asmtList[0].Institution_Location__c = 'Post-secondary Institution in BC';
        asmtList[0].How_did_you_hear_about_us__c = 'Facebook Groups';
        asmtList[0].Any_Specific_question_or_comment__c = 'avccc';
        asmtList[0].Education_Level__c = 'Post Degree Diploma';
        asmtList[0].Type_of_educational_institute__c = 'Public';
        asmtList[0].Country_of_studies__c = 'Canada';
        actList[0].Salutation__c = 'Mr.';
        asmtList[0].Please_type_a_occupation_1__c = nocList[0].id;
        update actList;
        insert asmtList;
        
         PageReference pageRef = Page.AssessmentPanelScreen;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        System.Test.startTest();
        BCPNPPanelScreenController controller = new BCPNPPanelScreenController();
        controller.selectedAsmtId = asmtList[0].Id;
        controller.onAsmtClick();
        account acc = new Account(name = 'test', parentId = actList[0].Id);
        acc.First_Name__c = 'test';
        acc.Last_Name__c = 'testlast';
        acc.e_mail__c = 'test@test.com';
        insert acc;
        controller.selectedAsmtId = null;
        controller.onAsmtClick();
        // Cover the backtoConsultationList
        controller.backtoConsultationList();
        // Cover onConsultationDetailsLeave
        controller.consTab = false;
        controller.onConsultationDetailsLeave();
        controller.cSheetDetail.Id = null;
        controller.onConsultationDetailsLeave();
        controller.cSheetDetail.Account__c = null;
        controller.onConsultationDetailsLeave();
        
		// Cover the setFieldValuesCDTab()
		controller.setFieldValuesCDTab();
        // Cover setrequiredFieldValuesCDTab()
        controller.setrequiredFieldValuesCDTab();
        controller.cSheetDetail.Account__c = actList[0].Id;
        controller.setrequiredFieldValuesCDTab();
        //Cover onEnTestChange()
        controller.selectedOptionEnLang = 'Main';
        controller.onEnTestChange();
        controller.selectedOptionEnLang = 'Spouse';
        controller.onEnTestChange();
        // Cover handleMaritalStatus()
        //controller.handleMaritalStatus();
        
        // Cover the handleChildren()
        controller.assessment.Number_of_children__c = '';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '1';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '2';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '3';
       // controller.handleChildren();
        controller.assessment.Number_of_children__c = '4';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '5';
        //controller.handleChildren();
        // Cover handleLevelEdu()
        //controller.handleLevelEdu();
        controller.assessment.Post_secondaries_in_canada__c = '';
        //controller.handleLevelEdu();
        // Cover handleLevelEduSp()
        //controller.handleLevelEduSp();
        controller.assessment.Post_secondaries_in_canada_Spouse__c = '';
        //controller.handleLevelEduSp();
        // Cover handleLang()
        controller.handleLang();
        controller.assessment.Do_you_speak_English__c = '';
        controller.handleLang();
        // Cover handleLangFrench()
        //controller.handleLangFrench();
        
        //Cover handleLangSpouse()
        //controller.handleLangSpouse();
        controller.assessment.Do_you_speak_English_Spouse__c = 'Yes';
        //controller.handleLangSpouse();
        
        // Cover handleLangFrenchSpouse
       // controller.handleLangFrenchSpouse();
        
        // Cover handleWorkInCanada
        //controller.handleWorkInCanada();
        controller.assessment.have_been_canada_as_temp_worker__c = '';
        controller.assessment.Have_you_received_an_LMIA__c = '';
        //controller.handleWorkInCanada();
        // Cover handleFrenchTestType()
        controller.handleFrenchTestType();
        // Cover handleFrenchTestTypeSpouse()
        //Controller.handleFrenchTestTypeSpouse();
        // Cover handleOnChangeProfile()
        controller.handleOnChangeProfile();
        // Cover handleOnChangeProfileRequired()
        controller.handleOnChangeProfileRequired();
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.mainApplicantAcc.e_mail__c = '';
        System.debug('controller.spouseAcc.Id: '+controller.spouseAcc.Id);
        controller.handleOnChangeProfileRequired();
        controller.mainApplicantAcc.Marital_Status__c = 'Legally separated';
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.e_mail__c = null;
        System.debug('main Applicant: '+controller.mainApplicantAcc);
        System.debug('Spouse :'+ controller.spouseAcc);
        controller.handleOnChangeProfileRequired();
        // Cover saveOrUpdateProfile
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = acc.Id;
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.mainApplicantAcc.e_mail__c = 'testmain@test.com';
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.Marital_Status__c = 'Legally separated';
        controller.saveOrUpdateProfile();
        controller.assessment.Id = null;
        controller.saveOrUpdateProfile();
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.spouseAcc.Id = null;
        controller.spouseAcc.DOB__c = date.newInstance(1990, 1, 23);
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = null;
        controller.assessment.Id = null;
        controller.saveOrUpdateProfile();
        controller.assessment.Consultation_Sheet__c = cSheets[0].Id;
        controller.saveOrUpdateProfile();
        controller.assessment.Id = null;
        //controller.saveOrUpdateProfile();
        System.Test.stopTest();
    }
    
    @isTest
    static void BCPNPTest1()
    {
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        actList[0].Name = 'Test151';
        actList[0].e_mail__c = 'Test151@xyz.in';
        insert actList;
        List<Account> actSp = TestDataFactory.createAccounts(1, actList[0].Id);
        actSp[0].Name = 'testSp151';
        actSp[0].e_mail__c = 'testSp151@xyz.in';
        insert actSP;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        oppty[0].Name = 'testScreen2';
        oppty[0].Number_of_Applicants__c = 1;
        oppty[0].CloseDate = system.today()+60;
        insert oppty;

        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        insert asmtList;
        
        assessment__c eeDemo = new assessment__c(First_Name_Main_Applicant__c = 'aTest1',Last_Name_Main_Applicant__c = 'TestEnd',E_mail_Main_Applicant__c = 'azaz@g.com',Currently_working_on_this_job_1__c = 'Yes',
                                                Location_1__c='In Canada',Duration_1__c = '2 year or more, but less than 3 years',Country_of_studies__c = 'Canada',Type_of_educational_institute__c = 'Public',
                                                Level_of_education__c = 'Below high school diploma',Do_you_speak_English__c = 'Yes',Do_you_speak_French__c = 'Yes',English_test_type__c = 'IELTS',English_speaking__c = '9');
        insert eeDemo;
        
        PageReference pageRef = Page.AssessmentPanelScreen;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        pageRef.getParameters().put('eeId',String.valueOf(eeDemo.Id));
        // Cover the onCSheetClick, handleConsultationDetails method
        BCPNPPanelScreenController controller = new BCPNPPanelScreenController();

        System.Test.startTest();
        controller.onProfileLeave();
        // Cover onOccuClick
        //controller.onOccuClick();
        // Cover onCSTabClick
        controller.onCSTabClick();
        // Cover onProflieClick
        controller.onProflieClick();
        
              
        // Cover updateWorkex()
       
        System.Test.stopTest();
        // Cover onasmtTabClick
        controller.onasmtTabClick();
        // Cover handleOnChangeasmtTab
        controller.handleOnChangeasmtTab();
        // Cover saveAsmtTab
        controller.saveAsmtTab();
        // Cover onasmtTabLeave()
        controller.onasmtTabLeave();
        // Cover createNewAssessment
        controller.createNewAssessment();
        // Cover backToSFhome
        controller.backToSFhome();
        // Cover handleNOC1()
        controller.handleNOC1();
        // Cover handleNOC2
        // Cover startNewAssessment
        controller.startNewAssessment();
        controller.cSheetDetail = cSheets[0];
        controller.startNewAssessment();
        controller.cSheetDetail.Id = null;
        controller.startNewAssessment();   
    }
    
    @isTest
    static void BCPNPAssessmentScoreCalculatorTest(){
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        actList[0].DOB__c = date.newInstance(1998, 05, 21);
        actList[0].Name = 'Test300';
        insert actList;
        List<Account> spActList = TestDataFactory.createAccounts(1, actList[0].Id);
        spActList[0].Name = 'Test300Sp';
        insert spActList;
        List<Account> actSp = TestDataFactory.createAccounts(1, actList[0].Id);
        insert actSP;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        oppty[0].name = 'Test213';
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        assessment__c asmt  = asmtList[0];
        asmt.French_first_language__c = true;
        asmt.French_first_language_Spouse__c = true;
        asmt.Spouse_Partner__c = spActList[0].Id;
        System.Test.startTest();
        BCPNPScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        actList[0].DOB__c = date.newInstance(2005, 05, 21);
        update actList;
        asmt.Level_of_education__c = 'Masters Degree or Professional Degree';
        asmt.Level_of_education_Spouse__c = 'Masters Degree or Professional Degree';
        asmt.Location_1__c = 'Outside Canada';
        asmt.Location_2__c = 'Outside Canada';
        asmt.Location_3__c = 'Outside Canada';
        asmt.English_Listening__c = '9';
        asmt.English_reading__c = '7.5';
        asmt.English_Writing__c = '7';
        asmt.English_speaking__c = '6';
        asmt.Education_Credential_Assessment__c = 'No';
        asmt.Trade_Certification_in_Canada__c = 'Yes';
        BCPNPScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        asmt.English_reading__c = '8';
        asmt.French_first_language__c = false;
        asmt.French_first_language_Spouse__c = false;
        asmt.Do_you_speak_English_Spouse__c = 'Yes';
        asmt.Duration_1__c = '3 months or more, but less than 6 months';
        asmt.Duration_2__c = '6 months or more, but less than 9 months';
        asmt.Duration_3__c = '6 months or more, but less than 9 months';
        asmt.Post_secondary_studies__c = 'Ph.D.';
        asmt.NOC_received__c = '0,A,B';
        asmt.Education_Credential_Assessment__c = 'Yes';
        asmt.Trade_Certification_in_Canada__c = 'No';
        
        BCPNPScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        
        Eligible_Occupation__c nocA = new Eligible_Occupation__c();
        nocA.Name = '0013';
        insert nocA;
        
        Eligible_Occupation__c nocB = new Eligible_Occupation__c();
        nocB.Name = '1212';
        insert nocB;
        
        asmt.Please_type_a_occupation_1__c = nocA.Id;
        asmt.Please_type_a_occupation_2__c = nocA.Id;
        asmt.Please_type_a_occupation_3__c = nocA.Id;
        asmt.Institution_Location__c = 'Post-secondary Institution in BC';
        asmt.Education_Credential_Assessment__c = 'Yes';
        asmt.Trade_Certification_in_Canada__c = 'Yes';
        asmt.Education_Level__c = 'Doctor Degree (PhD)';
        asmt.Directly_Related_Work_Experience__c = 'less than Year';
        asmt.Location_1__c = 'In Canada';
        asmt.Location_2__c = 'In Canada';
        asmt.Location_3__c = 'In Canada';
        BCPNPScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        asmt.Institution_Location__c = 'Post-secondary Institution in BC';
        asmt.Education_Credential_Assessment__c = 'Yes';
        asmt.Trade_Certification_in_Canada__c = 'Yes';
        asmt.Education_Level__c = 'Post Degree Diploma';
        asmt.Directly_Related_Work_Experience__c = '4 to 5 Years';
        asmt.Please_type_a_occupation_1__c = nocB.Id;
        asmt.Please_type_a_occupation_2__c = nocB.Id;
        asmt.Please_type_a_occupation_3__c = nocB.Id;
        BCPNPScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        asmt.Duration_3__c = '6 years or more';
        asmt.Duration_2__c = '6 years or more';
        asmt.Location_3__c = 'Outside Canada';
        asmt.Level_of_education__c = 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)';
        asmt.Please_type_a_occupation_3__c = nocA.Id;
        asmt.Education_Credential_Assessment__c = 'No';
        asmt.Trade_Certification_in_Canada__c = 'No';
        asmt.Education_Level__c = '3-year Diploma';
        asmt.Directly_Related_Work_Experience__c = '5+ Years';
        asmt.Have_you_done_TEF__c = 'TEF';
        asmt.Do_you_speak_English_or_French__c = 'Both';
        asmt.Company_Location_in_BC__c = 'Greater Vancouver';
        asmt.Institution_Location__c = 'Post-secondary Institution outside BC but in Canada';
        asmt.Type_of_Salary__c = 'Hourly';
        asmt.Hours_per_week__c = 0;
        asmt.Salary_Amount__c = 0;
        BCPNPScoreCalculator.calcPoints(new List<assessment__c>{asmt});
        System.Test.stopTest();

    }
    @isTest
    static void BCPNPUtilityTest()
    {
        assessment__c asmt = new assessment__c();
        BCPNPPanelScreenUtility.checkAllField(asmt);
        BCPNPPanelScreenUtility.checkHourlySalary(asmt);
        BCPNPPanelScreenUtility.checkRequiredFields(asmt);
    }
    @isTest
    static void leadAsmtCalcTest()
    {
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        insert actList;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(4, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        asmtList[0].Type__c ='Express Entry';
        asmtList[0].Marital_Status__c ='Married';
        asmtList[0].French_first_language_Spouse__c = true;
        asmtList[0].Level_of_education__c = 'Ph. D.';
        asmtList[0].experience_obtained_in_past_5_years_1__c = true;
        asmtList[1].Consultation_Sheet__c = null;
        asmtList[1].Type__c ='Express Entry';
        asmtList[1].Marital_Status__c ='Married';
        asmtList[1].French_first_language__c = true;
        asmtList[1].Level_of_education__c = 'Ph. D.';
        asmtList[1].experience_obtained_in_past_5_years_1__c = true;
        asmtList[2].Consultation_Sheet__c = null;
        asmtList[2].Type__c ='Express Entry';
        asmtList[2].Marital_Status__c ='Single/Never married';
        asmtList[2].Level_of_education__c = 'Ph. D.';
        asmtList[2].experience_obtained_in_past_5_years_1__c = true;
        asmtList[3].Consultation_Sheet__c = null;
        asmtList[3].Type__c ='Express Entry';
        asmtList[3].Marital_Status__c ='Single/Never married';
        asmtList[3].French_first_language__c = true;
        asmtList[3].Level_of_education__c = 'Ph. D.';
        asmtList[3].experience_obtained_in_past_5_years_1__c = true;
        insert asmtList;
    }
    
    @isTest
    static void OINPTest()
    {
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        insert actList;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        nocList[0].name= '1111';
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        asmtList[0].Salutation_Main_Applicant__c = 'Mr.';
        asmtList[0].Personal_Information_Notes__c = null;
        actList[0].Personal_Information_Notes__c = 'abc';
        actList[0].Phone = '1234567899';
        asmtList[0].Phone_Main_Applicant__c = null;
        asmtList[0].Education_Level__c = 'Doctor Degree (PhD)';
        asmtList[0].Type_of_Salary__c = 'Hourly';
        asmtList[0].At_least_1_year_of_experience_in_Canada__c = 'Yes';
        asmtList[0].Company_Location_in_BC__c = 'Thompson-Nicola';
        asmtList[0].employer_5_full_time_employees__c = 'Yes';
        asmtList[0].employer_3_full_time_employees__c = 'Yes';
        asmtList[0].Education_Credential_Assessment__c = 'Yes';
        asmtList[0].Trade_Certification_in_Canada__c = 'Yes';
        asmtList[0].Institution_Location__c = 'Post-secondary Institution in BC';
        asmtList[0].How_did_you_hear_about_us__c = 'Facebook Groups';
        asmtList[0].Any_Specific_question_or_comment__c = 'avccc';
        asmtList[0].Education_Level__c = 'Post Degree Diploma';
        asmtList[0].Type_of_educational_institute__c = 'Public';
        asmtList[0].Country_of_studies__c = 'Canada';
        actList[0].Salutation__c = 'Mr.';
        asmtList[0].Please_type_a_occupation_1__c = nocList[0].id;
        asmtList[0].Education_Level_OINP__c='PhD';
        asmtList[0].Field_of_Study__c = 'Engineering';
        asmtList[0].CEC_Noc_Level__c = nocList[0].id;
        asmtList[0].Do_you_have_over_12_months_of_Canadian_E__c = 'More than 12 months of cumulative, full-time or part-time equivalent';
        asmtList[0].Earnings_History__c = '$40k or more earnings in a year';
        asmtList[0].Salary_Amount_OINP__c = '$40 per hour or higher';
        asmtList[0].Company_Location_in_ON__c = 'Greater Toronto Area (GTA)';
        asmtList[0].Directly_Related_Work_Experience__c = 'Less than 1 year';
        asmtList[0].Occupation_part_OINP_Strategic_Priority__c = 'Yes';
        asmtList[0].Institution_Location_OINP__c = 'Greater Toronto Area (GTA)';
        asmtList[0].Canadian_Education_Experience__c = 'More than one Canadian credential';
        update actList;
        insert asmtList;
        
         PageReference pageRef = Page.AssessmentPanelScreen;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[0].Id));
        System.Test.startTest();
        OINPPanelScreenController controller = new OINPPanelScreenController();
        controller.selectedAsmtId = asmtList[0].Id;
        controller.onAsmtClick();
        account acc = new Account(name = 'test', parentId = actList[0].Id);
        acc.First_Name__c = 'test';
        acc.Last_Name__c = 'testlast';
        acc.e_mail__c = 'test@test.com';
        insert acc;
        controller.selectedAsmtId = null;
        controller.onAsmtClick();
        // Cover the backtoConsultationList
        controller.backtoConsultationList();
        // Cover onConsultationDetailsLeave
        controller.consTab = false;
        controller.onConsultationDetailsLeave();
        controller.cSheetDetail.Id = null;
        controller.onConsultationDetailsLeave();
        controller.cSheetDetail.Account__c = null;
        controller.onConsultationDetailsLeave();
        
		// Cover the setFieldValuesCDTab()
		controller.setFieldValuesCDTab();
        // Cover setrequiredFieldValuesCDTab()
        controller.setrequiredFieldValuesCDTab();
        controller.cSheetDetail.Account__c = actList[0].Id;
        controller.setrequiredFieldValuesCDTab();
        //Cover onEnTestChange()
        controller.selectedOptionEnLang = 'Main';
        controller.onEnTestChange();
        controller.selectedOptionEnLang = 'Spouse';
        controller.onEnTestChange();
        // Cover handleMaritalStatus()
        //controller.handleMaritalStatus();
        
        // Cover the handleChildren()
        controller.assessment.Number_of_children__c = '';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '1';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '2';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '3';
       // controller.handleChildren();
        controller.assessment.Number_of_children__c = '4';
        //controller.handleChildren();
        controller.assessment.Number_of_children__c = '5';
        //controller.handleChildren();
        // Cover handleLevelEdu()
        //controller.handleLevelEdu();
        controller.assessment.Post_secondaries_in_canada__c = '';
        //controller.handleLevelEdu();
        // Cover handleLevelEduSp()
        //controller.handleLevelEduSp();
        controller.assessment.Post_secondaries_in_canada_Spouse__c = '';
        //controller.handleLevelEduSp();
        // Cover handleLang()
        controller.handleLang();
        controller.assessment.Do_you_speak_English__c = '';
        
        controller.handleLang();
        // Cover handleLangFrench()
        //controller.handleLangFrench();
        
        //Cover handleLangSpouse()
        //controller.handleLangSpouse();
        controller.assessment.Do_you_speak_English_Spouse__c = 'Yes';
        //controller.handleLangSpouse();
        
        // Cover handleLangFrenchSpouse
       // controller.handleLangFrenchSpouse();
        
        // Cover handleWorkInCanada
        //controller.handleWorkInCanada();
        controller.assessment.have_been_canada_as_temp_worker__c = '';
        controller.assessment.Have_you_received_an_LMIA__c = '';
        //controller.handleWorkInCanada();
        // Cover handleFrenchTestType()
        controller.handleFrenchTestType();
        // Cover handleFrenchTestTypeSpouse()
        //Controller.handleFrenchTestTypeSpouse();
        // Cover handleOnChangeProfile()
        controller.handleOnChangeProfile();
        // Cover handleOnChangeProfileRequired()
        controller.handleOnChangeProfileRequired();
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.mainApplicantAcc.e_mail__c = '';
        System.debug('controller.spouseAcc.Id: '+controller.spouseAcc.Id);
        controller.handleOnChangeProfileRequired();
        controller.mainApplicantAcc.Marital_Status__c = 'Legally separated';
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.e_mail__c = null;
        System.debug('main Applicant: '+controller.mainApplicantAcc);
        System.debug('Spouse :'+ controller.spouseAcc);
        controller.handleOnChangeProfileRequired();
        // Cover saveOrUpdateProfile
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = acc.Id;
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.mainApplicantAcc.e_mail__c = 'testmain@test.com';
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = null;
        controller.mainApplicantAcc.Marital_Status__c = 'Legally separated';
        controller.saveOrUpdateProfile();
        controller.assessment.Id = null;
        controller.saveOrUpdateProfile();
        controller.mainApplicantAcc.Marital_Status__c = 'Married';
        controller.spouseAcc.Id = null;
        controller.spouseAcc.DOB__c = date.newInstance(1990, 1, 23);
        controller.saveOrUpdateProfile();
        controller.spouseAcc.Id = null;
        controller.assessment.Id = null;
        controller.saveOrUpdateProfile();
        controller.assessment.Consultation_Sheet__c = cSheets[0].Id;
        controller.saveOrUpdateProfile();
        controller.assessment.Id = null;
        //controller.saveOrUpdateProfile();
        System.Test.stopTest();
    }
    
    @isTest
    static void OINPTest1()
    {
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        actList[0].Name = 'Test151';
        actList[0].e_mail__c = 'Test151@xyz.in';
        insert actList;
        //List<Account> actSp = TestDataFactory.createAccounts(1, actList[0].Id);
        //actSp[0].Name = 'testSp151';
        //actSp[0].e_mail__c = 'testSp151@xyz.in';
        //insert actSP;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        oppty[0].Name = 'testScreen3';
        oppty[0].Number_of_Applicants__c = 1;
        oppty[0].CloseDate = system.today()+60;
        insert oppty;

        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(1);
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(3, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        insert asmtList;
        
        assessment__c eeDemo = new assessment__c(First_Name_Main_Applicant__c = 'aTest1',Last_Name_Main_Applicant__c = 'TestEnd',E_mail_Main_Applicant__c = 'azaz@g.com',Currently_working_on_this_job_1__c = 'Yes',
                                                Location_1__c='In Canada',Duration_1__c = '2 year or more, but less than 3 years',Country_of_studies__c = 'Canada',Type_of_educational_institute__c = 'Public',
                                                Level_of_education__c = 'Below high school diploma',Do_you_speak_English__c = 'Yes',Do_you_speak_French__c = 'Yes',English_test_type__c = 'IELTS',English_speaking__c = '9');
        insert eeDemo;
        
        PageReference pageRef = Page.AssessmentPanelScreen;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        pageRef.getParameters().put('eeId',String.valueOf(eeDemo.Id));
        // Cover the onCSheetClick, handleConsultationDetails method
        OINPPanelScreenController controller = new OINPPanelScreenController();

        System.Test.startTest();
        controller.onProfileLeave();
        // Cover onOccuClick
        //controller.onOccuClick();
        // Cover onCSTabClick
        controller.onCSTabClick();
        // Cover onProflieClick
        controller.onProflieClick();
        
              
        // Cover updateWorkex()
       
        System.Test.stopTest();
        // Cover onasmtTabClick
        controller.onasmtTabClick();
        // Cover handleOnChangeasmtTab
        controller.handleOnChangeasmtTab();
        // Cover saveAsmtTab
        controller.saveAsmtTab();
        // Cover onasmtTabLeave()
        controller.onasmtTabLeave();
        // Cover createNewAssessment
        controller.createNewAssessment();
        // Cover backToSFhome
        controller.backToSFhome();
        // Cover handleNOC1()
        controller.handleNOC1();
        // Cover handleNOC2
        controller.handleNOC2();
        // Cover startNewAssessment
        controller.startNewAssessment();
        controller.cSheetDetail = cSheets[0];
        controller.startNewAssessment();
        controller.cSheetDetail.Id = null;
        controller.startNewAssessment();   
    }
    @isTest
    static void OINPUtilityTest()
    {
        assessment__c asmt = new assessment__c();
        OINPPanelScreenUtility.checkAllField(asmt);
        OINPPanelScreenUtility.checkRequiredFields(asmt);
    }
    
     @isTest
    static void OINPScoreCalculatorTest()
    {
        List<Account> actList = TestDataFactory.createAccounts(1, null);
        insert actList;
        List<Opportunity> oppty = TestDataFactory.createOppty(1, actList[0].Id);
        insert oppty;
        List<Consultation_Sheet__c> cSheets = TestDataFactory.createCSheets(1, actList[0].Id, oppty[0].Id);
        insert cSheets;
        List<Eligible_Occupation__c> nocList = TestDataFactory.createNOCs(2);
        nocList[0].Name ='0014'; 
        nocList[1].Name ='0015';
        insert nocList;
        List<assessment__c> asmtList = TestDataFactory.createAsmts(5, actList[0].Id, cSheets[0].Id, nocList[0].Id);
        asmtList[0].Consultation_Sheet__c = null;
        asmtList[0].Type__c ='Express Entry';
        asmtList[0].Please_type_a_occupation_1__c =nocList[0].Id;
        asmtList[0].CEC_Noc_Level__c = nocList[1].Id;
        asmtList[0].Do_you_speak_English_or_French__c = 'Both';
        asmtList[0].Type_of_educational_institute__c = 'Public';
        asmtList[0].Canadian_Education_Experience__c = 'More than one Canadian credential';
        asmtList[0].Field_of_Study__c = 'Engineering';
        asmtList[0].Education_Level_OINP__c = 'PhD';
        asmtList[0].Do_you_have_over_12_months_of_Canadian_E__c = 'More than 12 months of cumulative, full-time or part-time equivalent';
        asmtList[0].Salary_Amount_OINP__c = '$40 per hour or higher';
        asmtList[0].Earnings_History__c = '$40k or more earnings in a year';
        asmtList[0].Company_Location_in_ON__c = 'Greater Toronto Area (GTA)';
        asmtList[0].Institution_Location_OINP__c = 'Greater Toronto Area (GTA)';
        
        asmtList[1].Field_of_Study__c = 'Physical and Chemical sciences';
        asmtList[1].Canadian_Education_Experience__c = 'One Canadian credential';
        asmtList[1].Education_Level_OINP__c = 'Masters';
        asmtList[1].Salary_Amount_OINP__c = '$20 to $39.99 per hour';
        asmtList[1].Company_Location_in_ON__c = 'Outside Greater Toronto Area (GTA)';
        asmtList[1].Institution_Location_OINP__c = 'Outside Greater Toronto Area (GTA)';
        
        asmtList[2].Field_of_Study__c = 'Mathematics and related studies';
        asmtList[2].Education_Level_OINP__c = 'Bachelors or equivalent';
        asmtList[2].Salary_Amount_OINP__c = 'Less than $20 per hour';
        
        asmtList[3].Field_of_Study__c = 'Business and Related studies';
        asmtList[3].Education_Level_OINP__c = 'College Diploma or Certificate for at least 1 year';
        
        asmtList[4].Field_of_Study__c = 'Arts';
        asmtList[3].Education_Level_OINP__c = 'College Diploma or Certificate for at least 2 years or more';
        
        insert asmtList;
        
        OINPScoreCalculator.calcPoints(asmtList);
        
    }
    
     @isTest
    static void BCPNPUtilityTest1()
    {
        assessment__c asmt = new assessment__c();
        asmt.Salary_Amount__c = 0;
        asmt.Hours_per_week__c = 41;
        BCPNPPanelScreenUtility.checkAllField(asmt);
        BCPNPPanelScreenUtility.checkHourlySalary(asmt);
        BCPNPPanelScreenUtility.checkRequiredFields(asmt);
    }
    
}