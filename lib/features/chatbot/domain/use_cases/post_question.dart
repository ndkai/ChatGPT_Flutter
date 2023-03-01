import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';

import '../entities/chat_bot_request.dart';
import '../repositories/chat-repo.dart';
class PostQuestionUc implements UseCase<CTResponse?, ChatBotRequest> {
  final ChatRepo chatRepo;

  PostQuestionUc(this.chatRepo);

  @override
  Future<Either<Failure, CTResponse?>> call(ChatBotRequest params) async {
    return chatRepo.postQuestion(params);
  }
}
