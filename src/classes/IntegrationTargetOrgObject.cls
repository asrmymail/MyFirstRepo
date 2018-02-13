/**
* ClassName: IntegrationTargetOrgObject
* Purpose: Practicing integration between Salesforce-2-Salesforce by Creating Integration Custom Object
* CreatedDate: 21jan2015
**/

global class IntegrationTargetOrgObject{

    //Insert Method
    webservice static void InsertMethod(String RecordName, String Description, String SourceOrg_ExternalId){
        
        System.debug('*****************Insert Method Started Executing**********************');
        
        Integration_TargetOrg__c Target = new Integration_TargetOrg__c(Name = Recordname, Description__c = Description, SourceOrg_Id__c = SourceOrg_ExternalId);
        insert Target;
        
        System.debug('*****************Insert Method End Executing**********************');
        
    }
    
    //Update Method
    webservice static void UpdateMethod(String RecordName, String Description, String SourceOrg_ExternalId){
        
        System.debug('*****************Update Method Started Executing**********************');
        
        Integration_TargetOrg__c Target = [SELECT 
                                                    Id, 
                                                    Name, 
                                                    Description__c, 
                                                    SourceOrg_Id__c 
                                            FROM Integration_TargetOrg__c 
                                            WHERE SourceOrg_Id__c =: SourceOrg_ExternalId Limit 1];
        system.debug('1====>Name:'+RecordName+ '===>Description'+Description + '====>Source Org Id' + SourceOrg_ExternalId);
        system.debug('1====>Name:'+Target.Name+ '===>Description'+Target.Description__c + '====>Source Org Id' + Target.SourceOrg_Id__c);

        
        Target.Name = RecordName;
        Target.Description__c = Description;
        update Target;
        
        system.debug('2====>Name:'+RecordName+ '===>Description'+Description + '====>Source Org Id' + SourceOrg_ExternalId);
        system.debug('2====>Name:'+Target.Name+ '===>Description'+Target.Description__c + '====>Source Org Id' + Target.SourceOrg_Id__c);
        System.debug('*****************Update Method End Executing**********************');
        
    }
    
    /************************************************************
    //Bulkify Update 
    webservice static void BulkUpdateMethod(List<String> SourceOrg_ExternalIds){
                                               
        for(Integration_TargetOrg__c Target: [SELECT Id, Name, Description__c, SourceOrg_Id__c FROM Integration_TargetOrg__c WHERE SourceOrg_Id__c =: SourceOrg_ExternalIds]){
            
        }
        //insert Target;
        
    }
    *************************************************************/
    
    //Delete Method
    webservice static void DeleteMethod(String SourceOrg_ExternalId){
        
        System.debug('*****************Delete Method Started Executing**********************');
        
        Integration_TargetOrg__c Target = [SELECT 
                                                    Id, 
                                                    Name, 
                                                    Description__c, 
                                                    SourceOrg_Id__c 
                                            FROM Integration_TargetOrg__c 
                                            WHERE SourceOrg_Id__c =: SourceOrg_ExternalId Limit 1];
        
        delete Target;
        
        System.debug('*****************Delete Method End Executing**********************');
        
    }
    

}