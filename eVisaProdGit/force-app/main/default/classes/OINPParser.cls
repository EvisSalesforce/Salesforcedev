global class OINPParser {

	global class Country_of_education {
		global Integer id;
		global String title;
		global String code;
	}

	global String first_name;
	global String last_name;
	global String email;
	global String email_confirmation;
	global String user_note;
	global List<Job_offer> job_offer;
	global Languages languages;
	global List<Educations> educations;
    global String preferred_language;

	global class ENGLISH {
		global String english_test;
		global Skills skills;
	}

	global class Job_title_noc {
		global String id;
		global String title;
		global String noc;
	}

	global class Skills {
		global String listening;
		global String reading;
		global String writing;
		global String speaking;
	}

	global class Educations {
		global String education_level;
		global String name_of_credential;
		global String field_of_study;
		global Country_of_education country_of_education;
		global String canadian_education_institution_type;
		global String canadian_education_institution_location;
		global String canadian_education_experience;
	}

	global class Languages {
		global ENGLISH ENGLISH;
		global FRENCH FRENCH;
	}

	global class FRENCH {
		global String french_test;
		global Skills skills;
	}

	global class Job_offer {
		global Job_title_noc job_title_noc;
		global String currently_working;
		global String salary_amount;
		global String in_demand_occupation;
		global String earnings_history;
		global String experience_over_year;
		global String years_of_related_work_experience;
		global String part_of_strategic_priorities;
		global String company_location_in_on;
		global Job_title_noc cec_noc;
        global String are_you_in_canada;
	}

	
	global static OINPParser parse(String json) {
		return (OINPParser) System.JSON.deserialize(json, OINPParser.class);
	}
}