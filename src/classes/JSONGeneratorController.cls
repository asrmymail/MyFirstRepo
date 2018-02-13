public with sharing class JSONGeneratorController {

    public String jsonString { get; set; }
    public List<Account> accontList {get; set;}
    //define shape of Json Response salesforce
    public JSONGeneratorController (){
        jsonString = Json.SerializePretty(getAccountList());
        system.debug(jsonString);
    }
    
    public static List<Account> getAccountList(){
        

        //return ([SELECT Id, Name, OwnerId, Owner.Name, Ownership, Industry, AnnualRevenue,  Type, Rating, NumberOfEmployees, (SELECT FirstName, LastName FROM Contacts WHERE AccountId != null) FROM Account ORDER BY Name ASC LIMIT 10]);
        return ([SELECT Id, Name,Phone,  OwnerId, Owner.Name, Ownership, Industry, AnnualRevenue,  Type, Rating, NumberOfEmployees FROM Account ORDER BY Name ASC LIMIT 10]);
    }
    
    public class DataTableRow {  
      public String name { get; set; }  
      public String industry { get; set; }  
      public String owner { get; set; }  
      public String rating { get; set; }  
      public String ratingFlag { get; set; }  
      public Decimal revenue { get; set; }  
      public String revenueFlag { get; set; }  
      public String acctType { get; set; }  
      public Integer numberOfEmployees { get; set; }  
      public Id recordId { get; set; }  
    
      public DataTableRow(Account acct){  
           this.name = acct.Name;  
           this.industry = acct.Industry;  
           this.owner = acct.Owner.Name;  
           this.rating = acct.Rating;  
           this.revenue = acct.AnnualRevenue;  
           this.acctType = acct.Type;  
           this.numberOfEmployees = acct.NumberOfEmployees;  
           this.recordId = acct.Id;  
      }  
    }
    
    public String jsonDataAllAccounts {  
      get {  
           List<DataTableRow> dataRows = new List<DataTableRow>();  
           if(jsonDataAllAccounts == null){  
                for(Account acct : [SELECT Id, Name, OwnerId, Owner.Name, Ownership, Industry, AnnualRevenue,  Type, Rating, NumberOfEmployees FROM Account ORDER BY Name ASC LIMIT 10]){  
                     dataRows.add(new DataTableRow(acct));  
                }  
           }  
           jsonDataAllAccounts = JSON.serializepretty(dataRows);  
           system.debug('get set variable'+jsonDataAllAccounts);
           return jsonDataAllAccounts;   
      }  
      private set;  
    }  
    
    @RemoteAction
    public static List<Account> childRecords()
    {
        try{
            List<Account> lst = new List<Account>([SELECT id, name, Phone FROM Account limit 5]);
        return lst;
        }
        catch (Exception e) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,e.getMessage()));
        }
        return null;
    }//childRecords End
    
    /** invoked on an Ajax request */   
    public string retrieveData {
    get{
        List<Account> lstAaData = [SELECT Id, Name FROM Account LIMIT 10];

        // Create a JSONGenerator object.
        // Pass true to the constructor for pretty print formatting.
        JSONGenerator gen = JSON.createGenerator(true);

        // Write data to the JSON string.
        gen.writeStartObject();
        
        gen.writeNumberField('iTotalRecords', 14);
        gen.writeNumberField('iTotalDisplayRecords', 14);
        gen.writeFieldName('aaData');       
        gen.writeStartArray();
        for (Account acc : lstAaData)
        {       
            gen.writeStartArray();
            gen.writeString(acc.Name);
            gen.writeString(acc.Id);
            gen.writeEndArray();

        }

        gen.writeEndArray();
        gen.writeEndObject();

        string JSONString1 = gen.getAsString();  
        
        return JSONString1;   
    }
 
      private set;  
    }  
    


}