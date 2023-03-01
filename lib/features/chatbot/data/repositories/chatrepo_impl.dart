import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/src/messages/image_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/network/network_info.dart';
import '../../domain/entities/chat_bot_request.dart';
import '../../domain/repositories/chat-repo.dart';
import '../data_sources/chat_datasource.dart';

class ChatRepoImpl extends ChatRepo {
  final NetworkInfo? networkInfo;
  final ChatDataSource? chatDataSource;

  ChatRepoImpl({
    this.networkInfo,
    this.chatDataSource,
  });

  @override
  Future<Either<Failure, CTResponse?>> postQuestion(ChatBotRequest request) {
    return _postQuestion(chatDataSource!.postQuestion(request));
  }

  @override
  Future<Either<Failure, GenImgResponse?>> genImg(String promt) {
    return _genImg(chatDataSource!.postImage(promt));
  }

  Future<Either<Failure, GenImgResponse?>> _genImg(
      Future<GenImgResponse?> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        print("1");
        if(data == null){
          print("2");
          return Left(ServerFailure("Server Error"));
        }
        print("3");
        return Right(data);
      } catch(e) {
        print("4");
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
    }
  }


  Future<Either<Failure, CTResponse?>> _postQuestion(
      Future<CTResponse?> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        print("1");
        if(data == null){
          print("2");
          return Left(ServerFailure("Server Error"));
        }
        print("3");
        return Right(data);
      } catch(e) {
        print("4");
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
    }
  }








}
