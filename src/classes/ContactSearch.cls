/* Class Name: ContactSearch
 * Created Date: 20Dec2014
 * Purpose: Exercise 2
 * URL:https://developer.salesforce.com/trailhead/force_com_programmatic_beginner/apex_database/apex_database_soql
 * Description: For this challenge, you will need to create a class that has a method accepting two strings. 
 * 				The method searches for contacts that have a last name matching the first string and a 
 * 				mailing postal code (API name: MailingPostalCode) matching the second. 
 * 				It gets the ID and Name of those contacts and returns them.
*/

//The Apex class must be called 'ContactSearch' and be in the public scope.
public class ContactSearch {

    //The Apex class must have a public static method called 'searchForContacts'.
    
    //The 'searchForContacts' method must accept two incoming strings as parameters, 
    //find any contact that has a lastname matching the first, 
    //and mailing postal code matching the second string. 
    //The method should return a list of Contact records with atleast the ID and Name fields.
    public static List<Contact> searchForContacts (string LName, string PostalCode){
        List<contact> ContactList = [SELECT Id, 
                                     		Name, 
                                     		FirstName, 
                                     		LastName, 
                                     		MailingPostalCode 
                                     FROM Contact WHERE LastName =: LName AND MailingPostalCode =: PostalCode];
        
        //The return type for 'searchForContacts' must be 'List<Contact>'.
        return ContactList;
    }
}