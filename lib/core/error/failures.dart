import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;
  Failure({required this.msg});
  @override
  List<Object> get props => [msg];
}

// General failures
class ServerFailure extends Failure {
  final String error;
  ServerFailure(this.error) : super(msg: error);
}

class CacheFailure extends Failure {
  CacheFailure() : super(msg:'');
}

class NetWorkFailure extends Failure {
  NetWorkFailure() : super(msg: "");
}
