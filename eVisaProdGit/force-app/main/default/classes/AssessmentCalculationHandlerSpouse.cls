public with sharing class AssessmentCalculationHandlerSpouse {

public static Decimal calculationLanguage(Id SpouseId, Id languageId, Id secondLanguageId){
	Decimal calculationTotal =0;
	
	//language
	List<Language_Test__c> languageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
	                                                                        Already_Taken__c, Expiration_Date__c, Expected_Test_Date__c,
	                                                                        First_Language__c FROM Language_Test__c WHERE Id = : languageId LIMIT 1]);


	if (languageTestValues.size()>0) {
		for(Language_Test__c ltv : languageTestValues) {


			if (ltv.Listening__c >= 4 && ltv.Reading__c >= 3.5 && ltv.Speaking__c >=4 && ltv.Writing__c >=4) {
				calculationTotal = 5;
			}
			else {
				calculationTotal = 0;
			}

			
		}
	}
	return calculationTotal;
}

public static assessment__c calculationLEEE(Id SpouseId, Id le){
	assessment__c assessment = new assessment__c();

	List<Language_Test__c> languageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
	                                                                        Already_Taken__c, Expiration_Date__c, Expected_Test_Date__c,
	                                                                        First_Language__c FROM Language_Test__c WHERE Id = : le LIMIT 1]);
	if(!languageTestValues.isEmpty()) {
		for(Language_Test__c ltv : languageTestValues) {
		Map<Double, Double> myMapPoints = new Map<Double, Double> {1 =>0, 2=>0, 3=>0, 3.5 => 0, 4 => 0, 4.5 => 0, 5 =>1, 5.5=>1, 6=>1, 6.5=>1, 7=>3, 7.5=>3, 8=>3, 8.5=>3, 9=>5, 9.5=>5, 10=>5, 10.5=>5, 11=>5, 11.5=>5, 12=>5, 12.5=>5, 13=>5, 13.5=>5};
	Map<Double, Double> myMapIELTSListening = new Map<Double, Double> { 3.5 => 0, 4 => 0, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5 =>7, 7=>7, 7.5=>8,8=>9, 8.5=>10, 9=>10,10=>10, 10.5 => 10 };
	Map<Double, Double> myMapIELTSReading = new Map<Double, Double> { 3.5 => 4, 4 => 5, 4.5 => 5, 5 =>6, 5.5=>6, 6 =>7, 6.5=>8, 7=>9, 7.5=>9, 8=>10,8.5=>10, 9 => 10, 9.5 => 10, 10 => 10, 10.5 => 10};
	Map<Double, Double> myMapIELTSWriting = new Map<Double, Double> { 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5=>8, 7=>9, 7.5=>10, 8=>10, 8.5=>10, 9=>10, 9.5=>10, 10=>10, 10.5=>10};
	Map<Double, Double> myMapIELTSSpeaking = new Map<Double, Double> { 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5=>8,7=>9, 7.5=>10, 8=>10, 8.5=>10, 9=>10, 9.5=>10, 10=>10, 10.5=>10};

	Map<Double, Double> myMapCELPIP = new Map<Double, Double> { 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>5, 6=>6, 6.5=>6, 7=>7, 7.5=>7, 8=>8, 8.5=>8, 9=>9, 9.5=>9, 10=>10, 10.5=>10, 11=>11, 11.5=>11, 12=>12, 12.5=>12, 13=>13, 13.5=>13};

			if (ltv.Test_Type__c == 'IELTS') {
					Double listening1 = myMapIELTSListening.get(ltv.Listening__c);
					Double reading1 = myMapIELTSReading.get(ltv.Reading__c);
					Double speaking1 = myMapIELTSSpeaking.get(ltv.Speaking__c);
					Double writing1 = myMapIELTSWriting.get(ltv.Writing__c);

					Double listening12 = myMapPoints.get(listening1);
					Double reading12 = myMapPoints.get(reading1);
					Double speaking12 = myMapPoints.get(speaking1);
					Double writing12 = myMapPoints.get(writing1);

					assessment.PCOfficial_language_proficiency__c = listening12+reading12+speaking12+writing12;
				}
				else if(ltv.Test_Type__c == 'CELPIP') {
					Double listening1 = myMapCELPIP.get(ltv.Listening__c);
					Double reading1 = myMapCELPIP.get(ltv.Reading__c);
					Double speaking1 = myMapCELPIP.get(ltv.Speaking__c);
					Double writing1 = myMapCELPIP.get(ltv.Writing__c);

					Double listening12 = myMapPoints.get(listening1);
					Double reading12 = myMapPoints.get(reading1);
					Double speaking12 = myMapPoints.get(speaking1);
					Double writing12 = myMapPoints.get(writing1);

					assessment.PCOfficial_language_proficiency__c = listening12+reading12+speaking12+writing12;
				}
			
		}
	}

	return assessment;
}

