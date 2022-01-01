class Constants {
  //late String id;

  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static String monthPattern = r'^(0?[13-9]|1[012])$';


  static String baseUrl = 'https://www.astrotak.com/astroapi/api/';//'http://198.211.55.134:8080/api/v1/';
  static String baseUrlImage = 'https://uat.taxiapp.uk.com/storage/';
  static String baseUrlPdf = 'https://uat.doktalk.uk.com/pdfview/';


  // static String baseUrl = 'https://dev.taxiapp.uk.com/api/';
  // static String baseUrlImage = 'https://dev.taxiapp.uk.com/storage/';
  // static String baseUrlPdf = 'https://dev.taxiapp.uk.com/pdfview/';
 static String getastro = 'agent/all';
 static String getlocationastro = 'location/place?inputPlace=';
  //Body:- {"inputPlace":"Delhi"}';
 static String getpanchang = 'horoscope/daily/panchang';
  
}