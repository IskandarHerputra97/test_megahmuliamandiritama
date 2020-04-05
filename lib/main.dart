import 'package:flutter/material.dart';
import 'package:test_megahmuliamandiritama/ui/addDataPage.dart';
import 'package:test_megahmuliamandiritama/ui/loginPage.dart';
import 'package:test_megahmuliamandiritama/ui/homePage.dart';

void main() => runApp(MyApp());

String myIP = 'iskandarherputra.000webhostapp.com';
String myUrl = 'http://$myIP/';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User list application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
        '/loginPage': (BuildContext context) => LoginPage(),
        '/homePage': (BuildContext context) => HomePage(),
        '/addDataPage': (BuildContext context) => AddDataPage(),
      },
    );
  }
}