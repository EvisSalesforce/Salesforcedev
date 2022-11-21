public class LeadConvertViewController {
    public String leadId;
    
    public LeadConvertViewController(ApexPages.StandardController stdController){
        //leadId = ApexPages.CurrentPage().getParameters().get('id');
        leadId = stdController.getId();
    }
    
    public PageReference convertLead(){
        Savepoint sp = Database.setSavepoint();
        if(String.isNotBlank(leadId)){
            List<Lead> ldList = [Select Id, Salutation, FirstName, LastName, Email, Spouse_First_Name__c,
                                 Spouse_Last_Name__c, Email_Spouse__c, Spouse_DOB__c From Lead Where Id = :leadId AND IsConverted=false LIMIT 1];
            LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true Limit 1];
            // Custom Lead Convert
            Database.LeadConvert Leadconvert = new Database.LeadConvert();
            Leadconvert.setLeadId(leadId);
            Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
            try{
                Database.LeadConvertResult lcr = Database.convertLead(Leadconvert);
                Account main = new Account();
                main.Id = lcr.getAccountId();
                main.First_Name__c = ldList.get(0).FirstName;
                main.Last_Name__c = ldList.get(0).LastName;
                // search for spouse
                Account spouse = new Account();
                if(String.isNotBlank(ldlist.get(0).Email_Spouse__c)){
                    //Pulkit change start
                    main.Spouse_e_mail__c = ldList.get(0).Email_Spouse__c;
                    main.Spouse_First_Name__c = ldList.get(0)?.Spouse_First_Name__c;
                    main.Spouse_Last_Name__c = ldList.get(0)?.Spouse_Last_Name__c;
                    /*
                     * Pulkit Commented the code
                    List<Account> findSpList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, 
                                                e_mail__c, Phone, ParentId From Account Where e_mail__c = :ldlist.get(0).Email_Spouse__c LIMIT 1];
                    if(!findSpList.isEmpty()){
                        if(isIdleAccount(findSpList.get(0))){
                            spouse.Id = findSpList.get(0).Id;
                            spouse.First_Name__c = ldList.get(0).Spouse_First_Name__c;
                            spouse.Last_Name__c = ldList.get(0).Spouse_Last_Name__c;
                            spouse.DOB__c = ldList.get(0).Spouse_DOB__c;
                            spouse.e_mail__c = ldList.get(0).Email_Spouse__c;
                            spouse.ParentId = lcr.getAccountId(); // Link spouse account with main applicant
                        }
                    }
                    else{
                        // Setting up the spouse account values if present
                        spouse.First_Name__c = ldList.get(0).Spouse_First_Name__c;
                        spouse.Last_Name__c = ldList.get(0).Spouse_Last_Name__c;
                        spouse.Name = spouse.First_Name__c+' '+spouse.Last_Name__c;
                        spouse.DOB__c = ldList.get(0).Spouse_DOB__c;
                        spouse.e_mail__c = ldList.get(0).Email_Spouse__c;
                        spouse.ParentId = lcr.getAccountId(); // Link spouse account with main applicant
                    }
                    */
                } // End of - search for spouse
                // Creating consultation sheet
                Consultation_Sheet__c cs = new Consultation_Sheet__c();
                cs.Account__c = lcr.getAccountId();
                cs.Opportunity__c = lcr.getOpportunityId();
                
                update main;
                //Pulkit Change Start
                /*
                 * Pulkit Commented The Code
                 * if(String.isNotBlank(spouse.First_Name__c) && String.isNotBlank(spouse.Last_Name__c) && String.isNotBlank(spouse.e_mail__c) 
                   && spouse.DOB__c != null && String.isNotBlank(spouse.ParentId)){
                       
                       if(String.isNotBlank(spouse.Id)){
                           update spouse;
                       }
                       else{
                           insert spouse;
                       }
                       
                       
                   }*/
                //Pulkit Change end
                insert cs;
                
                // Linking  assessments to the Account
                List<assessment__c> recentasmt = [Select Id, CreatedDate From assessment__c WHERE Lead__c = :ldList.get(0).Id Order By CreatedDate DESC];
                // Assessments are present on lead 
                if(!recentasmt.isEmpty()){
                    Integer counter =  0;
                    for(assessment__c asmt : recentasmt){
                        if(counter == 0){
                            asmt.Consultation_Sheet__c = cs.Id; // Linking of most recent assessment to the consultation sheet
                        }
                        asmt.Lead__c = null; 
                        asmt.Account__c = lcr.getAccountId(); // link assessment to main applicant account
                        if(String.isNotBlank(spouse.Id)){
                            asmt.Spouse_Partner__c = spouse.Id; // link assessment to spouse account
                        }
                        counter++;
                    }
                    
                    update recentasmt;
                    
                }
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Lead Converted Successfully'));
                String sServerName = ApexPages.currentPage().getHeaders().get('Host');
                sServerName = 'https://'+sServerName+'/';
                PageReference retPage = new PageReference(sServerName+lcr.getAccountId()); 
                retPage.setRedirect(true);
                
                return retPage;
            }
            Catch(Exception ex){
                Database.rollback(sp);
                System.debug('Exception Occured: '+ ex.getMessage());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
                return null;
            }
        }
        return null;
    }
    
    public static Boolean isIdleAccount(Account spouse){
        Boolean isIdle = false;
        if(spouse == null){
            return isIdle;
        }
        List<Account> relatedAccs;
        relatedAccs = [Select Id from Account Where ParentId =: spouse.Id LIMIT 1];
        
        if(String.isBlank(spouse.ParentId) && relatedAccs.isEmpty()){
            isIdle = true;
        }
        return isIdle;
    }
}