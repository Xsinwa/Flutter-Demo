class DateFormatUtil{
  factory DateFormatUtil() => getInstance();
  static DateFormatUtil _instance;
  DateFormatUtil._(){

  }

  static DateFormatUtil getInstance(){
    if(null == _instance){
      _instance = DateFormatUtil._();
    }
    return _instance;
  }

  String format(DateTime dateTime, String format){
    String date;
    String tempDate = dateTime.toString();
    switch(format){
      case "yyyy-MM-dd":
        date = tempDate.split(" ")[0];
        break;
      case "yyyy-MM-dd hh:mm:ss":
        date = tempDate.split(".")[0];
        break;
      case "yyyy-MM-dd hh:mm:ss:SSS":
        date = tempDate;
        break;
    }
    return date;
  }
}