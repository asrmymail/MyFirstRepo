@isTest
Public class CTI_CreateACallLogCloneCtrlTest {
    
   
    /*static testmethod void testCTI_CreateACallLogCtrlDummyClass1(){
        Account acc=new Account();
        acc.name = 'Test';
        
        insert acc;
        
        Contact con=new Contact();
        con.lastname='test';
        con.Email = 'test@gmail.com';
        con.accountId = acc.id;
        insert con;
        
        CallLogMaster__c clogm = new CallLogMaster__c();
        clogm.customer__c = acc.id;
        clogm.contact__c = con.id;
        clogm.subject__c = 'TestCallLog';
        clogm.CallstartedOn__c = System.now();
        insert clogm;
        
        list<AssetHeader__c> assetheadersList = new list<AssetHeader__c>();
        AssetHeader__c ah=new AssetHeader__c();
        ah.name = 'test-ah';
        ah.Customer__c = acc.id;
        assetheadersList.add(ah);
        
        AssetHeader__c ah1=new AssetHeader__c();
        ah1.name = 'test-ah';
        ah1.Customer__c = acc.id;
        assetheadersList.add(ah1);
        insert assetheadersList;
        
        list<String> asthederids=new list<String>();
        for(AssetHeader__c ahid:assetheadersList){
         asthederids.add(ahid.id);
        }
             
          
        list<AssetNumber__c> asNList = new list<AssetNumber__c>();
        AssetNumber__c asN = new AssetNumber__c();
        asN.name = '1234';
        asN.AssetHeader__c = assetheadersList[0].id;
        asN.Customer__c = acc.id;
        asN.Contact__c = con.id;
        asNList.add(asN);
         AssetNumber__c asN1 = new AssetNumber__c();
        asN1.name = '1235';
        asN1.AssetHeader__c = assetheadersList[0].id;
        asN1.Customer__c = acc.id;
        asN1.Contact__c = con.id;
        asNList.add(asN1);
        if(asNList.size()>0){
        insert asNList;
        }
                
        Date orig= Date.today(); 
        DateTime dtConverted = DateTime.newInstance(orig.year(), orig.month(), orig.day());
       
         String CallStartTime = ApexPages.currentPage().getParameters().put('CallStartTime',string.valueof(dtConverted));
         ApexPages.currentPage().getParameters().put('CallDuration',string.valueof(50));
         apexpages.currentpage().getparameters().put('id',acc.id);
         
         Boolean showLocation = true;
       String tsetsearchtext='';
        CTI_CreateACallLogCloneCtrl ccacdc=new CTI_CreateACallLogCloneCtrl();
        boolean testrenderedNewLocation = ccacdc.renderedNewLocation;
        //string teststCallDuration=ccacdc.stCallDuration;
        //contact testcontObj=ccacdc.contObj;
        //clogm.contact__c = testcontObj.id;
        //boolean testshowContact=ccacdc.showContact;
        //boolean testshowButton=ccacdc.showButton;
        
        //ccacdc.leftMultiPicklistValues;
        List<SelectOption> Opt =  ccacdc.leftMultiPicklistValues; 
        list<string> strsel = new list<string>();
        for(selectOption sel : Opt)
        {
            strsel.add(sel.getValue());
        }    
        
        ccacdc.leftMultiPicklist = strsel; 
        ccacdc.addValues(); 
        
        //ccacdc.rightMultiPicklistValues = ccacdc.leftMultiPicklist;
        for(String str : strsel){
            ccacdc.rightMultiPicklistValues.add(new selectOption(str,str));
        }
        List<SelectOption> Optde =  ccacdc.rightMultiPicklistValues; 
        list<string> strDesel = new list<string>();
        for(selectOption desel : Optde)
        {
            strDesel.add(desel.getValue());
        }
        ccacdc.rightMultiPicklist = strDesel; 
        ccacdc.removeValues();
        
        List<SelectOption> OptAns =  ccacdc.leftMultiPicklistValuesAN;
        list<string> strselAn = new list<string>();
        for(SelectOption optan:OptAns){
            strselAn.add(optan.getValue()); 
        }
        ccacdc.rightMultiPicklistAN = strselAn; 
        //ccacdc.adAnValues();
        
        List<SelectOption> OptdeAns =  ccacdc.rightMultiPicklistValuesAN;
        list<string> strseldeAn = new list<string>();
        for(SelectOption optdean:OptdeAns){
            strseldeAn.add(optdean.getValue()); 
        }
        ccacdc.leftMultiPicklistAN = strseldeAn; 
        ccacdc.removeAnValues();
        
        
    }
    
    static testmethod void testCTI_CreateACallLogCtrlDummyClass2(){
        Account acc=new Account();
        acc.name = 'Test';

        insert acc;
        
        Contact con=new Contact();
        con.lastname='test';
        con.Email = 'test@gmail.com';
        con.accountId = acc.id;
        insert con;
        
        CallLogMaster__c clogm = new CallLogMaster__c();
        clogm.customer__c = acc.id;
        clogm.contact__c = con.id;
        clogm.subject__c = 'TestCallLog';
        clogm.CallstartedOn__c = System.now();
        insert clogm;
        
        list<AssetHeader__c> assetheadersList = new list<AssetHeader__c>();
        AssetHeader__c ah=new AssetHeader__c();
        ah.name = 'test-ah';
        ah.Customer__c = acc.id;
        assetheadersList.add(ah);
        
        AssetHeader__c ah1=new AssetHeader__c();
        ah1.name = 'test-ah';
        ah1.Customer__c = acc.id;
        assetheadersList.add(ah1);
        insert assetheadersList;
        
        list<String> asthederids=new list<String>();
        for(AssetHeader__c ahid:assetheadersList){
         asthederids.add(ahid.id);
        }
             
          
        list<AssetNumber__c> asNList = new list<AssetNumber__c>();
        AssetNumber__c asN = new AssetNumber__c();
        asN.name = '1234';
        asN.AssetHeader__c = assetheadersList[0].id;
        asN.Customer__c = acc.id;
        asN.Contact__c = con.id;
        asNList.add(asN);
         AssetNumber__c asN1 = new AssetNumber__c();
        asN1.name = '1235';
        asN1.AssetHeader__c = assetheadersList[0].id;
        asN1.Customer__c = acc.id;
        asN1.Contact__c = con.id;
        asNList.add(asN1);
        if(asNList.size()>0){
        insert asNList;
        }
                
        Date orig= Date.today(); 
        DateTime dtConverted = DateTime.newInstance(orig.year(), orig.month(), orig.day());
       
         String CallStartTime = ApexPages.currentPage().getParameters().put('CallStartTime',string.valueof(dtConverted));
         ApexPages.currentPage().getParameters().put('CallDuration',string.valueof(50));
         apexpages.currentpage().getparameters().put('id',acc.id);
         
         Boolean showLocation = true;
       String tsetsearchtext='';
        CTI_CreateACallLogCloneCtrl ccacdc=new CTI_CreateACallLogCloneCtrl();
        
        list<SelectOption> testleftMultiPicklistValuesAN=new list<SelectOption>();
        testleftMultiPicklistValuesAN.addAll(ccacdc.leftMultiPicklistValuesAN);
        
        list<String> testleftMultiPicklistAN =ccacdc.leftMultiPicklistAN;
        
        list<SelectOption> testrightMultiPicklistValuesAN = new list<SelectOption>();
        testrightMultiPicklistValuesAN.addAll(ccacdc.rightMultiPicklistValuesAN);
        
        list<String> testrightMultiPicklistAN = ccacdc.rightMultiPicklistAN;
        
        list<String> testlefttmulvaluesAn=ccacdc.lefttmulvaluesAn;
        
        list<string> testrightmulvaluesAN = new list<string>();
        testrightmulvaluesAN.addAll(ccacdc.rightmulvaluesAN);
        ccacdc.adAnValues();
        ccacdc.removeAnValues();
        
        boolean testrenderedNewLocation = ccacdc.renderedNewLocation;
        string teststCallDuration=ccacdc.stCallDuration;
        contact testcontObj=ccacdc.contObj;
        //clogm.contact__c = testcontObj.id;
        boolean testshowContact=ccacdc.showContact;
        boolean testshowButton=ccacdc.showButton;
        
        List<Schema.FieldSetMember> testgetFields = ccacdc.getFields();
        ccacdc.CallStartTime=string.valueof(dtConverted);

        String testassetheaders = ccacdc.assetheaders;
        String testAssetNumberId = ccacdc.AssetNumberId;
        ccacdc.searchtext = tsetsearchtext;
        ccacdc.populateAssetNumbers(asthederids);
        ccacdc.doSearch();
        ccacdc.save();
        ccacdc.showHideNewLocation();
        ccacdc.CallLogMastersdataAcc();
        ccacdc.doGenerateAssetHeader();
        try{
        ccacdc.doAddContact();
        clogm.contact__c = con.id;
        }Catch(Exception ex){
        
        }
       
        
    }
    static testmethod void testCTI_CreateACallLogCtrlDummyClass3(){
        Account acc=new Account();
        acc.name = 'Test';

        insert acc;
        
        Contact con=new Contact();
        con.lastname='test';
        con.Email = 'test@gmail.com';
        con.accountId = acc.id;
        insert con;
        
        CallLogMaster__c clogm = new CallLogMaster__c();
        clogm.customer__c = acc.id;
        clogm.contact__c = con.id;
        clogm.subject__c = 'TestCallLog';
        clogm.CallstartedOn__c = System.now();
        insert clogm;
        
        list<AssetHeader__c> assetheadersList = new list<AssetHeader__c>();
        for(integer i=0;i<5;i++){
        AssetHeader__c ah=new AssetHeader__c();
        ah.name = 'test-ah'+i;
        ah.Customer__c = acc.id;
        assetheadersList.add(ah);
        }

        insert assetheadersList;
        
        list<String> asthederids=new list<String>();
        for(AssetHeader__c ahid:assetheadersList){
         asthederids.add(ahid.id);
        }
  
        list<AssetNumber__c> asNList = new list<AssetNumber__c>();
        AssetNumber__c asN = new AssetNumber__c();
        asN.name = '1234';
        asN.AssetHeader__c = assetheadersList[0].id;
        asN.Customer__c = acc.id;
        asN.Contact__c = con.id;
        asNList.add(asN);
         AssetNumber__c asN1 = new AssetNumber__c();
        asN1.name = '1235';
        asN1.AssetHeader__c = assetheadersList[0].id;
        asN1.Customer__c = acc.id;
        asN1.Contact__c = con.id;
        asNList.add(asN1);
        if(asNList.size()>0){
        insert asNList;
        }
        
        Date orig= Date.today(); 
        DateTime dtConverted = DateTime.newInstance(orig.year(), orig.month(), orig.day());
       
         String CallStartTime = ApexPages.currentPage().getParameters().put('CallStartTime',string.valueof(dtConverted));
         ApexPages.currentPage().getParameters().put('CallDuration',string.valueof(50));
         Boolean showLocation = false;
       String tsetsearchtext='testsearch';
       
        CTI_CreateACallLogCloneCtrl ccacdc=new CTI_CreateACallLogCloneCtrl();
        
        
        list<String> testlefttmulvaluesAn=ccacdc.lefttmulvaluesAn;
        list<String> testrightMultiPicklistAN=ccacdc.rightMultiPicklistAN;
        list<String> testleftMultiPicklistAN=ccacdc.leftMultiPicklistAN;
        ccacdc.CallStartTime=string.valueof(dtConverted);
        
        
        String testassetheaders = ccacdc.assetheaders;
        String testAssetNumberId = ccacdc.AssetNumberId;
        //ccacdc.doSearch();
        ccacdc.searchtext = tsetsearchtext;
        ccacdc.removeAnValues();
        
        
        ccacdc.addValues();
        ccacdc.removeValues();
        ccacdc.populateAssetNumbers(asthederids);
        ccacdc.doSearch();
        ccacdc.adAnValues();
        //ccacdc.save();
        
       
        
    }*/
}