public static assessment__c calculationEDEE(Id SpouseId, Id edu){
	assessment__c assessment = new assessment__c();

	List<Education__c> educationValues = new List<Education__c>([SELECT Id, Name, Recordtype.Name, Duration__c, Type_of_education__c,
	                                                             Account__c, Education_Background__c, Institution_Type__c, Completed__c,
	                                                             Major__c, Trade_Certificate__c, Expected_Date_of_Completion__c
	                                                             FROM Education__c WHERE Id = : edu]);

	if(!educationValues.isEmpty()) {
		for (Education__c ed : educationValues) {
				Map<String, Integer> myMapEd = new Map<String, Integer> {'PHD'=>10,'Masters'=> 10,'Two or more Bachelors or Diploma'=> 9,'Bachelor or 3-year Diploma'=> 8,'Two-year Diploma' => 7, 'One-year Diploma'=> 6,'High School'=> 2 };

				assessment.PCLevel_of_education__c = myMapEd.get(ed.Education_Background__c);
			
		}
	}


	return assessment;
}



public static assessment__c calculationWEEE(Id SpouseId){
	assessment__c assessment = new assessment__c();
	Integer totalMonthsWorked = 0 ;
	List<Work_Experience_1__c> workExperienceValues = new List<Work_Experience_1__c>([SELECT Id, Name, Years_of_Experience__c, NOC_Level__c, Employment_hours__c,
	                                                                                  Recordtype.Name FROM Work_Experience_1__c WHERE Contact__c = : SpouseId and Recordtype.Name = 'Spouse - Canadian Experience']);
	Map<String, Integer> myMapWevMonths = new Map<String, Integer> {'1 - 3 months' => 3, '3 - 6 months' => 6, '6 - 9 months' => 9,'1 year' =>12, '2 years' => 24, '3 years' => 36,
					                                                  	'4 years' => 48, '5 years' => 60, '6 years +' => 72 };
	if (!workExperienceValues.isEmpty()) {
		for(Work_Experience_1__c wev : workExperienceValues) {
			totalMonthsWorked = totalMonthsWorked+myMapWevMonths.get(wev.Years_of_Experience__c);
	}
		assessment.PCCanadian_Work_Experience__c = totalMonthsWorked < 12 ? 0 : totalMonthsWorked >= 12 && totalMonthsWorked <24 ? 5 : totalMonthsWorked >=24 && totalMonthsWorked < 36 ? 7 : totalMonthsWorked >=36 && totalMonthsWorked < 48 ? 8 : totalMonthsWorked >= 48 && totalMonthsWorked < 60 ? 9 : totalMonthsWorked >=60 ? 10 : 0;
	}
	return assessment;

}



public static Decimal calculationWE(Id SpouseId){
	Decimal calculationWE = 0;
	//Decimal eeCalculationWE = 0;
	Integer totalMonthsWorked = 0 ;
	List<Work_Experience_1__c> workExperienceValues = new List<Work_Experience_1__c>([SELECT Id, Name, Years_of_Experience__c, NOC_Level__c, Employment_hours__c,
	                                                                                  Recordtype.Name FROM Work_Experience_1__c WHERE Contact__c = : SpouseId and Recordtype.Name = 'Spouse - Canadian Experience']);

	if (!workExperienceValues.isEmpty()) {
		Map<String, Integer> myMapWevMonths = new Map<String, Integer> {'1 - 3 months' => 3, '3 - 6 months' => 6, '6 - 9 months' => 9,'1 year' =>12, '2 years' => 24, '3 years' => 36,
					                                                  	'4 years' => 48, '5 years' => 60, '6 years +' => 72 };
		for(Work_Experience_1__c wev : workExperienceValues) {
			totalMonthsWorked = totalMonthsWorked+myMapWevMonths.get(wev.Years_of_Experience__c);
		}
			
	}
	return calculationWE = totalMonthsWorked >= 12 ? 5 : 0;

	
}




public static Decimal calculationEd(Id SpouseId, Id edu){
	Decimal calculationEd = 0;
	List<Education__c> educationValues = new List<Education__c>([SELECT Id, Name, Account__c, Education_Background__c, Institution_Type__c, Completed__c, Major__c, Trade_Certificate__c, Expected_Date_of_Completion__c,
	                                                             Country_of_Education__c, Recordtype.Name, Type_of_education__c, Duration__c FROM Education__c WHERE Id = : edu and Recordtype.Name = 'Spouse - Canadian Education']);

	if (!educationValues.isEmpty()) {
		for(Education__c educ : educationValues) {
			if(educ.Type_of_education__c == 'Full-time' && (educ.Duration__c == '2 years' || educ.Duration__c == '3 years' || educ.Duration__c == '4 years' || educ.Duration__c == '5 years' || educ.Duration__c == '6 years +')) {
				calculationEd = 5;
			}
		}

	}

	return calculationEd;






}



}