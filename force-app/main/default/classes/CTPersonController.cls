public with sharing class CTPersonController {
<<<<<<< HEAD
  
    public static String getToken(String mobileNO){
        Blob value = Blob.valueOf(mobileNO);
        Blob hash = Crypto.generateDigest('MD5', value);

        // get the string value of hash blob
        return EncodingUtil.base64Encode(hash);
=======
    public CTPersonController() {

>>>>>>> 523e01f7a9ebb2fa5fc7f300bd99f0a00124b08f
    }
}