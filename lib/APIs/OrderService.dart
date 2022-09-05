import 'package:ateliermastera/APIs/Order.dart';
import 'package:dio/dio.dart';

class OrderService{
  String url = "https://ateliermastera.herokuapp.com/api/v1";

  Future<List<Order>> getAllOrders() async {
    List<Order> orders = [];
    var response = await Dio().get('$url/orders');
    for(var e in response.data){
      orders.add(Order(id: e['id'], name: e['name'], phone: e['phone'], username: e['user']['username'],date: e['date'], fullname: e['user']['fullname']));
    }
    return orders;
  }

  Future<List<Order>> getOrdersByUsername(String username) async {
    List<Order> orders = [];
    var response = await Dio().get('$url/orders/$username');
    for(var e in response.data){
      orders.add(Order(id: e['id'], name: e['name'], phone: e['phone'], username: username, date: e['date'], fullname: e['fullname']));
    }
    return orders;
  }

  Future<String> addPost(int id, String username) async {
    var response = await Dio().post('$url/add/$id?username=$username');
    return response.data.toString();
  }

  Future<String> deletePost(int id) async {
    var response = await Dio().post('$url/delete/$id');
    return response.data.toString();
  }

  Future<String> finishPost(int id) async {
    var response = await Dio().post('$url/finish/$id');
    return response.data.toString();
  }
}