import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String title = 'Flutter to Native';
  Color backGroundColor = Colors.red;

  //注册
  static const messageChannel = const BasicMessageChannel('com.pages.your/messageChannel', StandardMessageCodec());

  //发送消息
  void _sendMessage() async {
    String title = await messageChannel.send('Fluttter To Native');
    setState(() {
      backGroundColor = randomColor();
    });
  }

  //接收消息
  void _receiveMessage() {
    messageChannel.setMessageHandler((message) async {
      title = message;
      setState(() {
        backGroundColor = randomColor();
      });
      return 'Flutter Back';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _receiveMessage();
  }


  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(256)+0, Random().nextInt(256)+0, Random().nextInt(256)+0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: new Text(title),
          onTap: (){
            _sendMessage();
          },
        ),
      ),
    );
  }
}
