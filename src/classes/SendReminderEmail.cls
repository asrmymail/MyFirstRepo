global class SendReminderEmail implements Database.Batchable<sObject> {
	
    global String query;
    global String subject;
    global String body;
    global SendReminderEmail(String query, String subject, String body) {
        this.query = query;
        this.subject = subject;
        this.body = body;
	}
    global Database.QueryLocator start(Database.BatchableContext bc) {
		
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Session_Speaker__c> scope) {
    EmailManager.SendEmailMethod(scope);
    //for (Speaker__c speaker : scope) {
    //    EmailManager.SendEmailMethod(speaker.Email__c, this.subject, this.body);
    //}
	}

    global void finish(Database.BatchableContext bc) {

    }

}