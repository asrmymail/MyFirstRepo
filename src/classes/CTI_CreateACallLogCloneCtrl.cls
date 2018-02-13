public with sharing class CTI_CreateACallLogCloneCtrl{

    public boolean renderedNewLocation { get; set; }

    public PageReference showHideNewLocation() {
        if(cllm.Locations__c == 'Other'){
            renderedNewLocation=true;
        }else{
                renderedNewLocation=false;
                cllm.Locations__c = '';
        }
        return null;
    }


    
    public String assetheaders { get; set; }
    public String AssetNumberId { get; set; }
    public string selValues = '';
    public String searchtext { get; set; }
    list<String> asnumids=new list<String>();
    public list<String> lefttmulvaluesAn{get;set;}
    public list<String> rightMultiPicklistAN { get; set; }    
    public list<SelectOption> rightMultiPicklistValuesAN { get; set; }

    public list<SelectOption> leftMultiPicklistValuesAN { get; set; }

    public list<String> leftMultiPicklistAN { get; set; }

    public list<SelectOption> leftMultiPicklistValues { get; set; }

    public list<String> leftMultiPicklist { get; set; }

    public list<SelectOption> rightMultiPicklistValues { get; set; }
    
    public List<String> rightmulvalues = new List<String>();
    
    public list<string> rightmulvaluesAN{get;set;}

    public boolean nonevalue { get; set; }

    public list<String> rightMultiPicklist { get; set; }
    
    public CallLogMaster__c cllm{ get; set; }
    
    public List<String> AssetHeaderId = new List<String>();

    //End
    
    //Constructor
    public CTI_CreateACallLogCloneCtrl(){
    
        //Sai Commented
        /* 
        System.debug('------------selectLoc------------>'+selectLoc);
        showhideLoc=false;
        hidelocationReadonly=true;
        locItems=new list<SelectOption>();
        */
        cllm =new CallLogMaster__c();
        rightmulvalues=new list<String>();
        rightmulvaluesAN=new list<String>();
        leftMultiPicklist=new list<String>();
        rightMultiPicklistValuesAN=new list<SelectOption>();
        leftMultiPicklistValuesAN=new list<SelectOption>();
        rightMultiPicklistValues=new list<SelectOption>();
        String customerId=apexpages.currentpage().getparameters().get('id') == null ? '' :apexpages.currentpage().getparameters().get('id') ;
        leftMultiPicklistValues=new list<SelectOption>();
        if(customerid != '')
        {
            for(AssetHeader__c ah:[select id,Name,Customer__c from AssetHeader__c where Customer__c =:customerId]){
                leftMultiPicklistValues.add(new SelectOption(ah.id,ah.name));
            }
        }
        else
        {
            doGenerateAssetHeader();
        }
        cllm.AgentName__c=userinfo.getuserid();
        //cllm.Customer__c=customerId;
        //Get the contact Name in respect to the Account
        List<Contact> contList = new List<Contact>();
        
        //iF we are creating Call Log from Contact Page
        string contId = '';
        contId = ApexPages.currentPage().getParameters().get('contactId') == null ? '' : ApexPages.currentPage().getParameters().get('contactId'); 
        
        //End
        if(contId != '') // If direc
        {
            cllm.Contact__c = contId;
        }

        doPopulateCloneData();
         
    //End
    }
    
    public void doGenerateAssetHeader()
    {
        List<AssetHeader__C> ahd = new List<AssetHeader__C>();
        leftMultiPicklistValues.clear();
        if(cllm.customer__C !=null)
        {
            for(AssetHeader__c ah:[select id,Name,Customer__c from AssetHeader__c where Customer__c =:cllm.customer__C]){
            leftMultiPicklistValues.add(new SelectOption(ah.id,ah.name));
            }
        }
    }
    
    //Populate Data for clone records related to contact,issue,business,notes
    //@TestVisible private string logId;
    public void doPopulateCloneData()
    {
        List<CallLogMaster__C> oldLog = new List<CallLogMaster__C>();
        
        string logId = ApexPages.currentPage().getParameters().get('id') !=null ?  ApexPages.currentPage().getParameters().get('id'):'';
        System.debug('************logId***********'+logId);
        if(logId <> null)
        {
            //oldLog = [SELECT CALLSTARTEDON__c,CALLENDEDON__c,CALLNOTES__c, businesstype__C,issuetype__c,type__C ,UCID__c,Subject__C,Location__C,NewLocation__c,CallDuration__c,Call_Duration__C FROM CallLogMaster__C where Id =:logId];      //Sai Commented
                oldLog = [SELECT CALLSTARTEDON__c,NewLocation__c,CALLENDEDON__c,CALLNOTES__c, businesstype__C,issuetype__c,type__C ,UCID__c,Subject__C,Locations__C,CallDuration__c,Call_Duration__C FROM CallLogMaster__C where Id =:logId];
            System.debug('************oldLog***********'+oldLog);
            if(!oldLog.isEmpty())
            {
                for(CallLogMaster__C clm:oldLog)
                {
                    cllm.CallStartedOn__C = clm.callstartedon__C;
                    cllm.callendedon__C = clm.callendedon__C;
                    cllm.callnotes__C = clm.callnotes__C;
                    cllm.issuetype__C = clm.issuetype__C;
                    cllm.businesstype__C = clm.businesstype__C;
                    cllm.type__C = clm.type__C;
                    cllm.UCID__c = clm.UCID__C;
                    cllm.Subject__C = clm.Subject__C;
                    cllm.Locations__c = clm.locations__C;
                    if(clm.NewLocation__c != '' && clm.Locations__C == 'Other'){
                        renderedNewLocation=true;
                    cllm.NewLocation__c = clm.NewLocation__c;     //Sai Commented
                    }
                    cllm.Call_Duration__C = clm.Call_Duration__C;
                    //cllm.CallDuration__c = clm.CallDuration__c;
                }
            }
            /*********
            //START HERE
            if(cllm.location__c != null)
            {
                string[] locValues = cllm.location__c.split('-');
                selectedLocation = locValues[0].replace(' ','');
                //selectLoc = locValues[1];
                locationReadonly = locValues[1];
                System.Debug('LOCATION NOW:' + ' ' +  locValues[0]);
                System.Debug('LOCATION NOW1:' + ' ' +  locValues[1]);
            }
            if(selectedLocation == 'Other'){
           showLocation = true;
            }else{
            
            showLocation = false;
            }
            //END HERE
            ***********/
        }
    }
    //End
    
    
       
    //Searching Asset Number
    public void doSearch()
    {
        try{
            string SOQL = '';
            string tempInput = searchtext + '%';
            List<AssetNumber__C> asNList = new List<AssetNumber__c>();
            asNList.clear();
            leftMultiPicklistValuesAN.clear();
            string currentValues = '';
            for(SelectOption op:rightMultiPicklistValuesAN)
            {
                currentValues += op.getLabel() + ',';
            }
            if(searchtext == '' || searchtext == null)
            {
                
               asNList = [SELECT ID,NAME, AssetHeader__c from AssetNumber__c where AssetHeader__C in:(rightmulvalues)];
            }
            else
            {
               asNList = [select id,Name,AssetHeader__c from AssetNumber__c where ((AssetHeader__C in:(rightmulvalues)) AND (Name like : tempInput))];
            }
            //leftMultiPicklistValuesAN.clear();
            
            if(!asNList.isEmpty())
            {
                for(AssetNumber__c asn:asNList)
                {
                    if(!currentValues.contains(asn.name))
                    {
                        leftMultiPicklistValuesAN.add(new SelectOption(asn.id,asn.name));
                    }    
                }
            }
        }catch(Exception ex){
            
        }
    }
    
    //Asset Number List Navigation Process
   
    public PageReference removeAnValues() 
    {   try{
            rightmulvaluesAN.clear();
        }Catch(Exception ex){
            
        }
        
        for (integer i =0; i < rightMultiPicklistValuesAN.size(); i++)
        {
            for (integer si =0; si < rightMultiPicklistAN.size(); si++){
                if (rightMultiPicklistValuesAN[i].getValue() == rightMultiPicklistAN[si]){
                    leftMultiPicklistValuesAN.add(rightMultiPicklistValuesAN.remove(i));
                }
            }
        }
        for(SelectOption rMPVA:rightMultiPicklistValuesAN){
            rightmulvaluesAN.add(rMPVA.getvalue());              
        }
        return null;
    }

    
    public PageReference adAnValues() 
    {
        lefttmulvaluesAn=new list<String>();
        rightMultiPicklistAN = new List<string>();  
        searchtext = '';
         
        for (integer i =0; i < leftMultiPicklistValuesAN.size(); i++) 
        {
            for (integer si =0; si < leftMultiPicklistAN .size(); si++){
                if (leftMultiPicklistValuesAN[i].getValue() == leftMultiPicklistAN [si])
                {
                    selValues += leftMultiPicklistValuesAN[i].getValue() + ','; 
                    rightMultiPicklistValuesAN.add(leftMultiPicklistValuesAN.remove(i));
                }
            }
            //asnumids.add(string.valueof(leftMultiPicklistAN));
        }
        rightmulvaluesAN=new list<String>();
        for(SelectOption rMPV:rightMultiPicklistValuesAN){
            rightmulvaluesAN.add(rMPV.getvalue()); 
        }
        for(SelectOption lmpva:leftMultiPicklistValuesAN)
        {
            lefttmulvaluesAn.add(lmpva.getvalue());
        }
         doSearch();    
         System.debug('------------------list of leftMultiPicklistAN'+lefttmulvaluesAn);
         System.debug('------------------list of strings'+rightMultiPicklistAN);
        return null;
    }
    
    public void populateAssetNumbers(List<String> selAssHeaders)
    {   
        leftMultiPicklistValuesAN.clear();
        Set<ID> removeIDSet = new Set<ID>();
        //Populate Asset Header for Selection
        List<AssetNumber__C> asnlist = new List<AssetNumber__C>();
        leftMultiPicklistValuesAN.clear();
        if(!selAssHeaders.isEmpty())
        {
            asnlist = [select id,name,Customer__c,AssetHeader__c from AssetNumber__c where AssetHeader__c IN : selAssHeaders];
            if(!asnList.isEmpty())
            {
                for(AssetNumber__C an:asnList)
                {   
                    removeIDSet.add(an.id);
                    if( !strSet.contains(an.id) )
                    
                    leftMultiPicklistValuesAN.add(new SelectOption(an.id,an.name));
                }  

                for( Integer ii=0; ii< rightMultiPicklistValuesAN.size(); ii++)
                {
                    if( !removeIDSet.contains(rightMultiPicklistValuesAN.get(ii).getValue()) )
                        rightMultiPicklistValuesAN.remove(ii);                                              
                }
            }
        }    
    }
    public PageReference removeValues() {
    leftMultiPicklistValuesAN.clear();
        try{
            rightmulvalues.clear();
        }catch(Exception ex){
            
        }
    
    
     for (integer i =0; i < rightMultiPicklistValues.size(); i++){
          for (integer si =0; si < rightMultiPicklist.size(); si++){
              if (rightMultiPicklistValues[i].getValue() == rightMultiPicklist[si]){
                leftMultiPicklistValues.add(rightMultiPicklistValues.remove(i));
              }
          }
          }
          System.debug('************rightMultiPicklistValues in remove********'+rightMultiPicklistValues);
          
          //If still there are selected Asset Headers
          //then populate Asset Numbers based on it
          if(!rightMultiPicklistValues.isEmpty())
          {
            
             strSet = new Set<String>();
             for(SelectOption lso1:rightMultiPicklistValuesAN)
             strSet.add(lso1.getvalue());
              for(SelectOption lso:rightMultiPicklistValues)
              {
                 rightmulvalues.add(lso.getvalue());
                 
              }
              
              populateAssetNumbers(rightmulvalues);
              strSet.clear();
              
          }
          else
          {
              populateAssetNumbers(new List<String>());
              rightMultiPicklistValuesAN.clear(); // Remove selected Asset Numbers too
              leftMultiPicklistValuesAN.clear();
          } 
    
        return null;
    }
    
    public Set<String> strSet = new Set<String>();
    
     public PageReference addValues() 
     {
     
     //leftMultiPicklistValuesAN.clear();
     nonevalue=false;
     System.debug('------------------list of strings left******'+leftMultiPicklist);
     rightMultiPicklist  = new List<string>();       
     for (integer i =0; i < leftMultiPicklistValues.size(); i++) {
                 for (integer si =0; si < leftMultiPicklist .size(); si++){
                         if (leftMultiPicklistValues[i].getValue() == leftMultiPicklist [si]){
                              rightMultiPicklistValues.add(leftMultiPicklistValues.remove(i));
                         }
                 }
         Assetheaderid.add(string.valueof(leftMultiPicklist));
    }
         System.debug('------------------list of strings right*******'+rightMultiPicklistValues);
         rightmulvalues=new list<String>();
         
         for(SelectOption lso:rightMultiPicklistValues){
         rightmulvalues.add(lso.getvalue());
         }
         System.debug('*********rifht mulit values************'+rightmulvalues);
         
         System.debug('------------------rightMultiPicklistValues*******'+Assetheaderid);
         if(leftMultiPicklist.size() > 0){
            strSet = new Set<String>();
            for(SelectOption lso1:rightMultiPicklistValuesAN)
            strSet.add(lso1.getvalue());
            
           populateAssetNumbers(rightmulvalues);
           strSet.clear();
           
         }
        leftMultiPicklistValuesAN.sort();
         return null;
    }
    string assetheadernames='';

    public PageReference save() {
        if(rightmulvaluesAN.size() > 0){
            list<AssetNumber__c> lstassetnumber=[SELECT ID,name,AssetHeader__r.Name from AssetNumber__c   Where Id IN : rightmulvaluesAN];
            String tempv1='';
            for(AssetNumber__c asn:lstassetnumber){
                tempv1 += asn.AssetHeader__r.name + ' - ' + asn.name+';'+' ';
            }
            cllm.Asset_Numbers__c=tempv1;
        }else{
            cllm.Asset_Numbers__c='';
        }
        System.debug('------------cllm.Asset_Numbers__c------------>'+cllm.Asset_Numbers__c);
        if(rightmulvalues.size() > 0){
            list<AssetHeader__c> lstassetheader=[SELECT ID,name from AssetHeader__c   Where Id IN : rightmulvalues];
            String tempv='';
            for(AssetHeader__c ash:lstassetheader){
                tempv += ash.name+';'+' ';
            }
            cllm.Asset_Headers__c=tempv;
        }else{
            cllm.Asset_Headers__c='';
        }
        
        /*
        cllm.location__C = selectedLocation + '-' + selectLoc; */
        if(cllm.Locations__c != 'Other'){
            cllm.NewLocation__c = '';
        }
        Try{
            insert cllm;
        return new PageReference('/' + cllm.Id);
        }catch(Exception ex){
            
        }
        return null;

    }
    
    
    //Location Custom Settings Code //Sai Commented
    /*Start 
    
    public boolean showhideLoc { get; set; }
    public String locationReadonly { get; set; }
    public boolean hidelocationReadonly { get; set; }
    public boolean showLocation { get; set; }
    //Global Class members
    public String selectedLocation { get; set; }
    public list<SelectOption> locItems { get; set; }
    public String selectLoc { get; set; }
    public List<LocationDetails__c> location{ get; set; }
    
    
    //Location Population Utility Method
    public list<SelectOption> getlocationItems() {
        list<SelectOption> options=new list<SelectOption>(); 
        options.add(new SelectOption('', '-- Select One --')); 
        
        Map<String, LocationAbbrevation__c> Locationabbrevations = LocationAbbrevation__c.getAll();
        List<String> locationabbreNames = new List<String>();
        locationabbreNames.addAll(Locationabbrevations.keySet());
        locationabbreNames.sort();    
        for (String locationabbreName : locationabbreNames) {
            LocationAbbrevation__c Locabbre = Locationabbrevations.get(locationabbreName);
            
            options.add(new SelectOption(Locabbre.Location_Abbre_Code__c, Locabbre.Name));
        }

        return options;
    }
    
   
    public PageReference controlLocations() 
    {
        hidelocationReadonly=FALSE;
        showhideLoc=true;
        System.debug('************selectedlocation*****************'+selectedLocation);
        if(selectedLocation == 'Other'){
        System.debug('************selectedlocation*****************'+selectedLocation);
        showLocation = true;
        }else{
        showLocation=false;
        }
        locItems.clear();
        
        Map<String, Location__c> allLocations = Location__c.getAll();
        Map<String, Location__c> locations= new Map<String, Location__c>();  
        for(Location__c loc : allLocations.values()) {
            if (loc.Location_Abbre_Code__c == selectedLocation) {
                locations.put(loc.name, loc);
            }
        }
        
        List<String> locationNames = new List<String>();
        locationNames.addAll(locations.keySet());
        locationNames.sort();
        
        for (String locName : locationNames ) {
            Location__c loc = locations.get(locName);
            locItems.add(new SelectOption(loc.Location_Code__c, loc.Location_Name__c));
        }
        
        return null;
    }
    //End
    
    */
    
    
}