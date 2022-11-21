public class LeadAssessmentCalculator {
    public static void calcPoints(List<assessment__c> asmtList){
        for(assessment__c asmt : asmtList){
            if(asmt.Type__c == 'Express Entry')
            {
                //if(asmt.Lead__c != null){
            //Pulkit change
                //List<Lead> parentLead = [SELECT Id, DOB__c, Marital_Status__c, Email, Prefered_Language__c FROM Lead WHERE Id = :asmt.Lead__c];
                String maritalStatus = asmt.Marital_Status__c;
                //AGE(FSW + EE)
                Integer age = AssessmentScoreCalculatorUtility.getAge(asmt.DOB_Main_Applicant__c);
                System.debug('Age of Main Applicant : '+ age);
                // 4. AGE POINTS (Six Selection factors:FSW)
                // Age For FSW
                asmt.Age__c = 0;
                asmt.CAge__c = 0;
                Integer ageConst = 35;
                if(age < 18 || age >= 47){
                    asmt.Age__c = 0;
                }
                else if(age >= 18 && age <= 35){
                    asmt.Age__c = 12;
                }
                else{
                    for(Integer i = 11; ageConst < age; --i){
                        ageConst += 1;
                        asmt.Age__c = i;
                    }
                }
                
                // Age for EE with Common-Law Partner/Spouse
                if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                    Map<Integer, Integer> AgeMapWithPartner = new Map<Integer, Integer> {18 => 90, 19 => 95, 30 => 95, 31 => 90, 32 => 85, 33 => 80, 34 => 75, 35 => 70,36 => 65, 37 => 60, 38 => 55, 39 => 50, 40 => 45, 41 => 35, 42 => 25, 43 => 15, 44 => 5};
                        if(age <= 17 || age >= 47){
                            asmt.CAge__c = 0;    
                        }
                    
                    else if(age >= 20 && age <= 29){
                        asmt.CAge__c = 100;
                    }
                    
                    else{
                        if(AgeMapWithPartner.containsKey(age))
                            asmt.CAge__c = AgeMapWithPartner.get(age);
                    }
                    
                } // End of if Age for EE with Common-Law Partner/Spouse
                
                // Age for EE WithOut Spouse/Common-Law Partner
                else{
                    Map<Integer, Integer> AgeMapWithoutPartner = new Map<Integer, Integer> {18 => 99, 19 => 105, 30 => 105, 31 => 99, 32 => 94, 33 => 88, 34 =>83, 35 => 77, 36 =>72, 37 => 66, 38 => 61, 39 => 55, 40 => 50, 41 => 39, 42 => 28, 43 => 17, 44 => 6};
                        if(age <= 17 || age >= 47){
                            asmt.CAge__c = 0;    
                        }    
                    else if(age >= 20 && age <= 29){
                        asmt.CAge__c = 110;
                    }
                    else{
                        if(AgeMapWithoutPartner.containsKey(age))
                            asmt.CAge__c = AgeMapWithoutPartner.get(age);
                    }
                }
                
                System.debug('Age Points FSW : '+asmt.Age__c);
                System.debug('Age Points EE : '+asmt.CAge__c);
                
                // Educational Level (FSW + EE)
                // Calculating Education Level points for FSW
                asmt.Education__c = 0;
                asmt.CLevel_of_education__c = 0;
                asmt.PCLevel_of_education__c = 0;
                Map<String, Integer> edMapFSW = new Map<String, Integer>{'Ph. D.' => 25, 'Masters Degree or Professional Degree' => 23, '2 or more Degrees or Diplomas with at least one being 3+ years' => 22, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' => 21,
                    'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' => 19, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)' => 15, 'High school diploma' => 5,
                    'Below high school diploma' => 0};
                        
                        // 2. EDUCATION POINTS (Six Selection factor:FSW)
                        if(asmt.Level_of_education__c != null){
                            if(edMapFSW.containsKey(asmt.Level_of_education__c))
                                asmt.Education__c = edMapFSW.get(asmt.Level_of_education__c);
                        }                                                            
                else{
                    asmt.Education__c = 0;
                }
                
                // Calculating Education Level for EE With Common-Law Partner/Spouse
                if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                    Map<String, Integer> edMapWithPartnerEE = new Map<String, Integer>{'Ph. D.' => 140, 'Masters Degree or Professional Degree' => 126, '2 or more Degrees or Diplomas with at least one being 3+ years' => 119, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' => 112,
                        'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' => 91, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)' => 84, 'High school diploma' => 28,
                        'Below high school diploma' => 0};
                            if(asmt.Level_of_education__c != null){
                                if(edMapWithPartnerEE.containsKey(asmt.Level_of_education__c))
                                    asmt.CLevel_of_education__c = edMapWithPartnerEE.get(asmt.Level_of_education__c);
                            }
                    else{
                        asmt.CLevel_of_education__c = 0;
                    }
                    
                    // Calculating Education Level points for Spouse
                    Map<String, Integer> edMapSpouseEE = new Map<String, Integer>{'Ph. D.' => 10, 'Masters Degree or Professional Degree' => 10, '2 or more Degrees or Diplomas with at least one being 3+ years' => 9, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' => 8,
                        'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' => 7, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)' => 6, 'High school diploma' => 2,
                        'Below high school diploma' => 0};
                            if(asmt.Level_of_education_Spouse__c != null){
                                if(edMapSpouseEE.containsKey(asmt.Level_of_education_Spouse__c))
                                    asmt.PCLevel_of_education__c = edMapSpouseEE.get(asmt.Level_of_education_Spouse__c);
                            }
                    else{
                        asmt.PCLevel_of_education__c = 0;
                    }
                } //End of Calculating Education Level for EE With Common-Law Partner/Spouse
                
                // Calculating Education Level for EE WithOut Common-Law Partner/Spouse
                else{
                    Map<String, Integer> edMapWithOutPartnerEE = new Map<String, Integer>{'Ph. D.' => 150, 'Masters Degree or Professional Degree' => 135, '2 or more Degrees or Diplomas with at least one being 3+ years' => 128, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' => 120,
                        'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' => 98, 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)' => 90, 'High school diploma' => 30,
                        'Below high school diploma' => 0};
                            if(asmt.Level_of_education__c != null){
                                if(edMapWithOutPartnerEE.containsKey(asmt.Level_of_education__c))
                                    asmt.CLevel_of_education__c = edMapWithOutPartnerEE.get(asmt.Level_of_education__c);
                            }
                    else{
                        asmt.CLevel_of_education__c = 0; 
                    }
                } // End of Education Level
                
                System.debug('Education Points FSW: '+asmt.Education__c);
                System.debug('Education Points EE FOR MAIN APPLICANT: '+asmt.CLevel_of_education__c);
                System.debug('Education Points EE SPOUSE: '+asmt.PCLevel_of_education__c);
                
                // Work Experience
                Integer monthsExperience = 0;
                Integer monthsExperienceCanada = 0;
                Integer monthsExperienceNocOAB = 0;
                Integer monthsExperienceForeign = 0;
                asmt.Experience__c = 0;
                asmt.CCanadian_work_experience__c = 0;
                asmt.PCCanadian_Work_Experience__c = 0; 
                //NOC
                String levelNoc1, levelNoc2, levelNoc3 = '';
                String nocName1, nocName2, nocName3 = '';
                Set<Id> eligibleOccIdSet = new Set<Id>();
                if(asmt.Please_type_a_occupation_1__c != null){
                    eligibleOccIdSet.add(asmt.Please_type_a_occupation_1__c);
                    //levelNoc1 = [SELECT Skill_Level__c FROM Eligible_Occupation__c WHERE Id =: asmt.Please_type_a_occupation_1__c][0].Skill_Level__c;
                }
                if(asmt.Please_type_a_occupation_2__c != null){
                    eligibleOccIdSet.add(asmt.Please_type_a_occupation_2__c);
                    //levelNoc2 = [SELECT Skill_Level__c FROM Eligible_Occupation__c WHERE Id =: asmt.Please_type_a_occupation_2__c][0].Skill_Level__c;
                }
                if(asmt.Please_type_a_occupation_3__c != null){
                    eligibleOccIdSet.add(asmt.Please_type_a_occupation_3__c);
                    //levelNoc3 = [SELECT Skill_Level__c FROM Eligible_Occupation__c WHERE Id =: asmt.Please_type_a_occupation_3__c][0].Skill_Level__c;
                }
                
                Map<Id, Eligible_Occupation__c> mapOfSkillType = new Map<Id, Eligible_Occupation__c>([SELECT Id, Skill_Level__c, Name FROM Eligible_Occupation__c WHERE Id IN :eligibleOccIdSet]);
                if(mapOfSkillType.containsKey(asmt.Please_type_a_occupation_1__c)){
                    levelNoc1 = mapOfSkillType.get(asmt.Please_type_a_occupation_1__c).Skill_Level__c;
                    nocName1 = mapOfSkillType.get(asmt.Please_type_a_occupation_1__c).Name;
                }
                if(mapOfSkillType.containsKey(asmt.Please_type_a_occupation_2__c)){
                    levelNoc2 = mapOfSkillType.get(asmt.Please_type_a_occupation_2__c).Skill_Level__c;
                    nocName2 = mapOfSkillType.get(asmt.Please_type_a_occupation_2__c).Name;
                }
                if(mapOfSkillType.containsKey(asmt.Please_type_a_occupation_3__c)){
                    levelNoc3 = mapOfSkillType.get(asmt.Please_type_a_occupation_3__c).Skill_Level__c;
                    nocName3 = mapOfSkillType.get(asmt.Please_type_a_occupation_3__c).Name;
                }
                
                Map<String, Integer> workMonthsMap = new Map<String, Integer> {'Less than 3 months' => 0, '3 months or more, but less than 6 months' => 3, '6 months or more, but less than 9 months' => 6,
                    '9 months or more, but less than 1 year' => 9, '1 year or more, but less than 2 years' => 12, '2 year or more, but less than 3 years' => 24,
                    '3 year or more, but less than 4 years' => 36, '4 years or more, but less than 5 years' => 48, '5 years or more, but less than 6 years' =>60,
                    '6 years or more' => 72};
                        
                        if(asmt.Location_1__c == 'In Canada'){
                            if(workMonthsMap.containsKey(asmt.Duration_1__c)){
                                monthsExperienceCanada += workMonthsMap.get(asmt.Duration_1__c);
                            }
                        } else {
                            if(workMonthsMap.containsKey(asmt.Duration_1__c))
                                monthsExperienceForeign += workMonthsMap.get(asmt.Duration_1__c);
                        }
                if(levelNoc1 == '0' || levelNoc1 == 'A' || levelNoc1 == 'B'){
                    if(workMonthsMap.containsKey(asmt.Duration_1__c))
                        monthsExperienceNocOAB += workMonthsMap.get(asmt.Duration_1__c);
                }
                
                if(asmt.Location_2__c == 'In Canada'){
                    if(workMonthsMap.containsKey(asmt.Duration_2__c)){
                        monthsExperienceCanada += workMonthsMap.get(asmt.Duration_2__c);
                    }
                } else {
                    if(workMonthsMap.containsKey(asmt.Duration_2__c))
                        monthsExperienceForeign += workMonthsMap.get(asmt.Duration_2__c);
                }
                if(levelNoc2 == '0' || levelNoc2 == 'A' || levelNoc2 == 'B'){
                    if(workMonthsMap.containsKey(asmt.Duration_2__c))
                        monthsExperienceNocOAB += workMonthsMap.get(asmt.Duration_2__c);
                }
                
                if(asmt.Location_3__c == 'In Canada'){
                    if(workMonthsMap.containsKey(asmt.Duration_3__c)){
                        monthsExperienceCanada += workMonthsMap.get(asmt.Duration_3__c);
                    }
                } else {
                    if(workMonthsMap.containsKey(asmt.Duration_3__c))
                        monthsExperienceForeign += workMonthsMap.get(asmt.Duration_3__c);
                }
                if(levelNoc3 == '0' || levelNoc3 == 'A' || levelNoc3 == 'B'){
                    if(workMonthsMap.containsKey(asmt.Duration_3__c))
                        monthsExperienceNocOAB += workMonthsMap.get(asmt.Duration_3__c);
                }
                
                
                if(monthsExperienceNocOAB > 72){
                    monthsExperienceNocOAB = 72;
                }    
                
                monthsExperience = monthsExperienceForeign + monthsExperienceCanada;
                
                monthsExperience = monthsExperience > 72 ? 72 : monthsExperience;
                
                // 3.WORK EXPERIENCE POINTS (Six Selection factors:FSW)
                // Work Experience FSW
                asmt.Experience__c  = monthsExperienceNocOAB >= 0 && monthsExperienceNocOAB <12 ? 0: monthsExperienceNocOAB >=12 && monthsExperienceNocOAB < 24?9: monthsExperienceNocOAB >=24 && monthsExperienceNocOAB < 48?11 : monthsExperienceNocOAB >=48 && monthsExperienceNocOAB < 72?13 : monthsExperienceNocOAB >= 72?15 : 0;
                
                // Work Experience EE
                if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                    asmt.CCanadian_work_experience__c = monthsExperienceCanada >= 0 && monthsExperienceCanada <12 ? 0: monthsExperienceCanada >=12 && monthsExperienceCanada < 24?35: monthsExperienceCanada >=24 && monthsExperienceCanada < 36?46 : monthsExperienceCanada >=36 && monthsExperienceCanada < 48?56 : monthsExperienceCanada >= 48 && monthsExperienceCanada < 60?63 : 70; 
                } else {
                    asmt.CCanadian_work_experience__c = monthsExperienceCanada >= 0 && monthsExperienceCanada <12 ? 0: monthsExperienceCanada >=12 && monthsExperienceCanada < 24?40: monthsExperienceCanada >=24 && monthsExperienceCanada < 36?53 : monthsExperienceCanada >=36 && monthsExperienceCanada < 48?64 : monthsExperienceCanada >= 48 && monthsExperienceCanada < 60?72 : 80;
                }
                
                // Work Experience Spouse EE
                Integer monthsExperienceCanadaSpouse =0,monthsExperienceCanadaSpouseAdap = 0;
                String spouseLevelNoc1, spouseLevelNoc2, spouseLevelNoc3 = '';
          		String spouseNocName1, spouseNocName2, spouseNocName3 = '';
            	Set<Id> eligibleOccSpouseIdSet = new Set<Id>();
                
                if(asmt.Please_type_a_occupation_1_Spouse__c != null)
                {
                    eligibleOccSpouseIdSet.add(asmt.Please_type_a_occupation_1_Spouse__c);
                }
                
                if(asmt.Please_type_a_occupation_2_Spouse__c != null)
                {
                    eligibleOccSpouseIdSet.add(asmt.Please_type_a_occupation_2_Spouse__c);
                }
                
                if(asmt.Please_type_a_occupation_3_Spouse__c != null)
                {
                    eligibleOccSpouseIdSet.add(asmt.Please_type_a_occupation_3_Spouse__c);
                }
                
                Map<Id, Eligible_Occupation__c> mapOfSpouseSkillType = new Map<Id, Eligible_Occupation__c>([SELECT Id, Skill_Level__c, Name FROM Eligible_Occupation__c WHERE Id IN :eligibleOccSpouseIdSet]);
                if(mapOfSpouseSkillType.containsKey(asmt.Please_type_a_occupation_1_Spouse__c))
                {
                    spouseLevelNoc1 = mapOfSpouseSkillType.get(asmt.Please_type_a_occupation_1_Spouse__c).Skill_Level__c;
                    spouseNocName1 = mapOfSpouseSkillType.get(asmt.Please_type_a_occupation_1_Spouse__c).Name;
                }
                if(mapOfSpouseSkillType.containsKey(asmt.Please_type_a_occupation_2_Spouse__c))
                {
                    spouseLevelNoc2 = mapOfSpouseSkillType.get(asmt.Please_type_a_occupation_2_Spouse__c).Skill_Level__c;
                    spouseNocName2 = mapOfSpouseSkillType.get(asmt.Please_type_a_occupation_2_Spouse__c).Name;
                }
                if(mapOfSpouseSkillType.containsKey(asmt.Please_type_a_occupation_3_Spouse__c))
                {
                    spouseLevelNoc3 = mapOfSpouseSkillType.get(asmt.Please_type_a_occupation_3_Spouse__c).Skill_Level__c;
                    spouseNocName3 = mapOfSpouseSkillType.get(asmt.Please_type_a_occupation_3_Spouse__c).Name;
                }
                
                if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                    if(asmt.Location_1_Spouse__c == 'In Canada'){
                        if(workMonthsMap.containsKey(asmt.Duration_1_Spouse__c))
                        {
                            monthsExperienceCanadaSpouseAdap += workMonthsMap.get(asmt.Duration_1_Spouse__c);
                            if(spouseLevelNoc1 == '0' || spouseLevelNoc1 == 'A' || spouseLevelNoc1 == 'B')
                            	monthsExperienceCanadaSpouse += workMonthsMap.get(asmt.Duration_1_Spouse__c);
                        }
                    }
                    
                    if(asmt.Location_2_Spouse__c == 'In Canada'){
                        if(workMonthsMap.containsKey(asmt.Duration_2_Spouse__c))
                        {
                            monthsExperienceCanadaSpouseAdap += workMonthsMap.get(asmt.Duration_2_Spouse__c);
                            if(spouseLevelNoc2 == '0' || spouseLevelNoc2 == 'A' || spouseLevelNoc2 == 'B')
                            	monthsExperienceCanadaSpouse += workMonthsMap.get(asmt.Duration_2_Spouse__c);
                        }
                    }
                    
                    if(asmt.Location_3_Spouse__c == 'In Canada'){
                        if(workMonthsMap.containsKey(asmt.Duration_3_Spouse__c))
                        {
                            monthsExperienceCanadaSpouseAdap += workMonthsMap.get(asmt.Duration_3_Spouse__c);
                            if (spouseLevelNoc3 == '0' || spouseLevelNoc3 == 'A' || spouseLevelNoc3 == 'B')
                            	monthsExperienceCanadaSpouse += workMonthsMap.get(asmt.Duration_3_Spouse__c);
                        }
                    }
                    
                    if(monthsExperienceCanadaSpouse > 72){
                        monthsExperienceCanadaSpouse = 72;
                    }
                    
                    asmt.PCCanadian_Work_Experience__c = monthsExperienceCanadaSpouse < 12 ? 0 : monthsExperienceCanadaSpouse >= 12 && monthsExperienceCanadaSpouse <24 ? 5 : monthsExperienceCanadaSpouse >=24 && monthsExperienceCanadaSpouse < 36 ? 7 : monthsExperienceCanadaSpouse >=36 && monthsExperienceCanadaSpouse < 48 ? 8 : monthsExperienceCanadaSpouse >= 48 && monthsExperienceCanadaSpouse < 60 ? 9 : monthsExperienceCanadaSpouse >=60 ? 10 : 0;
                    
                } // End of Work Experience Spouse EE
                
                System.debug('WorkEx Points FSW: '+asmt.Experience__c);
                System.debug('WorkEx Points EE MAIN APPLICANT : '+asmt.CCanadian_work_experience__c);
                System.debug('WorkEx Points EE SPOUSE: '+asmt.PCCanadian_Work_Experience__c);
                
                // Language English (FSW + EE)
                asmt.First_Language__c = 0;
                asmt.Second_Language__c = 0;
                asmt.COfficial_languages_proficiency__c = 0;
                asmt.Second_Language_EE__c  = 0;
                asmt.PCOfficial_language_proficiency__c = 0;
                // English Main Applicant
                // Variables to store CLBs values English
                Integer enListeningCLB = 0;
                Integer enReadingCLB = 0; 
                Integer enWritingCLB = 0; 
                Integer enSpeakingCLB = 0;
                // Variable to store overall english CLB level
                Integer overallEnCLB = 0;
                // Variables to hold CLB values of first language
                Integer firstLangListenCLB = 0;
                Integer firstLangReadCLB = 0;
                Integer firstLangWriteCLB = 0;
                Integer firstLangSpeakCLB = 0;
                
                if(asmt.Do_you_speak_English__c == 'Yes'){
                    enReadingCLB = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Reading', asmt.English_reading__c);
                    enWritingCLB = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Writing', asmt.English_Writing__c);
                    enListeningCLB = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Listening', asmt.English_Listening__c);
                    enSpeakingCLB = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Speaking', asmt.English_speaking__c);
                    
                    // Calculating overall english clb level
                    
                    if(asmt.English_test_type__c != null){
                        overallEnCLB = enListeningCLB;
                        
                        if(enReadingCLB < overallEnCLB){
                            overallEnCLB = enReadingCLB;
                        }
                        if(enWritingCLB < overallEnCLB){
                            overallEnCLB = enWritingCLB;
                        }
                        if(enSpeakingCLB < overallEnCLB){
                            overallEnCLB = enSpeakingCLB;
                        }
                    }
                    
                    // 1.LANGUAGE SKILLS POINTS (Six Selection factor:FSW)
                    // English FSW Main Applicant 
                    // IF English is first language
                    if(!asmt.French_first_language__c){
                        // Assigning firstLanguage CLB to its variables (If english is first language)
                        firstLangListenCLB = enListeningCLB;
                        firstLangReadCLB = enReadingCLB;
                        firstLangWriteCLB = enWritingCLB;
                        firstLangSpeakCLB = enSpeakingCLB;
                        if(overallEnCLB >= 7){
                            asmt.First_Language__c = AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enReadingCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enWritingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enListeningCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enSpeakingCLB);
                        }
                        
                        // English EE Main Applicant with Common-Law Partner/Spouse
                        if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                            asmt.COfficial_languages_proficiency__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enReadingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enWritingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enListeningCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enSpeakingCLB);
                        }
                        // English EE Main Applicant withOut Common-Law Partner/Spouse
                        else{
                            asmt.COfficial_languages_proficiency__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enReadingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enWritingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enListeningCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enSpeakingCLB);
                        }
                        
                    }
                    // IF English is Second language
                    else{
                        if(overallEnCLB >= 5){
                            asmt.Second_Language__c = AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enReadingCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enWritingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enListeningCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(!asmt.French_first_language__c, enSpeakingCLB);
                        }
                        
                        // English EE Main Applicant with Common-Law Partner/Spouse
                        if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                            asmt.Second_Language_EE__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enReadingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enWritingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enListeningCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, true, enSpeakingCLB);
                        }
                        // English EE Main Applicant withOut Common-Law Partner/Spouse
                        else{
                            asmt.Second_Language_EE__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enReadingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enWritingCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enListeningCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(!asmt.French_first_language__c, false, enSpeakingCLB);
                        }
                    }
                    
                }
                
                //English (EE) For Spouse
                
                // Map of first language points for Spouse
                Map<Double, Integer> enPointsSpouse = new Map<Double, Integer>{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 1, 6 => 1, 7 => 3,
                    8 => 3, 9 => 5, 10 => 5};
                        // Variables to store CLBs values English
                        Integer enListeningCLBSpouse, enReadingCLBSpouse, enWritingCLBSpouse, enSpeakingCLBSpouse = 0;
                
                //If English is the first language of spouse
                if(!asmt.French_first_language_Spouse__c){
                    if(asmt.Do_you_speak_English_Spouse__c == 'Yes' && (maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                        enReadingCLBSpouse = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type_Spouse__c, 'Reading', asmt.English_reading_Spouse__c);
                        enWritingCLBSpouse = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type_Spouse__c, 'Writing', asmt.English_Writing_Spouse__c);
                        enListeningCLBSpouse = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type_Spouse__c, 'Listening', asmt.English_Listening_Spouse__c);
                        enSpeakingCLBSpouse = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type_Spouse__c, 'Speaking', asmt.English_speaking_Spouse__c);
                        
                        
                        // Spouse points English (EE)
                        asmt.PCOfficial_language_proficiency__c = AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(enReadingCLBSpouse) + AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(enWritingCLBSpouse)
                            + AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(enListeningCLBSpouse) + AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(enSpeakingCLBSpouse);
                    } 
                }
                
                
                // Language French (EE + FSW)
                
                // Variable to store CLB level of French Main Applicant
                Integer frReadCLB = 0;
                Integer frWriteCLB =0;
                Integer frListenCLB = 0;
                Integer frSpeakCLB = 0;
                
                if(asmt.Do_you_speak_French__c == 'Yes'){
                    frReadCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Reading', asmt.French_reading__c);
                    frWriteCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Writing', asmt.French_Writing__c);
                    frListenCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Listening', asmt.French_Listening__c);
                    frSpeakCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Speaking', asmt.French_speaking__c);
                    // IF french is second Language
                    if(!asmt.French_first_language__c){
                        // French points FSW Main Applicant
                        if(frReadCLB >= 5 && frWriteCLB >= 5 && frListenCLB >= 5 && frSpeakCLB >= 5){
                            asmt.Second_Language__c = AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frReadCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frWriteCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frListenCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frSpeakCLB);
                            
                        }
                        
                        // French points EE Main Applicant
                        if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                            asmt.Second_Language_EE__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frReadCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frWriteCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frListenCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frSpeakCLB);  
                        }
                        else{
                            asmt.Second_Language_EE__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frReadCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frWriteCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frListenCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frSpeakCLB);
                        }
                    } 
                    // IF French is first language
                    else{
                        // Assigning firstLanguage CLB to its variables (If english is first language)
                        firstLangListenCLB = frListenCLB;
                        firstLangReadCLB = frReadCLB;
                        firstLangWriteCLB = frWriteCLB;
                        firstLangSpeakCLB = frSpeakCLB;
                        // French points FSW Main Applicant
                        if(frReadCLB >= 7 && frWriteCLB >= 7 && frListenCLB >= 7 && frSpeakCLB >= 7){
                            asmt.First_Language__c = AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frReadCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frWriteCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frListenCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsFSW(asmt.French_first_language__c, frSpeakCLB);
                            
                        }
                        
                        // French points EE Main Applicant
                        if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                            asmt.COfficial_languages_proficiency__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frReadCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frWriteCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frListenCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, true, frSpeakCLB);  
                        }
                        else{
                            asmt.COfficial_languages_proficiency__c = AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frReadCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frWriteCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frListenCLB) +
                                AssessmentScoreCalculatorUtility.getLanguagePointsEE(asmt.French_first_language__c, false, frSpeakCLB);
                        }
                    }
                    
                }
                
                // check if Spouse has more points in French than English
                // Variable to store CLB level of French Main Applicant
                Integer frReadSPCLB = 0; 
                Integer frWriteSPCLB = 0;
                Integer frListenSPCLB = 0;
                Integer frSpeakSPCLB = 0;
                Integer frenchPointsSpouse = 0;
                // IF french is first language of Spouse
                if(asmt.French_first_language_Spouse__c){
                    if(asmt.Do_you_speak_French_Spouse__c == 'Yes' && (maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                        frReadSPCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF_Spouse__c, 'Reading', asmt.French_reading_Spouse__c);
                        frWriteSPCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF_Spouse__c, 'Writing', asmt.French_Writing_Spouse__c);
                        frListenSPCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF_Spouse__c, 'Speaking', asmt.French_Listening_Spouse__c);
                        frSpeakSPCLB = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF_Spouse__c, 'Listening', asmt.French_speaking_Spouse__c);
                        
                        asmt.PCOfficial_language_proficiency__c = AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(frReadSPCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(frWriteSPCLB)
                            + AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(frListenSPCLB) + AssessmentScoreCalculatorUtility.getLanguagePointsSpouse(frSpeakSPCLB);
                        
                    }
                    
                }
                
                System.debug('First Language Points FSW: '+ asmt.First_Language__c);
                System.debug('Second Language Points FSW: '+ asmt.Second_Language__c);
                System.debug('First Language Points EE MAIN APPLICANT: '+ asmt.COfficial_languages_proficiency__c);
                System.debug('Second Language Points EE MAIN APPLICANT: '+ asmt.Second_Language_EE__c);
                System.debug('Offical Language Points SPOUSE: '+asmt.PCOfficial_language_proficiency__c);
                
                
                // 6.ADAPTABILITY (Six selection factors:FSW)
                asmt.Adaptability__c = 0;
                String debugInfo = 'ADAPTABILITY Section \n';
                if((maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                    // Your spouse or partner’s language level
                    if((enListeningCLBSpouse >= 4 && enReadingCLBSpouse >= 4 && enWritingCLBSpouse >= 4 && enSpeakingCLBSpouse >= 4) ||
                       (frReadSPCLB >= 4 && frWriteSPCLB >=4 && frListenSPCLB >= 4 && frSpeakSPCLB >=4)){
                           asmt.Adaptability__c += 5;
                           debugInfo += 'Your spouse or partner’s language level +5 \n';
                       }
                    
                    // Your spouse or partner’s past studies in Canada
                    if(asmt.Post_secondaries_in_canada_Spouse__c == 'Yes' && (asmt.Post_secondary_studies_Spouse__c == '2 years' || asmt.Post_secondary_studies_Spouse__c == '3 years or more' ||
                                                                              asmt.Post_secondary_studies_Spouse__c == 'Masters' || asmt.Post_secondary_studies_Spouse__c == 'Ph.D.' ) ){
                                                                                  
                                                                                  asmt.Adaptability__c += 5;
                                                                                  debugInfo += 'Your spouse or partner’s past studies in Canada +5 \n';                                                       
                                                                              }
                }
                //Your past studies in Canada
                if(asmt.Post_secondaries_in_canada__c == 'Yes' && (asmt.Post_secondary_studies__c == '2 years' || asmt.Post_secondary_studies__c == '3 years or more' ||
                                                                   asmt.Post_secondary_studies__c == 'Masters' || asmt.Post_secondary_studies__c == 'Ph.D.' )){
                                                                       asmt.Adaptability__c += 5;
                                                                       debugInfo += 'Your past studies in Canada +5 \n';                                                  
                                                                   }
                
                
                // In this code block the field - 'asmt.Years_working_in_canada__c' was removed on request of marcius but its used in calculation
                // Your past work in Canada
                if(asmt.have_been_canada_as_temp_worker__c == 'Yes' &&
                   (asmt.NOC_received__c == '00' || asmt.NOC_received__c == '0,A,B') && asmt.Have_you_received_an_LMIA__c == 'Yes'){
                       asmt.Adaptability__c += 10;
                       debugInfo += 'Your past work in Canada +10 \n';
                   }
                
                // Arranged employment in Canada
                if(asmt.Have_you_received_an_LMIA__c == 'Yes' &&
                   (asmt.NOC_received__c == '00' || asmt.NOC_received__c == '0,A,B')){
                       asmt.Adaptability__c += 5;
                       debugInfo += 'Arranged employment in Canada +5 \n';
                   }
                
                // Relatives in Canada
                if(asmt.Relatives_In_Canada_List__c != null && asmt.Relatives_In_Canada_List__c != 'No relatives' && asmt.Relatives_In_Canada_List__c != ''){
                    asmt.Adaptability__c += 5;
                    debugInfo += 'Relatives in Canada +5 \n';
                }
                
                // Your spouse or common-law partner’s past work in Canada
                //Your spouse or partner did at least 1 year of full-time work in Canada on a valid work permit or while authorized to work in Canada.
                if(monthsExperienceCanadaSpouseAdap >= 12){
                    asmt.Adaptability__c += 5;
                    debugInfo += 'Your spouse or common-law partner’s past work in Canada +5 \n';
                }
                debugInfo += 'Total ADAPTABILITY POINTS BEFORE LIMIT: '+asmt.Adaptability__c +'\n';
                if(asmt.Adaptability__c > 10){
                    asmt.Adaptability__c = 10;
                }
                debugInfo += 'Total ADAPTABILITY POINTS AFTER LIMIT: '+asmt.Adaptability__c+'\n END OF ADAPTABILITY\n';
                System.debug('Adaptability: '+debugInfo);
                
                // 5. ARRANGED EMPLOYMENT IN CANADA POINTS (Six Selection factors:FSW)
                //Employment Job Offer
                asmt.Employment_job_offer__c = 0;
                // In this code block the field - 'asmt.Years_working_in_canada__c' was removed on request of marcius but its used in calculation
                if(asmt.Have_you_received_an_LMIA__c == 'Yes' &&
                   (asmt.NOC_received__c == '00' || asmt.NOC_received__c == '0,A,B')){
                       asmt.Employment_job_offer__c += 10;
                   }
                
                System.debug('ARRANGED EMPLOYMENT IN CANADA POINTS (Six Selection factors:FSW) : '+asmt.Employment_job_offer__c);
                // Skill Transferability combos (EE)
                asmt.Education_and_language__c = 0;
                asmt.Education_and_Canadian_work__c = 0;
                asmt.Foreign_work_and_language__c = 0;
                asmt.Foreign_work_and_Canadian_work__c = 0;
                // Education : Skill Transferability combos (EE)
                if(firstLangListenCLB >= 9 && firstLangReadCLB >= 9 && firstLangWriteCLB >= 9 && firstLangSpeakCLB >= 9){
                    if(asmt.Level_of_education__c != null){
                        if(asmt.Level_of_education__c == 'Ph. D.' || asmt.Level_of_education__c == 'Masters Degree or Professional Degree' || asmt.Level_of_education__c == '2 or more Degrees or Diplomas with at least one being 3+ years'){
                            asmt.Education_and_language__c = 50;
                        }
                        else if(asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)'){
                            asmt.Education_and_language__c = 25;
                        }
                    }
                }
                else if(firstLangListenCLB >= 7 && firstLangReadCLB >= 7 && firstLangWriteCLB >= 7 && firstLangSpeakCLB >= 7){
                    if(asmt.Level_of_education__c != null){
                        if(asmt.Level_of_education__c == 'Ph. D.' || asmt.Level_of_education__c == 'Masters Degree or Professional Degree' || asmt.Level_of_education__c == '2 or more Degrees or Diplomas with at least one being 3+ years'){
                            asmt.Education_and_language__c = 25;
                        }
                        else if(asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)'){
                            asmt.Education_and_language__c = 13;
                        }
                    }
                }
                
                // With Canadian work experience and a post-secondary degree : Skill Transferability combos (EE)
                if(monthsExperienceCanada >= 12 && monthsExperienceCanada < 24){
                    if(asmt.Level_of_education__c != null){
                        if(asmt.Level_of_education__c == 'Ph. D.' || asmt.Level_of_education__c == 'Masters Degree or Professional Degree' || asmt.Level_of_education__c == '2 or more Degrees or Diplomas with at least one being 3+ years'){
                            asmt.Education_and_Canadian_work__c = 25;
                        }
                        else if(asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)'){
                            asmt.Education_and_Canadian_work__c = 13;
                        }
                    }
                }
                else if(monthsExperienceCanada >= 24){
                    if(asmt.Level_of_education__c != null){
                        if(asmt.Level_of_education__c == 'Ph. D.' || asmt.Level_of_education__c == 'Masters Degree or Professional Degree' || asmt.Level_of_education__c == '2 or more Degrees or Diplomas with at least one being 3+ years'){
                            asmt.Education_and_Canadian_work__c = 50;
                        }
                        else if(asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (3 years or more)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (2 years)' || asmt.Level_of_education__c == 'Bachelor, Diploma, Trade certificate, or Apprenticeship (1 year)'){
                            asmt.Education_and_Canadian_work__c = 25;
                        }
                    }
                }
                
                // Foreign work experience – With good official language proficiency : Skill Transferability combos (EE)
                if(firstLangListenCLB >= 9 && firstLangReadCLB >= 9 && firstLangWriteCLB >= 9 && firstLangSpeakCLB >= 9){
                    if(monthsExperienceForeign >= 36){
                        asmt.Foreign_work_and_language__c = 50;
                    }
                    else if (monthsExperienceForeign >= 12 && monthsExperienceForeign < 36){
                        asmt.Foreign_work_and_language__c = 25;
                    }
                }
                else if(firstLangListenCLB >= 7 && firstLangReadCLB >= 7 && firstLangWriteCLB >= 7 && firstLangSpeakCLB >= 7){
                    if(monthsExperienceForeign >= 36){
                        asmt.Foreign_work_and_language__c = 25;
                    }
                    else if (monthsExperienceForeign >= 12 && monthsExperienceForeign < 36){
                        asmt.Foreign_work_and_language__c = 13;
                    }
                }
                
                // Foreign work experience – With Canadian work experience : Skill Transferability combos (EE)
                if(monthsExperienceCanada >= 12 && monthsExperienceCanada < 24){
                    if(monthsExperienceForeign >= 36){
                        asmt.Foreign_work_and_Canadian_work__c = 25;
                    }
                    else if (monthsExperienceForeign >= 12 && monthsExperienceForeign < 36){
                        asmt.Foreign_work_and_Canadian_work__c = 13;
                    }
                }
                else if(monthsExperienceCanada >= 24){
                    if(monthsExperienceForeign >= 36){
                        asmt.Foreign_work_and_Canadian_work__c = 50;
                    }
                    else if (monthsExperienceForeign >= 12 && monthsExperienceForeign < 36){
                        asmt.Foreign_work_and_Canadian_work__c = 25;
                    }
                }
                
                // Certificate of qualification (trade occupations) – With good official language proficiency (Canadian Language Benchmark Level [CLB] 5 or higher)
                // Right now Storing points in a pointsCertOfQualification variable 
                asmt.Certificate_of_qualification_points__c = 0;
                //Integer pointsCertOfQualification = 0;
                if(asmt.Certificate_of_Qualification_from_Canada__c == 'Yes'){
                    if(firstLangListenCLB >= 7 && firstLangReadCLB >= 7 && firstLangWriteCLB >= 7 && firstLangSpeakCLB >= 7){
                        //pointsCertOfQualification = 50;
                        asmt.Certificate_of_qualification_points__c = 50;
                    }
                    else if(firstLangListenCLB >= 5 && firstLangReadCLB >= 5 && firstLangWriteCLB >= 5 && firstLangSpeakCLB >= 5){
                        //pointsCertOfQualification = 25;
                        asmt.Certificate_of_qualification_points__c = 25;
                    }
                }
                
                // Additional points (Maximum 600 points) EE
                asmt.Siblings_in_Canada__c = 0;
                asmt.French_Additional_Points__c = 0;
                asmt.Post_secondary_education_in_Canada__c = 0;
                asmt.Arranged_employment__c = 0;
                Decimal totalAdditionalPointsEE = 0;
                // Brother or sister living in Canada who is a citizen or permanent resident of Canada
                if(asmt.Relatives_In_Canada_List__c == 'Sister or Brother'){
                    asmt.Siblings_in_Canada__c = 15;
                }
                
                // Scored NCLC 7 or higher on all four French language skills and scored CLB 5 or higher on all four English skills
                if(frReadCLB >= 7 && frWriteCLB >=7 && frListenCLB >= 7 && frSpeakCLB >= 7){
                    if(enListeningCLB >= 5 && enReadingCLB >=5 && enWritingCLB >= 5 && enSpeakingCLB >= 5){
                        asmt.French_Additional_Points__c = 50;
                    }
                    // Scored NCLC 7 or higher on all four French language skills and scored CLB 4 or lower in English (or didn’t take an English test)
                    else{
                        asmt.French_Additional_Points__c = 25;
                    }
                }
                
                // Post-secondary education in Canada
                if(asmt.Post_secondaries_in_canada__c == 'Yes'){
                    if((asmt.Post_secondary_studies__c == '1 year' || asmt.Post_secondary_studies__c == '2 years') && asmt.Type_of_educational_institute__c == 'Public'){
                        asmt.Post_secondary_education_in_Canada__c = 15;
                    }
                    else if(asmt.Post_secondary_studies__c == '3 years or more' || asmt.Post_secondary_studies__c == 'Masters'
                            || asmt.Post_secondary_studies__c == 'Ph.D.'){
                                asmt.Post_secondary_education_in_Canada__c = 30;
                            }
                }
                
                // Arranged employment (EE)
                if(asmt.Have_you_received_an_LMIA__c == 'Yes'){
                    if(asmt.NOC_received__c == '00'){
                        asmt.Arranged_employment__c = 200;
                    }
                    else if(asmt.NOC_received__c == '0,A,B'){
                        asmt.Arranged_employment__c = 50;
                    }
                }
                
                // Provincial or territorial nomination 
                asmt.Provincial_or_territorial_nomination__c = 0;
                //Integer nominationPoints = 0;
                if(asmt.Have_Province_Nomination_except_Quebec__c == 'Yes'){
                    asmt.Provincial_or_territorial_nomination__c = 600;
                    //nominationPoints = 600;
                }
                
                // Total Additional points EE
                totalAdditionalPointsEE = asmt.Siblings_in_Canada__c + asmt.French_Additional_Points__c + asmt.Post_secondary_education_in_Canada__c
                    + asmt.Arranged_employment__c + asmt.Provincial_or_territorial_nomination__c;
                
                // Set limits to EE
                // A. Core Human Capital
                Decimal coreHumanCapital = 0;
                coreHumanCapital = asmt.CAge__c + asmt.CLevel_of_education__c + asmt.COfficial_languages_proficiency__c + asmt.Second_Language_EE__c
                    + asmt.CCanadian_work_experience__c;
                if(coreHumanCapital > 460 && (maritalStatus == 'Married' || maritalStatus == 'Common-law')){
                    coreHumanCapital = 460;
                }
                else if(coreHumanCapital > 500 && (maritalStatus != 'Married' && maritalStatus != 'Common-law')){
                    coreHumanCapital = 500;
                }
                
                // B. Spouse or common-law partner factors
                Decimal coreHumanCapitalSpouse = 0;
                coreHumanCapitalSpouse = asmt.PCLevel_of_education__c + asmt.PCOfficial_language_proficiency__c + asmt.PCCanadian_Work_Experience__c;
                
                if(coreHumanCapitalSpouse > 40){
                    coreHumanCapitalSpouse = 40;
                }
                
                // C. Skill transferability factors (Maximum 100 points for this section)
                Decimal skillTransferPointsTotalCombo = 0;
                Decimal skillTransferPointsCombo1 = 0;
                Decimal skillTransferPointsCombo2 = 0;
                
                skillTransferPointsCombo1 = asmt.Education_and_language__c + asmt.Education_and_Canadian_work__c;
                if(skillTransferPointsCombo1 > 50){
                    skillTransferPointsCombo1 = 50;
                }
                
                skillTransferPointsCombo2 = asmt.Foreign_work_and_language__c + asmt.Foreign_work_and_Canadian_work__c;
                if(skillTransferPointsCombo2 > 50){
                    skillTransferPointsCombo2 = 50;
                }
                
                skillTransferPointsTotalCombo = skillTransferPointsCombo1 + skillTransferPointsCombo2 + asmt.Certificate_of_qualification_points__c;
                if(skillTransferPointsTotalCombo > 100){
                    skillTransferPointsTotalCombo = 100;
                }
                
                // D. Additional Points
                if(totalAdditionalPointsEE > 600){
                    totalAdditionalPointsEE = 600;
                }
                
                // Total Points FSW
                asmt.Total__c = asmt.Age__c + asmt.Education__c + asmt.Experience__c + asmt.First_Language__c + asmt.Second_Language__c + asmt.Employment_job_offer__c
                    + asmt.Adaptability__c;
                // Total Points EE
                asmt.Total_EE__c = coreHumanCapital + coreHumanCapitalSpouse + skillTransferPointsTotalCombo + totalAdditionalPointsEE;
                
                // Check if the applicant is elegible to CEC Canadian Experience Class
                Integer monthsExperienceCanadaNoc0 = 0;
                Integer monthsExperienceCanadaNocA = 0;
                Integer monthsExperienceCanadaNocB = 0;
                
                if(asmt.Location_1__c == 'In Canada'){
                    if(levelNoc1 == '0'){
                        if(workMonthsMap.containsKey(asmt.Duration_1__c)) 
                            monthsExperienceCanadaNoc0 += workMonthsMap.get(asmt.Duration_1__c);
                    } else if(levelNoc1 == 'A'){
                        if(workMonthsMap.containsKey(asmt.Duration_1__c)) 
                            monthsExperienceCanadaNocA += workMonthsMap.get(asmt.Duration_1__c);
                    } else if(levelNoc1 == 'B'){
                        if(workMonthsMap.containsKey(asmt.Duration_1__c)) 
                            monthsExperienceCanadaNocB += workMonthsMap.get(asmt.Duration_1__c);
                    }
                }
                
                if(asmt.Location_2__c == 'In Canada'){
                    if(levelNoc2 == '0'){
                        if(workMonthsMap.containsKey(asmt.Duration_2__c)) 
                            monthsExperienceCanadaNoc0 += workMonthsMap.get(asmt.Duration_2__c);
                    } else if(levelNoc2 == 'A'){
                        if(workMonthsMap.containsKey(asmt.Duration_2__c))
                            monthsExperienceCanadaNocA += workMonthsMap.get(asmt.Duration_2__c);
                    } else if(levelNoc2 == 'B'){
                        if(workMonthsMap.containsKey(asmt.Duration_2__c))
                            monthsExperienceCanadaNocB += workMonthsMap.get(asmt.Duration_2__c);
                    }
                }
                
                if(asmt.Location_3__c == 'In Canada'){
                    if(levelNoc3 == '0'){
                        if(workMonthsMap.containsKey(asmt.Duration_3__c)) 
                            monthsExperienceCanadaNoc0 += workMonthsMap.get(asmt.Duration_3__c);
                    } else if(levelNoc3 == 'A'){
                        if(workMonthsMap.containsKey(asmt.Duration_3__c))
                            monthsExperienceCanadaNocA += workMonthsMap.get(asmt.Duration_3__c);
                    } else if(levelNoc3 == 'B'){
                        if(workMonthsMap.containsKey(asmt.Duration_3__c))
                            monthsExperienceCanadaNocB += workMonthsMap.get(asmt.Duration_3__c);
                    }
                }
                
                // CEC 
                asmt.CEC_Result__c = 'NOT QUALIFIED';
                if(monthsExperienceCanadaNoc0 >= 12 || monthsExperienceCanadaNocA >= 12
                   &&(firstLangListenCLB >= 7 && firstLangReadCLB >= 7 && firstLangWriteCLB >= 7 && firstLangSpeakCLB >= 7)
                   && asmt.Preferred_destination_in_canada__c != 'Quebec (QC)'){
                       asmt.CEC_Result__c = 'QUALIFIED';
                   }
                
                if(monthsExperienceCanadaNocB >= 12 
                   &&(firstLangListenCLB >= 5 && firstLangReadCLB >= 5 && firstLangWriteCLB >= 5 && firstLangSpeakCLB >= 5)
                   && asmt.Preferred_destination_in_canada__c != 'Quebec (QC)'){
                       asmt.CEC_Result__c = 'QUALIFIED';
                   }
                
                // Federal Skilled Trade worker (FSTW)
                asmt.FSTW_Result__c = 'NOT QUALIFIED';
                Integer monthsExpFSTW = 0;
                
                if(asmt.experience_obtained_in_past_5_years_1__c || asmt.experience_obtained_in_past_5_years_2__c || asmt.experience_obtained_in_past_5_years_3__c){
                    if(isFSTWNoc(nocName1)){
                        if(workMonthsMap.containsKey(asmt.Duration_1__c)){
                            monthsExpFSTW += workMonthsMap.get(asmt.Duration_1__c);
                        }
                    }
                    
                    if(isFSTWNoc(nocName2)){
                        if(workMonthsMap.containsKey(asmt.Duration_2__c)){
                            monthsExpFSTW += workMonthsMap.get(asmt.Duration_2__c);
                        }                    
                    }
                    
                    if(isFSTWNoc(nocName3)){
                        if(workMonthsMap.containsKey(asmt.Duration_3__c)){
                            monthsExpFSTW += workMonthsMap.get(asmt.Duration_3__c);
                        }
                    }
                    
                }
                
                if(monthsExpFSTW >= 24 && (asmt.Certificate_of_Qualification_from_Canada__c == 'Yes' || asmt.Have_you_received_an_LMIA__c == 'Yes')
                   && firstLangListenCLB >= 5 && firstLangSpeakCLB >= 5 && firstLangReadCLB >=4 && firstLangWriteCLB >= 4){
                       asmt.FSTW_Result__c = 'QUALIFIED';
                   }
            }
            else if(asmt.Type__c == 'BCPNP')
            {
                List<assessment__c> tempList = new List<assessment__c>{asmt};
                BCPNPScoreCalculator.calcPoints(tempList);
            }
            else if(asmt.Type__c == 'OINP')
            {
                List<assessment__c> tempList = new List<assessment__c>{asmt};
                OINPScoreCalculator.calcPoints(tempList);
            }
            // Sending Email to Candidates (lead email)
            if(asmt.IsCreatedFromRestApi__c)
            {
                sendEmail(asmt);    
            }
            
            //} // end of if asmt.Lead__c != null
            
        } // End of for loop
    } // End of calcPoints method
    
    public static void sendEmail(assessment__c asmt){
        //Pulkit Change
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        if(asmt.Lead__c != null)
        {
            message.setTargetObjectId(asmt.Lead__c);
        }
        else
        {
            message.setWhatId(asmt.Account__c); 
        }
        //Lead ld = ldList.get(0);
        //message.setTargetObjectId(ld.id); 
        message.toAddresses = new String[]{asmt.E_mail_Main_Applicant__c};
            message.setUseSignature(false); 
        message.setBccSender(false);
        //message.toAddresses = new String[] { ld.Email};
        
        List<EmailTemplate> emailTemplates = new List<EmailTemplate>();
        // for English & Other Language
        if(asmt.Type__c == 'Express Entry')
        {
            if(asmt.Preferred_language__c != 'Portuguese'){
                if((asmt.Total__c >= 67 && asmt.Total_EE__c >= 450) || asmt.CEC_Result__c == 'QUALIFIED' || (asmt.FSTW_Result__c == 'QUALIFIED' && asmt.Total_EE__c >= 350)){
                    emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Strong candidate assessment English'];
                }
                else if((asmt.Total__c >= 67 && asmt.Total_EE__c < 450) || (asmt.FSTW_Result__c == 'QUALIFIED' && asmt.Total_EE__c < 350)){
                    emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Eligible has the points but low points English'];
                }
                else if(asmt.Total__c < 67 && asmt.CEC_Result__c == 'NOT QUALIFIED' && asmt.FSTW_Result__c == 'NOT QUALIFIED'){
                    emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Do not qualify English'];
                }
            }
            // For Portgues
            else{
                if((asmt.Total__c >= 67 && asmt.Total_EE__c >= 450) || asmt.CEC_Result__c == 'QUALIFIED' || (asmt.FSTW_Result__c == 'QUALIFIED' && asmt.Total_EE__c >= 350)){
                    emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Strong candidate assessment Portuguese'];
                }
                else if((asmt.Total__c >= 67 && asmt.Total_EE__c < 450) || (asmt.FSTW_Result__c == 'QUALIFIED' && asmt.Total_EE__c < 350)){
                    emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Eligible has the points but low points Portuguese'];
                }
                else if(asmt.Total__c < 67 && asmt.CEC_Result__c == 'NOT QUALIFIED' && asmt.FSTW_Result__c == 'NOT QUALIFIED'){
                    emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Do not qualify Portuguese'];
                }
            }
        }
        else if(asmt.Type__c == 'BCPNP')
        {
            if(asmt.Preferred_language__c == 'Farsi'){
              	emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'BCPNP_Farsi'];  
              	string emailSubject = asmt.First_Name_Main_Applicant__c + '، در اینجا نتیجه ارزیابی PNP BC شما است | خدمات مهاجرت ویزای الکترونیکی';
                message.setSubject(emailSubject);
                message.setCharset('UTF-8');
            }
            // For Portgues
            else if(asmt.Preferred_language__c == 'Portuguese'){
                emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'BCPNP_PT'];
                string emailSubject = asmt.First_Name_Main_Applicant__c + ', aqui está o resultado da sua Avaliação BC PNP | Serviços de imigração de e-Visa';
                message.setSubject(emailSubject);
            }
            else if(asmt.Preferred_language__c == 'Spanish'){
              	emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'BCPNP_Spanish'];  
              	string emailSubject = asmt.First_Name_Main_Applicant__c + ', aquí está el resultado de su evaluación BC PNP | Servicios de inmigración de visas electrónicas';
                message.setSubject(emailSubject);
                message.setCharset('UTF-8');
            }
            else
            {
                emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'BCPNP_EN'];  
              	string emailSubject = asmt.First_Name_Main_Applicant__c + ', here is the result of your BC PNP Assessment | e-Visa Immigration Services';
                message.setSubject(emailSubject);
            }
            
        }
        else if(asmt.Type__c == 'OINP')
        {
            if(asmt.Preferred_language__c == 'Portuguese')
            {
                emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'OINP_PT'];
                string emailSubject = asmt.First_Name_Main_Applicant__c + ', aqui está o resultado da sua Avaliação OINP | Serviços de imigração de e-Visa';
                message.setSubject(emailSubject);
            }
            else if(asmt.Preferred_language__c == 'Farsi')
            {
                emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'OINP_Farsi'];
                string emailSubject = asmt.First_Name_Main_Applicant__c + '، در اینجا نتیجه ارزیابی OINP شما است | خدمات مهاجرت ویزای الکترونیکی';
                message.setSubject(emailSubject);
                message.setCharset('UTF-8');
            }
            else if(asmt.Preferred_language__c == 'Spanish')
            {
                emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'OINP_Spanish'];
                string emailSubject = asmt.First_Name_Main_Applicant__c + ', aquí está el resultado de su Evaluación OINP | Servicios de inmigración de visas electrónicas';
                message.setSubject(emailSubject);
                message.setCharset('UTF-8');
            }
            else
            {
            	emailTemplates = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where Name = 'OINP_EN']; 
                string emailSubject = asmt.First_Name_Main_Applicant__c + ', here is the result of your OINP Assessment | e-Visa Immigration Service';
                message.setSubject(emailSubject);
            }
        }
        
        if(!emailTemplates.isEmpty()){
            message.setTemplateID(emailTemplates.get(0).Id); 
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'contact@evisaimmigration.com'];
            if ( owea.size() > 0 ) {
                message.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            //message.setTemplateID(null);
            String htmlBody = emailTemplates[0].HtmlValue;
            htmlBody = htmlBody.replaceAll('<!\\[CDATA\\[', ''); // replace '<![CDATA['
            htmlBody= htmlBody.replaceAll('\\]\\]>', ''); // replace ']]'
            htmlBody = htmlBody.replace('{!Lead.FirstName}', asmt.First_Name_Main_Applicant__c);
            if(asmt.Type__c == 'BCPNP')
            {
                htmlBody = htmlBody.replace('{!assessment__c.BCPNPTotal__c}', String.valueOf(asmt.BCPNPTotal__c));                
            }
            else if(asmt.Type__c == 'OINP')
            {
                htmlBody = htmlBody.replace('{!assessment__c.TotalEJOForeignWorkerOINP__c}', String.valueOf(asmt.TotalEJOForeignWorkerOINP__c));   
                htmlBody = htmlBody.replace('{!assessment__c.TotalEJOInDemandSkillsOINP__c}', String.valueOf(asmt.TotalEJOInDemandSkillsOINP__c));
                htmlBody = htmlBody.replace('{!assessment__c.TotalEJOInternationalStudentOINP__c}', String.valueOf(asmt.TotalEJOInternationalStudentOINP__c));
                htmlBody = htmlBody.replace('{!assessment__c.TotalMastersGraduateOINP__c}', String.valueOf(asmt.TotalMastersGraduateOINP__c));
                htmlBody = htmlBody.replace('{!assessment__c.TotalPhDGraduateOINP__c}', String.valueOf(asmt.TotalPhDGraduateOINP__c));
            }
            String plainBody = emailTemplates[0].Body;
            plainBody = plainBody.replace('{!Lead.FirstName}', asmt.First_Name_Main_Applicant__c);
            if(asmt.Type__c == 'BCPNP')
            {
                plainBody = plainBody.replace('{!assessment__c.BCPNPTotal__c}', String.valueOf(asmt.BCPNPTotal__c));
            }
            else if(asmt.Type__c == 'OINP')
            {
                plainBody = plainBody.replace('{!assessment__c.TotalEJOForeignWorkerOINP__c}', String.valueOf(asmt.TotalEJOForeignWorkerOINP__c));   
                plainBody = plainBody.replace('{!assessment__c.TotalEJOInDemandSkillsOINP__c}', String.valueOf(asmt.TotalEJOInDemandSkillsOINP__c));
                plainBody = plainBody.replace('{!assessment__c.TotalEJOInternationalStudentOINP__c}', String.valueOf(asmt.TotalEJOInternationalStudentOINP__c));
                plainBody = plainBody.replace('{!assessment__c.TotalMastersGraduateOINP__c}', String.valueOf(asmt.TotalMastersGraduateOINP__c));
                plainBody = plainBody.replace('{!assessment__c.TotalPhDGraduateOINP__c}', String.valueOf(asmt.TotalPhDGraduateOINP__c));
            }
            
            if(asmt.Type__c == 'Express Entry')
            {
               message.setSubject(emailTemplates[0].Subject); 
            }
            
            message.setHtmlBody(htmlBody);
            
            message.setPlainTextBody(plainBody);
            
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                
                try {
                    Messaging.sendEmail(messages);
                    return;
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }
        }
        
    }
    
    public Static Boolean isFSTWNoc(String Noc){
        if(String.isBlank(Noc)){
            return false;
        }
        if(Noc.startsWith('72') || Noc.startsWith('73') || Noc.startsWith('82') || Noc.startsWith('92') || Noc.startsWith('632') || Noc.startsWith('633')){
            return true;
        }
        return false;
    }
    
}