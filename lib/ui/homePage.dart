import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_megahmuliamandiritama/main.dart';
import 'package:test_megahmuliamandiritama/model/people.dart';
import 'package:http/http.dart' as http;
import 'package:test_megahmuliamandiritama/ui/homePageDetail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<People> _people = List<People>();

  Future<List<People>> fetchPeople() async {
    var url = 'http://$myIP/MegahMuliaMandiriTama/getPeople.php';

    var response = await http.get(url);

    var peoples = List<People>();

    if (response.statusCode == 200) {
      var peoplesJson = json.decode(response.body);
      for (var peopleJson in peoplesJson) {
        peoples.add(People.fromJson(peopleJson));
      }
    }
    return peoples;
  }

  @override
  void initState() {
    fetchPeople().then((value) {
      setState(() {
        _people.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman home'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Container(
                color: Colors.blue,
                width: 300,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<List>(
                      future: fetchPeople(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: _people == null ? 0 : _people.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageDetail(people: _people[index])));
                                  },
                                  title: Text(_people[index].nama),
                                ),
                              );
                            },
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addDataPage');
                    },
                    child: Text(
                      'Add data',
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/loginPage', (Route<dynamic> route) => false);
                    },
                    color: Colors.red,
                    child: Text(
                      'Sign out',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
