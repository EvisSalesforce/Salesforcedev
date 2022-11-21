@isTest
public class TestDataFactory {
    
    // Method to return account list
    public static List<Account> createAccounts(Integer numberOfActs, Id parentActId){
        List<Account> actList = new List<Account>();
        for(Integer i = 1; i <= numberOfActs; i++){
            Account acc = new Account();
            acc.First_Name__c ='Av';
            acc.Last_Name__c = 'Test' + i;
            acc.Name = acc.First_Name__c + acc.Last_Name__c;
            acc.e_mail__c = 'test'+i+'@xyz.com';
            acc.Territory__c = 'Vancouver';
            acc.DOB__c = Date.newInstance(1993, 06, 25);
            acc.ParentId = parentActId;
            acc.Marital_Status__c = 'Married';
            actList.add(acc);
        }
        return actList;
    }
    
    // Method to return Opportunity list
    public static List<Opportunity> createOppty(Integer numberOfOppty, Id accountId){
        List<Opportunity> opptyList = new List<Opportunity>();
        for(Integer i = 1; i <= numberOfOppty; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'testOpp' + i;
            opp.AccountId = accountId;
            opp.Number_of_Applicants__c = 2;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today() + 30;
            opp.Rating__c = 'HOT';
            
            opptyList.add(opp);
        }
        return opptyList;
    }
    
    // Method to return List of consultation Sheets
    public static List<Consultation_Sheet__c> createCSheets(Integer numberOfSheets, Id accountId, Id opptyId){
        List<Consultation_Sheet__c> cSheets = new List<Consultation_Sheet__c>();
        
        for(Integer i = 0; i <= numberOfSheets; i++){
            Consultation_Sheet__c cs = new Consultation_Sheet__c();
            cs.Account__c = accountId;
            cs.Consultation_Status__c = 'Scheduled';
            cs.Opportunity__c = opptyId;
            cSheets.add(cs);
        }
        return cSheets;
    }
    
