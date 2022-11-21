public class AssessmentScoreCalculatorUtility {
    
    /*
     * @description - Method to get Age from Date of birth 
     * @param birthDate - Birth date in date format
     * @return - years (age)
    */
    public static Integer getAge(Date birthDate){
        if(birthDate == null){
            return 0;
        }
        Integer years = System.today().year() - birthDate.year();
        Integer birthDay = AssessmentScoreCalculatorUtility.getAdjustedBirthDay(birthDate, System.today());
        if(System.today().dayOfYear() < birthDay){
            years -= 1;
        }
        return years;
    }
    
    /*
     * @description - Gets the adjusted date of birth to work around leap year differences.
     * @param birthDate - Birth date in date format
     * @param today - today's date
     * @return - birthday
    */
    public static Integer getAdjustedBirthDay(Date birthDate, Date today){
        Integer birthDay = birthDate.dayOfYear();
        Integer currentDay = today.dayOfYear();
        
        if(Date.isLeapYear(birthDate.year()) && !Date.isLeapYear(today.year()) && birthDay >= 60){
            return birthDay - 1;
        }
        
        if(!Date.isLeapYear(birthDate.year()) && Date.isLeapYear(today.year()) && birthDay >= 60){
            return birthDay + 1;
        }
        return birthDay;
    }

    /*
     * @description - Method to get CLBs in four English areas - Reading, Writing, Speaking, Listening
     * @param testType - IELTS, CLB or No
     * @param area - Reading, Writing, Speaking, Listening
     * @param value - value of Reading, Writing, Speaking, Listening of English
     * @return - CLB score (Integer)
    */
    public static Integer getEnglishCLB(String testType, String area, String value){
        Integer CLB = 0;
        Map<String, Integer> convertCelpipToCLB = new Map<String, Integer>{'Level 12' => 10, 'Level 11' => 10, 'Level 10' => 10, 'Level 9' => 9, 'Level 8'=>8, 'Level 7' => 7,
                															 'Level 6' => 6, 'Level 5' => 5, 'Level 4' => 4, 'Level 3' => 0, 'Level 2' => 0, 'Level 1' => 0};
                                                                                 
        Map<String, Integer> ieltsToCLBReading = new Map<String, Integer>{'2.5' => 0, '3' => 0, '3.5' => 4, '4' => 5, '4.5' => 5, '5' => 6, '5.5' => 6,
            															  	  '6' => 7, '6.5' => 8, '7' => 9, '7.5' => 9, '8' => 10, '8.5' => 10, '9' => 10};
                                                                              
        Map<String, Integer> ieltsToCLBWriting = new Map<String, Integer>{'2.5' => 0, '3' => 0, '3.5' => 0, '4' => 4, '4.5' => 4, '5' => 5, '5.5' => 6,
            															  	  '6' => 7, '6.5' => 8, '7' => 9, '7.5' => 10, '8' => 10, '8.5' => 10, '9' => 10};
                                                                              
        Map<String, Integer> ieltsToCLBListening = new Map<String, Integer>{'2.5' => 0, '3' => 0, '3.5' => 0, '4' => 0, '4.5' => 4, '5' => 5, '5.5' => 6,
            															 		'6' => 7, '6.5' => 7, '7' => 7, '7.5' => 8, '8' => 9, '8.5' => 10, '9' => 10};
                                                                                    
        Map<String, Integer> ieltsToCLBSpeaking = new Map<String, Integer>{'2.5' => 0, '3' => 0, '3.5' => 0, '4' => 4, '4.5' => 4, '5' => 5, '5.5' => 6,
            															   	   '6' => 7, '6.5' => 8, '7' => 9, '7.5' => 10, '8' => 10, '8.5' => 10, '9' => 10};
                                                                                   
        Map<String, Integer> noTestTypetoCLB = new Map<String, Integer>{'Not at all (CLB 1)'=> 1, 'Basic (CLB 3)'=> 3, 'Lower Intermediate (CLB 5)'=>5,
                															'Intermediate (CLB 7)'=> 7, 'Upper Intermediate (CLB 8)' => 8, 'Advanced/Native Proficiency (CLB 9+)'=>9};
        
        if(testType == 'IELTS'){
            if(area == 'Reading'){
                if(ieltsToCLBReading.containsKey(value))
                    CLB = ieltsToCLBReading.get(value);
            }
            if(area == 'Writing'){
                if(ieltsToCLBWriting.containsKey(value))
                    CLB = ieltsToCLBWriting.get(value);
            }
            if(area == 'Speaking'){
                if(ieltsToCLBSpeaking.containsKey(value))
                    CLB = ieltsToCLBSpeaking.get(value);
            }
            if(area == 'Listening'){
                if(ieltsToCLBListening.containsKey(value))
                    CLB = ieltsToCLBListening.get(value);
            }
            
        }
        
        if(testType == 'CELPIP'){
            if(area == 'Reading'){
                if(convertCelpipToCLB.containsKey(value))
                    CLB = convertCelpipToCLB.get(value);
            }
            if(area == 'Writing'){
                if(convertCelpipToCLB.containsKey(value))
                    CLB = convertCelpipToCLB.get(value);
            }
            if(area == 'Speaking'){
                if(convertCelpipToCLB.containsKey(value))
                    CLB = convertCelpipToCLB.get(value);
            }
            if(area == 'Listening'){
                if(convertCelpipToCLB.containsKey(value))
                    CLB = convertCelpipToCLB.get(value);
            }
        }
        
        if(testType == 'No'){
            if(area == 'Reading'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            if(area == 'Writing'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            if(area == 'Speaking'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            if(area == 'Listening'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
        }
        return CLB;
    }
    
    /*
     * @description - Method to get CLBs in four French areas - Reading, Writing, Speaking, Listening
     * @param testType - TEF, TCF or No
     * @param area - Reading, Writing, Speaking, Listening
     * @param value - value of Reading, Writing, Speaking, Listening of French
     * @return - CLB score (Integer)
    */
    public static Integer getFrenchCLB(String testType, String area, String value){
        Map<String, Integer> tefToCLBRead = new Map<String, Integer>{'121-150(TEF)' => 4, '151-180(TEF)' => 5, '181-206(TEF)' => 6, '207-232(TEF)' => 7, '233-247(TEF)' => 8,
														'248-262(TEF)' => 9, '263-277(TEF)' => 10};


		Map<String, Integer> tefToCLBWrite = new Map<String, Integer>{'181-225(TEF)' => 4, '226-270(TEF)' => 5, '271-309(TEF)' => 6, '310-348(TEF)' => 7, '349-370(TEF)' => 8,
														'371-392(TEF)' => 9, '393-415(TEF)' => 10};
														

		Map<String, Integer> tefToCLBListen = new Map<String, Integer>{'145-180(TEF)' => 4, '181-216(TEF)' => 5, '217-248(TEF)' => 6, '249-279(TEF)' => 7, '280-297(TEF)' => 8,
														'298-315(TEF)' => 9, '316-333(TEF)' => 10};
														
		Map<String, Integer> tefToCLBSpeak = new Map<String, Integer>{'181-225(TEF)' => 4, '226-270(TEF)' => 5, '271-309(TEF)' => 6, '310-348(TEF)' => 7, '349-370(TEF)' => 8,
														'371-392(TEF)' => 9, '393-415(TEF)' => 10};
                                                            
        Map<String, Integer> tCfToCLBRead = new Map<String, Integer>{'342-374(TCF)' => 4, '375-405(TCF)' => 5, '406-452(TCF)' => 6, '453-498(TCF)' => 7, '499-523(TCF)' => 8,
														'524-548(TCF)' => 9, '549-699(TCF)' => 10};
		
 		Map<String, Integer> tCfToCLBWrite = new Map<String, Integer>{'4-5(TCF)' => 4, '6(TCF)' => 5, '7-9(TCF)' => 6, '10-11(TCF)' => 7, '12-13(TCF)' => 8,
														'14-15(TCF)' => 9, '16-20(TCF)' => 10};

		Map<String, Integer> tCfToCLBListen = new Map<String, Integer>{'331-368(TCF)' => 4, '369-397(TCF)' => 5, '398-457(TCF)' => 6, '458-502(TCF)' => 7, '503-522(TCF)' => 8,
														'523-548(TCF)' => 9, '549-699(TCF)' => 10};

        Map<String, Integer> tCfToCLBSpeak = new Map<String, Integer>{'4-5(TCF)' => 4, '6(TCF)' => 5, '7-9(TCF)' => 6, '10-11(TCF)' => 7, '12-13(TCF)' => 8,
														'14-15(TCF)' => 9, '16-20(TCF)' => 10}; 
                                                            
        Map<String, Integer> noTestTypetoCLB = new Map<String, Integer>{'Advanced/ Native Proficiency (CLB 9+)'=> 9, 'Upper Intermediate (CLB 8)'=>8,
            															'Intermediate II (CLB 7)'=>7, 'Intermediate I (CLB 6)'=>6, 'Lower Intermediate (CLB 5)'=>5,
            															'Basic (CLB 4)'=>4};
        Integer CLB = 0;
        
        if(testType == 'TEF'){
            if(area == 'Reading'){
                if(tefToCLBRead.containsKey(value))
                    CLB = tefToCLBRead.get(value);
            }
            if(area == 'Writing'){
                if(tefToCLBWrite.containsKey(value))
                    CLB = tefToCLBWrite.get(value);
            }
            if(area == 'Speaking'){
                if(tefToCLBSpeak.containsKey(value))
                    CLB = tefToCLBSpeak.get(value);
            }
            if(area == 'Listening'){
                if(tefToCLBListen.containsKey(value))
                    CLB = tefToCLBListen.get(value);
            }
            
        }
        
        if(testType == 'TCF'){
            if(area == 'Reading'){
                if(tCfToCLBRead.containsKey(value))
                    CLB = tCfToCLBRead.get(value);
            }
            if(area == 'Writing'){
                if(tCfToCLBWrite.containsKey(value))
                    CLB = tCfToCLBWrite.get(value);
            }
            if(area == 'Speaking'){
                if(tCfToCLBSpeak.containsKey(value))
                    CLB = tCfToCLBSpeak.get(value);
            }
            if(area == 'Listening'){
                if(tCfToCLBListen.containsKey(value))
                    CLB = tCfToCLBListen.get(value);
            }
            
        }
        
        if(testType == 'No'){
            if(area == 'Reading'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            if(area == 'Writing'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            if(area == 'Speaking'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            if(area == 'Listening'){
                if(noTestTypetoCLB.containsKey(value))
                    CLB = noTestTypetoCLB.get(value);
            }
            
        }
        return CLB;
    }
    
    /*
     * @description - Method to get First Language Point FSW for - MAIN APPLICANT 
     * @param isFirstLanguage - To know the the language is either first or second
     * @param CLB - CLB of Language area
     * @return - return FSW points for 
    */
    public static Integer getLanguagePointsFSW(Boolean isFirstLanguage, Integer CLB){
        Integer points = 0;
        Map<Integer, Integer> firstpointsCLBFSW = new Map<Integer, Integer>{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 4,
            																	8 => 5, 9 => 6, 10 => 6};
                                                                                    
        Map<Integer, Integer> secondPointsCLBFSW = new Map<Integer, Integer>{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 1, 6 => 1, 7 => 1,
            																	8 => 1, 9 => 1, 10 => 1};
        if(isFirstLanguage){
            if(firstpointsCLBFSW.containsKey(CLB))
                points = firstpointsCLBFSW.get(CLB);
        }
        else{
            if(secondPointsCLBFSW.containsKey(CLB))
                points = secondPointsCLBFSW.get(CLB);
        }
        return points;
    }
    
    /*
     * @description - Method to get First Language Point EE for - MAIN APPLICANT 
     * @param isFirstLanguage - To know the the language is either first or second
     * @param isSpousePresent - To know if applicant has spouse or not
     * @param CLB - CLB of Language area
     * @return - return EE points for 
    */
    public static Integer getLanguagePointsEE(Boolean isFirstLanguage, Boolean isSpousePresent, Integer CLB){
        Map<Integer, Integer> firstpointsCLBWithOutSpouseEE = new Map<Integer, Integer>{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 6, 5 => 6, 6 => 9, 7 => 17,
            																	   8 => 23, 9 => 31, 10 => 34}; 
                                                                                       
        Map<Integer, Integer> firstpointsCLBWithSpouseEE = new Map<Integer, Integer>{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 6, 5 => 6, 6 => 8, 7 => 16,
            																	8 => 22, 9 => 29, 10 => 32};
                                                                                    
        Map<Integer, Integer> secondPointsCLBEE = new Map<Integer, Integer>{1 => 0, 2 => 0, 3 =>0, 4 => 0, 5 => 1, 6 => 1, 7 => 3, 8 => 3, 9 => 6, 10 => 6};
        Integer points = 0;
        if(isSpousePresent){
            if(isFirstLanguage){
                if(firstpointsCLBWithSpouseEE.containsKey(CLB))
                    points =  firstpointsCLBWithSpouseEE.get(CLB);
            }
            else{
                if(secondPointsCLBEE.containsKey(CLB))
                    points =  secondPointsCLBEE.get(CLB);
            }
        }
        else{
            if(isFirstLanguage){
                if(firstpointsCLBWithOutSpouseEE.containsKey(CLB))
                    points =  firstpointsCLBWithOutSpouseEE.get(CLB);
            }
            else{
                if(secondPointsCLBEE.containsKey(CLB))
                    points =  secondPointsCLBEE.get(CLB);
            }
        }
        return points;
    }
    
    /*
     * @description - Method to get First Language Point EE for - MAIN APPLICANT 
     * @param CLB - CLB of Language area
     * @return - return EE points for 
    */
    public static Integer getLanguagePointsSpouse(Integer CLB){
        Integer points = 0;
        Map<Double, Integer> enPointsSpouse = new Map<Double, Integer>{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 1, 6 => 1, 7 => 3,
            																	8 => 3, 9 => 5, 10 => 5};
        if(enPointsSpouse.containsKey(CLB)){
            points = enPointsSpouse.get(CLB);
        }                                                                           
        
        return points;
    }
}