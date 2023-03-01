import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phuquoc/core/error/failures.dart';

import '../entities/chat_bot_request.dart';

abstract class ChatRepo {
  Future<Either<Failure, CTResponse?>> postQuestion(ChatBotRequest request);
  Future<Either<Failure, GenImgResponse?>> genImg(String promt);
}
