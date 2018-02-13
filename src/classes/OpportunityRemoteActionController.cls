global with sharing class OpportunityRemoteActionController {
    
    // the soql without the order and limit
    private String soql {get;set;}
    //date variables
    public string fromDate {get; set;}
    public string toDate {get; set;}
    public string LegacyNo {get; set;}
    public List<Account> lOrderList {get; set;}
        
      public OpportunityRemoteActionController() {
          soql = 'SELECT Name, Fax, Phone, (SELECT FirstName, LastName, Phone FROM Contacts WHERE AccountId != null) FROM Account';
          soql += ' LIMIT 100 ';
          system.debug('------soql -------'+soql );
        runQuery();
      }
 
      
    // runs the actual query
    public void runQuery() {
    
        try {
          lOrderList = Database.query(soql);
        } catch (Exception e) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    
    }
      
      /**
 
      * Remote action involved with Javascript remoting and is made global
 
      **/
 
            
      //public string parentId {get; set;}
      @RemoteAction
      global static Contact[] getContacts(String parentId){
          return [SELECT id, FirstName, LastName FROM Contact WHERE AccountId =: parentId];    
      }
      
      @RemoteAction
      global static Account[] getAccounts1(){
          return [SELECT Name, Fax, Phone, (SELECT FirstName, LastName, Phone FROM Contacts WHERE AccountId != null) FROM Account limit 10];    
      }
      
      
      
       // format the soql for display on the visualforce page
    public String debugSoql {
        get { return soql; }
        set;
    }
    

    public List<Account> accountList {
        get {
            if (accountList == null) {
                accountList = [SELECT Name, Fax, Phone, (SELECT FirstName, LastName, Phone FROM Contacts WHERE AccountId != null) FROM Account limit 10];
            }
            return accountList;
        }
        set;
      }
      
      
      public pageReference runSearch(){
    
    
       soql = 'SELECT Name, Fax, Phone, (SELECT FirstName, LastName, Phone FROM Contacts WHERE AccountId != null) FROM Account';
    try {
        //enters if LegacyNo entered
            if(LegacyNo != '' && LegacyNo != null){
                system.debug('---Entered into Legacy condition--------LegacyNo---------'+LegacyNo);
                //soql += 'WHERE (GEW_SAP_Bill_to__c =: LegacyNo  OR  GEW_SAP_Payer__c =:  LegacyNo  OR  GEW_SAP_Ship_To__c =: LegacyNo  OR  GEW_SAP_Sold_to__c =: LegacyNo )';      
                soql += ' LIMIT 500'; 
            } 
            //Only enter if Date Values are entered & LegacyNo is Null
            else if( ((fromDate != null || fromDate != '' ) || (toDate != null || toDate != '')) && (LegacyNo == null || LegacyNo == '' )){
                system.debug('---Entered into Dates condition--------Dates---------'+'@@@@@@@@@From Date '+fromDate+ '@@@@@@@@@@@To Date '+toDate );
                //soql += 'WHERE (GEW_SAP_Bill_to__c IN: setOfUniqueLegacy OR  GEW_SAP_Payer__c IN: setOfUniqueLegacy OR  GEW_SAP_Ship_To__c IN: setOfUniqueLegacy OR  GEW_SAP_Sold_to__c IN: setOfUniqueLegacy)';
                if (fromDate != null ){
                  string[] pFDate = string.valueOf(date.parse(fromDate)).split(' ');
                  system.debug('####Date Splitted'+pFDate[0]);
                  soql += ' AND CreatedDate >= ' + pFDate[0] + 'T00:00:00.000Z' ;
                }
                if (toDate != null){
                  string[] aTDate = string.valueOf(date.parse(toDate)).split(' ');
                  system.debug('####Date Splitted'+aTDate[0]);
                  soql += ' AND CreatedDate <= ' + aTDate[0] + 'T00:00:00.000Z' ;
                }
                soql += ' LIMIT 800'; 
            } 
            system.debug('---Final Query executed will be is ---->  '+soql); 
            runQuery();
    }
    catch (Exception e) {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please Select Dates!!'));
    }

    return null;
    } 

}