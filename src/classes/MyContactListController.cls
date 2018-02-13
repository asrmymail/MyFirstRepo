//https://developer.salesforce.com/trailhead/project/quickstart-lightning-components/quickstart-lightning-components2
public class MyContactListController{
    @AuraEnabled
    public static List<Contact> getContacts() {
        return [Select Id, Name, Email, Title, Phone From Contact];
    }
}