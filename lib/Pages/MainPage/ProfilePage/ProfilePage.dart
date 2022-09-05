import 'package:ateliermastera/APIs/User.dart';
import 'package:ateliermastera/APIs/UserService.dart';
import 'package:ateliermastera/Pages/LoginPage/LoginPage.dart';
import 'package:ateliermastera/SQL/SavedUser.dart';
import 'package:ateliermastera/SQL/SavedUserService.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{

  User user;
  ProfilePage({required this.user});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  var old_password_controller = TextEditingController();
  var new_password_controller = TextEditingController();
  var saved_user_service = SavedUserService();
  var user_service = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 20
            ),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(150),
                child: Image.network(
                    widget.user.img,
                    width: 150,
                    height: 150,
                  )
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.user.fullname.replaceAll(' ', '\n'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            )
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Логин: ${widget.user.username}\nНомер телефона: ${widget.user.phone}',
              style: TextStyle(
                fontSize: 20
              ),
            )
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Поменять пароль",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 20
            ),
            child: Column(
              children: [
                TextField(
                  controller: old_password_controller,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    hintText: "Старый пароль"
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: new_password_controller,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    hintText: "Новый пароль",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    String result = (await user_service.updatePost(widget.user.username, old_password_controller.text, new_password_controller.text));
                    if(result == "success"){
                      saved_user_service.delete();
                      saved_user_service.insertUser(SavedUser(username: widget.user.username, password: widget.user.password));
                    }
                  }, 
                  child: Text(
                    "Поменять",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: (){
                    saved_user_service.delete();
                    Navigator.pop(
                      context,
                      true
                    );
                    Navigator.pop(
                      context,
                      true
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage()
                      )
                    );
                  }, 
                  child: Text(
                    "Выйти",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }

}