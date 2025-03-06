 
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
               
}