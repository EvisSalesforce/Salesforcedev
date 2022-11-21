public class OINPPanelScreenUtility {
    
    public static String checkAllField(assessment__c assessment)
    {
        String errorMsg = '';
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
        /*if(assessment.Please_type_a_occupation_1__c == null)
        {
            errorMsg += '<br />  '+'JOB title/ NOC is required';
        }
        if(assessment.Currently_working_on_this_job_1__c == null)
        {
            errorMsg += '<br />  '+'Are you currently working full-time in this position? is required';
        }
        if(assessment.Education_Level_OINP__c == null)
        {
            errorMsg += '<br />  '+'Education Level is required';
        }
        if(assessment.Name_of_diploma1__c == null)
        {
            errorMsg += '<br />  '+'Name of Credential 1 is required';
        }
        if(assessment.Country_of_studies__c == null)
        {
            errorMsg += '<br />  '+'Country of Education is required';
        }
        if(assessment.Field_of_Study__c == null)
        {
            errorMsg += '<br />  '+'Field of study is required';
        }*/
        return errorMsg;
    }
    
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
    
    
}