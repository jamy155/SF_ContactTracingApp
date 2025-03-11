 
 // Main Controller Class for Location__c object
 public with sharing class CTLocationController {
    
    // returns Health Status by when they were changed
    public static List<Location__c> getRecentStatusChanges (){

       return [ SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c
                FROM Location__c
                ORDER BY Status_Update_Date__c DESC NULLS LAST
                LIMIT 100] ;
    }

     // returns Location by Name , Pincode__c or Address__c 
      public static List<Location__c> searchLocation(String searchTerm){
        searchTerm = searchTerm + '%';

       return [ SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                FROM Location__c 
                WHERE Name LIKE :searchTerm 
                    OR Pincode__c LIKE :searchTerm
                    OR Address__c LIKE :searchTerm
                ORDER BY Status_Update_Date__c DESC NULLS LAST] ;

    }

    // returns a Location by Id
    public static Location__c getLocationById(String loactionId){
      
       List<Location__c> loactions =  [ SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                FROM Location__c
                WHERE Id = :loactionId] ;

        if(!loactions.isEmpty() && loactions != null){
          return  loactions[0]; 
        }

        return null;
    }

     public static Map<String,Integer> getStatusCount(){
        Map<String,Integer> healthCountMap = new Map<String,Integer>();

        //gets count of each Status 
        for( AggregateResult ar : [ SELECT Status__c, COUNT(Id) total 
                                    FROM Location__c 
                                    GROUP BY Status__c] ) {

            String status = String.valueOf(ar.get('Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));

            healthCountMap.put(status, count);
        }
        return healthCountMap;
    }

    public static void updateRedScore(Set<Id> locationIds) {
        List<Location__c> locationToUpdate = new List<Location__c>();
       List<AggregateResult> redPeopleLocation = [SELECT Location__c , COUNT(Id) total FROM Location_Tracing__c 
        WHERE Person__r.Health_Status__c='Red' 
        AND Visit_Date__c = LAST_N_DAYS:10 
        AND Location__c IN :locationIds
        GROUP BY Location__c ];

        for (AggregateResult ar : redPeopleLocation) {
            String locationId = String.valueOf(ar.get('Location__c'));
            Integer redScore = Integer.valueOf(ar.get('total'));
            String status = getStatus(redScore);
            locationToUpdate.add(new Location__c(Id = locationId, Red_Score__c=redScore ,Status__c = status));

        
        }
        if (locationToUpdate != null && !locationToUpdate.isEmpty()) {
            Database.update(locationToUpdate);
        }
        
    }

    public static String getStatus(Integer redScore){
        if(redScore == 0){
            return 'Green';
        }else if(redScore <= 5){
            return 'Yellow';
        }else if(redScore <= 10){
            return 'Orange';
        }else{
            return 'Red';
        }

    }
               
}