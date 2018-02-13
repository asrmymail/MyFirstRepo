public with sharing class JsonJQuery_PracticePage6Controller {

    public String toDate { get; set; }

    public String fromDate { get; set; }

    public String LegacyNo { get; set; }

    public String accid { get; set; }
    
    public List<Account> ListOfAccounts {get; set;}
    
    public JsonJQuery_PracticePage6Controller(){
        accList();
    }
    
    public List<Account> accList(){
        
        ListOfAccounts = [SELECT Id,Name FROM Account LIMIT 10];
        
        return ListOfAccounts;
    } 
    
    public transient List<contact> ListOfContacts {get; set;}
    //Contact
    @RemoteAction 
    public static List<contact> childRecords(string accid){
    
        List<contact> ListOfContacts = [SELECT Id, FirstName, LastName, Phone FROM Contact WHERE AccountId=: accid];
        return ListOfContacts;
    }
    
    public String accountName { get; set; }
    public static LIST<Account> account { get; set; }
    
    
    @RemoteAction
    public static List<Account> parentRecords(String legacy, string frmDate, string toDate) {
        account = [SELECT Id, Name, Phone, Type,Fax, NumberOfEmployees, CreatedDate FROM Account];
        return account;
    }
    @RemoteAction
    public static List<Account> getAllAccount() {
        List<Account> lst = [SELECT Id, Name, Phone, Type, Fax
                   FROM Account limit 10];
        return lst;
    }
    
    
}