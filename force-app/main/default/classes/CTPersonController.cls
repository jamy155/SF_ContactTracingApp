public with sharing class CTPersonController {
  
    public static String getToken(String mobileNO){
        Blob value = Blob.valueOf(mobileNO);
        Blob hash = Crypto.generateDigest('MD5', value);

        // get the string value of hash blob
        return EncodingUtil.base64Encode(hash);
    }


    public static List<Person__c> getRecentHealthChanges (){

            // returns Health Changes by when they were changed
       return [SELECT Id, Name, Mobile__c, Health_Status__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100] ;

    }

}