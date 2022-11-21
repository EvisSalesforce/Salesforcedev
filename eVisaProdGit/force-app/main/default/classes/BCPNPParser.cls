global class BCPNPParser {

	global class Country_of_education {
		global Integer id;
		global String title;
		global String code;
	}

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
		global Country_of_education country_of_education;
		global String obtained_credential_assessment;
		global String obtained_trade_certification_in_canada;
		global String canadian_education_institution_type;
		global String canadian_education_institution_location;
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
		global String years_of_experience;
		global String type_of_salary;
		global Integer salary_amount;
		global Integer hours_per_week;
		global String years_of_related_work_experience;
		global String a_year_experience_canada;
        global String are_you_in_canada;
		global String company_location_in_bc;
		global String employer_full_time_employees;
	}

	global String first_name;
	global String last_name;
	global String email;
	global String email_confirmation;
	global String how_hear_about_us;
    global String preferred_language;
	global String user_note;
	global List<Job_offer> job_offer;
	global Languages languages;
	global List<Educations> educations;

	
	global static BCPNPParser parse(String json) {
		return (BCPNPParser) System.JSON.deserialize(json, BCPNPParser.class);
	}
}