import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:equatable/equatable.dart';

abstract class ChatBotState extends Equatable {
  const ChatBotState();
}

class ChatBotInitial extends ChatBotState {
  @override
  List<Object> get props => [];
}

class ChatBotLoading extends ChatBotState {
  @override
  List<Object> get props => [];
}

class ChatBotError extends ChatBotState {
  final String msg;

  ChatBotError(this.msg);
  @override
  List<Object> get props => [msg];
}


class PostQuestionLoaded extends ChatBotState {
  final CTResponse response;

  PostQuestionLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class GenImgLoaded extends ChatBotState {
  final GenImgResponse response;

  GenImgLoaded(this.response);
  @override
  List<Object> get props => [response];
}




