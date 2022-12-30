

//return todays date formated as yyyymmdd

 String todaysDateFormatted(){
   //today
   var dateTimeObject = DateTime.now();

   //year in a format yyyy

  String year = dateTimeObject.year.toString();

  //month in a format of mm

  String month = dateTimeObject.month.toString();
   if(month.length == 1){
     month = "0$month";
   }

  // day in a format of dd

   String day = dateTimeObject.day.toString();
   if(month.length == 1){
     day = "0$day";
   }

   //final format
   String yyyymmdd = year + month + day;

   return yyyymmdd;

}



//convert string yyyymmdd to dateTime object

  DateTime createDateTimeObject (String yyyymmdd){
   int yyyy = int.parse(yyyymmdd.substring(0,4));
   int mm = int.parse(yyyymmdd.substring(4,6));
   int dd = int.parse(yyyymmdd.substring(6,8));

   DateTime dateTimeObject = DateTime(yyyy,mm,dd);

   return dateTimeObject;

  }


//convert dateTime Object to string yyyymmdd

  String convertDateTimeToString (DateTime dateTime){
    //year in a format yyyy

    String year = dateTime.year.toString();

    //month in a format of mm

    String month = dateTime.month.toString();
    if(month.length ==1){
      month = "0$month";
    }

    // day in a format of dd

    String day = dateTime.day.toString();
    if(month.length ==1){
       day = "0$day";
    }

    //final format
    String yyyymmdd = year + month + day;

    return yyyymmdd;

  }


