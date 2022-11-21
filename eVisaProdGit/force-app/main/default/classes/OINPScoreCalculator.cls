public class OINPScoreCalculator
{
    public static String calcPoints(List<assessment__c> asmtList)
    {
        List<assessment__c> updateAsmtList = new List<assessment__c>();
        Id eligibleOccIdSet ;
        Id cecEligibleOccIdSet;
        String statusMsg = '';
        
        for(assessment__c asmt : asmtList)
        {
            Integer salPoints = 0;
            Integer nocSkillPoints = 0;
            Integer nocTypePoints = 0;
            Integer canadianNocSkillPoints = 0;
            Integer locationOfJobPoints = 0;
            Integer locationOfStudyPoints = 0;
            Integer canadianWorkExpPoints = 0;
            Integer canadianEarnHistoryPoints = 0;
            Integer educationPoints = 0;
            Integer fieldOfStudyPoints = 0;
            Integer canadianEducationPoints = 0;
            Integer langPoints = 0;
            Integer KnowledgeOfLangPoints = 0;
            Integer strategicPrioritiesPoints = 0;
            Map<Id, Eligible_Occupation__c> mapOfSkillType;
            Map<Id, Eligible_Occupation__c> cecMapOfSkillType;
            
            
            if(asmt.Please_type_a_occupation_1__c != null)
            {
                eligibleOccIdSet = asmt.Please_type_a_occupation_1__c;
                mapOfSkillType = new Map<Id, Eligible_Occupation__c>([SELECT Id, Skill_Level__c, Name FROM Eligible_Occupation__c WHERE Id = :eligibleOccIdSet]);
            }
            
            if(asmt.CEC_Noc_Level__c != null)
            {
                cecEligibleOccIdSet = asmt.CEC_Noc_Level__c;
                cecMapOfSkillType = new Map<Id, Eligible_Occupation__c>([SELECT Id, Skill_Level__c, Name FROM Eligible_Occupation__c WHERE Id = :cecEligibleOccIdSet]);
            }
            
            
            
            if(mapOfSkillType != null && !mapOfSkillType.isEmpty()){
                nocSkillPoints = nocSkillFunc(mapOfSkillType.values());
           		asmt.OINPSkillLevel__c = nocSkillPoints;
            }
            else{
                asmt.OINPSkillLevel__c = 0;
            }
            
			if(mapOfSkillType != null && !mapOfSkillType.isEmpty()){
                nocTypePoints = nocTypeFunc(mapOfSkillType.values());
                asmt.OINPType__c = nocTypePoints;
            }
            else{
                asmt.OINPType__c = 0;
            }

            salPoints = salaryCal(asmt);
            asmt.OINPWage__c = salPoints;

            canadianWorkExpPoints = canadianWorkExpFunc(asmt);
            asmt.OINPCWEDuration__c = canadianWorkExpPoints;
	
            if(cecMapOfSkillType != null && !cecMapOfSkillType.isEmpty()){
             	canadianNocSkillPoints = canadianNocSkillFunc(cecMapOfSkillType.values(), asmt);
            	asmt.OINPCWESkillLevel__c = canadianNocSkillPoints;   
            }
            else{
                asmt.OINPCWESkillLevel__c = 0;
            }
            

            canadianEarnHistoryPoints = canadianEarnHistoryFunc(asmt);
            asmt.OINPCWEEarningHistory__c = canadianEarnHistoryPoints;

            educationPoints = educationPointsFunc(asmt);
            asmt.OINPEducation__c = educationPoints;

            fieldOfStudyPoints = fieldOfStudyFunc(asmt);
            asmt.OINPFieldOfStudy__c = fieldOfStudyPoints;

            canadianEducationPoints = canadianEducationFunc(asmt);
            asmt.OINPCanadianEduExp__c = canadianEducationPoints;

            locationOfJobPoints = locationOfJobFunc(asmt);
            asmt.OINPLocationOfJob__c = locationOfJobPoints;
            
            locationOfStudyPoints = locationOfStudyFunc(asmt);
            asmt.OINPLocationOfStudy__c = locationOfStudyPoints;
            
            langPoints = langPointsFunc(asmt);
            asmt.OINPLanguageAbility__c = langPoints;

            KnowledgeOfLangPoints = KnowledgeOfLangFunc(asmt);
            asmt.OINPKnowledgeOfLang__c = KnowledgeOfLangPoints;
            
            strategicPrioritiesPoints = strategicPrioritiesFunc(asmt);
            asmt.OINPStrategicPriorities__c = strategicPrioritiesPoints;

            if(String.isBlank(asmt.Please_type_a_occupation_1__c) || String.isBlank(asmt.Salary_Amount_OINP__c) 
               || String.isBlank(asmt.Company_Location_in_ON__c) || asmt.Directly_Related_Work_Experience__c =='Less than 1 year' || asmt.Directly_Related_Work_Experience__c == '1 to 2 years' || String.isBlank(asmt.Directly_Related_Work_Experience__c) )
            {
             	asmt.TotalEJOForeignWorkerOINP__c = 0;   
            }
            else{
               	asmt.TotalEJOForeignWorkerOINP__c = asmt.OINPSkillLevel__c + asmt.OINPType__c + asmt.OINPWage__c + asmt.OINPCWEDuration__c +
                asmt.OINPCWESkillLevel__c + asmt.OINPCWEEarningHistory__c + asmt.OINPLocationOfJob__c + asmt.OINPStrategicPriorities__c; 
            }
            
            

            if(asmt.Is_Occ_in_in_demand_occupations_list__c == 'Yes' && String.isNotBlank(asmt.Please_type_a_occupation_1__c) && String.isNotBlank(asmt.Salary_Amount_OINP__c) 
               && String.isNotBlank(asmt.Company_Location_in_ON__c) )
            {
               asmt.TotalEJOInDemandSkillsOINP__c = asmt.OINPSkillLevel__c + asmt.OINPType__c + asmt.OINPWage__c + asmt.OINPCWEDuration__c +
                asmt.OINPCWESkillLevel__c + asmt.OINPCWEEarningHistory__c + asmt.OINPLocationOfJob__c + asmt.OINPStrategicPriorities__c; 
            }
            else
            {
                asmt.TotalEJOInDemandSkillsOINP__c = 0;
            }
            
            if(asmt.OINPKnowledgeOfLang__c == 0 || asmt.Education_Level_OINP__c =='Less than college or trade certificate' || String.isBlank(asmt.Please_type_a_occupation_1__c) || String.isBlank(asmt.Salary_Amount_OINP__c) 
               || String.isBlank(asmt.Education_Level_OINP__c) || String.isBlank(asmt.Field_of_Study__c)
               || String.isBlank(asmt.Canadian_Education_Experience__c) || String.isBlank(asmt.Do_you_speak_English_or_French__c) || String.isBlank(asmt.Company_Location_in_ON__c) || String.isBlank(asmt.Institution_Location_OINP__c) 
               || ( (asmt.Do_you_speak_English_or_French__c == 'Both' || asmt.Do_you_speak_English_or_French__c == 'English') && String.isBlank(asmt.English_reading__c) && String.isBlank(asmt.English_Writing__c) && String.isBlank(asmt.English_speaking__c) && String.isBlank(asmt.English_Listening__c) )
               || ( (asmt.Do_you_speak_English_or_French__c == 'Both' || asmt.Do_you_speak_English_or_French__c == 'French') && String.isBlank(asmt.French_reading__c) && String.isBlank(asmt.French_Writing__c) && String.isBlank(asmt.French_speaking__c) && String.isBlank(asmt.French_Listening__c) ))
            {  
                asmt.TotalEJOInternationalStudentOINP__c = 0;
            }
            else{
                asmt.TotalEJOInternationalStudentOINP__c = asmt.OINPSkillLevel__c + asmt.OINPType__c + asmt.OINPWage__c +
                asmt.OINPCWEDuration__c + asmt.OINPCWESkillLevel__c + asmt.OINPCWEEarningHistory__c + asmt.OINPEducation__c + 
                asmt.OINPFieldOfStudy__c + asmt.OINPCanadianEduExp__c + asmt.OINPLanguageAbility__c +
                asmt.OINPKnowledgeOfLang__c + asmt.OINPLocationOfJob__c + asmt.OINPLocationOfStudy__c + asmt.OINPStrategicPriorities__c;
            }
            
             
            
            if(asmt.Country_of_studies__c == 'Canada' && asmt.Education_Level_OINP__c == 'Masters' 
               &&  String.isNotBlank(asmt.Field_of_Study__c)
               && String.isNotBlank(asmt.Canadian_Education_Experience__c) && String.isNotBlank(asmt.Do_you_speak_English_or_French__c) && String.isNotBlank(asmt.Institution_Location_OINP__c) 
               && ( ( (asmt.Do_you_speak_English_or_French__c == 'English') && (String.isNotBlank(asmt.English_reading__c) || String.isNotBlank(asmt.English_Writing__c) || String.isNotBlank(asmt.English_speaking__c) || String.isNotBlank(asmt.English_Listening__c) ) )
               || ( (asmt.Do_you_speak_English_or_French__c == 'French') && (String.isNotBlank(asmt.French_reading__c) || String.isNotBlank(asmt.French_Writing__c) || String.isNotBlank(asmt.French_speaking__c) || String.isNotBlank(asmt.French_Listening__c) ) )
               || ( (asmt.Do_you_speak_English_or_French__c == 'Both' ) && (String.isNotBlank(asmt.English_reading__c) || String.isNotBlank(asmt.English_Writing__c) || String.isNotBlank(asmt.English_speaking__c) || String.isNotBlank(asmt.English_Listening__c) ) && (String.isNotBlank(asmt.French_reading__c) || String.isNotBlank(asmt.French_Writing__c) || String.isNotBlank(asmt.French_speaking__c) || String.isNotBlank(asmt.French_Listening__c) ) ) ) )
            {
                asmt.TotalMastersGraduateOINP__c = asmt.OINPCWEDuration__c + asmt.OINPCWESkillLevel__c + asmt.OINPCWEEarningHistory__c +
                asmt.OINPFieldOfStudy__c + asmt.OINPCanadianEduExp__c + asmt.OINPLanguageAbility__c +
                asmt.OINPKnowledgeOfLang__c + asmt.OINPLocationOfStudy__c + asmt.OINPStrategicPriorities__c;
            }
            else
            {
                asmt.TotalMastersGraduateOINP__c = 0;
            }
            
    
            if(asmt.Country_of_studies__c == 'Canada' && asmt.Education_Level_OINP__c == 'PhD' 
               &&  String.isNotBlank(asmt.Field_of_Study__c)
               && String.isNotBlank(asmt.Canadian_Education_Experience__c) && String.isNotBlank(asmt.Do_you_speak_English_or_French__c) && String.isNotBlank(asmt.Institution_Location_OINP__c)
               && ( ( (asmt.Do_you_speak_English_or_French__c == 'English') && (String.isNotBlank(asmt.English_reading__c) || String.isNotBlank(asmt.English_Writing__c) || String.isNotBlank(asmt.English_speaking__c) || String.isNotBlank(asmt.English_Listening__c) ) )
               || ( (asmt.Do_you_speak_English_or_French__c == 'French') && (String.isNotBlank(asmt.French_reading__c) || String.isNotBlank(asmt.French_Writing__c) || String.isNotBlank(asmt.French_speaking__c) || String.isNotBlank(asmt.French_Listening__c) ) )
               || ( (asmt.Do_you_speak_English_or_French__c == 'Both' ) && (String.isNotBlank(asmt.English_reading__c) || String.isNotBlank(asmt.English_Writing__c) || String.isNotBlank(asmt.English_speaking__c) || String.isNotBlank(asmt.English_Listening__c) ) && (String.isNotBlank(asmt.French_reading__c) || String.isNotBlank(asmt.French_Writing__c) || String.isNotBlank(asmt.French_speaking__c) || String.isNotBlank(asmt.French_Listening__c) ) ) ) )
            {
                asmt.TotalPhDGraduateOINP__c = asmt.OINPCWEDuration__c + asmt.OINPCWESkillLevel__c + asmt.OINPCWEEarningHistory__c +
                asmt.OINPFieldOfStudy__c + asmt.OINPCanadianEduExp__c + asmt.OINPLanguageAbility__c +
                asmt.OINPKnowledgeOfLang__c + asmt.OINPLocationOfStudy__c + asmt.OINPStrategicPriorities__c;
            }
            else
            {
                asmt.TotalPhDGraduateOINP__c = 0;
            }
            

            updateAsmtList.add(asmt);
        }
        // Updating the assessment list
        if(updateAsmtList.size() > 0 && !Trigger.isExecuting){
            try{
                update updateAsmtList;
                statusMsg = 'Assessment Score updated successfully';
            }
            catch(DMLException exp){
                System.debug('DMLException occured: '+exp.getMessage());
                statusMsg = 'DML Exception Occured';
            }
            catch(QueryException qe){
                System.debug('QueryException occured: '+qe.getMessage());
                statusMsg = 'Query Exception Occured';
            }
            catch(Exception ex){
                System.debug('Exception Occured: '+ex.getMessage() +' In Line Number: '+ex.getLineNumber());
                statusMsg = 'Exception Occured';
            }
        }
        
        return statusMsg;
    }
    
    
    public static Integer strategicPrioritiesFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Occupation_part_OINP_Strategic_Priority__c == 'Yes')
        {
            total = 10;
        }
        return total;
    }
    public static Integer KnowledgeOfLangFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Do_you_speak_English_or_French__c == 'Both')
            total = 10;
        else if(asmt.Do_you_speak_English_or_French__c == 'French' || asmt.Do_you_speak_English_or_French__c == 'English')
            total = 5;
        return total;
    }
    public static Integer langPointsFunc(assessment__c asmt)
    {
        Integer minEnglishScore = engScoreCalculator(asmt);
        Integer minFrenchScore = frenchScoreCalculator(asmt);
        Integer langScore = 0;
        Integer total = 0;
        langScore = minEnglishScore >= minFrenchScore ? minEnglishScore : minFrenchScore;

        if(langScore >= 9)
            total = 10;
        else if(langScore == 8)
            total = 6;
        else if(langScore == 7)
            total = 4;
        return total;
    }

    
    public static Integer canadianEducationFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Type_of_educational_institute__c == 'Public')
        {
            if(asmt.Canadian_Education_Experience__c == 'More than one Canadian credential')
                total = 10;
            else if(asmt.Canadian_Education_Experience__c == 'One Canadian credential')
                total = 5;
        }
        return total;
    }
    
    public static Integer fieldOfStudyFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Field_of_Study__c =='Engineering' || asmt.Field_of_Study__c =='Engineering Technology' || asmt.Field_of_Study__c =='Medicine, Dentistry, Optometry, and Veterinary medicine (including residencies)' || asmt.Field_of_Study__c =='Nursing' || asmt.Field_of_Study__c =='Pharmacy and related programs' || asmt.Field_of_Study__c =='Health care, n.e.c.')
            total = 10;
        else if(asmt.Field_of_Study__c =='Mathematics and related studies' || asmt.Field_of_Study__c =='Computer and Information sciences')
            total = 9;
        else if(asmt.Field_of_Study__c =='Business and Related studies' || asmt.Field_of_Study__c =='Public Administration' || asmt.Field_of_Study__c =='Agriculture and natural resources operations and management' || asmt.Field_of_Study__c =='Mechanics and repair, Architecture, Construction, and Precision Production' || asmt.Field_of_Study__c =='Personal, Security, and Transport services' || asmt.Field_of_Study__c =='Non-credit programs' || asmt.Field_of_Study__c =='BHASE programs, n.e.c.')  
            total = 7;
        else if(asmt.Field_of_Study__c =='Physical and Chemical sciences' || asmt.Field_of_Study__c =='Biological Sciences' || asmt.Field_of_Study__c =='General and Integrated sciences' || asmt.Field_of_Study__c =='Social and Behavioural sciences' || asmt.Field_of_Study__c =='Law' || asmt.Field_of_Study__c =='' || asmt.Field_of_Study__c =='Other legal professions and studies' || asmt.Field_of_Study__c =='Education and Teaching'|| asmt.Field_of_Study__c =='Social Work and related programs') 
            total = 6;   
        else if(asmt.Field_of_Study__c =='Arts' || asmt.Field_of_Study__c =='Humanities') 
            total = 5;
        return total;
    }
    
    public static Integer educationPointsFunc(assessment__c asmt)
    {
        Integer total =0;
        if(asmt.Education_Level_OINP__c == 'PhD')
            total =10;
        else if(asmt.Education_Level_OINP__c == 'Masters')
            total = 8;
        else if(asmt.Education_Level_OINP__c == 'Bachelors or equivalent')
            total = 6;
        else if(asmt.Education_Level_OINP__c == 'College Diploma or Certificate for at least 2 years or more' || asmt.Education_Level_OINP__c == 'College Diploma or Certificate for at least 1 year')
            total = 5;
        return total;
    }
    
    public static Integer canadianWorkExpFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Do_you_have_over_12_months_of_Canadian_E__c == 'More than 12 months of cumulative, full-time or part-time equivalent')
            total = 4;
        return total;
    }
    
    
    public static Integer nocSkillFunc(Eligible_Occupation__c eocc)
    {
        Integer total = 0;
        String name = eocc.Name;
        if(String.isNotBlank(name))
        {
            
            if(name.length()>=2)   
            {   
                //changes start on 28/07/2022
                if(name.substring(0,1) =='0')
                {
                    total = 10;
                }
                //changes end on 28/07/2022
                else if(name.substring(1,2) =='0' || name.substring(1,2) =='1')
                    total = 10;
                else if(name.substring(1,2) =='2' || name.substring(1,2) =='3')
                    total = 8;
                else if(name.substring(1,2) != '0' && name.substring(1,2) != '1'  && name.substring(1,2) != '2' && name.substring(1,2)!= '3')
                    total = 0;
                
            }
        }
        
        return total;
        
    }
    public static Integer nocTypeFunc(Eligible_Occupation__c eocc)
    {
        Integer total = 0;
        String name = eocc.Name;
        if(String.isNotBlank(name))
        {
            if(name.length()>=2)
            {
                if(name.substring(0,1) =='0' || name.substring(0,1) =='1' || name.substring(0,1) =='2' || name.substring(0,1) =='3' || name.substring(0,1) =='9')
                {    
                    total =10;
                }
                else if(name.substring(0,1) =='4' || name.substring(0,1) =='5' || name.substring(0,1) =='6' || name.substring(0,1) =='7' || name.substring(0,1) =='8')
                {
                    total =5;
                }
            }
        }
        return total;
    }
    
    public static Integer salaryCal(assessment__c asmt)
    {
        Integer salaryPoint = 0;
        
        if(asmt.Salary_Amount_OINP__c == '$40 per hour or higher')
        {
            salaryPoint = 10;
        }
        else if(asmt.Salary_Amount_OINP__c == '$20 to $39.99 per hour')
        {
            salaryPoint = 5;
        }
        else if( asmt.Salary_Amount_OINP__c=='Less than $20 per hour')
        {
            salaryPoint = 0;
        }
        return salaryPoint;
    }
    
    public static Integer canadianEarnHistoryFunc(assessment__c asmt)
    {
        Integer total =0;
        if(asmt.Earnings_History__c == '$40k or more earnings in a year')
            total = 3;
        return total;
    }
    
    public static Integer canadianNocSkillFunc(Eligible_Occupation__c eocc, assessment__c asmt)
    {
        Integer total = 0;
        String name = eocc.Name;
        if(String.isNotBlank(name))
        {
            if(name.length()>=2)
            {
                 //changes start on 28/07/2022
                if(name.substring(0,1) =='0' && String.isNotBlank(asmt.Do_you_have_over_12_months_of_Canadian_E__c) && asmt.Do_you_have_over_12_months_of_Canadian_E__c == 'More than 12 months of cumulative, full-time or part-time equivalent')
                {
                    total = 10;
                }
                //changes end on 28/07/2022
                //changes on 28/07/2022 comment
                else if( (/*name.substring(1,2) =='0' ||*/ name.substring(1,2) =='1') && String.isNotBlank(asmt.Do_you_have_over_12_months_of_Canadian_E__c) && asmt.Do_you_have_over_12_months_of_Canadian_E__c == 'More than 12 months of cumulative, full-time or part-time equivalent' )
                    total = 3;
               
            }
        }
        
        return total;
    }
    public static Integer locationOfJobFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Company_Location_in_ON__c == 'Greater Toronto Area (GTA)')     
        {
            total = 6;
        }
        else if(asmt.Company_Location_in_ON__c == 'Outside Greater Toronto Area (GTA)') 
        {
            total = 10;
        }  
        return total; 
    }  
    
    public static Integer locationOfStudyFunc(assessment__c asmt)
    {
        Integer total = 0;
        if(asmt.Institution_Location_OINP__c == 'Greater Toronto Area (GTA)')     
        {
            total = 6;
        }
        else if(asmt.Institution_Location_OINP__c == 'Outside Greater Toronto Area (GTA)') 
        {
            total = 10;
        }  
        return total; 
    }
    
    
    
    public static Integer engScoreCalculator(assessment__c asmt)
    {
        Integer minEnglishScore = 0;
        if(asmt.Do_you_speak_English_or_French__c !=null && (asmt.Do_you_speak_English_or_French__c == 'Both' || asmt.Do_you_speak_English_or_French__c == 'English'))
        {
            if(String.isNotBlank(asmt.English_test_type__c))
            {
                Integer engRead = 0;
                Integer engWrite = 0;
                Integer engSpeak = 0;
                Integer engListen = 0;
                
                if(asmt.English_reading__c == null)
                    engRead = 1000;
                else
                {
                    engRead = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Reading', asmt.English_reading__c);
                }
                if(asmt.English_Writing__c == null)
                    engWrite = 1000;
                else
                {
                    engWrite = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Writing', asmt.English_Writing__c);
                }
                if(asmt.English_speaking__c == null)
                    engSpeak = 1000;
                else
                {
                    engSpeak = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Speaking', asmt.English_speaking__c);
                }
                if(asmt.English_Listening__c == null)
                    engListen = 1000;
                else
                {
                    engListen = AssessmentScoreCalculatorUtility.getEnglishCLB(asmt.English_test_type__c, 'Listening', asmt.English_Listening__c);
                }
                
                engRead = engRead <= engWrite? engRead : engWrite;
                engRead = engRead <= engSpeak? engRead : engSpeak;
                engRead = engRead <= engListen? engRead : engListen;
                if(engRead == 1000)
                    minEnglishScore = 0;
                else
                    minEnglishScore = engRead;
            }
        }
        return minEnglishScore;
    }
    
    public static Integer frenchScoreCalculator(assessment__c asmt)
    {
        Integer minFrenchScore = 0;
        if(asmt.Do_you_speak_English_or_French__c !=null && (asmt.Do_you_speak_English_or_French__c == 'Both' || asmt.Do_you_speak_English_or_French__c == 'French'))
        {
            if(String.isNotBlank(asmt.Have_you_done_TEF__c))
            {
                Integer frenchRead = 0;
                Integer frenchWrite = 0;
                Integer frenchSpeak = 0;
                Integer frenchListen = 0;
                
                if(asmt.French_reading__c == null)
                    frenchRead = 1000;
                else
                    frenchRead = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Reading', asmt.French_reading__c);
                if(asmt.French_Writing__c == null)
                    frenchWrite = 1000;
                else
                    frenchWrite = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Writing', asmt.French_Writing__c);
                if(asmt.French_speaking__c == null)
                    frenchSpeak = 1000;
                else
                    frenchSpeak = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Speaking', asmt.French_speaking__c);
                if(asmt.French_Listening__c == null)
                    frenchListen = 1000;
                else
                   frenchListen = AssessmentScoreCalculatorUtility.getFrenchCLB(asmt.Have_you_done_TEF__c, 'Listening', asmt.French_Listening__c); 
                
                frenchRead = frenchRead <= frenchWrite ? frenchRead : frenchWrite;
                frenchRead = frenchRead <= frenchSpeak ? frenchRead : frenchSpeak;
                frenchRead = frenchRead <= frenchListen ? frenchRead : frenchListen;
                
                if(frenchRead == 1000)
                    minFrenchScore = 0;
                else
                    minFrenchScore = frenchRead;
                
            }
        }
        
        return minFrenchScore;
    }  
}