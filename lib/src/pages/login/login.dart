import 'dart:math';

import 'package:qr_reader/src/pages/login/miss.dart';
import 'package:qr_reader/src/provider/general.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                'assets/logo.JPG',
                height: 80,
              ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.person), hintText: 'Email'),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock), hintText: 'Password'),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              auth.loginEmail(email, password).then((value) {
                                print('succes');
                                Navigator.pushNamed(context, 'qr');
                              }).catchError((error) => print(error));
                            },
                            child: Text('Login'),
                          ),
                          Row(
                            children: <Widget>[
                              Text("               "),
                              Center(
                                child:
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MissPage()),
                                      );
                                },
                                child: Text('Olvide contraseña'),
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
