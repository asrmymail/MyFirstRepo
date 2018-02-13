//Created Date: 13July2015
//https://developer.salesforce.com/trailhead/project/salesforce_developer_workshop/using_javascript_in_visualforce

global with sharing class HotelRemoter {

    @RemoteAction
    global static List<Hotel__c> findAll() {
        return [SELECT Id, Name, Location__Latitude__s, Location__Longitude__s
                    FROM Hotel__c];
    }

}