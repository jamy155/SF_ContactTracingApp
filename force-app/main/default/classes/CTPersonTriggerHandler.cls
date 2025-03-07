public with sharing class CTPersonTriggerHandler {

    public static void beforeInsert(List<Person__c> newRecords){
            // update health status to green
            // generate unique tokne for the person record 
            for(Person__c person: newRecords){
                person.Health_Status__c = 'Green';
                person.Token__c = CTPersonController.getToken(person.Mobile__c);
            }
    }

    public static void beforeUpdate(List<Person__c> newRecords , Map<id,Person__c> oldRecordsMap ){
        for (Person__c person : newRecords) {
            // checks if the health status of a person was changed 
            if (person.Health_Status__c != oldRecordsMap.get(person.id).Health_Status__c) {
                // changes the update date to today 
                person.Status_Update_Date__c = Date.today();
            }
             
        }
    }
    
}