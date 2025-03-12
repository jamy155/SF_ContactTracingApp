public with sharing class CTLocationTiggerHandler {

    public static void beforeInsert(List<Location__c> newRecords){
        for (Location__c location : newRecords) {
            location.Status__c = 'Green';
            
        }
    }

    public static void beforeUpdate(List<Location__c> newRecords, Map<id,Location__c> oldRecordsMap){
        for (Location__c location : newRecords) {
            if(location.Status__c != oldRecordsMap.get(location.Id).Status__c){
                location.Status_Update_Date__c = Date.today();
            }
            
        }
    }

    public static void afterUpdate(List<Location__c> newRecords, Map<id,Location__c> oldRecordsMap){
        Set<Id> statusChange = new Set<Id>();
        for (Location__c location : newRecords) {
            if(location.Status__c == 'Red' && oldRecordsMap.get(location.id).Status__c != 'Red'){
                statusChange.add(location.Id);
            }
        }


       List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationByLocationIds(statusChange);

      // Set<Id> personIds = new Set<Id>();
       List<Person__c> peopleToUpdate = new List<Person__c>();

       for (Location_Tracing__c trace : locationTraces) {
       // personIds.add(trace.Person__c);
        peopleToUpdate.add(new Person__c(Id = trace.Person__c, Health_Status__c='Yellow'));
       }

       
    //    for (Id pid : personIds) {
        
    //    }

       if (!peopleToUpdate.isEmpty()) {
        update peopleToUpdate;
        
       }






    }

}