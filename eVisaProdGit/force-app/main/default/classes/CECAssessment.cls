public with sharing class CECAssessment {
public static assessment__c CECAssessmentCalculation(Id accountId, Id languageId, Id workExperienceId, assessment__c a) {
	assessment__c assessment = new assessment__c();
	//WORK EXPERIENCE
    /*Needed fields:
        Employment_hours__c , NOC_Level__c , Years_of_Experience__c , RecordType.name = 'Main Applicant - Canadian Experience'
    */
    String NOC = '';
	if (accountId != null) {
		List<Work_Experience_1__c> workExperienceValues = new List<Work_Experience_1__c>([SELECT Id, Name, Employment_hours__c, Years_of_Experience__c, NOC_Level__c,
		                                                                                  RecordtypeId, RecordType.name, Start_Date__c, End_Date__c
		                                                                                  FROM Work_Experience_1__c
		                                                                                  WHERE Account__c = : accountId
		                                                                                             AND Employment_hours__c = 'Full-time'
		                                                                                                                       AND (NOC_Level__c = '0' OR NOC_Level__c = 'A' OR NOC_Level__c = 'B')
		                                                                                                                       AND RecordType.name = 'Main Applicant - Canadian Experience' LIMIT 1]);
		// System.debug('workExperienceValues : '+workExperienceValues);
		if (workExperienceValues.size() > 0) {
			for (Work_Experience_1__c woe : workExperienceValues) {
				//Find difference between dates TODAY and START DAY
				Integer dateDif = Integer.valueOf(Date.today().monthsBetween(woe.End_Date__c)/12)* -1;

				if ( dateDif <=3 ) {
					assessment.At_least_1_year_of_Work_Experience__c = true; 
                    NOC =  woe.NOC_Level__c;     
				}
			}

		}
		//else {
		//	assessment.At_least_1_year_of_Work_Experience__c = false;  
		//}
	}

    //ACCOUNT
    /*
    NEEDED FIELDS CurrentVisaStatus__c
    */
    List<Account> accountValues = new List<Account>([SELECT Id, Name, Calculated_Age__c, CurrentVisaStatus__c 
                                                        FROM Account 
                                                        WHERE Id = : accountId
                                                        AND (CurrentVisaStatus__c = 'WorkVisa' OR CurrentVisaStatus__c = 'Permanent Resident' OR CurrentVisaStatus__c = 'Student and Work Visa') LIMIT 1]);

        if (accountValues.size() > 0) {
            assessment.Visa_Criteria__c = true;
        }
       // else {
           
            
           // a.addError('The field Current Visa Status is null or the value is different that the options: WorkVisa, Permanent Resident ou Student and Work Visa : https://evisa--dev1.lightning.force.com/lightning/r/Account/'+accountId+'/view',false);
           
      //  }


    //LENGUAGE
    List<Language_Test__c> languageTestValues = new List<Language_Test__c>([SELECT Id, Name, Test_Type__c, Account__c, Listening__c, Reading__c, Speaking__c, Writing__c,
	                                                                        Expiration_Date__c, Expected_Test_Date__c, Already_Taken__c,
	                                                                        First_Language__c 
                                                                            FROM Language_Test__c 
                                                                            WHERE Id = : languageId 
                                                                            AND Already_Taken__c = TRUE LIMIT 1]);
    
    if (languageTestValues.size() > 0 ) {
        for (Language_Test__c ltv : languageTestValues) {
            if (ltv.Expiration_Date__c > Date.today()) {
                Decimal CLBFinal = 0;

                if (ltv.Test_Type__c == 'CELPIP') {
                    if (ltv.Listening__c >= 7 && ltv.Reading__c >= 7 && ltv.Speaking__c>= 7 && ltv.Writing__c>= 7) {
                        CLBFinal = 7;
                    }
                    else if(ltv.Listening__c >= 5 && ltv.Reading__c >= 5 && ltv.Speaking__c>= 5 && ltv.Writing__c>= 5){
                        CLBFinal = 5;
                    }
                                       
                }
                else if (ltv.Test_Type__c == 'IELTS'){
                    if (ltv.Listening__c >= 6 && ltv.Reading__c >= 6 && ltv.Speaking__c>= 6 && ltv.Writing__c>= 6) {
                        CLBFinal = 7;
                    }
                    else if(ltv.Listening__c >= 5 && ltv.Reading__c >= 4 && ltv.Speaking__c>= 5 && ltv.Writing__c>= 5){
                        CLBFinal = 5;
                    }
                }

                if (NOC == '0' || NOC == 'A' && CLBFinal == 7) {
                    assessment.Meet_the_language_criteria__c = true;
                }
                else if (NOC == 'B' && CLBFinal == 5 ) {
                    assessment.Meet_the_language_criteria__c = true;
                }
            }
        }
    }

	return assessment;
}
}