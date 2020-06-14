import 'package:flutter/material.dart';
import 'package:qr_reader/src/pages/login/login.dart';
import 'package:qr_reader/src/provider/general.dart';

class MissPage extends StatefulWidget {
  MissPage({Key key}) : super(key: key);

  @override
  _MissPageState createState() => _MissPageState();
}

class _MissPageState extends State<MissPage> {
  String email;
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
                    Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              auth.ForgotPassword(email).then((value) {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                              }).catchError((error) => print(error));
                            },
                            child: Text('Enviar'),
                          ),
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