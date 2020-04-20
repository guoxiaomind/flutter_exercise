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
  static const MethodChannel methodChannel = const MethodChannel('com.pages.your/native_get');

  //Dart调用Native方法，并接收返回值。
  _iOSPushToVC() async {
    title = await methodChannel.invokeMethod('FlutterToNative');
    setState(() {
      backGroundColor = Colors.green;
    });
  }


  _HomePageState(){
    //Native调用Dart方法
    methodChannel.setMethodCallHandler((MethodCall call){
      if(call.method  == "NativeToFlutter"){
        setState(() {
          title = call.arguments;
          backGroundColor = Colors.yellow;
        });
      }
      return Future<dynamic>.value();
    });
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
            _iOSPushToVC();
          },
        ),
      ),
    );
  }
}

