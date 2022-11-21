public class BCPNPPanelScreenController {
    
    public String newAsmt {get; set;} // String parameter get value 'new' from url to create new ASSESSMENT
    public String csId{get; set;} // Consultation Id passed in url to create new ASSESSMENT
    public String asId{get; set;} // Url parameter(assessmentId) to directly open ASSESSMENT
    public String openCsId {get; set;} // Url parameter(consultation Id) to directly open CONSULTATION SHEET
    public String newCsSheet{get; set;} // String parameter to get value 'new' from url to create new CONSULTATION SHEET
    public String tabDisableSet {get; set;} // variable to manage disable or enable tabs
    public transient String tabOpt {get; set;}// variable to store which tab opted/opened in tab-panel
    public Assessment__c assessment {get; set;} // Assessment
    public Boolean consTab {get; set;} // variable to manage reRendering of Consultation Details tab's both screen
    public Consultation_Sheet__c cSheetDetail {get; set;} //Selected consultation sheet for update
    public String statusExpirationDate {get; set;}
    public String csDate {get; set;} // Date__c field of consultation sheet
    public String timeProjected {get; set;}
    public String accountId {get; set;}
    public String selectedCsheetId {get; set;} // variable to store selected Consultation Sheet Id
    public List<Consultation_Sheet__c> cSheets {get; set;} // List of Consultation Sheets - related to Account
    public List<Assessment__c> relatedAsmts {get; set;} // List of Assessments - related to Consultation Sheets
    public List<Assessment__c> asmts {get; set;} // List of Assessments - Without Consultation Sheets
    public Boolean setRequiredTabCS {get; set;} // To make fields required or not required in Consultation Details tab1;
    public Integer numberofChilds {get; set;} // variable to handle Children - Block rerendering
    public String selectedAsmtId {get; set;} // variable to store selected Assessment Sheet Id
    public boolean isSalutation{get; set;} // Identifier to make main applicant Saluation editable
    public boolean isFirstName {get; set;} // Identifier to make main applicant firstname editable
    public boolean isLastName {get; set;} // Identifier to make main applicant lastname editable
    public boolean isSpSalutation{get; set;}  // Identifier to make spouse Saluation editable
    public boolean isSpFirstName {get; set;} // Identifier to make spouse firstname editable
    public boolean isSpLastName {get; set;} // Identifier to make spouse lastname editable
    public String mainApplicantDOB {get; set;} // variable to store DOB of Main Applicant
    public String spouseDOB {get; set;} // variable to store DOB of Spouse
    public String dobOutputMainApplicant {get; set;} //variable to show age of main applicant in years, months, days
    public String dobOutputSpouse {get; set;} //variable to show age of Spouse in years, months, days
    public String eeId {get;set;} //Express Entry Id to fill the automatic data;
    
    // Tab-2 properties
    public Account mainApplicantAcc {get; set;} // Account to store Main Applicant Account
    public Account spouseAcc {get; set;} // Account to store Spouse Account
    
    // Tab - 2 (Business/Finance) Properties
    public Consultation_Sheet__c cSheetBiz {get; set;}
    
    //  English Language - Speak/Read/Write/Listen Main Applicant
    public List<SelectOption> enSpeakList {get; set;} // variable to store English Speaking picklist values
    public String enSpeakValue {get; set;} // variable to store selected english speaking value
    public List<SelectOption> enReadList {get; set;} // variable to store English Read picklist values
    public String enReadValue {get; set;} // variable to store selected english Read value
    public List<SelectOption> enWriteList {get; set;} // variable to store English Write picklist values
    public String enWriteValue {get; set;} // variable to store selected english Write value
    public List<SelectOption> enListenList {get; set;} // variable to store English Listen picklist values
    public String enListenValue {get; set;} // variable to store selected english Listen value
    public String selectedTestType {get; set;} // variable to store selected language-test type
    public List<SelectOption> selectedTestTypeList {get; set;} // List of language test type
    //  English Language - Speak/Read/Write/Listen Spouse
    public String selectedOptionEnLang {get; set;} // variable to identify which section- Main Applicant lang OR Spouse lang called the method 'onEnTestChange'
    
    // French Language - Speak/Read/Write/Listen Main Applicant
    public List<SelectOption> frSpeakList {get; set;} // variable to store french speak picklist values
    public String frSpeakValue {get; set;} // variable to selected french speak picklist value
    public List<SelectOption> frReadList {get; set;} // variable to store french Read picklist values
    public String frReadValue {get; set;} // variable to selected french Read picklist value
    public List<SelectOption> frWriteList {get; set;} // variable to store french Write picklist values
    public String frWriteValue {get; set;} // variable to selected french Write picklist value
    public List<SelectOption> frListenList {get; set;} // variable to store french Listen picklist values
    public String frListenValue {get; set;} // variable to selected french Listen picklist value
    
    // French Language - Speak/Read/Write/Listen Spouse
    public List<SelectOption> frSpeakListSP {get; set;} // variable to store french speak picklist values Spouse
    public String frSpeakValueSP {get; set;} // variable to selected french speak picklist value Spouse
    public List<SelectOption> frReadListSP {get; set;} // variable to store french Read picklist values Spouse
    public String frReadValueSP {get; set;} // variable to selected french Read picklist value Spouse
    public List<SelectOption> frWriteListSP {get; set;} // variable to store french Write picklist values Spouse
    public String frWriteValueSP {get; set;} // variable to selected french Write picklist value Spouse
    public List<SelectOption> frListenListSP {get; set;} // variable to store french Listen picklist values Spouse
    public String frListenValueSP {get; set;} // variable to selected french Listen picklist value Spouse
    
    //Tab - 3(occupations) properties
    public String jobStart1{get; set;}
    public String jobEnd1 {get; set;}
    public String jobStart2{get; set;}
    public String jobEnd2 {get; set;}
    public String jobStart3{get; set;}
    public String jobEnd3 {get; set;}
    public String workExShow {get; set;}
    public String nocDetails1{get; set;}
    
    public String focusEle {get; set;}
    
    //Constructor
    public BCPNPPanelScreenController()
    {
        newAsmt = Apexpages.currentpage().getparameters().get('asmt');
        accountId = Apexpages.currentpage().getparameters().get('accountId');
        csId = Apexpages.currentpage().getparameters().get('csId');
        asId = Apexpages.currentpage().getparameters().get('asId');
        openCsId = Apexpages.currentpage().getparameters().get('openCsId');
        newCsSheet = Apexpages.currentpage().getparameters().get('newCsSheet');
        eeId = Apexpages.currentpage().getparameters().get('eeId');
        if(accountId != null){
            //tabOpt = 'cdetailTab';
            consTab = true;
            this.handleConsultationDetails();
            tabDisableSet = '0';
            assessment = new assessment__c();
        }
        
        workExShow = '1';
        numberofChilds = 0;
        // Create new Assessment
        if(newAsmt == 'new'){
            createNewAssessment();
        }
        
        // Open assessment form url directly
        if(asId != null){
            selectedAsmtId = asId;
            onAsmtClick();
        }
        
        // Create new consultation sheet from url
        if(newCsSheet == 'new'){
            createNewConsultationSheet();
        }
        // Open Consultation Sheet from url directly
        if(openCsId != null){
            selectedCsheetId = openCsId;
            onCSheetClick();
        }
    }
    
    //Method to handle Consultation Details Tab Leave
    public void onConsultationDetailsLeave(){
        
        if(!consTab){
            cSheetDetail.Date__c = AssessmentPanelScreenUtility.convertToDate(csDate);
            cSheetDetail.Time_Projected__c = AssessmentPanelScreenUtility.convertToDate(timeProjected);
            cSheetDetail.Status_Expiration_Date__c = AssessmentPanelScreenUtility.convertToDate(statusExpirationDate);
            this.updateConsultationDetails();
        }
        
    }
    //Method to handle Consultation details tab
    public void handleConsultationDetails(){
        cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c,(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessments__r order by createdDate DESC) 
                   FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
        
        relatedAsmts = [SELECT Id, Name,Type__c, Consultation_Sheet__r.Account__r.Name,E_mail_Confirmation__c FROM Assessment__c 
                        WHERE Consultation_Sheet__c IN :cSheets order by createdDate DESC];
        asmts = [SELECT Id, Name,Type__c, Account__r.Name, CreatedDate, Total__c, Total_EE__c,E_mail_Confirmation__c FROM Assessment__c 
                 WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
    }
    
    // Method to update Consultation Sheet Details
    public void updateConsultationDetails(){
        System.debug('cSheetDetail=> '+cSheetDetail);
        System.debug('cSheetDetail.Time_Projected__c: '+cSheetDetail.Time_Projected__c);
        try {
            if(cSheetDetail.Account__c == NULL || cSheetDetail.Opportunity__c == NULL){
                String emsg = AssessmentPanelScreenUtility.checkRequiredFieldsCSTab(cSheetDetail);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, emsg));
                tabDisableSet = '0';
            }else if(cSheetDetail.Account__c != NULL && cSheetDetail.Opportunity__c != NULL && cSheetDetail.Id != NULL){
                update cSheetDetail;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Consultation Sheet Successfully Updated!'));
            }
            else if(cSheetDetail.Account__c != NULL && cSheetDetail.Opportunity__c != NULL && cSheetDetail.Id == NULL){
                insert cSheetDetail;
                selectedCsheetId = cSheetDetail.Id;
                // To refresh the consultation sheet & gets its name and other fields
                cSheetDetail = [SELECT Id, Name, Account__c, Source__c, Opportunity__c, Consultation_Status__c, 
                                Assessment_for__c, Seeking_Consultation_on_the_Matter_of__c, Time_Projected__c, 
                                Province_of_Interest__c, Location__c, Date__c, Consultant_Notes__c,
                                City_Province__c, Outside_Country_of_Citizenship__c, Country__c, Status__c, Status_Expiration_Date__c, LastModifiedBy.Name, LastModifiedDate, 
                                Preferred_Language__c, Marital_Status__c, How_many_children__c, Canadian_or_PR_Spouse__c, Child_below_5__c, Child_5_to_13yrs_old__c, Child_13_to_21yrs_old__c,
								(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessments__r order by createdDate DESC)
                                FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
                // setting up date fields 05 July 2021
                csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
                timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
                statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
                // Refresh the List of consultations in tab - 1
                cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c, (SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessments__r order by createdDate DESC) 
                           FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
                
                //Refresh the assessments without consultation on tab 1
                asmts = [SELECT Id, Name, Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessment__c 
                         WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Consultation Sheet Successfully Created!'));
            }
        }
        
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Error occured: '+ex.getMessage()));
            System.debug('Exception Csheet Update: '+ ex.getMessage()+' Line Number: '+ex.getLineNumber());
        }
    }
    
    // Method to create new consultation sheet from url
    public void createNewConsultationSheet(){
        // to hide Screen 1
        consTab = false;
        // To set Account and Opportunity required
        setRequiredTabCS = true; 
        cSheetDetail = new Consultation_Sheet__c();
        cSheetDetail.Account__c = accountId;
    }
    
    //Method to set non-required fields value onChange (Consultation Tab)
    public void setFieldValuesCDTab(){
        cSheetDetail.Source__c = cSheetDetail.Source__c;
        cSheetDetail.Consultation_Status__c = cSheetDetail.Consultation_Status__c;
        cSheetDetail.Assessment_for__c = cSheetDetail.Assessment_for__c;
        cSheetDetail.Seeking_Consultation_on_the_Matter_of__c = cSheetDetail.Seeking_Consultation_on_the_Matter_of__c;
        cSheetDetail.Province_of_Interest__c = cSheetDetail.Province_of_Interest__c;
        cSheetDetail.Location__c = cSheetDetail.Location__c;
        cSheetDetail.City_Province__c = cSheetDetail.City_Province__c;
        // personal info section
        cSheetDetail.Marital_Status__c = cSheetDetail.Marital_Status__c;
        cSheetDetail.How_many_children__c = cSheetDetail.How_many_children__c;
        cSheetDetail.Canadian_or_PR_Spouse__c = cSheetDetail.Canadian_or_PR_Spouse__c;
        cSheetDetail.Child_below_5__c = cSheetDetail.Child_below_5__c;
        cSheetDetail.Child_5_to_13yrs_old__c = cSheetDetail.Child_5_to_13yrs_old__c;
        cSheetDetail.Child_13_to_21yrs_old__c = cSheetDetail.Child_13_to_21yrs_old__c;
        // personal info section end
        
        cSheetDetail.Outside_Country_of_Citizenship__c = cSheetDetail.Outside_Country_of_Citizenship__c;
        cSheetDetail.Country__c = cSheetDetail.Country__c;
        cSheetDetail.Status__c = cSheetDetail.Status__c;
		cSheetDetail.Consultant_Notes__c = cSheetDetail.Consultant_Notes__c;
        cSheetDetail.Date__c = AssessmentPanelScreenUtility.convertToDate(csDate);
        cSheetDetail.Time_Projected__c = AssessmentPanelScreenUtility.convertToDate(timeProjected);
        cSheetDetail.Status_Expiration_Date__c = AssessmentPanelScreenUtility.convertToDate(statusExpirationDate);
        //tabDisableSet = '01234';
        tabOpt = 'cdetailTab';
        System.debug('cSheetDetail.Account__c: '+cSheetDetail.Account__c );
        
    }
    
    //Method to set required fields values onChange (Consultation Tab)
    public void setrequiredFieldValuesCDTab(){ 
        tabOpt = 'cdetailTab';
        cSheetDetail.Account__c = cSheetDetail.Account__c;
        cSheetDetail.Opportunity__c = cSheetDetail.Opportunity__c;
        if(cSheetDetail.Account__c == NULL || cSheetDetail.Opportunity__c == NULL){
            String emsg = AssessmentPanelScreenUtility.checkRequiredFieldsCSTab(cSheetDetail);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, emsg));
            tabDisableSet = '0';
        }
        
        if(cSheetDetail.Account__c != NULL && cSheetDetail.Opportunity__c != NULL && assessment.Id != NULL){
            tabDisableSet = '01234';
        }
    }
    
    public PageReference backToSFhome(){
        String base = URL.getSalesforceBaseUrl().toExternalForm();
        string url = '/lightning/r/Account/'+accountId+'/view';
        System.debug('base: '+base);
        if(base.startsWith('https://evisaimmigration.force.com')){
            url = '/'+accountId;
        }
        System.debug('url: '+url);
        PageReference pageRef = new PageReference(url);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    // Method to handle selected consultation sheet and Consultation Details tab's Screen 2
    public void onCSheetClick(){
        // to hide Screen 1
        consTab = false;
        // To set Account and Opportunity required
        setRequiredTabCS = true; 
        System.debug('selectedCsheetId: '+selectedCsheetId);
        cSheetDetail = [SELECT Id, Name, Account__c, Source__c, Opportunity__c, Consultation_Status__c, 
                        Assessment_for__c, Seeking_Consultation_on_the_Matter_of__c, Time_Projected__c, 
                        Province_of_Interest__c, Location__c, Date__c, Consultant_Notes__c,
                        City_Province__c, Outside_Country_of_Citizenship__c, Country__c, Status__c, Status_Expiration_Date__c, LastModifiedBy.Name, LastModifiedDate,
                        Preferred_Language__c, Marital_Status__c, How_many_children__c, Canadian_or_PR_Spouse__c, Child_below_5__c, Child_5_to_13yrs_old__c, Child_13_to_21yrs_old__c,
						(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessments__r order by createdDate DESC)
                        FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
        
        // setting up date fields
        csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
        timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
        statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
        
    }
    
    public PageReference onAsmtClickRouting()
    {
        if(!consTab){
            try {
                if(cSheetDetail.Account__c == NULL || cSheetDetail.Opportunity__c == NULL){
                    System.debug('Account Or Opportunity field cannot be null');
                }else{
                    update cSheetDetail;
                }
            }
            
            catch(Exception ex){
                System.debug('Exception Csheet Update: '+ ex.getMessage()+' Line Number: '+ex.getLineNumber());
            }
        }// End - of consultation save
        
        Assessment__c asmnt = [Select id,name,Type__c,E_mail_Confirmation__c,Consultation_Sheet__c from Assessment__c where id =: selectedAsmtId limit 1];
        if(asmnt.Type__c == null || (String.isNotBlank(asmnt.Type__c) && asmnt.Type__c.equalsIgnoreCase('Express Entry')))
        {
            if(asmnt.Consultation_Sheet__c == null)
            {
                PageReference pgRef = new PageReference('/apex/AssessmentPanelScreen?accountId='+accountId+'&asId='+selectedAsmtId);
                pgRef.setRedirect(true);
                return pgRef;
            }
            else
            {
                PageReference pgRef = new PageReference('/apex/AssessmentPanelScreen?accountId='+accountId+'&asId='+selectedAsmtId+'&openCsId='+asmnt.Consultation_Sheet__c);
                pgRef.setRedirect(true);
                return pgRef;
            }
            
        }
        else if(String.isNotBlank(asmnt.Type__c) && asmnt.Type__c.equalsIgnoreCase('OINP'))
        {
            if(asmnt.Consultation_Sheet__c == null)
            {
                PageReference pgRef = new PageReference('/apex/OINPPanelScreen?accountId='+accountId+'&asId='+selectedAsmtId);
                pgRef.setRedirect(true);
                return pgRef;
            }
            else
            {
                PageReference pgRef = new PageReference('/apex/OINPPanelScreen?accountId='+accountId+'&asId='+selectedAsmtId+'&openCsId='+asmnt.Consultation_Sheet__c);
                pgRef.setRedirect(true);
                return pgRef;
            }
        }
        else
        {
           onAsmtClick(); 
        }
        return null;
    }
    //On clicking of any assesment from consulation sheet
    public void onAsmtClick(){
        // save consultation sheet before leaving it by click on assessment..
        //onConsultationDetailsLeave();
        if(!consTab){
            try {
                if(cSheetDetail.Account__c == NULL || cSheetDetail.Opportunity__c == NULL){
                    System.debug('Account Or Opportunity field cannot be null');
                }else{
                    update cSheetDetail;
                }
            }
            
            catch(Exception ex){
                System.debug('Exception Csheet Update: '+ ex.getMessage()+' Line Number: '+ex.getLineNumber());
            }
        }// End - of consultation save
        
        // Setting workExShow & workExShowSP to 1 for intialization
        workExShow = '1';
        System.debug('selectedAsmtId: '+selectedAsmtId);
        //Enabling Profile Tab
        tabDisableSet = '01234';
        //Move to the profile tab
        tabOpt = 'profile';
        String obj = 'assessment__c';
        // Getting Picklist values for English Language-test type 
        selectedTestTypeList = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_test_type__c');
        // getting all picklist values for speak/read/Write/listen
        List<SelectOption> enSpeakOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_speaking__c');
        List<SelectOption> enReadOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_reading__c');
        List<SelectOption> enWriteOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Writing__c');
        List<SelectOption> enListenOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Listening__c');

        //Query to Main Applicant Account
        mainApplicantAcc = [SELECT Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, Personal_Information_Notes__c, e_mail__c, Phone, ParentId FROM Account
                            WHERE Id = :accountId LIMIT 1];
        if(mainApplicantAcc == NULL){
            mainApplicantAcc = new Account();
        }
        
        List<Account> spActList = [SELECT Id, First_Name__c, Last_Name__c, Salutation__c, DOB__c, e_mail__c, Phone FROM Account WHERE 
                                   ParentId =: accountId LIMIT 1];
        
        if(spActList.size() == 0 || spActList.isEmpty()){
            spActList = [SELECT Id, First_Name__c, Last_Name__c, Salutation__c, DOB__c, e_mail__c, Phone FROM Account WHERE 
                                       Id =: mainApplicantAcc.ParentId LIMIT 1];
        }
        if(spActList.size() > 0){
            spouseAcc = spActList[0];
        }
        
        
        if(spouseAcc == NULL){
            spouseAcc = new Account();
        }
        
        List<assessment__c> astList = [SELECT Id, Account__c, Spouse_Partner__c, French_first_language__c, French_first_language_Spouse__c, Name, Consultation_Sheet__c, Number_of_children__c, Child_s_Birth1__c, Child_s_Birth2__c, Child_s_Birth3__c,
                                       Child_s_Birth4__c, Child_s_Birth5__c, Child_s_Birth6__c, Child_s_Name1__c, Child_s_Name2__c	, Child_s_Name3__c, Child_s_Name4__c, Child_s_Name5__c,
                                       Child_s_Name6__c, Children_Notes__c, Immigrate__c, Work__c, Study__c, Invest__c, Not_Sure__c,
									   Level_of_education__c, Name_of_diploma1__c,
                                       Name_of_diploma2__c, Country_of_studies__c, Post_secondaries_in_canada__c, Type_of_educational_institute__c, Post_secondary_studies__c,
                                       Name_of_bachelor_s_degree__c, Education_Notes__c, Level_of_education_Spouse__c, Name_of_diploma1_Spouse__c, Name_of_diploma2_Spouse__c,
                                       Country_of_studies_Spouse__c, Post_secondaries_in_canada_Spouse__c, Type_of_educational_institute_Spouse__c,
                                       Post_secondary_studies_Spouse__c, Name_of_bachelor_s_degree_Spouse__c, Do_you_speak_English__c, English_test_type__c,
                                       English_speaking__c, English_reading__c, English_Writing__c, English_Listening__c, Do_you_speak_French__c,
                                       Have_you_done_TEF__c, French_speaking__c, French_reading__c, French_Writing__c, French_Listening__c, Language_Notes__c, 
                                       Do_you_speak_English_Spouse__c, English_test_type_Spouse__c, English_speaking_Spouse__c, English_reading_Spouse__c,
                                       English_Writing_Spouse__c, English_Listening_Spouse__c, Do_you_speak_French_Spouse__c, Have_you_done_TEF_Spouse__c,
                                       French_speaking_Spouse__c, French_reading_Spouse__c, French_Writing_Spouse__c, French_Listening_Spouse__c,have_been_canada_as_temp_worker__c,
                                       Certificate_of_Qualification_from_Canada__c, Have_you_received_an_LMIA__c, NOC_received__c, Work_In_Canada_Notes__c, Relatives_In_Canada_List__c,
                                       Does_this_relation_wish_to_sponsor_you__c, Sponsor_s_age__c, Sponsor_s_employment_status__c, Sponsor_s_family_size__c, 
                                       Sponsor_s_annual_income__c, Currently_a_full_time_student__c, Have_been_a_dependent_child_since_before__c, Family_Relation_Notes__c,
                                       Have_previously_visited_canada__c, Have_previously_applied_Immigration__c, Preferred_destination_in_canada__c, refused_a_visa_to_Canada__c,
                                       Previous_and_future_visit_notes__c, Country_of_Citizenship__c, Current_country_of_residence__c, Preferred_language__c,
                                       Office__c, Source_Media__c, Have_Province_Nomination_except_Quebec__c, Is_Client__c, Further_Information__c,
                                       Other_Info_Notes__c, Previously_submitted_an_Express_Entry__c, 
                                       Please_type_a_occupation_1__c, Duration_1__c, Location_1__c, Province_1__c, Currently_working_on_this_job_1__c, 
                                       Job_start_1__c, Job_start_2__c, Job_start_3__c, Job_end_1__c, Job_end_2__c, Job_end_3__c, Type_of_Employment_1__c,
                                       Work_experience_notes__c, spouse_have_any_occupational_experience__c, Please_type_a_occupation_2__c,
                                       Duration_2__c, Location_2__c, Province_2__c, Currently_working_on_this_job_2__c, Type_of_Employment_2__c,
                                       Please_type_a_occupation_3__c, Duration_3__c, Location_3__c, Province_3__c, Currently_working_on_this_job_3__c,
                                       Type_of_Employment_3__c, Please_type_a_occupation_1_Spouse__c, Duration_1_Spouse__c, Location_1_Spouse__c,
                                       Province_1_Spouse__c, Type_of_employment_1_Spouse__c, Please_type_a_occupation_2_Spouse__c,
                                       Duration_2_Spouse__c, Location_2_Spouse__c, Province_2_Spouse__c, Type_of_employment_2_Spouse__c,
                                       Please_type_a_occupation_3_Spouse__c, Duration_3_Spouse__c, Location_3_Spouse__c, Province_3_Spouse__c,
                                       Type_of_employment_3_Spouse__c,
                                       Currently_working_on_this_job_1_Spouse__c, Currently_working_on_this_job_2_Spouse__c, Currently_working_on_this_job_3_Spouse__c,
                                       Job_start_1_Spouse__c, Job_start_2_Spouse__c, Job_start_3_Spouse__c, Job_end_1_Spouse__c, Job_end_2_Spouse__c, Job_end_3_Spouse__c, 
                                       Networth__c, Years_of_managerial_Experience__c, Number_of_staff_managed__c, Own_business__c,
                                       Precentage_of_ownership__c, Annual_sales_CDN__c, Annual_Income_CDN__c, Net_business_assets_CDN__c,
                                       Business_Finance_Notes__c, Education_Notes_Spouse__c, Language_Notes_Spouse__c,
                                       Please_type_a_occupation_1__r.NOC_Details__c, Please_type_a_occupation_2__r.NOC_Details__c, Please_type_a_occupation_3__r.NOC_Details__c,
                                       Please_type_a_occupation_1_Spouse__r.NOC_Details__c, Please_type_a_occupation_2_Spouse__r.NOC_Details__c,
                                       Please_type_a_occupation_3_Spouse__r.NOC_Details__c,
                                       CAge__c, CLevel_of_education__c, COfficial_languages_proficiency__c, Second_Language_EE__c, CCanadian_work_experience__c,
                                       PCLevel_of_education__c, PCOfficial_language_proficiency__c, PCCanadian_Work_Experience__c, Education_and_language__c,
                                       Education_and_Canadian_work__c, Foreign_work_and_language__c, Foreign_work_and_Canadian_work__c,
                                       Siblings_in_Canada__c, Total_EE__c,
                                       Age__c, Education__c, Experience__c, First_Language__c, Second_Language__c, Adaptability__c, 
                                       Employment_job_offer__c, Total__c, CEC_Result__c, Certificate_of_qualification_points__c,
                                       Provincial_or_territorial_nomination__c, French_Additional_Points__c, Post_secondary_education_in_Canada__c, Arranged_employment__c,
                                       Create_Spouse_Assessment__c ,experience_obtained_in_past_5_years_1__c, experience_obtained_in_past_5_years_2__c, 
                                       experience_obtained_in_past_5_years_3__c, FSTW_Result__c/*Pulkit change start*/
                                       ,First_Name_Main_Applicant__c,Last_Name_Main_Applicant__c,Salutation_Main_Applicant__c,
                                       Marital_Status__c,DOB_Main_Applicant__c,E_mail_Main_Applicant__c,Phone_Main_Applicant__c,
                                       Personal_Information_Notes__c,Salutation_Spouse__c,E_mail_Spouse__c,First_Name_Spouse__c
                                       ,DOB_Spouse__c,Last_Name_Spouse__c,Phone_Spouse__c,Type__c,E_mail_Confirmation__c,Type_of_Salary__c,
                                       Salary_Amount__c,Hours_per_week__c,At_least_1_year_of_experience_in_Canada__c,
                                       Company_Location_in_BC__c,employer_5_full_time_employees__c,How_did_you_hear_about_us__c,
                                       Any_Specific_question_or_comment__c,newsletter_subscribe__c,Education_Credential_Assessment__c,
                                       Trade_Certification_in_Canada__c,Institution_Location__c,Do_you_speak_English_or_French__c,
                                       Education_Level__c,employer_3_full_time_employees__c,hourlywagecalc__c,BCPNPDRWE__c,BCPNPHLE__c,
                                       BCPNPLanguage__c,BCPNPRDE__c,BCPNPskilllevel__c,BCPNPWage__c,BCPNPTotal__c,Directly_Related_Work_Experience__c,
                                       BCPNPOOBonus__c,BCPNPCurrentlyWorking__c,BCPNPAtleast1Yearexp__c,BCPNPPostBC__c,BCPNPPostCanada__c,
                                       BCPNPECA__c,BCPNPICA__c,BCPNPEcoSub__c,BCPNPHumCap__c,SkilledWorkingExperience__c,BCPNPSkilledWS__c,BCPNPSGS__c
                                       /*Pulkit change end*/
                                       FROM assessment__c WHERE Id = : selectedAsmtId];
        if(astList.size() > 0){
            assessment = astList[0];
        }
        
        // Showing main applicant & spouse age in years, months & days
        // Pulkit Change Start
        // Taking dob from Assesment
 		
        if(assessment != null && assessment.DOB_Main_Applicant__c != null)
        {
            dobOutputMainApplicant = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(assessment.DOB_Main_Applicant__c, System.today());
            mainApplicantDOB = AssessmentPanelScreenUtility.convertToString(assessment.DOB_Main_Applicant__c);
        }
        else
        {
            assessment.DOB_Main_Applicant__c = mainApplicantAcc?.DOB__c;
            dobOutputMainApplicant = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(mainApplicantAcc?.DOB__c, System.today());
            mainApplicantDOB = AssessmentPanelScreenUtility.convertToString(mainApplicantAcc?.DOB__c);
        }
        
        
        //setting up date fields of Occupation tab
        jobStart1 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_1__c);
        jobEnd1 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_1__c);
        jobStart2 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_2__c);
        jobEnd2 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_2__c);
        jobStart3 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_3__c);
        jobEnd3 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_3__c);
        String csheetIdBiz = '';
        
        csheetIdBiz = [SELECT Consultation_Sheet__r.Id,Type__c,E_mail_Confirmation__c from assessment__c WHERE Id = : selectedAsmtId]?.Consultation_Sheet__r?.Id;
        System.debug('csheetIdBiz: '+ csheetIdBiz);
        
        if(csheetIdBiz != null && csheetIdBiz != ''){
            cSheetBiz = [SELECT Id, Name, Funds_Already_Available__c, On_the_Name_of_Main_Applicant__c, Funds_for_PR_Comments__c,
                         Funds_AvailableImmigration__c, How_Paying_For_Studies__c, Sponsor__c, FundsAvailableStudy__c, 
                         Tax_Return_Files_Available__c, Other_Source_Of_Income__c, Average_Salary__c, Annual_Salary_Main_for_spouse__c, Funds_for_Visa_Comments__c,
                         Points_Estimation_Federal__c, Points_Estimation_Provincial__c, Program_Eligibility__c, If_Others_please_inform__c,
                         Education_option__c, School_Option__c, Program_Type__c, Intake__c, Education_CommentsAssessment__c,
                         Overall_Qualification__c, Rating__c, Details__c, Referral_List__c, Other_Info__c
                         FROM Consultation_Sheet__c WHERE Id = :csheetIdBiz];
        }
        else{
            cSheetBiz = new Consultation_Sheet__c();
        }
        
        
        // Setting Selected test type for Main Applicant
        selectedTestType = assessment?.English_test_type__c;
        // Setting Speak/Read/Write/Listen values in Language Main Applicant picklist
        enSpeakList = AssessmentPanelScreenUtility.setPicklistValues(enSpeakOption, selectedTestType);
        enReadList = AssessmentPanelScreenUtility.setPicklistValues(enReadOption, selectedTestType);
        enWriteList = AssessmentPanelScreenUtility.setPicklistValues(enWriteOption, selectedTestType);
        enListenList = AssessmentPanelScreenUtility.setPicklistValues(enListenOption, selectedTestType);
        
        // Setting up Language Section custom dependent picklist values
        
        enSpeakValue = assessment?.English_speaking__c;
        enReadValue = assessment?.English_reading__c;
        enWriteValue = assessment?.English_Writing__c;
        enListenValue = assessment?.English_Listening__c;
        
        // Setting French(read/write/listen/speak) picklist Main Applicant values
        frSpeakList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_speaking__c', assessment?.Have_you_done_TEF__c);
        frReadList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_reading__c', assessment?.Have_you_done_TEF__c);
        frWriteList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_Writing__c', assessment?.Have_you_done_TEF__c);
        frListenList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_Listening__c', assessment?.Have_you_done_TEF__c);
        
        // Setting French French(read/write/listen/speak) selected value
        frSpeakValue = assessment?.French_speaking__c;
        frReadValue = assessment?.French_reading__c;
        frWriteValue = assessment?.French_Writing__c;
        frListenValue = assessment?.French_Listening__c;
        
        // Setting French(read/write/listen/speak) picklist Spouse values
        frSpeakListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_speaking_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        frReadListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_reading_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        frWriteListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_Writing_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        frListenListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_Listening_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        
        // Setting French French(read/write/listen/speak) selected value
        frSpeakValueSP = assessment?.French_speaking_Spouse__c;
        frReadValueSP = assessment?.French_reading_Spouse__c;
        frWriteValueSP = assessment?.French_Writing_Spouse__c;
        frListenValueSP = assessment?.French_Listening_Spouse__c;
        
        // Setting up the nocdetails with labels in occupations tab
        nocDetails1 = assessment.Please_type_a_occupation_1__r.NOC_Details__c;
        if(assessment == Null){
            assessment = new assessment__c();
        }
        //Handling profile fields editability main applicant
        //Pulkit Change Start
        if(assessment != null && String.isNotBlank(assessment.Salutation_Main_Applicant__c)){ 
            isSalutation = true;
        }
        else if(String.isNotBlank(mainApplicantAcc.Salutation__c)){
            assessment.Salutation_Main_Applicant__c = mainApplicantAcc.Salutation__c;
            isSalutation = true;
        }
        else{
            isSalutation = false;
        }
        if(assessment != null && String.isNotBlank(assessment.First_Name_Main_Applicant__c))
        {
            isFirstName = true;
        }
        else if(String.isNotBlank(mainApplicantAcc.First_Name__c)){
            assessment.First_Name_Main_Applicant__c = mainApplicantAcc.First_Name__c;
            isFirstName = true;
        }
        else{
            isFirstName = false;
        }
        
        if(assessment != null && String.isNotBlank(assessment.Last_Name_Main_Applicant__c))
        {
            isLastName = true;
        }
        
        else if(String.isNotBlank(mainApplicantAcc.Last_Name__c)){
            assessment.Last_Name_Main_Applicant__c = mainApplicantAcc.Last_Name__c;
            isLastName = true;
        }
        else{
            isLastName = false;
        }
        if(mainApplicantAcc.Personal_Information_Notes__c != null && assessment.Personal_Information_Notes__c == null)
            assessment.Personal_Information_Notes__c = mainApplicantAcc.Personal_Information_Notes__c;
        if(mainApplicantAcc.e_mail__c != null && assessment.E_mail_Main_Applicant__c == null)
        {
            assessment.E_mail_Main_Applicant__c = mainApplicantAcc.e_mail__c;
            assessment.E_mail_Confirmation__c = mainApplicantAcc.e_mail__c;
        }
            
        if(mainApplicantAcc.Phone != null && assessment.Phone_Main_Applicant__c == null)
            assessment.Phone_Main_Applicant__c = mainApplicantAcc.Phone;
        if(assessment!= null)
        {
            if(assessment.Education_Level__c != null)
                assessment.Education_Level__c = assessment.Education_Level__c;
            if(assessment.Currently_working_on_this_job_1__c != null)
                assessment.Currently_working_on_this_job_1__c = assessment.Currently_working_on_this_job_1__c;
            if(assessment.Type_of_Salary__c != null)
                assessment.Type_of_Salary__c = assessment.Type_of_Salary__c;
            if(assessment.Salary_Amount__c != null)
                assessment.Salary_Amount__c = assessment.Salary_Amount__c;
            if(assessment.Hours_per_week__c != null)
                assessment.Hours_per_week__c = assessment.Hours_per_week__c;
            if(assessment.Duration_1__c != null)
                assessment.Duration_1__c = assessment.Duration_1__c;
            if(assessment.At_least_1_year_of_experience_in_Canada__c != null)
                assessment.At_least_1_year_of_experience_in_Canada__c = assessment.At_least_1_year_of_experience_in_Canada__c;
            if(assessment.Company_Location_in_BC__c != null)
                assessment.Company_Location_in_BC__c = assessment.Company_Location_in_BC__c;
            if(assessment.employer_5_full_time_employees__c != null)
                assessment.employer_5_full_time_employees__c = assessment.employer_5_full_time_employees__c;
            if(assessment.employer_3_full_time_employees__c != null)
                assessment.employer_3_full_time_employees__c = assessment.employer_3_full_time_employees__c;
            if(assessment.Name_of_diploma1__c != null)
                assessment.Name_of_diploma1__c = assessment.Name_of_diploma1__c;
            if(assessment.Country_of_studies__c != null)
                assessment.Country_of_studies__c = assessment.Country_of_studies__c;
            if(assessment.Education_Credential_Assessment__c != null)
                assessment.Education_Credential_Assessment__c = assessment.Education_Credential_Assessment__c;
            if(assessment.Trade_Certification_in_Canada__c != null)
                assessment.Trade_Certification_in_Canada__c = assessment.Trade_Certification_in_Canada__c;
            if(assessment.Type_of_educational_institute__c != null)
                assessment.Type_of_educational_institute__c = assessment.Type_of_educational_institute__c;
            if(assessment.Institution_Location__c != null)
                assessment.Institution_Location__c = assessment.Institution_Location__c;
            if(assessment.How_did_you_hear_about_us__c != null)
                assessment.How_did_you_hear_about_us__c = assessment.How_did_you_hear_about_us__c;
            if(assessment.Any_Specific_question_or_comment__c != null)
                assessment.Any_Specific_question_or_comment__c = assessment.Any_Specific_question_or_comment__c;
            if(assessment.newsletter_subscribe__c != null)
                assessment.newsletter_subscribe__c = assessment.newsletter_subscribe__c;
            hourlywagecalc();
                
        }
        
        
        // handling profile field editability for spouse account
        
        //Pulkit Change End// End - of consultation save    
    }
     // Method to handle back button of Consultation details tab's screen-2 
    public void backtoConsultationList(){
        consTab = true;
    }
    
    // Method to create new Assessment form consultation Details Tab's Screen-2
    public PageReference startNewAssessment(){
        // on the click of 'Start New Assessment':  before leaving the consultation details tab update/insert the consultation sheet
        try {
            if(cSheetDetail.Account__c == NULL || cSheetDetail.Opportunity__c == NULL){
                String emsg = AssessmentPanelScreenUtility.checkRequiredFieldsCSTab(cSheetDetail);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, emsg));
                tabDisableSet = '0';
            }
            else if(cSheetDetail.Account__c != NULL && cSheetDetail.Opportunity__c != NULL && cSheetDetail.Id != NULL){
                update cSheetDetail;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Consultation Sheet Successfully Updated!'));
                //Start new Assessment
                String base = '/apex/AssessmentRedirectionPage?accountId='+accountId+'&origin=bcpnpbtn&consultationId='+cSheetDetail.Id;
                System.debug('base: '+base);
                PageReference pageRef = new PageReference(base);
                pageRef.setRedirect(true);
                return pageRef;
                //createNewAssessment();
                //assessment.Consultation_Sheet__c = selectedCsheetId; //pulkit commented
            }
            else if(cSheetDetail.Account__c != NULL && cSheetDetail.Opportunity__c != NULL && cSheetDetail.Id == NULL){
                insert cSheetDetail;
                selectedCsheetId = cSheetDetail.Id;
                // To refresh the consultation sheet & gets its name and other fields
                cSheetDetail = [SELECT Id, Name, Account__c, Source__c, Opportunity__c, Consultation_Status__c, 
                                Assessment_for__c, Seeking_Consultation_on_the_Matter_of__c, Time_Projected__c, 
                                Province_of_Interest__c, Location__c, Date__c, Consultant_Notes__c,
                                City_Province__c, Outside_Country_of_Citizenship__c, Country__c, Status__c, Status_Expiration_Date__c, LastModifiedBy.Name, LastModifiedDate,
                                Preferred_Language__c, Marital_Status__c, How_many_children__c, Canadian_or_PR_Spouse__c, Child_below_5__c, Child_5_to_13yrs_old__c, Child_13_to_21yrs_old__c,
								(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessments__r order by createdDate DESC)
                                FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
                
                // setting up date fields 05 July 2021
                csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
                timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
                statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
                // Refresh the List of consultations in tab - 1
                cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c, (SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessments__r order by createdDate DESC) 
                           FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
                
                //Refresh the assessments without consultation on tab 1
                asmts = [SELECT Id, Name, Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c,E_mail_Confirmation__c FROM Assessment__c 
                         WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Consultation Sheet Successfully Created!'));
                //Start new Assessment
                //Pulkit added
                String base = '/apex/AssessmentRedirectionPage?accountId='+accountId+'&origin=bcpnpbtn&consultationId='+selectedCsheetId;
                System.debug('base: '+base);
                PageReference pageRef = new PageReference(base);
                pageRef.setRedirect(true);
                return pageRef;
                //Commented
                //createNewAssessment();
                //assessment.Consultation_Sheet__c = selectedCsheetId;
            }
            return null;
            
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Error Occured'));
            System.debug('Exception Csheet Update: '+ ex.getMessage()+' Line Number: '+ex.getLineNumber());
            return null;
        }
    }
    
    public void onCSTabClick(){
        tabOpt = 'cdetailTab';
    }
    
    //Method for creating new Assessment
    public void createNewAssessment(){
        //Enabling Profile Tab
        tabDisableSet = '01234';
        //Move to the profile tab
        tabOpt = 'profile';
        assessment = new assessment__c();
        
        //Query to Main Applicant Account
        mainApplicantAcc = [SELECT Id, First_Name__c, Last_Name__c, Salutation__c, Marital_Status__c, DOB__c, Personal_Information_Notes__c, e_mail__c, Phone, ParentId FROM Account
                            WHERE Id = :accountId LIMIT 1];
        if(mainApplicantAcc == NULL){
            mainApplicantAcc = new Account();
        }
        
        List<Account> spActList = [SELECT Id, First_Name__c, Last_Name__c, Salutation__c, DOB__c, e_mail__c, Phone FROM Account WHERE 
                                   ParentId =: accountId LIMIT 1];
        
        if(spActList.size() == 0 || spActList.isEmpty()){
            spActList = [SELECT Id, First_Name__c, Last_Name__c, Salutation__c, DOB__c, e_mail__c, Phone FROM Account WHERE 
                         Id =: mainApplicantAcc.ParentId LIMIT 1];
        }
        if(spActList.size()>0){
            spouseAcc = spActList[0];
        }
        
        
        if(spouseAcc == NULL){
            spouseAcc = new Account();
        }
        
        //Handling profile fields editability main applicant
        //Pulkit Change Start
        if(String.isNotBlank(mainApplicantAcc.Salutation__c)){
            assessment.Salutation_Main_Applicant__c = mainApplicantAcc.Salutation__c;
            isSalutation = true;
        }
        else{
            isSalutation = false;
        }
        
        if(String.isNotBlank(mainApplicantAcc.First_Name__c)){
            assessment.First_Name_Main_Applicant__c = mainApplicantAcc.First_Name__c;
            isFirstName = true;
        }
        else{
            isFirstName = false;
        }
        
        if(String.isNotBlank(mainApplicantAcc.Last_Name__c)){
            assessment.Last_Name_Main_Applicant__c = mainApplicantAcc.Last_Name__c;
            isLastName = true;
        }
        else{
            isLastName = false;
        }
        if(String.isNotBlank(mainApplicantAcc.Marital_Status__c))
        {
            assessment.Marital_Status__c = mainApplicantAcc.Marital_Status__c;
        }
        if(mainApplicantAcc.e_mail__c != null)
        {
            assessment.E_mail_Main_Applicant__c = mainApplicantAcc.e_mail__c;
            assessment.E_mail_Confirmation__c = mainApplicantAcc.e_mail__c;
        }
            
        if(mainApplicantAcc.Phone != null)
            assessment.Phone_Main_Applicant__c = mainApplicantAcc.Phone;
        if(mainApplicantAcc.Personal_Information_Notes__c != null)
            assessment.Personal_Information_Notes__c = mainApplicantAcc.Personal_Information_Notes__c;
        
        // handling profile field editability for spouse account
        // Setting up date fields for spouse, main applicant
        assessment.Id = null;
        assessment.Account__c = mainApplicantAcc?.Id;
        if(csId != null){
            assessment.Consultation_Sheet__c = csId;
        }
        if(String.isNotBlank(eeId))
        {
            assessment__c expAsmt = [Select id,E_mail_Main_Applicant__c,First_Name_Main_Applicant__c,Last_Name_Main_Applicant__c,Please_type_a_occupation_1__c,
                                     Currently_working_on_this_job_1__c,Location_1__c,Duration_1__c,Province_1__c,
                                     Country_of_studies__c,Name_of_diploma1__c,Post_secondaries_in_canada__c,Type_of_educational_institute__c,English_test_type__c,
                                     English_speaking__c,English_reading__c,English_Writing__c,English_Listening__c,French_speaking__c,French_reading__c,French_Writing__c,
                                     French_Listening__c,Have_you_done_TEF__c,Do_you_speak_French__c,Do_you_speak_English__c,Level_of_education__c from assessment__c where id =: eeId limit 1];
            
            if(String.isNotBlank(expAsmt.First_Name_Main_Applicant__c))
                assessment.First_Name_Main_Applicant__c = expAsmt.First_Name_Main_Applicant__c;
            if(String.isNotBlank(expAsmt.Last_Name_Main_Applicant__c))
                assessment.Last_Name_Main_Applicant__c = expAsmt.Last_Name_Main_Applicant__c;
            if(String.isNotBlank(expAsmt.E_mail_Main_Applicant__c))
            {
                assessment.E_mail_Main_Applicant__c = expAsmt.E_mail_Main_Applicant__c;
                assessment.E_mail_Confirmation__c = expAsmt.E_mail_Main_Applicant__c;
            }
            if(expAsmt.Please_type_a_occupation_1__c != null)
            {
                assessment.Please_type_a_occupation_1__c = expAsmt.Please_type_a_occupation_1__c;
                handleNOC1();
            }
                
            if(expAsmt.Currently_working_on_this_job_1__c != null)
                assessment.Currently_working_on_this_job_1__c = expAsmt.Currently_working_on_this_job_1__c;
            if(expAsmt.Duration_1__c != null && expAsmt.Location_1__c != null)
            {
                if(expAsmt.Location_1__c == 'In Canada')
                {
                    if(expAsmt.Duration_1__c == '1 year or more, but less than 2 years' || expAsmt.Duration_1__c == '2 year or more, but less than 3 years' || expAsmt.Duration_1__c == '3 year or more, but less than 4 years'
                       || expAsmt.Duration_1__c == '4 years or more, but less than 5 years' || expAsmt.Duration_1__c == '5 years or more, but less than 6 years' || expAsmt.Duration_1__c == '6 years or more')
                    {
                        assessment.At_least_1_year_of_experience_in_Canada__c = 'Yes';    
                    }
                    else
                        assessment.At_least_1_year_of_experience_in_Canada__c = 'No';
                    
                }
                else
                    assessment.At_least_1_year_of_experience_in_Canada__c = 'No';
            }
            if(expAsmt.Country_of_studies__c != null)
                assessment.Country_of_studies__c = expAsmt.Country_of_studies__c;
            if(expAsmt.Name_of_diploma1__c != null)
                assessment.Name_of_diploma1__c = expAsmt.Name_of_diploma1__c;
            if(expAsmt.Type_of_educational_institute__c != null)
                assessment.Type_of_educational_institute__c = expAsmt.Type_of_educational_institute__c;
            if(String.isNotBlank(expAsmt.Level_of_education__c))
            {
                if(expAsmt.Level_of_education__c == 'Below high school diploma')
                    assessment.Education_Level__c = 'Below High School';
                if(expAsmt.Level_of_education__c == 'High school diploma')
                    assessment.Education_Level__c = 'High School';
                if(expAsmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)')
                    assessment.Education_Level__c = '1-year Diploma / Certificate';
                if(expAsmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)')
                    assessment.Education_Level__c = '2-year Diploma';
                if(expAsmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)')
                    assessment.Education_Level__c = 'Bachelor / Licenciature';
                if(expAsmt.Level_of_education__c == 'Masters Degree or Professional Degree')
                    assessment.Education_Level__c = 'Masters';
                if(expAsmt.Level_of_education__c == 'Ph. D.')
                    assessment.Education_Level__c = 'Doctor Degree (PhD)';
            }
            if(expAsmt.Do_you_speak_English__c != null && expAsmt.Do_you_speak_English__c == 'Yes' && expAsmt.Do_you_speak_French__c != null && 
              expAsmt.Do_you_speak_French__c == 'Yes')
                assessment.Do_you_speak_English_or_French__c = 'Both';
            else if(expAsmt.Do_you_speak_English__c != null && expAsmt.Do_you_speak_English__c == 'Yes')
                assessment.Do_you_speak_English_or_French__c = 'English';
            else if(expAsmt.Do_you_speak_French__c != null && expAsmt.Do_you_speak_French__c == 'Yes')
                assessment.Do_you_speak_English_or_French__c = 'French';
            else
                assessment.Do_you_speak_English_or_French__c = null;
            
            String obj = 'assessment__c';
            // Getting Picklist values for English Language-test type 
            selectedTestTypeList = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_test_type__c');
            // getting all picklist values for speak/read/Write/listen
            List<SelectOption> enSpeakOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_speaking__c');
            List<SelectOption> enReadOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_reading__c');
            List<SelectOption> enWriteOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Writing__c');
            List<SelectOption> enListenOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Listening__c');
            
            
            // Setting Selected test type for Main Applicant
            selectedTestType = expAsmt?.English_test_type__c;
            assessment.English_test_type__c = expAsmt?.English_test_type__c;
            // Setting Speak/Read/Write/Listen values in Language Main Applicant picklist
            enSpeakList = AssessmentPanelScreenUtility.setPicklistValues(enSpeakOption, selectedTestType);
            enReadList = AssessmentPanelScreenUtility.setPicklistValues(enReadOption, selectedTestType);
            enWriteList = AssessmentPanelScreenUtility.setPicklistValues(enWriteOption, selectedTestType);
            enListenList = AssessmentPanelScreenUtility.setPicklistValues(enListenOption, selectedTestType);
            
            // Setting up Language Section custom dependent picklist values
            
            enSpeakValue = expAsmt?.English_speaking__c;
            assessment.English_speaking__c = expAsmt?.English_speaking__c;
            enReadValue = expAsmt?.English_reading__c;
            assessment.English_reading__c = expAsmt?.English_reading__c;
            enWriteValue = expAsmt?.English_Writing__c;
            assessment.English_Writing__c = expAsmt?.English_Writing__c;
            enListenValue = expAsmt?.English_Listening__c;
            assessment.English_Listening__c = expAsmt?.English_Listening__c;
            
            // Setting French(read/write/listen/speak) picklist Main Applicant values
            frSpeakList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_speaking__c', expAsmt?.Have_you_done_TEF__c);
            frReadList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_reading__c', expAsmt?.Have_you_done_TEF__c);
            frWriteList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_Writing__c', expAsmt?.Have_you_done_TEF__c);
            frListenList = AssessmentPanelScreenUtility.setFrenchPicklistValues('assessment__c', 'French_Listening__c', expAsmt?.Have_you_done_TEF__c);
            assessment.Have_you_done_TEF__c = expAsmt?.Have_you_done_TEF__c;
            
            // Setting French French(read/write/listen/speak) selected value
            frSpeakValue = expAsmt?.French_speaking__c;
            assessment.French_speaking__c = expAsmt?.French_speaking__c;
            frReadValue = expAsmt?.French_reading__c;
            assessment.French_reading__c = expAsmt?.French_reading__c;
            frWriteValue = expAsmt?.French_Writing__c;
            assessment.French_Writing__c = expAsmt?.French_Writing__c;
            frListenValue = expAsmt?.French_Listening__c;
            assessment.French_Listening__c = expAsmt?.French_Listening__c;
            
        }
        
    }
    
    
    public void onProflieClick(){
        tabOpt = 'profile';
    }
    
    //Complete this method
    public void onProfileLeave(){
        saveOrUpdateProfile();
    }
    //complete this method
    public pageReference saveOrUpdateProfile(){
        tabDisableSet = '01234'; // Enable all tabs because this button doesn't rerender tabpanel so to resolve NOC Exception this needs to be set all enable
        try{
            
            String errorMsg = BCPNPPanelScreenUtility.checkAllField(assessment);
            if(String.isBlank(errorMsg))
            {
                //Make the dml work here
                assessment.Type__c = 'BCPNP';
                if(assessment.Id != Null){
                    update assessment;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully updated'));
                    calculateAsmtScore();
                }
                else
                {
                    insert assessment;
                    assessment.Id = assessment.Id;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully saved'));
                    calculateAsmtScore();
                }
                    
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMsg));
                
            }
            
        }
        catch(Exception ex)
        {
            System.debug('Exception Occured: '+ex.getMessage()+' in the Line Number: '+ex.getLineNumber());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error occured: '+ex.getMessage()));
        }
        
        // Query ConsultationSheet if assessment created/ updated - to refresh cSheetBiz on Biz/Finance, assessment section
        // And to refresh cSheets, asmts on consultation details tab1 section
        
        String csheetIdBiz = '';
        
        csheetIdBiz = [SELECT Consultation_Sheet__r.Id,Type__c from assessment__c WHERE Id = : assessment.Id]?.Consultation_Sheet__r?.Id;
        System.debug('csheetIdBiz: '+ csheetIdBiz);
        
        if(csheetIdBiz != null && csheetIdBiz != ''){
            cSheetBiz = [SELECT Id, Name, Funds_Already_Available__c, On_the_Name_of_Main_Applicant__c, Funds_for_PR_Comments__c,
                         Funds_AvailableImmigration__c, How_Paying_For_Studies__c, Sponsor__c, FundsAvailableStudy__c, 
                         Tax_Return_Files_Available__c, Other_Source_Of_Income__c, Average_Salary__c, Annual_Salary_Main_for_spouse__c, Funds_for_Visa_Comments__c,
                         Points_Estimation_Federal__c, Points_Estimation_Provincial__c, Program_Eligibility__c, If_Others_please_inform__c,
                         Education_option__c, School_Option__c, Program_Type__c, Intake__c, Education_CommentsAssessment__c,
                         Overall_Qualification__c, Rating__c, Details__c, Referral_List__c, Other_Info__c
                         FROM Consultation_Sheet__c WHERE Id = :csheetIdBiz];
        }
        // Changed Code 02 June 2021 to do proper rerender of consultation
        else{
            cSheetBiz = new Consultation_Sheet__c();
        }
        // Updated the List of consultations in tab - 1
        cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c, (SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC) 
                   FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
        
        //Updated the assessments without consultation on tab 1
        asmts = [SELECT Id, Name, Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessment__c 
                 WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
        
        // Update the consultation and its related assessment on tab 1 screen - 2
        if(!consTab){
            cSheetDetail = [SELECT Id, Name, Account__c, Source__c, Opportunity__c, Consultation_Status__c, 
                            Assessment_for__c, Seeking_Consultation_on_the_Matter_of__c, Time_Projected__c, 
                            Province_of_Interest__c, Location__c, Date__c, Consultant_Notes__c,
                            City_Province__c, Outside_Country_of_Citizenship__c, Country__c, Status__c, Status_Expiration_Date__c, LastModifiedBy.Name, LastModifiedDate,
                            Preferred_Language__c, Marital_Status__c, How_many_children__c, Canadian_or_PR_Spouse__c, Child_below_5__c, Child_5_to_13yrs_old__c, Child_13_to_21yrs_old__c,
							(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC)
                            FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
            // setting up date fields 05 July 2021
            csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
            timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
            statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
        }
        // End of - Query(ConsultationSheet)
        return null;
    }
    //complete this method
    public void handleOnChangeProfile(){
        
        assessment.Currently_working_on_this_job_1__c = assessment.Currently_working_on_this_job_1__c;
        
        assessment.Directly_Related_Work_Experience__c = assessment.Directly_Related_Work_Experience__c;
        
        assessment.At_least_1_year_of_experience_in_Canada__c = assessment.At_least_1_year_of_experience_in_Canada__c;
        
        assessment.employer_5_full_time_employees__c = assessment.employer_5_full_time_employees__c;
        
        assessment.employer_3_full_time_employees__c = assessment.employer_3_full_time_employees__c;
        
        assessment.Education_Level__c = assessment.Education_Level__c;
        
        assessment.Name_of_diploma1__c = assessment.Name_of_diploma1__c;
        
        assessment.Country_of_studies__c = assessment.Country_of_studies__c;
        
        assessment.Education_Credential_Assessment__c = assessment.Education_Credential_Assessment__c;
        
        assessment.Trade_Certification_in_Canada__c = assessment.Trade_Certification_in_Canada__c;
        
        assessment.Type_of_educational_institute__c = assessment.Type_of_educational_institute__c;
        
        assessment.Institution_Location__c = assessment.Institution_Location__c;
        assessment.SkilledWorkingExperience__c = assessment.SkilledWorkingExperience__c;
        
        assessment.English_speaking__c = enSpeakValue;
        assessment.English_reading__c = enReadValue;
        assessment.English_Writing__c = enWriteValue;
        assessment.English_Listening__c = enListenValue;
        
        assessment.French_speaking__c = frSpeakValue;
        assessment.French_reading__c = frReadValue;
        assessment.French_Writing__c = frWriteValue;
        assessment.French_Listening__c = frListenValue;
        
        assessment.How_did_you_hear_about_us__c = assessment.How_did_you_hear_about_us__c;
        assessment.Any_Specific_question_or_comment__c = assessment.Any_Specific_question_or_comment__c;
        assessment.newsletter_subscribe__c = assessment.newsletter_subscribe__c;
        //System.debug('->'+assessment.Currently_working_on_this_job_1__c);
        //System.debug('->'+assessment.Duration_1__c);
        //System.debug('->'+assessment.At_least_1_year_of_experience_in_Canada__c);
        //System.debug('->'+assessment.employer_5_full_time_employees__c);
        //System.debug('->'+assessment.employer_3_full_time_employees__c);
    }
    //complete this method
    public void handleOnChangeProfileRequired(){
        tabOpt = 'profile';
        tabDisableSet = '01234';
        
        assessment.First_Name_Main_Applicant__c = assessment.First_Name_Main_Applicant__c;
   
        assessment.Last_Name_Main_Applicant__c = assessment.Last_Name_Main_Applicant__c;
        
        assessment.E_mail_Main_Applicant__c = assessment.E_mail_Main_Applicant__c;
        
        assessment.E_mail_Confirmation__c = assessment.E_mail_Confirmation__c;
        
        String errormsg = BCPNPPanelScreenUtility.checkRequiredFields(assessment);
        
        if(errormsg != null && errormsg != '')
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsg));
            tabDisableSet = '1';
        }
            
        
    }
    //This method is used for calculation of hourly wage
    public void hourlywagecalc()
    {
        assessment.Type_of_Salary__c = assessment.Type_of_Salary__c;
        assessment.Hours_per_week__c = assessment.Hours_per_week__c;
        assessment.Salary_Amount__c = assessment.Salary_Amount__c;
        
        tabOpt = 'profile';
        
        String errorMsg = BCPNPPanelScreenUtility.checkHourlySalary(assessment);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '1';
        }
        else
            tabDisableSet = '01234';
        
        if(assessment.Type_of_Salary__c =='Hourly' && assessment.Hours_per_week__c > 0 && assessment.Salary_Amount__c>0)
        {
            assessment.hourlywagecalc__c = 'Yearly salary is $'+(52*assessment.Hours_per_week__c*assessment.Salary_Amount__c).setScale(2);
        }
        else if(assessment.Type_of_Salary__c =='Yearly' && assessment.Salary_Amount__c>0 && assessment.Hours_per_week__c>0)
        {
        	assessment.hourlywagecalc__c ='Hourly Salary is $'+(assessment.Salary_Amount__c/(52*assessment.Hours_per_week__c)).setScale(2) ;    
        }
        else
        {
            assessment.hourlywagecalc__c = 'Hourly Salary is $'+0.00;
        }
            
        
    }
    //actionSupport event="onchange" language action support
    public void handleLang(){
        assessment.Do_you_speak_English_or_French__c = assessment.Do_you_speak_English_or_French__c;
        selectedTestTypeList = selectedTestTypeList = AssessmentPanelScreenUtility.getPicklistValues('assessment__c', 'English_test_type__c');
        System.debug('selectedTestType: '+selectedTestType);
        if(assessment.Do_you_speak_English_or_French__c != 'English' && assessment.Do_you_speak_English_or_French__c != 'Both'){
            assessment.English_test_type__c = null;
            assessment.English_speaking__c = null;
            assessment.English_reading__c = null;
            assessment.English_Writing__c = null;
            assessment.English_Listening__c = null;
        }
        else if(assessment.Do_you_speak_English_or_French__c != 'French' && assessment.Do_you_speak_English_or_French__c != 'Both')
        {
            assessment.Have_you_done_TEF__c = null;
            assessment.French_speaking__c = null;
            assessment.French_reading__c = null;
            assessment.French_Writing__c = null;
            assessment.French_Listening__c = null;
        
            //frSpeakList = null;
            //frReadList = null;
            //frWriteList = null;
            //frListenList = null;
        }
        else{
            selectedTestType = null;
            selectedTestTypeList = selectedTestTypeList = AssessmentPanelScreenUtility.getPicklistValues('assessment__c', 'English_test_type__c');
            enSpeakList = null;
            enReadList = null;
            enWriteList = null;
            enListenList = null;
            
            frSpeakList = null;
            frReadList = null;
            frWriteList = null;
            frListenList = null;
            
            assessment.English_test_type__c = null;
            assessment.English_speaking__c = null;
            assessment.English_reading__c = null;
            assessment.English_Writing__c = null;
            assessment.English_Listening__c = null;
            
            assessment.Have_you_done_TEF__c = null;
            assessment.French_speaking__c = null;
            assessment.French_reading__c = null;
            assessment.French_Writing__c = null;
            assessment.French_Listening__c = null;
        }
        
    }
    public void handleNOC1(){
        tabDisableSet = '01234';
        tabOpt = 'profile';
        assessment.Please_type_a_occupation_1__c = assessment.Please_type_a_occupation_1__c;
        if(assessment.Please_type_a_occupation_1__c != null){
            nocDetails1 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                           WHERE Id = :assessment.Please_type_a_occupation_1__c][0].NOC_Details__c;
        }
        else{
            nocDetails1 = null;
        }
        
    }
    
    public void companyLocationChange()
    {
        assessment.Company_Location_in_BC__c = assessment.Company_Location_in_BC__c;
        if(String.isBlank(assessment.Company_Location_in_BC__c))
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Select the Company Location'));
            tabDisableSet = '1';
            tabOpt = 'profile';
        }
        else
        {
            tabDisableSet = '01234';
            tabOpt = 'profile';
        }
            
    }
    
    public void onasmtTabClick(){
        tabOpt = 'asmtTab';
        //calculateAsmtScore();
    }
    
    public void handleOnChangeasmtTab(){
        tabOpt = 'asmtTab';
        cSheetBiz.Points_Estimation_Federal__c = cSheetBiz.Points_Estimation_Federal__c;
        cSheetBiz.Points_Estimation_Provincial__c = cSheetBiz.Points_Estimation_Provincial__c;
        cSheetBiz.Program_Eligibility__c = cSheetBiz.Program_Eligibility__c;
        cSheetBiz.If_Others_please_inform__c = cSheetBiz.If_Others_please_inform__c;
        cSheetBiz.Education_option__c = cSheetBiz.Education_option__c;
        cSheetBiz.School_Option__c = cSheetBiz.School_Option__c;
        cSheetBiz.Program_Type__c = cSheetBiz.Program_Type__c;
        cSheetBiz.Intake__c = cSheetBiz.Intake__c;
        cSheetBiz.Education_CommentsAssessment__c = cSheetBiz.Education_CommentsAssessment__c;
        cSheetBiz.Overall_Qualification__c = cSheetBiz.Overall_Qualification__c;
        cSheetBiz.Rating__c = cSheetBiz.Rating__c;
        cSheetBiz.Details__c = cSheetBiz.Details__c;
        cSheetBiz.Referral_List__c = cSheetBiz.Referral_List__c;
        cSheetBiz.Other_Info__c = cSheetBiz.Other_Info__c;        
    }
    
    public void saveAsmtTab(){
        try{
            if(cSheetBiz.Id != null){
                update cSheetBiz;
            }
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Assessment updated successfully!'));
        }
        catch(Exception ex){
            System.debug('Exception occured: '+ex.getMessage()+' Line Nunber: '+ex.getLineNumber());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error occured: '+ex.getMessage()));
        }
    }
    
    public void onasmtTabLeave(){
        saveAsmtTab();
    }
    
    //Complete the method
    public void calculateAsmtScore(){
        List<assessment__c> asmtList = new List<assessment__c>();
        asmtList.add(assessment);
        String statusMsg = BCPNPScoreCalculator.calcPoints(asmtList);
        List<assessment__c> astList =[SELECT Id, Account__c, Spouse_Partner__c, French_first_language__c, French_first_language_Spouse__c, Name, Consultation_Sheet__c, Number_of_children__c, Child_s_Birth1__c, Child_s_Birth2__c, Child_s_Birth3__c,
                                       Child_s_Birth4__c, Child_s_Birth5__c, Child_s_Birth6__c, Child_s_Name1__c, Child_s_Name2__c	, Child_s_Name3__c, Child_s_Name4__c, Child_s_Name5__c,
                                       Child_s_Name6__c, Children_Notes__c, Immigrate__c, Work__c, Study__c, Invest__c, Not_Sure__c,
									   Level_of_education__c, Name_of_diploma1__c,
                                       Name_of_diploma2__c, Country_of_studies__c, Post_secondaries_in_canada__c, Type_of_educational_institute__c, Post_secondary_studies__c,
                                       Name_of_bachelor_s_degree__c, Education_Notes__c, Level_of_education_Spouse__c, Name_of_diploma1_Spouse__c, Name_of_diploma2_Spouse__c,
                                       Country_of_studies_Spouse__c, Post_secondaries_in_canada_Spouse__c, Type_of_educational_institute_Spouse__c,
                                       Post_secondary_studies_Spouse__c, Name_of_bachelor_s_degree_Spouse__c, Do_you_speak_English__c, English_test_type__c,
                                       English_speaking__c, English_reading__c, English_Writing__c, English_Listening__c, Do_you_speak_French__c,
                                       Have_you_done_TEF__c, French_speaking__c, French_reading__c, French_Writing__c, French_Listening__c, Language_Notes__c, 
                                       Do_you_speak_English_Spouse__c, English_test_type_Spouse__c, English_speaking_Spouse__c, English_reading_Spouse__c,
                                       English_Writing_Spouse__c, English_Listening_Spouse__c, Do_you_speak_French_Spouse__c, Have_you_done_TEF_Spouse__c,
                                       French_speaking_Spouse__c, French_reading_Spouse__c, French_Writing_Spouse__c, French_Listening_Spouse__c,have_been_canada_as_temp_worker__c,
                                       Certificate_of_Qualification_from_Canada__c, Have_you_received_an_LMIA__c, NOC_received__c, Work_In_Canada_Notes__c, Relatives_In_Canada_List__c,
                                       Does_this_relation_wish_to_sponsor_you__c, Sponsor_s_age__c, Sponsor_s_employment_status__c, Sponsor_s_family_size__c, 
                                       Sponsor_s_annual_income__c, Currently_a_full_time_student__c, Have_been_a_dependent_child_since_before__c, Family_Relation_Notes__c,
                                       Have_previously_visited_canada__c, Have_previously_applied_Immigration__c, Preferred_destination_in_canada__c, refused_a_visa_to_Canada__c,
                                       Previous_and_future_visit_notes__c, Country_of_Citizenship__c, Current_country_of_residence__c, Preferred_language__c,
                                       Office__c, Source_Media__c, Have_Province_Nomination_except_Quebec__c, Is_Client__c, Further_Information__c,
                                       Other_Info_Notes__c, Previously_submitted_an_Express_Entry__c, 
                                       Please_type_a_occupation_1__c, Duration_1__c, Location_1__c, Province_1__c, Currently_working_on_this_job_1__c, 
                                       Job_start_1__c, Job_start_2__c, Job_start_3__c, Job_end_1__c, Job_end_2__c, Job_end_3__c, Type_of_Employment_1__c,
                                       Work_experience_notes__c, spouse_have_any_occupational_experience__c, Please_type_a_occupation_2__c,
                                       Duration_2__c, Location_2__c, Province_2__c, Currently_working_on_this_job_2__c, Type_of_Employment_2__c,
                                       Please_type_a_occupation_3__c, Duration_3__c, Location_3__c, Province_3__c, Currently_working_on_this_job_3__c,
                                       Type_of_Employment_3__c, Please_type_a_occupation_1_Spouse__c, Duration_1_Spouse__c, Location_1_Spouse__c,
                                       Province_1_Spouse__c, Type_of_employment_1_Spouse__c, Please_type_a_occupation_2_Spouse__c,
                                       Duration_2_Spouse__c, Location_2_Spouse__c, Province_2_Spouse__c, Type_of_employment_2_Spouse__c,
                                       Please_type_a_occupation_3_Spouse__c, Duration_3_Spouse__c, Location_3_Spouse__c, Province_3_Spouse__c,
                                       Type_of_employment_3_Spouse__c,
                                       Currently_working_on_this_job_1_Spouse__c, Currently_working_on_this_job_2_Spouse__c, Currently_working_on_this_job_3_Spouse__c,
                                       Job_start_1_Spouse__c, Job_start_2_Spouse__c, Job_start_3_Spouse__c, Job_end_1_Spouse__c, Job_end_2_Spouse__c, Job_end_3_Spouse__c, 
                                       Networth__c, Years_of_managerial_Experience__c, Number_of_staff_managed__c, Own_business__c,
                                       Precentage_of_ownership__c, Annual_sales_CDN__c, Annual_Income_CDN__c, Net_business_assets_CDN__c,
                                       Business_Finance_Notes__c, Education_Notes_Spouse__c, Language_Notes_Spouse__c,
                                       Please_type_a_occupation_1__r.NOC_Details__c, Please_type_a_occupation_2__r.NOC_Details__c, Please_type_a_occupation_3__r.NOC_Details__c,
                                       Please_type_a_occupation_1_Spouse__r.NOC_Details__c, Please_type_a_occupation_2_Spouse__r.NOC_Details__c,
                                       Please_type_a_occupation_3_Spouse__r.NOC_Details__c,
                                       CAge__c, CLevel_of_education__c, COfficial_languages_proficiency__c, Second_Language_EE__c, CCanadian_work_experience__c,
                                       PCLevel_of_education__c, PCOfficial_language_proficiency__c, PCCanadian_Work_Experience__c, Education_and_language__c,
                                       Education_and_Canadian_work__c, Foreign_work_and_language__c, Foreign_work_and_Canadian_work__c,
                                       Siblings_in_Canada__c, Total_EE__c,
                                       Age__c, Education__c, Experience__c, First_Language__c, Second_Language__c, Adaptability__c, 
                                       Employment_job_offer__c, Total__c, CEC_Result__c, Certificate_of_qualification_points__c,
                                       Provincial_or_territorial_nomination__c, French_Additional_Points__c, Post_secondary_education_in_Canada__c, Arranged_employment__c,
                                       Create_Spouse_Assessment__c ,experience_obtained_in_past_5_years_1__c, experience_obtained_in_past_5_years_2__c, 
                                       experience_obtained_in_past_5_years_3__c, FSTW_Result__c/*Pulkit change start*/
                                       ,First_Name_Main_Applicant__c,Last_Name_Main_Applicant__c,Salutation_Main_Applicant__c,
                                       Marital_Status__c,DOB_Main_Applicant__c,E_mail_Main_Applicant__c,Phone_Main_Applicant__c,
                                       Personal_Information_Notes__c,Salutation_Spouse__c,E_mail_Spouse__c,First_Name_Spouse__c
                                       ,DOB_Spouse__c,Last_Name_Spouse__c,Phone_Spouse__c,Type__c,E_mail_Confirmation__c,Type_of_Salary__c,
                                       Salary_Amount__c,Hours_per_week__c,At_least_1_year_of_experience_in_Canada__c,
                                       Company_Location_in_BC__c,employer_5_full_time_employees__c,How_did_you_hear_about_us__c,
                                       Any_Specific_question_or_comment__c,newsletter_subscribe__c,Education_Credential_Assessment__c,
                                       Trade_Certification_in_Canada__c,Institution_Location__c,Do_you_speak_English_or_French__c,
                                       Education_Level__c,employer_3_full_time_employees__c,hourlywagecalc__c,BCPNPDRWE__c,BCPNPHLE__c,
                                       BCPNPLanguage__c,BCPNPRDE__c,BCPNPskilllevel__c,BCPNPWage__c,BCPNPTotal__c,Directly_Related_Work_Experience__c,
                                       BCPNPOOBonus__c,BCPNPCurrentlyWorking__c,BCPNPAtleast1Yearexp__c,BCPNPPostBC__c,BCPNPPostCanada__c,
                                       BCPNPECA__c,BCPNPICA__c,BCPNPEcoSub__c,BCPNPHumCap__c,SkilledWorkingExperience__c,BCPNPSkilledWS__c,BCPNPSGS__c
                                       /*Pulkit change end*/
                                       FROM assessment__c WHERE Id = : assessment.Id];
        if(astList.size() > 0){
            assessment = astList[0];
        }
        if(statusMsg.contains('successfully')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, statusMsg));
        }
        else if(statusMsg.contains('Exception')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, statusMsg));
        }
        
    }
    
    // Method to handle Language Test Type Main Applicant onChange and Set the values for - speak, read, write, listen
    public void onEnTestChange(){
        assessment.English_test_type__c = selectedTestType;
        String obj = 'assessment__c';
        String asmtEnTestType;
        System.Debug('selectedOptionEnLang=>'+ selectedOptionEnLang);
        // Block to setting up Language properties for Main Applicant
        if(selectedOptionEnLang == 'Main'){
            asmtEnTestType = selectedTestType;
            List<SelectOption> enSpeakOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_speaking__c');
            List<SelectOption> enReadOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_reading__c');
            List<SelectOption> enWriteOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Writing__c');
            List<SelectOption> enListenOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Listening__c');
            
            // setting up the values in properties
            enSpeakList = AssessmentPanelScreenUtility.setPicklistValues(enSpeakOption, asmtEnTestType);
            enReadList = AssessmentPanelScreenUtility.setPicklistValues(enReadOption, asmtEnTestType);
            enWriteList = AssessmentPanelScreenUtility.setPicklistValues(enWriteOption, asmtEnTestType);
            enListenList = AssessmentPanelScreenUtility.setPicklistValues(enListenOption, asmtEnTestType);
            // setting up the english speaking reading, writing, listening to null 
            assessment.English_speaking__c = null;
            assessment.English_reading__c = null;
            assessment.English_Writing__c = null;
            assessment.English_Listening__c = null;
        }
        
        
    }
    
    // Method to handle french test type (have you done tef?) 
    public void handleFrenchTestType(){
        String sObjectName = 'assessment__c';
        assessment.Have_you_done_TEF__c = assessment.Have_you_done_TEF__c;
		frSpeakList = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_speaking__c', assessment.Have_you_done_TEF__c);
        frReadList = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_reading__c', assessment.Have_you_done_TEF__c);
        frWriteList = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_Writing__c', assessment.Have_you_done_TEF__c);
        frListenList = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_Listening__c', assessment.Have_you_done_TEF__c);
        
        assessment.French_speaking__c = null;
        assessment.French_reading__c = null;
        assessment.French_Writing__c = null;
        assessment.French_Listening__c = null;
    }
    
    

}