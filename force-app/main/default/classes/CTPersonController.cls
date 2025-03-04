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

}