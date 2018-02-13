@isTest
public class CTIDeciderPageControllerTest{
    
    static testmethod void Coverage(){
       List<Account> accts = new List<Account>();
        
        
            Account a = new Account();
            a.Name='TestAccount';
            a.phone='9849332418';
            
            accts.add(a);
        Account a1 = new Account();
            a1.Name='TestAccount1';
            a1.phone='9849332418';
        accts.add(a1);
        if(accts.size()>1){
            insert accts;
        }
        list<Contact> lstcon=new list<Contact>();
       
        Contact con=new Contact();
        con.FirstName = 'testing';
        con.lastname='test';
        con.accountId=accts[0].id;
        con.email='test@gmail.com';
        con.phone='9908960750';
        lstcon.add(con);
        Contact con1=new Contact();
        con1.FirstName = 'testing1';
        con1.lastname='test1';
        con1.accountId=accts[1].id;
        con1.email='test1@gmail.com';
        con1.phone='9908960750';
        lstcon.add(con1);
        if(lstcon.size()>1){
            insert lstcon;
        }
        list<CallLogMaster__c> lclogm=new list<CallLogMaster__c>();
        CallLogMaster__c clogm = new CallLogMaster__c();
        clogm.customer__c = accts[0].id;
        clogm.contact__c = lstcon[0].id;
        clogm.subject__c = 'Test';
        clogm.CallstartedOn__c = System.now();
        clogm.type__C = 'Inbound';
        lclogm.add(clogm);
        list<CallLogMaster__c> lclogm1=new list<CallLogMaster__c>();
        CallLogMaster__c clogm1 = new CallLogMaster__c();
        clogm1.customer__c = accts[0].id;
        clogm1.contact__c = lstcon[0].id;
        clogm1.subject__c = 'Test';
        clogm1.CallstartedOn__c = System.now();
        clogm1.type__C = 'Inbound';
        lclogm.add(clogm1);
        insert lclogm;
        
        ApexPages.currentPage().getParameters().put('contactId','lstcon[0].id');
        ApexPages.currentPage().getParameters().put('ANI', '9908960750');
        ApexPages.currentPage().getParameters().put('CallDurationInSeconds','120');
        ApexPages.currentPage().getParameters().put('ActivityDate',String.valueof(System.now()));
        ApexPages.currentPage().getParameters().put('whoId',lstcon[0].id);
        CTIDeciderPageController decider = new CTIDeciderPageController();
        String sCallType = clogm.type__C;
        decider.redirectToCallLog();
        decider.doInsertCallLogWithBasicInfo(lstcon[0].id);
        decider.doInsertCallLogOnOutbound();
        
    }
        
    
    static testmethod void Coverage1(){
        List<Account> accts = new List<Account>();
        
        
            Account a = new Account();
            a.Name='TestAccount';
            a.phone='9849332418';
            
            accts.add(a);
        Account a1 = new Account();
            a1.Name='TestAccount1';
            a1.phone='9849332418';
        accts.add(a1);
        if(accts.size()>1){
            insert accts;
        }
        list<Contact> lstcon=new list<Contact>();
       
        Contact con=new Contact();
        con.FirstName = 'testing';
        con.lastname='test';
        con.accountId=accts[0].id;
        con.email='test@gmail.com';
        con.phone='9908960750';
        lstcon.add(con);
        Contact con1=new Contact();
        con1.FirstName = 'testing1';
        con1.lastname='test1';
        con1.accountId=accts[1].id;
        con1.email='test1@gmail.com';
        con1.phone='9908960750';
        lstcon.add(con1);
        if(lstcon.size()>1){
            insert lstcon;
        }
        system.debug('#######lstcon#######'+lstcon[0]);
        list<CallLogMaster__c> lclogm=new list<CallLogMaster__c>();
        CallLogMaster__c clogm = new CallLogMaster__c();
        clogm.customer__c = accts[0].id;
        clogm.UCID__C = '99089607501111';
        clogm.subject__c = 'Test';
        clogm.CallstartedOn__c = System.now();
        clogm.type__C = 'Outbound';
        lclogm.add(clogm);
        
        CallLogMaster__c clogm1 = new CallLogMaster__c();
        clogm1.customer__c = accts[0].id;
        clogm1.UCID__C = '99089607501111';
        clogm1.subject__c = 'Test';
        clogm1.CallstartedOn__c = System.now();
        clogm1.type__C = 'Outbound';
        lclogm.add(clogm1);
        insert lclogm;
        
        ApexPages.currentPage().getParameters().put('contactId','lstcon[0].id');
        ApexPages.currentPage().getParameters().put('ANI', '9908960750');
        ApexPages.currentPage().getParameters().put('CallDurationInSeconds','100');
        ApexPages.currentPage().getParameters().put('ActivityDate',String.valueof(System.now()));
        apexpages.currentpage().getparameters().put('CallType','Outbound');
        ApexPages.currentPage().getParameters().put('whoId',lstcon[0].id);
        ApexPages.currentPage().getParameters().put('contactId',null);
        CTIDeciderPageController decider = new CTIDeciderPageController();
        String sCallType = clogm.type__C;
        decider.redirectToCallLog();
        decider.doInsertCallLogWithBasicInfo(lstcon[0].id);
        decider.doInsertCallLogOnOutbound();
        
    }
    
    //Multi match
    static testmethod void Coverage2(){
        
            Account a = new Account();
                a.Name='TestAccount';
                a.phone='9849332418';
                
            Account a1 = new Account();
                a1.Name='TestAccount1';
                a1.phone='9849332419';
                insert a;
              insert a1;
                       
        list<Contact> lstcon=new list<Contact>();
            Contact con=new Contact();
                con.FirstName = 'testing';
                con.lastname='test';
                con.accountId=a.id;
                con.email='test@gmail.com';
                con.phone='9908960750';
            lstcon.add(con);
            Contact con1=new Contact();
                con1.FirstName = 'testing1';
                con1.lastname='test1';
                con1.accountId=a1.id;
                con1.email='test1@gmail.com';
                con1.phone='9908960750';
            lstcon.add(con1);
            if(lstcon.size()>0)
                insert lstcon;
            
        ApexPages.currentPage().getParameters().put('ANI', '99089688');
        ApexPages.currentPage().getParameters().put('UCID', '99089607501111');
        ApexPages.currentPage().getParameters().put('CallDurationInSeconds',null);
        apexpages.currentpage().getparameters().put('CallType','Inbound');
        ApexPages.currentPage().getParameters().put('contactId',lstcon[0].id);
        
        CTIDeciderPageController decider = new CTIDeciderPageController();
        decider.doInsertCallLogWithBasicInfo(lstcon[0].id);
        decider.redirectToCallLog();
        //system.assert('/apex/CTI_CustomSearchPage?ids='+accts[0].id+'&ANI=9908960750&UCID='99089607501111' ,'/apex/CTI_CustomSearchPage?ids='+accts[0].id+'&ANI='+ANI +'&UCID=' + UCID ,  );
    }
}