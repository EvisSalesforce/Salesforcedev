public with sharing class AssessmentTriggerHandler extends TriggerHandler {
private List<assessment__c> newAssessmentList;
private Map<Id, assessment__c> newAssessmentMap;
private Map<Id, assessment__c> oldAssessmentMap;



public AssessmentTriggerHandler() {
	this.newAssessmentList = (List<assessment__c>) Trigger.new;
	this.newAssessmentMap = (Map<Id, assessment__c>) Trigger.newMap;
	this.oldAssessmentMap = (Map<Id, assessment__c>) Trigger.oldMap;

}

protected override void beforeInsert(){


	for (assessment__c a :  newAssessmentList) {
		


		//NEW CEC
		assessment__c assessmentReturnCEC = CECAssessment.CECAssessmentCalculation(a.Account__c, a.Select_Language_Test__c, a.Work_Experience_1__c, a);
		a.At_least_1_year_of_Work_Experience__c = assessmentReturnCEC.At_least_1_year_of_Work_Experience__c;
		a.Visa_Criteria__c = assessmentReturnCEC.Visa_Criteria__c;
		a.Meet_the_language_criteria__c = assessmentReturnCEC.Meet_the_language_criteria__c;

		//NEW FSW
		assessment__c assessmentReturnFSW = FSWAssessment.FSWAssessmentCalculation(a.Account__c, a.Select_Language_Test__c, a.Second_Language_Test__c, a.Work_Experience_1__c, a.Select_Education__c, a);
		a.Age__c=assessmentReturnFSW.Age__c;
		a.Education__c = assessmentReturnFSW.Education__c;
		a.Experience__c = assessmentReturnFSW.Experience__c;
		a.First_Language__c =assessmentReturnFSW.First_Language__c;
		a.Second_Language__c = assessmentReturnFSW.Second_Language__c;
		



		//NEW EE
		assessment__c assessmentReturnEE = EEAssessment.EEAssessmentCalculation(a.Account__c, a.Select_Language_Test__c, a.Second_Language_Test__c, a.Select_Education__c, a.Work_Experience_1__c, a.Spouse_Partner__c, a.Select_Language_Test_P__c, a.Second_Language_Test_P__c, a.Select_Education_P__c, a.Select_the_Work_Experience_P__c, a);
		a.CAge__c = assessmentReturnEE.CAge__c;
		a.CLevel_of_education__c = assessmentReturnEE.CLevel_of_education__c;
		a.COfficial_languages_proficiency__c = assessmentReturnEE.COfficial_languages_proficiency__c;
		a.Second_Language_EE__c = assessmentReturnEE.Second_Language_EE__c;
		a.CCanadian_work_experience__c = assessmentReturnEE.CCanadian_work_experience__c;
		a.Education_and_language__c = assessmentReturnEE.Education_and_language__c;
		a.Education_and_Canadian_work__c = assessmentReturnEE.Education_and_Canadian_work__c;
		a.Arranged_employment__c = assessmentReturnEE.Arranged_employment__c;
		a.Foreign_work_and_Canadian_work__c = assessmentReturnEE.Foreign_work_and_Canadian_work__c;
		a.Foreign_work_and_language__c = assessmentReturnEE.Foreign_work_and_language__c;
		a.Post_secondary_education_in_Canada__c = assessmentReturnEE.Post_secondary_education_in_Canada__c;
		a.Siblings_in_Canada__c = assessmentReturnEE.Siblings_in_Canada__c;
		a.French_Additional_Points__c = assessmentReturnEE.French_Additional_Points__c;


		if (a.Spouse_Partner__c!=null) {
			Decimal spouseLanguage;
			Decimal spouseWorkExperience;
			Decimal spouseEducation;
			Decimal atLeast1year;
			Decimal weInCA;
			Decimal relatives;
			Decimal edumain;
			//Express Entry
			assessment__c assessmentReturnSpouseWEEE = AssessmentCalculationHandlerSpouse.calculationWEEE(a.Spouse_Partner__c);
			a.PCCanadian_Work_Experience__c = assessmentReturnSpouseWEEE.PCCanadian_Work_Experience__c;

			assessment__c assessmentReturnSpouseLEEE = AssessmentCalculationHandlerSpouse.calculationLEEE(a.Spouse_Partner__c, a.Select_Language_Test_P__c);
			a.PCOfficial_language_proficiency__c = assessmentReturnSpouseLEEE.PCOfficial_language_proficiency__c;

			assessment__c assessmentReturnSpouseEDEE = AssessmentCalculationHandlerSpouse.calculationEDEE(a.Spouse_Partner__c, a.Select_Education_P__c);
			a.PCLevel_of_education__c = assessmentReturnSpouseEDEE.PCLevel_of_education__c;


			//FSW
			if(a.Select_Language_Test_P__c != null || a.Second_Language_Test__c != null) {
				spouseLanguage = AssessmentCalculationHandlerSpouse.calculationLanguage(a.Spouse_Partner__c, a.Select_Language_Test_P__c, a.Second_Language_Test__c);
			}
			if(a.Select_the_Work_Experience_P__c != null || a.Select_the_Work_Experience_P__c != '') {
				spouseWorkExperience = AssessmentCalculationHandlerSpouse.calculationWE(a.Spouse_Partner__c);
			}
			if(a.Select_Education_P__c != null || a.Select_Education_P__c != '') {
				spouseEducation = AssessmentCalculationHandlerSpouse.calculationEd(a.Spouse_Partner__c, a.Select_Education_P__c);
			}
			if (assessmentReturnFSW.At_least_1_year_of_Work_Experience__c == true) {
				atLeast1year = 5;
			}
			else {
				atLeast1year = 0;
			}
			if (assessmentReturnFSW.Work_In_Canada__c == true) {
				weInCA = 5;
			}
			else {
				weInCA = 0;
			}
			if (assessmentReturnFSW.Relatives_In_Canada__c ==true) {
				relatives = 5;
			}
			else {
				relatives = 0;
			}
			if(assessmentReturnFSW.X2years_Criteria__c==true) {
				edumain = 5;
			}
			else {
				edumain = 0;
			}
			
			spouseLanguage = spouseLanguage == null ? 0 : spouseLanguage;
			spouseWorkExperience = spouseWorkExperience == null ? 0 : spouseWorkExperience;
			spouseEducation = spouseEducation == null ? 0 : spouseEducation;
			atLeast1year = atLeast1year ==null ? 0 : atLeast1year;
			weInCA = weInCA == null ? 0 : weInCA;
			relatives = relatives == null? 0 : relatives;
			edumain = edumain == null ? 0 : edumain;

			Decimal totalAdp = spouseLanguage + spouseWorkExperience + spouseEducation + atLeast1year+weInCA+relatives+edumain;

			if(totalAdp >= 10) {
				a.Adaptability__c = 10;
			}
			else {
				a.Adaptability__c = totalAdp;
			}
		}


		a.CAge__c = a.CAge__c == null ? 0 :a.CAge__c;
		a.CLevel_of_education__c = a.CLevel_of_education__c == null ? 0 :a.CLevel_of_education__c;
		a.COfficial_languages_proficiency__c = a.COfficial_languages_proficiency__c == null ? 0 :a.COfficial_languages_proficiency__c;
		a.Second_Language_EE__c = a.Second_Language_EE__c == null ? 0 :a.Second_Language_EE__c;
		a.CCanadian_work_experience__c = a.CCanadian_work_experience__c == null ? 0 :a.CCanadian_work_experience__c;


		a.Total_EE__c = 0;
		Double coreHuman = a.CAge__c + a.CLevel_of_education__c + a.COfficial_languages_proficiency__c + a.Second_Language_EE__c + a.CCanadian_work_experience__c;
		a.Total_EE__c = coreHuman > 460 ? 460:coreHuman;
		System.debug('Core Human '+a.Total_EE__c );
		/*if (coreHuman > 460) {
			a.Total_EE__c = 460;
		}
		else {
			a.Total_EE__c = coreHuman;
		}*/

		a.PCOfficial_language_proficiency__c = a.PCOfficial_language_proficiency__c == null ? 0 :a.PCOfficial_language_proficiency__c ;
		a.PCLevel_of_education__c = a.PCLevel_of_education__c == null ? 0  :a.PCLevel_of_education__c;
		a.PCCanadian_Work_Experience__c = a.PCCanadian_Work_Experience__c == null ? 0 :a.PCCanadian_Work_Experience__c;

		Double coreHumanSpouse = a.PCOfficial_language_proficiency__c + a.PCLevel_of_education__c + a.PCCanadian_Work_Experience__c;
		a.Total_EE__c = coreHumanSpouse > 40 ? a.Total_EE__c+40:a.Total_EE__c+coreHumanSpouse;
		System.debug('coreHumanSpouse '+a.Total_EE__c );
		/*if (coreHumanSpouse > 40) {
			a.Total_EE__c = a.Total_EE__c+40;
		}
		else {
			a.Total_EE__c = a.Total_EE__c+coreHumanSpouse;
		}*/
		
		a.Education_and_language__c = a.Education_and_language__c == null ? 0 :a.Education_and_language__c ;
		a.Education_and_Canadian_work__c = a.Education_and_Canadian_work__c == null ? 0 :a.Education_and_Canadian_work__c ;
		a.Foreign_work_and_language__c = a.Foreign_work_and_language__c == null ? 0 :a.Foreign_work_and_language__c;
		a.Foreign_work_and_Canadian_work__c = a.Foreign_work_and_Canadian_work__c == null ? 0 :a.Foreign_work_and_Canadian_work__c;

		Double skillCombos = a.Education_and_language__c + a.Education_and_Canadian_work__c + a.Foreign_work_and_language__c + a.Foreign_work_and_Canadian_work__c;
		a.Total_EE__c = skillCombos > 100?a.Total_EE__c+100:a.Total_EE__c+skillCombos;
		System.debug('skillCombos '+a.Total_EE__c );
		/*if (skillCombos > 100) {
			a.Total_EE__c = a.Total_EE__c+100;
		}
		else {
			a.Total_EE__c = a.Total_EE__c+skillCombos;
		}*/

		a.Post_secondary_education_in_Canada__c=a.Post_secondary_education_in_Canada__c == null ? 0 :a.Post_secondary_education_in_Canada__c;
		a.Arranged_employment__c = a.Arranged_employment__c == null ? 0 :a.Arranged_employment__c;
		a.Siblings_in_Canada__c = a.Siblings_in_Canada__c == null ? 0 :a.Siblings_in_Canada__c;
		a.French_Additional_Points__c = a.French_Additional_Points__c ==null ? 0 : a.French_Additional_Points__c;

		Double additionalPoints = a.Post_secondary_education_in_Canada__c + a.Arranged_employment__c + a.Siblings_in_Canada__c + a.French_Additional_Points__c;
		a.Total_EE__c = additionalPoints > 600?a.Total_EE__c+600:a.Total_EE__c+additionalPoints;
		System.debug('additionalPoints '+a.Total_EE__c );
		/*if (additionalPoints > 600) {
			a.Total_EE__c = a.Total_EE__c+600;
		}
		else {
			a.Total_EE__c = a.Total_EE__c+additionalPoints;
		}*/

	}




}



}