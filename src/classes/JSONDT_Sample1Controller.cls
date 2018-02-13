public class JSONDT_Sample1Controller {

    
    public List<Account> Acc {get; set;}
    public String jsonString {get;set;}
    public string ObjData {get; set;}
    public List<Account> deSerialize {get; set;}
    public List<Account> ordersList {get; set;}
    
    public JSONDT_sample1Controller( ){
        //List<Account> accounts = [SELECT id, name,(SELECT FirstName, LastName from Contacts) FROM Account LIMIT 2]; 
        //String accountsJSON = JSON.serializePretty(accounts);
        //system.debug(accountsJSON);
        //getAccounts();
        //execute();
        //jsonString = prepareData();
        soql = 'SELECT id, Name, (SELECT id,name, FirstName, LastName FROM Contacts) FROM Account LIMIT 10';
        runQuery();
    }
    
    public List<Account> getAccounts (){
        List<Account> accounts = [SELECT id, name,Phone, Rating,(SELECT FirstName, LastName from Contacts) FROM Account LIMIT 10];
        String accountsJSON = JSON.serializepretty(accounts);
        system.debug(accountsJSON);
        Acc = (List<Account>) JSON.deserialize(accountsJSON, List<Account>.class);

            system.debug('************'+Acc);

        return (Acc = (List<Account>) JSON.deserialize(accountsJSON, List<Account>.class));
    }
    
    
    public class VariableParsing {
    public String aid;
    public String aname;
    public String aPhone;
    public String aRating;
    public String cFirstName;
    public String cLastName;
    
    }
    
    public void execute(){
       /* VariableParsing vParsing = new VariableParsing();
        //code to populate fields for the gCalendar is skipped
        String vCalJSON = JSON.serializepretty(vParsing);
        system.debug('***serializepretty '+vCalJSON);
        VariableParsing gCalendarDeserialized = (VariableParsing) JSON.deserialize(vCalJSON, VariableParsing.class);
        system.debug('****gCalendarDeserialized '+gCalendarDeserialized );*/
        
            List<Contact> contacts = [SELECT Id, Name FROM Contact LIMIT 10]; 
            JSONGenerator generator = JSON.createGenerator(true);   //instantiation of the generator
            generator.writeStartObject();               // Writes the starting marker of a JSON object '{'
            generator.writeNumberField('count', contacts.size());   //Writes the # of contacts 
            generator.writeEndObject();                 //Writes the ending marker of a JSON object '}'
            String jsonString = generator.getAsString();
            system.debug('*****'+jsonString);
    }
    
    @RemoteAction
    public static String prepareData(){
        List<Account> c= [SELECT id, Name, Phone, Rating,(SELECT FirstName, LastName from Contacts) FROM Account LIMIT 10]; 
         string jsonString = JSON.serializepretty(c);
         system.debug('@@@@*********@deSerialize '+jsonString);
         List<Account> deSerialize = (List<Account>)JSON.deserialize(jsonString, List<Account>.class);
         system.debug('@@@***********@@deSerialize '+deSerialize);
         string ObjData = '{"data": [{"name": "Tiger Nixon","position": "System Architect","salary": "$320,800","start_date": "2011/04/25", "office": "Edinburgh","extn": "5421"},{"name": "Garrett Winters","position": "Accountant","salary": "$170,750","start_date": "2011/07/25","office": "Tokyo","extn": "8422"},{"name": "Donna Snider","position": "Customer Support","salary": "$112,000","start_date": "2011/01/25","office": "New York","extn": "4226"}]}';
         return jsonString;
   }
    
    
    private string soql {get; set;}
    // runs the actual query
    public void runQuery() {
    
        try {
          system.debug('-----Query executed: '+soql);
          ordersList = Database.query(soql ); //+ ' limit 20');
          system.debug('ordersList----'+ordersList.size());
        } catch (Exception e) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }
    
    }
    
    public PageReference doSearch() {
        soql = 'SELECT id, Name, (SELECT id,name, FirstName, LastName FROM Contacts) FROM Account'; // LIMIT 10
        soql += ' LIMIT 30';
        system.debug('----Soql '+soql);
        runQuery();
        return null;
    }
    
    
}