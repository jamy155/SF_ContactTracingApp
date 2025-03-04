public with sharing class CTPeopleTracingController {
    

        // get the Location Tracing records by the location id 
        public static List<Location_Tracing__c> getVistors(String locationId){

            return [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c , Person__r.Health_Status__c 
                FROM Location_Tracing__c
                WHERE Id = :locationId
                ORDER BY Visit_Date__c DESC];

        }

        public static List<Location_Tracing__c> getLocationByPersonIds(Set<Id> personIds){

            return [SELECT Id, Person__c, Location__c
                FROM Location_Tracing__c
                WHERE Person__c = :personIds
                AND Visit_Date__c = LAST_N_DAYS:10];

        }

         public static List<Location_Tracing__c> getLocationByLocationIds(Set<Id> locationIds){

            return [SELECT Id, Person__c, Location__c
                FROM Location_Tracing__c
                WHERE Location__c = :locationIds
                AND Person__r.Health_Status__c = 'Green'
                AND Visit_Date__c = LAST_N_DAYS:10];

        }

    
}