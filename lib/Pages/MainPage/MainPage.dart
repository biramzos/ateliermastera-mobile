import 'dart:io';

import 'package:ateliermastera/APIs/User.dart';
import 'package:ateliermastera/Pages/MainPage/MyOrderPage/MyOrdersPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'OrdersPage/OrdersPage.dart';
import 'ProfilePage/ProfilePage.dart';

class MainPage extends StatefulWidget{

  User user;
  MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage>{

  int _nav_index = 0;

  List<Widget>? fragments = null;

  void initBottomNav(){
    fragments = [
      OrdersPage(user: widget.user),
      MyOrdersPage(user: widget.user),
      ProfilePage(user: widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    initBottomNav();
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ателье Мастера'),
        ),
        body: fragments![_nav_index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _nav_index,
          onTap: (index){
            setState(() {
              _nav_index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox),
              label: "Все заказы"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: "Мои заказы"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined),
              label: "Профиль"
            ),
          ]
        ),
      ),
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Вы хотите выйти?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  },
                  child: const Text('Да'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Нет'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
    );
  }
}