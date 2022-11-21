public class AssessmentPanelScreenUtility {
    
    // Utility Method to get Picklist values of a field
    public static list<SelectOption> getPicklistValues(String sObjectName, String fld){
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', '--None--'));
        // Get the object type of the SObject.
        Schema.SObjectType objType  = Schema.getGlobalDescribe().get(sObjectName);
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();       
        // Get a map of fields for the SObject
        map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap(); 
        // Get the list of picklist values for this field.
        list<Schema.PicklistEntry> values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a : values)
        { 
            options.add(new SelectOption(a.getValue(), a.getLabel())); 
        }
        return options;
    } 
    
    // Utility method to set Assessment__c object's Language Test - Speak/Read/Write/Listen picklist values
    public static list<SelectOption> setPicklistValues(list<SelectOption> options, String controllingFieldVal){
        list<SelectOption> SelectedOptions = new list<SelectOption>();
        if(controllingFieldVal == 'CELPIP'){
            SelectedOptions.add(new SelectOption('', '--None--'));
            System.debug('CELPIP block');
            for(SelectOption sp : options){
                if(sp.getValue().startsWith('Level')){
                    System.debug('celpip block val=> ' +sp.getLabel());
                    SelectedOptions.add(new SelectOption(sp.getValue(), sp.getLabel()));
                    //System.debug('CELPIP block =>'+ sp.getLabel());
                }
            }
        }
        
        else if(controllingFieldVal == 'No'){
            SelectedOptions.add(new SelectOption('', '--None--'));
            System.debug('no Block');
            for(SelectOption sp : options){
                if(sp.getValue().endsWith(')')){
                    SelectedOptions.add(new SelectOption(sp.getValue(), sp.getLabel()));
                }
            }
        }
        
        else if(controllingFieldVal != '--None--' && controllingFieldVal != Null){
            System.debug('None Block(IELTS)');
            SelectedOptions.add(new SelectOption('', '--None--'));
            for(SelectOption sp : options){
                if(!sp.getValue().endsWith(')') && !sp.getValue().startsWith('Level') && sp.getValue() <> ''){
                    SelectedOptions.add(new SelectOption(sp.getValue(), sp.getLabel()));
                }
            }
        }
        return SelectedOptions;
    }
    
    //Utility Method to convert date into String
    public static String convertToString(Date d){
        if(d == null){
            return null;
        }
        else{
            String str = d.format();
            return str;
        }
    }
    
    //Utility Method to convert String into Date
    public static Date convertToDate(String str){
        if(str == null || str == ''){
            return null;
        }
        else{
            try{
                Date d = Date.parse(str);
                return d;
            }
            catch(Exception ex){
                System.debug('Exception occured: '+ex.getMessage());
                return null;
            }
        }
    }
    
    // Utility method for required field validation on Profile Tab
    public static String checkRequiredFields(String maritalStatus , assessment__c assessment){
        String errormsg = '';
        
        if(assessment.First_Name_Main_Applicant__c == null){
            errormsg += '<br />  '+'First Name(Main Applicant) is required';
        }
        if(assessment.Last_Name_Main_Applicant__c == null){
            errormsg += '<br />  '+'Last Name(Main Applicant) is required';
        }
        if(assessment.E_mail_Main_Applicant__c == null){
            errormsg += '<br />  '+'Email(Main Applicant) is required';
        }
        if(assessment.DOB_Main_Applicant__c == null){
            errormsg += '<br />  '+'DOB(Main Applicant) is required';
        }
        
        
        
        if(maritalStatus != null && (maritalStatus == 'Married' || maritalStatus == 'Common-law')){
            if(assessment.First_Name_Spouse__c == null){
                errormsg += '<br />  '+'First Name(Spouse) is required';
            }
            if(assessment.Last_Name_Spouse__c == null){
                errormsg += '<br />  '+'Last Name(Spouse) is required';
            }
            if(assessment.E_mail_Spouse__c == null){
                errormsg += '<br />  '+'Email(Spouse) is required';
            }
            if(assessment.DOB_Spouse__c == null){
                errormsg += '<br />  '+'DOB(Spouse) is required';
            }            
        }
        System.debug('errormsg:=>' +errormsg);
        return errormsg;
    }
    
    // Utility method for required field validation on Consultation Tab screen 2
    public static String checkRequiredFieldsCSTab(Consultation_Sheet__c csheetObj){
        string errormsg = '';
        if(csheetObj.Account__c == null){
            errormsg += '<br />  '+'Account is required';
        }
        if(csheetObj.Opportunity__c == null){
            errormsg += '<br />  '+'Opportunity is required';
        }
        return errormsg;
    }
    
    // Utlity Method to get Dependent French Read/Write/Listen/Speak value according to french test type - TEF/TCF/No
    public static list<SelectOption> setFrenchPicklistValues(String sObjectName, String fld, String controllingFieldVal){
        list<SelectOption> SelectedOptions = new list<SelectOption>();
        list<SelectOption> options = AssessmentPanelScreenUtility.getPicklistValues(sObjectName, fld);

        if(controllingFieldVal == 'TEF'){
            System.debug('In TEF');
            SelectedOptions.add(new SelectOption('', '--None--'));
            for(SelectOption sp : options){
                if(sp.getValue().contains('TEF')){
                    SelectedOptions.add(new SelectOption(sp.getValue(), sp.getLabel()));
                }
            }
        }
        
        if(controllingFieldVal == 'TCF'){
            System.debug('In TCF');
            SelectedOptions.add(new SelectOption('', '--None--'));
            for(SelectOption sp : options){
                if(sp.getValue().contains('TCF')){
                    SelectedOptions.add(new SelectOption(sp.getValue(), sp.getLabel()));
                }
            }
        }
        
        if(controllingFieldVal == 'No'){
            System.debug('In No');
            SelectedOptions.add(new SelectOption('', '--None--'));
            for(SelectOption sp : options){
                if(!sp.getValue().contains('TEF') && !sp.getValue().contains('TCF') && sp.getLabel() <> '--None--'){
                    System.debug('sp.getValue() :' + sp.getValue());
                    SelectedOptions.add(new SelectOption(sp.getValue(), sp.getLabel()));
                }
            }
        }
        return SelectedOptions;
    }
    
    // Method for validation on Occupation Tab
    public static String checkRequiredOnOccuTab(assessment__c asmt, String workExShow, String workExShowSP){
        String errorMsg = '';
        if(asmt.Duration_1__c == null){
           errorMsg += '<br /> '+'Duration 1 is required' ;
        }
        if(asmt.Location_1__c == null){
            errorMsg += '<br /> '+'Location 1 is required' ;
        }
        
        if(workExShow.contains('2')){
            if(asmt.Duration_2__c == null){
                errorMsg += '<br /> '+'Duration 2 is required' ;  
            }
            
            if(asmt.Location_2__c == null){
                errorMsg += '<br /> '+'Location 2 is required' ;
            }
        }
        
        if(workExShow.contains('3')){
            if(asmt.Duration_3__c == null){
                errorMsg += '<br /> '+'Duration 3 is required' ;  
            }
            
            if(asmt.Location_3__c == null){
                errorMsg += '<br /> '+'Location 3 is required' ;
            }
        }
        
        // Check Required for Spouse's Occupation fields
        if(asmt.spouse_have_any_occupational_experience__c == 'Yes'){
            if(asmt.Duration_1_Spouse__c == null){
                errorMsg += '<br /> '+'Duration 1(Spouse) is required' ;
            }
            if(asmt.Location_1_Spouse__c == null){
                errorMsg += '<br /> '+'Location 1(Spouse) is required' ;
            }
            
            if(workExShowSP.contains('2')){
                if(asmt.Duration_2_Spouse__c == null){
                    errorMsg += '<br /> '+'Duration 2(Spouse) is required' ;
                }
                
                if(asmt.Location_2_Spouse__c == null){
                    errorMsg += '<br /> '+'Location 2(Spouse) is required' ;
                }
            }
            
            if(workExShowSP.contains('3')){
                if(asmt.Duration_3_Spouse__c == null){
                    errorMsg += '<br /> '+'Duration 3(Spouse) is required' ;
                }
                
                if(asmt.Location_3_Spouse__c == null){
                    errorMsg += '<br /> '+'Location 3(Spouse) is required' ;
                }
            }
        }
        return errorMsg;
        
    }
    
    // Method to get Age in years, months & days from Date of birth
    // param - startDate(DOB), endDate - Date when age ended
    public static String getAgeInYearsMonthsDays(Date startDate, Date endDate){
        if(startDate == null){
            return null;
        }
        String age = '';
        if(startDate > endDate){
            age = 'The date of birth is invalid since it is after today\'s date.';
            return age;
        }
        Integer years = 0;
        Integer months = 0;
        Integer days = 0;
        
        days += endDate.day() - startDate.day();
        
        if(days < 0){
            days += Date.daysInMonth(startDate.year(), startDate.month());
            months--;
        }
        
        months += endDate.month() - startDate.month();
        
        if(months < 0){
            months += 12;
            years--;
        }
        
        years += endDate.year() - startDate.year();
        
        age = years + ' years ' + months + ' months '+ days + ' days ';
        return age;
    }
}