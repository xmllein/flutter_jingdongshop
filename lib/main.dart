import 'package:flutter/material.dart';
import 'package:flutter_jdshop/provider/Cart.dart';
import 'package:flutter_jdshop/provider/Counter.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'pages/tabs/Tabs.dart';
//引入路由配置文件
import 'routers/router.dart';

import "package:provider/provider.dart";

void main() {
  // Add this line
  // await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/', //初始化的时候加载的路由
        onGenerateRoute: onGenerateRoute,
        // 设置主题颜色
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],

          // Define the default font family.
          // fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            // titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
            bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
          ),
        ),
      ),
    );
  }
}
