import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../api_key.dart';

enum ChatMessageType {user , bot}

class ChatMessage{
  final String text;
  final ChatMessageType chatMessageType;

  ChatMessage({
    required this.text,
    required this.chatMessageType,
  });


}

const backgroundColor = Colors.black87;
const botBackgroundColor = Color(0xffB80454);

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late bool isLoading;
  TextEditingController _textController = TextEditingController();
  final scrollController = ScrollController();
  final List<ChatMessage> messages = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      // messages.add(ChatMessage(
      //     text: "List of top trending songs", chatMessageType: ChatMessageType.user));
      isLoading = true;
    });
    var input = "Repeat this sentence 'Hello , How can I assist you today ?'";

    Future.delayed(const Duration(milliseconds: 50))
        .then((value) => _scrollDown());

    generateResponse(input).then((value) {
      setState(() {
        isLoading = false;
        messages.add(
            ChatMessage(text: value, chatMessageType: ChatMessageType.bot));
      });
    });
    Future.delayed(const Duration(milliseconds: 50))
        .then((value) => _scrollDown());
  }

  Future<String> generateResponse(String prompt) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0
      }),
    );

    Map<String, dynamic> newresponse = jsonDecode(response.body);
    return newresponse['choices'][0]['text'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Assistant",
              style: GoogleFonts.outfit(
                fontSize: 35,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        // backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              // const SizedBox(height: 40,),
              // chat body
              Expanded(
                child: buildList(),
              ),
              Visibility(
                visible: isLoading,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              buildInput()
            ],
          ),
        ),
      ),
    );
  }

  Row buildInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                color: Colors.black87,
              ),
              controller: _textController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Ask me anything...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                // contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
              ),
            ),
          ),
        ),
        buildSubmit()
      ],
    );
  }

  Widget buildSubmit() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Visibility(
          visible: !isLoading,
          child: Container(
            color: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black,),
              onPressed: () {
                setState(() {
                  messages.add(ChatMessage(
                      text: _textController.text,
                      chatMessageType: ChatMessageType.user));
                  isLoading = true;
                });
                var input = _textController.text;
                _textController.clear();
                Future.delayed(const Duration(milliseconds: 50))
                    .then((value) => _scrollDown());

                generateResponse(input).then((value) {
                  setState(() {
                    isLoading = false;
                    messages.add(ChatMessage(
                        text: value, chatMessageType: ChatMessageType.bot));
                  });
                });
                _textController.clear();
                Future.delayed(const Duration(milliseconds: 50))
                    .then((value) => _scrollDown());
              },
            ),
          )),
    );
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  ListView buildList() {
    return ListView.builder(
        reverse: true,
        itemCount: messages.length,
        controller: scrollController,
        itemBuilder: ((context, index) {
          var message = messages[messages.length - index - 1];
          return ChatMessageWidget(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        }));
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget({required this.text, required this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        color: chatMessageType == ChatMessageType.bot
            ? botBackgroundColor
            : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chatMessageType == ChatMessageType.bot
                ? Container(
              margin: const EdgeInsets.only(right: 8, left: 8),
              child: Image.asset(
                'assets/images/chatgpt-icon.png',
                height: 40,
              ),
            )
                : Container(
              margin: const EdgeInsets.only(right: 8, left: 8),
              child: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      // color: chatMessageType == ChatMessageType.bot? botBackgroundColor : Colors.white,
                    ),
                    child: Text(
                      text.trimLeft(),
                      style: GoogleFonts.outfit(
                        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: chatMessageType == ChatMessageType.bot
                              ? Colors.white
                              : Colors.black,
                          fontSize: 15
                        // fontWeight: FontWeight.bold,
                      ),
                          ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
