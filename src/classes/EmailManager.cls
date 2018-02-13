public class EmailManager {
	
    public static void SendEmailMethod(List<Session_Speaker__c> RecordsList){
        
        system.debug('***1--RecordList Count: '+RecordsList.size());
        
        //list of emails
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        //add mail

        for(Session_Speaker__c spkList: [SELECT id, Name, Session__r.Name, Session__r.Session_Date__c, Speaker__r.First_Name__c, Speaker__r.Last_Name__c, Speaker__r.Email__c FROM Session_Speaker__c WHERE id IN: RecordsList AND Speaker__r.Email__c!= null]){        
        	system.debug('***3--Entered ForLoop '+spkList.Speaker__r.Email__c);
            
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            String address = spkList.Speaker__r.Email__c;
            String subject = 'Speaker Confirmation';
            String message = 'Dear ' + spkList.Speaker__r.First_Name__c + ',\nYour session "' + spkList.Session__r.Name + '" on ' + spkList.Session__r.Session_Date__c + ' is confirmed.\n\n' + 'Thanks for speaking at the conference!';
            String[] toAddresses = new String[] {address};
            singleMail.setToAddresses(toAddresses);
            singleMail.setSubject(subject);
            singleMail.setPlainTextBody(message);
            emails.add(singleMail);
        }
        
        //send mail
        Messaging.sendEmail(emails);
        system.debug('*****4--Email Sent');

    }
}