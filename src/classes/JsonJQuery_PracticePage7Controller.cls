public with sharing class JsonJQuery_PracticePage7Controller {

    public JsonJQuery_PracticePage7Controller(ApexPages.StandardController controller) {
        
        
    }

    public static LIST<Contact> LContact { get; set; }
    
    //getset Variables
    public string fromDate {get; set;}
    public string toDate {get; set;}
    public static List<Account> lOrderList {get; set;}
    //constructor
    public JsonJQuery_PracticePage7Controller(){
        getAllAccount('2015-07-01', '2015-01-01');
    }
    
    @RemoteAction
    public static List<Contact> getContact(Id ParentId) {
        LContact = [SELECT Id, FirstName, LastName
                   FROM Contact WHERE AccountId = :ParentId];
        return LContact;
    }
    
    @RemoteAction
    public static List<Account> getAllAccount(string frmDt, string toDt) {

        string soql = 'SELECT id, Name, Phone, Type, NumberOfEmployees FROM Account';
        system.debug('----frmDt '+frmDt + ' toDt '+toDt);
        soql += ' WHERE';
        soql += ' CreatedDate >= ' + frmDt + 'T00:00:00.000Z' ;
        soql += ' AND CreatedDate <= ' + toDt + 'T00:00:00.000Z' ;
        soql += ' Limit 20';
        system.debug('---->soql: '+soql);

        
        
        try {
         lOrderList = Database.query(soql);
        } catch (Exception e) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
        }

        return lOrderList;
    }
        
}