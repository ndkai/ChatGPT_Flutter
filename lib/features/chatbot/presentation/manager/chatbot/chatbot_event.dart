import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/chat_bot_request.dart';

abstract class ChatBotEvent extends Equatable {
  const ChatBotEvent();
}

class PostQuestionE extends ChatBotEvent{
  final ChatBotRequest request;

  PostQuestionE(this.request);

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class GenImgE extends ChatBotEvent{
  final String request;

  GenImgE(this.request);

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class ChatBotLoadingE extends ChatBotEvent{

  ChatBotLoadingE();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

