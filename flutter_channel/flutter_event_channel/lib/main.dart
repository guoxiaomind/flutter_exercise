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


  // 注册一个通知
  static const EventChannel eventChannel = EventChannel('com.pages.your/native_get');
  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  //接收Native消息。
  void _onEvent(Object event) {
    setState(() {
      title = event;
      backGroundColor = randomColor();
      //取消监听
//      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError).cancel();
    });
  }

  void _onError(Object error) {
    setState(() {
      PlatformException exception = error;
      title = exception?.message ?? 'error';
    });
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
          },
        ),
      ),
    );
  }
}




