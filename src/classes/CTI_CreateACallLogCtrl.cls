public with sharing class CTI_CreateACallLogCtrl {

    public PageReference showHideNewLocation() {
        System.debug('******************cllm.Locations__c*************'+cllm.Locations__c);
        if(cllm.Locations__c == 'Other'){
            renderedNewLocation=true;
        }else{
                renderedNewLocation=false;
                cllm.Locations__c = '';
        }
        return null;
    }


    public boolean renderedNewLocation { get; set; }
    
    //Location Custom settings Code
    /********
    public Boolean showLocation { get; set; }
    public String selectedLocation { get; set; }
    public list<SelectOption> locItems { get; set; }
    public String selectLoc { get; set; }
    public List<LocationDetails__c> location{get;set;}
    
    public PageReference controlLocations() {
        if(selectedLocation == 'Other'){
            showLocation = true;
        }else{
            
            showLocation = false;
        }
        locItems.clear();
        System.debug('************selectedlocation*****************'+selectedLocation);
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
    */
    
    //Get fields for the Contact fieldset
    /*public List<Schema.FieldSetMember> getFields() 
    {

        return SObjectType.Contact.FieldSets.ContactInfo.getFields();

    }    
    //end*/
    public void doAddContact()
    {
        insert contObj;
        cllm.contact__c = contObj.Id;
    }
    
    
    public String assetheaders { get; set; }
    public String AssetNumberId { get; set; }
    public string selValues = '';
    public boolean showContact{ get; set;}
    public boolean showButton{ get; set;}
    public String searchtext { get; set; }
 
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
        }catch(exception ex){
               
               
            }
        //return null;
    
    }
    
    public PageReference removeAnValues() {
        try{
            rightmulvaluesAN.clear();
        }catch(Exception ex){
            
        }
        
        for (integer i =0; i < rightMultiPicklistValuesAN.size(); i++){
            for (integer si =0; si < rightMultiPicklistAN.size(); si++){
                if (rightMultiPicklistValuesAN[i].getValue() == rightMultiPicklistAN[si]){
                        leftMultiPicklistValuesAN.add(rightMultiPicklistValuesAN.remove(i));
                    
                }
            }
        }
        for(SelectOption rMPVA:rightMultiPicklistValuesAN){
            rightmulvaluesAN.add(rMPVA.getvalue()); // Contains Right multi picklist values after remove  holds rightmulvalues               
        }
    return null;
    }

    list<String> asnumids=new list<String>();
    public list<String> lefttmulvaluesAn{ get; set; }
    public PageReference adAnValues() {
        lefttmulvaluesAn=new list<String>();
        rightMultiPicklistAN = new List<string>();  
        searchtext = '';
         
        for (integer i =0; i < leftMultiPicklistValuesAN.size(); i++) 
        {
            for (integer si =0; si < leftMultiPicklistAN .size(); si++)
            {
                if (leftMultiPicklistValuesAN[i].getValue() == leftMultiPicklistAN [si])
                {
                selValues += leftMultiPicklistValuesAN[i].getValue() + ','; 
                rightMultiPicklistValuesAN.add(leftMultiPicklistValuesAN.remove(i));
                }
            }
            asnumids.add(string.valueof(leftMultiPicklistAN));
        }
        rightmulvaluesAN=new list<String>();
        for(SelectOption rMPV:rightMultiPicklistValuesAN){
            rightmulvaluesAN.add(rMPV.getvalue()); // Contains Right multi picklist values before remove  holds rightmulvalues  
        }
        for(SelectOption lmpva:leftMultiPicklistValuesAN){
            lefttmulvaluesAn.add(lmpva.getvalue());
        }
        doSearch();
    return null;
    }
    
    public list<String> rightMultiPicklistAN { get; set; }
    
    public list<SelectOption> rightMultiPicklistValuesAN { get; set; }

    public list<SelectOption> leftMultiPicklistValuesAN { get; set; }

    public list<String> leftMultiPicklistAN { get; set; }

    public list<SelectOption> leftMultiPicklistValues { get; set; }

    public list<String> leftMultiPicklist { get; set; }

    public list<SelectOption> rightMultiPicklistValues { get; set; }

    public boolean nonevalue { get; set; }

    public list<String> rightMultiPicklist { get; set; }
    
    public string stCallDuration { get; set; }
    
    public contact contObj{get;set;}
    

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
          System.debug('************left selected multipick values****************'+rightMultiPicklist);
          if(rightMultiPicklist.size() > 0){
            
            removeassetNumbers(rightMultiPicklist);
            
          }
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
    public list<String> assetnumberidsToremove{get;set;}
    public void removeassetNumbers(list<String> deSelassetHeaders){
        System.debug('************left selected multipick values****************'+deSelassetHeaders);
        for(AssetNumber__C deasnlist : [select id,name,Customer__c,AssetHeader__c from AssetNumber__c where AssetHeader__c IN : deSelassetHeaders]){
            assetnumberidsToremove.add(deasnlist.id);
        }
        
        for (integer i =0; i < leftMultiPicklistValuesAN.size(); i++) 
        {
            for (integer si =0; si < assetnumberidsToremove .size(); si++)
            {
                if (leftMultiPicklistValuesAN[i].getValue() == assetnumberidsToremove [si])
                {
                selValues += leftMultiPicklistValuesAN[i].getValue() + ','; 
                rightMultiPicklistValuesAN.add(leftMultiPicklistValuesAN.remove(i));
                }
            }
        }
        try{
        for (integer i =0; i < rightMultiPicklistValuesAN.size(); i++){
            for (integer si =0; si < assetnumberidsToremove.size(); si++){
                if (rightMultiPicklistValuesAN[i].getValue() == assetnumberidsToremove[si]){
                        leftMultiPicklistValuesAN.add(rightMultiPicklistValuesAN.remove(i));
                    
                }
            }
        }
        }catch(exception ex){
            
        }
        
    }
    
 
        list<string> Assetheaderid=new list<string>();
        public list<string> rightmulvalues{get;set;}
        public list<string> rightmulvaluesAN{get;set;}
        public Set<String> strSet = new Set<String>();
      
     public PageReference addValues() {
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
           populateAssetNumbers(rightmulvalues);
           strSet = new Set<String>();
           for(SelectOption lso1:rightMultiPicklistValuesAN)
           strSet.add(lso1.getvalue());
           populateAssetNumbers(rightmulvalues);
           strSet.clear();
        }
        leftMultiPicklistValuesAN.sort();
         return null;
    }
    
    public void populateAssetNumbers(List<String> selAssHeaders)
    {
        leftMultiPicklistValuesAN.clear();
        //Populate Asset Header for Selection
        List<AssetNumber__C> asnlist = new List<AssetNumber__C>();
        leftMultiPicklistValuesAN.clear();
        Set<ID> removeIDSet = new Set<ID>();
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
        //
        
        //Remove Other Asset Headers - If Any
        
        
        //End
    
    }
    
    
    
    string assetheadernames='';
    public list<AssetNumber__c> lstassetnumber{get;set;}
    public String tempv1;
    public PageReference Save() {
        tempv1='';
        lstassetnumber=new list<AssetNumber__C>();
        
        //Get the Current Call Log ID in respect to UCID
        List<CallLogMaster__C> clmaster = new List<CallLogMaster__C>();
        clmaster = [SELECT ID FROM CALLLOGMASTER__c WHERE UCID__c=:ApexPages.currentPage().getParameters().get('UCID') LIMIT 1];
        if(!clmaster.isEmpty())
        {
            cllm.Id = clmaster[0].id;
            System.debug('****************cllm.Id = clmaster[0].id*******************'+cllm.Id +' = '+ clmaster[0].id);
        }
        
        //End
        
        // Last min Change req
        /****Start
        string locFirst = '';
        string locSec = '';
        locFirst = selectedLocation !=null ? selectedLocation : '';
        locSec = selectLoc !=null ? ' - ' + selectLoc : '';
        cllm.location__C = locFirst + locSec;
        End****/

        if(rightmulvaluesAN.size() > 0){
            System.debug('***************Asset numbers******************'+rightmulvaluesAN.size());
            lstassetnumber=[SELECT ID,name,AssetHeader__r.Name from AssetNumber__c   Where Id IN : rightmulvaluesAN];
            for(AssetNumber__c asn:lstassetnumber){
                tempv1 += asn.AssetHeader__r.name + ' - ' + asn.name+';'+' ';
            }
            cllm.Asset_Numbers__c=tempv1;
        }else{
            System.debug('***************Asset numbers else******************'+rightmulvaluesAN.size());
            cllm.Asset_Numbers__c='';
        }
            
        if(rightmulvalues.size() > 0){
            System.debug('***************Asset headers******************'+rightmulvalues.size());
            list<AssetHeader__c> lstassetheader=[SELECT ID,name from AssetHeader__c   Where Id IN : rightmulvalues];
            String tempv='';
            for(AssetHeader__c ash:lstassetheader){
            tempv += ash.name+';'+' ';
            
            }
            cllm.Asset_Headers__c=tempv;
        }else{
            
            cllm.Asset_Headers__c='';
        }
        
        //update cllm;
         try{
            update cllm;
            return new PageReference('/' + cllm.Id);
        }Catch(Exception ex){
        
        }
        
        return null;
    }
    
    public CallLogMaster__c cllm{get;set;}
    public string CallStartTime{get;set;}
    public String customerId {get;set;}
    public CTI_CreateACallLogCtrl(){
        assetnumberidsToremove=new list<String>();
        rightmulvalues=new list<String>();
        rightmulvaluesAN=new list<String>();
        renderedNewLocation=false;
        //locItems=new list<SelectOption>();    //Sai Commented
        leftMultiPicklist=new list<String>();
        rightMultiPicklistValuesAN=new list<SelectOption>();
        leftMultiPicklistValuesAN=new list<SelectOption>();
        rightMultiPicklistValues=new list<SelectOption>();
        
        leftMultiPicklistValues=new list<SelectOption>();
        cllm=new CallLogMaster__c();
        cllm.AgentName__c=userinfo.getuserid();
        cllm.UCID__c = Apexpages.currentPage().getParameters().get('UCID') ;
        cllm.CALLER__C = Apexpages.currentPage().getParameters().get('ANI') ;
        customerId = '';
        if(apexpages.currentpage().getparameters().get('id')!=null && apexpages.currentpage().getparameters().get('id')!='')
        {
            //customerId = ApexPages.currentPage().getParameters().get('id') != null ? '' : ApexPages.currentPage().getParameters().get('id');
            //customerId = ApexPages.currentPage().getParameters().get('id') == null ? '' : ApexPages.currentPage().getParameters().get('id');
            customerId = apexpages.currentpage().getparameters().get('id');
            for(AssetHeader__c ah:[select id,Name,Customer__c from AssetHeader__c where Customer__c =:customerId])
            {
                leftMultiPicklistValues.add(new SelectOption(ah.id,ah.name));
            }
            System.debug('****************customerId*****************'+customerId);
            if (!customerId.contains('null'))
            {          
                cllm.Customer__c=customerId;
            }  
            
        }
        else
        {
            doGenerateAssetHeader();
        }
        
       
        
        //Get the contact Name in respect to the Account
        List<Contact> contList = new List<Contact>();
        
        //iF we are creating Call Log from Contact Page
        string contId = '';
        if( ApexPages.currentPage().getParameters().get('contactId') != '')
        {
            cllm.contact__c = ApexPages.currentPage().getParameters().get('contactId');
        }
   
        //Get all Call data related to CUSTOMER
        CallLogMastersdataAcc();
        
        //End
   
    //End
    }
    
    public void doGenerateAssetHeader()
    {
        List<AssetHeader__C> ahd = new List<AssetHeader__C>();
        leftMultiPicklistValues.clear();
        rightMultiPicklistValues.clear();
        rightMultiPicklistValuesAN.clear();
        leftMultiPicklistValuesAN.clear();
        if(cllm.customer__C !=null)
        {
            for(AssetHeader__c ah:[select id,Name,Customer__c from AssetHeader__c where Customer__c =:cllm.customer__C]){
            leftMultiPicklistValues.add(new SelectOption(ah.id,ah.name));
            }
        }
    }
    public list<CallLogMaster__c> CallLogMastersdata { get; set; }
    public void CallLogMastersdataAcc(){
        system.debug('**********************************************cllm.Customer__c************************'+cllm.Customer__c);
        if(cllm.Customer__c != null){
        CallLogMastersdata = [select id,name,type__c,subject__c,AgentName__c,Customer__c,CREATEDDATE,
        Asset_Headers__C,asset_numbers__C,CallNotes__c,Issuetype__C,businesstype__C from CallLogMaster__c where Customer__c =:cllm.Customer__c ORDER BY CREATEDDATE DESC ];
        //return CallLogMastersdata;
        }
    //return null;
    }
    
   
    
}