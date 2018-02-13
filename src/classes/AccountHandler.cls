/* Class Name: AccountHandler
 * Created Date: 20Dec2014
 * Purpose: Exercise 2
 * URL: https://developer.salesforce.com/trailhead/force_com_programmatic_beginner/apex_database/apex_database_dml
*/
//The Apex class must be called 'AccountHandler' and be in the public scope
public class AccountHandler {
    
    public integer CurrencyValue {get; set; }
    public boolean check {get; set; }
    
    public AccountHandler(ApexPages.StandardController controller) {

    }

        
    //The Apex class must have a public static method called 'insertNewAccount'.
    public static Account insertNewAccount(string AccountName){
        
        //The 'insertNewAccount' method must accept an incoming string as a parameter, 
        //name the account after the parameter, 
        //insert it into the system and then return the account record.
        
        Account Acc = new Account(Name=AccountName);
        //The 'insertNewAccount' method must also accept an empty string, 
        //catch the failed DML and return null.
        try
        {
            insert Acc;
            system.debug('Account Id: '+Acc.Id); 
        }
        catch(system.DmlException dmlEx)
        {
            return null;
        } 
        
        //return the account record.
        return Acc;
    }
    
}