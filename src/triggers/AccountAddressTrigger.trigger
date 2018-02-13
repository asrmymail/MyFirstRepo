/* Trigger Name: AccountAddressTrigger
 * Created Date: 20Dec2014
 * Purpose: Exercise 1
 * URL: https://developer.salesforce.com/trailhead/force_com_programmatic_beginner/apex_triggers/apex_triggers_intro
 *
*/   
trigger AccountAddressTrigger on Account (before insert, before update) {
    
    //fire before insert & before update
    if(Trigger.isInsert || Trigger.IsUpdate){
        for(Account Acc: Trigger.new){
            if(Acc.Match_Billing_Address__c && Acc.BillingPostalCode != null){
            Acc.ShippingPostalCode = Acc.BillingPostalCode;
            }
        }
    }
}