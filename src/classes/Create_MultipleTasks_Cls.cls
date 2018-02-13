public with sharing class Create_MultipleTasks_Cls {

    

  public PageReference save() {
        return null;
    }


    public CallLogMaster__c cllm{get;set;}

    public Create_MultipleTasks_Cls(){
    cllm=new CallLogMaster__c();
    wrapper=new List<TaskWrapper>();
    wrapper.add(new TaskWrapper(nextIdent++));
    
    }
    
    //public static Integer toDelIdent {get; set;}
    public static Integer addCount {get; set;}
    private Integer nextIdent=0;
    public List<TaskWrapper> wrapper {get; set;}
    
    
    
    public class TaskWrapper{
    public CallLogMaster__c callLog{get;set;}
    public integer ident{get;set;}
    public TaskWrapper(integer inIdent){
    ident=inIdent;
    callLog=new CallLogMaster__c();
    }
    }
    
    public PageReference addNewRow() {
    System.debug('**********add Count************'+addCount);
    for (Integer idx=0; idx<addCount; idx++){
     wrapper.add(new TaskWrapper(nextIdent++));
     wrapper[idx].callLog.Customer__c='0019000001BHlAy';
    }
    
    for(TaskWrapper wrp: wrapper){
    if(wrp.ident == addCount){
    //wrp.callLog.Customer__c='0019000001BHlAy';
    }
    }
    
    return null;
    }
    public integer toDelIdent{get;set;}
    public void delWrapper(){
    System.debug('************to del ident*********'+toDelIdent);
    Integer toDelPos=-1;
    for (Integer idx=0; idx<wrapper.size(); idx++){
    if (wrapper[idx].ident==toDelIdent){
    toDelPos=idx;
    }
    }
    if (-1!=toDelPos){
    wrapper.remove(toDelPos);
    }
    }
    
    public static Integer toDelIdentcon {get; set;}
    public void delWrappercon() {
    System.debug('************to del ident*********'+toDelIdentcon);
    Integer toDelPos=-1;
    for (Integer idx=0; idx<wrapper.size(); idx++){
    if (wrapper[idx].ident==toDelIdentcon){
    toDelPos=idx;
    }
    }
    if (-1!=toDelPos){
    wrapper.remove(toDelPos);
    }
    }


}