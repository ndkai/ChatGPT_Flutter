class ServerException implements Exception {
  final String msg;

  ServerException({required this.msg});
}

class CacheException implements Exception {}

class LoginException implements Exception {}

class ServerError  implements Exception{
  String? type;
  String? title;
  int? status;
  String? traceId;

  ServerError({this.type, this.title, this.status, this.traceId});

  ServerError.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    traceId = json['traceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['status'] = this.status;
    data['traceId'] = this.traceId;
    return data;
  }
}
