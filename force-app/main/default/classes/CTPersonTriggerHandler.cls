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

    public static void afterUpdate(List<Person__c> newRecords , Map<Id,Person__c> oldRecordsMap ){
        Set<Id> statusChange = new Set<Id>();
        Set<Id> redStatus = new Set<Id>();

        for (Person__c person : newRecords) {
            // checks if the health status of a person was changed 
            if (person.Health_Status__c != oldRecordsMap.get(person.id).Health_Status__c) {
                statusChange.add(person.Id);
           
            }
            if (person.Health_Status__c == 'Red' && oldRecordsMap.get(person.id).Health_Status__c != 'Red') {
                redStatus.add(person.id);
            }

        }
        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(redStatus);

        Set<Id> orangeStatus = new Set<Id>();
        Set<Id> yellowStatus = new Set<Id>();

        List<Person__c> personToUpdate = new List<Person__c>();

        //adds cohabitants
       orangeStatus.addAll(CTPersonController.getCohabitants(redStatus,alreadyProcessed));
       //adds primaryContacts 
        Set<Id> primaryContacts = CTPersonController.getPriamaryContact(redStatus,alreadyProcessed);
       orangeStatus.addAll(primaryContacts);
        //adds neightbors
       yellowStatus.addAll(CTPersonController.getNeighbours(redStatus,alreadyProcessed));
        //adds secondaryContacts
       yellowStatus.addAll(CTPersonController.getSecondaryContacts(primaryContacts,alreadyProcessed));

      for (Id pe : orangeStatus) {
        personToUpdate.add(new Person__c(Id = pe, Health_Status__c = 'Orange'));
        }
    for (Id pe : yellowStatus) {
        personToUpdate.add(new Person__c(Id = pe, Health_Status__c = 'Yellow'));
        }
        
        if (!personToUpdate.isEmpty()) {
            Database.update(personToUpdate);
        }
        
        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationByLocationIds(statusChange);

        if (!locationTraces.isEmpty() && locationTraces != null ) {
            
            Set<Id> locationIds = new Set<Id>();
            for (Location_Tracing__c trace : locationTraces) {
                locationIds.add(trace.Location__c);
                
            }
            
        }


    }

    
    
}