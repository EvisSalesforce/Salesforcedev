@RestResource(urlMapping='/AssessmentRestService/*')
global class AssessmentRestService {
    @HttpPost
    global static void createAssessment() {
        String email = '';
        String accountId = '';
        String leadId = '';
        RestResponse response = RestContext.response;
        Savepoint sp = Database.setSavepoint();
        try{
            
            //
            String assessmentType = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1);
            System.debug('->'+assessmentType);
            //
            if('BCPNP'.equalsIgnoreCase(assessmentType))
            {
                BCPNPParser asp = (BCPNPParser) JSON.deserialize(RestContext.request.requestBody.toString(),BCPNPParser.class);
                System.debug('JSON: '+JSON.serializePretty(asp));
                if(String.isNotBlank(asp.email))
                {
                    email = asp.email;
                    List<Account> accList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, e_mail__c, Phone, ParentId From Account Where e_mail__c = :email LIMIT 1];
                    if(!accList.isEmpty()){
                        Account main = new Account();
                        // Assigning main applicant values
                        main.Id = accList.get(0).Id;
                        //Pulkit change
                        response = createBCPNPAssessmentHelper(asp, main.Id, 'Account', response);
                        if(response.statusCode != 201){
                            Database.rollback(sp);
                        }
                    }// End of - If Account is present in Salesforce
                    
                    // If Account is not present then check for Lead
                    else if(accList.isEmpty()){
                        List<Lead> leadlist = [Select Id From Lead Where Email = :email AND isConverted = false];
                        Lead ld = new Lead();
                        if(!leadlist.isEmpty()){
                            ld.Id = leadlist.get(0).Id;
                        }
                        // If lead is not present in salesforce
                        else{
                            // Setting up User value for responsible field of Lead
                            List<User> leadResponsible = [Select Id From User Where Name = 'Admin Team'];
                            if(!leadResponsible.isEmpty()){
                                ld.Responsible__c = leadResponsible.get(0).Id;
                            }
                            //Default Field Values
                            ld.LeadSource = 'FREE ASSESSMENT';
                            ld.Territory__c = 'Vancouver';
                            
                            if(asp.job_offer != null && !asp.job_offer.isEmpty())
                            {
                                if(String.isNotBlank(asp.job_offer[0].are_you_in_canada)){
                                    ld.Client_is_in_Canada__c = asp.job_offer[0].are_you_in_canada;
                                } 
                            }                            
                            if(String.isNotBlank(asp.preferred_language)){
                                //ld.Prefered_Language__c = asp.preferred_language == 'Brazilian' ? 'Portuguese' : 'English';
                                if(asp.preferred_language == 'Portuguese')
                                {
                                    ld.Prefered_Language__c = 'Portuguese';
                                }
                                else if(asp.preferred_language == 'Farsi')
                                {
                                    ld.Prefered_Language__c = 'Farsi';
                                }
                                else if(asp.preferred_language == 'Spanish')
                                {
                                    ld.Prefered_Language__c = 'Spanish';
                                }
                                else
                                {
                                    ld.Prefered_Language__c = 'English';
                                }
                            }
                            //End of - Default Field Values
                            if(String.isNotBlank(asp.first_name)){
                                ld.FirstName = asp.first_name;
                            }
                            if(String.isNotBlank(asp.last_name)){
                                ld.LastName = asp.last_name;
                            }
                            if(String.isNotBlank(asp.email)){
                                ld.Email = asp.email;
                            }
                            ld.Company = ld.First_Name__c + ' ' + ld.LastName;
                        }
                        if(ld.id == null){
                            insert ld;
                        }
                        response = createBCPNPAssessmentHelper(asp, ld.Id, 'Lead', response);
                        if(response.statusCode != 201){
                            Database.rollback(sp);
                        }             
                    }
                }
            }
            else if('OINP'.equalsIgnoreCase(assessmentType))
            {
                 OINPParser asp = (OINPParser) JSON.deserialize(RestContext.request.requestBody.toString(),OINPParser.class);
                System.debug('JSON: '+JSON.serializePretty(asp));
                if(String.isNotBlank(asp.email))
                {
                    email = asp.email;
                    List<Account> accList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, e_mail__c, Phone, ParentId From Account Where e_mail__c = :email LIMIT 1];
                    if(!accList.isEmpty()){
                        Account main = new Account();
                        // Assigning main applicant values
                        main.Id = accList.get(0).Id;
                        //Pulkit change
                        response = createOINPAssessmentHelper(asp, main.Id, 'Account', response);
                        if(response.statusCode != 201){
                            Database.rollback(sp);
                        }
                    }// End of - If Account is present in Salesforce
                    
                    // If Account is not present then check for Lead
                    else if(accList.isEmpty()){
                        List<Lead> leadlist = [Select Id From Lead Where Email = :email AND isConverted = false];
                        Lead ld = new Lead();
                        if(!leadlist.isEmpty()){
                            ld.Id = leadlist.get(0).Id;
                        }
                        // If lead is not present in salesforce
                        else{
                            // Setting up User value for responsible field of Lead
                            List<User> leadResponsible = [Select Id From User Where Name = 'Admin Team'];
                            if(!leadResponsible.isEmpty()){
                                ld.Responsible__c = leadResponsible.get(0).Id;
                            }
                            //Default Field Values
                            ld.LeadSource = 'FREE ASSESSMENT';
                            ld.Territory__c = 'Vancouver';
                            
                           if(asp.job_offer != null && !asp.job_offer.isEmpty())
                            {
                                if(String.isNotBlank(asp.job_offer[0].are_you_in_canada)){
                                    ld.Client_is_in_Canada__c = asp.job_offer[0].are_you_in_canada;
                                } 
                            }                            
                            if(String.isNotBlank(asp.preferred_language)){
                                //ld.Prefered_Language__c = asp.preferred_language == 'Brazilian' ? 'Portuguese' : 'English';
                                if(asp.preferred_language == 'Portuguese')
                                {
                                    ld.Prefered_Language__c = 'Portuguese';
                                }
                                else if(asp.preferred_language == 'Farsi')
                                {
                                    ld.Prefered_Language__c = 'Farsi';
                                }
                                else if(asp.preferred_language == 'Spanish')
                                {
                                    ld.Prefered_Language__c = 'Spanish';
                                }
                                else
                                {
                                    ld.Prefered_Language__c = 'English';
                                }
                            }
                            //End of - Default Field Values
                            if(String.isNotBlank(asp.first_name)){
                                ld.FirstName = asp.first_name;
                            }
                            if(String.isNotBlank(asp.last_name)){
                                ld.LastName = asp.last_name;
                            }
                            if(String.isNotBlank(asp.email)){
                                ld.Email = asp.email;
                            }
                            ld.Company = ld.First_Name__c + ' ' + ld.LastName;
                        }
                        if(ld.id == null){
                            insert ld;
                        }
                        response = createOINPAssessmentHelper(asp, ld.Id, 'Lead', response);
                        if(response.statusCode != 201){
                            Database.rollback(sp);
                        }             
                    }
                }
            }
            else
            {
                AssessmentParseJSON asp = (AssessmentParseJSON) JSON.deserialize(
                    RestContext.request.requestBody.toString(),
                    AssessmentParseJSON.class
                );
                System.debug('JSON: '+JSON.serializePretty(asp));
                if(String.isNotBlank(asp.info.email)){
                    email = asp.info.email;
                    List<Account> accList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, e_mail__c, Phone, ParentId From Account Where e_mail__c = :email LIMIT 1];
                    
                    // If Account is present in Salesforce
                    if(!accList.isEmpty()){
                        Account main = new Account();
                        Account spouse = new Account();
                        // Assigning main applicant values
                        main.Id = accList.get(0).Id;
                        //Pulkit change
                        accountId = accList[0]?.Id;
                        /*if(String.isNotBlank(asp.info.first_name)){
main.First_Name__c = asp.info.first_name;
}
if(String.isNotBlank(asp.info.last_name)){
main.Last_Name__c = asp.info.last_name;
}
if(String.isNotBlank(asp.info.dob)){
main.DOB__c = Date.parse(asp.info.dob);
}
if(String.isNotBlank(asp.info.marital_status)){
main.Marital_Status__c = asp.info.marital_status;
}
if(String.isNotBlank(asp.info.nationality)){
main.Preferred_Language__c = asp.info.nationality == 'Brazilian' ? 'Portuguese' : 'English'; // Update of Preferred Language on 17-09-2021
}*/
                        if(String.isNotBlank(asp.info.marital_status) && (asp.info.marital_status == 'Married' ||asp.info.marital_status == 'Common-law'))
                        {
                            //accountId = accList[0]?.Id;
                            // Search for spouse
                            List<Account> spList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, e_mail__c, Phone, ParentId From Account Where ParentId = :accountId LIMIT 1];
                            if(spList.isEmpty() && String.isNotBlank(accList.get(0).parentId)){
                                spList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, e_mail__c, Phone, ParentId From Account Where Id = :accList.get(0).parentId LIMIT 1];
                            }
                            // If Spouse Account Present in the System & Linked to parent Account
                            if(!spList.isEmpty()){
                                spouse.Id = spList.get(0).Id;
                                /*if(String.isNotBlank(asp.info.spouse_first_name)){
spouse.First_Name__c = asp.info.spouse_first_name;
}
if(String.isNotBlank(asp.info.spouse_last_name)){
spouse.Last_Name__c = asp.info.spouse_last_name;
}
if(String.isNotBlank(asp.info.spouse_dob)){
spouse.DOB__c = Date.parse(asp.info.spouse_dob);
}
if(String.isNotBlank(asp.info.spouse_email)){
spouse.e_mail__c = asp.info.spouse_email;
}*/
                            }
                            // if Spouse Account not present in Salesforce Linked with Main Applicant
                            else{
                                spouse.ParentId = accList.get(0).Id; // Linking of sp acc to main acc
                                if(String.isNotBlank(asp.info.spouse_email)){
                                    // finding an idle spouse account
                                    List<Account> findSpList = [Select Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, e_mail__c, Phone, ParentId From Account Where e_mail__c = :asp.info.spouse_email LIMIT 1];
                                    // if Spouse account is an idle account
                                    if(!findSpList.isEmpty()){
                                        if(isIdleAccount(findSpList.get(0))){
                                            spouse.Id = findSpList.get(0).Id;
                                            if(String.isNotBlank(asp.info.spouse_first_name)){
                                                spouse.First_Name__c = asp.info.spouse_first_name;
                                            }
                                            if(String.isNotBlank(asp.info.spouse_last_name)){
                                                spouse.Last_Name__c = asp.info.spouse_last_name;
                                            }
                                            if(String.isNotBlank(asp.info.spouse_dob)){
                                                spouse.DOB__c = Date.parse(asp.info.spouse_dob);
                                            }
                                            if(String.isNotBlank(asp.info.spouse_email)){
                                                spouse.e_mail__c = asp.info.spouse_email;
                                            }
                                            if(String.isNotBlank(asp.info.marital_status))
                                            {
                                                spouse.Marital_Status__c = asp.info.marital_status;
                                            }
                                            
                                        }
                                        
                                    } // End of - if Spouse account is an idle account
                                    // If Idle Spouse Account not present in salesforce
                                    else if(findSpList.isEmpty()){
                                        if(String.isNotBlank(asp.info.spouse_first_name)){
                                            spouse.First_Name__c = asp.info.spouse_first_name;
                                        }
                                        if(String.isNotBlank(asp.info.spouse_last_name)){
                                            spouse.Last_Name__c = asp.info.spouse_last_name;
                                        }
                                        if(String.isNotBlank(asp.info.spouse_dob)){
                                            spouse.DOB__c = Date.parse(asp.info.spouse_dob);
                                        }
                                        if(String.isNotBlank(asp.info.spouse_email)){
                                            spouse.e_mail__c = asp.info.spouse_email;
                                        }
                                        if(String.isNotBlank(asp.info.marital_status))
                                        {
                                            spouse.Marital_Status__c = asp.info.marital_status;
                                        }
                                    } // End of - If Idle Spouse Account not present in salesforce
                                }
                                /*
* Pulkit commented this code for Spouse account stoping process 
//This is to update the marital status of main account only when spouse is idle or creating new 
if(String.isNotBlank(asp.info.marital_status))
{
main.Marital_Status__c = asp.info.marital_status;
}
update main;

if(String.isNotBlank(spouse.Id)){
update spouse;
}
else{
if(String.isNotBlank(spouse.First_Name__c) && String.isNotBlank(spouse.Last_Name__c) && String.isNotBlank(spouse.e_mail__c) 
&& spouse.DOB__c != null && String.isNotBlank(spouse.ParentId)){
spouse.Name = spouse.First_Name__c+' '+spouse.Last_Name__c;
//spouse.Territory__c = 'Vancouver';
insert spouse;
}

}
*Pulkit change end CR2
*/
                            } // End of - if Spouse Account not present in Salesforce 
                            
                        }  
                        
                        
                        response = createAssessmentHelper(asp, accountId, 'Account', spouse?.Id, response);
                        if(response.statusCode != 201){
                            Database.rollback(sp);
                        }
                        
                    } // End of - If Account is present in Salesforce
                    
                    // If Account is not present then check for Lead
                    else if(accList.isEmpty()){
                        List<Lead> leadlist = [Select Id From Lead Where Email = :email AND isConverted = false];
                        Lead ld = new Lead();
                        // If Lead is present in salesforce 
                        if(!leadlist.isEmpty()){
                            // Setting up User value for responsible field of Lead
                            //Pulkit change start
                            //List<User> leadResponsible = [Select Id From User Where Name = 'Admin Team'];
                            
                            /*if(!leadResponsible.isEmpty()){
ld.Responsible__c = leadResponsible.get(0).Id;
}*/
                            ld.Id = leadlist.get(0).Id;
                            leadId = leadlist.get(0).Id;
                            //Default Field Values
                            /*ld.LeadSource = 'FREE ASSESSMENT';
ld.Territory__c = 'Vancouver';
if(String.isNotBlank(asp.info.country)){
ld.Client_is_in_Canada__c = asp.info.country == 'Canada' ? 'Yes' : 'No';
}
if(String.isNotBlank(asp.info.nationality)){
ld.Prefered_Language__c = asp.info.nationality == 'Brazilian' ? 'Portuguese' : 'English';
}
//End of - Default Field Values
if(String.isNotBlank(asp.info.first_name)){
ld.FirstName = asp.info.first_name;
}
if(String.isNotBlank(asp.info.last_name)){
ld.LastName = asp.info.last_name;
}
if(String.isNotBlank(asp.info.email)){
ld.Email = asp.info.email;
}
if(String.isNotBlank(asp.info.dob)){
ld.DOB__c = Date.parse(asp.info.dob);
}
if(String.isNotBlank(asp.info.marital_status)){
ld.Marital_Status__c = asp.info.marital_status;
}
if(String.isNotBlank(asp.info.spouse_first_name)){
ld.Spouse_First_Name__c = asp.info.spouse_first_name;
}
if(String.isNotBlank(asp.info.spouse_last_name)){
ld.Spouse_Last_Name__c = asp.info.spouse_last_name;
}
if(String.isNotBlank(asp.info.spouse_dob)){
ld.Spouse_DOB__c = Date.parse(asp.info.spouse_dob);
}
if(String.isNotBlank(asp.info.spouse_email)){
ld.Email_Spouse__c = asp.info.spouse_email;
}
ld.Company = ld.First_Name__c + ' ' + ld.LastName;*/
                        } // End of - If Lead is present in salesforce 
                        
                        // If lead is not present in salesforce
                        else{
                            // Setting up User value for responsible field of Lead
                            List<User> leadResponsible = [Select Id From User Where Name = 'Admin Team'];
                            if(!leadResponsible.isEmpty()){
                                ld.Responsible__c = leadResponsible.get(0).Id;
                            }
                            //Default Field Values
                            ld.LeadSource = 'FREE ASSESSMENT';
                            ld.Territory__c = 'Vancouver';
                            if(String.isNotBlank(asp.info.country)){
                                ld.Client_is_in_Canada__c = asp.info.country == 'Canada' ? 'Yes' : 'No';
                            }
                            if(String.isNotBlank(asp.info.nationality)){
                                ld.Prefered_Language__c = asp.info.nationality == 'Brazilian' ? 'Portuguese' : 'English';
                            }
                            //End of - Default Field Values
                            if(String.isNotBlank(asp.info.first_name)){
                                ld.FirstName = asp.info.first_name;
                            }
                            if(String.isNotBlank(asp.info.last_name)){
                                ld.LastName = asp.info.last_name;
                            }
                            if(String.isNotBlank(asp.info.email)){
                                ld.Email = asp.info.email;
                            }
                            if(String.isNotBlank(asp.info.dob)){
                                ld.DOB__c = Date.parse(asp.info.dob);
                            }
                            if(String.isNotBlank(asp.info.marital_status)){
                                ld.Marital_Status__c = asp.info.marital_status;
                            }
                            if(String.isNotBlank(asp.info.spouse_first_name)){
                                ld.Spouse_First_Name__c = asp.info.spouse_first_name;
                            }
                            if(String.isNotBlank(asp.info.spouse_last_name)){
                                ld.Spouse_Last_Name__c = asp.info.spouse_last_name;
                            }
                            if(String.isNotBlank(asp.info.spouse_dob)){
                                ld.Spouse_DOB__c = Date.parse(asp.info.spouse_dob);
                            }
                            if(String.isNotBlank(asp.info.spouse_email)){
                                ld.Email_Spouse__c = asp.info.spouse_email;
                            }
                            ld.Company = ld.First_Name__c + ' ' + ld.LastName;
                            
                        } // End of - If lead is not present in salesforce
                        
                        if(String.isNotBlank(ld.Id)){
                            //update ld;
                        }
                        else{
                            insert ld;
                        }
                        response = createAssessmentHelper(asp, ld.Id, 'Lead', null, response);
                        if(response.statusCode != 201){
                            Database.rollback(sp);
                        }
                        
                        
                    } // End of - If Account is not present then check for Lead
                }   
            }
            
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
    
    global static RestResponse createAssessmentHelper(AssessmentParseJSON asp, Id parentId, String parentType, String spouseId, RestResponse res){
        assessment__c asmt = new assessment__c();
        if(parentType == 'Lead'){
            asmt.Lead__c = parentId; // Linking the Lead to the assessment
        }
        if(parentType == 'Account'){
            asmt.Account__c = parentId; // Linking the main account to the assessment
            asmt.Spouse_Partner__c = spouseId; // Linking of spouse to the assessment
        }
        // Mapping of Children Section
        if(String.isNotBlank(asp.info.number_of_children)){
            asmt.Number_of_children__c = asp.info.number_of_children;
        }
        
        if(String.isNotBlank(asp.info.ChildName1)){
            asmt.Child_s_Name1__c = asp.info.ChildName1;
        }
        if(String.isNotBlank(asp.info.ChildName2)){
            asmt.Child_s_Name2__c = asp.info.ChildName2;
        }
        if(String.isNotBlank(asp.info.ChildName3)){
            asmt.Child_s_Name3__c = asp.info.ChildName3;
        }
        if(String.isNotBlank(asp.info.ChildName4)){
            asmt.Child_s_Name4__c = asp.info.ChildName4;
        }
        if(String.isNotBlank(asp.info.ChildName5)){
            asmt.Child_s_Name5__c = asp.info.ChildName5;
        }
        if(String.isNotBlank(asp.info.ChildName6)){
            asmt.Child_s_Name6__c = asp.info.ChildName6;
        }
        
        if(String.isNotBlank(asp.info.ChildBirth1)){
            asmt.Child_s_Birth1__c = Date.parse(asp.info.ChildBirth1);
        }
        if(String.isNotBlank(asp.info.ChildBirth2)){
            asmt.Child_s_Birth2__c = Date.parse(asp.info.ChildBirth2);
        }
        if(String.isNotBlank(asp.info.ChildBirth3)){
            asmt.Child_s_Birth3__c = Date.parse(asp.info.ChildBirth3);
        }
        if(String.isNotBlank(asp.info.ChildBirth4)){
            asmt.Child_s_Birth4__c = Date.parse(asp.info.ChildBirth4);
        }
        if(String.isNotBlank(asp.info.ChildBirth5)){
            asmt.Child_s_Birth5__c = Date.parse(asp.info.ChildBirth5);
        }
        if(String.isNotBlank(asp.info.ChildBirth6)){
            asmt.Child_s_Birth6__c = Date.parse(asp.info.ChildBirth6);
        }
        //Pulkit change here
        if(String.isNotBlank(asp.info.first_name))
        {
            asmt.First_Name_Main_Applicant__c = asp.info.first_name;
        }
        if(String.isNotBlank(asp.info.last_name))
        {
            asmt.Last_Name_Main_Applicant__c = asp.info.last_name;
        }
        if(String.isNotBlank(asp.info.email))
        {
            asmt.E_mail_Main_Applicant__c = asp.info.email;
        }
        if(String.isNotBlank(asp.info.dob))
        {
            asmt.DOB_Main_Applicant__c = Date.parse(asp.info.dob);
        }
        if(String.isNotBlank(asp.info.marital_status))
        {
            asmt.Marital_Status__c = asp.info.marital_status;
        }
        if(String.isNotBlank(asp.info.spouse_first_name))
        {
            asmt.First_Name_Spouse__c = asp.info.spouse_first_name;
        }
        if(String.isNotBlank(asp.info.spouse_last_name))
        {
            asmt.Last_Name_Spouse__c = asp.info.spouse_last_name;
        }
        if(String.isNotBlank(asp.info.spouse_dob))
        {
            asmt.DOB_Spouse__c = Date.parse(asp.info.spouse_dob);
        }
        if(String.isNotBlank(asp.info.spouse_email))
        {
            asmt.E_mail_Spouse__c = asp.info.spouse_email;
        }
        
        // Mapping of Education Section Main Applicant
        if(!asp.educations.isEmpty()){
            // Count to maintain 1 education for each- spouse & main applicant
            Integer countEdu = 0;
            for(AssessmentParseJSON.cls_educations ed : asp.educations){
                if(countEdu == 2){
                    break;
                }
                if(String.isNotBlank(ed.applicant_or_spouse)){
                    if(ed.applicant_or_spouse == 'Main Applicant'){
                        // Level of education list of assessment
                        if(String.isNotBlank(ed.education_level)){
                            ed.education_level = ed.education_level == 'PhD' ? 'Ph. D.': ed.education_level;
                            asmt.Level_of_education__c = ed.education_level;
                        }
                        // Name of diploma1 mapping
                        if(String.isNotBlank(ed.name_of_credential)){
                            asmt.Name_of_diploma1__c = ed.name_of_credential;
                        }
                        // Country of Studies mapping
                        if(String.isNotBlank(ed.country_of_education)){
                            asmt.Country_of_studies__c = ed.country_of_education;
                        }
                        // Post secondaries in Canada mapping
                        if(String.isNotBlank(ed.Post_secondaries_in_Canada)){
                            asmt.Post_secondaries_in_canada__c = ed.Post_secondaries_in_Canada;
                        }
                        // Type of educational institute mapping
                        if(String.isNotBlank(ed.canadian_education_institution_type)){
                            asmt.Type_of_educational_institute__c = ed.canadian_education_institution_type;
                        }
                        // Post-secondary studies mapping
                        if(String.isNotBlank(ed.Post_secondary_studies)){
                            asmt.Post_secondary_studies__c = ed.Post_secondary_studies;
                        }
                    }
                    // Education
                    if(ed.applicant_or_spouse == 'Spouse'){
                        // Level of education list of assessment
                        if(String.isNotBlank(ed.education_level)){
                            ed.education_level = ed.education_level == 'PhD' ? 'Ph. D.': ed.education_level;
                            asmt.Level_of_education_Spouse__c = ed.education_level;
                        }
                        // Name of diploma1 mapping
                        if(String.isNotBlank(ed.name_of_credential)){
                            asmt.Name_of_diploma1_Spouse__c = ed.name_of_credential;
                        }
                        // Country of Studies mapping
                        if(String.isNotBlank(ed.country_of_education)){
                            asmt.Country_of_studies_Spouse__c = ed.country_of_education;
                        }
                        // Post secondaries in Canada mapping
                        if(String.isNotBlank(ed.Post_secondaries_in_Canada)){
                            asmt.Post_secondaries_in_canada_Spouse__c = ed.Post_secondaries_in_Canada;
                        }
                        // Type of educational institute mapping
                        if(String.isNotBlank(ed.canadian_education_institution_type)){
                            asmt.Type_of_educational_institute_Spouse__c = ed.canadian_education_institution_type;
                        }
                        // Post-secondary studies mapping
                        if(String.isNotBlank(ed.Post_secondary_studies)){
                            asmt.Post_secondary_studies_Spouse__c = ed.Post_secondary_studies;
                        }
                    }
                }
                countEdu++;
            } // End of Education loop
            
        } // End of Education Section
        
        //Start of Language section
        if(!asp.languages.isEmpty()){
            for(AssessmentParseJSON.cls_languages lang : asp.languages){
                if(String.isNotBlank(lang.applicant_or_spouse)){
                    // Language for Main Applicant
                    if(lang.applicant_or_spouse == 'Main Applicant'){
                        if(String.isNotBlank(lang.main_language)){
                            asmt.French_first_language__c = Boolean.valueOf(lang.main_language);
                        }
                        // Check the language name - English OR French
                        if(String.isNotBlank(lang.language_name)){
                            if(lang.language_name == 'ENGLISH'){
                                if(String.isNotBlank(lang.speak_this_language)){
                                    asmt.Do_you_speak_English__c = lang.speak_this_language;
                                }
                                if(String.isNotBlank(lang.test)){
                                    asmt.English_test_type__c = lang.test;
                                }
                                // Assigning the skills - read, listen, speak, write
                                if(!lang.skills.isEmpty()){
                                    for(AssessmentParseJSON.cls_skills skill : lang.skills){
                                        if(String.isNotBlank(skill.listening)){
                                            asmt.English_Listening__c = skill.listening;
                                        }
                                        if(String.isNotBlank(skill.reading)){
                                            asmt.English_reading__c = skill.reading;
                                        }
                                        if(String.isNotBlank(skill.speaking)){
                                            asmt.English_speaking__c = skill.speaking;
                                        }
                                        if(String.isNotBlank(skill.writing)){
                                            asmt.English_Writing__c = skill.writing;
                                        }
                                    }
                                } // End Of - Assigning the skills - read, listen, speak, write
                                
                            } // End - Of English
                            
                            // Start of - French
                            if(lang.language_name == 'FRENCH'){
                                if(String.isNotBlank(lang.speak_this_language)){
                                    asmt.Do_you_speak_French__c = lang.speak_this_language;
                                }
                                if(String.isNotBlank(lang.test)){
                                    asmt.Have_you_done_TEF__c = lang.test;
                                }
                                // Assigning the skills - read, listen, speak, write (FRENCH)
                                if(!lang.skills.isEmpty()){
                                    for(AssessmentParseJSON.cls_skills skill : lang.skills){
                                        if(String.isNotBlank(skill.listening)){
                                            // Adding (TEF) OR (TCF) to do Integration based on Picklist API Name instead of its label
                                            if(lang.test == 'TEF'){
                                                skill.listening = skill.listening + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.listening = skill.listening + '(TCF)';
                                            }
                                            asmt.French_Listening__c = skill.listening;
                                        }
                                        if(String.isNotBlank(skill.reading)){
                                            if(lang.test == 'TEF'){
                                                skill.reading = skill.reading + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.reading = skill.reading + '(TCF)';
                                            }
                                            asmt.French_reading__c = skill.reading;
                                        }
                                        if(String.isNotBlank(skill.speaking)){
                                            if(lang.test == 'TEF'){
                                                skill.speaking = skill.speaking + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.speaking = skill.speaking + '(TCF)';
                                            }
                                            asmt.French_speaking__c = skill.speaking;
                                        }
                                        if(String.isNotBlank(skill.writing)){
                                            if(lang.test == 'TEF'){
                                                skill.writing = skill.writing + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.writing = skill.writing + '(TCF)';
                                            }
                                            asmt.French_Writing__c = skill.writing;
                                        }
                                    }
                                } // End Of - Assigning the skills - read, listen, speak, write(FRENCH)
                            } // End of French
                        }
                    } // End of Language for Main Applicant
                    // Start Language for Spouse
                    else if(lang.applicant_or_spouse == 'Spouse'){
                        if(String.isNotBlank(lang.main_language)){
                            asmt.French_first_language_Spouse__c = Boolean.valueOf(lang.main_language);
                        }
                        // Check the language name - English OR French
                        if(String.isNotBlank(lang.language_name)){
                            if(lang.language_name == 'ENGLISH'){
                                if(String.isNotBlank(lang.speak_this_language)){
                                    asmt.Do_you_speak_English_Spouse__c = lang.speak_this_language;
                                }
                                if(String.isNotBlank(lang.test)){
                                    asmt.English_test_type_Spouse__c = lang.test;
                                }
                                // Assigning the skills - read, listen, speak, write
                                if(!lang.skills.isEmpty()){
                                    for(AssessmentParseJSON.cls_skills skill : lang.skills){
                                        if(String.isNotBlank(skill.listening)){
                                            asmt.English_Listening_Spouse__c = skill.listening;
                                        }
                                        if(String.isNotBlank(skill.reading)){
                                            asmt.English_reading_Spouse__c = skill.reading;
                                        }
                                        if(String.isNotBlank(skill.speaking)){
                                            asmt.English_speaking_Spouse__c = skill.speaking;
                                        }
                                        if(String.isNotBlank(skill.writing)){
                                            asmt.English_Writing_Spouse__c = skill.writing;
                                        }
                                    }
                                } // End Of - Assigning the skills - read, listen, speak, write
                                
                            } // End - Of English
                            
                            // Start of - French
                            if(lang.language_name == 'FRENCH'){
                                if(String.isNotBlank(lang.speak_this_language)){
                                    asmt.Do_you_speak_French_Spouse__c = lang.speak_this_language;
                                }
                                if(String.isNotBlank(lang.test)){
                                    asmt.Have_you_done_TEF_Spouse__c = lang.test;
                                }
                                // Assigning the skills - read, listen, speak, write (FRENCH)
                                if(!lang.skills.isEmpty()){
                                    for(AssessmentParseJSON.cls_skills skill : lang.skills){
                                        if(String.isNotBlank(skill.listening)){
                                            // Adding (TEF) OR (TCF) to do Integration based on Picklist API Name instead of its label
                                            if(lang.test == 'TEF'){
                                                skill.listening = skill.listening + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.listening = skill.listening + '(TCF)';
                                            }
                                            asmt.French_Listening_Spouse__c = skill.listening;
                                        }
                                        if(String.isNotBlank(skill.reading)){
                                            if(lang.test == 'TEF'){
                                                skill.reading = skill.reading + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.reading = skill.reading + '(TCF)';
                                            }
                                            asmt.French_reading_Spouse__c = skill.reading;
                                        }
                                        if(String.isNotBlank(skill.speaking)){
                                            if(lang.test == 'TEF'){
                                                skill.speaking = skill.speaking + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.speaking = skill.speaking + '(TCF)';
                                            }
                                            asmt.French_speaking_Spouse__c = skill.speaking;
                                        }
                                        if(String.isNotBlank(skill.writing)){
                                            if(lang.test == 'TEF'){
                                                skill.writing = skill.writing + '(TEF)';
                                            }
                                            if(lang.test == 'TCF'){
                                                skill.writing = skill.writing + '(TCF)';
                                            }
                                            asmt.French_Writing_Spouse__c = skill.writing;
                                        }
                                    }
                                } // End Of - Assigning the skills - read, listen, speak, write(FRENCH)
                            } // End of French
                        }
                    } // End of Spouse Language 
                }
            }
        }//End of language section
        
        
        // Work Ex Section Mapping
        // Counter for workex Main Applicant section
        Integer workExCounterMainApplicant = 0;
        // Counter for workex Main Spouse
        Integer workExCounterSpouse = 0;
        if(!asp.works.isEmpty()){
            for(AssessmentParseJSON.cls_works workex : asp.works){
                if(String.isNotBlank(workex.applicant_or_spouse)){
                    // Check Workex for Main Applicant
                    if(workex.applicant_or_spouse == 'Main Applicant'){
                        //Condition for only 3 workex can be added for main applicant
                        if(workExCounterMainApplicant < 3){
                            // 1st workex for main applicant
                            if(workExCounterMainApplicant == 0){
                                if(String.isNotBlank(workex.job_title)){
                                    List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c =: workex.job_title];
                                    if(!noc1list.isEmpty()){
                                        asmt.Please_type_a_occupation_1__c = noc1list[0]?.Id;
                                    }
                                }
                                if(String.isNotBlank(workex.years_of_experience)){
                                    asmt.Duration_1__c = workex.years_of_experience;
                                }
                                if(String.isNotBlank(workex.location)){
                                    asmt.Location_1__c = workex.location;
                                }
                                if(String.isNotBlank(workex.canadian_experience_province)){
                                    asmt.Province_1__c = workex.canadian_experience_province;
                                }
                                if(String.isNotBlank(workex.canadian_experience_currently_working)){
                                    asmt.Currently_working_on_this_job_1__c = workex.canadian_experience_currently_working;
                                }
                                if(String.isNotBlank(workex.canadian_experience_start_date)){
                                    asmt.Job_start_1__c = Date.parse(workex.canadian_experience_start_date);
                                }
                                if(String.isNotBlank(workex.canadian_experience_end_date)){
                                    asmt.Job_end_1__c = Date.parse(workex.canadian_experience_end_date);
                                }
                            } // End of - 1st workex for main applicant
                            
                            // Start of - 2nd workex for main applicant
                            if(workExCounterMainApplicant == 1){
                                if(String.isNotBlank(workex.job_title)){
                                    List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c =: workex.job_title];
                                    if(!noc1list.isEmpty()){
                                        asmt.Please_type_a_occupation_2__c = noc1list[0]?.Id;
                                    }
                                }
                                if(String.isNotBlank(workex.years_of_experience)){
                                    asmt.Duration_2__c = workex.years_of_experience;
                                }
                                if(String.isNotBlank(workex.location)){
                                    asmt.Location_2__c = workex.location;
                                }
                                if(String.isNotBlank(workex.canadian_experience_province)){
                                    asmt.Province_2__c = workex.canadian_experience_province;
                                }
                                if(String.isNotBlank(workex.canadian_experience_currently_working)){
                                    asmt.Currently_working_on_this_job_2__c = workex.canadian_experience_currently_working;
                                }
                                if(String.isNotBlank(workex.canadian_experience_start_date)){
                                    asmt.Job_start_2__c = Date.parse(workex.canadian_experience_start_date);
                                }
                                if(String.isNotBlank(workex.canadian_experience_end_date)){
                                    asmt.Job_end_2__c = Date.parse(workex.canadian_experience_end_date);
                                }
                            } // End of - 2nd workex for main applicant
                            
                            // Start of - 3rd workex for main applicant
                            if(workExCounterMainApplicant == 2){
                                if(String.isNotBlank(workex.job_title)){
                                    List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c =: workex.job_title];
                                    if(!noc1list.isEmpty()){
                                        asmt.Please_type_a_occupation_3__c = noc1list[0]?.Id; 
                                    }
                                }
                                if(String.isNotBlank(workex.years_of_experience)){
                                    asmt.Duration_3__c = workex.years_of_experience;
                                }
                                if(String.isNotBlank(workex.location)){
                                    asmt.Location_3__c = workex.location;
                                }
                                if(String.isNotBlank(workex.canadian_experience_province)){
                                    asmt.Province_3__c = workex.canadian_experience_province;
                                }
                                if(String.isNotBlank(workex.canadian_experience_currently_working)){
                                    asmt.Currently_working_on_this_job_3__c = workex.canadian_experience_currently_working;
                                }
                                if(String.isNotBlank(workex.canadian_experience_start_date)){
                                    asmt.Job_start_3__c = Date.parse(workex.canadian_experience_start_date);
                                }
                                if(String.isNotBlank(workex.canadian_experience_end_date)){
                                    asmt.Job_end_3__c = Date.parse(workex.canadian_experience_end_date);
                                }
                            }
                        } //End  of - Condition for only 3 workex can be added for main applicant
                        workExCounterMainApplicant++;
                    } // End of - Check Workex for Main Applicant
                    
                    // Start of spouse workex
                    else if(workex.applicant_or_spouse == 'Spouse'){
                        asmt.spouse_have_any_occupational_experience__c = 'Yes'; // to make visible spouse occupation in occupation tab
                        //Condition for only 3 workex can be added for Spouse
                        if(workExCounterSpouse < 3){
                            // 1st workex for Spouse
                            if(workExCounterSpouse == 0){
                                if(String.isNotBlank(workex.job_title)){
                                    List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c =: workex.job_title];
                                    if(!noc1list.isEmpty()){
                                        asmt.Please_type_a_occupation_1_Spouse__c = noc1list[0]?.Id;
                                    }
                                }
                                if(String.isNotBlank(workex.years_of_experience)){
                                    asmt.Duration_1_Spouse__c = workex.years_of_experience;
                                }
                                if(String.isNotBlank(workex.location)){
                                    asmt.Location_1_Spouse__c = workex.location;
                                }
                                if(String.isNotBlank(workex.canadian_experience_province)){
                                    asmt.Province_1_Spouse__c = workex.canadian_experience_province;
                                }
                                if(String.isNotBlank(workex.canadian_experience_currently_working)){
                                    asmt.Currently_working_on_this_job_1_Spouse__c = workex.canadian_experience_currently_working;
                                }
                                if(String.isNotBlank(workex.canadian_experience_start_date)){
                                    asmt.Job_start_1_Spouse__c = Date.parse(workex.canadian_experience_start_date);
                                }
                                if(String.isNotBlank(workex.canadian_experience_end_date)){
                                    asmt.Job_end_1_Spouse__c = Date.parse(workex.canadian_experience_end_date);
                                }
                            } // End of - 1st workex for Spouse
                            
                            // 2nd workex for Spouse
                            if(workExCounterSpouse == 1){
                                if(String.isNotBlank(workex.job_title)){
                                    List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c =: workex.job_title];
                                    if(!noc1list.isEmpty()){
                                        asmt.Please_type_a_occupation_2_Spouse__c = noc1list[0]?.Id;
                                    }
                                }
                                if(String.isNotBlank(workex.years_of_experience)){
                                    asmt.Duration_2_Spouse__c = workex.years_of_experience;
                                }
                                if(String.isNotBlank(workex.location)){
                                    asmt.Location_2_Spouse__c = workex.location;
                                }
                                if(String.isNotBlank(workex.canadian_experience_province)){
                                    asmt.Province_2_Spouse__c = workex.canadian_experience_province;
                                }
                                if(String.isNotBlank(workex.canadian_experience_currently_working)){
                                    asmt.Currently_working_on_this_job_2_Spouse__c = workex.canadian_experience_currently_working;
                                }
                                if(String.isNotBlank(workex.canadian_experience_start_date)){
                                    asmt.Job_start_2_Spouse__c = Date.parse(workex.canadian_experience_start_date);
                                }
                                if(String.isNotBlank(workex.canadian_experience_end_date)){
                                    asmt.Job_end_2_Spouse__c = Date.parse(workex.canadian_experience_end_date);
                                }
                            } // End of - 2nd workex for Spouse
                            
                            // 3rd workex for Spouse
                            if(workExCounterSpouse == 2){
                                if(String.isNotBlank(workex.job_title)){
                                    List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c =: workex.job_title];
                                    if(!noc1list.isEmpty()){
                                        asmt.Please_type_a_occupation_3_Spouse__c = noc1list[0]?.Id;
                                    }
                                }
                                if(String.isNotBlank(workex.years_of_experience)){
                                    asmt.Duration_3_Spouse__c = workex.years_of_experience;
                                }
                                if(String.isNotBlank(workex.location)){
                                    asmt.Location_3_Spouse__c = workex.location;
                                }
                                if(String.isNotBlank(workex.canadian_experience_province)){
                                    asmt.Province_3_Spouse__c = workex.canadian_experience_province;
                                }
                                if(String.isNotBlank(workex.canadian_experience_currently_working)){
                                    asmt.Currently_working_on_this_job_3_Spouse__c = workex.canadian_experience_currently_working;
                                }
                                if(String.isNotBlank(workex.canadian_experience_start_date)){
                                    asmt.Job_start_3_Spouse__c = Date.parse(workex.canadian_experience_start_date);
                                }
                                if(String.isNotBlank(workex.canadian_experience_end_date)){
                                    asmt.Job_end_3_Spouse__c = Date.parse(workex.canadian_experience_end_date);
                                }
                            } // End of - 3rd workex for Spouse
                            
                        }
                        workExCounterSpouse++;
                    } // End of - spouse workex
                }
            }
        } //end of workex section
        
        // Other section Mapping 
        
        // Mapping for relatives in canada
        if(String.isNotBlank(asp.other.relatives_in_canada)){
            asmt.Relatives_In_Canada_List__c = asp.other.relatives_in_canada;
        }
        
        // Mapping for Biz/Finance section Networth
        if(String.isNotBlank(asp.other.funds_available)){
            asmt.Networth__c = asp.other.funds_available;
        }
        
        //Mapping for source media
        if(String.isNotBlank(asp.other.how_hear_about_us)){
            asmt.Source_Media__c = asp.other.how_hear_about_us;
        }
        
        // Mapping of further information (Other info section)
        if(String.isNotBlank(asp.other.note)){
            asmt.Further_Information__c = asp.other.note;
        }
        
        // Certificate of Qualification Mapping
        if(String.isNotBlank(asp.other.province_certificate_qualification)){
            asmt.Certificate_of_Qualification_from_Canada__c = asp.other.province_certificate_qualification;
        }
        
        // temporary foreign worker Mapping
        if(String.isNotBlank(asp.other.temporary_foreign_worker)){
            asmt.have_been_canada_as_temp_worker__c = asp.other.temporary_foreign_worker;
        }
        
        // LMIA Mapping
        if(String.isNotBlank(asp.other.lmia)){
            asmt.Have_you_received_an_LMIA__c = asp.other.lmia;
        }
        
        // Noc received Mapping
        if(String.isNotBlank(asp.other.Noc_received)){
            asmt.NOC_received__c = asp.other.Noc_received;
        }
        
        // Provincial Nomination Mapping
        if(String.isNotBlank(asp.other.Provincial_Nomination)){
            asmt.Have_Province_Nomination_except_Quebec__c = asp.other.Provincial_Nomination;
        }
        if(String.isNotBlank(asp.info.nationality)){
            asmt.Preferred_language__c = asp.info.nationality == 'Brazilian' ? 'Portuguese' : 'English'; // Update of Preferred Language on 17-09-2021
        }
        try{
            //RestApi Identifier
            asmt.IsCreatedFromRestApi__c = true;
            asmt.Type__c = 'Express Entry';
            insert asmt;
            res.statusCode = 201;
            res.responseBody = blob.valueOf('Assessment record created inside Salesforce with Id: '+asmt.Id);
        }
        catch(DmlException ex){
            res.statusCode = 400;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(JSONException ex){
            res.statusCode = 400;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(System.QueryException ex){
            res.statusCode = 404;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(Exception ex){
            res.statusCode = 500;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        return res;
    }
    
    global static RestResponse createBCPNPAssessmentHelper(BCPNPParser asp, Id parentId, String parentType, RestResponse res){
        assessment__c asmt = new assessment__c();
        asmt.Type__c = 'BCPNP';
        if(parentType == 'Lead'){
            asmt.Lead__c = parentId; // Linking the Lead to the assessment
        }
        if(parentType == 'Account'){
            asmt.Account__c = parentId; // Linking the main account to the assessment
        }
        if(String.isNotBlank(asp.first_name))
            asmt.First_Name_Main_Applicant__c = asp.first_name;
        if(String.isNotBlank(asp.last_name))
            asmt.Last_Name_Main_Applicant__c = asp.last_name;
        if(String.isNotBlank(asp.email))
            asmt.E_mail_Main_Applicant__c = asp.email;
        if(String.isNotBlank(asp.email_confirmation))
            asmt.E_mail_Confirmation__c = asp.email_confirmation;
        if(String.isNotBlank(asp.preferred_language))
        {
            if(asp.preferred_language == 'Portuguese')
            {
                asmt.Preferred_language__c = 'Portuguese';
            }
            else if(asp.preferred_language == 'Farsi')
            {
                asmt.Preferred_language__c = 'Farsi';
            }
            else if(asp.preferred_language == 'Spanish')
            {
                asmt.Preferred_language__c = 'Spanish';
            }
            else
            {
                asmt.Preferred_language__c = 'English';
            }
        }
        if(!asp.job_offer.isEmpty())
        {
           for(BCPNPParser.Job_offer jo : asp.job_offer)
           {
               if(String.isNotBlank(jo.type_of_salary))
                  asmt.Type_of_Salary__c = jo.type_of_salary;
               if(String.isNotBlank(jo.company_location_in_bc))
                   asmt.Company_Location_in_BC__c = jo.company_location_in_bc;
               if(jo.hours_per_week != null)
                   asmt.Hours_per_week__c = jo.hours_per_week;
               if(jo.salary_amount != null)
                   asmt.Salary_Amount__c = jo.salary_amount;
               if(String.isNotBlank(jo.years_of_related_work_experience))
                   asmt.Directly_Related_Work_Experience__c = jo.years_of_related_work_experience;
               if(asmt.Company_Location_in_BC__c != null && asmt.Company_Location_in_BC__c == 'Greater Vancouver' && String.isNotBlank(jo.employer_full_time_employees))
                   asmt.employer_5_full_time_employees__c = jo.employer_full_time_employees;
               else if(asmt.Company_Location_in_BC__c != null && asmt.Company_Location_in_BC__c != 'Greater Vancouver' && String.isNotBlank(jo.employer_full_time_employees))
                   asmt.employer_3_full_time_employees__c = jo.employer_full_time_employees;
               if(String.isNotBlank(jo.a_year_experience_canada))
                   asmt.At_least_1_year_of_experience_in_Canada__c = jo.a_year_experience_canada;
               if(String.isNotBlank(jo.years_of_experience))
                   asmt.Currently_working_on_this_job_1__c = jo.years_of_experience;
               if(jo.job_title_noc != null)
               {
                   String title = jo.job_title_noc.title.trim();
                   String noc = '%'+title+'%';
                   if(String.isNotBlank(title))
                   {
                       List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c like: noc];
                       if(!noc1list.isEmpty()){
                           asmt.Please_type_a_occupation_1__c = noc1list[0]?.Id;
                       }
                   }
               }
           }
        }
        if(!asp.educations.isEmpty())
        {
            for(BCPNPParser.Educations edu : asp.educations)
            {
                if(String.isNotBlank(edu.education_level))
                    asmt.Education_Level__c = edu.education_level;
                if(String.isNotBlank(edu.name_of_credential))
                    asmt.Name_of_diploma1__c = edu.name_of_credential;
                if(String.isNotBlank(edu.canadian_education_institution_location))
                    asmt.Institution_Location__c = edu.canadian_education_institution_location;
                if(String.isNotBlank(edu.canadian_education_institution_type))
                    asmt.Type_of_educational_institute__c = edu.canadian_education_institution_type;
                if(String.isNotBlank(edu.obtained_credential_assessment))
                    asmt.Education_Credential_Assessment__c = edu.obtained_credential_assessment;
                if(String.isNotBlank(edu.obtained_trade_certification_in_canada))
                    asmt.Trade_Certification_in_Canada__c = edu.obtained_trade_certification_in_canada;
                if(edu.country_of_education != null)
                    asmt.Country_of_studies__c = edu.country_of_education?.title;
            }
        }
        if(asp.languages != null)
        {
            BCPNPParser.Languages lang = asp.languages;
            String langType = '';
            if(lang.ENGLISH != null)
            {
                if(String.isNotBlank(lang.ENGLISH.english_test))
                {
               		langType = '1';
                    asmt.English_test_type__c = lang.ENGLISH.english_test;
                    if(lang.ENGLISH.skills != null)
                    {
                        BCPNPParser.Skills sk = lang.ENGLISH.skills;
                        if(String.isNotBlank(sk.listening))
                            asmt.English_Listening__c = sk.listening;
                        if(String.isNotBlank(sk.reading))
                            asmt.English_reading__c = sk.reading;
                        if(String.isNotBlank(sk.speaking))
                            asmt.English_speaking__c = sk.speaking;
                        if(String.isNotBlank(sk.writing))
                            asmt.English_Writing__c = sk.writing;
                    }
                }
                
            }
            if(lang.FRENCH != null)
            {
                if(String.isNotBlank(lang.FRENCH.french_test)) 
                {
                    langType +='2';
                    asmt.Have_you_done_TEF__c = lang.FRENCH.french_test;
                    if(lang.FRENCH.skills != null)
                    {
                        BCPNPParser.Skills skill = lang.FRENCH.skills;
                        if(String.isNotBlank(skill.listening))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.listening = skill.listening + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.listening = skill.listening + '(TCF)';
                            }
                            asmt.French_Listening__c = skill.listening;
                            if(skill.listening.containsIgnoreCase('Advanced'))
                                asmt.French_Listening__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        if(String.isNotBlank(skill.reading))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.reading = skill.reading + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.reading = skill.reading + '(TCF)';
                            }
                            asmt.French_reading__c = skill.reading;
                            if(skill.reading.containsIgnoreCase('Advanced'))
                                asmt.French_reading__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        if(String.isNotBlank(skill.writing))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.writing = skill.writing + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.writing = skill.writing + '(TCF)';
                            }
                            asmt.French_Writing__c = skill.writing;
                            if(skill.writing.containsIgnoreCase('Advanced'))
                                asmt.French_Writing__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        if(String.isNotBlank(skill.speaking))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.speaking = skill.speaking + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.speaking = skill.speaking + '(TCF)';
                            }
                            asmt.French_speaking__c = skill.speaking;
                            if(skill.speaking.containsIgnoreCase('Advanced'))
                                asmt.French_speaking__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        
                    }
                }
                
            }
            if(String.isNotBlank(langType))
            {
                if(langType == '1')
                    asmt.Do_you_speak_English_or_French__c = 'English';
                else if(langType == '2')
                    asmt.Do_you_speak_English_or_French__c = 'French';
                else if(langType == '12')
                    asmt.Do_you_speak_English_or_French__c = 'Both';
                    
            }      
        }
        if(String.isNotBlank(asp.user_note))
            asmt.Any_Specific_question_or_comment__c = asp.user_note;
        if(String.isNotBlank(asp.how_hear_about_us))
            asmt.How_did_you_hear_about_us__c = asp.how_hear_about_us;
        try{
            //RestApi Identifier
            asmt.IsCreatedFromRestApi__c = true;
            insert asmt;
            res.statusCode = 201;
            res.responseBody = blob.valueOf('Assessment record created inside Salesforce with Id: '+asmt.Id);
        }
        catch(DmlException ex){
            res.statusCode = 400;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(JSONException ex){
            res.statusCode = 400;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(System.QueryException ex){
            res.statusCode = 404;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(Exception ex){
            res.statusCode = 500;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        return res;
    }
    
    global static RestResponse createOINPAssessmentHelper(OINPParser asp, Id parentId, String parentType, RestResponse res){
        assessment__c asmt = new assessment__c();
        asmt.Type__c = 'OINP';
        if(parentType == 'Lead'){
            asmt.Lead__c = parentId; // Linking the Lead to the assessment
        }
        if(parentType == 'Account'){
            asmt.Account__c = parentId; // Linking the main account to the assessment
        }
        if(String.isNotBlank(asp.first_name))
            asmt.First_Name_Main_Applicant__c = asp.first_name;
        if(String.isNotBlank(asp.last_name))
            asmt.Last_Name_Main_Applicant__c = asp.last_name;
        if(String.isNotBlank(asp.email))
            asmt.E_mail_Main_Applicant__c = asp.email;
        
        if(String.isNotBlank(asp.email_confirmation))
            asmt.E_mail_Confirmation__c = asp.email_confirmation;
        if(String.isNotBlank(asp.preferred_language))
        {
            if(asp.preferred_language == 'Portuguese')
            {
                asmt.Preferred_language__c = 'Portuguese';
            }
            else if(asp.preferred_language == 'Farsi')
            {
                asmt.Preferred_language__c = 'Farsi';
            }
            else if(asp.preferred_language == 'Spanish')
            {
                asmt.Preferred_language__c = 'Spanish';
            }
            else
            {
                asmt.Preferred_language__c = 'English';
            }
        }
            
        
        if(!asp.job_offer.isEmpty())
        {
           for(OINPParser.Job_offer jo : asp.job_offer)
           {
               if(String.isNotBlank(jo.currently_working))
                  asmt.Currently_working_on_this_job_1__c = jo.currently_working;
               
               if(String.isNotBlank(jo.experience_over_year))
                   asmt.Do_you_have_over_12_months_of_Canadian_E__c = jo.experience_over_year;
               
               if(String.isNotBlank(jo.in_demand_occupation))
                   asmt.Is_Occ_in_in_demand_occupations_list__c = jo.in_demand_occupation;
               
               if(String.isNotBlank(jo.earnings_history))
                   asmt.Earnings_History__c = jo.earnings_history;
               
               if(String.isNotBlank(jo.salary_amount))
                   asmt.Salary_Amount_OINP__c = jo.salary_amount; 
               
               if(String.isNotBlank(jo.years_of_related_work_experience))
                   asmt.Directly_Related_Work_Experience__c = jo.years_of_related_work_experience;
               
               if(String.isNotBlank(jo.part_of_strategic_priorities))
                   asmt.Occupation_part_OINP_Strategic_Priority__c = jo.part_of_strategic_priorities;
               
               if(String.isNotBlank(jo.company_location_in_on))
                   asmt.Company_Location_in_ON__c = jo.company_location_in_on;
               
               if(jo.job_title_noc != null)
               {
                   String title = jo.job_title_noc.title.trim();
                   String noc = '%'+title+'%';
                   if(String.isNotBlank(title))
                   {
                       List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c like: noc];
                       if(!noc1list.isEmpty()){
                           asmt.Please_type_a_occupation_1__c = noc1list[0]?.Id;
                       }
                   }
               }
               
               if(jo.cec_noc != null)
               {
                   String title = jo.cec_noc.title.trim();
                   String noc = '%'+title+'%';
                   if(String.isNotBlank(title))
                   {
                       List<Eligible_Occupation__c> noc1list = [Select Id from Eligible_Occupation__c Where NOC_Details__c like: noc];
                       if(!noc1list.isEmpty()){
                           asmt.CEC_Noc_Level__c = noc1list[0]?.Id;
                       }
                   }
               }
           }
        }
        if(!asp.educations.isEmpty())
        {
            for(OINPParser.Educations edu : asp.educations)
            {
                if(String.isNotBlank(edu.education_level))
                    asmt.Education_Level_OINP__c = edu.education_level;
                
                if(String.isNotBlank(edu.name_of_credential))
                    asmt.Name_of_diploma1__c = edu.name_of_credential;
                
                if(edu.country_of_education != null)
                    asmt.Country_of_studies__c = edu.country_of_education?.title;
                
                if(String.isNotBlank(edu.field_of_study))
                    asmt.Field_of_Study__c = edu.field_of_study;
                
                if(String.isNotBlank(edu.canadian_education_institution_type))
                    asmt.Type_of_educational_institute__c = edu.canadian_education_institution_type;
                
                if(String.isNotBlank(edu.canadian_education_institution_location))
                    asmt.Institution_Location_OINP__c = edu.canadian_education_institution_location;
                
                if(String.isNotBlank(edu.canadian_education_experience))
                    asmt.Canadian_Education_Experience__c = edu.canadian_education_experience;
            }
        }
        if(asp.languages != null)
        {
            OINPParser.Languages lang = asp.languages;
            String langType = '';
            if(lang.ENGLISH != null)
            {
                if(String.isNotBlank(lang.ENGLISH.english_test))
                {
               		langType = '1';
                    asmt.English_test_type__c = lang.ENGLISH.english_test;
                    if(lang.ENGLISH.skills != null)
                    {
                        OINPParser.Skills sk = lang.ENGLISH.skills;
                        if(String.isNotBlank(sk.listening))
                            asmt.English_Listening__c = sk.listening;
                        if(String.isNotBlank(sk.reading))
                            asmt.English_reading__c = sk.reading;
                        if(String.isNotBlank(sk.speaking))
                            asmt.English_speaking__c = sk.speaking;
                        if(String.isNotBlank(sk.writing))
                            asmt.English_Writing__c = sk.writing;
                    }
                }
                
            }
            if(lang.FRENCH != null)
            {
                if(String.isNotBlank(lang.FRENCH.french_test)) 
                {
                    langType +='2';
                    asmt.Have_you_done_TEF__c = lang.FRENCH.french_test;
                    if(lang.FRENCH.skills != null)
                    {
                        OINPParser.Skills skill = lang.FRENCH.skills;
                        if(String.isNotBlank(skill.listening))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.listening = skill.listening + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.listening = skill.listening + '(TCF)';
                            }
                            asmt.French_Listening__c = skill.listening;
                            if(skill.listening.containsIgnoreCase('Advanced'))
                                asmt.French_Listening__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        if(String.isNotBlank(skill.reading))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.reading = skill.reading + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.reading = skill.reading + '(TCF)';
                            }
                            asmt.French_reading__c = skill.reading;
                            if(skill.reading.containsIgnoreCase('Advanced'))
                                asmt.French_reading__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        if(String.isNotBlank(skill.writing))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.writing = skill.writing + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.writing = skill.writing + '(TCF)';
                            }
                            asmt.French_Writing__c = skill.writing;
                            if(skill.writing.containsIgnoreCase('Advanced'))
                                asmt.French_Writing__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        if(String.isNotBlank(skill.speaking))
                        {
                            if(lang.FRENCH.french_test == 'TEF'){
                                skill.speaking = skill.speaking + '(TEF)';
                            }
                            if(lang.FRENCH.french_test == 'TCF'){
                                skill.speaking = skill.speaking + '(TCF)';
                            }
                            asmt.French_speaking__c = skill.speaking;
                            if(skill.speaking.containsIgnoreCase('Advanced'))
                                asmt.French_speaking__c = 'Advanced/ Native Proficiency (CLB 9+)';
                        }
                        
                    }
                }
                
            }
            if(String.isNotBlank(langType))
            {
                if(langType == '1')
                    asmt.Do_you_speak_English_or_French__c = 'English';
                else if(langType == '2')
                    asmt.Do_you_speak_English_or_French__c = 'French';
                else if(langType == '12')
                    asmt.Do_you_speak_English_or_French__c = 'Both';
                    
            }      
        }
        if(String.isNotBlank(asp.user_note))
            asmt.Any_Specific_question_or_comment__c = asp.user_note;
        
        try{
            //RestApi Identifier
            asmt.IsCreatedFromRestApi__c = true;
            insert asmt;
            res.statusCode = 201;
            res.responseBody = blob.valueOf('Assessment record created inside Salesforce with Id: '+asmt.Id);
        }
        catch(DmlException ex){
            res.statusCode = 400;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(JSONException ex){
            res.statusCode = 400;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(System.QueryException ex){
            res.statusCode = 404;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        catch(Exception ex){
            res.statusCode = 500;
            res.responseBody = blob.valueOf(ex.getMessage());
        }
        return res;
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