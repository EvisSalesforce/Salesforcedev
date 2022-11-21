public class AssessmentPanelScreenController {
    // Tab-1 properties
    public String accountId {get; set;}
    public String newAsmt {get; set;} // String parameter get value 'new' from url to create new ASSESSMENT
    public String csId{get; set;} // Consultation Id passed in url to create new ASSESSMENT
    public String asId{get; set;} // Url parameter(assessmentId) to directly open ASSESSMENT
    public String openCsId {get; set;} // Url parameter(consultation Id) to directly open CONSULTATION SHEET
    public String newCsSheet{get; set;} // String parameter to get value 'new' from url to create new CONSULTATION SHEET
    public List<Consultation_Sheet__c> cSheets {get; set;} // List of Consultation Sheets - related to Account
    public List<Assessment__c> relatedAsmts {get; set;} // List of Assessments - related to Consultation Sheets
    public List<Assessment__c> asmts {get; set;} // List of Assessments - Without Consultation Sheets
    public Boolean consTab {get; set;} // variable to manage reRendering of Consultation Details tab's both screen
    public String selectedCsheetId {get; set;} // variable to store selected Consultation Sheet Id
    public String selectedAsmtId {get; set;} // variable to store selected Assessment Sheet Id
    public Consultation_Sheet__c cSheetDetail {get; set;} //Selected consultation sheet for update
    public String tabDisableSet {get; set;} // variable to manage disable or enable tabs
    public transient String tabOpt {get; set;} // variable to store which tab opted/opened in tab-panel
    public Boolean setRequiredTabCS {get; set;} // To make fields required or not required in Consultation Details tab1;
    public String timeProjected {get; set;}
    public String statusExpirationDate {get; set;}
    public String csDate {get; set;} // Date__c field of consultation sheet
    public boolean isSalutation{get; set;} // Identifier to make main applicant Saluation editable
    public boolean isFirstName {get; set;} // Identifier to make main applicant firstname editable
    public boolean isLastName {get; set;} // Identifier to make main applicant lastname editable
    public boolean isSpSalutation{get; set;}  // Identifier to make spouse Saluation editable
    public boolean isSpFirstName {get; set;} // Identifier to make spouse firstname editable
    public boolean isSpLastName {get; set;} // Identifier to make spouse lastname editable
    // Tab-2 properties
    public Account mainApplicantAcc {get; set;} // Account to store Main Applicant Account
    public Account spouseAcc {get; set;} // Account to store Spouse Account 
    public Assessment__c assessment {get; set;} // Assessment
    public String mainApplicantDOB {get; set;} // variable to store DOB of Main Applicant
    public String spouseDOB {get; set;} // variable to store DOB of Spouse
    public String dobOutputMainApplicant {get; set;} //variable to show age of main applicant in years, months, days
    public String dobOutputSpouse {get; set;} //variable to show age of Spouse in years, months, days
    public String childDOB1 {get; set;} // variable to store DOB of child 1
    public String childDOB2 {get; set;} // variable to store DOB of child 2
    public String childDOB3 {get; set;} // variable to store DOB of child 3
    public String childDOB4 {get; set;} // variable to store DOB of child 4
    public String childDOB5 {get; set;} // variable to store DOB of child 5
    public String childDOB6 {get; set;} // variable to store DOB of child 6
    
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
    public List<SelectOption> enSpeakListSpouse {get; set;} // variable to store English Speaking picklist values - Spouse
    public String enSpeakValueSpouse {get; set;} // variable to store selected english speaking value - Spouse
    public List<SelectOption> enReadListSpouse {get; set;} // variable to store English Read picklist values - Spouse
    public String enReadValueSpouse {get; set;} // variable to store selected english Read value - Spouse
    public List<SelectOption> enWriteListSpouse {get; set;} // variable to store English Write picklist values - Spouse
    public String enWriteValueSpouse {get; set;} // variable to store selected english Write value - Spouse
    public List<SelectOption> enListenListSpouse {get; set;} // variable to store English Listen picklist values - Spouse
    public String enListenValueSpouse {get; set;} // variable to store selected english Listen value - Spouse
    public String selectedTestTypeSP {get; set;} // variabe to store selected language test type spouse
    public List<SelectOption> selectedTestTypeListSP {get; set;} // List - of language test type
    public String selectedOptionEnLang {get; set;} // variable to identify which section- Main Applicant lang OR Spouse lang called the method 'onEnTestChange'
    public Integer numberofChilds {get; set;} // variable to handle Children - Block rerendering
    
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
    public String nocDetails2{get; set;}
    public String nocDetails3{get; set;}
    // Occupations - Spouse properties
    public String jobStartSp1{get; set;}
    public String jobEndSp1 {get; set;}
    public String jobStartSp2{get; set;}
    public String jobEndSp2 {get; set;}
    public String jobStartSp3{get; set;}
    public String jobEndSp3 {get; set;}
    public String workExShowSP {get; set;}
    public String nocDetailsSP1{get; set;}
    public String nocDetailsSP2{get; set;}
    public String nocDetailsSP3{get; set;}
    
    public String focusEle {get; set;}
    // Tab - 2 (Business/Finance) Properties
    public Consultation_Sheet__c cSheetBiz {get; set;}
    //Constructor
    public AssessmentPanelScreenController(){
        newAsmt = Apexpages.currentpage().getparameters().get('asmt');
        accountId = Apexpages.currentpage().getparameters().get('accountId');
        csId = Apexpages.currentpage().getparameters().get('csId');
        asId = Apexpages.currentpage().getparameters().get('asId');
        openCsId = Apexpages.currentpage().getparameters().get('openCsId');
        newCsSheet = Apexpages.currentpage().getparameters().get('newCsSheet');
        if(accountId != null){
            //tabOpt = 'cdetailTab';
            consTab = true;
            this.handleConsultationDetails();
            tabDisableSet = '0';
            assessment = new assessment__c();
        }
        
        
        workExShow = '1';
        workExShowSP = '1';
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
    
    //Method to handle Consultation details tab
    public void handleConsultationDetails(){
        cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c,(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name,Type__c, CreatedDate, Total__c, Total_EE__c FROM Assessments__r order by createdDate DESC) 
                   FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
        
        relatedAsmts = [SELECT Id, Name,Type__c, Consultation_Sheet__r.Account__r.Name FROM Assessment__c 
                        WHERE Consultation_Sheet__c IN :cSheets order by createdDate DESC];
        asmts = [SELECT Id, Name,Type__c, Account__r.Name, CreatedDate, Total__c, Total_EE__c FROM Assessment__c 
                 WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
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
						(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC)
                        FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
        
        // setting up date fields
        csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
        timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
        statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
        
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
        
        Assessment__c asmnt = [Select id,name,Type__c,Consultation_Sheet__c from Assessment__c where id =: selectedAsmtId limit 1];
        if(asmnt.Type__c == null || (String.isNotBlank(asmnt.Type__c) && asmnt.Type__c.equalsIgnoreCase('Express Entry')))
        {
            onAsmtClick();
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
            if(asmnt.Consultation_Sheet__c == null)
            {
                PageReference pgRef = new PageReference('/apex/BCPNPPanelScreen?accountId='+accountId+'&asId='+selectedAsmtId);
                pgRef.setRedirect(true);
                return pgRef;
            }
            else
            {
                PageReference pgRef = new PageReference('/apex/BCPNPPanelScreen?accountId='+accountId+'&asId='+selectedAsmtId+'&openCsId='+asmnt.Consultation_Sheet__c);
                pgRef.setRedirect(true);
                return pgRef;
            }
        }
        return null;
    }
    //Method to handle selected Assessment and renderning of profile page
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
        workExShowSP = '1';
        System.debug('selectedAsmtId: '+selectedAsmtId);
        //Enabling Profile Tab
        tabDisableSet = '01234';
        //Move to the profile tab
        tabOpt = 'profile';
        String obj = 'assessment__c';
        // Getting Picklist values for English Language-test type 
        selectedTestTypeList = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_test_type__c');
        selectedTestTypeListSP = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_test_type_Spouse__c');
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
                                       ,DOB_Spouse__c,Last_Name_Spouse__c,Phone_Spouse__c,Type__c /*Pulkit change end*/
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
        if(assessment != null && assessment.DOB_Spouse__c != null)
        {
            dobOutputSpouse = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(assessment.DOB_Spouse__c, System.today());
            spouseDOB = AssessmentPanelScreenUtility.convertToString(assessment.DOB_Spouse__c);
        }
        else
        {
            assessment.DOB_Spouse__c = spouseAcc?.DOB__c;
            dobOutputSpouse = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(spouseAcc?.DOB__c, System.today());
            spouseDOB = AssessmentPanelScreenUtility.convertToString(spouseAcc?.DOB__c);
        }
        //dobOutputMainApplicant = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(mainApplicantAcc?.DOB__c, System.today());
		//dobOutputSpouse = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(spouseAcc?.DOB__c, System.today());
		
        
        //setting up date fields of profile tab
        //Commented by Pulkit
        //mainApplicantDOB = AssessmentPanelScreenUtility.convertToString(mainApplicantAcc?.DOB__c);
        //spouseDOB = AssessmentPanelScreenUtility.convertToString(spouseAcc?.DOB__c);
        //Pulkit Change End
        childDOB1 = AssessmentPanelScreenUtility.convertToString(assessment?.Child_s_Birth1__c);
        childDOB2 = AssessmentPanelScreenUtility.convertToString(assessment?.Child_s_Birth2__c);
        childDOB3 = AssessmentPanelScreenUtility.convertToString(assessment?.Child_s_Birth3__c);
        childDOB4 = AssessmentPanelScreenUtility.convertToString(assessment?.Child_s_Birth4__c);
        childDOB5 = AssessmentPanelScreenUtility.convertToString(assessment?.Child_s_Birth5__c);
        childDOB6 = AssessmentPanelScreenUtility.convertToString(assessment?.Child_s_Birth6__c);
        
        //setting up date fields of Occupation tab
        jobStart1 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_1__c);
        jobEnd1 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_1__c);
        jobStart2 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_2__c);
        jobEnd2 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_2__c);
        jobStart3 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_3__c);
        jobEnd3 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_3__c);
        
        // For Spouse
        jobStartSp1 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_1_Spouse__c);
        jobEndSp1 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_1_Spouse__c);
        jobStartSp2 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_2_Spouse__c);
        jobEndSp2 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_2_Spouse__c);
        jobStartSp3 =  AssessmentPanelScreenUtility.convertToString(assessment?.Job_start_3_Spouse__c);
        jobEndSp3 = AssessmentPanelScreenUtility.convertToString(assessment?.Job_end_3_Spouse__c);
        
        String csheetIdBiz = '';
        
        csheetIdBiz = [SELECT Consultation_Sheet__r.Id,Type__c from assessment__c WHERE Id = : selectedAsmtId]?.Consultation_Sheet__r?.Id;
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
        
        // Setting Selected test type for Spouse
        selectedTestTypeSP = assessment?.English_test_type_Spouse__c;
        // Setting Speak/Read/Write/Listen values in Language Spouse picklist
        enSpeakListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enSpeakOption, selectedTestTypeSP);
        enReadListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enReadOption, selectedTestTypeSP);
        enWriteListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enWriteOption, selectedTestTypeSP);
        enListenListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enListenOption, selectedTestTypeSP);
        // Setting up Language Section custom dependent picklist values
        
        enSpeakValue = assessment?.English_speaking__c;
        enReadValue = assessment?.English_reading__c;
        enWriteValue = assessment?.English_Writing__c;
        enListenValue = assessment?.English_Listening__c;
        
        // Setting up Language Section - Spouse custom dependent picklist values
        enSpeakValueSpouse = assessment?.English_speaking_Spouse__c;
        enReadValueSpouse = assessment?.English_reading_Spouse__c;
        enWriteValueSpouse = assessment?.English_Writing_Spouse__c;
        enListenValueSpouse = assessment?.English_Listening_Spouse__c;
        
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
        nocDetails2 = assessment.Please_type_a_occupation_2__r.NOC_Details__c;
        nocDetails3 = assessment.Please_type_a_occupation_3__r.NOC_Details__c;
        nocDetailsSP1 = assessment.Please_type_a_occupation_1_Spouse__r.NOC_Details__c;
        nocDetailsSP2 = assessment.Please_type_a_occupation_2_Spouse__r.NOC_Details__c;
        nocDetailsSP3 = assessment.Please_type_a_occupation_3_Spouse__r.NOC_Details__c;
        
        // Calling handleChildren() to initialize numberofChilds
        handleChildren();
        System.debug('handleChildren() in asmt block');
        if(assessment == Null){
            assessment = new assessment__c();
        }
        
        // handling workExShow
        if(assessment?.Please_type_a_occupation_2__c != null){
            workExShow += '2';
        }
        if(assessment?.Please_type_a_occupation_3__c != null){
            workExShow += '3';
        }
        
        // handling workExShow for spouse
        if(assessment?.Please_type_a_occupation_2_Spouse__c != null){
            workExShowSP += '2';
        }
        
        if(assessment?.Please_type_a_occupation_3_Spouse__c != null){
            workExShowSP += '3';
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
        if(String.isNotBlank(mainApplicantAcc.Marital_Status__c) && assessment.Marital_Status__c == null)
        {
            assessment.Marital_Status__c = mainApplicantAcc.Marital_Status__c;
        }
        if(mainApplicantAcc.Personal_Information_Notes__c != null && assessment.Personal_Information_Notes__c == null)
            assessment.Personal_Information_Notes__c = mainApplicantAcc.Personal_Information_Notes__c;
        if(mainApplicantAcc.e_mail__c != null && assessment.E_mail_Main_Applicant__c == null)
            assessment.E_mail_Main_Applicant__c = mainApplicantAcc.e_mail__c;
        if(mainApplicantAcc.Phone != null && assessment.Phone_Main_Applicant__c == null)
            assessment.Phone_Main_Applicant__c = mainApplicantAcc.Phone;
        
        // handling profile field editability for spouse account
        if(assessment != null && String.isNotBlank(assessment.Salutation_Spouse__c))
        {
            isSpSalutation = true;
        }
        else if(String.isNotBlank(spouseAcc.Salutation__c)){
            assessment.Salutation_Spouse__c = spouseAcc.Salutation__c;
            isSpSalutation = true;
        }
        else{
            isSpSalutation = false;
        }
        
        if(assessment != null && String.isNotBlank(assessment.First_Name_Spouse__c))
        {
            isSpFirstName = true;
        }
        
        else if(String.isNotBlank(spouseAcc.First_Name__c)){
            assessment.First_Name_Spouse__c = spouseAcc.First_Name__c;
            isSpFirstName = true;
        }
        else{
            isSpFirstName = false;
        }
        
        if(assessment != null && String.isNotBlank(assessment.Last_Name_Spouse__c))
        {
            isSpLastName = true;
        }
        
        else if(String.isNotBlank(spouseAcc.Last_Name__c)){
            assessment.Last_Name_Spouse__c = spouseAcc.Last_Name__c;
            isSpLastName = true;
        }
        else{
            isSpLastName = false;
        }
        
        if(spouseAcc.e_mail__c != null && assessment.E_mail_Spouse__c == null)
            assessment.E_mail_Spouse__c = spouseAcc.e_mail__c;
        if(spouseAcc.Phone != null && assessment.Phone_Spouse__c == null)
            assessment.Phone_Spouse__c = spouseAcc.Phone;
        //Pulkit Change End
    }
    
    // Method to handle back button of Consultation details tab's screen-2 
    public void backtoConsultationList(){
        consTab = true;
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
								(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC)
                                FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
                // setting up date fields 05 July 2021
                csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
                timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
                statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
                // Refresh the List of consultations in tab - 1
                cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c, (SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC) 
                           FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
                
                //Refresh the assessments without consultation on tab 1
                asmts = [SELECT Id, Name, Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessment__c 
                         WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Consultation Sheet Successfully Created!'));
            }
        }
        
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Error occured: '+ex.getMessage()));
            System.debug('Exception Csheet Update: '+ ex.getMessage()+' Line Number: '+ex.getLineNumber());
        }
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
    
    // Method to handle Language Test Type Main Applicant onChange and Set the values for - speak, read, write, listen
    public void onEnTestChange(){
        assessment.English_test_type__c = selectedTestType;
        assessment.English_test_type_Spouse__c = selectedTestTypeSP;
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
        
        // Block to setting up Language properties for Spouse
        if(selectedOptionEnLang == 'Spouse'){
            asmtEnTestType = selectedTestTypeSP;
            List<SelectOption> enSpeakOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_speaking__c');
            List<SelectOption> enReadOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_reading__c');
            List<SelectOption> enWriteOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Writing__c');
            List<SelectOption> enListenOption = AssessmentPanelScreenUtility.getPicklistValues(obj, 'English_Listening__c');
            
            // setting up the values in properties
            enSpeakListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enSpeakOption, asmtEnTestType);
            enReadListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enReadOption, asmtEnTestType);
            enWriteListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enWriteOption, asmtEnTestType);
            enListenListSpouse = AssessmentPanelScreenUtility.setPicklistValues(enListenOption, asmtEnTestType);
            // setting up the english speaking reading, writing, listening to null - Spouse
            assessment.English_speaking_Spouse__c = null;
            assessment.English_reading_Spouse__c = null;
            assessment.English_Writing_Spouse__c = null;
            assessment.English_Listening_Spouse__c = null;
        }
    }
    
    // Method to handle Marital Status field on profile tab
    public void handleMaritalStatus(){
        assessment.Marital_Status__c = assessment.Marital_Status__c;
        //mainApplicantAcc.Marital_Status__c = mainApplicantAcc.Marital_Status__c;
        // Code to check for required field according to martial status & make tabs disable/enable
        tabOpt = 'profile';
        tabDisableSet = '01234';
        if( spouseAcc.Id == null && (assessment.Marital_Status__c != 'Married' && assessment.Marital_Status__c != 'Common-law') &&
           (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
            assessment.DOB_Main_Applicant__c == NULL)
          ){
              String errormsg = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
              if(errormsg != null && errormsg != ''){
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsg));
                  tabDisableSet = '1';
              }
              
          }
        
        if( (spouseAcc.Id != NULL) && (assessment.Marital_Status__c == 'Married' || assessment.Marital_Status__c == 'Common-law') &&
           (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
            assessment.DOB_Main_Applicant__c == NULL || assessment.DOB_Spouse__c == NULL || assessment.E_mail_Spouse__c == NULL || assessment.First_Name_Spouse__c == NULL
            || assessment.Last_Name_Spouse__c == NULL)
          ){
              String errormsgSp = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
              //errormsgSp += AssessmentPanelScreenUtility.checkRequiredFields(mainApplicantAcc, spouseAcc);
              if(errormsgSp != null && errormsgSp != ''){
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsgSp));
                  tabDisableSet = '1';
              }
              
              
          }
        
        if(spouseAcc.Id == null && (assessment.Marital_Status__c == 'Married' || assessment.Marital_Status__c == 'Common-law')
           && (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
               assessment.DOB_Main_Applicant__c == NULL || assessment.DOB_Spouse__c == NULL || assessment.E_mail_Spouse__c == NULL || assessment.First_Name_Spouse__c == NULL
               || assessment.Last_Name_Spouse__c == NULL)){
                   String errormsgS = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
                   //errormsgS += AssessmentPanelScreenUtility.checkRequiredFields(mainApplicantAcc, spouseAcc);
                   if(errormsgS != null && errormsgS != ''){
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsgS));
                       tabDisableSet = '1';
                   }
                   
               }
        
    }
    
    public void handleChildren(){
        if(assessment != null){
            assessment.Number_of_children__c = assessment.Number_of_children__c;
        }
        String childs = assessment?.Number_of_children__c;
        if(childs == NULL || childs == '' || childs == 'No children'){
            numberofChilds = 0;
            childDOB1 = null;
            childDOB2 = null;
            childDOB3 = null;
            childDOB4 = null;
            childDOB5 = null;
            childDOB6 = null;
            
            assessment.Child_s_Birth1__c = null;
            assessment.Child_s_Birth2__c = null;
            assessment.Child_s_Birth3__c = null;
            assessment.Child_s_Birth4__c = null;
            assessment.Child_s_Birth5__c = null;
            assessment.Child_s_Birth6__c = null;
            
            assessment.Child_s_Name1__c = null;
            assessment.Child_s_Name2__c = null;
            assessment.Child_s_Name3__c = null;
            assessment.Child_s_Name4__c = null;
            assessment.Child_s_Name5__c = null;
            assessment.Child_s_Name6__c = null;
            
            assessment.Children_Notes__c = null;
            System.debug('numberofChilds: '+numberofChilds);
            return;
        }
        
        if(childs.length() > 1){
            childs = childs.removeEnd('+');
        }
        numberofChilds = Integer.valueOf(childs);
        System.debug('numberofChilds: '+numberofChilds);
        
        if(numberofChilds == 1){
            
            childDOB2 = null;
            childDOB3 = null;
            childDOB4 = null;
            childDOB5 = null;
            childDOB6 = null;
            assessment.Child_s_Birth2__c = null;
            assessment.Child_s_Birth3__c = null;
            assessment.Child_s_Birth4__c = null;
            assessment.Child_s_Birth5__c = null;
            assessment.Child_s_Birth6__c = null;
            
            assessment.Child_s_Name2__c = null;
            assessment.Child_s_Name3__c = null;
            assessment.Child_s_Name4__c = null;
            assessment.Child_s_Name5__c = null;
            assessment.Child_s_Name6__c = null;
        }
        if(numberofChilds == 2){
            childDOB3 = null;
            childDOB4 = null;
            childDOB5 = null;
            childDOB6 = null;
            assessment.Child_s_Birth3__c = null;
            assessment.Child_s_Birth4__c = null;
            assessment.Child_s_Birth5__c = null;
            assessment.Child_s_Birth6__c = null;
            
            assessment.Child_s_Name3__c = null;
            assessment.Child_s_Name4__c = null;
            assessment.Child_s_Name5__c = null;
            assessment.Child_s_Name6__c = null;
        }
        if(numberofChilds == 3){
            childDOB4 = null;
            childDOB5 = null;
            childDOB6 = null;
            assessment.Child_s_Birth4__c = null;
            assessment.Child_s_Birth5__c = null;
            assessment.Child_s_Birth6__c = null;
            
            assessment.Child_s_Name4__c = null;
            assessment.Child_s_Name5__c = null;
            assessment.Child_s_Name6__c = null;
        }
        if(numberofChilds == 4){
            childDOB5 = null;
            childDOB6 = null;
            assessment.Child_s_Birth5__c = null;
            assessment.Child_s_Birth6__c = null;
            
            assessment.Child_s_Name5__c = null;
            assessment.Child_s_Name6__c = null;
        }
        if(numberofChilds == 5){
            childDOB6 = null;
            assessment.Child_s_Birth6__c = null;
            assessment.Child_s_Name6__c = null;
        }
        
    }
    
    public void handleLevelEdu(){
        assessment.Level_of_education__c = assessment.Level_of_education__c;
        if(assessment.Level_of_education__c != '2 or more Degrees or Diplomas with at least one being 3+ years'){
            assessment.Name_of_diploma2__c = null;
        }
        assessment.Post_secondaries_in_canada__c = assessment.Post_secondaries_in_canada__c;
        
        if(assessment.Post_secondaries_in_canada__c != 'Yes'){
            assessment.Type_of_educational_institute__c = null;
            assessment.Post_secondary_studies__c = null;
            assessment.Name_of_bachelor_s_degree__c = null;
        }
    }
    
    public void handleLevelEduSp(){
        assessment.Level_of_education_Spouse__c = assessment.Level_of_education_Spouse__c;
        if(assessment.Level_of_education_Spouse__c != '2 or more Degrees or Diplomas with at least one being 3+ years'){
            assessment.Name_of_diploma2_Spouse__c = null;
        }
        assessment.Post_secondaries_in_canada_Spouse__c = assessment.Post_secondaries_in_canada_Spouse__c;
        if(assessment.Post_secondaries_in_canada_Spouse__c != 'Yes'){
            assessment.Type_of_educational_institute_Spouse__c = null;
            assessment.Post_secondary_studies_Spouse__c = null;
            assessment.Name_of_bachelor_s_degree_Spouse__c = null;
        }
    }
    
    public void handleLang(){
        assessment.Do_you_speak_English__c = assessment.Do_you_speak_English__c;
        System.debug('selectedTestType: '+selectedTestType);
        if(assessment.Do_you_speak_English__c != 'Yes'){
            assessment.English_test_type__c = null;
            assessment.English_speaking__c = null;
            assessment.English_reading__c = null;
            assessment.English_Writing__c = null;
            assessment.English_Listening__c = null;
        }
        else{
            selectedTestType = null;
            selectedTestTypeList = selectedTestTypeList = AssessmentPanelScreenUtility.getPicklistValues('assessment__c', 'English_test_type__c');
            enSpeakList = null;
            enReadList = null;
            enWriteList = null;
            enListenList = null;
        }
        
    }
    
    public void handleLangFrench(){
        assessment.Do_you_speak_French__c = assessment.Do_you_speak_French__c;
        assessment.Have_you_done_TEF__c = null;
        assessment.French_speaking__c = null;
        assessment.French_reading__c = null;
        assessment.French_Writing__c = null;
        assessment.French_Listening__c = null;
        
        frSpeakList = null;
        frReadList = null;
        frWriteList = null;
        frListenList = null; 
    }
    
    public void handleLangSpouse(){
        assessment.Do_you_speak_English_Spouse__c = assessment.Do_you_speak_English_Spouse__c;
        if(assessment.Do_you_speak_English_Spouse__c != 'Yes'){
            assessment.English_test_type_Spouse__c = null;
            assessment.English_speaking_Spouse__c = null;
            assessment.English_reading_Spouse__c = null;
            assessment.English_Writing_Spouse__c = null;
            assessment.English_Listening_Spouse__c = null;
        }
        else{
            selectedTestTypeSP = null;
            selectedTestTypeListSP = AssessmentPanelScreenUtility.getPicklistValues('assessment__c', 'English_test_type_Spouse__c');
            enSpeakListSpouse = null;
            enReadListSpouse = null;
            enWriteListSpouse = null;
            enListenListSpouse = null;
        }
        
    }
    
    public void handleLangFrenchSpouse(){
        assessment.Do_you_speak_French_Spouse__c = assessment.Do_you_speak_French_Spouse__c;
        
        assessment.Have_you_done_TEF_Spouse__c = null;
        assessment.French_speaking_Spouse__c = null;
        assessment.French_reading_Spouse__c = null;
        assessment.French_Writing_Spouse__c = null;
        assessment.French_Listening_Spouse__c = null;
    }
    
    public void handleWorkInCanada(){
        assessment.have_been_canada_as_temp_worker__c = assessment.have_been_canada_as_temp_worker__c;
        if(assessment.have_been_canada_as_temp_worker__c != 'Yes'){
            assessment.Work_In_Canada_Notes__c = null;
        }
        assessment.Have_you_received_an_LMIA__c = assessment.Have_you_received_an_LMIA__c;
        if(assessment.Have_you_received_an_LMIA__c != 'Yes'){
            assessment.NOC_received__c = null;
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
    
    // Method to handle french test type Spouse (have you done tef?) 
    public void handleFrenchTestTypeSpouse(){
        String sObjectName = 'assessment__c';
        assessment.Have_you_done_TEF_Spouse__c = assessment.Have_you_done_TEF_Spouse__c;
        frSpeakListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_speaking_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        frReadListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_reading_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        frWriteListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_Writing_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        frListenListSP = AssessmentPanelScreenUtility.setFrenchPicklistValues(sObjectName, 'French_Listening_Spouse__c', assessment.Have_you_done_TEF_Spouse__c);
        
        assessment.French_speaking_Spouse__c = null;
        assessment.French_reading_Spouse__c = null;
        assessment.French_Writing_Spouse__c = null;
        assessment.French_Listening_Spouse__c = null;
    }
    
    public void handleOnChangeProfile(){
        assessment.Create_Spouse_Assessment__c = assessment.Create_Spouse_Assessment__c; // Check box to create assessment on spouse
        //mainApplicantAcc.Salutation__c = mainApplicantAcc.Salutation__c;
        assessment.Salutation_Main_Applicant__c = assessment.Salutation_Main_Applicant__c;
        //spouseAcc.Salutation__c = spouseAcc.Salutation__c;
        assessment.Salutation_Spouse__c = assessment.Salutation_Spouse__c;
        assessment.Consultation_Sheet__c = assessment.Consultation_Sheet__c;
        assessment.Immigrate__c = assessment.Immigrate__c;
        assessment.Work__c = assessment.Work__c;
        assessment.Study__c = assessment.Study__c;
        assessment.Invest__c = assessment.Invest__c;
        assessment.Not_Sure__c = assessment.Not_Sure__c;
        //mainApplicantAcc.Personal_Information_Notes__c = mainApplicantAcc.Personal_Information_Notes__c;
        assessment.Personal_Information_Notes__c = assessment.Personal_Information_Notes__c;
        assessment.Child_s_Birth1__c = AssessmentPanelScreenUtility.convertToDate(childDOB1);
        assessment.Child_s_Birth2__c = AssessmentPanelScreenUtility.convertToDate(childDOB2);
        assessment.Child_s_Birth3__c = AssessmentPanelScreenUtility.convertToDate(childDOB3);
        assessment.Child_s_Birth4__c = AssessmentPanelScreenUtility.convertToDate(childDOB4);
        assessment.Child_s_Birth5__c = AssessmentPanelScreenUtility.convertToDate(childDOB5);
        assessment.Child_s_Birth6__c = AssessmentPanelScreenUtility.convertToDate(childDOB6);
        assessment.Child_s_Name1__c = assessment.Child_s_Name1__c;
        assessment.Child_s_Name2__c = assessment.Child_s_Name2__c;
        assessment.Child_s_Name3__c = assessment.Child_s_Name3__c;
        assessment.Child_s_Name4__c = assessment.Child_s_Name4__c;
        assessment.Child_s_Name5__c = assessment.Child_s_Name5__c;
        assessment.Child_s_Name6__c = assessment.Child_s_Name6__c;
        assessment.Children_Notes__c = assessment.Children_Notes__c;
        assessment.Name_of_diploma1__c = assessment.Name_of_diploma1__c;
        assessment.Name_of_diploma2__c = assessment.Name_of_diploma2__c;
        assessment.Country_of_studies__c = assessment.Country_of_studies__c;
        assessment.Type_of_educational_institute__c = assessment.Type_of_educational_institute__c;
        assessment.Post_secondary_studies__c = assessment.Post_secondary_studies__c;
        assessment.Name_of_bachelor_s_degree__c = assessment.Name_of_bachelor_s_degree__c;
        assessment.Education_Notes__c = assessment.Education_Notes__c;
        assessment.Name_of_diploma1_Spouse__c = assessment.Name_of_diploma1_Spouse__c;
        assessment.Name_of_diploma2_Spouse__c = assessment.Name_of_diploma2_Spouse__c;
        assessment.Country_of_studies_Spouse__c = assessment.Country_of_studies_Spouse__c;
        assessment.Type_of_educational_institute_Spouse__c = assessment.Type_of_educational_institute_Spouse__c;
        assessment.Post_secondary_studies_Spouse__c = assessment.Post_secondary_studies_Spouse__c;
        assessment.Name_of_bachelor_s_degree_Spouse__c = assessment.Name_of_bachelor_s_degree_Spouse__c;
        assessment.Education_Notes_Spouse__c = assessment.Education_Notes_Spouse__c;
        assessment.French_first_language__c = assessment.French_first_language__c;
        assessment.English_speaking__c = enSpeakValue;
        assessment.English_reading__c = enReadValue;
        assessment.English_Writing__c = enWriteValue;
        assessment.English_Listening__c = enListenValue;
        //assessment.Have_you_done_TEF__c = assessment.Have_you_done_TEF__c;
        assessment.French_speaking__c = frSpeakValue;
        assessment.French_reading__c = frReadValue;
        assessment.French_Writing__c = frWriteValue;
        assessment.French_Listening__c = frListenValue;
        assessment.Language_Notes__c = assessment.Language_Notes__c;
        assessment.French_first_language_Spouse__c = assessment.French_first_language_Spouse__c;
        assessment.English_speaking_Spouse__c = enSpeakValueSpouse;
        assessment.English_reading_Spouse__c = enReadValueSpouse;
        assessment.English_Writing_Spouse__c = enWriteValueSpouse;
        assessment.English_Listening_Spouse__c = enListenValueSpouse;
        //assessment.Have_you_done_TEF_Spouse__c = assessment.Have_you_done_TEF_Spouse__c;
        assessment.French_speaking_Spouse__c = frSpeakValueSP;
        assessment.French_reading_Spouse__c = frReadValueSP;
        assessment.French_Writing_Spouse__c = frWriteValueSP;
        assessment.French_Listening_Spouse__c = frListenValueSP;
        assessment.Language_Notes_Spouse__c = assessment.Language_Notes_Spouse__c;
        assessment.NOC_received__c = assessment.NOC_received__c;
        assessment.Certificate_of_Qualification_from_Canada__c = assessment.Certificate_of_Qualification_from_Canada__c;
        assessment.Relatives_In_Canada_List__c = assessment.Relatives_In_Canada_List__c;
        assessment.Does_this_relation_wish_to_sponsor_you__c = assessment.Does_this_relation_wish_to_sponsor_you__c;
        assessment.Sponsor_s_age__c = assessment.Sponsor_s_age__c;
        assessment.Sponsor_s_employment_status__c = assessment.Sponsor_s_employment_status__c;
        assessment.Sponsor_s_family_size__c = assessment.Sponsor_s_family_size__c;
        assessment.Sponsor_s_annual_income__c = assessment.Sponsor_s_annual_income__c;
        assessment.Currently_a_full_time_student__c = assessment.Currently_a_full_time_student__c;
        assessment.Have_been_a_dependent_child_since_before__c = assessment.Have_been_a_dependent_child_since_before__c;
        assessment.Family_Relation_Notes__c = assessment.Family_Relation_Notes__c;
        assessment.Have_previously_visited_canada__c = assessment.Have_previously_visited_canada__c;
        assessment.Have_previously_applied_Immigration__c = assessment.Have_previously_applied_Immigration__c;
        assessment.Preferred_destination_in_canada__c = assessment.Preferred_destination_in_canada__c;
        assessment.Previously_submitted_an_Express_Entry__c = assessment.Previously_submitted_an_Express_Entry__c;
        assessment.refused_a_visa_to_Canada__c = assessment.refused_a_visa_to_Canada__c;
        assessment.Previous_and_future_visit_notes__c = assessment.Previous_and_future_visit_notes__c;
        assessment.Country_of_Citizenship__c = assessment.Country_of_Citizenship__c;
        assessment.Current_country_of_residence__c = assessment.Current_country_of_residence__c;
        assessment.Preferred_language__c = assessment.Preferred_language__c;
        //mainApplicantAcc.Phone = mainApplicantAcc.Phone;
        assessment.Phone_Main_Applicant__c = assessment.Phone_Main_Applicant__c;
        //spouseAcc.Phone = spouseAcc.Phone;
        assessment.Phone_Spouse__c = assessment.Phone_Spouse__c;
        assessment.Office__c = assessment.Office__c;
        assessment.Source_Media__c = assessment.Source_Media__c;
        assessment.Have_Province_Nomination_except_Quebec__c = assessment.Have_Province_Nomination_except_Quebec__c;
        assessment.Is_Client__c = assessment.Is_Client__c;
        assessment.Further_Information__c = assessment.Further_Information__c;
        assessment.Other_Info_Notes__c = assessment.Other_Info_Notes__c;

    }
    
    public void handleOnChangeProfileRequired(){
        dobOutputMainApplicant = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(AssessmentPanelScreenUtility.convertToDate(mainApplicantDOB), System.today());
        dobOutputSpouse = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(AssessmentPanelScreenUtility.convertToDate(spouseDOB), System.today());

        tabOpt = 'profile';
        tabDisableSet = '01234';
        mainApplicantDOB = mainApplicantDOB;
        //Pulkit change start
        //mainApplicantAcc.First_Name__c = mainApplicantAcc.First_Name__c;
        assessment.First_Name_Main_Applicant__c = assessment.First_Name_Main_Applicant__c;
        //mainApplicantAcc.Last_Name__c = mainApplicantAcc.Last_Name__c;
        assessment.Last_Name_Main_Applicant__c = assessment.Last_Name_Main_Applicant__c;
        //mainApplicantAcc.DOB__c = AssessmentPanelScreenUtility.convertToDate(mainApplicantDOB);
        assessment.DOB_Main_Applicant__c = AssessmentPanelScreenUtility.convertToDate(mainApplicantDOB);
        //spouseAcc.DOB__c = AssessmentPanelScreenUtility.convertToDate(spouseDOB);
        assessment.DOB_Spouse__c = AssessmentPanelScreenUtility.convertToDate(spouseDOB);
        //spouseAcc.First_Name__c = spouseAcc.First_Name__c;
        assessment.First_Name_Spouse__c = assessment.First_Name_Spouse__c;
        //spouseAcc.Last_Name__c = spouseAcc.Last_Name__c;
        assessment.Last_Name_Spouse__c = assessment.Last_Name_Spouse__c;
        //mainApplicantAcc.e_mail__c = mainApplicantAcc.e_mail__c;
        assessment.E_mail_Main_Applicant__c = assessment.E_mail_Main_Applicant__c;
        //spouseAcc.e_mail__c = spouseAcc.e_mail__c;
        assessment.E_mail_Spouse__c = assessment.E_mail_Spouse__c;
        //System.debug('mainApplicantDOB: '+mainApplicantAcc.DOB__c);
        /*if( spouseAcc.Id == null && (mainApplicantAcc.Marital_Status__c != 'Married' && mainApplicantAcc.Marital_Status__c != 'Common-law') &&
           (mainApplicantAcc.First_Name__c == NULL || mainApplicantAcc.Last_Name__c == NULL || mainApplicantAcc.e_mail__c == NULL ||
            mainApplicantAcc.DOB__c == NULL)
          ){
            String errormsg = AssessmentPanelScreenUtility.checkRequiredFields(mainApplicantAcc, null);
            if(errormsg != null && errormsg != '')
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsg));
            tabDisableSet = '1';
        }*/
        if( spouseAcc.Id == null && (assessment.Marital_Status__c != 'Married' && assessment.Marital_Status__c != 'Common-law') &&
           (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
            assessment.DOB_Main_Applicant__c == NULL)
          ){
            String errormsg = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
            if(errormsg != null && errormsg != '')
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsg));
            tabDisableSet = '1';
        }
        
        if( spouseAcc.Id != null && (assessment.Marital_Status__c != 'Married' && assessment.Marital_Status__c != 'Common-law') &&
           (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
            assessment.DOB_Main_Applicant__c == NULL)
          ){
            String errormsg = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c , assessment);
            if(errormsg != null && errormsg != '')
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsg));
            tabDisableSet = '1';
        }
        
        if( (spouseAcc.Id != NULL) && (assessment.Marital_Status__c == 'Married' || assessment.Marital_Status__c == 'Common-law') &&
           (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
            assessment.DOB_Main_Applicant__c == NULL || assessment.DOB_Spouse__c == NULL || assessment.E_mail_Spouse__c == NULL || assessment.First_Name_Spouse__c == NULL
            || assessment.Last_Name_Spouse__c == NULL)
          ){
              String errormsgSp = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
              if(errormsgSp != null && errormsgSp != ''){
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsgSp));
              }
                  
              tabDisableSet = '1';
          }
        
        if(spouseAcc.Id == null && (assessment.Marital_Status__c == 'Married' || assessment.Marital_Status__c == 'Common-law')
           && (assessment.First_Name_Main_Applicant__c == NULL || assessment.Last_Name_Main_Applicant__c == NULL || assessment.E_mail_Main_Applicant__c == NULL ||
               assessment.DOB_Main_Applicant__c == NULL || assessment.DOB_Spouse__c == NULL || assessment.E_mail_Spouse__c == NULL || assessment.First_Name_Spouse__c== NULL
               || assessment.Last_Name_Spouse__c == NULL)){
                   String errormsgS = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
                   //errormsgS += AssessmentPanelScreenUtility.checkRequiredFields(mainApplicantAcc, spouseAcc,assessment);
                   if(errormsgS != null && errormsgS != '')
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsgS));
                   tabDisableSet = '1';
               }
    }
    
    public pageReference saveOrUpdateProfile(){
        tabDisableSet = '01234'; // Enable all tabs because this button doesn't rerender tabpanel so to resolve NOC Exception this needs to be set all enable
        pageReference pageX = null;
        try{
            
            if( (spouseAcc.Id == NULL) && (assessment.Marital_Status__c != 'Married' && assessment.Marital_Status__c != 'Common-law') &&
               assessment.First_Name_Main_Applicant__c != NULL && assessment.Last_Name_Main_Applicant__c != NULL && assessment.E_mail_Main_Applicant__c != NULL &&
               assessment.DOB_Main_Applicant__c != NULL
              ){
                  if(assessment.Id != Null){
                      assessment.Type__c = 'Express Entry';
                      update assessment;
                      //Pulkit change
                      //update mainApplicantAcc; // Read Only Field Update
                      // Make editable field as read only (MainApplicant)
                      if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                          isSalutation = true;
                      }
                      isFirstName = true; // Make editable field as read only (MainApplicant)
                      isLastName = true; // Make editable field as read only (MainApplicant)
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully updated'));
                  }
                  else{
                      assessment.Type__c = 'Express Entry';
                      insert assessment;
                      //update mainApplicantAcc; // Read Only Field Update
                      // Assigining the Id to the assessment to maintain it in view state 
                      assessment.Id = assessment.Id;
                      // Make editable field as read only (MainApplicant)
                      if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                          isSalutation = true;
                      }
                      isFirstName = true; // Make editable field as read only (MainApplicant)
                      isLastName = true; // Make editable field as read only (MainApplicant)
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully saved'));
                  }
                  
              }
            else if( (spouseAcc.Id == NULL) && (assessment.Marital_Status__c == 'Married' || assessment.Marital_Status__c == 'Common-law') &&
                    (assessment.First_Name_Main_Applicant__c != NULL && assessment.Last_Name_Main_Applicant__c != NULL && assessment.E_mail_Main_Applicant__c	 != NULL &&
                     assessment.DOB_Main_Applicant__c != NULL && assessment.DOB_Spouse__c != NULL && assessment.E_mail_Spouse__c != NULL && assessment.First_Name_Spouse__c != NULL
                    && assessment.Last_Name_Spouse__c != NULL)
                   ){
                       if(assessment.Id != Null){
                           // Check for if any idle account present with spouse email address
                           if(linkIdleSpouseAccount(assessment)){
                               List<Account> accountList = new List<Account>();
                               mainApplicantAcc.Marital_Status__c = assessment.Marital_Status__c;
                               accountList.add(spouseAcc);
                               accountList.add(mainApplicantAcc);
                               update accountList;
                           }
                           else{
                               spouseAcc.Name = assessment.First_Name_Spouse__c+' '+assessment.Last_Name_Spouse__c;
                               spouseAcc.ParentId = mainApplicantAcc.Id;
                               spouseAcc.First_Name__c = assessment.First_Name_Spouse__c;
                               spouseAcc.Last_Name__c = assessment.Last_Name_Spouse__c;
                               spouseAcc.DOB__c = assessment.DOB_Spouse__c;
                               spouseAcc.e_mail__c = assessment.E_mail_Spouse__c;
                               spouseAcc.Salutation__c = assessment.Salutation_Spouse__c;
                               spouseAcc.Phone = assessment.Phone_Spouse__c;
                               spouseAcc.Marital_Status__c = assessment.Marital_Status__c;
                               insert spouseAcc;
                               
                               mainApplicantAcc.Marital_Status__c = assessment.Marital_Status__c;
                               update mainApplicantAcc;
                           }
                           
                           assessment.Spouse_Partner__c = spouseAcc.Id; // Spouse Account Lookup : Line 1583
                           assessment.Type__c = 'Express Entry';
                           update assessment;
                           //update mainApplicantAcc; // Read Only Field Update
                           // Make editable field as read only (MainApplicant)
                           if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                               isSalutation = true;
                           }
                           isFirstName = true; // Make editable field as read only (MainApplicant)
                           isLastName = true; // Make editable field as read only (MainApplicant)
                           // Make editable field as read only (Spouse)
                           if(String.isNotBlank(assessment.Salutation_Spouse__c)){
                               isSpSalutation = true;
                           }
                           isSpFirstName = true; // Make editable field as read only (Spouse)
                           isSpLastName = true; // Make editable field as read only (Spouse)
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully updated'));
                       }
                       else{
                           if(linkIdleSpouseAccount(assessment)){
                               List<Account> accountList = new List<Account>();
                               mainApplicantAcc.Marital_Status__c = assessment.Marital_Status__c;
                               accountList.add(spouseAcc);
                               accountList.add(mainApplicantAcc);
                               update accountList;
                               //update spouseAcc;
                           }
                           else{
                               spouseAcc.Name = assessment.First_Name_Spouse__c+' '+assessment.Last_Name_Spouse__c;
                               spouseAcc.ParentId = mainApplicantAcc.Id;
                               spouseAcc.First_Name__c = assessment.First_Name_Spouse__c;
                               spouseAcc.Last_Name__c = assessment.Last_Name_Spouse__c;
                               spouseAcc.DOB__c = assessment.DOB_Spouse__c;
                               spouseAcc.e_mail__c = assessment.E_mail_Spouse__c;
                               spouseAcc.Salutation__c = assessment.Salutation_Spouse__c;
                               spouseAcc.Phone = assessment.Phone_Spouse__c;
                               spouseAcc.Marital_Status__c = assessment.Marital_Status__c;
                               insert spouseAcc;
                               
                               mainApplicantAcc.Marital_Status__c = assessment.Marital_Status__c;
                               update mainApplicantAcc;
                           }
                           assessment.Spouse_Partner__c = spouseAcc.Id; // Spouse Account Lookup : Line 1583
                           assessment.Type__c = 'Express Entry';
                           insert assessment;
                           //update mainApplicantAcc; // Read Only Field Update
                           // Assigining the Id to the assessment to maintain it in view state 
                           assessment.Id = assessment.Id;
                           // Make editable field as read only (MainApplicant)
                           if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                               isSalutation = true;
                           }
                           isFirstName = true; // Make editable field as read only (MainApplicant)
                           isLastName = true; // Make editable field as read only (MainApplicant)
                           // Make editable field as read only (Spouse)
                           if(String.isNotBlank(assessment.Salutation_Spouse__c)){
                               isSpSalutation = true;
                           }
                           isSpFirstName = true; // Make editable field as read only (Spouse)
                           isSpLastName = true; // Make editable field as read only (Spouse)
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully saved'));
                       }
                       
                   }
            else if( (spouseAcc.Id != NULL) && (assessment.Marital_Status__c != 'Married' && assessment.Marital_Status__c != 'Common-law') &&
                    (assessment.First_Name_Main_Applicant__c != NULL && assessment.Last_Name_Main_Applicant__c != NULL && assessment.E_mail_Main_Applicant__c != NULL &&
                     assessment.DOB_Main_Applicant__c != NULL)
                   ){
                       if(assessment.Id != Null){
                           assessment.Type__c = 'Express Entry';
                           update assessment;
                           //update mainApplicantAcc; // Read Only Field Update
                           // Make editable field as read only (MainApplicant)
                           if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                               isSalutation = true;
                           }
                           isFirstName = true; // Make editable field as read only (MainApplicant)
                           isLastName = true; // Make editable field as read only (MainApplicant)
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully updated'));
                       }
                       else{
                           assessment.Type__c = 'Express Entry';
                           insert assessment;
                           //update mainApplicantAcc; // Read Only Field Update
                           // Assigining the Id to the assessment to maintain it in view state 
                           assessment.Id = assessment.Id;
                           // Make editable field as read only (MainApplicant)
                           if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                               isSalutation = true;
                           }
                           isFirstName = true; // Make editable field as read only (MainApplicant)
                           isLastName = true; // Make editable field as read only (MainApplicant)
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully saved'));
                       }
                       
                   }
            
            else if( (spouseAcc.Id != NULL) && (assessment.Marital_Status__c == 'Married' || assessment.Marital_Status__c == 'Common-law') &&
                    (assessment.First_Name_Main_Applicant__c != NULL && assessment.Last_Name_Main_Applicant__c != NULL && assessment.E_mail_Main_Applicant__c != NULL &&
                     assessment.DOB_Main_Applicant__c != NULL && assessment.DOB_Spouse__c != NULL && assessment.E_mail_Spouse__c != NULL && assessment.First_Name_Spouse__c != NULL
                    && assessment.Last_Name_Spouse__c != NULL)
                   ){
                       if(assessment.Id != Null){
                           if(assessment.Create_Spouse_Assessment__c){
                               assessment.Create_Spouse_Assessment__c = false;
                               assessment.Type__c = 'Express Entry';
                               update assessment;
                               pageX = createSpouseAccount();
                               return pageX;
                           }
                           else{
                               assessment.Type__c = 'Express Entry';
                               update assessment;
                               //update mainApplicantAcc; // Read Only Field Update
                               //update spouseAcc;		// Read Only Field Update
                               // Make editable field as read only (MainApplicant)
                               if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                                   isSalutation = true;
                               }
                               isFirstName = true; // Make editable field as read only (MainApplicant)
                               isLastName = true; // Make editable field as read only (MainApplicant)
                               // Make editable field as read only (Spouse)
                               if(String.isNotBlank(assessment.Salutation_Spouse__c)){
                                   isSpSalutation = true;
                               }
                               isSpFirstName = true; // Make editable field as read only (Spouse)
                               isSpLastName = true; // Make editable field as read only (Spouse)
                               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully updated'));
                           }
                       }
                           
                       else{
                           if(assessment.Create_Spouse_Assessment__c){
                               assessment.Create_Spouse_Assessment__c = false;
                               assessment.Type__c = 'Express Entry';
                               insert assessment;
                               pageX = createSpouseAccount();
                               return pageX;
                           }
                           else{
                               assessment.Type__c = 'Express Entry';
                               insert assessment;
                               //update mainApplicantAcc; // Read Only Field Update
                               //update spouseAcc; // Read Only Field Update
                               // Assigining the Id to the assessment to maintain it in view state 
                               assessment.Id = assessment.Id;
                               // Make editable field as read only (MainApplicant)
                               if(String.isNotBlank(assessment.Salutation_Main_Applicant__c)){
                                   isSalutation = true;
                               }
                               isFirstName = true; // Make editable field as read only (MainApplicant)
                               isLastName = true; // Make editable field as read only (MainApplicant)
                               // Make editable field as read only (Spouse)
                               if(String.isNotBlank(assessment.Salutation_Spouse__c)){
                                   isSpSalutation = true;
                               }
                               isSpFirstName = true; // Make editable field as read only (Spouse)
                               isSpLastName = true; // Make editable field as read only (Spouse)
                               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Profile successfully saved'));
                           }
                           
                       }
                       
                   }
            else{
                String errormsgSp = '';
                //String errormsg = AssessmentPanelScreenUtility.checkRequiredFields(mainApplicantAcc, null);
                String errormsg = AssessmentPanelScreenUtility.checkRequiredFields(assessment.Marital_Status__c,assessment);
                System.debug('errormsg: '+errormsg);
                /*if(mainApplicantAcc.Marital_Status__c == 'Married' || mainApplicantAcc.Marital_Status__c == 'Common-law'){
                    errormsgSp = AssessmentPanelScreenUtility.checkRequiredFields(mainApplicantAcc, spouseAcc);
                    System.debug('errormsgSp: '+errormsgSp);
                }*/
                errormsg = errormsgSp != null && errormsgSp != '' ? errormsg + errormsgSp : errormsg;
                System.debug('errormsg: '+errormsg);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errormsg));

            }
            
        }
        catch(Exception ex){
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
        return pageX;
        // End of - Query(ConsultationSheet)
    }
    
    public void onProfileLeave(){
        // Setting Date Fields because of old viewstate of assessment/Account object date fields
        assessment.DOB_Main_Applicant__c = AssessmentPanelScreenUtility.convertToDate(mainApplicantDOB);
        assessment.DOB_Spouse__c = AssessmentPanelScreenUtility.convertToDate(spouseDOB);
        assessment.Child_s_Birth1__c = AssessmentPanelScreenUtility.convertToDate(childDOB1);
        assessment.Child_s_Birth2__c = AssessmentPanelScreenUtility.convertToDate(childDOB2);
        assessment.Child_s_Birth3__c = AssessmentPanelScreenUtility.convertToDate(childDOB3);
        assessment.Child_s_Birth4__c = AssessmentPanelScreenUtility.convertToDate(childDOB4);
        assessment.Child_s_Birth5__c = AssessmentPanelScreenUtility.convertToDate(childDOB5);
        assessment.Child_s_Birth6__c = AssessmentPanelScreenUtility.convertToDate(childDOB6);
        System.debug('onProfileLeave');
        System.debug('mainApplicantDOB1: '+mainApplicantDOB);
        //System.debug('mainApplicantDOB: '+mainApplicantAcc.DOB__c);
        saveOrUpdateProfile();
        calculateAsmtScore();
    }
    
    public void onOccuClick(){
        tabOpt = 'Occu';
        system.debug('occuTab section');
    }
    
    public void onCSTabClick(){
        tabOpt = 'cdetailTab';
    }
    
    
    public void onProflieClick(){
        tabOpt = 'profile';
    }
    
    public void handleOnChangeWorkEx(){
        tabOpt = 'Occu';
        //Work Ex section - 1
        //assessment.Please_type_a_occupation_1__c = assessment.Please_type_a_occupation_1__c;
        assessment.Duration_1__c = assessment.Duration_1__c;
        assessment.Province_1__c = assessment.Province_1__c;
        assessment.Job_start_1__c = AssessmentPanelScreenUtility.convertToDate(jobStart1);
        assessment.Job_end_1__c = AssessmentPanelScreenUtility.convertToDate(jobEnd1);
        assessment.Type_of_Employment_1__c = assessment.Type_of_Employment_1__c;
        assessment.Work_experience_notes__c = assessment.Work_experience_notes__c;
        assessment.experience_obtained_in_past_5_years_1__c = assessment.experience_obtained_in_past_5_years_1__c;
        //assessment.spouse_have_any_occupational_experience__c = assessment.spouse_have_any_occupational_experience__c;
        //Work Ex Section - 2
        //assessment.Please_type_a_occupation_2__c = assessment.Please_type_a_occupation_2__c;
        assessment.Duration_2__c = assessment.Duration_2__c;
        assessment.Province_2__c = assessment.Province_2__c;
        assessment.Job_start_2__c = AssessmentPanelScreenUtility.convertToDate(jobStart2);
        assessment.Job_end_2__c = AssessmentPanelScreenUtility.convertToDate(jobEnd2);
        assessment.Type_of_Employment_2__c = assessment.Type_of_Employment_2__c;
        assessment.experience_obtained_in_past_5_years_2__c = assessment.experience_obtained_in_past_5_years_2__c;
        //Work Ex Section - 3
       // assessment.Please_type_a_occupation_3__c = assessment.Please_type_a_occupation_3__c;
        assessment.Duration_3__c = assessment.Duration_3__c;
        assessment.Province_3__c = assessment.Province_3__c;
        assessment.Job_start_3__c = AssessmentPanelScreenUtility.convertToDate(jobStart3);
        assessment.Job_end_3__c = AssessmentPanelScreenUtility.convertToDate(jobEnd3);
        assessment.Type_of_Employment_3__c = assessment.Type_of_Employment_3__c;
        assessment.experience_obtained_in_past_5_years_3__c = assessment.experience_obtained_in_past_5_years_3__c;
        //Work Ex Section - 1(Spouse)
        //assessment.Please_type_a_occupation_1_Spouse__c = assessment.Please_type_a_occupation_1_Spouse__c;
        assessment.Duration_1_Spouse__c = assessment.Duration_1_Spouse__c;
        assessment.Province_1_Spouse__c = assessment.Province_1_Spouse__c;
        assessment.Type_of_employment_1_Spouse__c = assessment.Type_of_employment_1_Spouse__c;
        assessment.Job_start_1_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobStartSp1);
        assessment.Job_end_1_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobEndSp1);
        //Work Ex Section - 2(Spouse)
        //assessment.Please_type_a_occupation_2_Spouse__c = assessment.Please_type_a_occupation_2_Spouse__c;
        assessment.Duration_2_Spouse__c = assessment.Duration_2_Spouse__c;
        assessment.Province_2_Spouse__c = assessment.Province_2_Spouse__c;
        assessment.Type_of_employment_2_Spouse__c = assessment.Type_of_employment_2_Spouse__c;
        assessment.Job_start_2_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobStartSp2);
        assessment.Job_end_2_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobEndSp2);
        //Work Ex Section - 3(Spouse)
        //assessment.Please_type_a_occupation_3_Spouse__c = assessment.Please_type_a_occupation_3_Spouse__c;
        assessment.Duration_3_Spouse__c = assessment.Duration_3_Spouse__c;
        assessment.Province_3_Spouse__c = assessment.Province_3_Spouse__c;
        assessment.Type_of_employment_3_Spouse__c = assessment.Type_of_employment_3_Spouse__c;
        assessment.Job_start_3_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobStartSp3);
        assessment.Job_end_3_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobEndSp3);
        
    }
    
    // Method to Handle Required Fields of Occupation Tab
    public void handleOnChangeRequiredWorkEx(){
        assessment.Duration_1__c = assessment.Duration_1__c;
        assessment.Duration_2__c = assessment.Duration_2__c;
        assessment.Duration_3__c = assessment.Duration_3__c;
        assessment.Duration_1_Spouse__c = assessment.Duration_1_Spouse__c;
        assessment.Duration_2_Spouse__c = assessment.Duration_2_Spouse__c;
        assessment.Duration_3_Spouse__c = assessment.Duration_3_Spouse__c;
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleSpouseHaveAnyWorkEx(){
        assessment.spouse_have_any_occupational_experience__c = assessment.spouse_have_any_occupational_experience__c;
        
        assessment.Please_type_a_occupation_1_Spouse__c = null;
        assessment.Duration_1_Spouse__c = null;
        assessment.Location_1_Spouse__c = null;
        assessment.Province_1_Spouse__c = null;
        assessment.Type_of_employment_1_Spouse__c = null;
        
        assessment.Please_type_a_occupation_2_Spouse__c = null;
        assessment.Duration_2_Spouse__c = null;
        assessment.Location_2_Spouse__c = null;
        assessment.Province_2_Spouse__c = null;
        assessment.Type_of_employment_2_Spouse__c = null;
        
        assessment.Please_type_a_occupation_3_Spouse__c = null;
        assessment.Duration_3_Spouse__c = null;
        assessment.Location_3_Spouse__c = null;
        assessment.Province_3_Spouse__c = null;
        assessment.Type_of_employment_3_Spouse__c = null;
    }
    
    public void updateWorkex(){
        tabDisableSet = '01234';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));

        }
        else{
            try{
                assessment.Type__c = 'Express Entry';
                update assessment;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Work Experience successfully added'));
            }
            catch(Exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error occured: '+ex.getMessage()));
            }
        }
        
    }
    
    public void displayMoreWorkEx(){
        System.debug('workExShow before: '+workExShow);
        if(workExShow.contains('2')){
            workExShow += '3';
        }
        else{
            workExShow += '2';
        }
        System.debug('workExShow after: '+workExShow);
        
    }
    
    public void removeWorkEx2(){
        workExShow = workExShow.remove('2');
        assessment.Please_type_a_occupation_2__c = null;
        assessment.Duration_2__c = null;
        assessment.Location_2__c = null;
        assessment.Province_2__c = null;
        assessment.Currently_working_on_this_job_2__c = null;
        assessment.Job_start_2__c = null;
        assessment.Job_end_2__c = null;
        assessment.Type_of_Employment_2__c = null;
    }
    
    public void removeWorkEx3(){
        workExShow = workExShow.remove('3');
        assessment.Please_type_a_occupation_3__c = null;
        assessment.Duration_3__c = null;
        assessment.Location_3__c = null;
        assessment.Province_3__c = null;
        assessment.Currently_working_on_this_job_3__c = null;
        assessment.Job_start_3__c = null;
        assessment.Job_end_3__c = null;
        assessment.Type_of_Employment_3__c = null;
    }
    
    public void handleWorkEx1(){
        jobStart1 = null;
        jobEnd1 = null;
        assessment.Location_1__c = assessment.Location_1__c;
        assessment.Job_start_1__c = null;
        assessment.Job_end_1__c = null;
        assessment.Province_1__c = null;
        assessment.Currently_working_on_this_job_1__c = null;
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleWorkEx1CurrentJob(){
        jobEnd1 = null;
        assessment.Currently_working_on_this_job_1__c = assessment.Currently_working_on_this_job_1__c;
        assessment.Job_end_1__c = null;
    }
    
    public void handleWorkEx2(){
        jobStart2 = null;
        jobEnd2 = null;
        assessment.Location_2__c = assessment.Location_2__c;
        
        assessment.Province_2__c = null;
        assessment.Currently_working_on_this_job_2__c = null;
        assessment.Job_start_2__c = null;
        assessment.Job_end_2__c = null;
        
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleWorkEx2CurrentJob(){
        assessment.Currently_working_on_this_job_2__c = assessment.Currently_working_on_this_job_2__c;
        jobEnd2 = null;
        assessment.Job_end_2__c = null;
    }
    
    public void handleWorkEx3(){
        jobStart3 = null;
        jobEnd3 = null;
        assessment.Location_3__c = assessment.Location_3__c;
        
        assessment.Province_3__c = null;
        assessment.Currently_working_on_this_job_3__c = null;
        assessment.Job_start_3__c = null;
        assessment.Job_end_3__c = null;
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleWorkEx3CurrentJob(){
        assessment.Currently_working_on_this_job_3__c = assessment.Currently_working_on_this_job_3__c;
        jobEnd3 = null;
        assessment.Job_end_3__c = null;
    }
    
    public void handleWorkExSP1(){
        jobStartSp1 = null;
        jobEndSp1 = null;
        assessment.Location_1_Spouse__c = assessment.Location_1_Spouse__c;
        assessment.Province_1_Spouse__c = null;
        assessment.Currently_working_on_this_job_1_Spouse__c = null;
        assessment.Job_start_1_Spouse__c = null;
        assessment.Job_end_1_Spouse__c = null;
        
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleWorkExSP2(){
        jobStartSp2 = null;
        jobEndSp2 = null;
        assessment.Currently_working_on_this_job_2_Spouse__c = null;
        assessment.Job_start_2_Spouse__c = null;
        assessment.Job_end_2_Spouse__c = null;
        assessment.Location_2_Spouse__c = assessment.Location_2_Spouse__c;
        assessment.Province_2_Spouse__c = null;
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleWorkExSP3(){
        jobStartSp3 = null;
        jobEndSp3 = null;
        assessment.Job_start_3_Spouse__c = null;
        assessment.Job_end_3_Spouse__c = null;
        assessment.Currently_working_on_this_job_3_Spouse__c = null;
        assessment.Location_3_Spouse__c = assessment.Location_3_Spouse__c;
        assessment.Province_3_Spouse__c = null;
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
    }
    
    public void handleCurrentWorkExSP1(){
        assessment.Currently_working_on_this_job_1_Spouse__c = assessment.Currently_working_on_this_job_1_Spouse__c;
        jobEndSp1 = null;
        assessment.Job_end_1_Spouse__c = null;
        
    }
    
    public void handleCurrentWorkExSP2(){
        jobEndSp2 = null;
        assessment.Job_end_2_Spouse__c = null;
        assessment.Currently_working_on_this_job_2_Spouse__c = assessment.Currently_working_on_this_job_2_Spouse__c;
    }
    
    public void handleCurrentWorkExSP3(){
        jobEndSp3 = null;
        assessment.Job_end_3_Spouse__c = null;
        assessment.Currently_working_on_this_job_3_Spouse__c = assessment.Currently_working_on_this_job_3_Spouse__c;
    }
    
    public void displayMoreWorkExSP(){
        System.debug('workExShowSP before: '+workExShowSP);
        if(workExShowSP.contains('2')){
            workExShowSP += '3';
        }
        else{
            workExShowSP += '2';
        }
        System.debug('workExShowSP after: '+workExShowSP);
        
        
    }
    
    public void removeWorkExSP2(){
        workExShowSP = workExShowSP.remove('2');
        assessment.Please_type_a_occupation_2_Spouse__c = null;
        assessment.Duration_2_Spouse__c = null;
        assessment.Location_2_Spouse__c = null;
        assessment.Province_2_Spouse__c = null;
        assessment.Type_of_employment_2_Spouse__c = null;
        
    }
    
    public void removeWorkExSP3(){
        workExShowSP = workExShowSP.remove('3');
        assessment.Please_type_a_occupation_3_Spouse__c = null;
        assessment.Duration_3_Spouse__c = null;
        assessment.Location_3_Spouse__c = null;
        assessment.Province_3_Spouse__c = null;
        assessment.Type_of_employment_3_Spouse__c = null;
    }
    
    public void onOccuLeave(){
        //Setting up date fields of occu tab fields becuz of old view state of Assessment's date fields
        assessment.Job_start_1__c = AssessmentPanelScreenUtility.convertToDate(jobStart1);
        assessment.Job_end_1__c = AssessmentPanelScreenUtility.convertToDate(jobEnd1);
        assessment.Job_start_2__c = AssessmentPanelScreenUtility.convertToDate(jobStart2);
        assessment.Job_end_2__c = AssessmentPanelScreenUtility.convertToDate(jobEnd2);
        assessment.Job_start_3__c = AssessmentPanelScreenUtility.convertToDate(jobStart3);
        assessment.Job_end_3__c = AssessmentPanelScreenUtility.convertToDate(jobEnd3);
        
        assessment.Job_start_1_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobStartSp1);
        assessment.Job_end_1_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobEndSp1);
        assessment.Job_start_2_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobStartSp2);
        assessment.Job_end_2_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobEndSp2);
        assessment.Job_start_3_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobStartSp3);
        assessment.Job_end_3_Spouse__c = AssessmentPanelScreenUtility.convertToDate(jobEndSp3);
        
        updateWorkex();
        calculateAsmtScore();
    }
    
    // Unused Method - related to Biz/Fin tab
    public void onBizClick(){
        tabOpt = 'Biz';
    }
    
    // Tab - Business & Finance Methods
    public void saveBiz(){
        try{
            assessment.Type__c = 'Express Entry';
            update assessment;
            if(cSheetBiz.Id != null){
                update cSheetBiz;
            }
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Business/Finance successfully updated'));
        }
        catch(Exception ex){
            System.debug('Exception occured: '+ex.getMessage()+' Line Nunber: '+ex.getLineNumber());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error occured: '+ex.getMessage()));
        }
    }
    
    public void handleOnChangeBizAsmt(){
        tabOpt = 'Biz';
        assessment.Networth__c = assessment.Networth__c;
        assessment.Years_of_managerial_Experience__c = assessment.Years_of_managerial_Experience__c;
        assessment.Number_of_staff_managed__c = assessment.Number_of_staff_managed__c;
        assessment.Own_business__c = assessment.Own_business__c;
        assessment.Precentage_of_ownership__c = assessment.Precentage_of_ownership__c;
        assessment.Annual_sales_CDN__c = assessment.Annual_sales_CDN__c;
        assessment.Annual_Income_CDN__c = assessment.Annual_Income_CDN__c;
        assessment.Net_business_assets_CDN__c = assessment.Net_business_assets_CDN__c;
        assessment.Business_Finance_Notes__c = assessment.Business_Finance_Notes__c;
    }
    
    public void handleOnChangeBizCsheet(){
        tabOpt = 'Biz';
        cSheetBiz.Funds_Already_Available__c = cSheetBiz.Funds_Already_Available__c;
        cSheetBiz.On_the_Name_of_Main_Applicant__c = cSheetBiz.On_the_Name_of_Main_Applicant__c;
        cSheetBiz.Funds_for_PR_Comments__c = cSheetBiz.Funds_for_PR_Comments__c;
        cSheetBiz.Funds_AvailableImmigration__c = cSheetBiz.Funds_AvailableImmigration__c;
        
        cSheetBiz.How_Paying_For_Studies__c = cSheetBiz.How_Paying_For_Studies__c;
        cSheetBiz.Sponsor__c = cSheetBiz.Sponsor__c;
        cSheetBiz.FundsAvailableStudy__c = cSheetBiz.FundsAvailableStudy__c;
        cSheetBiz.Tax_Return_Files_Available__c = cSheetBiz.Tax_Return_Files_Available__c;
        cSheetBiz.Other_Source_Of_Income__c = cSheetBiz.Other_Source_Of_Income__c;
        cSheetBiz.Average_Salary__c = cSheetBiz.Average_Salary__c;
		cSheetBiz.Annual_Salary_Main_for_spouse__c = cSheetBiz.Annual_Salary_Main_for_spouse__c;
        cSheetBiz.Funds_for_Visa_Comments__c = cSheetBiz.Funds_for_Visa_Comments__c;
    }
    
    public void onBizLeave(){
        saveBiz();
    }
    
    //Method for assessment Tab Enter and Calculate Score
    
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
    
    //Method for creating new Assessment
    //Last Modified - 06 July 2021
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
            assessment.E_mail_Main_Applicant__c = mainApplicantAcc.e_mail__c;
        if(mainApplicantAcc.Phone != null)
            assessment.Phone_Main_Applicant__c = mainApplicantAcc.Phone;
        if(mainApplicantAcc.Personal_Information_Notes__c != null)
            assessment.Personal_Information_Notes__c = mainApplicantAcc.Personal_Information_Notes__c;
        
        // handling profile field editability for spouse account
        if(String.isNotBlank(spouseAcc.Salutation__c)){
            assessment.Salutation_Spouse__c = spouseAcc.Salutation__c;
            isSpSalutation = true;
        }
        else{
            isSpSalutation = false;
        }
        
        if(String.isNotBlank(spouseAcc.First_Name__c)){
            assessment.First_Name_Spouse__c = spouseAcc.First_Name__c;
            isSpFirstName = true;
        }
        else{
            isSpFirstName = false;
        }
        
        if(String.isNotBlank(spouseAcc.Last_Name__c)){
            assessment.Last_Name_Spouse__c = spouseAcc.Last_Name__c;
            isSpLastName = true;
        }
        else{
            isSpLastName = false;
        }
        if(spouseAcc.e_mail__c != null)
            assessment.E_mail_Spouse__c = spouseAcc.e_mail__c;
        if(spouseAcc.Phone != null)
            assessment.Phone_Spouse__c = spouseAcc.Phone;
        
        // Setting up date fields for spouse, main applicant
        mainApplicantDOB = AssessmentPanelScreenUtility.convertToString(mainApplicantAcc?.DOB__c);
        assessment.DOB_Main_Applicant__c = mainApplicantAcc?.DOB__c;
        spouseDOB = AssessmentPanelScreenUtility.convertToString(spouseAcc?.DOB__c);
        assessment.DOB_Spouse__c = spouseAcc?.DOB__c;
        // Showing main applicant & spouse age in years, months & days
        dobOutputMainApplicant = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(mainApplicantAcc?.DOB__c, System.today());
		dobOutputSpouse = AssessmentPanelScreenUtility.getAgeInYearsMonthsDays(spouseAcc?.DOB__c, System.today());
        
        
        assessment.Id = null;
        assessment.Account__c = mainApplicantAcc?.Id;
        assessment.Spouse_Partner__c = spouseAcc?.Id; // Spouse Account Lookup
        if(csId != null){
            assessment.Consultation_Sheet__c = csId;
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
    
    public void handleNOC1(){
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
        assessment.Please_type_a_occupation_1__c = assessment.Please_type_a_occupation_1__c;
        if(assessment.Please_type_a_occupation_1__c != null){
            nocDetails1 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                           WHERE Id = :assessment.Please_type_a_occupation_1__c][0].NOC_Details__c;
        }
        else{
            nocDetails1 = null;
        }
        
    }
    
    public void handleNOC2(){
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
        assessment.Please_type_a_occupation_2__c = assessment.Please_type_a_occupation_2__c;
        if(assessment.Please_type_a_occupation_2__c != null){
            nocDetails2 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                           WHERE Id = :assessment.Please_type_a_occupation_2__c][0].NOC_Details__c;
        }
        else{
            nocDetails2 = null;
        }
    }
    
    public void handleNOC3(){
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
        assessment.Please_type_a_occupation_3__c = assessment.Please_type_a_occupation_3__c;
        if(assessment.Please_type_a_occupation_3__c != null){
            nocDetails3 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                           WHERE Id = :assessment.Please_type_a_occupation_3__c][0].NOC_Details__c;
        }
        else{
            nocDetails3 = null;
        }
    }
    
    public void handleNOCSP1(){
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
        assessment.Please_type_a_occupation_1_Spouse__c = assessment.Please_type_a_occupation_1_Spouse__c;
        if(assessment.Please_type_a_occupation_1_Spouse__c != null){
            nocDetailsSP1 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                             WHERE Id = :assessment.Please_type_a_occupation_1_Spouse__c][0].NOC_Details__c;
        }
        else{
            nocDetailsSP1 = null;
        }
    }
    
    public void handleNOCSP2(){
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
        assessment.Please_type_a_occupation_2_Spouse__c = assessment.Please_type_a_occupation_2_Spouse__c;
        if(assessment.Please_type_a_occupation_2_Spouse__c != null){
            nocDetailsSP2 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                             WHERE Id = :assessment.Please_type_a_occupation_2_Spouse__c][0].NOC_Details__c;
        }
        else{
            nocDetailsSP2 = null;
        }
    }
    
    public void handleNOCSP3(){
        tabDisableSet = '01234';
        tabOpt = 'Occu';
        String errorMsg = AssessmentPanelScreenUtility.checkRequiredOnOccuTab(assessment, workExShow, workExShowSP);
        if(errorMsg != null && errorMsg != ''){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
            tabDisableSet = '2';
        }
        assessment.Please_type_a_occupation_3_Spouse__c = assessment.Please_type_a_occupation_3_Spouse__c;
        if(assessment.Please_type_a_occupation_3_Spouse__c != null){
            nocDetailsSP3 = [SELECT NOC_Details__c FROM Eligible_Occupation__c
                             WHERE Id = :assessment.Please_type_a_occupation_3_Spouse__c][0].NOC_Details__c;
        }
        else{
            nocDetailsSP3 = null;
        }
    }
    
    public void calculateAsmtScore(){
        List<assessment__c> asmtList = new List<assessment__c>();
        asmtList.add(assessment);
        String statusMsg = AssessmentScoreCalculator.calcPoints(asmtList);
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
                                       ,DOB_Spouse__c,Last_Name_Spouse__c,Phone_Spouse__c,Type__c /*Pulkit change end*/
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
                String base = '/apex/AssessmentRedirectionPage?accountId='+accountId+'&origin=EEbtn&consultationId='+cSheetDetail.Id;
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
								(SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC)
                                FROM Consultation_Sheet__c WhERE Id = :selectedCsheetId];
                
                // setting up date fields 05 July 2021
                csDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Date__c);
                timeProjected = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Time_Projected__c);
                statusExpirationDate = AssessmentPanelScreenUtility.convertToString(cSheetDetail.Status_Expiration_Date__c);
                // Refresh the List of consultations in tab - 1
                cSheets = [SELECT Id, Name, Opportunity__r.name, Consultation_Status__c, Date__c, (SELECT Id, Name, Consultation_Sheet__r.Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessments__r order by createdDate DESC) 
                           FROM Consultation_Sheet__c WHERE Account__c = :accountId order by createdDate DESC];
                
                //Refresh the assessments without consultation on tab 1
                asmts = [SELECT Id, Name, Account__r.Name, CreatedDate, Total__c, Total_EE__c,Type__c FROM Assessment__c 
                         WHERE (Account__c = :accountId AND Consultation_Sheet__c = Null) order by createdDate DESC];
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Consultation Sheet Successfully Created!'));
                //Start new Assessment
                //Pulkit added
                String base = '/apex/AssessmentRedirectionPage?accountId='+accountId+'&origin=EEbtn&consultationId='+selectedCsheetId;
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
    
    public void gotoConsultationSheet(){
        List<assessment__c> asmtList = [Select Consultation_Sheet__c,Type__c From assessment__c WHERE Id = : assessment.Id];
        selectedCsheetId = asmtList[0].Consultation_Sheet__c;
        tabOpt = 'cdetailTab';
        if(String.isNotBlank(selectedCsheetId))
        	onCSheetClick();
    }
    
    public boolean linkIdleSpouseAccount(assessment__c assessment){
        Boolean isLinked = false;
        if(assessment == null || assessment.E_mail_Spouse__c == null){
            return isLinked;
        }
        // Query Account with email address filled in spouse email field
        List<Account> relatedAccs = [Select Id, First_Name__c, Last_Name__c, Salutation__c, DOB__c, e_mail__c, Phone, ParentId
                       from Account Where e_mail__c =: assessment.E_mail_Spouse__c LIMIT 1];
        if(!relatedAccs.isEmpty()){
            // Is this account an Idle account (No Parent-child relation with another account)
            List<Account> relatedAccSpouse = [Select Id from Account Where ParentId =: relatedAccs.get(0).Id LIMIT 1];
            if(String.isBlank(relatedAccs.get(0).ParentId) && relatedAccSpouse.isEmpty() && relatedAccs.get(0).Id != mainApplicantAcc.Id){
                // If its Idle link it to main applicant
                spouseAcc.Id = relatedAccs.get(0).Id;
                spouseAcc.ParentId = mainApplicantAcc.Id;
                spouseAcc.First_Name__c = assessment.First_Name_Spouse__c;
                spouseAcc.Last_Name__c = assessment.Last_Name_Spouse__c;
                spouseAcc.Name = assessment.First_Name_Spouse__c + ' ' + assessment.Last_Name_Spouse__c;
                spouseAcc.DOB__c = assessment.DOB_Spouse__c;
                spouseAcc.e_mail__c = assessment.E_mail_Spouse__c;
                spouseAcc.Salutation__c = assessment.Salutation_Spouse__c;
                spouseAcc.Phone = assessment.Phone_Spouse__c;
                spouseAcc.Marital_Status__c = assessment.Marital_Status__c;
                
                isLinked = true;
            }
        }
        return isLinked;
    }
    
    public pageReference createSpouseAccount(){
        assessment = new assessment__c();
        assessment.Account__c = spouseAcc.Id;
        assessment.Spouse_Partner__c = mainApplicantAcc.Id;
        assessment.Type__c = 'Express Entry';
        try{
            insert assessment;     
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Spouse assessment created'));
            String url = '/apex/AssessmentPanelScreen?accountId='+spouseAcc.Id +'&asId='+assessment.Id;
            PageReference pageRef = new PageReference(url);
            pageRef.setRedirect(true);
            return pageRef;
        }
        Catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
            return null;
        }
    }
    
    public pageReference pnpRedirection()
    {
        try{
            if(assessment.Id != null)
            {
            	update assessment;    
            }
            String consultationid = null;
            if(assessment.Consultation_Sheet__c != null)
                consultationid = '&consultationId='+assessment.Consultation_Sheet__c;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Assessment Updated successfully'));
            String url = '/apex/AssessmentRedirectionPage?accountId='+accountId+'&origin=pnptab';
            if(String.isNotBlank(consultationid))
                url+=consultationid;
            if(assessment.Id != null)
                url+= '&eeId='+assessment.Id;
            System.debug('url: '+url);
            PageReference pageRef = new PageReference(url);
            pageRef.setRedirect(true);
            return pageRef;
        }
        catch(DMLException ex)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Required fields are missing. Please complete those fields'));
            return null;
		}
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
            return null;
        }
        
    }
    
}