@isTest
public class AssessmentRedirectionPageControllerTest {
    
    @isTest
    static void test1()
    {
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
        
        PageReference pageRef = Page.AssessmentRedirectionPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        pageRef.getparameters().put('origin','pnptab');
        AssessmentRedirectionPageController controller = new AssessmentRedirectionPageController();
        controller.selectedassessment = 'Express Entry';
        controller.backToSFhome();
        controller.createAssessment();
        controller.selectedassessment = 'BCPNP';
        controller.createAssessment();
                
    }
    
     @isTest
    static void test2()
    {
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
        
        PageReference pageRef = Page.AssessmentRedirectionPage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('accountId', String.valueOf(actList[0].Id));
        pageRef.getParameters().put('openCsId', String.valueOf(cSheets[0].Id));
        pageRef.getParameters().put('asId', String.valueOf(asmtList[1].Id));
        pageRef.getparameters().put('origin','OINPbtn');
        AssessmentRedirectionPageController controller = new AssessmentRedirectionPageController();
        controller.selectedassessment = 'OINP';
        controller.createAssessment();
                
    }

}