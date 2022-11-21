public class AccountZapierTriggerHandler {
    // Boolean variable to handle Recursive trigger
    public static boolean isFirstRun = true;
    public static void CreateConsultationFromZapier(List<Account> listOfAccts){
        if(isFirstRun){
            Savepoint sp = Database.setSavepoint();
            try{
                AccountZapierTriggerHandler.isFirstRun = false;
                // start of - for loop
                for(Account acc : listOfAccts){
                    // start  of - if consultation is paid from zapier
                    if(acc.IsPaid_Acuity__c){
                        
                        // create an Opportunity
                        Opportunity Opp = new Opportunity();
                        Opp.Name = acc.Name + 'Opportunity';
                        Opp.AccountId = acc.Id;
                        Opp.CloseDate = System.today() + 30;
                        Opp.StageName = 'New';
                        insert Opp;
                        
                        // Create a consultation
                        Consultation_Sheet__c cs = new Consultation_Sheet__c();
                        cs.Account__c = acc.Id;
                        cs.Opportunity__c = Opp.Id;
                        insert cs;
                        
                        // update the account
                        Account main = new Account();
                        main.Id = acc.Id;
                        main.Is_Main_Applicant__c = true; // set the Is Main Applicant? to true
                        main.IsPaid_Acuity__c = false; // set Is paid to false 
                        
                        update main;
                    } // end  of - if consultation is paid from zapier
                } // end of - for loop
            }
            catch(Exception ex){
                Database.rollback(sp);
                System.debug('Exception Occured: '+ex.getMessage()+' in line number: '+ex.getLineNumber());
            }
        }
        
    }
    
}