import 'package:ateliermastera/SQL/SavedUserService.dart';
import 'package:dio/dio.dart';

class UserService{
  String url = "https://ateliermastera.herokuapp.com/api/v1";
  
  var saved_user_service = SavedUserService();

  Future<dynamic> loginPost(String username, String password) async {
    var response = await Dio().post(
      '$url/login',
      data: {
        'username':username,
        'password':password
      }
    );
    return response.data;
  }

  Future<String> updatePost(String username, String old_password, String new_password) async {
    var response = await Dio().post(
      '$url/update',
      data: {
        'username':username,
        'oldPassword':old_password,
        'newPassword':new_password
      }
    );
    return response.data;
  }
}