trigger CTPersonTrigger on Person__c (before insert, after insert , before update , after update ,before delete , after delete , after undelete   ) {


    switch on Trigger.operationType  {
        when BEFORE_INSERT {
            // update health status to green
            // generate unique tokne for the person record 
            CTPersonTriggerHandler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
             // checks if the health status of a person was changed 
              // changes the update date to today 
            CTPersonTriggerHandler.beforeUpdate(trigger.new, trigger.oldMap);
            
        }
    }

}