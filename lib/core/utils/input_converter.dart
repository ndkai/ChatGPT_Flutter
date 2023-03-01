import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure(""));
    }
  }
}

class InvalidInputFailure extends Failure {
  final String msg;
  InvalidInputFailure(this.msg) : super(msg: msg);
}

String getTimeByString(String? s) {
try{
  DateTime datetime = DateTime.parse(s!);
  return "${datetime.day}/${datetime.month}/${datetime.year}";
}
catch(e){
  return "";
}
}

String getTimeByDateTime(DateTime datetime) {
  try{
    return "${datetime.day}/${datetime.month}/${datetime.year}";
  }
  catch(e){
    return "";
  }
}

String getDetailTimeByString(String s) {
  try{
    DateTime datetime = DateTime.parse(s);
    return "Vào lúc ${datetime.hour}:${datetime.minute}  ${datetime.day}/${datetime.month}/${datetime.year}";
  }
  catch(e){
    return "";
  }

}
