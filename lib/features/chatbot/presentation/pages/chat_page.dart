import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:uuid/uuid.dart';

import '../../../../injection_container.dart';
import '../../data/models/ChatBotResponse.dart';
import '../../domain/entities/chat_bot_request.dart';
import '../manager/chatbot/chatbot_bloc.dart';
import '../manager/chatbot/chatbot_event.dart';
import '../manager/chatbot/chatbot_state.dart';
import '../widgets/chat_ui/src/models/send_button_visibility_mode.dart';
import '../widgets/chat_ui/src/widgets/chat.dart';
import '../widgets/chat_ui/src/widgets/image_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  BuildContext? currentContext;
  List<types.Message> _messages = [];
  List<Widget> optionBnts = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c', imageUrl: "https://1000logos.net/wp-content/uploads/2023/02/ChatGPT-Emblem.png");
  final _user2 = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666d', imageUrl: "https://1000logos.net/wp-content/uploads/2023/02/ChatGPT-Emblem.png");
  String loadingMessageID = "";
  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['data'] = _messages.map((v) => v.toJson()).toList();
      prefs!.setString(CHAT_DATA, jsonEncode(data));
    });

  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      _addMessage(message);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    // final updatedMessage = _messages[index].copyWith(previewData: previewData);
    final updatedMessage = _messages[index];

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    postQuestion(ChatBotRequest(sender: "${_user.id}", message: "${message.text}"));
    _addMessage(textMessage);
  }

  void _handleSendImgPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    genImage(message.text);
    _addMessage(textMessage);
  }

  void _receive(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
  }

  void _receiveImage(types.PartialText message) {
    final textMessage = types.ImageMessage(
      author: _user2,
      name: "",
      size: 1024,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      uri: message.text,
    );
    _addMessage(textMessage);
  }

  void _loadingMessage() async {
    try{
      // ByteData? byteData = await getImageFileFromAssets('assets/images/enmergency.png');
      // File file = await writeToFile(byteData!);
      // Image image = Image.file(file);
      // print('aaaaaaaaaaaaaaa ${image.height }');
      final message = types.CustomMessage(
        author: _user2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: loadingMessageID,
      );

      _addMessage(message);
    } catch(e){
    }
  }

  void _loadMessages() async {
    String? cacheMessages = prefs!.getString(CHAT_DATA);
    log("_loadMessages ${cacheMessages}");
    CacheChat cacheChat = CacheChat.fromJson(jsonDecode(cacheMessages!));

    setState(() {
      _messages = cacheChat.data!;
    });
  }

  void _deleteMessage(String uuid){
    setState(() {
      _messages.removeWhere((element) => element.id == loadingMessageID);
    });
  }

  Widget optionButton(Buttons button){
    return Container(
      child: ChoiceChip(
        backgroundColor: Colors.blue.shade500,
        selectedColor: Colors.blue.shade500,
        label: Text(
            '${button.title}', style: TextStyle(
          color: Colors.white
        ),),
        selected: true,
        onSelected: (bool selected) {
          setState(() {
            optionBnts = [];
            postQuestion(ChatBotRequest(sender: "${_user.id}", message: "${button.payload}"));
          });
        },
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider<ChatBotBloc>(
        create: (_) => sl<ChatBotBloc>(),
        child: BlocConsumer<ChatBotBloc, ChatBotState>(
          listener: (context, state){
            print("chatbot bloc: ${state}");
            if(state is ChatBotLoading){
              // showLoadingDialog(context);
              loadingMessageID = Uuid().v4();
              _loadingMessage();
            } else
            if(state is ChatBotError){
              _deleteMessage(loadingMessageID);
              types.PartialText message = const types.PartialText(text: "Xin lỗi, hiện tại tôi không trả lời được!");
              _receive(message);
            } else
            if(state is PostQuestionLoaded){
              _deleteMessage(loadingMessageID);
              types.PartialText message = types.PartialText(text: state.response.choices[0].text.trim());
            _receive(message);
              // if(i.image != null){
              //   types.PartialText message = types.PartialText(text: i.image!);
              //   _receiveImage(message);
              // }
              // if(i.text != null){
              //   types.PartialText message = types.PartialText(text: i.text!);
              //   _receive(message);
              // }

            } else
              if(state is GenImgLoaded){
                _deleteMessage(loadingMessageID);
                types.PartialText message = types.PartialText(text: state.response!.data!.last!.url!);
                _receiveImage(message);
              }
          },
          builder: (context, state){
            currentContext = context;
            return Container(
              height: SizeConfig.screenHeight,
              child: Chat(
                sendButtonVisibilityMode: SendButtonVisibilityMode.always,
                messages: _messages,
                onAttachmentPressed: _handleAtachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                onSendImgPressed: _handleSendImgPressed,
                user: _user,
                optionButtons: optionBnts,
                showUserAvatars: true,
                usePreviewData: true,
                showUserNames: true,
              ),
            );
          },
        ),
      ),
    );
  }

  void showLoading(){
    BlocProvider.of<ChatBotBloc>(currentContext!).add(ChatBotLoadingE());
  }

  void postQuestion(ChatBotRequest request){
    showLoading();
    setState(() {
      optionBnts = [];
    });
    BlocProvider.of<ChatBotBloc>(currentContext!).add(PostQuestionE(request));
  }

  void genImage(String promt){
    showLoading();
    setState(() {
      optionBnts = [];
    });
    BlocProvider.of<ChatBotBloc>(currentContext!).add(GenImgE(promt));
  }

  Future<ByteData?> getImageFileFromAssets(String path) async {
   try{
     final byteData = await rootBundle.load('$path');
     return byteData;
   }catch(e){
     return null;
   }
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/loading.gif'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Widget optionItem(Buttons buttons){
    return Container(
      color: Colors.transparent,
      child: ChoiceChip(
        backgroundColor: Colors.blue,
        label: Text('${buttons.title}'),
        selected: false,
        onSelected: (bool selected) {},
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }

}

class CacheChat {
  List<types.Message>? data;

  CacheChat({this.data});

  CacheChat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <types.Message>[];
      json['data'].forEach((v) {
        data!.add(new types.Message.fromJson(v));
      });
    }
  }

}
