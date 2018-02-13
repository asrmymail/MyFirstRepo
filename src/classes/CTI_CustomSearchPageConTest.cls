@isTest
public class CTI_CustomSearchPageConTest{

    static testmethod  void  Method1(){
        List<Account> accts = [SELECT id,Name FROM Account WHERE Name= 'Test Account 1' LIMIT 1];
        system.assertEquals('Test Account 1',accts[0].Name);
        ApexPages.currentPage().getParameters().put('ANI','9908960750');
        ApexPages.currentPage().getParameters().put('ids',accts[0].id);
        
        CTI_CustomSearchPageCon ccsp=new CTI_CustomSearchPageCon();
            boolean testshowhidePB =ccsp.showhidePB;
    }
    
    static testmethod  void  Method2(){
        List<Account> accts = [SELECT id,Name FROM Account WHERE Name= 'Test Account 1' LIMIT 1];
        system.assertEquals('Test Account 1',accts[0].Name);   
        List<Contact> lstcon = [SELECT id, LastName FROM Contact LIMIT 1];
        system.assertNotEquals('Test Account 1',lstcon[0].LastName); 
        ApexPages.currentPage().getParameters().put('CallDurationInSeconds','120');
        String testsContactId=ApexPages.currentPage().getParameters().put('contactId',lstcon[0].id);
        ApexPages.currentPage().getParameters().put('ANI','99089607');
        ApexPages.currentPage().getParameters().put('ids',accts[0].id);
        CTI_CustomSearchPageCon ccsp=new CTI_CustomSearchPageCon();
            boolean testshowhidePB =ccsp.showhidePB;
    }

    
    //Test Data
    @testSetup static void setUptestData(){
        
        List<Account> AccList = new List<Account>();
        for(integer i=0; i<5; i++){
            AccList.add(new Account(Name = 'Test Account '+i));
        }
        insert AccList;
        
        List<contact> ConList =  new List<Contact>();
        List<AssetHeader__c> assHdr = new list<AssetHeader__c>();
       
        for(integer j=0; j<5; j++){
            Account acct = AccList[j];
            // For each account just inserted, add Contacts
            for (Integer k=0;k<10;k++) {
                ConList.add(new Contact(FirstName=acct.Name, 
                                        LastName= ' Contact ' + k,
                                        Phone=k+'23456789'+k,
                                        AccountId=acct.Id));
            }
            assHdr.add(new AssetHeader__c(Customer__c=acct.Id, Name='TA '+j));
        }
        insert conList;
        insert assHdr;

        List<AssetNumber__c> lstAsstNum = new List<AssetNumber__c>();
        for (Integer l=0; l<5; l++){
            AssetHeader__c assH = assHdr[l]; 
            // For each AssetHeader just inserted, add Asset Number
            for (Integer m=0;m<10;m++) {
                lstAsstNum.add(new AssetNumber__c(AssetHeader__c=assH.Id,  
                                              Name='100'+m));  
            }   
        }
        insert lstAsstNum;
    }
}