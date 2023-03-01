import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/chat_bot_request.dart';

abstract class ChatDataSource {
  Future<CTResponse?> postQuestion(ChatBotRequest request);

  Future<GenImgResponse?> postImage(String promt);
}

class ChatDataSourceImpl implements ChatDataSource {
  late OpenAI? chatGPT;

  ChatDataSourceImpl({@required this.chatGPT});


  @override
  Future<CTResponse?> postQuestion(ChatBotRequest request) {
    return _postQuestion(request);
  }

  Future<CTResponse?> _postQuestion(ChatBotRequest request) async{
    try{
      final call =
      CompleteText(prompt: request.message!, model: kTranslateModelV3);
      final response = await chatGPT!.onCompleteText(request: call);
      print("lolol ${response!.choices[0].text} 222");
      return response;
    }  catch(e){
      print("lololol1 ${e.toString()}");
      return null;
    }
  }

  @override
  Future<GenImgResponse?> postImage(String promt) async{
    try{
      final request = GenerateImage(promt, 1, size: "256x256");
      final response = await chatGPT!.generateImage(request);
      print("lolol ${response!.data!.last!.url!} 222");
      return response;
    }  catch(e){
      print("lololol1 ${e.toString()}");
      return null;
    }
  }










}
