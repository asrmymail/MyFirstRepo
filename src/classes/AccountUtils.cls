/*
 * url: https://developer.salesforce.com/trailhead/apex_basics_dotnet/mapping_concepts
 */
public class AccountUtils {
    List<Account> Acc { get; set; }
     static void accountsByState(string state){
        //List<Account>	Acc = [SELECT id, Name, BillingAddress FROM Account WHERE BillingAddress =: state];
        //return null;
    }
}