/* Trigger Name: ClosedOpportunityTrigger
 * Created Date: 20Dec2014
 * Purpose: Exercise 2
 * URL: https://developer.salesforce.com/trailhead/force_com_programmatic_beginner/apex_triggers/apex_triggers_bulk
*/  
trigger ClosedOpportunityTrigger on Opportunity (after insert, after Update) {

    //With 'ClosedOpportunityTrigger' active, 
    //if an opportunity is inserted or updated with 
    //a stage of 'Closed Won', it will have a task 
    //created with the subject 'Follow Up Test Task'.
    List<Task> listToUpdateTask = new List<Task>();
    for(Opportunity opp: Trigger.New){
        if(opp.StageName == 'Closed Won'){
            system.debug('*****Opportunity Stage is Closed Won');
            Task tk = new Task();
            tk.WhatId = opp.id;
            tk.Subject = 'Follow Up Test Task';
            tk.priority= 'Medium';
            tk.status = 'Not Started';
            tk.description = 'Hello New Work';
            listToUpdateTask.add(tk);
        }
    }
    insert listToUpdateTask;
}