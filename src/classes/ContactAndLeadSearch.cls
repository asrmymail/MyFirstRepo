/* Class Name: ContactAndLeadSearch
 * Created Date: 20Dec2014
 * Purpose: Exercise 5
 * URL:https://developer.salesforce.com/trailhead/force_com_programmatic_beginner/apex_database/apex_database_sosl
 * Description: 
*/

public class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(string IncommingParameter){
 		List<List<SObject>> ContactsAndLeads;	
        if(IncommingParameter!= null)
            ContactsAndLeads = [FIND :IncommingParameter IN ALL FIELDS 
                                      RETURNING  Contact(LastName), Lead(LastName)];
        return ContactsAndLeads;
        
    }
}