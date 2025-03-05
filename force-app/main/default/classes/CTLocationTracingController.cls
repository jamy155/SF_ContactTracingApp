public with sharing class CTLocationTracingController {
    // get the Location Tracing records by the location id 
        public static List<Location_Tracing__c> getVistors(String locationId){

            return [SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Token__c , Person__r.Health_Status__c 
                FROM Location_Tracing__c
                WHERE Id = :locationId
                ORDER BY Visit_Date__c DESC];

        }

        // gets all Location Tracing records by person ids 
        public static List<Location_Tracing__c> getLocationByPersonIds(Set<Id> personIds){

            return [SELECT Id, Person__c, Location__c
                FROM Location_Tracing__c
                WHERE Person__c = :personIds
                AND Visit_Date__c = LAST_N_DAYS:10];

        }

            // gets all Location Tracing records by location ids 
         public static List<Location_Tracing__c> getLocationByLocationIds(Set<Id> locationIds){

            return [SELECT Id, Person__c, Location__c
                FROM Location_Tracing__c
                WHERE Location__c = :locationIds
                AND Person__r.Health_Status__c = 'Green'
                AND Visit_Date__c = LAST_N_DAYS:10];

        }

        public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTraces ){

            //store unique location and persons ids form 
            Set<Id> locationsIds = new Set<Id>();
            Set<Id> personIds = new Set<Id>();

            for (Location_Tracing__c trace : newLocationTraces) {

                locationsIds.add(trace.Location__c);
                personIds.add(trace.Person__c);
                
            }

            //map pf location id, set of person ids 
            Map<Id,Set<Id>> mapOfExistingRecords = new Map<Id,Set<Id>>();

            // query existing location tracing records
           List<Location_Tracing__c> existingRecords = [SELECT Id, Person__c, Location__c
                                                        FROM Location_Tracing__c
                                                        WHERE Person__c IN :personIds
                                                        AND Location__c IN :locationsIds  ];

             // list of dulicates records                                                
            List<Location_Tracing__c> duplicates = new List<Location_Tracing__c>();

            if (!existingRecords.isEmpty() && existingRecords != null) {
                for(Location_Tracing__c trace : existingRecords){

                    if(! mapOfExistingRecords.containsKey(trace.Location__c)){
                        mapOfExistingRecords.put(trace.Location__c, new Set<Id>());
                    }
                    mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);
                }

                // loop over new location tracing records to find the duplicate 
                for (Location_Tracing__c trace : newLocationTraces) {
                    if(mapOfExistingRecords.containsKey(trace.Location__c)&& mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__c)){
                        duplicates.add(trace);
                    }
                    
                }
                
            }
            return duplicates;

        }

}