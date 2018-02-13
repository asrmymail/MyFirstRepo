public with sharing class JsonJQuery_PracticePage2 {

    Private list<account> acc;
    
    public List<accountWrap> accountList { get; set; }
    public JsonJQuery_PracticePage2 (){
        List<contactWrap> cw;
        accountList = new List<accountWrap>();
        acc = [select id,name,industry,billingcountry,createdbyid,(select id,name,email,phone from contacts) from account limit 2000];
        for(account a:acc){
            cw = new list<contactWrap>();
            For(contact co : a.contacts){
               cw.add(new contactWrap(co));
            }
            accountList.add(new accountWrap(a,false,cw));
        }
    }
    
    public class accountWrap{
        public account oAccount{get;set;}
        public boolean isSelected{get;set;}
        public List<contactWrap> contactset{get;set;}
        public accountWrap(account a,boolean b, List<contactWrap> c){
            oAccount=a;
            isSelected=b;
            contactset =c;            
        }
    }
    
    public class contactWrap{
        public contact oContact{get;set;}
        public boolean isSelected{get;set;}        
        public contactWrap(contact a){
            oContact=a;
            isSelected=false;                       
        }
    }
    
}