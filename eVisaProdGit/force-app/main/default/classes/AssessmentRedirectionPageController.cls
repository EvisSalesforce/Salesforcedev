public class AssessmentRedirectionPageController {
    public string selectedassessment{get;set;}
    public string consultationId {get;set;}
    public String accountId {get; set;}//Account Id
    public String assessmentId {get; set;}
    public string origin{get;set;}
    public List<Selectoption> assessmenttype{get;set;}
    public string eeId {get;set;}
    
    
    
    public final string pnptab = 'pnptab'; 
    public final string EEbtn = 'EEbtn';
    public final string OINPbtn = 'OINPbtn';
    public final string bcpnpbtn = 'bcpnpbtn';
    public final string Accounthome = 'Accounthome';
    
    //Constructor
    public AssessmentRedirectionPageController()
    {
        accountId = Apexpages.currentpage().getparameters().get('accountId');
        consultationId = Apexpages.currentpage().getparameters().get('consultationId');
        origin = Apexpages.currentpage().getparameters().get('origin');
        eeId = Apexpages.currentPage().getparameters().get('eeId');
        if(pnptab.equals(origin))
        {
       		assessmenttype = getselectedassessmenttype(true);     
        }
        else
        {
            assessmenttype = getselectedassessmenttype(false);
        }
       
    }
    
    
    public List<Selectoption> getselectedassessmenttype(Boolean pnp){
            List<Selectoption> lstnamesel = new List<selectoption>();
            lstnamesel.add(new selectOption('Express Entry', 'Express Entry',pnp));
        	lstnamesel.add(new selectOption('BCPNP', 'BCPNP'));
        	lstnamesel.add(new selectOption('OINP', 'OINP'));
            return lstnamesel; 
        }
    
    //create new assessment
    public PageReference createAssessment()
    {
        PageReference pageRef = null;
        if(selectedassessment.equals('Express Entry'))
        {
            if(String.isNotBlank(consultationId))//if clicked from start new assessment from consutation sheet
            {
                String base = '/apex/AssessmentPanelScreen?accountId='+accountId+'&asmt=new&openCsId='+consultationId+'&csId='+consultationId;
                System.debug('base: '+base);
                pageRef = new PageReference(base);
                pageRef.setRedirect(true);
            }
            else
            {
                //System.debug('accountId: '+accountId);
                String base = '/apex/AssessmentPanelScreen?accountId='+accountId+'&asmt=new';
                //System.debug('base: '+base);
                pageRef = new PageReference(base);
                pageRef.setRedirect(true);
            }
        }
        else if(selectedassessment.equals('BCPNP'))
        {
            String base = '/apex/BCPNPPanelScreen?accountId='+accountId+'&asmt=new';
            if(String.isNotBlank(eeId))
                base+='&eeId='+eeId;
            if(String.isNotBlank(consultationId))
                base+='&openCsId='+consultationId+'&csId='+consultationId;
            pageRef = new PageReference(base);
            pageRef.setRedirect(true);
            
        }
        else if(selectedassessment.equals('OINP'))
        {
           String base = '/apex/OINPPanelScreen?accountId='+accountId+'&asmt=new';
            if(String.isNotBlank(eeId))
                base+='&eeId='+eeId;
            if(String.isNotBlank(consultationId))
                base+='&openCsId='+consultationId+'&csId='+consultationId;
            pageRef = new PageReference(base);
            pageRef.setRedirect(true); 
        }
            
        return pageRef;
    }
    public PageReference backToSFhome(){
        String base = URL.getSalesforceBaseUrl().toExternalForm();
        string url = '/lightning/r/Account/'+accountId+'/view';
        System.debug('base: '+base);
        if(base.startsWith('https://evisaimmigration.force.com')){
            url = '/'+accountId;
        }
        System.debug('url: '+url);
        if(EEbtn.equals(origin))
        {
            url = '/apex/AssessmentPanelScreen?accountId='+ accountId+'&openCsId='+consultationId;
        }
        else if(OINPbtn.equals(origin))
        {
            url = '/apex/OINPPanelScreen?accountId='+ accountId+'&openCsId='+consultationId;
        }
        else if(bcpnpbtn.equals(origin))
        {
            url = '/apex/BCPNPPanelScreen?accountId='+ accountId+'&openCsId='+consultationId; 
        }
        else if(pnptab.equals(origin))
        {
            if(String.isBlank(consultationId))
                url = '/apex/AssessmentPanelScreen?accountId='+ accountId+'&asId='+eeId;
            else
                url = '/apex/AssessmentPanelScreen?accountId='+ accountId+'&asId='+eeId+'&openCsId='+consultationId;
            System.debug('url: '+url);
        }
        else
        {
			url = '/lightning/r/Account/'+accountId+'/view';            
        }
        PageReference pageRef = new PageReference(url);
        pageRef.setRedirect(true);
        return pageRef;
    }
}