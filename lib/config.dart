import 'dart:convert';

class Config {
   static String consumerKey = 'ck_9b281f559582be376df252e6cd3cb171faebe4b2';
   static String consumerSecret = 'cs_65dd63d828b2527a104898bd2d6daa567db66d77';
   static String url =  'https://delidove.com/wp-json/wc/v3/';
   static String productCat = 'products/categories';
   static String customer = 'customers';

   static String token =  base64.encode(utf8.encode(consumerKey+':'+consumerSecret));
  
 
}