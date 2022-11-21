@RestResource(urlMapping='/ConsultationRestService/*')
global class ConsultationRestService {
    @HttpPost
    global static void createConsultation(){
        String email = '';
        RestResponse response = RestContext.response;
        Savepoint sp = Database.setSavepoint();
        try{
            ConsultationJSONParse csp = (ConsultationJSONParse) JSON.deserialize(
                RestContext.request.requestBody.toString(),
                ConsultationJSONParse.class
            );
            // if Email is not empty
            if(String.isNotBlank(csp.Email)){
                email = csp.Email;
                List<Lead> ldList = [Select Id, Salutation, FirstName, LastName, Email, Spouse_First_Name__c,
                                     Spouse_Last_Name__c, Email_Spouse__c, Spouse_DOB__c From Lead Where Email = :email AND IsConverted=false LIMIT 1];
                // Lead is present in System
                if(!ldList.isEmpty()){
                    LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true Limit 1];
                    // Custom Lead Convert
                    Database.LeadConvert Leadconvert = new Database.LeadConvert();
                    Leadconvert.setLeadId(ldList.get(0).Id);
                    Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
                    Database.LeadConvertResult lcr = Database.convertLead(Leadconvert);
                    Account main = new Account();
                    Account spouse = new Account();
                    // setting up main applicant account values
                    main.Id = lcr.getAccountId();
                    main.Is_Main_Applicant__c = true; // set the Is Main Applicant? to true
                    if(String.isNotBlank(csp.First_Name)){
                        main.First_Name__c = csp.First_Name;
                    }
                    if(String.isNotBlank(csp.Last_Name)){
                        main.Last_Name__c = csp.Last_Name;
                    }
                    if(String.isNotBlank(csp.Phone)){
                        main.Phone = csp.Phone;
                    }
                    if(String.isNotBlank(ldlist.get(0).Email_Spouse__c)){
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
                    }
                    
                    // Creating consultation sheet
                    Consultation_Sheet__c cs = new Consultation_Sheet__c();
                    cs.Account__c = lcr.getAccountId();
                    cs.Opportunity__c = lcr.getOpportunityId();
                    
                    update main;
                    if(String.isNotBlank(spouse.First_Name__c) && String.isNotBlank(spouse.Last_Name__c) && String.isNotBlank(spouse.e_mail__c) 
                       && spouse.DOB__c != null && String.isNotBlank(spouse.ParentId)){
                           
                           if(String.isNotBlank(spouse.Id)){
                               update spouse;
                           }
                           else{
                               insert spouse;
                           }
                           
                       }
                    
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
                            asmt.Account__c = main.Id; // link assessment to main applicant account
                            if(String.isNotBlank(spouse.Id)){
                                asmt.Spouse_Partner__c = spouse.Id; // link assessment to spouse account
                            }
                            counter++;
                        }
                        
                        update recentasmt;
                        
                        response.statusCode = 201;
                        response.responseBody = Blob.valueOf('Consultation Sheet created with Id: '+cs.Id);
                    } // End of - Assessments are present on lead
                    
                    
                } // End of - Lead is present in System
                
                // Lead is not present in system
                else{
                    List<Account> accList = [Select Id, Name From Account WHERE e_mail__c = :email LIMIT 1];
                    
                    // If Account is present
                    if(!accList.isEmpty()){
                        // Setting up the Account values
                        Account main = new Account();
                        main.Id = accList.get(0).Id;
                        main.Is_Main_Applicant__c = true; // set the Is Main Applicant? to true
                        if(String.isNotBlank(csp.First_Name)){
                            main.First_Name__c = csp.First_Name;
                        }
                        if(String.isNotBlank(csp.Last_Name)){
                            main.Last_Name__c = csp.Last_Name;
                        }
                        if(String.isNotBlank(csp.Phone)){
                            main.Phone = csp.Phone;
                        }
                        update main;
                        
                        Opportunity Opp = new Opportunity();
                        Opp.Name = accList.get(0).Name + 'Opportunity';
                        Opp.AccountId = accList.get(0).Id;
                        Opp.CloseDate = System.today() + 30;
                        Opp.StageName = 'New';
                        insert Opp;
                        
                        Consultation_Sheet__c cs = new Consultation_Sheet__c();
                        cs.Account__c = accList.get(0).Id;
                        cs.Opportunity__c = Opp.Id;
                        insert cs;
                        response.statusCode = 201;
                        response.responseBody = Blob.valueOf('Consultation Sheet created with Id: '+cs.Id);
                        
                        
                    } //End of - If Account is present
                    
                    // If Account is not present in system
                    else{
                        // creating new account
                        Account main = new Account();
                        main.Is_Main_Applicant__c = true; // set the Is Main Applicant? to true
                        if(String.isNotBlank(csp.First_Name)){
                            main.First_Name__c = csp.First_Name;
                        }
                        if(String.isNotBlank(csp.Last_Name)){
                            main.Last_Name__c = csp.Last_Name;
                        }
                        if(String.isNotBlank(csp.Phone)){
                            main.Phone = csp.Phone;
                        }
                        main.e_mail__c = csp.Email;
                        main.Name = main.First_Name__c+' '+main.Last_Name__c;
                        
                        insert main;
                        Opportunity Opp = new Opportunity();
                        Opp.Name = main.Name + 'Opportunity';
                        Opp.AccountId = main.Id;
                        Opp.CloseDate = System.today() + 30;
                        Opp.StageName = 'New';
                        insert Opp;
                        
                        Consultation_Sheet__c cs = new Consultation_Sheet__c();
                        cs.Account__c = main.Id;
                        cs.Opportunity__c = Opp.Id;
                        insert cs;
                        response.statusCode = 201;
                        response.responseBody = Blob.valueOf('Consultation Sheet created with Id: '+cs.Id);
                        
                        
                    } // End of -If Account is not present in system
                    
                } // End of -Lead is not present in system
                
            } // End of - if Email is not empty
        }
        catch(DmlException ex){
            Database.rollback(sp);
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(ex.getMessage());
        }
        catch(JSONException ex){
            Database.rollback(sp);
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(ex.getMessage());
        }
        catch(System.QueryException ex){
            Database.rollback(sp);
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(ex.getMessage());
        }
        catch(exception ex){
            Database.rollback(sp);
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(ex.getMessage());
        }
        
    }
    
    global static Boolean isIdleAccount(Account spouse){
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