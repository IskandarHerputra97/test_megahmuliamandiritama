import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_megahmuliamandiritama/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<List> _login() async {
    final response = await http.post('${myUrl}login.php', body: {
      'nama': name.text,
      'email': email.text,
      'password': password.text,
      'alamat': address.text,
    });
    print(response.body);

    var dataUser = json.decode(response.body);

    if(dataUser.length==0) {
      print('Login gagal');
    } else {
      Navigator.pushReplacementNamed(context, '/homePage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Nama',
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Tolong input nama' : null,
                  controller: name,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Email',
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Tolong input email' : null,
                  controller: email,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Password',
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) => val.isEmpty ? 'Tolong input password' : null,
                  controller: password,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Alamat',
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Tolong input alamat' : null,
                  controller: address,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _login();
                    }
                  },
                  child: Text(
                    'Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
