 
 // Main Controller Class for Location__c object
 public with sharing class CTLocationController {
    
    // returns Health Changes by when they were changed
    public static List<Location__c> getRecentStatusChanges (){

       return [ SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c
                FROM Location__c
                ORDER BY Status_Update_Date__c DESC NULLS LAST
                LIMIT 100] ;
    }
}