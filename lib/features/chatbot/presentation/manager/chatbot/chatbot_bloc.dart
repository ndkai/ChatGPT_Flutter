import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/gen_img_uc.dart';
import '../../../domain/use_cases/post_question.dart';
import 'bloc.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final PostQuestionUc postQuestionUc;
  final GenImgUc genImgUc;

  ChatBotBloc(this.postQuestionUc, this.genImgUc) : super(ChatBotInitial()){
    on<PostQuestionE>(_postQuestion);
    on<GenImgE>(_genImgUc);
    on<ChatBotLoadingE>(_loading);
  }

  Future<void> _genImgUc(GenImgE event, Emitter<ChatBotState> emit) async {
    var result = await genImgUc(event.request);
    return emit(
        result.fold(
                (l) => ChatBotError(l.msg),
                (r) => r != null? GenImgLoaded(r!) : ChatBotError(r.toString())));
  }


  Future<void> _postQuestion(PostQuestionE event, Emitter<ChatBotState> emit) async {
    var result = await postQuestionUc(event.request);
    return emit(
        result.fold(
                (l) => ChatBotError(l.msg),
                (r) => r != null? PostQuestionLoaded(r!) : ChatBotError(r.toString())));
  }

  Future<void> _loading(ChatBotLoadingE event, Emitter<ChatBotState> emit) async {
    return emit(
        ChatBotLoading()
    );
  }

}