    // Method to return list of assessment
    public static List<assessment__c> createAsmts(Integer numberOfasmts, Id accountId, Id CSheetId, 
                                                  Id nocId){
        List<assessment__c> asmtList = new List<assessment__c>();
        for(Integer i = 0; i <= numberOfasmts; i++){
            assessment__c assessment = new assessment__c();
            assessment.Account__c = accountId;
            assessment.Consultation_Sheet__c = CSheetId;
            assessment.Number_of_children__c = '6+';
            assessment.Child_s_Birth1__c = Date.newInstance(2005, 8, 21);
            assessment.Child_s_Birth2__c = Date.newInstance(2005, 8, 21);
            assessment.Child_s_Birth3__c = Date.newInstance(2005, 8, 21);
            assessment.Child_s_Birth4__c = Date.newInstance(2005, 8, 21);
            assessment.Child_s_Birth5__c = Date.newInstance(2005, 8, 21);
            assessment.Child_s_Birth6__c = Date.newInstance(2005, 8, 21);
            assessment.Child_s_Name1__c = 'c1' + i;
            assessment.Child_s_Name2__c = 'c2' + i;
            assessment.Child_s_Name3__c = 'c3' + i;
            assessment.Child_s_Name4__c = 'c4' + i;
            assessment.Child_s_Name5__c = 'c5' + i;
            assessment.Child_s_Name6__c = 'c6' + i;
            assessment.Children_Notes__c = 'test notes...';
            assessment.Name_of_diploma1__c = 'diploma1';
            assessment.Name_of_diploma2__c = 'diploma2';
            assessment.Country_of_studies__c = 'India';
            assessment.Post_secondaries_in_canada__c = 'Yes';
            assessment.Type_of_educational_institute__c = 'Public';
            assessment.Post_secondary_studies__c = '2 years';
            assessment.Name_of_bachelor_s_degree__c = 'test';
            assessment.Education_Notes__c = 'test notes';
            assessment.Name_of_diploma1_Spouse__c = 'diplomaSp1';
            assessment.Name_of_diploma2_Spouse__c = 'diplomaSp2';
            assessment.Country_of_studies_Spouse__c = 'India';
            assessment.Post_secondaries_in_canada_Spouse__c = 'Yes';
            assessment.Type_of_educational_institute_Spouse__c = 'public';
            assessment.Post_secondary_studies_Spouse__c = '2 years';
            assessment.Name_of_bachelor_s_degree_Spouse__c = 'test';
            assessment.Education_Notes_Spouse__c = 'test';
            assessment.French_first_language__c = false;
            assessment.Do_you_speak_English__c = 'Yes';
            assessment.English_test_type__c = 'IELTS';
            assessment.English_speaking__c = '9';
            assessment.English_reading__c = '9';
            assessment.English_Writing__c = '9';
            assessment.English_Listening__c = '9';
            assessment.Do_you_speak_French__c = 'Yes';
            assessment.Have_you_done_TEF__c = 'TEF';
            assessment.French_speaking__c = '393-415(TEF)';
            assessment.French_reading__c = '263-277(TEF)';
            assessment.French_Writing__c = '393-415(TEF)';
            assessment.French_Listening__c = '316-333(TEF)';
            assessment.Language_Notes__c = 'test';
            assessment.French_first_language_Spouse__c = false;
            assessment.Do_you_speak_English__c = 'Yes';
            assessment.English_test_type_Spouse__c = 'IELTS';
            assessment.English_speaking_Spouse__c = '9';
            assessment.English_reading_Spouse__c = '9';
            assessment.English_Writing_Spouse__c = '9';
            assessment.English_Listening_Spouse__c = '9';
            assessment.Do_you_speak_French_Spouse__c = 'Yes';
            assessment.Have_you_done_TEF_Spouse__c = 'TEF';
            assessment.French_speaking_Spouse__c = '393-415(TEF)';
            assessment.French_reading_Spouse__c = '263-277(TEF)';
            assessment.French_Writing_Spouse__c = '393-415(TEF)';
            assessment.French_Listening_Spouse__c = '316-333(TEF)';
            assessment.Language_Notes_Spouse__c = 'test';
            assessment.Certificate_of_Qualification_from_Canada__c = 'Yes';
            assessment.have_been_canada_as_temp_worker__c = 'Yes';
            assessment.Have_you_received_an_LMIA__c = 'Yes';
            assessment.NOC_received__c = '00';
            assessment.Relatives_In_Canada_List__c = 'Sister or Brother';
            assessment.Preferred_destination_in_canada__c = 'Alberta (AB)';
            assessment.Have_Province_Nomination_except_Quebec__c = 'Yes';
            
            //Work Ex section - 1
            assessment.Please_type_a_occupation_1__c = nocId;
            assessment.Duration_1__c = '6 years or more';
            assessment.Location_1__c = 'In Canada';
            assessment.Currently_working_on_this_job_1__c = 'No';
            assessment.spouse_have_any_occupational_experience__c = 'Yes';
            //Work Ex Section - 2
            assessment.Please_type_a_occupation_2__c = nocId;
            assessment.Duration_2__c = '6 years or more';
            assessment.Location_2__c = 'In Canada';
            assessment.Currently_working_on_this_job_2__c = 'No';
            //Work Ex Section - 3
            assessment.Please_type_a_occupation_3__c = nocId;
            assessment.Duration_3__c = '6 years or more';
            assessment.Location_3__c = 'In Canada';
            assessment.Currently_working_on_this_job_3__c = 'Yes';
            //Work Ex Section - 1(Spouse)
            assessment.Please_type_a_occupation_1_Spouse__c = nocId;
            assessment.Duration_1_Spouse__c = '6 years or more';
            assessment.Location_1_Spouse__c = 'In Canada';
            //Work Ex Section - 2(Spouse)
            assessment.Please_type_a_occupation_2_Spouse__c = nocId;
            assessment.Duration_2_Spouse__c = '6 years or more';
            assessment.Location_2_Spouse__c = 'In Canada';
            //Work Ex Section - 3(Spouse)
            assessment.Please_type_a_occupation_3_Spouse__c = nocId;
            assessment.Duration_3_Spouse__c = '6 years or more';
            assessment.Location_3_Spouse__c = 'In Canada';
            
            asmtList.add(assessment);
        }
        return asmtList;
    }
    
    // Method to return Eligible Occupation List
    public static List<Eligible_Occupation__c> createNOCs(Integer numberOfNOCs){
        List<Eligible_Occupation__c> nocList = new List<Eligible_Occupation__c>();
        
        for(Integer i = 0; i <= numberOfNOCs; i++){
            Eligible_Occupation__c noc = new Eligible_Occupation__c();
            noc.Name = '2173';
            noc.NOC_Details__c = 'cloud architect (NOC 2173)';
            nocList.add(noc);
        }
        return nocList;
    }
    
