public class BCPNPPanelScreenUtility {
    
    public static String checkRequiredFields(assessment__c assessment)
    {
        String errormsg = '';
        if(assessment.First_Name_Main_Applicant__c == null){
            errormsg += '<br />  '+'First Name is required';
        }
        if(assessment.Last_Name_Main_Applicant__c == null){
            errormsg += '<br />  '+'Last Name is required';
        }
        if(assessment.E_mail_Main_Applicant__c == null){
            errormsg += '<br />  '+'Email is required';
        }
        if(assessment.E_mail_Confirmation__c == null)
        {
            errormsg += '<br />  '+'Email Confirmation is required';
        }
        if(assessment.E_mail_Confirmation__c != null && assessment.E_mail_Main_Applicant__c != null && assessment.E_mail_Confirmation__c !=assessment.E_mail_Main_Applicant__c)
        {
            errormsg += '<br />  '+'Email Confirmation is not same as Email';
        }
        return errormsg;
    }
    
    public static String checkHourlySalary(assessment__c assessment)
    {
        String errormsg = '';
        if(assessment.Hours_per_week__c == null ||assessment.Hours_per_week__c == 0.00){
            errormsg += '<br />  '+'Hours per week is required';
        }
        if(assessment.Type_of_Salary__c == null){
            errormsg += '<br />  '+'Type of Salary is required';
        }
        if(assessment.Salary_Amount__c == null){
            errormsg += '<br />  '+'Salary Amount is required';
        }
        if(assessment.Salary_Amount__c <= 0.00)
            errormsg += '<br />  '+'Salary Amount should be greater than 0';
        if(assessment.Hours_per_week__c >40){
            errormsg += '<br />  '+'Hours per week cannot be greater than 40';
        }
        return errormsg;
    }
    
    
    public static String checkAllField(assessment__c assessment)
    {
        String errorMsg = '';
        if(assessment.First_Name_Main_Applicant__c == null){
            errorMsg += '<br />  '+'First Name is required';
        }
        if(assessment.Last_Name_Main_Applicant__c == null){
            errorMsg += '<br />  '+'Last Name is required';
        }
        if(assessment.E_mail_Main_Applicant__c == null){
            errorMsg += '<br />  '+'Email is required';
        }
        if(assessment.E_mail_Confirmation__c == null)
        {
            errorMsg += '<br />  '+'Email Confirmation is required';
        }
        if(assessment.E_mail_Confirmation__c != null && assessment.E_mail_Main_Applicant__c != null && assessment.E_mail_Confirmation__c !=assessment.E_mail_Main_Applicant__c)
        {
            errorMsg += '<br />  '+'Email Confirmation is not same as Email';
        }
        if(assessment.Please_type_a_occupation_1__c == null)
            errorMsg += '<br />  '+'JOB title/ NOC is required';
        if(assessment.Currently_working_on_this_job_1__c == null)
            errorMsg += '<br />  '+'Are you currently working full-time in this position is required';
        
        errorMsg = String.isNotBlank(checkHourlySalary(assessment)) ? errorMsg += checkHourlySalary(assessment):errorMsg;
        
        /*if(assessment.Directly_Related_Work_Experience__c == null)
            errorMsg += '<br />  '+'Years of related work experience in the past 10 years is required';*/
        if(assessment.At_least_1_year_of_experience_in_Canada__c == null)
            errorMsg += '<br />  '+'Atleast 1 year of experience in Canada is required';
        if(assessment.Company_Location_in_BC__c == null)
            errorMsg += '<br />  '+'Company Location in BC is required';
        if(assessment.Company_Location_in_BC__c != null && assessment.Company_Location_in_BC__c == 'Greater Vancouver' && assessment.employer_5_full_time_employees__c == null)
            errorMsg += '<br />  '+'Does your employer have at least 5 full-time employees is required';
        if(assessment.Company_Location_in_BC__c != null && assessment.Company_Location_in_BC__c != 'Greater Vancouver' && assessment.employer_3_full_time_employees__c == null)
            errorMsg += '<br />  '+'Does your employer have at least 3 full-time employees is required';
        if(assessment.Education_Level__c == null)
            errorMsg += '<br />  '+'Education level is required';
        if(String.isBlank(assessment.Name_of_diploma1__c))
            errorMsg += '<br />  '+'Credential 1 is required';
        if(assessment.Country_of_studies__c == null)
            errorMsg += '<br />  '+'Country of Education is required';
        if(assessment.Education_Credential_Assessment__c == null)
            errorMsg += '<br />  '+'Have you obtained any Education Credential Assessment for this education is required';
        if(assessment.Trade_Certification_in_Canada__c == null)
            errorMsg += '<br />  '+'Have you successfuly obtained your Trade Certification in Canada is required';
        /*if(assessment.Type_of_educational_institute__c == null)
            errorMsg += '<br />  '+'Institution Type is required';
        if(assessment.Institution_Location__c == null)
            errorMsg += '<br />  '+'Institution Location is required';*/
        if(assessment.Do_you_speak_English_or_French__c == null)
            errorMsg += '<br />  '+'Do you speak English or French is required';
        if(assessment.Do_you_speak_English_or_French__c != null  && assessment.Do_you_speak_English_or_French__c == 'English' && assessment.English_test_type__c == null)
            errorMsg += '<br />  '+'English Test Type is required';
        if(assessment.Do_you_speak_English_or_French__c != null  && assessment.Do_you_speak_English_or_French__c == 'English' && assessment.English_test_type__c != null 
           && assessment.English_speaking__c == null && assessment.English_reading__c == null && assessment.English_Writing__c == null && assessment.English_Listening__c == null)
            errorMsg += '<br />  '+'English Test Marks is required';
        if(assessment.Do_you_speak_English_or_French__c != null  && assessment.Do_you_speak_English_or_French__c == 'French' && assessment.Have_you_done_TEF__c == null)
            errorMsg += '<br />  '+'French Test Type is required';
        if(assessment.Do_you_speak_English_or_French__c != null  && assessment.Do_you_speak_English_or_French__c == 'French' && assessment.Have_you_done_TEF__c != null &&
          assessment.French_speaking__c == null && assessment.French_reading__c == null && assessment.French_Writing__c == null && assessment.French_Listening__c == null)
            errorMsg += '<br />  '+'French Test Marks is required';
        if(assessment.Do_you_speak_English_or_French__c != null  && assessment.Do_you_speak_English_or_French__c == 'Both' && (assessment.Have_you_done_TEF__c == null ||
                                                                                                                              assessment.English_test_type__c == null))
            errorMsg += '<br />  '+'English and French Test Type is required';
        if(assessment.Do_you_speak_English_or_French__c != null  && assessment.Do_you_speak_English_or_French__c == 'Both' && assessment.Have_you_done_TEF__c != null &&
           assessment.English_test_type__c != null && ((assessment.French_speaking__c == null && assessment.French_reading__c == null && assessment.French_Writing__c == null && assessment.French_Listening__c == null)
                                                       ||(assessment.English_speaking__c == null && assessment.English_reading__c == null && assessment.English_Writing__c == null && assessment.English_Listening__c == null)))
            errorMsg += '<br />  '+'English and French Test Marks is required';
        return errorMsg;
    }

}