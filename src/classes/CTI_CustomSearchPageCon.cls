public with sharing class CTI_CustomSearchPageCon {

    public String ids { get; set; }
    public boolean showhidePB { get; set; }
    public list<Account> customerData{ get; set; }
    public list<String> accIdsList{ get; set; }
    public string ANI { get; set; }
    //public String accountName { get; set; }
    //public String accountId { get; set; }
    //public string CustomerName{ get; set; }
    
    //Constructor
    public CTI_CustomSearchPageCon(){
        
        ANI = ApexPages.currentPage().getParameters().get('ANI') == null ? '' : ApexPages.currentPage().getParameters().get('ANI');
        if(ANI.length()==10){
            //system.debug('------ANI Before Conversion '+ANI);
            ANI = '(' + ANI.substring(0, 3) + ') ' + ANI.substring(3, 6) + '-' + ANI.substring(6); 
            //system.debug('------ANI After Conversion '+ANI);
        }else{
            ANI = ANI ; 
        }
        
        
        Ids = ApexPages.currentPage().getParameters().get('ids') == null ? '' : ApexPages.currentPage().getParameters().get('ids') ;
        //system.debug('---------'+Ids);
        try{
            accIdsList=new list<String>();
         ids=ids.removeStart('{');
         ids=ids.removeEnd('}');
     
        for (String idss: ids.split(', ')){
             accIdsList.add(idss);
        }

        customerData = [select id,name,Phone,(Select id,name,accountid,Email,phone from Contacts where Phone LIKE: ANI) from Account where Id IN : accIdsList ];
        //System.debug('*************accIds****************'+customerData);
        }catch(Exception ex){
            
        }

        if(customerData.size() > 0){
            showhidePB=true;
        }
    }
    
    //Method2
    /*public PageReference fetchCustomerData() {
        //System.debug('**********accountName****************'+CustomerName);
        customerData = [select id,name,Phone,(Select id,name,accountid,Email,phone from Contacts ) from Account where name LIKE : CustomerName];
        if(customerData.size() > 0){
            showhidePB=true;
        }
        return null;
    }*/

}