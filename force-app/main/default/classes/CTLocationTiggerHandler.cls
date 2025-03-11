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
}