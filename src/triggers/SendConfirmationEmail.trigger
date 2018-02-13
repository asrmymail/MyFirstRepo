trigger SendConfirmationEmail on Session_Speaker__c (After insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            system.debug('Trigger Fired');
            EmailManager.SendEmailMethod(Trigger.new);
        }
    }
}