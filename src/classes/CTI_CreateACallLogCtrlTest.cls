@isTest
Public class CTI_CreateACallLogCtrlTest {
    
   
    
    static testmethod void CTI_CreateACallLogCtrl1(){
        List<SelectOption> Opt;
        list<AssetHeader__c> assetheaderlst;
        list<AssetNumber__c> assetnumberlst;
        Account acc=new Account();
        acc.name = 'Test';
        //acc.RMD_Account__c = true;
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
         assetheaderlst=[select id,name from AssetHeader__c where customer__c =: apexpages.currentpage().getparameters().put('id',acc.id)];
         
         
         Boolean showLocation = true;
         String tsetsearchtext='';
         CTI_CreateACallLogCtrl ccacdc=new CTI_CreateACallLogCtrl();
         boolean testrenderedNewLocation = ccacdc.renderedNewLocation;
         String testassetheaders = ccacdc.assetheaders;
         String testAssetNumberId = ccacdc.AssetNumberId;
         Opt =  ccacdc.leftMultiPicklistValues;
         system.assertEquals(2, Opt.size());
         Opt = ccacdc.rightMultiPicklistValues;         
         
         ccacdc.leftMultiPicklist.add(assetheaderlst[0].id);
         ccacdc.addValues();
         
         Opt = ccacdc.rightMultiPicklistValues;
         ccacdc.rightMultiPicklist.add(assetheaderlst[0].Id);
         ccacdc.removeValues();
         ccacdc.rightmulvalues=ccacdc.rightMultiPicklist;

         ccacdc.searchtext = '';
         ccacdc.doSearch();
        assetnumberlst=[select id,name, AssetHeader__c from AssetNumber__c where AssetHeader__c IN : ccacdc.rightmulvalues];
        list<SelectOption> leftMultiPicklistValuesANTest=new list<SelectOption>();

        //Opt =  ccacdc.leftMultiPicklistValuesAN;
         List<SelectOption> OptAns =  ccacdc.leftMultiPicklistValuesAN;
        list<string> strselAn = new list<string>();
        for(SelectOption optan:OptAns){
            strselAn.add(optan.getValue()); 
        }
        ccacdc.leftMultiPicklistAN = strselAn;
        //ccacdc.leftMultiPicklistAN.add(assetnumberlst[0].id); 
        ccacdc.removeValues();
        ccacdc.adAnValues();
        
        List<SelectOption> OptdeAns =  ccacdc.rightMultiPicklistValuesAN;
        list<string> strseldeAn = new list<string>();
        for(SelectOption optdean:OptdeAns){
            strseldeAn.add(optdean.getValue()); 
        }
        ccacdc.rightMultiPicklistAN = strseldeAn; 
        ccacdc.rightmulvaluesAN=ccacdc.rightMultiPicklistAN;
        ccacdc.removeAnValues(); 
        //ccacdc.doPopulateCloneData();
        
        ccacdc.showHideNewLocation();
        try{
            ccacdc.populateAssetNumbers(asthederids);
            ccacdc.doGenerateAssetHeader();
        ccacdc.save();
        }Catch(Exception ex){
        
        }  
    }
    static testmethod void CTI_CreateACallLogCtrl3(){
        Account acc=new Account();
        acc.name = 'Test';
        //acc.RMD_Account__c = true;
        insert acc;
        
        Contact con=new Contact();
        con.lastname='test';
        con.Email = 'test@gmail.com';
        con.accountId = acc.id;
        insert con;
         
        list<CallLogMaster__c> cLML=new list<CallLogMaster__c>();
        
        CallLogMaster__c clogm = new CallLogMaster__c();
        clogm.customer__c = acc.id;
        clogm.contact__c = con.id;
        clogm.subject__c = 'TestCallLog';
        clogm.CallstartedOn__c = System.now();
        clogm.CALLENDEDON__c = System.now()+1;
        clogm.CALLNOTES__c = 'Tets';
        clogm.businesstype__C = 'Other';
        clogm.issuetype__c = 'CN Conference Call';
        clogm.type__C ='Inbound';
        clogm.Locations__C='Other';
        clogm.NewLocation__c='xyz1';
        clogm.UCID__c = '00001041371448396964';
        clogm.Locations__C = 'Calgary';
        //clogm.CallDuration__c = 20;
        clogm.Call_Duration__C = 20;
        cLML.add(clogm);
        
        CallLogMaster__c clogm1 = new CallLogMaster__c();
        //clogm1.customer__c = acc.id;
        clogm1.contact__c = con.id;
        clogm1.subject__c = 'TestCallLog';
        clogm1.CallstartedOn__c = System.now();
        clogm1.CALLENDEDON__c = System.now()+1;
        clogm1.CALLNOTES__c = 'Tets';
        clogm1.businesstype__C = 'Other';
        clogm1.issuetype__c = 'CN Conference Call';
        clogm1.type__C ='Inbound';
        clogm1.UCID__c = '00001041371448396964';
        clogm1.Locations__C = 'Calgary';
        clogm1.Locations__C='Other';
        clogm1.NewLocation__c='xyz';
        //clogm.CallDuration__c = 20;
        clogm1.Call_Duration__C = 20;
        cLML.add(clogm1);
        
        insert cLML;
        system.assertequals(cLML.size(),2);
       
        
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
        asN1.name = '1234';
        asN1.AssetHeader__c = assetheadersList[0].id;
        asN1.Customer__c = acc.id;
        asN1.Contact__c = con.id;
        asNList.add(asN1);
        
        insert asNList;
        
        Date orig= Date.today(); 
        DateTime dtConverted = DateTime.newInstance(orig.year(), orig.month(), orig.day());
        
         String CallStartTime = ApexPages.currentPage().getParameters().put('CallStartTime',string.valueof(dtConverted));
         ApexPages.currentPage().getParameters().put('CallDuration',string.valueof(50));
          //apexpages.currentpage().getparameters().put('id',acc.id);
           ApexPages.currentPage().getParameters().put('id',cLML[0].id);
         Boolean showLocation = true;
        String tsetsearchtext='';
        CTI_CreateACallLogCtrl ccacdc=new CTI_CreateACallLogCtrl();
        boolean testrenderedNewLocation = ccacdc.renderedNewLocation;
        //ccacdc.doPopulateCloneData();
        
        ccacdc.showHideNewLocation();
        try{
            ccacdc.populateAssetNumbers(asthederids);
            ccacdc.doGenerateAssetHeader();
        ccacdc.save();
        }Catch(Exception ex){
        
        }  
        
       
        
    }
     
}