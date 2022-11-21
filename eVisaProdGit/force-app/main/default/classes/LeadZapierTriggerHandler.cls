public class LeadZapierTriggerHandler {
    
    public static void ConvertLeadFromZapier(List<Lead> listOfLeads){
        Savepoint sp = Database.setSavepoint();
        try{
            // Start of - Lead for loop
            for(Lead ld : listOfLeads){
                // Start of - if the consultation is paid & lead is not converted
                if(ld.IsPaid_Acuity__c && !(ld.IsConverted)){
                    LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true Limit 1];
                    // Custom Lead Convert
                    Database.LeadConvert Leadconvert = new Database.LeadConvert();
                    Leadconvert.setLeadId(ld.Id);
                    Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
                    Database.LeadConvertResult lcr = Database.convertLead(Leadconvert);
                    
                    // Setting main applicant account
                    Account main = new Account();
                    Account spouse = new Account();
                    main.Id = lcr.getAccountId();
                    main.Is_Main_Applicant__c = true;
                    
                    if(String.isNotBlank(ld.Email_Spouse__c)){
                        //Pulkit change Start
                        main.Spouse_e_mail__c = ld.Email_Spouse__c;
                        main.Spouse_First_Name__c = ld?.Spouse_First_Name__c;
                        main.Spouse_Last_Name__c = ld?.Spouse_Last_Name__c;
                        /*
                         * Pulkit Commented
                        List<Account> findSpList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, 
                                                    e_mail__c, Phone, ParentId From Account Where e_mail__c = :ld.Email_Spouse__c LIMIT 1];
                        
                        if(!findSpList.isEmpty()){
                            if(isIdleAccount(findSpList.get(0))){
                                spouse.Id = findSpList.get(0).Id;
                                spouse.First_Name__c = ld.Spouse_First_Name__c;
                                spouse.Last_Name__c = ld.Spouse_Last_Name__c;
                                spouse.DOB__c = ld.Spouse_DOB__c;
                                spouse.e_mail__c = ld.Email_Spouse__c;
                                spouse.ParentId = lcr.getAccountId(); // Link spouse account with main applicant
                            }
                        }
                        else{
                            // Setting up the spouse account values if present
                            spouse.First_Name__c = ld.Spouse_First_Name__c;
                            spouse.Last_Name__c = ld.Spouse_Last_Name__c;
                            spouse.Name = spouse.First_Name__c+' '+spouse.Last_Name__c;
                            spouse.DOB__c = ld.Spouse_DOB__c;
                            spouse.e_mail__c = ld.Email_Spouse__c;
                            spouse.ParentId = lcr.getAccountId(); // Link spouse account with main applicant
                        }*/
                        //Pulkit change End
                    }
                    
                    update main;
                    /* Pulkit Change start
                     * Pulkit Commented
                    if(String.isNotBlank(spouse.First_Name__c) && String.isNotBlank(spouse.Last_Name__c) && String.isNotBlank(spouse.e_mail__c) 
                       && spouse.DOB__c != null && String.isNotBlank(spouse.ParentId)){
                           if(String.isNotBlank(spouse.Id)){
                               update spouse;
                           }
                           
                           else{
                               insert spouse;
                           }
                           
                       }
                    //Pulkit Change End
                    */
                    // Creating consultation sheet
                    Consultation_Sheet__c cs = new Consultation_Sheet__c();
                    cs.Account__c = lcr.getAccountId();
                    cs.Opportunity__c = lcr.getOpportunityId();
                    
                    insert cs;
                    
                    // Linking  assessments to the Account
                    List<assessment__c> recentasmt = [Select Id, CreatedDate From assessment__c WHERE Lead__c = :ld.Id Order By CreatedDate DESC];
                    // Assessments are present on lead 
                    if(!recentasmt.isEmpty()){
                        Integer counter =  0;
                        for(assessment__c asmt : recentasmt){
                            if(counter == 0){
                                asmt.Consultation_Sheet__c = cs.Id; // Linking of most recent assessment to the consultation sheet
                            }
                            asmt.Lead__c = null; 
                            asmt.Account__c = main.Id; // link assessment to main applicant account
                            if(String.isNotBlank(spouse.Id)){
                                asmt.Spouse_Partner__c = spouse.Id; // link assessment to spouse account
                            }
                            counter++;
                        }
                        
                        update recentasmt;

                    } // End of - Assessments are present on lead
                                        
                } // End of - if the consultation is paid & lead is not converted
                
            } // End of - Lead for loop
        }
        catch(Exception ex){
            Database.rollback(sp);
            System.debug('Exception Occured: '+ ex.getMessage() +' in line number :'+ex.getLineNumber());
        }
        
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