public with sharing class CTPersonController {

   
    public static String getToken(String mobileNO){
        Blob value = Blob.valueOf(mobileNO);
        Blob hash = Crypto.generateDigest('MD5', value);

       // get the string value of hash blob
        return EncodingUtil.base64Encode(hash);
    }

    // returns Health Changes by when they were changed
    public static List<Person__c> getRecentHealthChanges (){

        
       return [ SELECT Id, Name, Mobile__c, Health_Status__c, Token__c 
                FROM Person__c 
                ORDER BY Status_Update_Date__c DESC NULLS LAST 
                LIMIT 100] ;

    }

    // returns People by Name , Token or Mobile 
    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm = searchTerm + '%';

       return [ SELECT Id, Name, Health_Status__c, Mobile__c, Token__c 
                FROM Person__c 
                WHERE Name LIKE :searchTerm 
                    OR Token__c LIKE :searchTerm
                    OR Mobile__c LIKE :searchTerm
                ORDER BY Status_Update_Date__c DESC NULLS LAST] ;

    }

    // returns a person  by Id
    public static Person__c getPersonById(String personID){
      
       List<Person__c> people =  [ SELECT Id, Name, Mobile__c, Health_Status__c, Token__c 
                FROM Person__c 
                WHERE Id = :personID] ;

        if(!people.isEmpty() && people != null){
          return  people[0]; 
        }

        return null;
               
    }

    public static Map<String,Integer> getHealthStatusCount(){
        Map<String,Integer> healthCountMap = new Map<String,Integer>();

        //gets count of each Health Status 
        for( AggregateResult ar : [ SELECT Health_Status__c, COUNT(Id) total 
                                    FROM Person__c 
                                    GROUP BY Health_Status__c] ) {

            String healthStatus = String.valueOf(ar.get('Health_Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));

            healthCountMap.put(healthStatus, count);
        }
        return healthCountMap;
    }

    //returns the cohabitants 
    public static Set<Id> getCohabitants(Set<Id> personIds){

        
        List<String> healthStatus = new List<String>{'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces =  [ SELECT Person_1__c, Person_2__c 
                                                    FROM People_Tracing__c 
                                                    WHERE (Person_1__c IN :personIds OR Person_2__c IN :personIds ) AND Contact_Type__c = 'Cohabitant'
                                                    AND (Person_1__r.Health_Status__c IN :healthStatus OR Person_2__r.Health_Status__c IN :healthStatus ) ];

        Set<Id> cohabitants = new Set<Id>();                                            
        for (People_Tracing__c pt : peopleTraces) {
            if (!personIds.contains(pt.Person_1__c)) {
                cohabitants.add(pt.Person_1__c);
            }
            if (!personIds.contains(pt.Person_2__c)) {
                cohabitants.add(pt.Person_2__c);
            }
            
        }
        return cohabitants;

    }

    public static Set<Id> getNeighbours(Set<Id> personIds){
        
        List<People_Tracing__c> peopleTraces =  [ SELECT Person_1__c, Person_2__c 
                                                    FROM People_Tracing__c 
                                                    WHERE (Person_1__c IN :personIds OR Person_2__c IN :personIds ) AND Contact_Type__c = 'Neighbour'
                                                    AND (Person_1__r.Health_Status__c = 'Green' 
                                                        OR Person_2__r.Health_Status__c = 'Green' ) ];

        Set<Id> neighbours = new Set<Id>();                                            
        for (People_Tracing__c pt : peopleTraces) {
            if (!personIds.contains(pt.Person_1__c)) {
                neighbours.add(pt.Person_1__c);
            }
            if (!personIds.contains(pt.Person_2__c)) {
                neighbours.add(pt.Person_2__c);
            }
            
        }
        return neighbours;

    }

    public static Set<Id> getPriamaryContact(Set<Id> personIds){
        
        List<String> healthStatus = new List<String>{'Green', 'Yellow'};
        
        List<People_Tracing__c> peopleTraces =  [ SELECT Person_1__c, Person_2__c 
                                                    FROM People_Tracing__c 
                                                    WHERE (Person_1__c IN :personIds OR Person_2__c IN :personIds ) 
                                                    AND Contact_Type__c = 'Other'
                                                    AND Contact_Date__c = LAST_N_DAYS:10
                                                    AND (Person_1__r.Health_Status__c IN :healthStatus 
                                                        OR Person_2__r.Health_Status__c IN :healthStatus ) ];

        Set<Id> priamaryContacts = new Set<Id>();                                            
        for (People_Tracing__c pt : peopleTraces) {
            if (!personIds.contains(pt.Person_1__c)) {
                priamaryContacts.add(pt.Person_1__c);
            }
            if (!personIds.contains(pt.Person_2__c)) {
                priamaryContacts.add(pt.Person_2__c);
            }
            
        }
        return priamaryContacts;

    }

     public static Set<Id> getSecondaryContacts(Set<Id> primaryContactIds ){
        
        List<People_Tracing__c> peopleTraces =  [ SELECT Person_1__c, Person_2__c 
                                                    FROM People_Tracing__c 
                                                    WHERE (Person_1__c IN :primaryContactIds OR Person_2__c IN :primaryContactIds ) 
                                                    AND Contact_Type__c = 'Other'
                                                    AND Contact_Date__c = LAST_N_DAYS:10
                                                    AND (Person_1__r.Health_Status__c = 'Green' 
                                                        OR Person_2__r.Health_Status__c = 'Green' ) ];

        Set<Id> secondaryContacts = new Set<Id>();                                            
        for (People_Tracing__c pt : peopleTraces) {
            if (!secondaryContacts.contains(pt.Person_1__c)) {
                secondaryContacts.add(pt.Person_1__c);
            }
            if (!secondaryContacts.contains(pt.Person_2__c)) {
                secondaryContacts.add(pt.Person_2__c);
            }
            
        }
        return secondaryContacts;

    }

}