/**
* ClassName: ListIntegrationTargetOrgObject
* Purpose: Practicing integration between Salesforce-2-Salesforce by Creating Integration Custom Object
* CreatedDate: 21jan2015
**/

global class ListIntegrationTargetOrgObject{

    //Insert Method
    webservice static void InsertMethod(List<String> RecordName, List<String> Description, List<String> SourceOrg_ExternalId){
        
        System.debug('*****************Insert Method Started Executing**********************');
        
        //Initiliase List to add List of records
        List<Integration_TargetOrg__c> ListTargetObj = new List<Integration_TargetOrg__c>();
        
        list<Integration_TargetOrg__c> lst=[select id,Description__c, name,SourceOrg_Id__c  from Integration_TargetOrg__c where SourceOrg_Id__c IN :SourceOrg_ExternalId];
            for(integer i=0;i<lst.size();i++){
                lst[i].name=RecordName[i];
                lst[i].Description__c=Description[i];
                lst[i].SourceOrg_Id__c =SourceOrg_ExternalId[i];
            ListTargetObj.add(lst[i]);
        }
        
        /****
        List<Integration_TargetOrg__c> ListTargetObj = [SELECT id, 
                                                                Description__c, 
                                                                SourceOrg_Id__c 
                                                        FROM Integration_TargetOrg__c 
                                                        WHERE SourceOrg_Id__c =: SourceOrg_ExternalId ];
                                                        
        for(Integration_TargetOrg__c existRec: ListTargetObj ){
            existRec.Name = RecordName[0];
            system.debug('****************'+RecordName[0]);
            //TargetObj.Description__c = Description[i];
            //TargetObj.SourceOrg_Id__c = SourceOrg_ExternalId[i];
        }
        ****/
        
        //running in for Loop
        for(integer i=0; i<RecordName.size(); i++){
            Integration_TargetOrg__c TargetObj = new Integration_TargetOrg__c();
                TargetObj.Name = RecordName[i];
                TargetObj.Description__c = Description[i];
                TargetObj.SourceOrg_Id__c = SourceOrg_ExternalId[i];
                System.debug('=======> Record Name:'+TargetObj.Name+'==>'+RecordName[i]);
            ListTargetObj.add(TargetObj);
        }
        //try {
            upsert ListTargetObj;
            for(Integration_TargetOrg__c t:ListTargetObj){
                System.debug('List of Records: '+t.Name );
            }
       /* } 
        catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }*/
    }

}