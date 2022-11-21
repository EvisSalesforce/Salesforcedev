public with sharing class OpportunityTriggerHandler extends TriggerHandler {
private List<Opportunity> newOppList;
//private List<Opportunity> oldOppList;
private Map<Id, Opportunity> newOppMap;
private Map<Id, Opportunity> oldOppMap;


public OpportunityTriggerHandler() {
	this.newOppList = (List<Opportunity>) Trigger.new;
	this.newOppMap = (Map<Id, Opportunity>) Trigger.newMap;
	this.oldOppMap = (Map<Id, Opportunity>) Trigger.oldMap;
	//this.oldOppList = (List<Opportunity>) Trigger.old;
}




protected override void beforeUpdate(){
	for(Opportunity opportunity:newOppMap.values()) {
		if(oldOppMap.get(opportunity.Id).Amount2__c!=opportunity.Amount2__c) {
			
			List <OpportunityLineItem> tprod = new List<OpportunityLineItem>([SELECT Name, Id, ProductCode FROM OpportunityLineItem WHERE OpportunityId = :newOppMap.keySet()]);//.ProductCode;
				if(tprod.size() > 0) {
					if(opportunity.Name.contains('-')) {
						opportunity.Name = opportunity.Name.SubStringBefore('-');
						//opportunity.Name = opportunity.Name+'-'+tprod;
					}
					
						//opportunity.Name = opportunity.Name+'-'+tprod;         //newName;
					
                    String nName = '';
					for (OpportunityLineItem tp : tprod) {
                        nName += '-'+tp.ProductCode;
					}
                    opportunity.Name = opportunity.Name + nName;
                    //System.debug('nName : '+nName);


				}
                else {
                   opportunity.Name = opportunity.Name.SubStringBefore('-'); 
                }
		}
	}
}

}