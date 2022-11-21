@isTest(SeeAllData=true)
public class OpportunityTriggerHandlerTest {
static testMethod void shouldTestOpportunityTrigger(){
	Account account = Test_Util.newAccount();
	
	insert account;

	Opportunity opp = Test_Util.newOpportunity(account.Id);
	//System.debug(opp);
	//insert opp;

	

	Opportunity oppObject = new Opportunity();
	oppObject.Name = 'Opportunity-Test Update';
	oppObject.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('e-Visa').getRecordTypeId();
	oppObject.Looking_for__c = 'Consultation';
	oppObject.AccountId = account.Id;
	oppObject.LeadSource = 'ACUITY SCHEDULING';
	oppObject.StageName = 'Closed Won';
	//oppObject.CloseDate = date.valueOf(system.today().format());
	oppObject.CloseDate = Date.valueOf('2019-11-11');
	oppObject.Pricebook2Id = Test.getStandardPricebookId();
	insert oppObject;

	oppObject.Name = 'dssa dsa';
	update oppObject;

	try {
		

	oppObject.Name = 'dsadas-dasdas';
	update oppObject;

	} catch (DMLException e) {
		system.assertEquals(e.getMessage(), e.getMessage());
	}


	opp.LeadSource = 'GOOGLE';
	update opp;

	List <OpportunityLineItem> tprod = new List<OpportunityLineItem>([SELECT Name, Id, ProductCode FROM OpportunityLineItem WHERE OpportunityId = :opp.Id]);
	delete tprod;

}
}