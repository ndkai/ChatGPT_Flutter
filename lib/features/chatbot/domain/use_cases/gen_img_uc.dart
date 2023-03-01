import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import '../repositories/chat-repo.dart';
class GenImgUc implements UseCase<GenImgResponse?, String> {
  final ChatRepo chatRepo;

  GenImgUc(this.chatRepo);

  @override
  Future<Either<Failure, GenImgResponse?>> call(String promt) async {
    return chatRepo.genImg(promt);
  }
}
