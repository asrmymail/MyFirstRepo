public with sharing class CTIDeciderPageController {

    public PageReference redirectToCallLog() {
        
        System.Debug('ACCOUNT IDS:' + ' ' + accountIds);
        //Muti Matching record scenario
        
        if(sCallType == 'Inbound') // In bound Call
        {
            if(sCallDuration == '' || sCallDuration == Null)
            {
            if(accountIds.size()>1  ){
                system.debug('-------accountIds '+accountIds);
                doInsertCallLogWithBasicInfo(sContactId);
                
                pagereference ref=new pagereference('/apex/CTI_CustomSearchPage?ids='+accountIds+'&ANI='+ANI +'&UCID=' + UCID);
                System.debug('*****************Multi Match*********************'+'\'/apex/CTI_CustomSearchPage?ids='+accountIds+'&ANI='+ANI);
                return ref;
            }
            }
            //Single Match Scenario
            if((sCallDuration == '' || sCallDuration == Null))
            
            {
                System.debug('*****Contact Id************'+sContactId );
                
                doInsertCallLogWithBasicInfo(sContactId);         
                PageReference ref = new PageReference('/apex/CTI_CreateACallLog?id='+ sAccountId +'&contactId='+ sContactId +'&CallType='+ sCallType +'&ActivityDate='+ sCallStartTime + '&CallDuration='+ sCallDuration + '&UCID=' + UCID + '&ANI=' + ANI);
                System.debug('*****************Single Match*********************'+'\'/apex/CTI_CreateACallLog?id='+ sAccountId +'&contactId='+ sContactId +'&CallType='+ sCallType +'&ActivityDate='+ sCallStartTime + '&CallDuration='+ sCallDuration + '&UCID=' + UCID + '&ANI=' + ANI);
                return ref;
            }       
            //Upsert Operation to update End Call Parameters  
            if((sCallDuration != '' || sCallDuration != Null))
            {
                System.debug('*****dtCallStartTime '+dtCallStartTime+' ****sCallDuration in Page Reference Method****** '+sCallDuration+' ********Call End Time****' +sCallEndTime);
                system.debug('*****Subject '+sSubject);
                
                //Update Operation while wrapping up call based On UCID
                
                string currentAccount = '';
                string currentCont = '';
                
                List<CallLogMaster__c> clmast = new List<CallLogMaster__C>();
                clMast = [select id, Name, Customer__c, Contact__c,AgentName__c, CallstartedOn__c, CallEndedOn__c,
                Type__C,Call_Duration__c from  CallLogMaster__c where UCID__C =: UCID 
                ORDER BY CreatedDate DESC limit 1];
                
                List<CallLogMaster__C> updateList = new List<CallLogMaster__C>();
                if(!clMast.isEmpty())
                {
                
                    for(CallLogMaster__c CallLog:clMast)
                    {
                            system.debug('*********Call Log Id'+CallLog.Id + ' CallLog No: ' +CallLog.Name);
                            //realigning other value related to UCID pertaining to the Call
                            system.debug('--- If Condition ---dtCallEndTime '+dtCallEndTime);
                            currentAccount =  CallLog.Customer__C;
                            currentCont = CallLog.contact__c;
                            CallLog.CallEndedOn__c = dtCallEndTime;
                            CallLog.CallstartedOn__c = dtCallStartTime;
                            CallLog.Call_Duration__c = decimal.ValueOf(sCallDuration);
                            //CallLog.Subject__c= sSubject; 
                            CallLog.UCID__C = UCID;
                            CallLog.type__C = sCallType;
                            updateList.add(CallLog);
                    }
                    System.debug('Current Update List:' + ' ' + updateList);
                    update updateList ; // Once successful do upsert operation based on UCID
                }
                
                PageReference ref = null;
                if(currentAccount !=null && currentCont !=null)
                {
                    ref = new PageReference('/' + currentAccount);
                }
                else
                {
                    ref = new PageReference('/apex/CTIPOP?mode=CallComplete');
                }
                
                return ref;
            
            }
            
        }
        
        if(sCallType == 'Outbound') //Outbound Call Type
        {
        
            doInsertCallLogOnOutbound();
            //Get Account for the WHOID
            string contid = '';
            if(ApexPages.currentPage().getParameters().get('whoId') !=null)
            {
                contid = ApexPages.currentPage().getParameters().get('whoId');
                sContactId = contid;
                List<Contact> cntlist = new List<Contact>();
                cntlist = [SELECT ACCOUNTID FROM CONTACT WHERE ID=:sContactId limit 1];
                if(!cntlist.isEmpty())
                {
                    for(Contact cx:cntList)
                    {
                        sAccountId = cx.AccountId;
                    }
                }
                
                PageReference ref = new PageReference('/apex/CTI_CreateACallLog?id='+ sAccountId +'&contactId='+ sContactId +'&CallType='+ sCallType +'&ActivityDate='+ sCallStartTime + '&CallDuration='+ sCallDuration + '&UCID=' + UCID + '&ANI=' + ANI);
                return ref;
                
            }
            else
            {
                sContactId = '';
                sAccountId = '';
                PageReference ref = new PageReference('/apex/CTI_CreateACallLog?id='+ sAccountId +'&contactId='+ sContactId +'&CallType='+ sCallType +'&ActivityDate='+ sCallStartTime + '&CallDuration='+ sCallDuration + '&UCID=' + UCID + '&ANI=' + ANI);
                return ref  ;  
            
            }
            
            
            
        
        }
        
        
        return null;
    }
    
    public String sAccountId { get; set; }

    public String sContactId { get; set; } 

    public Datetime dtCallStartTime {get; set;}    
    
    public String sCallType {get; set;} 
    
    public string sCallDuration { get; set; } 
    
    public String sCallStartTime { get; set; }
    
    public string sCallEndTime { get; set; }
    
    public Datetime dtCallEndTime { get; set; }  
    
    public string UCID{get;set;}
    
    public string ANI { get; set; }
    
    public Set<string> accountIds { get; set; }
    
    public string sSubject { get; set; }

    //------------- constructor
    public CTIDeciderPageController(){

        accountIds=new set<String>();
        ANI = ApexPages.currentPage().getParameters().get('ANI') == null ? '' : ApexPages.currentPage().getParameters().get('ANI');
        if(ANI.length()==10){
            system.debug('------ANI Before Conversion '+ANI);
            ANI = '(' + ANI.substring(0, 3) + ') ' + ANI.substring(3, 6) + '-' + ANI.substring(6); 
            system.debug('------ANI After Conversion '+ANI);
        }else{
            //here needs the twicking for populating Contact based on Contact Phone
            ANI = ANI ; 
        }
        
        if(ApexPages.currentPage().getParameters().get('ANI') != null ) // If direc
        {
            List<Contact> conLists = new List<Contact>();
            conLists  = [SELECT Id, AccountId, Account.Name, FirstName, lastname FROM Contact WHERE Phone LIKE: ANI ]; 
            if(!conLists.isEmpty())
            {
                
                for(Contact Con: conLists)
                {
                    system.debug('-------Account '+con.Account.Name);
                    system.debug('-------Contact '+Con.FirstName+' '+con.LastName);
                    accountIds.add(Con.AccountId);
                    sAccountId = Con.AccountId;
                    sContactId = Con.Id;
                }    
                //Finally based 
                
            } 
            else
            {
                sContactId = '';
                
            }   
            
        }
        else
        {
            sContactId = '';
        }
        if(ApexPages.currentPage().getParameters().get('contactId') !=null )
        {
                sContactId = ApexPages.currentPage().getParameters().get('contactId');
        }
       
        //sAccountId = ApexPages.CurrentPage().getParameters().get('id') !=null ? ApexPages.CurrentPage().getParameters().get('id') : '';
        
        
        //Call End Parameters
        sCallDuration = ApexPages.currentPage().getParameters().get('CallDurationInSeconds') == null ? '' : ApexPages.currentPage().getParameters().get('CallDurationInSeconds');
        sCallStartTime = ApexPages.currentPage().getParameters().get('ActivityDate') == null ? '' : ApexPages.currentPage().getParameters().get('ActivityDate'); 
        System.debug('START TIME:' + ' ' +  sCallStartTime);
        if(sCallStartTime != '' && sCallStartTime !=null ) // If direc
        {
            //dtCallStartTime = dateTime.parse(sCallStartTime);
            dtCallStartTime = dateTime.ValueOf(sCallStartTime);
            sCallDuration = ApexPages.currentPage().getParameters().get('CallDurationInSeconds') == null ? '300' : ApexPages.currentPage().getParameters().get('CallDurationInSeconds');
            system.debug('------sCallDuration '+sCallDuration );
            if(sCallDuration != '' && sCallDuration !=null) // If direc
            {
             //dtCallEndTime = dateTime.parse(sCallStartTime).addSeconds(integer.valueOf(sCallDuration));
             dtCallEndTime = dateTime.valueOf(sCallStartTime).addSeconds(integer.valueOf(sCallDuration));
             system.debug('------dtCallEndTime '+dtCallEndTime);
            }
        }
        
        
        
        //sContactId = ApexPages.currentPage().getParameters().get('whoId') == null ? '' : ApexPages.currentPage().getParameters().get('whoId');
        sCallType = apexpages.currentpage().getparameters().get('CallType') !=null ? apexpages.currentpage().getparameters().get('CallType'): 'Inbound' ;
        /*sCallStartTime = ApexPages.currentPage().getParameters().get('ActivityDate') == null ? '' : ApexPages.currentPage().getParameters().get('ActivityDate'); 
        system.debug('------sCallStartTime '+sCallStartTime);
        if(sCallStartTime != '') // If direc
        {
        dtCallStartTime = dateTime.parse(sCallStartTime);
        }
        sCallDuration = ApexPages.currentPage().getParameters().get('CallDurationInSeconds') == null ? '300' : ApexPages.currentPage().getParameters().get('CallDurationInSeconds');
        system.debug('------sCallDuration '+sCallDuration );
        if(sCallDuration != '') // If direc
        {
            dtCallEndTime = dateTime.parse(sCallStartTime).addSeconds(integer.valueOf(sCallDuration));
        }*/
        
        UCID = ApexPages.currentPage().getParameters().get('UCID') == null ? '' : ApexPages.currentPage().getParameters().get('UCID') ;
        
        sSubject = ApexPages.currentPage().getParameters().get('Subject') == null ? '' : ApexPages.currentPage().getParameters().get('Subject') ;
        
    }
    
    public void doInsertCallLogWithBasicInfo(string callerid)
    {
            CallLogMaster__c CallLog= new CallLogMaster__c();
            if(callerid!= '') // For matched records
            {
            System.debug('*****Contact Id* In If Condition***********'+sContactId );
            CallLog= new CallLogMaster__c ( Contact__c = callerid, UCID__c = UCID, 
            Subject__c= 'Test', AgentName__c = userinfo.getuserid(),Caller__C = ANI);
            system.debug('-----------------Inserted CallLog Record Id: '+CallLog.Id);
            }
            else // For unmatched records, do create without Contact
            {
                CallLog= new CallLogMaster__c (UCID__c = UCID, 
                Subject__c= 'Test', AgentName__c = userinfo.getuserid(),Caller__C = ANI);
            }
            
            insert CallLog;
    }
    
    //OUT BOUND CALL BLOCK
    public void doInsertCallLogOnOutbound()
    {
        List<CallLogMaster__C> clObList = new List<CallLogMaster__c>();
        CallLogMaster__C cml = new CallLogMaster__c();
        cml.CallEndedOn__c = dtCallEndTime;
        cml.CallstartedOn__c = dtCallStartTime;
        cml.Call_Duration__c = decimal.ValueOf(sCallDuration);
        //CallLog.Subject__c= sSubject; 
        cml.UCID__C = UCID;
        cml.type__C = sCallType;
        cml.Caller__c = ANI;
        clObList.add(cml);
        insert clObList;
    
    }
    
    
    //END
    

}