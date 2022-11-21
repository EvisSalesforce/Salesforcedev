// Class to parse JSON of Assessment
global class AssessmentParseJSON{
	public cls_info info;
	public cls_other other;
	public cls_languages[] languages;
	public cls_educations[] educations;
	public cls_works[] works;
	global class cls_info {
		public String first_name;	//Farshad
		public String last_name;	//Ajdar
		public String email;	//farshadajdar@gmail.com
		public String dob;	//05 October 1984
		public String nationality;	//Iranian
		public String country;
		public String city;	//Tehran
		public String marital_status;	//Married / Common-law Relationship
		public String spouse_citizen;	//Yes
		public String spouse_first_name;	//My
		public String spouse_last_name;	//Wife
		public String spouse_dob;	//01 January 1985
        public String spouse_email; // Field Added
		public String spouse_children;	//No
		public String number_of_children;
		public String ChildName1;
		public String ChildName2;
		public String ChildName3;
		public String ChildName4;
		public String ChildName5;
		public String ChildName6;
		public String ChildBirth1;
		public String ChildBirth2;
		public String ChildBirth3;
		public String ChildBirth4;
		public String ChildBirth5;
		public String ChildBirth6;
	}

	global class cls_other {
		public String relatives_in_canada;	//Brother or Sister
		public String funds_available;	//0 to 9,999
		public String employer_location;	//Alberta (AB) Mapping not found.
		public String how_hear_about_us;	//evisaimmigration.com
		public String job_offer;	//Yes // Mapping not found.
		public String note;	//some spe
		public String province_certificate_qualification;	//Yes
		public String temporary_foreign_worker;	//Yes
		public String lmia;	//Yes
        public String Noc_received; //00; 0,A,B; Not sure
        public String Provincial_Nomination; //Yes
	}
    global class cls_languages {
        public String applicant_or_spouse;	//Main Applicant
        public String language_name;	//ENGLISH
        public String speak_this_language;	//No
        public String main_language;
        public String test;
        public cls_skills[] skills;
	}


	global class cls_skills {
		public String listening;
		public String reading;
		public String writing;
		public String speaking;
		
	}
	global class cls_educations {
		public String applicant_or_spouse;	//Main Applicant
		public String education_level;	//2 or more Degrees or Diplomas with at least one being 3+ years
		public String name_of_credential;	//Cred
		public String country_of_education;	//Iran (Islamic Republic of)
		public String canadian_education_institution_type; // Public
		public String canadian_education_completion_date;	//July 2021
        public String Post_secondaries_in_Canada; // Added field (Yes/No field)
        public String Post_secondary_studies; //Field Added
	}

	global class cls_works {
		public String applicant_or_spouse;	//Main Applicant
		public String job_title;	//Web designers and developers(Need Noc Details)
		public String years_of_experience;	//3 months or more, but less than 6 months
		public String location;	//In Canada
		public String canadian_experience_province;	//British Columbia (BC)
		public String canadian_experience_currently_working;	//Yes
		public String canadian_experience_start_date;	//February 2020
		public String canadian_experience_end_date;	//July 2021
	}
	
}