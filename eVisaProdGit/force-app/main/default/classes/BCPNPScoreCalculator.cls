public without sharing class BCPNPScoreCalculator {
    
    public static String calcPoints(List<assessment__c> asmtList){
        List<assessment__c> updateAsmtList = new List<assessment__c>();
        Map<String,Integer>  rdePoints = new Map<String,Integer>{'Greater Vancouver'=>0,'Fraser Valley'=>2,'Capital'=>2,'Thompson-Nicola'=>2,
            'Nanaimo'=>2,'Central Okanagan'=>2,'Okanagan-Similkameen'=>4,'Cowichan Valley'=>4,'North Okanagan'=>4,'Fraser-Fort George'=>4,
            'Peace River'=>6,'Comox Valley'=>6,'Cariboo'=>6,'Central Kootenay'=>6,'Kitimat-Stikine'=>8,'Bulkley-Nechako'=>8,'Squamish-Lillooet'=>8,
            'Strathcona'=>8,'Columbia-Shuswap'=>8,'East Kootenay'=>8,'Stikine'=>10,'Central Coast'=>10,'Northern Rockies'=>10,'Mount Waddington'=>10,
            'Skeena-Queen Charlotte'=>10,'Powell River'=>10,' Sunshine Coast'=>10,'Kootenay-Boundary'=>10,'Alberni-Clayoquot'=>10};
        String statusMsg = '';
        String noctype = '';
        Set<Id> eligibleOccIdSet = new Set<Id>();
        for(assessment__c asmt : asmtList){
            Integer nocScr = 0;
            Integer currentlyworking = 0;
            Integer extNoc = 0;
            Integer salPoints = 0;
            Integer companyLocpoints = 0;
            Integer workExYear = 0;
            Integer oneYearExp = 0;
            if(asmt.Please_type_a_occupation_1__c != null){
                eligibleOccIdSet.add(asmt.Please_type_a_occupation_1__c);
            }
            Map<Id, Eligible_Occupation__c> mapOfSkillType = new Map<Id, Eligible_Occupation__c>([SELECT Id, Skill_Level__c, Name FROM Eligible_Occupation__c WHERE Id IN :eligibleOccIdSet]);
            if(mapOfSkillType.containsKey(asmt.Please_type_a_occupation_1__c))
            {
                nocScr = nocScore(mapOfSkillType.get(asmt.Please_type_a_occupation_1__c));
                extNoc = extraNoc(mapOfSkillType.get(asmt.Please_type_a_occupation_1__c));
                noctype = nocType(mapOfSkillType.get(asmt.Please_type_a_occupation_1__c));
                asmt.BCPNPskilllevel__c = nocScr;
                asmt.BCPNPOOBonus__c = extNoc;
            }
            currentlyworking = asmt.Currently_working_on_this_job_1__c == 'Yes'? 10 : 0;
            asmt.BCPNPCurrentlyWorking__c = currentlyworking;
            salPoints = salaryCal(asmt);
            asmt.BCPNPWage__c = salPoints;
            if(String.isNotBlank(asmt.Company_Location_in_BC__c))
            {
                List<String> companyLocation = asmt.Company_Location_in_BC__c.split(';');
                Set<String> companyLocationSet = new Set<String>(companyLocation);
                for(String s : rdePoints.keySet())
                {
                    if(companyLocationSet.contains(s) && companyLocpoints == 0)
                    {
                        companyLocpoints = rdePoints.get(s);
                        break;
                    }
                }
                
            }
            asmt.BCPNPRDE__c = companyLocpoints;
            if(String.isNotBlank(asmt.Directly_Related_Work_Experience__c))
            {
               String drwe = asmt.Directly_Related_Work_Experience__c;
                if(drwe == '5 years+')
                    workExYear = 15;
                else if(drwe == '4 to 5 years')
                    workExYear = 12;
                else if(drwe == '3 to 4 years')
                    workExYear = 9;
                else if(drwe == '2 to 3 years')
                    workExYear = 6;
                else if(drwe == '1 to 2 years')
                    workExYear = 3;
                else if(drwe == 'Less than 1 year')
                    workExYear = 1;
            }
            asmt.BCPNPDRWE__c = workExYear;
            if(asmt.At_least_1_year_of_experience_in_Canada__c != null && asmt.At_least_1_year_of_experience_in_Canada__c == 'Yes')
                oneYearExp = 10;
            else
                oneYearExp = 0;
            asmt.BCPNPAtleast1Yearexp__c = oneYearExp;
            
            //Highest level of education scoring 
            if(String.isNotBlank(asmt.Education_Level__c))
            {
                if(asmt.Education_Level__c == 'Doctor Degree (PhD)' || asmt.Education_Level__c == 'Masters')
                    asmt.BCPNPHLE__c = 17;
                if(asmt.Education_Level__c == 'Post Degree Diploma' || asmt.Education_Level__c == 'Bachelor / Licenciature' ||asmt.Education_Level__c == 'Trade Certificate')
                    asmt.BCPNPHLE__c = 11;
                if(asmt.Education_Level__c == 'Associate Degree')
                    asmt.BCPNPHLE__c = 4;
                if(asmt.Education_Level__c == '3-year Diploma' || asmt.Education_Level__c == '2-year Diploma' || asmt.Education_Level__c == '1-year Diploma / Certificate' )
                    asmt.BCPNPHLE__c = 2;
                if(asmt.Education_Level__c == 'High School' || asmt.Education_Level__c == 'Below High School')
                    asmt.BCPNPHLE__c = 0;
                    
            }
            else
                asmt.BCPNPHLE__c = 0;
                
            //Post secondary completed in BC
            asmt.BCPNPPostBC__c = 0;
            asmt.BCPNPPostCanada__c = 0;
            if(String.isNotBlank(asmt.Institution_Location__c))
            {
                if(asmt.Institution_Location__c == 'Post-secondary Institution in BC')
                {
                    asmt.BCPNPPostBC__c = 8;
                    asmt.BCPNPPostCanada__c = 0;
                }
                else if(asmt.Institution_Location__c == 'Post-secondary Institution outside BC but in Canada')
                {
                    asmt.BCPNPPostBC__c = 0;
                    asmt.BCPNPPostCanada__c = 6;
                }
                    
            }
            else
            {
                asmt.BCPNPPostBC__c = 0;
                asmt.BCPNPPostCanada__c = 0; 
            }
            asmt.BCPNPECA__c =0;
            asmt.BCPNPICA__c = 0;
            
            if(String.isNotBlank(asmt.Education_Credential_Assessment__c))
            {
                if(asmt.Education_Credential_Assessment__c == 'Yes')
                    asmt.BCPNPECA__c =4;  
            }
            if(String.isNotBlank(asmt.Trade_Certification_in_Canada__c))
            {
                if(asmt.Trade_Certification_in_Canada__c == 'Yes')
                    asmt.BCPNPICA__c =4; 
            }
            
            Decimal maxPostSecondary = 0;
            if(asmt.BCPNPPostBC__c > maxPostSecondary)
            {
                maxPostSecondary = asmt.BCPNPPostBC__c;
                asmt.BCPNPECA__c = 0;
                asmt.BCPNPICA__c = 0;
                asmt.BCPNPPostCanada__c = 0;
            }
            else if(asmt.BCPNPPostCanada__c > maxPostSecondary)
            {
                maxPostSecondary = asmt.BCPNPPostCanada__c;
                asmt.BCPNPICA__c = 0;
                asmt.BCPNPECA__c = 0;
                asmt.BCPNPPostBC__c = 0;   
            }
            else if(asmt.BCPNPECA__c > maxPostSecondary)
            {
                maxPostSecondary = asmt.BCPNPECA__c;
                asmt.BCPNPICA__c = 0;
                asmt.BCPNPPostCanada__c = 0;
                asmt.BCPNPPostBC__c = 0;
            }
            else if(asmt.BCPNPICA__c > maxPostSecondary)
            {
                maxPostSecondary = asmt.BCPNPICA__c;
                asmt.BCPNPECA__c = 0;
                asmt.BCPNPPostCanada__c = 0;
                asmt.BCPNPPostBC__c = 0;
            }
 
            
            //Language Scoring
            Integer minEnglishScore = engScoreCalculator(asmt);
            Integer minFrenchScore = frenchScoreCalculator(asmt);
            Integer langScore = 0;
            Integer langPoint = 0; //Language Point
            langScore = minEnglishScore >= minFrenchScore ? minEnglishScore : minFrenchScore;
            
            if(langScore >= 10)
                langPoint = 30;
            else if(langScore >= 9 && langScore < 10)
                langPoint = 26;
            else if(langScore >= 8 && langScore < 9)
                langPoint = 22;
            else if(langScore >= 7 && langScore < 8)
                langPoint = 18;
            else if(langScore >= 6 && langScore < 7)
                langPoint = 14;
            else if(langScore >= 5 && langScore < 6)
                langPoint = 10;
            else if(langScore >= 4 && langScore < 5)
                langPoint = 6;
            else 
                langPoint = 0;
            asmt.BCPNPLanguage__c = langPoint;
            
            if(String.isNotBlank(asmt.SkilledWorkingExperience__c) && asmt.SkilledWorkingExperience__c == 'Yes')
            {
                if(String.isNotBlank(noctype) && (noctype == '0' || noctype == 'A'))
                {
                    asmt.BCPNPSkilledWS__c = 'QUALIFIED';
                }
                else if(String.isNotBlank(noctype) && noctype == 'B' && langScore >=4)
                {
                    asmt.BCPNPSkilledWS__c = 'QUALIFIED';
                }
                else
                    asmt.BCPNPSkilledWS__c = 'NOT QUALIFIED';
            }
            else
                asmt.BCPNPSkilledWS__c = 'NOT QUALIFIED';
            if(String.isNotBlank(asmt.Country_of_studies__c) && asmt.Country_of_studies__c == 'Canada' && String.isNotBlank(asmt.Type_of_educational_institute__c) && 
              String.isNotBlank(asmt.Education_Level__c) && String.isNotBlank(noctype) && (noctype == 'A' || (noctype == 'B' && langScore >=4)))
            {
                if(asmt.Type_of_educational_institute__c == 'Public' && asmt.Education_Level__c != 'High School' && asmt.Education_Level__c != 'Below High School')
                {
                    asmt.BCPNPSGS__c = 'QUALIFIED';
                }
                else if(asmt.Type_of_educational_institute__c == 'Private' && (asmt.Education_Level__c =='Associate Degree' || asmt.Education_Level__c == 'Bachelor / Licenciature'
                                                                              ||asmt.Education_Level__c == 'Post Degree Diploma' ||asmt.Education_Level__c == 'Masters' ||asmt.Education_Level__c == 'Doctor Degree (PhD)'))
                {
                    asmt.BCPNPSGS__c = 'QUALIFIED';
                }
                else
                    asmt.BCPNPSGS__c = 'NOT QUALIFIED';
            }
            else
                asmt.BCPNPSGS__c = 'NOT QUALIFIED';
            
            asmt.BCPNPEcoSub__c = asmt.BCPNPskilllevel__c + asmt.BCPNPOOBonus__c + asmt.BCPNPCurrentlyWorking__c + asmt.BCPNPWage__c + asmt.BCPNPRDE__c;
            
            asmt.BCPNPHumCap__c = asmt.BCPNPLanguage__c + maxPostSecondary + asmt.BCPNPHLE__c + asmt.BCPNPAtleast1Yearexp__c +asmt.BCPNPDRWE__c;
            
            asmt.BCPNPTotal__c = asmt.BCPNPLanguage__c + maxPostSecondary + asmt.BCPNPHLE__c + asmt.BCPNPAtleast1Yearexp__c +asmt.BCPNPDRWE__c +
                asmt.BCPNPRDE__c + asmt.BCPNPWage__c + asmt.BCPNPCurrentlyWorking__c + asmt.BCPNPOOBonus__c + asmt.BCPNPskilllevel__c;
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
    
    public static Integer nocScore(Eligible_Occupation__c eocc)
    {
        Integer total = 0;
        String name = eocc.Name;
        if(String.isNotBlank(name))
        {
            if(name.length()>=2)
            {
                if(name.substring(0,1) =='0')
                    total+=25;
                else if(name.substring(1,2) =='0' || name.substring(1,2) =='1')
                    total+=25;
                else if(name.substring(1,2) =='2' || name.substring(1,2) =='3')
                    total+=10;
                else
                    total+=5;
            }
        }
        
        return total;
    }
    
    public static String nocType(Eligible_Occupation__c eocc)
    {
        String total = '';
        String name = eocc.Name;
        if(String.isNotBlank(name))
        {
            if(name.length()>=2)
            {
                if(name.substring(0,1) =='0')
                    total='0';
                else if(name.substring(1,2) =='0' || name.substring(1,2) =='1')
                    total = 'A';
                else if(name.substring(1,2) =='2' || name.substring(1,2) =='3')
                    total= 'B';
                else if(name.substring(1,2) == '4' || name.substring(1,2) == '5')
                    total ='C';
                else
                    total = 'D';
            }
        }
        
        return total;
    }
    
    public static Integer extraNoc(Eligible_Occupation__c eocc)
    {
        Integer total = 0;
        String name = eocc.Name;
        if(String.isNotBlank(name))
        {
            if(name.length()>=2)
            {
                if(name.substring(0,2) =='00')
                    total+=15;
            }
        }
        return total;
        
    }
    public static Integer salaryCal(assessment__c asmt)
    {
        Integer salaryPoint = 0;
        Double sal = 0;
        if(asmt.Type_of_Salary__c == 'Hourly')
        {
            Double hours = 0;
            hours = asmt.Hours_per_week__c == null ? 0 : asmt.Hours_per_week__c;
            Double amount = 0;
            amount = asmt.Salary_Amount__c == null ? 0 : asmt.Salary_Amount__c;
            sal = 52*hours*amount;
        }
        else if(asmt.Type_of_Salary__c == 'Yearly')
        {
            sal = asmt.Salary_Amount__c == null ? 0 : asmt.Salary_Amount__c;
        }
        if(sal >= 100000)
            salaryPoint = 50;
        else if(sal >=97500 && sal<100000)
            salaryPoint = 38;
        else if(sal >=95000 && sal<97500)
            salaryPoint = 37;
        else if(sal >=92500 && sal<95000)
            salaryPoint = 36;
        else if(sal >=90000 && sal<92500)
            salaryPoint = 35;
        else if(sal >=87500 && sal<90000)
            salaryPoint = 34;
        else if(sal >=85000 && sal<87500)
            salaryPoint = 33;
        else if(sal >=82500 && sal<85000)
            salaryPoint = 32;
        else if(sal >=80000 && sal<82500)
            salaryPoint = 31;
        else if(sal >=77500 && sal<80000)
            salaryPoint = 30;
        else if(sal >=75000 && sal<77500)
            salaryPoint = 29;
        else if(sal >=72500 && sal<75000)
            salaryPoint = 28;
        else if(sal >=70000 && sal<72500)
            salaryPoint = 27;
        else if(sal >=67500 && sal<70000)
            salaryPoint = 26;
        else if(sal >=65000 && sal<67500)
            salaryPoint = 25;
        else if(sal >=62500 && sal<65000)
            salaryPoint = 24;
        else if(sal >=60000 && sal<62500)
            salaryPoint = 23;
        else if(sal >=57500 && sal<60000)
            salaryPoint = 22;
        else if(sal >=55000 && sal<57500)
            salaryPoint = 21;
        else if(sal >=52500 && sal<55000)
            salaryPoint = 20;
        else if(sal >=50000 && sal<52500)
            salaryPoint = 19;
        else if(sal >=47500 && sal<50000)
            salaryPoint = 18;
        else if(sal >=45000 && sal<47500)
            salaryPoint = 17;
        else if(sal >=42500 && sal<45000)
            salaryPoint = 16;
        else if(sal >=40000 && sal<42500)
            salaryPoint = 15;
        else if(sal >=38750 && sal<40000)
            salaryPoint = 14;
        else if(sal >=37500 && sal<38750)
            salaryPoint = 13;
        else if(sal >=36250 && sal<37500)
            salaryPoint = 12;
        else if(sal >=35000 && sal<36250)
            salaryPoint = 11;
        else if(sal >=33750 && sal<35000)
            salaryPoint = 10;
        else if(sal >=32500 && sal<33750)
            salaryPoint = 9;
        else if(sal >=31250 && sal<32500)
            salaryPoint = 8;
        else if(sal >=30000 && sal<31250)
            salaryPoint = 7;
        else if(sal >=28750 && sal<30000)
            salaryPoint = 6;
        else if(sal >=27500 && sal<28750)
            salaryPoint = 5;
        else if(sal >=26250 && sal<27500)
            salaryPoint = 4;
        else if(sal >=25000 && sal<26250)
            salaryPoint = 3;
        else if(sal<25000)
            salaryPoint = 0;
        
        
        return salaryPoint;
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