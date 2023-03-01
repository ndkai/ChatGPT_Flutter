class ChatBotRequest {
  String? sender;
  String? message;

  ChatBotRequest({this.sender, this.message});

  ChatBotRequest.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['message'] = this.message;
    return data;
  }
}