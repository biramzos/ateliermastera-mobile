import 'package:ateliermastera/APIs/Order.dart';
import 'package:ateliermastera/APIs/OrderService.dart';
import 'package:ateliermastera/APIs/User.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget{
  User user;
  OrdersPage({Key? key, required this.user}) : super(key: key);


  @override
  State<StatefulWidget> createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage>{
  var order_service = OrderService();
  List<Order> orders = [];
  String? text;

  void initList() async {
    orders = (await order_service.getAllOrders());
  }

  @override
  Widget build(BuildContext context) {
    initList();
    return Scaffold(
      body: FutureBuilder(
        future: order_service.getAllOrders(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => showDialog(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        orders.elementAt(index).name,
                      ),
                      content: Text(
                        'Имя: ${orders.elementAt(index).name}\nТелефон: ' + orders.elementAt(index).phone + '\nДата и время: ' + orders.elementAt(index).date + '\nЗаказ для: ' + orders.elementAt(index).fullname,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if(orders.elementAt(index).username == widget.user.username){
                              order_service.deletePost(orders.elementAt(index).id);
                              Navigator.pop(context, 'OK');
                            } else {
                              order_service.addPost(orders.elementAt(index).id, widget.user.username);
                              Navigator.pop(context, 'OK');
                            }
                          },
                          child: const Text('Добавить/удалить с моих заказов'),
                        ),
                        TextButton(
                          onPressed: () {
                            order_service.finishPost(orders.elementAt(index).id);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('Закончить'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    )
                  ),
                  child:Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: 20
                      ),
                      child:Text(
                        orders.elementAt(index).name,
                        style: TextStyle(
                          fontSize: 17
                        ),
                      ),
                    ),
                  )
                );
              }
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              )
            );
          }
        }
      )
    );
  }
}