    // Method to return AssessmentParseJSON Wrapper obj
    public static AssessmentParseJSON createAssessmentParseJSON(){
        AssessmentParseJSON asp = new AssessmentParseJSON();
        AssessmentParseJSON.cls_info infos = new AssessmentParseJSON.cls_info();
        infos.first_name = 'Sammy';
        infos.last_name = 'j';
        infos.email = 'sammytest@test123.com';
        infos.dob = '05/05/1990';
        infos.nationality = 'Indian';
        infos.country = 'India';
        infos.city = 'Delhi';
        infos.marital_status = 'Married';
        infos.spouse_citizen = 'Yes';
        infos.spouse_first_name = 'Sarena';
        infos.spouse_last_name = 'j';
        infos.spouse_dob = '05/05/1990';
        infos.spouse_email = 'sarenatest@test123.com';
        infos.number_of_children = '1';
        infos.ChildName1 = 'Arya';
        infos.ChildBirth1 = '23/07/2008';
        infos.ChildName2 = 'Arya';
        infos.ChildBirth2 = '23/07/2008';
        infos.ChildName3 = 'Arya';
        infos.ChildBirth3 = '23/07/2008';
        infos.ChildName4 = 'Arya';
        infos.ChildBirth4 = '23/07/2008';
        infos.ChildName5 = 'Arya';
        infos.ChildBirth5 = '23/07/2008';
        infos.ChildName6 = 'Arya';
        infos.ChildBirth6 = '23/07/2008';
        
        asp.info = infos;
        
        AssessmentParseJSON.cls_other others = new AssessmentParseJSON.cls_other();
        others.relatives_in_canada = 'Sister or Brother';
        others.funds_available = '0 to 9,999';
        others.employer_location = 'Alberta (AB)';
        others.how_hear_about_us = '';
        others.job_offer = 'Yes';
        others.note = 'some note';
        others.province_certificate_qualification = 'Yes';
        others.temporary_foreign_worker = 'Yes';
        others.lmia = 'Yes';
        others.Noc_received = '00';
        others.how_hear_about_us = 'ALTERI INSURANCE';
        others.Provincial_Nomination = 'Yes';
        
        asp.other = others;
        
        //Language Array init
        List<AssessmentParseJSON.cls_languages> clsLangs = new List<AssessmentParseJSON.cls_languages>();

        // Main Applicant ENGLISH
        AssessmentParseJSON.cls_languages EnlangMain = new AssessmentParseJSON.cls_languages();
        EnlangMain.applicant_or_spouse = 'Main Applicant';
        EnlangMain.language_name = 'ENGLISH';
        EnlangMain.speak_this_language = 'Yes';
        EnlangMain.main_language = 'false';
        EnlangMain.test = 'CELPIP';
        // adding skill to it
        List<AssessmentParseJSON.cls_skills> SkillEnMainList = new List<AssessmentParseJSON.cls_skills>();
        AssessmentParseJSON.cls_skills skillEnMain = new AssessmentParseJSON.cls_skills();
        skillEnMain.listening = 'Level 10';
        skillEnMain.reading = 'Level 10';
        skillEnMain.speaking = 'Level 10';
        skillEnMain.writing = 'Level 10';
        SkillEnMainList.add(skillEnMain);
        
        EnlangMain.skills = SkillEnMainList;
        // Add the ENGLISH of Main Applicant in it
        clsLangs.add(EnlangMain);
        
        // Main Applicant French
        AssessmentParseJSON.cls_languages frlangMain = new AssessmentParseJSON.cls_languages();
        frlangMain.applicant_or_spouse = 'Main Applicant';
        frlangMain.language_name = 'FRENCH';
        frlangMain.speak_this_language = 'Yes';
        frlangMain.main_language = 'false';
        frlangMain.test = 'No';
        // adding skill to it
        List<AssessmentParseJSON.cls_skills> SkillFrMainList = new List<AssessmentParseJSON.cls_skills>();
        AssessmentParseJSON.cls_skills skillfrMain = new AssessmentParseJSON.cls_skills();
        skillfrMain.listening = 'Lower Intermediate (CLB 5)';
        skillfrMain.reading = 'Lower Intermediate (CLB 5)';
        skillfrMain.speaking = 'Lower Intermediate (CLB 5)';
        skillfrMain.writing = 'Lower Intermediate (CLB 5)';
        SkillFrMainList.add(skillfrMain);
        
        frlangMain.skills = SkillFrMainList;
        // Add the ENGLISH of Main Applicant in it
        clsLangs.add(frlangMain);
        
        // Spouse ENGLISH
        AssessmentParseJSON.cls_languages EnlangSp = new AssessmentParseJSON.cls_languages();
        EnlangSp.applicant_or_spouse = 'Spouse';
        EnlangSp.language_name = 'ENGLISH';
        EnlangSp.speak_this_language = 'Yes';
        EnlangSp.main_language = 'false';
        EnlangSp.test = 'CELPIP';
        // adding skill to it
        List<AssessmentParseJSON.cls_skills> SkillEnSpList = new List<AssessmentParseJSON.cls_skills>();
        AssessmentParseJSON.cls_skills skillEnSp = new AssessmentParseJSON.cls_skills();
        skillEnSp.listening = 'Level 10';
        skillEnSp.reading = 'Level 10';
        skillEnSp.speaking = 'Level 10';
        skillEnSp.writing = 'Level 10';
        SkillEnSpList.add(skillEnSp);
        
        EnlangSp.skills = SkillEnMainList;
        // Add the ENGLISH of Spouse in it
        clsLangs.add(EnlangSp);
        
        // Spouse French
        AssessmentParseJSON.cls_languages frlangSp = new AssessmentParseJSON.cls_languages();
        frlangSp.applicant_or_spouse = 'Spouse';
        frlangSp.language_name = 'FRENCH';
        frlangSp.speak_this_language = 'Yes';
        frlangSp.main_language = 'false';
        frlangSp.test = 'No';
        // adding skill to it
        List<AssessmentParseJSON.cls_skills> SkillFrSpList = new List<AssessmentParseJSON.cls_skills>();
        AssessmentParseJSON.cls_skills skillfrSp = new AssessmentParseJSON.cls_skills();
        skillfrSp.listening = 'Lower Intermediate (CLB 5)';
        skillfrSp.reading = 'Lower Intermediate (CLB 5)';
        skillfrSp.speaking = 'Lower Intermediate (CLB 5)';
        skillfrSp.writing = 'Lower Intermediate (CLB 5)';
        SkillFrSpList.add(skillfrSp);
        
        frlangSp.skills = SkillFrSpList;
        // Add the FRENCH of Spouse in it
        clsLangs.add(frlangSp);
        
        asp.languages = clsLangs;
        
        // Works
        List<AssessmentParseJSON.cls_works> worksList = new List<AssessmentParseJSON.cls_works>();
        // Work for main applicant
        for(Integer i = 0; i < 3; i++){
            AssessmentParseJSON.cls_works workmain = new AssessmentParseJSON.cls_works();
            workmain.applicant_or_spouse = 'Main Applicant';
            workmain.job_title = 'cloud architect (NOC 2173)';
            workmain.years_of_experience = '3 months or more, but less than 6 months';
            workmain.location = 'In Canada';
            workmain.canadian_experience_province = 'British Columbia (BC)';
            workmain.canadian_experience_start_date = '02/05/2021';
            workmain.canadian_experience_end_date = '02/08/2021';
            workmain.canadian_experience_currently_working = 'No';
            worksList.add(workmain);
        }
        
        // Work for spouse
        for(Integer i = 0; i < 3; i++){
            AssessmentParseJSON.cls_works worksp = new AssessmentParseJSON.cls_works();
            worksp.applicant_or_spouse = 'Spouse';
            worksp.job_title = 'cloud architect (NOC 2173)';
            worksp.years_of_experience = '3 months or more, but less than 6 months';
            worksp.location = 'In Canada';
            worksp.canadian_experience_province = 'British Columbia (BC)';
            worksp.canadian_experience_start_date = '02/05/2021';
            worksp.canadian_experience_end_date = '02/08/2021';
            worksp.canadian_experience_currently_working = 'No';
            worksList.add(worksp);
        }
        asp.works = worksList;
        // education for main applicant
        List<AssessmentParseJSON.cls_educations> educations = new List<AssessmentParseJSON.cls_educations>();
        
        // education for main applicant
        AssessmentParseJSON.cls_educations eduMain = new AssessmentParseJSON.cls_educations();
        eduMain.applicant_or_spouse = 'Main Applicant';
        eduMain.education_level = '2 or more Degrees or Diplomas with at least one being 3+ years';
        eduMain.name_of_credential = 'Cred';
        eduMain.country_of_education = 'Iran, Islamic Republic of';
        eduMain.canadian_education_institution_type = 'Public';
        eduMain.Post_secondaries_in_Canada = 'Yes';
        eduMain.Post_secondary_studies = 'Masters';
        
        educations.add(eduMain);
        
        // education for spouse
        AssessmentParseJSON.cls_educations eduSp = new AssessmentParseJSON.cls_educations();
        eduSp.applicant_or_spouse = 'Spouse';
        eduSp.education_level = '2 or more Degrees or Diplomas with at least one being 3+ years';
        eduSp.name_of_credential = 'Cred';
        eduSp.country_of_education = 'Iran, Islamic Republic of';
        eduSp.canadian_education_institution_type = 'Public';
        eduSp.Post_secondaries_in_Canada = 'Yes';
        eduSp.Post_secondary_studies = 'Masters';
        
        educations.add(eduSp);
        asp.educations = educations;
        
        String aspStr = System.JSON.serializePretty(asp);
        return asp;
    }

}