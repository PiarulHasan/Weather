import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:weather/languagepage.dart';
import 'package:weather/weather.dart';
import 'package:weather/weatherfontpage.dart';
import 'package:weather/weatherpage.dart';


void main() {
  runApp(
      EasyLocalization(
        child: MyApp(),
        saveLocale: true,
        path: "resources/lang",
        supportedLocales: [
          Locale("bn", "BN"),
          Locale("en", "EN"),

        ],
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Weather(),
    );
  }
}


