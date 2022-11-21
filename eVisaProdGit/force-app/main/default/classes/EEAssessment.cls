public with sharing class EEAssessment {
public static assessment__c EEAssessmentCalculation(Id accountId, Id languageId, Id secondLanguageId,Id educationId, Id workExperienceId, Id partnerId, Id partnerLang, Id partnerSecondLeng, Id partnerEdu, Id partnerWork, assessment__c sourceAssessment) {
	assessment__c assessment = new assessment__c();

	if (accountId != null) {
		List<Account> accountValues = new List<Account>([SELECT Id, Relatives_in_Canada_List__c, Name, Calculated_Age__c, CurrentVisaStatus__c
		                                                 FROM Account
		                                                 WHERE Id = : accountId LIMIT 1]);
		if (accountValues.size() > 0) {
			for (Account a : accountValues) {
				Map<Double, Double> myMapAgeAcc = new Map<Double, Double> {18=>99,19=>105,30=>105,31=>99,32=>94,33=>88,34=>83,35=>77,36=>72,37=>66,38=>61,39=>55,40=>50,41=>39,42=>28,43=>17,44=>6};
				if (a.Calculated_Age__c <=17 || a.Calculated_Age__c >= 45) {
					assessment.CAge__c = 0;
				}
				else if (a.Calculated_Age__c >= 20 && a.Calculated_Age__c <=29) {
					assessment.CAge__c = 110;
				}
				else{
					assessment.CAge__c = myMapAgeAcc.get(a.Calculated_Age__c );
				}

				if (a.Relatives_in_Canada_List__c =='Sister or brother') {
					assessment.Siblings_in_Canada__c = 15;
				}

				if (partnerId != null) {
					Map<Double, Double> myMapAgePart = new Map<Double, Double> {18=>90,19=>95,30=>95,31=>90,32=>85,33=>80,34=>75,35=>70,36=>65,37=>60,38=>55,39=>50,40=>45,41=>35,42=>25,43=>15,44=>5};
					if (a.Calculated_Age__c <=17 || a.Calculated_Age__c >= 45) {
						assessment.CAge__c = 0;
					}
					else if (a.Calculated_Age__c >= 20 && a.Calculated_Age__c <=29) {
						assessment.CAge__c = 100;
					}
					else{
						assessment.CAge__c = myMapAgePart.get(a.Calculated_Age__c );
					}
				}



			}
		}
	}


	//String workResult = '';
	//String weRecordName = '';
	Integer totalMonthsWorked = 0 ;
	Integer totalMonthsWorkedExt = 0;
	if (accountId != null) {
		List<Work_Experience_1__c> workExperienceValues = new List<Work_Experience_1__c>([SELECT Id, Name, Arranged_Employment__c, RecordType.Name, RecordTypeId, Years_of_Experience__c, NOC_Level__c FROM Work_Experience_1__c WHERE Account__c = : accountId]);
		if(workExperienceValues.size() >0) {


			for (Work_Experience_1__c wev : workExperienceValues) {
				//weRecordName = wev.RecordType.Name;

				if (wev.RecordType.Name == 'Main Applicant - Canadian Experience') {

				Map<String, Integer> myMapWevMonths = new Map<String, Integer> {'1 - 3 months' => 3, '3 - 6 months' => 6, '6 - 9 months' => 9,'1 year' =>12, '2 years' => 24, '3 years' => 36,
					                                                  				'4 years' => 48, '5 years' => 60, '6 years +' => 72 };
					totalMonthsWorked = totalMonthsWorked+myMapWevMonths.get(wev.Years_of_Experience__c);

					
					//workResult = wev.Years_of_Experience__c;
					if (partnerId != null) {
						assessment.CCanadian_work_experience__c = totalMonthsWorked >= 0 && totalMonthsWorked <12 ? 0: totalMonthsWorked >=12 && totalMonthsWorked < 24?35: totalMonthsWorked >=24 && totalMonthsWorked < 36?46 : totalMonthsWorked >=36 && totalMonthsWorked < 48?56 : totalMonthsWorked >= 48 && totalMonthsWorked < 60?63 : 70;
					}
					else {
						assessment.CCanadian_work_experience__c = totalMonthsWorked >= 0 && totalMonthsWorked <12 ? 0: totalMonthsWorked >=12 && totalMonthsWorked < 24?40: totalMonthsWorked >=24 && totalMonthsWorked < 36?53 : totalMonthsWorked >=36 && totalMonthsWorked < 48?64 : totalMonthsWorked >= 48 && totalMonthsWorked < 60?72 : 80;
					}

					if (wev.NOC_Level__c == '00' && wev.Arranged_Employment__c == true) {
						assessment.Arranged_employment__c =200;
					}
					else if ((wev.NOC_Level__c == '0' || wev.NOC_Level__c == 'A' ||wev.NOC_Level__c == 'B')&&wev.Arranged_Employment__c ) {
						assessment.Arranged_employment__c =50;
					}

				}
				else {
				Map<String, Integer> myMapWevMonthsExt = new Map<String, Integer> {'1 - 3 months' => 3, '3 - 6 months' => 6, '6 - 9 months' => 9,'1 year' =>12, '2 years' => 24, '3 years' => 36,
					                                                  				'4 years' => 48, '5 years' => 60, '6 years +' => 72 };
				totalMonthsWorkedExt = totalMonthsWorkedExt+myMapWevMonthsExt.get(wev.Years_of_Experience__c);
				}




			}
		}
	}

	String eduResult = '';
	if (educationId != null) {

		List<Education__c> educationValues = new List<Education__c>([SELECT Id, Name, Recordtype.Name, Duration__c, Type_of_education__c, Account__c, Education_Background__c, Institution_Type__c, Completed__c, Major__c, Trade_Certificate__c, Expected_Date_of_Completion__c FROM Education__c WHERE Id = : educationId]);

		if (educationValues.size()>0) {
			for(Education__c ed : educationValues) {
				eduResult= ed.Education_Background__c;
				Map<String, Double> myMapEdu= new Map<String, Double> {'PHD'=>150, 'Masters'=>135, 'Two or more Bachelors or Diploma'=>128, 'Bachelor or 3-year Diploma'=>98, 'One-year Diploma'=>90, 'High School'=>30};
				Map<String, Double> myMapEduWork1= new Map<String, Double> {'PHD'=>25, 'Masters'=>25, 'Two or more Bachelors or Diploma'=>25, 'Bachelor or 3-year Diploma'=>25, 'High School'=>0};
				Map<String, Double> myMapEduWork2= new Map<String, Double> {'PHD'=>50, 'Masters'=>50, 'Two or more Bachelors or Diploma'=>50, 'Bachelor or 3-year Diploma'=>50, 'High School'=>0};
				assessment.CLevel_of_education__c = myMapEdu.get(ed.Education_Background__c);

				if (totalMonthsWorked >=12 && totalMonthsWorked <24) {
					assessment.Education_and_Canadian_work__c = myMapEduWork1.get(ed.Education_Background__c);
				}
				else if(totalMonthsWorked >=24) {
					assessment.Education_and_Canadian_work__c = myMapEduWork2.get(ed.Education_Background__c);
				}

				if (assessment.CLevel_of_education__c == null) {
					assessment.CLevel_of_education__c = 0;
				}

				if (partnerId != null) {
					Map<String, Double> myMapEduP= new Map<String, Double> {'PHD'=>140, 'Masters'=>126, 'Two or more Bachelors or Diploma'=>119, 'Bachelor or 3-year Diploma'=>91, 'One-year Diploma'=>84, 'High School'=>28};
					assessment.CLevel_of_education__c = myMapEduP.get(ed.Education_Background__c);

					if (assessment.CLevel_of_education__c == null) {
						assessment.CLevel_of_education__c = 0;
					}
				}

			}
		}

	}

	List<Education__c> educationValues2 = new List<Education__c>([SELECT Id, Name, Recordtype.Name, Duration__c, Type_of_education__c, Account__c, Education_Background__c, Institution_Type__c, Completed__c, Major__c, Trade_Certificate__c, Expected_Date_of_Completion__c FROM Education__c WHERE Account__c = : accountId 
																	AND Recordtype.Name = 'Main Applicant - Canadian Education']);
	if (educationValues2.size()>0) {
		for (Education__c edux : educationValues2) {
		if (edux.Institution_Type__c == 'Public' || (edux.Institution_Type__c == 'Private' && (edux.Education_Background__c == 'Masters' || edux.Education_Background__c == 'Bachelor or 3-year Diploma'  ))) {
			if(edux.Duration__c == '1 year' ||edux.Duration__c == '2 years' && (edux.Education_Background__c == 'Two-year Diploma' ||edux.Education_Background__c == 'One-year Diploma')){
				assessment.Post_secondary_education_in_Canada__c = 15;
			}
			else if(edux.Duration__c == '3 years' || edux.Duration__c == '4 years' || edux.Duration__c == '5 years' && (edux.Education_Background__c == 'Bachelor or 3-year Diploma' ||edux.Education_Background__c == 'Masters'||edux.Education_Background__c == 'PHD')) {
				assessment.Post_secondary_education_in_Canada__c = 30;
			}

		}

		
		}
	}


	Map<Double, Integer> myMapIELTSListening = new Map<Double, Integer> {1=>0,1.5=>0,2=>0,2.5=>0,3=>0, 3.5 => 0, 4 => 0, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5 =>7, 7=>7, 7.5=>8,8=>9, 8.5=>10, 9=>10,10=>10, 10.5 => 10, 11 => 10, 11.5 => 10, 12 => 10, 12.5 => 10, 13 => 10 };
	Map<Double, Integer> myMapIELTSReading = new Map<Double, Integer> {1=>0,1.5=>0,2=>0,2.5=>0,3=>0, 3.5 => 4, 4 => 5, 4.5 => 5, 5 =>6, 5.5=>6, 6 =>7, 6.5=>8, 7=>9, 7.5=>9, 8=>10,8.5=>10, 9 => 10, 9.5 => 10, 10 => 10, 10.5 => 10, 11 => 10, 11.5 => 10, 12 => 10, 12.5 => 10, 13 => 10 };
	Map<Double, Integer> myMapIELTSWriting = new Map<Double, Integer> {1=>0,1.5=>0,2=>0,2.5=>0,3=>0, 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5=>8, 7=>9, 7.5=>10, 8=>10, 8.5=>10, 9=>10, 9.5=>10, 10=>10, 10.5=>10, 11 => 10, 11.5 => 10, 12 => 10, 12.5 => 10, 13 => 10 };
	Map<Double, Integer> myMapIELTSSpeaking = new Map<Double, Integer> {1=>0,1.5=>0,2=>0,2.5=>0,3=>0, 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>6, 6 =>7, 6.5=>8,7=>9, 7.5=>10, 8=>10, 8.5=>10, 9=>10, 9.5=>10, 10=>10, 10.5=>10, 11 => 10, 11.5 => 10, 12 => 10, 12.5 => 10, 13 => 10 };

	Map<Double, Integer> myMapCELPIP = new Map<Double, Integer> {1=>0,1.5=>0,2=>0,2.5=>0,3=>0, 3.5 => 0, 4 => 4, 4.5 => 4, 5 =>5, 5.5=>5, 6=>6, 6.5=>6, 7=>7, 7.5=>7, 8=>8, 8.5=>8, 9=>9, 9.5=>9, 10=>10, 10.5=>10, 11=>11, 11.5=>11, 12=>12, 12.5=>12, 13=>13, 13.5=>13};
		String firstLanguageType = '';
		Integer listening1 = 0;
		Integer reading1 = 0;
		Integer speaking1 = 0;
		Integer writing1 = 0;
	if (languageId != null) {
		List<Language_Test__c> languageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
		                                                                        Expiration_Date__c, Expected_Test_Date__c,Type_Language__c,
		                                                                        First_Language__c FROM Language_Test__c WHERE Id = : languageId LIMIT 1]);
		List<Work_Experience_1__c> workExperienceValues2 = new List<Work_Experience_1__c>([SELECT Id, Name,RecordType.Name, RecordTypeId,
		                                                                                   Years_of_Experience__c, NOC_Level__c, Account__c
		                                                                                   FROM Work_Experience_1__c
		                                                                                   WHERE Account__c = : accountId]);



		if (languageTestValues.size()>0) {
			for (Language_Test__c ltv : languageTestValues) {


				Map<Double, Integer> myMapPoints = new Map<Double, Integer> {0=>0,1=>0,2=>0,3=>0,4=>6,5=>6,6=>9,7=>17,8=>23,9=>31,10=>34,11=>34,12=>34,13=>34 };
				Map<Double, Integer> myMapPointsP = new Map<Double, Integer> {0=>0,1=>0,2=>0,3=>0,4=>6,5=>6,6=>8,7=>16,8=>22,9=>29,10=>32,11=>32,12=>32,13=>32 };
				firstLanguageType = ltv.Type_Language__c;
				if (ltv.Test_Type__c == 'IELTS') {
					listening1 = myMapIELTSListening.get(ltv.Listening__c);
					reading1 = myMapIELTSReading.get(ltv.Reading__c);
					speaking1 = myMapIELTSSpeaking.get(ltv.Speaking__c);
					writing1 = myMapIELTSWriting.get(ltv.Writing__c);

					Double listening12 = myMapPoints.get(listening1);
					Double reading12 = myMapPoints.get(reading1);
					Double speaking12 = myMapPoints.get(speaking1);
					Double writing12 = myMapPoints.get(writing1);
					System.debug('Eles');
					System.debug(listening12);
					System.debug(reading12);
					System.debug(speaking12);
					System.debug(writing12);

					assessment.COfficial_languages_proficiency__c = listening12+reading12+speaking12+writing12;
				}
				else if(ltv.Test_Type__c == 'CELPIP') {
					listening1 = myMapCELPIP.get(ltv.Listening__c);
					reading1 = myMapCELPIP.get(ltv.Reading__c);
					speaking1 = myMapCELPIP.get(ltv.Speaking__c);
					writing1 = myMapCELPIP.get(ltv.Writing__c);

					Double listening12 = myMapPoints.get(listening1);
					Double reading12 = myMapPoints.get(reading1);
					Double speaking12 = myMapPoints.get(speaking1);
					Double writing12 = myMapPoints.get(writing1);

					assessment.COfficial_languages_proficiency__c = listening12+reading12+speaking12+writing12;
				}
				Map<String, Integer> myMapCLB7 = new Map<String, Integer> {'PHD'=>25,'Masters'=> 25,'Two or more Bachelors or Diploma'=> 25,'Bachelor or 3-year Diploma'=> 25,'One-year Diploma'=> 13,'High School'=> 0};
				Map<String, Integer> myMapCLB9 = new Map<String, Integer> {'PHD'=>50,'Masters'=> 50,'Two or more Bachelors or Diploma'=> 50,'Bachelor or 3-year Diploma'=> 50,'One-year Diploma'=> 25,'High School'=> 0 };

				if(listening1 >= 9 && reading1 >= 9 && speaking1 >=9 && writing1 >=9) {
					assessment.Education_and_language__c =  myMapCLB9.get(eduResult);
				}
				else if (listening1 >= 7 && reading1 >=7 && speaking1 >= 7  && writing1 >=7) {
					assessment.Education_and_language__c =  myMapCLB7.get(eduResult);
				}
				

				if (totalMonthsWorkedExt > 0 ) {
					if(listening1 >= 9 && reading1 >= 9 && speaking1 >=9 && writing1 >=9) {
						assessment.Foreign_work_and_language__c =  totalMonthsWorkedExt >= 0 && totalMonthsWorkedExt <12 ? 0: totalMonthsWorkedExt >=12 && totalMonthsWorked <36?25:50;
					}
					else if (listening1 >= 7 && reading1 >=7 && speaking1 >= 7  && writing1 >=7) {
						assessment.Foreign_work_and_language__c =  totalMonthsWorkedExt >= 0 && totalMonthsWorkedExt <12 ? 0: totalMonthsWorkedExt >=12 && totalMonthsWorkedExt < 36? 13 : 25;
					}

				}


				if (partnerId != null) {
					if (ltv.Test_Type__c == 'IELTS') {
						listening1 = myMapIELTSListening.get(ltv.Listening__c);
						reading1 = myMapIELTSReading.get(ltv.Reading__c);
						speaking1 = myMapIELTSSpeaking.get(ltv.Speaking__c);
						writing1 = myMapIELTSWriting.get(ltv.Writing__c);

						Double listening12 = myMapPointsP.get(listening1);
						Double reading12 = myMapPointsP.get(reading1);
						Double speaking12 = myMapPointsP.get(speaking1);
						Double writing12 = myMapPointsP.get(writing1);

						assessment.COfficial_languages_proficiency__c = listening12+reading12+speaking12+writing12;
					}
					else if(ltv.Test_Type__c == 'CELPIP') {
						listening1 = myMapPointsP.get(ltv.Listening__c);
						reading1 = myMapPointsP.get(ltv.Reading__c);
						speaking1 = myMapPointsP.get(ltv.Speaking__c);
						writing1 = myMapPointsP.get(ltv.Writing__c);


						assessment.COfficial_languages_proficiency__c = listening1+reading1+speaking1+writing1;
					}
				}
			}
		}
		Integer totalYearsOfExp = 0;
		if (workExperienceValues2.size() > 0) {
			Map<String, Integer> totalYearsOfExp2 = new Map<String, Integer> {'1 - 3 months' => 3, '3 - 6 months' => 6, '6 - 9 months' => 9,'1 year' => 12, '2 years' => 24, '3 years' => 36,
				                                                          '4 years' => 48, '5 years' => 60, '6 years +' => 72 };
			for (Work_Experience_1__c wex : workExperienceValues2) {
				if (wex.RecordType.Name != 'Main Applicant - Canadian Experience') {
					totalYearsOfExp += totalYearsOfExp+ totalYearsOfExp2.get(wex.Years_of_Experience__c);
				}
			}
			Integer workResult2 = totalMonthsWorked;


			if (totalYearsOfExp < 12) {
				assessment.Foreign_work_and_language__c = 0;
				assessment.Foreign_work_and_Canadian_work__c =0;
			}
			else if(totalYearsOfExp >= 12 && totalYearsOfExp <= 24) {
				if (listening1 >= 9 && reading1 >=9 && speaking1 >= 9  && writing1 >=9) {
					assessment.Foreign_work_and_language__c = 25;
				}
				else if (listening1 >= 7 && reading1 >=7 && speaking1 >= 7  && writing1 >=7) {
					assessment.Foreign_work_and_language__c = 13;
				}

				if (workResult2 != null && workResult2 >=24) {
					assessment.Foreign_work_and_Canadian_work__c =25;
				}
				else if(workResult2 != null && workResult2 >=12) {
					assessment.Foreign_work_and_Canadian_work__c =13;
				}

			}
			else if(totalYearsOfExp >= 36) {
				if (listening1 >= 9 && reading1 >=9 && speaking1 >= 9  && writing1 >=9) {
					assessment.Foreign_work_and_language__c = 50;
				}
				else if (listening1 >= 7 && reading1 >=7 && speaking1 >= 7  && writing1 >=7) {
					assessment.Foreign_work_and_language__c = 25;
				}

				if (workResult2 != null && workResult2 >=24) {
					assessment.Foreign_work_and_Canadian_work__c =50;
				}
				else if(workResult2 != null && workResult2 >=12) {
					assessment.Foreign_work_and_Canadian_work__c =25;
				}



			}





		}



	}


				String secondLanguageType = '';
				Double slistening1 = 0;
				Double sreading1 = 0;
				Double sspeaking1 = 0;
				Double swriting1 = 0;
	if (secondLanguageId != null) {
		List<Language_Test__c> SecondlanguageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
		                                                                              Expiration_Date__c, Expected_Test_Date__c, Type_Language__c,
		                                                                              First_Language__c FROM Language_Test__c WHERE Id = : secondLanguageId LIMIT 1]);

		if (SecondlanguageTestValues.size()>0) {
			for (Language_Test__c sltv : SecondlanguageTestValues) {

				Map<Double, Double> myMapPoints = new Map<Double, Double> {0=>0,1=>0,2=>0,3=>0,4=>0,5=>1,6=>1,7=>3,8=>3,9=>6,10=>6,11=>6,12=>6,13=>6 };

				secondLanguageType = sltv.Type_Language__c;
				if (sltv.Test_Type__c == 'IELTS') {
					 slistening1 = myMapIELTSListening.get(sltv.Listening__c);
					 sreading1 = myMapIELTSReading.get(sltv.Reading__c);
					 sspeaking1 = myMapIELTSSpeaking.get(sltv.Speaking__c);
					 swriting1 = myMapIELTSWriting.get(sltv.Writing__c);

					Double listening12 = myMapPoints.get(slistening1);
					Double reading12 = myMapPoints.get(sreading1);
					Double speaking12 = myMapPoints.get(sspeaking1);
					Double writing12 = myMapPoints.get(swriting1);

					assessment.Second_Language_EE__c = listening12+reading12+speaking12+writing12;
				}
				else if(sltv.Test_Type__c == 'CELPIP') {
					 slistening1 = myMapCELPIP.get(sltv.Listening__c);
					 sreading1 = myMapCELPIP.get(sltv.Reading__c);
					 sspeaking1 = myMapCELPIP.get(sltv.Speaking__c);
					 swriting1 = myMapCELPIP.get(sltv.Writing__c);

					Double listening12 = myMapPoints.get(slistening1);
					Double reading12 = myMapPoints.get(sreading1);
					Double speaking12 = myMapPoints.get(sspeaking1);
					Double writing12 = myMapPoints.get(swriting1);

					assessment.Second_Language_EE__c = listening12+reading12+speaking12+writing12;
				}


				if (partnerId != null) {
					if (assessment.Second_Language_EE__c > 22) {
						assessment.Second_Language_EE__c = 22;
					}
				}

			}
		}
	}
	if (secondLanguageType == 'French') {
	assessment.French_Additional_Points__c = slistening1 >= 7 && sreading1 >= 7 && sspeaking1 >= 7&&swriting1>=7 && listening1 >= 5 && reading1 >= 5 && speaking1 >= 5&&writing1>=5?30:15;
		
	}
	else if(firstLanguageType == 'French') {
	assessment.French_Additional_Points__c = slistening1 >= 5 && sreading1 >= 5 && sspeaking1 >= 5&&swriting1>=5 && listening1 >= 7 && reading1 >= 7 && speaking1 >= 7&&writing1>=5?30:15;
	}

	return assessment;
}
}