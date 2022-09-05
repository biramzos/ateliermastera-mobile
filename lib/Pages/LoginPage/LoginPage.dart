import 'dart:ffi';
import 'dart:io';

import 'package:ateliermastera/APIs/UserService.dart';
import 'package:ateliermastera/Pages/MainPage/MainPage.dart';
import 'package:ateliermastera/SQL/SavedUser.dart';
import 'package:ateliermastera/SQL/SavedUserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../APIs/User.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final _username_controller = TextEditingController();
  final _password_controller = TextEditingController();
  var user_service = UserService();
  var saved_user_service = SavedUserService();
  String message = "";
  
  @override
  void initState(){
    saved_user_service.retrieveUsers().then((user) => {
      user_service.loginPost(user.username, user.password).then((value) => {
        if(value['message'] == 'success'){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => MainPage(user: User(fullname: value['fullname'], username: value['username'], password: value['password'], phone: value['phone'], img: value['image'], token: value['token']))
            )
          )
        }
      })
    });
    initControllers();
  }

  void initControllers(){
    _username_controller.text = '';
    _password_controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { 
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                "Ателье МастерА",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 50,
                ),
                child: TextFormField(
                  controller: _username_controller,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    hintText: "Логин"
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  controller: _password_controller,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    hintText: "Пароль"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left:50,
                  right: 50,
                  top: 40
                ),
                child: TextButton(
                  child: Text(
                    "Войти",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  onPressed: () {
                      user_service.loginPost(_username_controller.text, _password_controller.text).then((value) => {
                        if(value['message'] == 'success'){
                          setState(() {
                            saved_user_service.insertUser(
                              SavedUser(
                                username: _username_controller.text, 
                                password: _password_controller.text
                              )
                            );
                            var user = User(fullname: value['fullname'], username: value['username'], password: value['password'], phone: value['phone'], img: value['image'], token: value['token']); 
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => MainPage(user: user)
                              )
                            );
                          })
                        } else {
                          setState((){
                            message = value['message'];
                          })
                        }
                      }
                    );
                  },
                )
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  message
                )
              )
            ],
          ),
        )
      )
    );
  }

}