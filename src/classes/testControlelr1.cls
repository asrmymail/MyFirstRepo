public with sharing class testControlelr1 {

    public PageReference savecallm() {
        insert clm;
        return null;
    }

    public CallLogMaster__c clm{get;set;}
    public testControlelr1(){
        clm=new CallLogMaster__c();
    }
}