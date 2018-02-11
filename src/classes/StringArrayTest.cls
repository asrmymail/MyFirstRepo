/* Class Name: StringArrayTest
 * Created Date: 20Dec2014
 * Purpose: Exercise 1
 * URL: https://developer.salesforce.com/trailhead/force_com_programmatic_beginner/apex_database/apex_database_intro
*/
public class StringArrayTest {

    
    // return List of strings will determin the integer Parameter
    // public static method
    public static List<string> generateStringArray(integer n){
        system.debug('***Method Called');
        //list Collection
        List<string> listOfString = new List<string>();
        //passing the integer parameter in to the for loop
        //running n number of times to add Test 'n' 
        for(integer i=0; i<n; i++){
            listOfString.add('Test '+i);
            system.debug('***** N: '+i);
        }
        system.debug('*****: '+listOfString);
        system.debug('***Method End');
        return listOfString;
    }
}