trigger CTLocationTrigger on Location__c (before insert, after insert, before update , after update ) {

switch on Trigger.operationType {
    when BEFORE_INSERT {
        CTLocationTiggerHandler.beforeInsert(Trigger.new);
        
    }
    when BEFORE_UPDATE {
        CTLocationTiggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);

        
    }
}

}