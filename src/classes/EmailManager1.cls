//Trailhead Task
//https://developer.salesforce.com/trailhead/project/salesforce_developer_workshop/creating_apex_class

public with sharing class EmailManager1{

    public static void sendMail(String address, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}