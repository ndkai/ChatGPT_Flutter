
String changeStringToTime(String datetime){
   try{
     DateTime time = DateTime.parse(datetime);
     return "${time.day}/${time.month}/${time.year}";
   }catch(e){
     return "";
   }
}

double? parseStringToDouble(String data){
  try{
    if(data.contains(",")){
      data = data.replaceAll(",", ".");
    }
    print("parseStringToDouble ${data}");
    return double.parse(data);
  } catch(e){
    return null;
  }
}

int? parseTextPointToInt(String data){
  try{
    if(data == "Đ"){
      return 1;
    }
    return 0;
  } catch(e){
    return null;
  }
}

DateTime? readTimestamp(int timestamp) {
 try{
   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
   print("readTimestamp ${date.toString()}");
   return date;
 } catch(e){
   return null;
 }

}



String changeStringToTime1(String hour){
  try{
    List<String> list = hour.split(":");
    return "${list[0]}:${list[1]}:${list[2]}";
  }catch(e){
    return "";
  }
}


bool isEmail(String em) {
  try{
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  } catch(e){
    return false;
  }
}

int getPeriodByTime(){
  DateTime time = DateTime.now();
  if(time.hour == 7  && time.minute <= 40){
    return 1;
  }
  if(time.hour == 7  && time.minute > 40) {
    return 2;
  }
  if(time.hour == 8  && time.minute <= 25){
    return 2;
  }
  if(time.hour == 8  && time.minute > 25) {
    return 3;
  }

  if(time.hour == 9  && time.minute < 40) {
    return 3;
  }

  if(time.hour == 9  && time.minute > 40) {
    return 4;
  }
  if(time.hour == 10  && time.minute <= 30) {
    return 4;
  }
  if(time.hour == 10  && time.minute > 30) {
    return 5;
  }
  if(time.hour == 11 || time.hour == 12) {
    return 5;
  }

  if(time.hour == 13 && time.minute < 40) {
    return 6;
  }

  if(time.hour == 13 && time.minute > 40) {
    return 7;
  }

  if(time.hour == 14 && time.minute < 15 ){
    return 7;
  }

  if(time.hour == 14 && time.minute > 15) {
    return 8;
  }

  if(time.hour == 15 && time.minute <= 25 ){
    return 8;
  }

  if(time.hour == 15 && time.minute > 25) {
    return 9;
  }

  if(time.hour == 16 && time.minute <= 25 ){
    return 10;
  }

   return 10;
}