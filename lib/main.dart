import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_megahmuliamandiritama/bloc/people_bloc2.dart';
import 'package:test_megahmuliamandiritama/ui/addDataPage.dart';
import 'package:test_megahmuliamandiritama/ui/loginPage.dart';
import 'package:test_megahmuliamandiritama/ui/homePage.dart';
import 'package:test_megahmuliamandiritama/ui/testBloc.dart';

void main() => runApp(MyApp());

String myIP = 'iskandarherputra.000webhostapp.com';
String myUrl = 'http://$myIP/';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeopleBloc2>(
          create: (BuildContext context) => PeopleBloc2(),
        ),
      ],
      child: MaterialApp(
        title: 'User list application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: <String, WidgetBuilder> {
          '/loginPage': (BuildContext context) => LoginPage(),
          '/homePage': (BuildContext context) => HomePage(),
          '/addDataPage': (BuildContext context) => AddDataPage(),
          '/testBloc': (BuildContext context) => TestBloc(),
        },
      ),
    );
  }
}