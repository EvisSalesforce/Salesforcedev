public with sharing class FSWAssessment {
public static assessment__c FSWAssessmentCalculation(Id accountId, Id languageId, Id secondLanguageId, Id workExperienceId, Id educationId, assessment__c a) {
	assessment__c assessment = new assessment__c();
	if (accountId != null) {
		List<Account> accountValues = new List<Account>([SELECT Id,Relatives_in_Canada_List__c, Name, Calculated_Age__c, CurrentVisaStatus__c
		                                                 FROM Account
		                                                 WHERE Id = : accountId LIMIT 1]);

		if (accountValues.size() > 0) {
			Integer ageFor = 34;
			for (Account acc : accountValues) {
				if (acc.Calculated_Age__c < 18 || acc.Calculated_Age__c >=47) {
					assessment.Age__c = 0;
				}
				else if(acc.Calculated_Age__c >= 18 && acc.Calculated_Age__c <=34) {
					assessment.Age__c = 12;
				}
				else {
					for (Integer i =12; ageFor<acc.Calculated_Age__c; i-=1) {
						ageFor = ageFor+1;
						System.debug(' I = '+i+' AGE acc = '+acc.Calculated_Age__c+' Age for = '+ageFor);
						assessment.Age__c = i;
					}
				}

				if (acc.Relatives_in_Canada_List__c != 'No relatives' ) {
					assessment.Relatives_In_Canada__c = true;
				}
				else {
					assessment.Relatives_In_Canada__c = false;
				}
				
			}

		}
	}


	if (educationId != null) {
		List<Education__c> educationValues = new List<Education__c>([SELECT Id, Name, Recordtype.Name, Duration__c, Type_of_education__c, Account__c, Education_Background__c, Institution_Type__c, Completed__c, Major__c, Trade_Certificate__c, Expected_Date_of_Completion__c FROM Education__c WHERE Id = : educationId LIMIT 1]);
		if (educationValues.size() > 0) {
			for(Education__c ed : educationValues) {
				Map<String, Integer> myMapEdu = new Map<String, Integer> {'PHD' => 25, 'Masters' => 23, 'Two or more Bachelors or Diploma' => 22, 'Bachelor or 3-year Diploma' => 21, 'Two-year Diploma' => 19, 'One-year Diploma' => 15, 'High School' => 5};
				assessment.Education__c = myMapEdu.get(ed.Education_Background__c);

				if (ed.Type_of_education__c == 'Full-time' && (ed.Duration__c == '2 years' || ed.Duration__c == '3 years' || ed.Duration__c == '4 years' || ed.Duration__c == '5 years' || ed.Duration__c == '6 years +')) {
					assessment.X2years_Criteria__c = true;
				}
				//System.debug('Assessment education '+assessment.Education__c);
			}
		}
	}

	if(accountId != null) {
		List<Work_Experience_1__c> workExperienceValues = new List<Work_Experience_1__c>([SELECT Id, Name, Years_of_Experience__c, Employment_hours__c, NOC_Level__c, RecordType.Name FROM Work_Experience_1__c WHERE Account__c = : accountId]);
		if(workExperienceValues.size() > 0) {
			Integer totalMonthsWorked = 0 ;
			Boolean canadianWork = false;
			
			for (Work_Experience_1__c wev : workExperienceValues) {

				if (wev.NOC_Level__c == '0' || wev.NOC_Level__c == '00' || wev.NOC_Level__c == 'A' || wev.NOC_Level__c == 'B' ) {
					Map<String, Integer> myMapWevMonths = new Map<String, Integer> {'1 - 3 months' => 3, '3 - 6 months' => 6, '6 - 9 months' => 9,'1 year' =>12, '2 years' => 24, '3 years' => 36,
					                                                  '4 years' => 48, '5 years' => 60, '6 years +' => 72 };
					totalMonthsWorked = totalMonthsWorked+myMapWevMonths.get(wev.Years_of_Experience__c);
					if (wev.RecordType.Name == 'Main Applicant - Canadian Experience') {
						canadianWork = true;
					}
					
				}


			}
				assessment.Experience__c  = totalMonthsWorked >= 0 && totalMonthsWorked <12 ? 0: totalMonthsWorked >=12 && totalMonthsWorked < 24?9: totalMonthsWorked >=24 && totalMonthsWorked < 48?11 : totalMonthsWorked >=48 && totalMonthsWorked < 72?13 : totalMonthsWorked >= 72?15 : 0;
				System.debug('FSW assessment.Experience__c'+assessment.Experience__c);
			if (assessment.Experience__c >= 12 && canadianWork ==true) {
				assessment.At_least_1_year_of_Work_Experience__c = true;
				assessment.Work_In_Canada__c = true;
			}

			System.debug('FSW assessment.At_least_1_year_of_Work_Experience__c  '+assessment.At_least_1_year_of_Work_Experience__c );
			System.debug('FSW assessment.At_least_1_year_of_Work_Experience__c  '+assessment.Work_In_Canada__c );
		}
	}

	Map<Double, Double> myMapIELTSListening = new Map<Double, Double> { 3.5 => 0, 4 => 0, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5 =>7, 7=>7, 7.5=>8,8=>9, 8.5=>10, 9=>10,10=>10, 10.5 => 10 };
	Map<Double, Double> myMapIELTSReading = new Map<Double, Double> { 3.5 => 4, 4 => 5, 4.5 => 5, 5 =>6, 5.5=>6, 6 =>7, 6.5=>8, 7=>9, 7.5=>9, 8=>10,8.5=>10, 9 => 10, 9.5 => 10, 10 => 10, 10.5 => 10};
	Map<Double, Double> myMapIELTSWriting = new Map<Double, Double> { 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5=>8, 7=>9, 7.5=>10, 8=>10, 8.5=>10, 9=>10, 9.5=>10, 10=>10, 10.5=>10};
	Map<Double, Double> myMapIELTSSpeaking = new Map<Double, Double> { 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5=>8,7=>9, 7.5=>10, 8=>10, 8.5=>10, 9=>10, 9.5=>10, 10=>10, 10.5=>10};

	Map<Double, Double> myMapCELPIP = new Map<Double, Double> { 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>5, 6=>6, 6.5=>6, 7=>7, 7.5=>7, 8=>8, 8.5=>8, 9=>9, 9.5=>9, 10=>9, 10.5=>9, 11=>9, 11.5=>9, 12=>9, 12.5=>9, 13=>9, 13.5=>9};

//Confirmar logica https://www.canada.ca/en/immigration-refugees-citizenship/services/immigrate-canada/express-entry/eligibility/federal-skilled-workers/six-selection-factors-federal-skilled-workers.html#education
	if (languageId != null) {
		List<Language_Test__c> languageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
		                                                                        Expiration_Date__c, Expected_Test_Date__c,
		                                                                        First_Language__c FROM Language_Test__c WHERE Id = : languageId]);
		if (languageTestValues.size()>0) {
			Double listening1 = 0;
			Double reading1 = 0;
			Double speaking1 = 0;
			Double writing1 = 0;

			for (Language_Test__c ltv : languageTestValues) {
				Map<Double, Double> myMapPoints = new Map<Double, Double> {7=> 4, 8=>5, 9 => 6, 10 => 6, 11 => 6, 12 => 6 };

				if (ltv.Test_Type__c == 'IELTS' && (ltv.Listening__c >= 6 && ltv.Reading__c >= 6 && ltv.Speaking__c >=6 && ltv.Writing__c >=6) ) {

					listening1 = myMapIELTSListening.get(ltv.Listening__c);
					reading1 = myMapIELTSReading.get(ltv.Reading__c);
					speaking1 = myMapIELTSSpeaking.get(ltv.Speaking__c);
					writing1 = myMapIELTSWriting.get(ltv.Writing__c);


					Double listening12 = myMapPoints.get(listening1);
					Double reading12 = myMapPoints.get(reading1);
					Double speaking12 = myMapPoints.get(speaking1);
					Double writing12 = myMapPoints.get(writing1);
					listening12 = listening12 == null?0:listening12;
					reading12 = reading12 == null?0:reading12;
					speaking12 = speaking12 == null?0:speaking12;
					writing12 = writing12 == null?0:writing12;

					assessment.First_Language__c = listening12 + reading12 + speaking12 + writing12;

				}
				else if(ltv.Test_Type__c == 'CELPIP' && (ltv.Listening__c >= 7 && ltv.Reading__c >= 7 && ltv.Speaking__c >=7 && ltv.Writing__c >=7)) {
					 listening1 = myMapCELPIP.get(ltv.Listening__c);
					 reading1 = myMapCELPIP.get(ltv.Reading__c);
					 speaking1 = myMapCELPIP.get(ltv.Speaking__c);
					 writing1 = myMapCELPIP.get(ltv.Writing__c);

					Double listening12 = myMapPoints.get(listening1);
					Double reading12 = myMapPoints.get(reading1);
					Double speaking12 = myMapPoints.get(speaking1);
					Double writing12 = myMapPoints.get(writing1);
					listening12 = listening12 == null?0:listening12;
					reading12 = reading12 == null?0:reading12;
					speaking12 = speaking12 == null?0:speaking12;
					writing12 = writing12 == null?0:writing12;

					

					assessment.First_Language__c = listening12 + reading12 + speaking12 + writing12;

				}
				else {
					assessment.First_Language__c = 0;
					assessment.Experience__c = 0;
					assessment.Education__c = 0;
					assessment.Age__c = 0;
				}

					System.debug('CLB FSW listening '+listening1);
					System.debug('CLB FSW reading '+reading1);
					System.debug('CLB FSW speaking '+speaking1);
					System.debug('CLB FSW writing '+writing1);

			}
		}



	}
	else {
		assessment.First_Language__c = 0;
		assessment.Experience__c = 0;
		assessment.Education__c = 0;
		assessment.Age__c = 0;
	}

	if (secondLanguageId != null) {
		List<Language_Test__c> SecondlanguageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
		                                                                              Expiration_Date__c, Expected_Test_Date__c,
		                                                                              First_Language__c FROM Language_Test__c WHERE Id = : secondLanguageId ]);

		if (SecondlanguageTestValues.size() > 0 || assessment.First_Language__c != 0) {
			for (Language_Test__c ltv2 : SecondlanguageTestValues) {

				if (ltv2.Test_Type__c == 'CELPIP') {
					Double listening = myMapCELPIP.get(ltv2.Listening__c);
					Double reading = myMapCELPIP.get(ltv2.Reading__c);
					Double speaking = myMapCELPIP.get(ltv2.Speaking__c);
					Double writing = myMapCELPIP.get(ltv2.Writing__c);

					if (listening >= 5 && reading >= 5 && speaking >= 5 && writing>= 5) {
						assessment.Second_Language__c = 4;
					}
					else {
						assessment.Second_Language__c = 0;
					}

				}
				else if (ltv2.Test_Type__c == 'IELTS') {
					Double listening = myMapIELTSListening.get(ltv2.Listening__c);
					Double reading = myMapIELTSReading.get(ltv2.Reading__c);
					Double speaking = myMapIELTSSpeaking.get(ltv2.Speaking__c);
					Double writing = myMapIELTSWriting.get(ltv2.Writing__c);

					if (listening >= 5 && reading >= 5 && speaking >= 5 && writing>= 5) {
						assessment.Second_Language__c = 4;
					}
					else {
						assessment.Second_Language__c = 0;
					}
				}

			}
		}
		else {
			assessment.Second_Language__c = 0;
		}
	}


	return assessment;
}
}