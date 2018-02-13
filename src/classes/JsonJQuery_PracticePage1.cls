//Scenario: Show List of Accounts in Data Table & Use @RemoteAction to get Contact Id on Click of Account Name
public with sharing class JsonJQuery_PracticePage1 {

    public String accid { get; set; }
    
    public List<Account> ListOfAccounts {get; set;}
    
    public JsonJQuery_PracticePage1(){
        accList();
    }
    
    public List<Account> accList(){
        
        ListOfAccounts = [SELECT Id,Name FROM Account LIMIT 10];
        
        return ListOfAccounts;
    } 
    
    public transient List<contact> ListOfContacts {get; set;}
    //Contact
    @RemoteAction 
    public static List<contact> getconList(string accid){
    
        List<contact> ListOfContacts = [SELECT Id, FirstName FROM Contact WHERE AccountId=: accid];
        return ListOfContacts;
    }
    public String accountName { get; set; }
    public static LIST<Account> account { get; set; }
    
    
    @RemoteAction
    public static List<Account> getAccount(String accountName) {
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account WHERE Name = :accountName];
        return account;
    }
}