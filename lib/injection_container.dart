import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:phuquoc/features/chatbot/domain/use_cases/gen_img_uc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'core/utils/input_converter.dart';

import 'features/chatbot/data/data_sources/chat_datasource.dart';
import 'features/chatbot/data/repositories/chatrepo_impl.dart';
import 'features/chatbot/domain/repositories/chat-repo.dart';
import 'features/chatbot/domain/use_cases/post_question.dart';
import 'features/chatbot/presentation/manager/chatbot/chatbot_bloc.dart';
final sl = GetIt.instance;

Future<void> init() async {
   //bloc
  sl.registerFactory(
        () => ChatBotBloc(sl(), sl()),
  );

  //usecase
  sl.registerLazySingleton(() => PostQuestionUc(sl()));
  sl.registerLazySingleton(() => GenImgUc(sl()));

  // repo
  sl.registerLazySingleton<ChatRepo>(
          () => ChatRepoImpl(networkInfo: sl(), chatDataSource: sl()));
  //datasourse
  sl.registerLazySingleton<ChatDataSource>(
        () => ChatDataSourceImpl(chatGPT: sl()),
  );
  // core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: 60000), isLogger: true));
}
